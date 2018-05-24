package by.chemerisuk.cordova.browser;

import android.content.Context;
import android.content.ComponentName;
import android.net.Uri;
import android.os.Bundle;
import android.support.customtabs.CustomTabsCallback;
import android.support.customtabs.CustomTabsClient;
import android.support.customtabs.CustomTabsIntent;
import android.support.customtabs.CustomTabsService;
import android.support.customtabs.CustomTabsServiceConnection;
import android.support.customtabs.CustomTabsSession;
import android.util.Log;

import by.chemerisuk.cordova.support.CordovaMethod;
import by.chemerisuk.cordova.support.ReflectiveCordovaPlugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


public class BrowserPlugin extends ReflectiveCordovaPlugin {
    private static final String TAG = "BrowserPlugin";

    private CustomTabsClient customTabsClient;
    private CallbackContext loadCallback;
    private CallbackContext closeCallback;

    @CordovaMethod
    protected void ready(final CallbackContext callbackContext) {
        Context context = cordova.getActivity();
        String packageName = CustomTabsClient.getPackageName(context, null);
        CustomTabsClient.bindCustomTabsService(context, packageName, new CustomTabsServiceConnection() {
            @Override
            public void onCustomTabsServiceConnected(ComponentName name, CustomTabsClient client) {
                customTabsClient = client;
                callbackContext.success();
            }

            @Override
            public void onServiceDisconnected(ComponentName name) {
                Log.d(TAG, "onServiceDisconnected");
            }
        });
    }

    @CordovaMethod
    protected void open(String urlStr, JSONObject options, CallbackContext callbackContext) throws JSONException {
        CustomTabsSession session = this.customTabsClient.newSession(new CustomTabsCallback() {
            @Override
            public void onNavigationEvent(int navigationEvent, Bundle extras) {
                if (navigationEvent == CustomTabsCallback.NAVIGATION_FINISHED) {
                    if (loadCallback != null) {
                        loadCallback.success();
                        loadCallback = null;
                    }
                } else if (navigationEvent == CustomTabsCallback.TAB_HIDDEN) {
                    if (closeCallback != null) {
                        closeCallback.success();
                        closeCallback = null;
                    }
                }
            }
        });
        CustomTabsIntent.Builder customTabsIntentBuilder = new CustomTabsIntent.Builder(session);
        // TODO
        CustomTabsIntent customTabsIntent = customTabsIntentBuilder.build();
        customTabsIntent.launchUrl(cordova.getActivity(), Uri.parse(urlStr));

        callbackContext.success();
    }

    @CordovaMethod
    protected void onLoad(CallbackContext callbackContext) {
        this.loadCallback = callbackContext;
    }

    @CordovaMethod
    protected void onClose(CallbackContext callbackContext) {
        this.closeCallback = callbackContext;
    }
}
