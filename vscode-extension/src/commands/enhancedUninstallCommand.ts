/**
 * Enhanced Uninstall Command - Phase 3: Smart Uninstallation
 * Provides intelligent uninstallation with user choice, preservation of modifications,
 * backup functionality, and comprehensive reporting.
 */

import * as vscode from 'vscode';
import * as path from 'path';
import * as fs from 'fs-extra';
import { 
    IntegrityReport, 
    ScopeInfo, 
    InstallationAnalysis,
    UninstallChoice,
    UninstallPreview
} from '../types/integrityTypes';
import { InstallationScope } from '../types/platform';
import { EnhancedInstallationManager } from '../services/enhancedInstallationManager';
import { Logger } from '../utils/logger';

export class EnhancedUninstallCommand {
    private readonly installationManager: EnhancedInstallationManager;
    private readonly outputChannel: vscode.OutputChannel;
    private readonly logger: Logger;

    constructor() {
        this.installationManager = EnhancedInstallationManager.getInstance();
        this.outputChannel = vscode.window.createOutputChannel('OLAF Uninstallation');
        this.logger = Logger.getInstance();
    }

    /**
     * Main execute method for the enhanced uninstall command
     */
    async execute(): Promise<void> {
        try {
            this.outputChannel.show();
            this.outputChannel.appendLine('Starting OLAF Smart Uninstallation...');
            
            // Phase 1: Discovery
            const scopes = await this.discoverInstalledScopes();
            if (scopes.length === 0) {
                vscode.window.showInformationMessage('No OLAF installations found in the current workspace.');
                return;
            }

            // Phase 2: Analysis
            const analysis = await this.analyzeInstallation(scopes);
            
            // Phase 3: User Choice
            const choice = await this.showUninstallPreview(analysis);
            if (!choice || choice === 'cancel') {
                vscode.window.showInformationMessage('Uninstallation cancelled.');
                return;
            }

            // Phase 4: Execute Smart Uninstallation
            await this.performSmartUninstallation(scopes, choice, analysis);

        } catch (error) {
            const errorMessage = `Uninstallation failed: ${error instanceof Error ? error.message : 'Unknown error'}`;
            this.logger.error(errorMessage, error as Error);
            vscode.window.showErrorMessage(errorMessage);
        }
    }

    /**
     * Discover all OLAF installation scopes in the workspace
     */
    private async discoverInstalledScopes(): Promise<ScopeInfo[]> {
        const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
        if (!workspaceFolder) {
            throw new Error('No workspace folder found');
        }

        const scopes: ScopeInfo[] = [];
        const rootPath = workspaceFolder.uri.fsPath;

        // Look for OLAF installation markers
        const potentialScopes = [
            { name: 'global', path: rootPath, type: 'global' as const },
            { name: 'workspace', path: path.join(rootPath, '.vscode'), type: 'workspace' as const },
            { name: 'project', path: path.join(rootPath, '.olaf'), type: 'project' as const }
        ];

        for (const scope of potentialScopes) {
            if (await this.isValidScope(scope.path)) {
                scopes.push(scope);
            }
        }

        this.outputChannel.appendLine(`Found ${scopes.length} OLAF installation scope(s): ${scopes.map(s => s.name).join(', ')}`);
        return scopes;
    }

    /**
     * Check if a path represents a valid OLAF installation scope
     */
    private async isValidScope(scopePath: string): Promise<boolean> {
        try {
            const stat = await vscode.workspace.fs.stat(vscode.Uri.file(scopePath));
            return stat.type === vscode.FileType.Directory;
        } catch {
            return false;
        }
    }

