package org.apache.cordova.openalpr;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

import android.util.Log;

public class OpenALPR extends CordovaPlugin {

    /**
     * Constructor.
     */
    public OpenALPR() {
    }

    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        if (action.equals("scan")) {
            String path = args.getString(0);
            this.scan(path, callbackContext);
            return true;
        }

        return true;
    }

    private void scan(String filePath, CallbackContext callbackContext) {
        if (filePath != null && filePath.length() > 0) {
            Log.v("OpenALPR", filePath);
            callbackContext.success(filePath);
        } else {
            Log.v("OpenALPR", "No filepath");

            callbackContext.error("No filepath.");
        }
    }

}