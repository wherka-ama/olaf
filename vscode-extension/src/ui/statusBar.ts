import * as vscode from 'vscode';
import { UpdateManager } from '../services/updateManager';
import { InstallationManager } from '../services/installationManager';
import { Logger } from '../utils/logger';

/**
 * Status bar item for OLAF extension
 */
export class StatusBar {
    private static instance: StatusBar;
    private statusBarItem: vscode.StatusBarItem;
    private readonly logger: Logger;
    private readonly updateManager: UpdateManager;
    private readonly installationManager: InstallationManager;
    private isCheckingUpdates: boolean = false;

    private constructor() {
        this.logger = Logger.getInstance();
        this.updateManager = UpdateManager.getInstance();
        this.installationManager = InstallationManager.getInstance();
        
        this.statusBarItem = vscode.window.createStatusBarItem(
            vscode.StatusBarAlignment.Right,
            100
        );
        
        this.statusBarItem.command = 'olaf.showVersion';
        this.statusBarItem.tooltip = 'OLAF - Click for version information';
    }

    public static getInstance(): StatusBar {
        if (!StatusBar.instance) {
            StatusBar.instance = new StatusBar();
        }
        return StatusBar.instance;
    }

    /**
     * Initialize the status bar
     */
    public async initialize(): Promise<void> {
        try {
            await this.updateStatus();
            this.statusBarItem.show();
            this.logger.debug('Status bar initialized');
        } catch (error) {
            this.logger.error('Failed to initialize status bar', error as Error);
        }
    }

    /**
     * Update the status bar display
     */
    public async updateStatus(): Promise<void> {
        try {
            const installedScopes = await this.installationManager.getInstalledScopes();
            
            if (installedScopes.length === 0) {
                this.statusBarItem.text = '$(cloud-download) OLAF';
                this.statusBarItem.tooltip = 'OLAF - Not installed. Click to install.';
                this.statusBarItem.command = 'olaf.enhancedInstall';
                this.statusBarItem.backgroundColor = undefined;
                return;
            }

            // Get version from first installed scope
            const installationInfo = await this.installationManager.getInstallationInfo(installedScopes[0]);
            const version = installationInfo?.version || 'unknown';
            
            this.statusBarItem.text = `$(extensions) OLAF v${version}`;
            this.statusBarItem.tooltip = `OLAF v${version} - Installed in ${installedScopes.length} scope(s). Click for details.`;
            this.statusBarItem.command = 'olaf.showVersion';
            this.statusBarItem.backgroundColor = undefined;

        } catch (error) {
            this.logger.error('Failed to update status bar', error as Error);
            this.statusBarItem.text = '$(error) OLAF';
            this.statusBarItem.tooltip = 'OLAF - Error getting status. Click to retry.';
            this.statusBarItem.command = 'olaf.showVersion';
            this.statusBarItem.backgroundColor = new vscode.ThemeColor('statusBarItem.errorBackground');
        }
    }

    /**
     * Show update notification in status bar
     */
    public showUpdateAvailable(updateCount: number): void {
        if (updateCount > 0) {
            this.statusBarItem.text = '$(arrow-up) OLAF Update';
            this.statusBarItem.tooltip = `${updateCount} OLAF update(s) available. Click to update.`;
            this.statusBarItem.command = 'olaf.update';
            this.statusBarItem.backgroundColor = new vscode.ThemeColor('statusBarItem.warningBackground');
        }
    }

    /**
     * Show checking updates status
     */
    public showCheckingUpdates(): void {
        if (!this.isCheckingUpdates) {
            this.isCheckingUpdates = true;
            this.statusBarItem.text = '$(sync~spin) OLAF';
            this.statusBarItem.tooltip = 'OLAF - Checking for updates...';
            this.statusBarItem.command = undefined;
            this.statusBarItem.backgroundColor = undefined;
        }
    }

    /**
     * Hide checking updates status
     */
    public hideCheckingUpdates(): void {
        if (this.isCheckingUpdates) {
            this.isCheckingUpdates = false;
            this.updateStatus();
        }
    }

    /**
     * Check for updates and update status bar accordingly
     */
    public async checkAndUpdateStatus(): Promise<void> {
        try {
            this.showCheckingUpdates();
            
            const installedScopes = await this.installationManager.getInstalledScopes();
            if (installedScopes.length === 0) {
                this.hideCheckingUpdates();
                return;
            }

            const updateChecks = await this.updateManager.checkForUpdates();
            const updatesAvailable = updateChecks.filter(check => check.hasUpdate);

            this.hideCheckingUpdates();

            if (updatesAvailable.length > 0) {
                this.showUpdateAvailable(updatesAvailable.length);
            } else {
                await this.updateStatus();
            }

        } catch (error) {
            this.logger.error('Failed to check for updates in status bar', error as Error);
            this.hideCheckingUpdates();
        }
    }

    /**
     * Dispose of the status bar
     */
    public dispose(): void {
        this.statusBarItem.dispose();
    }
}