    /**
     * Analyze the installation to understand what files exist and their status
     */
    private async analyzeInstallation(scopes: ScopeInfo[]): Promise<InstallationAnalysis> {
        this.outputChannel.appendLine('Analyzing installation...');
        
        const totalFiles: string[] = [];
        const modifiedFiles: string[] = [];
        const userCreatedFiles: string[] = [];
        let estimatedSize = 0;

        for (const scope of scopes) {
            const scopeFiles = await this.scanScopeFiles(scope.path);
            totalFiles.push(...scopeFiles.all);
            modifiedFiles.push(...scopeFiles.modified);
            userCreatedFiles.push(...scopeFiles.userCreated);
            estimatedSize += scopeFiles.size;
        }

        const analysis: InstallationAnalysis = {
            scopes,
            totalFiles: totalFiles.length,
            modifiedFiles,
            userCreatedFiles,
            estimatedSize,
            fileList: totalFiles,
            modifiedFileList: modifiedFiles,
            userCreatedFileList: userCreatedFiles
        };

        this.outputChannel.appendLine(`Analysis complete: ${analysis.totalFiles} total files, ${analysis.modifiedFiles.length} modified, ${analysis.userCreatedFiles?.length || 0} user-created`);
        return analysis;
    }

    /**
     * Scan files within a scope and categorize them
     */
    private async scanScopeFiles(scopePath: string): Promise<{
        all: string[],
        modified: string[],
        userCreated: string[],
        size: number
    }> {
        const allFiles: string[] = [];
        const modifiedFiles: string[] = [];
        const userCreatedFiles: string[] = [];
        let totalSize = 0;

        try {
            const files = await this.getAllFilesRecursive(scopePath);
            
            for (const file of files) {
                allFiles.push(file);
                
                try {
                    const stat = await vscode.workspace.fs.stat(vscode.Uri.file(file));
                    totalSize += stat.size;
                    
                    // Simple heuristic: files in certain patterns are likely user-modified
                    if (this.isLikelyUserModified(file)) {
                        modifiedFiles.push(file);
                    }
                    
                    // Files with certain patterns are likely user-created
                    if (this.isLikelyUserCreated(file)) {
                        userCreatedFiles.push(file);
                    }
                } catch (error) {
                    // File might have been deleted during scan
                    continue;
                }
            }
        } catch (error) {
            this.logger.warn(`Failed to scan scope ${scopePath}: ${error}`);
        }

        return {
            all: allFiles,
            modified: modifiedFiles,
            userCreated: userCreatedFiles,
            size: totalSize
        };
    }

    /**
     * Recursively get all files in a directory
     */
    private async getAllFilesRecursive(dirPath: string): Promise<string[]> {
        const files: string[] = [];
        
        try {
            const entries = await vscode.workspace.fs.readDirectory(vscode.Uri.file(dirPath));
            
            for (const [name, type] of entries) {
                const fullPath = path.join(dirPath, name);
                
                if (type === vscode.FileType.File) {
                    files.push(fullPath);
                } else if (type === vscode.FileType.Directory) {
                    const subFiles = await this.getAllFilesRecursive(fullPath);
                    files.push(...subFiles);
                }
            }
        } catch (error) {
            // Directory might not exist or be accessible
        }

        return files;
    }

    /**
     * Determine if a file is likely user-modified based on patterns
     */
    private isLikelyUserModified(filePath: string): boolean {
        const fileName = path.basename(filePath);
        const ext = path.extname(fileName).toLowerCase();
        
        // Configuration files are often modified
        const configPatterns = ['.json', '.yml', '.yaml', '.xml', '.ini', '.conf'];
        if (configPatterns.includes(ext)) {return true;}
        
        // Common user-modified filenames
        const userModifiedPatterns = ['config', 'setting', 'preference', 'custom'];
        return userModifiedPatterns.some(pattern => 
            fileName.toLowerCase().includes(pattern)
        );
    }

    /**
     * Determine if a file is likely user-created
     */
    private isLikelyUserCreated(filePath: string): boolean {
        const fileName = path.basename(filePath);
        
        // Files with certain patterns suggest user creation
        const userPatterns = ['my', 'custom', 'user', 'local', 'private'];
        return userPatterns.some(pattern => 
            fileName.toLowerCase().includes(pattern)
        );
    }

