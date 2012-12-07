package newview.fight
{

	import flash.events.Event;


	/**
	 * 说明：FightEvent
	 * @author Victor
	 * 2012-11-19
	 */

	public class FightEvent extends Event
	{

		public static const FIGHT_CLICK_ITEM : String = "fight_click_item";

		public var item : FightItem;
		public var data : Object;

		public function FightEvent( type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
			if ( data is FightItem )
				item = data as FightItem;
			this.data = data;
		}



	}

}
