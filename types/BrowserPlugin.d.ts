/**
 * Opens a url in browser activity.
 *
 * @param url The url to open.
 * @param options The options for the browser.
 *
 * @returns {Promise<void>} Callback when operation is completed
 *
 * @example
 * cordova.plugins.browser.open("https://google.com");
 * cordova.plugins.browser.open("https://google.com", {readerMode: true});
 */
export function open(url: any, options: any): Promise<void>;
/**
 * Trigger a callback when browser finished loading page successfully.
 *
 * @param {() => void} callback Callback function
 * @param {(error: string) => void} [errorCallback] Error callback function
 *
 * @example
 * cordova.plugins.browser.onLoad(() => {
 *     console.log("my url is loaded");
 * });
 */
export function onLoad(callback: () => void, errorCallback?: (error: string) => void): void;
/**
 * Trigger a callback when browser activity was closed.
 *
 * @param {() => void} callback Callback function
 * @param {(error: string) => void} [errorCallback] Error callback function
 *
 * @example
 * cordova.plugins.browser.onClose(() => {
 *     console.log("browser activity was closed");
 * });
 */
export function onClose(callback: () => void, errorCallback?: (error: string) => void): void;
