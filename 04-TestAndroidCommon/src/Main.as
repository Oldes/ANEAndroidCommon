package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.ui.Keyboard;
	
	import flash.text.TextField;
	
	import com.amanitadesign.AndroidCommon;
	import com.amanitadesign.events.AlertDialogEvent;
	import com.amanitadesign.events.StateChangedEvent;
	/**
	 * ...
	 * @author Oldes
	 */
	public class Main extends Sprite 
	{
		
		public var tf:TextField;
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			tf = new TextField();
			tf.width = stage.stageWidth;
			tf.height = stage.stageHeight;
			tf.defaultTextFormat = new TextFormat(null, 24);
			addChild(tf);
			
			log("Testing Amanita Android ANE...");
			log("AndroidCommon is supported: " + AndroidCommon.isSupported);
			log("DeviceId: " + AndroidCommon.instance.getDeviceId());
			log("Test getResourceString: " + AndroidCommon.instance.getResourceString("quitQuestion"));
			log("\nPress BACK button to test the AlertDialog!");
			
			AndroidCommon.instance.keepAwake(true);
			AndroidCommon.instance.addEventListener(StateChangedEvent.ON_STATE_CHANGED, onStateChanged);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			
			AndroidCommon.instance.visitURLDialog("http://amanita-design.net", "visitWebsite", "official", "Test: ここから先はauスマートパス外となりますが!");
		}
		
		private function onStateChanged(e:StateChangedEvent):void {
			log("onStateChanged: " + e.value);
		}
		
		private function onAlertDialog(e:AlertDialogEvent):void {
			log("onAlertDialog: " + e.value);
			if (e.value == "yes") {
				NativeApplication.nativeApplication.exit();
			} else {
				//It looks that flash.net.navigatetoURL forces app to loose context, so I'm using own version;
				//AndroidCommon.instance.navigateToURL("market://details?id=amanita_design.samorost3.GP");
				AndroidCommon.instance.showToast("Keep testing!", 1000);
			}
		}
		
		private function onKey(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case Keyboard.BACK:
					event.preventDefault();
					event.stopImmediatePropagation();
					AndroidCommon.instance.addEventListener(AlertDialogEvent.ON_ALERT_DIALOG, onAlertDialog);
					log("AlertDialog: " + AndroidCommon.instance.showAlertDialog(AndroidCommon.instance.getResourceString("quitQuestion")));
				break;
			}
		}
		
		private function log(value:String):void {
			trace(value);
			tf.appendText(value+"\n");
			tf.scrollV = tf.maxScrollV;
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}