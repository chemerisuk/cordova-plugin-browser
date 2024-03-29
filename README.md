# cordova-plugin-browser<br>[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url] [![Twitter][twitter-follow]][twitter-url]
> Open browser in your app

The project allows to load urls in [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller?language=objc)/[Chrome Custom Tabs](https://developer.chrome.com/multidevice/android/customtabs). 

[npm-url]: https://www.npmjs.com/package/cordova-plugin-browser
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-browser.svg
[npm-downloads]: https://img.shields.io/npm/dm/cordova-plugin-browser.svg
[twitter-url]: https://twitter.com/chemerisuk
[twitter-follow]: https://img.shields.io/twitter/follow/chemerisuk.svg?style=social&label=Follow%20me

## Installation

    $ cordova plugin add cordova-plugin-browser

Use variable `ANDROIDX_BROWSER_VERSION` to override dependency version on Android:

    $ cordova plugin add cordova-plugin-browser --variable ANDROIDX_BROWSER_VERSION='1.0.+'

## Supported Platforms

- iOS
- Android

<!-- TypedocGenerated -->

## Functions

### onClose

**onClose**(`callback`, `errorCallback?`): `void`

Trigger a callback when browser activity was closed.

**`Example`**

```ts
cordova.plugins.browser.onClose(() => {
    console.log("browser activity was closed");
});
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `callback` | () => `void` | Callback function |
| `errorCallback?` | (`error`: `string`) => `void` | Error callback function |

#### Returns

`void`

___

### onLoad

**onLoad**(`callback`, `errorCallback?`): `void`

Trigger a callback when browser finished loading page successfully.

**`Example`**

```ts
cordova.plugins.browser.onLoad(() => {
    console.log("my url is loaded");
});
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `callback` | () => `void` | Callback function |
| `errorCallback?` | (`error`: `string`) => `void` | Error callback function |

#### Returns

`void`

___

### open

**open**(`url`, `options`): `Promise`<`void`\>

Opens a url in browser activity.

**`Example`**

```ts
cordova.plugins.browser.open("https://google.com");
cordova.plugins.browser.open("https://google.com", {readerMode: true});
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `url` | `any` | The url to open. |
| `options` | `any` | The options for the browser. |

#### Returns

`Promise`<`void`\>

Callback when operation is completed
