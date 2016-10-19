package org.apache.cordova.openalpr;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

//import com.openalpr.jni.Alpr;
//import com.openalpr.jni.AlprPlate;
//import com.openalpr.jni.AlprPlateResult;
//import com.openalpr.jni.AlprResults;

import android.util.Log;

import java.io.File;

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
        JSONArray result = new JSONArray();
        JSONObject error = new JSONObject();

        // Strip file:// from imagePath where applicable
        imagePath = imagePath.replace("file://", "");

        //Check if imagePath is available and if image exists
        if (imagePath != null && imagePath.length() > 0) {

            boolean imageExists = new File(imagePath).isFile();

            if (imageExists) {
                Log.v("OpenALPR", imagePath);

                //TODO Move to other place
//                Alpr alpr = new Alpr("eu", "/path/to/openalpr.conf", "/path/to/runtime_data");
//                alpr.setTopN(3);
//
//                AlprResults results = alpr.recognize(imagePath);
//                System.out.format("  %-15s%-8s\n", "Plate Number", "Confidence");
//                for (AlprPlateResult result : results.getPlates())
//                {
//                    for (AlprPlate plate : result.getTopNPlates()) {
//                        if (plate.isMatchesTemplate())
//                            System.out.print("  * ");
//                        else
//                            System.out.print("  - ");
//                        System.out.format("%-15s%-8f\n", plate.getCharacters(), plate.getOverallConfidence());
//                    }
//                }
//
//                // Make sure to call this to release memory
//                alpr.unload();

                callbackContext.success(result);

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