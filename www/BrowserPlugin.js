var exec = require("cordova/exec");
var PLUGIN_NAME = "BrowserPlugin";
var promiseReady;

module.exports = {
    open: function(url, options) {
        if (!promiseReady) {
            promiseReady = new Promise(function(resolve, reject) {
                exec(resolve, reject, PLUGIN_NAME, "ready", []);
            });
        }

        return promiseReady.then(function() {
            return new Promise(function(resolve, reject) {
                exec(resolve, reject, PLUGIN_NAME, "open", [url, options || {}]);
            });
        });
    },
    onLoad: function(callback) {
        exec(callback, callback, PLUGIN_NAME, "onLoad", []);
    },
    onClose: function(callback) {
        exec(callback, callback, PLUGIN_NAME, "onClose", []);
    }
};
