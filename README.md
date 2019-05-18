# cordova-plugin-browser<br>[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url] [![Twitter][twitter-follow]][twitter-url]
> Open browser in your app

The project allows to load urls in [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller?language=objc)/[Chrome Custom Tabs](https://developer.chrome.com/multidevice/android/customtabs). 

## Installation

    cordova plugin add cordova-plugin-browser --save

Use variable `CUSTOMTABS_VERSION` to override dependency version on Android.

## Supported Platforms

- iOS
- Android

## Methods

### open(_url_, _options_)
Opens a url in browser activity.
```js
cordova.plugins.browser.open("https://google.com");
```

On iOS you can set option `readerMode` to open Safari in reader mode:
```js
cordova.plugins.browser.open("https://google.com", {readerMode: true});
```

### onLoad(_callback_)
Callback is triggered when browsers finished loading page successfully.
```js
cordova.plugins.browser.onLoad(function() {
    console.log("my url is loaded");
});
```

### onClose(_callback_)
Callback is triggered when browser activity was closed.
```js
cordova.plugins.browser.onLoad(function() {
    console.log("browser activity was closed");
});
```

[npm-url]: https://www.npmjs.com/package/cordova-plugin-browser
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-browser.svg
[npm-downloads]: https://img.shields.io/npm/dm/cordova-plugin-browser.svg
[twitter-url]: https://twitter.com/chemerisuk
[twitter-follow]: https://img.shields.io/twitter/follow/chemerisuk.svg?style=social&label=Follow%20me
