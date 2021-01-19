interface BrowserPluginOpenOptions {
    /**
     * On iOS you can set option `readerMode` to open Safari in reader mode.
     * 
     * @default false
     */
    readerMode?: boolean;
}

interface BrowserPlugin {
    /**
     * Opens a url in browser activity.
     *
     * @param url The url to open.
     * @param options The options for the browser.
     * 
     * @example
     * cordova.plugins.browser.open("https://google.com");
     * cordova.plugins.browser.open("https://google.com", {readerMode: true});
     */
    open(url: string, options?: BrowserPluginOpenOptions): Promise<void>;

    /**
     * Trigger a callback when browser finished loading page successfully.
     *
     * @param callback The callback to trigger.
     * 
     * @example
     * cordova.plugins.browser.onLoad(() => {
     *     console.log("my url is loaded");
     * });
     */
    onLoad(callback: (error?: unknown) => void): void;

    /**
     * Trigger a callback when browser activity was closed.
     *
     * @param callback The callback to trigger.
     * 
     * @example
     * cordova.plugins.browser.onClose(() => {
     *     console.log("browser activity was closed");
     * });
     */
    onClose(callback: (error?: unknown) => void): void;
}

interface CordovaPlugins {
    browser: BrowserPlugin;
}
