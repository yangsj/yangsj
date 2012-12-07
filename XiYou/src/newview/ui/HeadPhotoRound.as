package newview.ui
{

	import flash.display.Sprite;

	import ui.team.ResourceTeamAllRoleHeadPicture1;
	import ui.team.ResourceTeamWaitStatusEffect;


	/**
	 * 说明：HeadPhotoRound
	 * @author Victor
	 * 2012-11-19
	 */

	public class HeadPhotoRound extends HeadPhotoBase
	{


		public function HeadPhotoRound()
		{
			super();
		}

		override protected function createResource() : void
		{
			headPhoto = new ResourceTeamAllRoleHeadPicture1();
			addChild( headPhoto );
			selectedStatusMc = new ResourceTeamWaitStatusEffect();
			addChild( selectedStatusMc );
			headPhoto.stop();
		}



	}

}
