package newview.equip
{

	import flash.events.Event;


	/**
	 * 说明：EquipEvent
	 * @author Victor
	 * 2012-11-19
	 */

	public class EquipEvent extends Event
	{

		public static const CLICK_HEAD_ROLE : String = "click_head_role";
		public static const CLICK_ICON_SKILL : String = "click_icon_skill";

		public var data : Object;

		public function EquipEvent( type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
			if ( data )
				this.data = data;
		}



	}

}