    /**
     * Show uninstallation preview and get user choice
     */
    private async showUninstallPreview(analysis: InstallationAnalysis): Promise<UninstallChoice | undefined> {
        const preview: UninstallPreview = {
            analysis,
            scope: analysis.scopes.map((s: any) => s.name).join(", "),
            recommendedAction: analysis.modifiedFiles.length > 0 ? "smart" : "complete",
            message: this.generatePreviewMessage(analysis)
        };

        const choices = [
            'Complete Removal',
            'Smart Removal (Preserve User Files)',
            'Custom Selection',
            'Cancel'
        ];

        const choice = await vscode.window.showQuickPick(choices, {
            title: 'OLAF Uninstallation Options',
            placeHolder: preview.message
        });

        switch (choice) {
            case 'Complete Removal':
                return 'complete';
            case 'Smart Removal (Preserve User Files)':
                return 'smart';
            case 'Custom Selection':
                return 'custom';
            default:
                return 'cancel';
        }
    }

    /**
     * Generate preview message for user
     */
    private generatePreviewMessage(analysis: InstallationAnalysis): string {
        const sizeStr = this.formatFileSize(analysis.estimatedSize || 0);
        
        let message = `Found OLAF installation in ${analysis.scopes.length} scope(s)\n`;
        message += `Total: ${analysis.totalFiles} files (${sizeStr})\n`;
        
        if (analysis.modifiedFiles.length > 0) {
            message += `Modified: ${analysis.modifiedFiles.length} files\n`;
        }
        
        if ((analysis.userCreatedFiles?.length || 0) > 0) {
            message += `User-created: ${analysis.userCreatedFiles?.length} files\n`;
        }
        
        message += '\nChoose uninstallation method:';
        return message;
    }

