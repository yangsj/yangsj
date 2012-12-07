package newview.adventure
{

	import com.greensock.TweenMax;

	import datas.EctypalData;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;

	import level.Dungeon1;
	import level.Dungeon2;
	import level.Dungeon3;
	import level.Wave;

	import manager.ui.UIMainManager;

	import newview.SpriteBase;

	import ui.adventure.ResourceAdventureBackground;
	import ui.adventure.ResourceAdventureView;
	import ui.resource.ectypal.ResourceEctypalView;

	import utils.BitmapUtils;
	import utils.FunctionUtils;
	import utils.Numeric;
	import utils.TextFieldTyper;

	import view.ViewBase;
	import view.battle.BattleView;


	/**
	 * 说明：EctypalView
	 * @author Victor
	 * 2012-10-1
	 */

	public class AdventureView extends SpriteBase
	{
		private var adventureBground : Sprite;
		private var adventureView : ResourceAdventureView;
		private var adventureSelectLevel : AdventureSelectLevel;


		public function AdventureView()
		{
			super();
		}

		override protected function createResource() : void
		{
			adventureBground = new ResourceAdventureBackground();
			addChild( adventureBground );

			adventureView = new ResourceAdventureView();
			addChild( adventureView );

			adventureSelectLevel = new AdventureSelectLevel();
			adventureSelectLevel.thisParent = this;
			adventureSelectLevel.btnPrev = adventureView.btnPrev;
			adventureSelectLevel.btnNext = adventureView.btnNext;
			adventureSelectLevel.initialization();
			adventureView.container.addChild( adventureSelectLevel );

			adventureBground.mouseChildren = adventureBground.mouseEnabled = false;
			BitmapUtils.cacheAsBitmap( adventureBground );
		}

		override protected function clear() : void
		{
			adventureView = null;
			adventureSelectLevel = null;
			AdventureLevelItem.dispose();
		}


	}

}
