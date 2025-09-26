import * as assert from 'assert';
import * as vscode from 'vscode';
import { Logger } from '../../utils/logger';

describe('Logger Tests', () => {
    vscode.window.showInformationMessage('Start logger tests.');

    it('Should create singleton instance', () => {
        const logger1 = Logger.getInstance();
        const logger2 = Logger.getInstance();
        
        assert.strictEqual(logger1, logger2);
    });

    it('Should log messages without throwing', () => {
        const logger = Logger.getInstance();
        
        // These should not throw
        assert.doesNotThrow(() => {
            logger.debug('Debug message');
            logger.info('Info message');
            logger.warn('Warning message');
            logger.error('Error message');
            logger.error('Error with error object', new Error('Test error'));
        });
    });

    it('Should handle logger operations', () => {
        // Reset singleton to ensure clean state with mock
        Logger.resetInstance();
        
        const logger = Logger.getInstance();
        
        assert.doesNotThrow(() => {
            logger.show();
            logger.clear();
            logger.info('Test message after clear');
        });
    });

    it('Should dispose properly', () => {
        const logger = Logger.getInstance();
        
        assert.doesNotThrow(() => {
            logger.dispose();
        });
    });
});
