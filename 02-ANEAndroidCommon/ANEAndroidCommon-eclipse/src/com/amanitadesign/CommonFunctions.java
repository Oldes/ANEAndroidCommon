package com.amanitadesign;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.amanitadesign.CommonExtension;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.res.Resources;
import android.util.Log;
import android.view.WindowManager;
import android.widget.Toast;

public class CommonFunctions {
	static public String getResourceString(String id) {
		Resources res = CommonExtension.appContext.getResources();
		return res.getString(res.getIdentifier(id, "string", CommonExtension.appContext.getPackageName()));
	}
	static public class Init implements FREFunction {
		@Override
		public FREObject call(FREContext context, FREObject[] args) {
			CommonExtension.init(context.getActivity().getApplicationContext());
			return null;
		}
	}
	
	static public class GetDeviceId implements FREFunction  {

		@Override
		public FREObject call(FREContext ctx, FREObject[] args) {
			FREObject result = null;

			try{
				result = FREObject.newObject(CommonExtension.deviceId);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}
	}
	
	static public class GetResourceString implements FREFunction  {

		@SuppressWarnings("unused")
		@Override
		public FREObject call(FREContext ctx, FREObject[] args) {
			try{
				String id = args[0].getAsString();
				String str = getResourceString(id);
		    	if(CommonExtension.VERBOSE > 0) Log.d(CommonExtension.TAG, "GetResourceString: '"+ id +"' = "+str);
		    	return FREObject.newObject(str);
		    	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	}
	
	static public class KeepAwake implements FREFunction  {

		@SuppressWarnings("unused")
		@Override
		public FREObject call(FREContext ctx, FREObject[] args) {
			try{
				Boolean keepAwake = CommonExtension.extensionContext.keepAwake = args[0].getAsBool();
				if(CommonExtension.VERBOSE > 0) Log.d(CommonExtension.TAG, "KeepAwake: "+ keepAwake);
				if(keepAwake) {
					CommonExtension.extensionContext.getActivity().getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
				} else {
					CommonExtension.extensionContext.getActivity().getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	}
	
	static public class ShowToast implements FREFunction  {

		@SuppressWarnings("unused")
		@Override
		public FREObject call(FREContext ctx, FREObject[] args) {
			try{
				String message = args[0].getAsString();
		    	int duration = args[1].getAsInt();
		    	if(CommonExtension.VERBOSE > 0) Log.d(CommonExtension.TAG, "showToast: '"+ message +"', duration: "+ duration);
		    	Toast.makeText(ctx.getActivity(), message, duration).show();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	}
	
	static public class ShowAlertDialog implements FREFunction {
		public static final String NO = "no";
		public static final String YES = "yes";
		
		@SuppressWarnings("unused")
		@Override
		final public FREObject call(FREContext context, FREObject[] args) {
			try {
				String title   = (args[0] == null) ? null : args[0].getAsString();
				String message = (args[1] == null) ? null : args[1].getAsString();
				
				if(CommonExtension.VERBOSE > 1) Log.d(CommonExtension.TAG, "ShowAlertDialog");
				

				AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(context.getActivity());
				alertDialogBuilder
					.setTitle(title)
					.setMessage(message)
					.setNegativeButton(getResourceString(NO), new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog,int id) {
						    CommonExtension.extensionContext.dispatchStatusEventAsync("onAlertDialog", NO);
						}
					})
					.setPositiveButton(getResourceString(YES), new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog,int id) {
						    CommonExtension.extensionContext.dispatchStatusEventAsync("onAlertDialog", YES);
						}
					});
				// create alert dialog
				AlertDialog alertDialog = alertDialogBuilder.create();

				// show it
				alertDialog.show();
				
			    return FREObject.newObject(true);
			}
			catch (Exception e) {
				return null;
			}
		}
	}
}
