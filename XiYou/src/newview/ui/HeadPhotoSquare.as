package newview.ui
{

	import flash.display.Sprite;

	import ui.team.ResourceTeamAllRoleHeadPicture2;
	import ui.team.ResourceTeamSelectedStatusEffect;


	/**
	 * 说明：HeadPhotoSquare
	 * @author Victor
	 * 2012-11-19
	 */

	public class HeadPhotoSquare extends HeadPhotoBase
	{


		public function HeadPhotoSquare()
		{
			super();
		}

		override protected function createResource() : void
		{
			headPhoto = new ResourceTeamAllRoleHeadPicture2();
			addChild( headPhoto );
			selectedStatusMc = new ResourceTeamSelectedStatusEffect();
			addChild( selectedStatusMc );
			headPhoto.stop();
		}


	}

}
