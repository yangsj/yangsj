package newview.intensify
{
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import newview.ShowAreaBase;


	/**
	 * 说明：IntensifyShowArea
	 * @author Victor
	 * 2012-11-20
	 */

	public class IntensifyShowArea extends ShowAreaBase
	{

		public function IntensifyShowArea( container : DisplayObjectContainer )
		{
			showRect = new Rectangle(270, 340, 537, 377);
			super(container);
		}


	}

}
