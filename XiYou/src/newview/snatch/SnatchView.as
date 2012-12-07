package newview.snatch
{

	import newview.SpriteBase;

	import ui.snatch.ResourceSnatchView;


	/**
	 * 说明：SnatchView
	 * @author Victor
	 * 2012-11-14
	 */

	public class SnatchView extends SpriteBase
	{

		private var snatchView : ResourceSnatchView;

		public function SnatchView()
		{
			super();
		}

		override protected function createResource() : void
		{
			snatchView = new ResourceSnatchView();
			addChild( snatchView );
		}



	}

}
