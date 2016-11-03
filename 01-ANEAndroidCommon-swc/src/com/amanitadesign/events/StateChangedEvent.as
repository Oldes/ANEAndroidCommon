package com.amanitadesign.events
{
	import flash.events.Event;
	
	public class StateChangedEvent extends Event
	{
		public static const ON_STATE_CHANGED:String = "onStateChanged";
		private var mValue;
		
		public function StateChangedEvent(type:String, value:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			mValue = value;
			super(type, bubbles, cancelable);
		}
		
		public final function get value():String {
			return mValue;
		}
	}
}