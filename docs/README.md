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
