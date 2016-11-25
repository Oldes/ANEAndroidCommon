package com.amanitadesign
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;

	import flash.events.Event;
	import flash.events.StatusEvent;
	import com.amanitadesign.events.*;
	
	public class AndroidCommon extends EventDispatcher
	{
		
		private static var _instance:AndroidCommon;
		private var extContext:ExtensionContext;
		
		
		public function AndroidCommon( enforcer:SingletonEnforcer ) {
			super();
			
			extContext = ExtensionContext.createExtensionContext( "com.amanitadesign.AndroidCommon", "" );
			
			if ( !extContext ) {
				throw new Error( "AndroidCommon extension is not supported on this platform." );
			}
			extContext.addEventListener( StatusEvent.STATUS, onStatusHandler );
		}
		
		/** Extension is supported on Android devices. */
		public static function get isSupported() : Boolean
		{
			return Capabilities.manufacturer.indexOf("Android") != -1;
		}
		
		
		private function init():void {
			extContext.call( "init" );
			
		}

		private function onStatusHandler( event:StatusEvent ):void {
			trace("onStatusHandler: " + event)
			var e:Event;
			
			switch(event.code) {
				case AlertDialogEvent.ON_ALERT_DIALOG:
					e = new AlertDialogEvent(event.code, event.level);
					break;
				case StateChangedEvent.ON_STATE_CHANGED:
					e = new StateChangedEvent(event.code, event.level);
					break;
			}
			if(e) {
				this.dispatchEvent(e);
			}
			//
			//
		}

		
		/**
		 * Cleans up the instance of the native extension. 
		 */		
		public function dispose():void { 
			extContext.dispose(); 
		}
		
		
		public static function get instance():AndroidCommon {
			if ( !_instance ) {
				_instance = new AndroidCommon( new SingletonEnforcer() );
				_instance.init();
			}
			return _instance;
		}
		
		
		//----------------------------------------
		//
		// Public Methods
		//
		//----------------------------------------
		
		public function getDeviceId(): String { return extContext.call("getDeviceId") as String; }
		public function getResourceString(id:String): String { return extContext.call("getResourceString", id) as String; }
		public function showAlertDialog(title:String = null, message:String = null): Boolean { return extContext.call("showAlertDialog", title, message) as Boolean; }
		public function keepAwake(state:Boolean): void { extContext.call("keepAwake", state); }
		public function navigateToURL(url:String): Boolean { return extContext.call("navigateToURL", url) as Boolean; }
		public function visitURLDialog(url:String, messageRes:String, nameRes:String=null): Boolean { return extContext.call("visitURLDialog", url, messageRes, nameRes) as Boolean; }
	}
}

class SingletonEnforcer {}