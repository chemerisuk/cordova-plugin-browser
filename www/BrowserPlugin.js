var exec = require("cordova/exec");
var PLUGIN_NAME = "BrowserPlugin";

module.exports = {
    open: function(url, options) {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "open", [url, options || {}]);
        });
    },
    close: function() {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "close", []);
        });
    }
};
