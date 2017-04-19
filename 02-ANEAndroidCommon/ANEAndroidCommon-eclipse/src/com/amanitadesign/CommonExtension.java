package com.amanitadesign;

import android.content.Context;
import android.provider.Settings;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.amanitadesign.CommonExtensionContext;

/**
 * Created by Oldes on 9/16/2016.
 */
public class CommonExtension implements FREExtension {
    public static final String TAG = "AmanitaCommonExtension";
    public static final int VERBOSE = 3; 

    public static CommonExtensionContext extensionContext;
    public static Context appContext;
    
    public static String deviceId;

    @Override
    public FREContext createContext(String contextType) {
        return extensionContext = new CommonExtensionContext();
    }

    public static void init(Context context) {
    	appContext = context;
    	deviceId = Settings.Secure.getString(appContext.getContentResolver(), Settings.Secure.ANDROID_ID);
    }
    @SuppressWarnings("unused")
	@Override
    public void dispose() {
        if(VERBOSE > 0) Log.i(TAG, "Extension disposed.");

        appContext = null;
        extensionContext = null;
    }

    @SuppressWarnings("unused")
	@Override
    public void initialize() {
    	if(VERBOSE > 0) Log.i(TAG, "Extension initialized.");
    }

}
