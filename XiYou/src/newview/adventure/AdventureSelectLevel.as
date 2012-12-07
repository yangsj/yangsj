package newview.adventure
{

	import com.greensock.TweenMax;

	import datas.EctypalData;
	import datas.TeamInfoData;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.filters.DisplacementMapFilter;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.getDefinitionByName;

	import global.Global;

	import manager.ui.UIMainManager;

	import newview.navi.MainNaviView;

	import ui.adventure.ResourceViewScenarioInfo_0;

	import utils.BitmapUtils;
	import utils.FunctionUtils;

	import view.battle.BattleView;


	/**
	 * 说明：EctypalSelectLevel
	 * @author Victor
	 * 2012-10-1
	 */

	public class AdventureSelectLevel extends Sprite
	{
		private const RES_LINAKGE_PREFIX : String = "ui.adventure.ResourceViewScenarioInfo_";

		private var child : Sprite;
		private var isPrev : Boolean = false;
		private var index : int = 0;
		private var isLast : Boolean = true;
		private var isFrist : Boolean = true;

		public var thisParent : DisplayObjectContainer;
		public var currentEctypalID : int = EctypalData.currentEctypalID;
		public var btnPrev : InteractiveObject;
		public var btnNext : InteractiveObject;

		public function AdventureSelectLevel()
		{
			super();
		}

		public function initialization() : void
		{
			if ( currentEctypalID == EctypalData.DEFAULT_ECTYPAL_ID )
			{
				if ( EctypalData.currentEctypalID != EctypalData.DEFAULT_ECTYPAL_ID )
					index = EctypalData.ectypalDataArrayID.indexOf( EctypalData.currentEctypalID );
				else
					index = 0;
				currentEctypalID = EctypalData.ectypalDataArrayID[ index ];
			}

			index = EctypalData.ectypalDataArrayID.indexOf( currentEctypalID );

			createResource();
			initLayoutItemData();
			addEvents();
		}

		private function addEvents() : void
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;

			addEventListener( MouseEvent.CLICK, onClickHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			if ( thisParent )
				thisParent.addEventListener( TransformGestureEvent.GESTURE_SWIPE, gestureSwipeHandler );
			if ( btnPrev )
				btnPrev.addEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
			if ( btnNext )
				btnNext.addEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );

		}

		private function removeEvents() : void
		{
			Multitouch.inputMode = MultitouchInputMode.NONE;
			removeEventListener( MouseEvent.CLICK, onClickHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			if ( thisParent )
				thisParent.removeEventListener( TransformGestureEvent.GESTURE_SWIPE, gestureSwipeHandler );
			if ( btnPrev )
				btnPrev.removeEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
			if ( btnNext )
				btnNext.removeEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
		}

		protected function mouseHandler( event : MouseEvent ) : void
		{
			var target : InteractiveObject = event.target as InteractiveObject;
			if ( target == btnPrev )
			{
				index--;
				isPrev = true;
				pageContent();
			}
			else if ( target == btnNext )
			{
				index++;
				isPrev = false;
				pageContent();
			}
		}

		protected function gestureSwipeHandler( event : TransformGestureEvent ) : void
		{
			var offsetX : Number = event.offsetX;
			if ( offsetX == -1 ) // next
			{
				if ( isLast )
					return;
				index++;
				isPrev = false;
				pageContent();
			}
			else if ( offsetX == 1 ) // prev
			{
				if ( isFrist )
					return;
				index--;
				isPrev = true;
				pageContent();
			}
		}

		protected function onClickHandler( event : MouseEvent ) : void
		{
			var target : MovieClip = event.target as MovieClip;
			if ( target )
			{
				var levelItem : AdventureLevelItem = target[ "levelItem" ] as AdventureLevelItem;
				if ( levelItem )
					gotoBattle( levelItem );
				levelItem = null;
			}
			target = null;
		}

		protected function removedFromStageHandler( event : Event ) : void
		{
			clear();
		}

		private function clear() : void
		{
			removeEvents();
			btnPrev = null;
			btnNext = null;
		}

		private function createResource() : void
		{
			child = ( new ( getDefinitionByName( RES_LINAKGE_PREFIX + 0 ) as Class )()) as Sprite;
			addChild( child );
			child.mouseEnabled = false;
		}

		private function initLayoutItemData() : void
		{
			EctypalData.currentEctypalID = currentEctypalID;
			var array : Array = EctypalData.getCurrentEctypalData( currentEctypalID );
			var object : Object;
			if ( array == null )
			{
				array = EctypalData.getDefaultEctypalData( currentEctypalID );
				EctypalData.setCurrentEctypalData( array );
			}
			var boolean : Boolean = true;
			var item : AdventureLevelItem;
			for each ( object in array )
			{
				item = AdventureLevelItem.create();
				item.data = object;
				item.target = child[ "level_" + item.getLevel ] as MovieClip;
				item.initialization();
				if ( boolean == true )
					boolean = item.isUnlocked;
			}
			btnNext.visible = boolean;
			btnPrev.visible = ( index != 0 );
			isFrist = ( index == 0 );
			isLast = !boolean;

			BitmapUtils.cacheAsBitmap( child );
		}

		/**
		 * 进入战斗系统
		 * @param item
		 *
		 */
		private function gotoBattle( item : AdventureLevelItem ) : void
		{
			if ( item ) // 设置当前战斗的关卡号 
				EctypalData.currentLevel = item.getLevel;
			else // 未选择任何关卡，设置为默认值 
				EctypalData.setDefaultCurrentLevel();

			if ( item )
				TeamInfoData.enemyerTeams = AdventureBattleEnemyerTeams.getEnemyerTeams( item.teamId );

			MainNaviView.instance.openUIMainPage( BattleView );
			MainNaviView.instance.hide();
		}

		private function pageContent() : void
		{
			Global.stage.mouseChildren = false;
			currentEctypalID = EctypalData.ectypalDataArrayID[ index ];
			var tempChild : DisplayObject = child;
			var endOutX : Number = isPrev ? Global.stageWidth : -Global.stageWidth;
			initialization();
			child.x = isPrev ? -Global.stageWidth : Global.stageWidth;
			FunctionUtils.removeChild( tempChild as DisplayObjectContainer );
			addChild( tempChild );
			TweenMax.to( tempChild, 0.6, { x: endOutX, onComplete: tweenOnComplete, onCompleteParams: [ tempChild, true ]});
			TweenMax.to( child, 0.6, { x: 0, onComplete: tweenOnComplete, onCompleteParams: [ child, false ]});
		}

		private function tweenOnComplete( childParams : DisplayObject, isOut : Boolean = false ) : void
		{
			Global.stage.mouseChildren = true;
			TweenMax.killTweensOf( childParams );
			if ( isOut )
				FunctionUtils.removeChild( childParams as DisplayObjectContainer );
		}

		private function importResource() : void
		{
			ui.adventure.ResourceViewScenarioInfo_0;
		}


	}

}
