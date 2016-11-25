package com.amanitadesign;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.amanitadesign.CommonExtension;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Resources;
import android.net.Uri;
import android.util.Log;
import android.view.WindowManager;
import android.widget.Toast;

public class CommonFunctions {
	static public String getResourceString(String id) {
		Resources res = CommonExtension.appContext.getResources();
		return res.getString(res.getIdentifier(id, "string", CommonExtension.appContext.getPackageName()));
	}
	static public void navigateToURL(String url) {
		if(CommonExtension.VERBOSE > 0) Log.d(CommonExtension.TAG, "navigateToURL: "+ url);
		Intent openUrlIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
		openUrlIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		CommonExtension.extensionContext.getActivity().startActivity(openUrlIntent);
	}
	static private void displayDialog(AlertDialog.Builder alertDialogBuilder) {
		// create alert dialog
		AlertDialog alertDialog = alertDialogBuilder.create();

		//Set the dialog to not focusable (makes navigation ignore us adding the window)
		alertDialog.getWindow().setFlags(WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE, WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE);
		
		// show it
		alertDialog.show();
		
		//Set the dialog to immersive
		alertDialog.getWindow().getDecorView().setSystemUiVisibility(
		CommonExtension.extensionContext.getActivity().getWindow().getDecorView().getSystemUiVisibility());

		//Clear the not focusable flag from the window
		alertDialog.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE);
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

				//AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(context.getActivity());
				AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(context.getActivity(), AlertDialog.THEME_HOLO_DARK);
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
					})
					.setOnCancelListener(new DialogInterface.OnCancelListener() {         
					    @Override
					    public void onCancel(DialogInterface dialog) {
					    	CommonExtension.extensionContext.dispatchStatusEventAsync("onAlertDialog", "cancel");
					    }
					});
				
				displayDialog(alertDialogBuilder);
				
			    return FREObject.newObject(true);
			}
			catch (Exception e) {
				return null;
			}
		}
	}
	
	static public class ShowVisitURLDialog implements FREFunction {
		public static final String NO = "no";
		public static final String YES = "yes";
		public static String url;
		
		@SuppressWarnings("unused")
		@Override
		final public FREObject call(FREContext context, FREObject[] args) {
			try {
				if(CommonExtension.VERBOSE > 1) Log.d(CommonExtension.TAG, "ShowVisitURLDialog");
				
				url = args[0].getAsString();
				String message   = getResourceString(args[1].getAsString());
				String name = (args[2] == null) ? null : args[2].getAsString();
				
				
				if(name != null) {
					name = getResourceString(name);
					message = String.format(message, name);
				}
				

				//AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(context.getActivity());
				AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(context.getActivity(), AlertDialog.THEME_HOLO_DARK);
				alertDialogBuilder
					.setTitle(message)
					.setNegativeButton(getResourceString(NO), new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog,int id) {
						    //CommonExtension.extensionContext.dispatchStatusEventAsync("onAlertDialog", NO);
						}
					})
					.setPositiveButton(getResourceString(YES), new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog,int id) {
							navigateToURL(url);
						}
					});
				
				displayDialog(alertDialogBuilder);
				
			    return FREObject.newObject(true);
			}
			catch (Exception e) {
				return null;
			}
		}
	}
	
	static public class NavigateToURL implements FREFunction  {

		@SuppressWarnings("unused")
		@Override
		public FREObject call(FREContext ctx, FREObject[] args) {
			try{
				navigateToURL(args[0].getAsString());
		    	return FREObject.newObject(true);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	}
}
