package newview.intensify
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	import newview.equip.EquipListItem;

	import ui.intensify.ResourceIntensifyListItem1;
	import ui.weapon.ResourceIconBackground;
	import ui.weapon.ResourceWeaponIcons;


	/**
	 * 说明：IntensifyListItem1 装备信息列表item
	 * @author Victor
	 * 2012-11-20
	 */

	public class IntensifyListItem1 extends IntensifyListItemBase
	{
		private const WIDTH : Number = 66;

		private var child : ResourceIntensifyListItem1;

		protected var iconBg : MovieClip;
		protected var iconChild : MovieClip;

		public function IntensifyListItem1()
		{
			super();
		}

		override protected function createResource() : void
		{
			child = new ResourceIntensifyListItem1();
			addChild( child );

			iconBg = new ResourceIconBackground();
			iconChild = new ResourceWeaponIcons();
			child.container.addChild( iconBg );
			child.container.addChild( iconChild );
			child.container.width = child.container.height = WIDTH;

			item = child as MovieClip;
		}

		override protected function addedToStageHandler( event : Event ) : void
		{
			super.addedToStageHandler( event );

			if ( child )
			{
				child.iconStar.gotoAndStop( getStar );
				child.txtLevel.text = getLevel + "";
				child.txtName.text = getName + "";

				if ( iconBg )
					iconBg.gotoAndStop( getStar );
				if ( iconChild )
					iconChild.gotoAndStop( "lab_" + getResID );
			}
		}

		override public function get listType() : int
		{
			return IntensifyType.INFO_LIST_EQUIP;
		}



	}

}
