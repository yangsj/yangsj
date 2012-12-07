package newview.team
{

	import flash.display.Sprite;
	import flash.events.Event;
	
	import newview.ui.HeadPhotoRound;
	
	import ui.team.ResourceTeamAllRoleHeadPicture1;
	import ui.team.ResourceTeamReadyWords;
	import ui.team.ResourceTeamRoleHeadBgMask;
	import ui.team.ResourceTeamWaitStatusEffect;
	
	import utils.BitmapUtils;


	/**
	 * 说明：TeamWaitItem
	 * @author Victor
	 * 2012-11-14
	 */

	public class TeamWaitItem extends TeamItemBase
	{

		private static var pool : Vector.<TeamWaitItem> = new Vector.<TeamWaitItem>();


		private var readyMc : Sprite;
		private var roleHeadMask : Sprite;

		public function TeamWaitItem()
		{
			roleHeadMask = new ResourceTeamRoleHeadBgMask();
			headPhoto = new HeadPhotoRound();
			readyMc = new ResourceTeamReadyWords();
			readyMc.x = headPhoto.width * 0.5 + headPhoto.getBounds( headPhoto ).x;
			readyMc.y = headPhoto.height * 0.5 + headPhoto.getBounds( headPhoto ).y;

			addChild( roleHeadMask );
			addChild( headPhoto );
			addChild( readyMc );

			BitmapUtils.cacheAsBitmap( roleHeadMask );
			BitmapUtils.cacheAsBitmap( readyMc );

			pushItemFromSelectedListToWaitList();
		}

		public static function create() : TeamWaitItem
		{
			var item : TeamWaitItem;
			if ( pool == null )
				pool = new Vector.<TeamWaitItem>();
			if ( pool.length > 0 )
				item = pool.pop();
			else
				item = new TeamWaitItem();
			item.initialization();
			return item;
		}

		override public function initialization() : void
		{
			super.initialization();
			pushItemFromSelectedListToWaitList();
		}

		override public function pushItemFromSelectedListToWaitList() : void
		{
			if ( readyMc )
				readyMc.visible = false;
			isReady = false;
		}

		override public function pushItemFromWaitListToSelectedList() : void
		{
			if ( readyMc )
				readyMc.visible = true;
			isReady = true;
		}

		override protected function clear() : void
		{
			super.clear();

			pool.push( this );
		}

		override protected function addedToStageHandler( event : Event ) : void
		{
			super.addedToStageHandler( event );

			addChildAt( headPhoto, getStatus );
			this.mouseEnabled = ( getStatus == 1 );
		}


		override public function get type() : int
		{
			return TeamType.TYPE_WAITING;
		}



	}

}
