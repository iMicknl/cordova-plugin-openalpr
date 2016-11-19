package org.apache.cordova.openalpr;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.openalpr.jni.Alpr;
import com.openalpr.jni.AlprException;
import com.openalpr.jni.AlprPlate;
import com.openalpr.jni.AlprPlateResult;
import com.openalpr.jni.AlprResults;
import com.openalpr.util.Utils;

import android.content.Context;
import android.content.res.AssetManager;
import android.util.ArrayMap;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import static android.R.id.message;

public class OpenALPR extends CordovaPlugin {

    /**
     * Constructor.
     */
    public OpenALPR() {
    }

    /**
     * @param action          The action to execute.
     * @param args            The exec() arguments.
     * @param callbackContext The callback context used when calling back into JavaScript.
     * @return boolean
     * @throws JSONException
     */
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        if (action.equals("scan")) {
            String imagePath = args.getString(0);
            this.scan(imagePath, callbackContext);
            return true;
        }

        return true;
    }

    /**
     * Returns (via callback) array of license plates found based on the given imagePath
     *
     * @param imagePath       path to image
     * @param callbackContext callback to JavaScript
     */
    private void scan(String imagePath, CallbackContext callbackContext) {

        //TODO Remove Mock objects
        JSONObject error = new JSONObject();

        // Strip file:// from imagePath where applicable
        imagePath = imagePath.replace("file://", "");
        System.out.println("Path: " + imagePath);
        //Check if imagePath is available and if image exists
        if (imagePath != null && imagePath.length() > 0) {

            boolean imageExists = new File(imagePath).isFile();

            if (imageExists) {

                //TODO Move to other place
                Context context = this.cordova.getActivity().getApplicationContext();
                String androidDataDir = context.getApplicationInfo().dataDir;
                Utils.copyAssetFolder(context.getAssets(), "runtime_data", androidDataDir + File.separatorChar + "runtime_data");

                String runtime_dir = androidDataDir + File.separatorChar + "runtime_data";
                String conf_file = runtime_dir + File.separatorChar + "openalpr.conf";

                Alpr alpr = new Alpr("eu", conf_file, runtime_dir);
                alpr.setTopN(3);
                AlprResults results = null;

                try {
                    results = alpr.recognize(imagePath);
                } catch (AlprException e) {
                    e.printStackTrace();
                }

                JSONArray array = new JSONArray();
                if(results != null) {
                    for (AlprPlateResult result : results.getPlates()) {
                        for (AlprPlate plate : result.getTopNPlates()) {
                            JSONObject obj = new JSONObject();
                            try {
                                obj.put("number", plate.getCharacters());
                                obj.put("confidence", plate.getOverallConfidence());
                                array.put(obj);
                            } catch(JSONException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }

                PluginResult cordovaResult = new PluginResult(PluginResult.Status.OK, array);
                // Make sure to call this to release memory
                alpr.unload();
                callbackContext.sendPluginResult(cordovaResult);
            } else {
                Log.v("OpenALPR", "Image doesn't exist");

                try {
                    error.put("code", 1);
                    error.put("message", "Image doesn't exist");
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                callbackContext.error(error);
            }

        } else {
            Log.v("OpenALPR", "No imagePath");

            try {
                error.put("code", 0);
                error.put("message", "No imagepath given");
            } catch (JSONException e) {
                e.printStackTrace();
            }

            callbackContext.error(error);
        }
    }
}