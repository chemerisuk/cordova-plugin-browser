package by.chemerisuk.cordova.browser;

import android.net.Uri;
import android.support.customtabs.CustomTabsIntent;
import android.util.Log;

import by.chemerisuk.cordova.support.CordovaMethod;
import by.chemerisuk.cordova.support.ReflectiveCordovaPlugin;

import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class BrowserPlugin extends ReflectiveCordovaPlugin {
    private static final String TAG = "BrowserPlugin";

    @CordovaMethod
    protected void open(String urlStr, JSONObject options, CallbackContext callbackContext) throws JSONException {
        CustomTabsIntent.Builder customTabsIntentBuilder = new CustomTabsIntent.Builder();
        // TODO
        CustomTabsIntent customTabsIntent = customTabsIntentBuilder.build();
        customTabsIntent.launchUrl(cordova.getActivity(), Uri.parse(urlStr));

        callbackContext.success();
    }

    @CordovaMethod
    protected void close(CallbackContext callbackContext) {
        callbackContext.success();
    }
}
