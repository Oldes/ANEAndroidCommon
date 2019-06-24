package com.amanitadesign;

import java.util.HashMap;
import java.util.Map;

import android.content.res.Configuration;
import android.util.Log;
import android.view.WindowManager;

import com.adobe.air.AndroidActivityWrapper;
import com.adobe.air.CommonStateChangeCallback;
import com.adobe.air.AndroidActivityWrapper.ActivityState;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;


public class CommonExtensionContext extends FREContext implements CommonStateChangeCallback
{
	private AndroidActivityWrapper aaw = null;
	public Boolean keepAwake;
	
    public CommonExtensionContext()
    {
    	aaw = AndroidActivityWrapper.GetAndroidActivityWrapper();
        aaw.addActivityStateChangeListner( this );
    }
    
    @Override
    public void onActivityStateChanged( ActivityState state ) {
        switch ( state ) {
            case STARTED:
            case RESTARTED:
            case RESUMED:
            	if(keepAwake) getActivity().getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
            	break;
            case PAUSED:
            case STOPPED:
            	getActivity().getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
            	break;
            case DESTROYED:
        }
        if(CommonExtension.VERBOSE > 0) Log.i(CommonExtension.TAG, "onStateChanged: "+ state);
        dispatchStatusEventAsync("onStateChanged", state.toString());
    }
    @Override
    public void onConfigurationChanged(Configuration paramConfiguration) {
    	if(CommonExtension.VERBOSE > 0) Log.i(CommonExtension.TAG, "onConfigurationChanged: "+ paramConfiguration);
    }

    @SuppressWarnings("unused")
	@Override
	public void dispose() {
    	if(CommonExtension.VERBOSE > 0) Log.i(CommonExtension.TAG,"Context disposed.");
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
		functions.put("init", new CommonFunctions.Init());
		functions.put("getDeviceId", new CommonFunctions.GetDeviceId());
		functions.put("getResourceString", new CommonFunctions.GetResourceString());
		functions.put("getSDKInt", new CommonFunctions.GetSDKInt());
		functions.put("showToast", new CommonFunctions.ShowToast());
		functions.put("showAlertDialog", new CommonFunctions.ShowAlertDialog());
		functions.put("keepAwake", new CommonFunctions.KeepAwake());
		functions.put("navigateToURL", new CommonFunctions.NavigateToURL());
		functions.put("visitURLDialog", new CommonFunctions.ShowVisitURLDialog());
		return functions;
	}

}
