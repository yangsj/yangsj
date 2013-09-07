package app.core.components.controls.combo
{
	
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-7
	 */
	public class ComboEvent extends BaseEvent
	{
		public function ComboEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public static const SELECTED:String = "combo_selected";
		
	}
}