    /**
     * Format file size in human-readable format
     */
    private formatFileSize(bytes: number): string {
        if (bytes === 0) {return '0 B';}
        const k = 1024;
        const sizes = ['B', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    /**
     * Perform the actual smart uninstallation
     */
    private async performSmartUninstallation(
        scopes: ScopeInfo[],
        choice: UninstallChoice,
        analysis: InstallationAnalysis
    ): Promise<void> {
        this.outputChannel.appendLine(`Starting ${choice} uninstallation...`);
        
        await vscode.window.withProgress({
            location: vscode.ProgressLocation.Notification,
            title: 'Uninstalling OLAF',
            cancellable: false
        }, async (progress) => {
            progress.report({ increment: 0, message: 'Creating verification policy...' });
            
            const policy = this.createVerificationPolicy(choice, analysis);
            
            progress.report({ increment: 20, message: 'Backing up user files...' });
            if (choice !== 'complete') {
                await this.backupUserFiles(analysis);
            }
            
            progress.report({ increment: 40, message: 'Removing OLAF files...' });
            const report = await this.executeUninstallation(scopes, policy);
            
            progress.report({ increment: 80, message: 'Finalizing...' });
            await this.showCompletionDialog(report, choice);
            
            progress.report({ increment: 100, message: 'Complete!' });
        });
    }

    /**
     * Create verification policy based on user choice
     */
    private createVerificationPolicy(choice: UninstallChoice, analysis: InstallationAnalysis): {
        preserveModified: boolean,
        preserveUserCreated: boolean,
        customSelection?: string[]
    } {
        switch (choice) {
            case 'complete':
                return { preserveModified: false, preserveUserCreated: false };
            case 'smart':
                return { preserveModified: true, preserveUserCreated: true };
            case 'custom':
                return { 
                    preserveModified: true, 
                    preserveUserCreated: true,
                    customSelection: analysis.modifiedFileList
                };
            default:
                return { preserveModified: true, preserveUserCreated: true };
        }
    }

    /**
     * Backup user files before uninstallation
     */
    private async backupUserFiles(analysis: InstallationAnalysis): Promise<void> {
        const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
        if (!workspaceFolder) {return;}

        const backupDir = path.join(workspaceFolder.uri.fsPath, '.olaf-backup', new Date().toISOString().slice(0, 19).replace(/:/g, '-'));
        
        try {
            await fs.ensureDir(backupDir);
            
            const filesToBackup = [...(analysis.modifiedFileList || []), ...(analysis.userCreatedFileList || [])];
            
            for (const file of filesToBackup) {
                try {
                    const relativePath = path.relative(workspaceFolder.uri.fsPath, file);
                    const backupPath = path.join(backupDir, relativePath);
                    await fs.ensureDir(path.dirname(backupPath));
                    await fs.copy(file, backupPath);
                } catch (error) {
                    this.logger.warn(`Failed to backup file ${file}: ${error}`);
                }
            }
            
            this.outputChannel.appendLine(`User files backed up to: ${backupDir}`);
        } catch (error) {
            this.logger.warn(`Backup failed: ${error}`);
        }
    }

    /**
     * Execute the actual uninstallation
     */
    private async executeUninstallation(
        scopes: ScopeInfo[],
        policy: { preserveModified: boolean, preserveUserCreated: boolean, customSelection?: string[] }
    ): Promise<IntegrityReport> {
        // Use the installation manager's uninstall method
        // Convert ScopeInfo to InstallationScope enum
        const scopeType = scopes[0].type === "global" ? InstallationScope.USER : 
                         scopes[0].type === "workspace" ? InstallationScope.WORKSPACE : 
                         InstallationScope.PROJECT;
        const report = await this.installationManager.uninstall(scopeType);
        
        this.outputChannel.appendLine(`Uninstallation completed. Files processed: ${report.totalFiles}`);
        return report;
    }

    /**
     * Show completion dialog with detailed results
     */
    private async showCompletionDialog(report: IntegrityReport, choice: UninstallChoice): Promise<void> {
        const stats = this.generateUninstallStats(report);
        const message = `OLAF Uninstallation Complete!\n\n${stats}`;
        
        const actions = ['Show Details', 'Close'];
        if (report.deletedFiles > 0) {
            actions.unshift('View Detailed Report');
        }
        
        const selection = await vscode.window.showInformationMessage(message, ...actions);
        
        if (selection === 'Show Details') {
            this.outputChannel.show();
        } else if (selection === 'View Detailed Report') {
            await this.showDetailedReport(report);
        }
    }

    /**
     * Generate uninstallation statistics
     */
    private generateUninstallStats(report: IntegrityReport): string {
        return [
            `Files processed: ${report.totalFiles}`,
            `Files removed: ${report.deletedFiles}`,
            `Files preserved: ${report.modifiedFiles}`,
            `Files intact: ${report.intactFiles}`
        ].join('\n');
    }

    /**
     * Show detailed report in a new document
     */
    private async showDetailedReport(report: IntegrityReport): Promise<void> {
        const doc = await vscode.workspace.openTextDocument({
            content: this.formatDetailedReport(report),
            language: 'markdown'
        });
        
        await vscode.window.showTextDocument(doc);
    }

    /**
     * Format detailed report content
     */
    private formatDetailedReport(report: IntegrityReport): string {
        const sections: string[] = [
            '# OLAF Uninstallation Report\n',
            `**Total Files**: ${report.totalFiles}`,
            `**Files Removed**: ${report.deletedFiles}`,
            `**Files Preserved**: ${report.modifiedFiles}`,
            `**Files Intact**: ${report.intactFiles}`,
            ''
        ];

        // Add detailed file listings if available
        if (report.modifications && report.modifications.length > 0) {
            sections.push('## Removed Files');
            const deleted = report.modifications
                .filter((m: any) => m.type === 'deleted')
                .map((item: any) => `- ${item.path}`);
            sections.push(...deleted, '');

            sections.push('## Preserved Files');
            const modified = report.modifications
                .filter((m: any) => m.type === 'modified')
                .map((item: any) => `- ${item.path}`);
            sections.push(...modified, '');

            sections.push('## Intact Files');
            const intact = report.modifications
                .filter((m: any) => m.type === 'intact')
                .map((item: any) => `- ${item.path}`);
            sections.push(...intact, '');
        }

        return sections.join('\n');
    }
}
