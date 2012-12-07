package newview.equip
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import newview.ShowAreaBase;


	/**
	 * 说明：EquipShowInfo
	 * @author Victor
	 * 2012-11-19
	 */

	public class EquipShowArea extends ShowAreaBase
	{

		public function EquipShowArea( container : DisplayObjectContainer )
		{
			showRect = new Rectangle(275, 445, 560, 470);
			super(container);
		}

	}

}
