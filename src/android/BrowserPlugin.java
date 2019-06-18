package by.chemerisuk.cordova.browser;

import android.content.Context;
import android.content.ComponentName;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.Browser;
import androidx.browser.customtabs.CustomTabsCallback;
import androidx.browser.customtabs.CustomTabsClient;
import androidx.browser.customtabs.CustomTabsIntent;
import androidx.browser.customtabs.CustomTabsServiceConnection;
import androidx.browser.customtabs.CustomTabsSession;
import android.util.Log;

import by.chemerisuk.cordova.support.CordovaMethod;
import by.chemerisuk.cordova.support.ReflectiveCordovaPlugin;

import org.apache.cordova.CallbackContext;

import org.json.JSONException;
import org.json.JSONObject;


public class BrowserPlugin extends ReflectiveCordovaPlugin {
    private static final String TAG = "BrowserPlugin";

    private CustomTabsClient customTabsClient;
    private CustomTabsCallback customTabsCallback;

    private CallbackContext loadCallback;
    private CallbackContext closeCallback;

    @CordovaMethod
    protected void ready(final CallbackContext callbackContext) {
        Context context = this.cordova.getActivity();
        String packageName = CustomTabsClient.getPackageName(context, null);
        if (packageName == null) {
            callbackContext.success();
        } else {
            CustomTabsClient.bindCustomTabsService(context, packageName, new CustomTabsServiceConnection() {
                @Override
                public void onCustomTabsServiceConnected(ComponentName name, CustomTabsClient client) {
                    customTabsClient = client;
                    customTabsCallback = new CustomTabsCallback() {
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
                    };

                    callbackContext.success();
                }

                @Override
                public void onServiceDisconnected(ComponentName name) {
                    Log.d(TAG, "onServiceDisconnected");
                }
            });
        }
    }

    @CordovaMethod
    protected void open(String urlStr, JSONObject options, CallbackContext callbackContext) throws JSONException {
        Context context = this.cordova.getActivity();
        Uri uri = Uri.parse(urlStr);

        if (this.customTabsClient == null) {
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setData(uri);
            intent.putExtra(Browser.EXTRA_APPLICATION_ID, context.getPackageName());
            context.startActivity(intent);
        } else {
            CustomTabsSession session = this.customTabsClient.newSession(this.customTabsCallback);
            CustomTabsIntent.Builder builder = new CustomTabsIntent.Builder(session);
            // add nice animation for custom tabs
            builder.setStartAnimations(context, getAnimResId("slide_in_right"), getAnimResId("slide_out_left"));
            builder.setExitAnimations(context, getAnimResId("slide_in_left"), getAnimResId("slide_out_right"));
            // TODO
            CustomTabsIntent customTabsIntent = builder.build();
            customTabsIntent.launchUrl(context, uri);
        }

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

    @Override
    public void onPause(boolean multitasking) {
        if (this.customTabsClient == null && this.loadCallback != null) {
            this.loadCallback.success();
            this.loadCallback = null;
        }
    }

    @Override
    public void onResume(boolean multitasking) {
        if (this.customTabsClient == null && this.closeCallback != null) {
            this.closeCallback.success();
            this.closeCallback = null;
        }
    }

    private int getAnimResId(String name) {
        Context context = this.cordova.getActivity();

        return context.getResources()
            .getIdentifier(name, "anim", context.getPackageName());
    }
}
