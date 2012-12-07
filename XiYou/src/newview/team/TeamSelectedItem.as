package newview.team
{

	import flash.display.Sprite;
	import flash.events.Event;
	
	import newview.ui.HeadPhotoSquare;
	
	import ui.team.ResourceTeamAllRoleHeadPicture2;
	import ui.team.ResourceTeamSelectedStatusEffect;


	/**
	 * 说明：TeamSelectedItem
	 * @author Victor
	 * 2012-11-14
	 */

	public class TeamSelectedItem extends TeamItemBase
	{
		private static var pool : Vector.<TeamSelectedItem> = new Vector.<TeamSelectedItem>();

		private const WIDTH : Number = 130.8;
		private const HEIGHT : Number = 130.6;

		public function TeamSelectedItem()
		{
			headPhoto = new HeadPhotoSquare();
			addChild(headPhoto);
		}

		public static function create() : TeamSelectedItem
		{
			var item:TeamSelectedItem;
			if ( pool == null )
				pool = new Vector.<TeamSelectedItem>();
			if ( pool.length > 0 )
				item = pool.pop();
			else
				item = new TeamSelectedItem();
			item.initialization();
			return item;
		}

		override protected function removedFromStageHandler( event : Event ) : void
		{
			super.removedFromStageHandler( event );

			pool.push( this );
		}

		override public function get type() : int
		{
			return TeamType.TYPE_SELECTED;
		}
		
		override public function get isReady():Boolean
		{
			return true;
		}


	}

}
