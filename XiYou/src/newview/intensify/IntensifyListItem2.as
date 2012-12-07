package newview.intensify
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import newview.ui.HeadPhotoBase;
	import newview.ui.HeadPhotoRound;
	import newview.ui.HeadPhotoSquare;
	
	import ui.intensify.ResourceIntensifyListItem2;
	import ui.team.ResourceTeamRoleHeadBgMask;


	/**
	 * 说明：IntensifyListItem2 人物信息列表Item
	 * @author Victor
	 * 2012-11-20
	 */

	public class IntensifyListItem2 extends IntensifyListItemBase
	{
		private const HEAD_WIDTH : Number = 66;
		private const HEAD_HEIGHT : Number = 66;

		private var child : ResourceIntensifyListItem2;
		private var headPhoto : HeadPhotoBase;
		private var headMask : Sprite;

		public function IntensifyListItem2()
		{
			super();
		}

		override protected function createResource() : void
		{
			child = new ResourceIntensifyListItem2();
			addChild( child );
			item = child as MovieClip;

//			headPhoto = new HeadPhotoSquare();
			headPhoto = new HeadPhotoRound();
			headMask = new ResourceTeamRoleHeadBgMask();
			child.headContainer.addChild(headMask);
			child.headContainer.addChild( headPhoto );
//			child.headContainer.scaleX = child.headContainer.scaleY = 1;
//			var scalex : Number = HEAD_WIDTH / child.headContainer.width;
//			var scaley : Number = HEAD_HEIGHT / child.headContainer.height;
			child.headContainer.scaleX = child.headContainer.scaleY = 0.8;//Math.min( scalex, scaley );
		}

		override protected function addedToStageHandler( event : Event ) : void
		{
			super.addedToStageHandler( event );

			if ( child )
			{
//				child.iconStar.gotoAndStop( getStar );
				child.txtLevel.text = getLevel + "";
				child.txtName.text = getName + "";

				headPhoto.setId( getId );
			}
		}


		override public function get listType() : int
		{
			return IntensifyType.INFO_LIST_ROLE;
		}



	}

}
