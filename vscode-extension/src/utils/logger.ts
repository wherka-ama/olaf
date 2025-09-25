import * as vscode from 'vscode';

/**
 * Centralized logging utility for the OLAF extension
 */
export class Logger {
    private static instance: Logger;
    private outputChannel: vscode.OutputChannel;

    private constructor() {
        this.outputChannel = vscode.window.createOutputChannel('OLAF');
    }

    public static getInstance(): Logger {
        if (!Logger.instance) {
            Logger.instance = new Logger();
        }
        return Logger.instance;
    }

    /**
     * Reset the singleton instance (for testing purposes)
     */
    public static resetInstance(): void {
        Logger.instance = null as any;
    }

    public info(message: string, ...args: any[]): void {
        const timestamp = new Date().toISOString();
        const logMessage = `[${timestamp}] INFO: ${message}`;
        this.outputChannel.appendLine(logMessage);
        
        if (args.length > 0) {
            this.outputChannel.appendLine(`  Details: ${JSON.stringify(args, null, 2)}`);
        }
        
        console.log(logMessage, ...args);
    }

    public warn(message: string, ...args: any[]): void {
        const timestamp = new Date().toISOString();
        const logMessage = `[${timestamp}] WARN: ${message}`;
        this.outputChannel.appendLine(logMessage);
        
        if (args.length > 0) {
            this.outputChannel.appendLine(`  Details: ${JSON.stringify(args, null, 2)}`);
        }
        
        console.warn(logMessage, ...args);
    }

    public error(message: string, error?: Error, ...args: any[]): void {
        const timestamp = new Date().toISOString();
        const logMessage = `[${timestamp}] ERROR: ${message}`;
        this.outputChannel.appendLine(logMessage);
        
        if (error) {
            this.outputChannel.appendLine(`  Error: ${error.message}`);
            this.outputChannel.appendLine(`  Stack: ${error.stack}`);
        }
        
        if (args.length > 0) {
            this.outputChannel.appendLine(`  Details: ${JSON.stringify(args, null, 2)}`);
        }
        
        console.error(logMessage, error, ...args);
    }

    public debug(message: string, ...args: any[]): void {
        const config = vscode.workspace.getConfiguration('olaf');
        const enableLogging = config.get<boolean>('enableLogging', true);
        
        if (!enableLogging) {
            return;
        }

        const timestamp = new Date().toISOString();
        const logMessage = `[${timestamp}] DEBUG: ${message}`;
        this.outputChannel.appendLine(logMessage);
        
        if (args.length > 0) {
            this.outputChannel.appendLine(`  Details: ${JSON.stringify(args, null, 2)}`);
        }
        
        console.debug(logMessage, ...args);
    }

    public show(): void {
        this.outputChannel.show();
    }

    public clear(): void {
        this.outputChannel.clear();
    }

    public dispose(): void {
        this.outputChannel.dispose();
    }
}
