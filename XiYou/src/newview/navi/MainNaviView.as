package newview.navi
{
	import flash.media.SoundChannel;
	import sound.SoundResource;
	import sound.EmbededSound;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.events.TweenEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import global.Global;
	
	import manager.ui.UIMainManager;
	import manager.ui.UINaviManager;
	
	import newview.SpriteBase;
	import newview.adventure.AdventureView;
	import newview.equip.EquipView;
	import newview.fight.FightView;
	import newview.intensify.IntensifyView;
	import newview.shop.ShopView;
	import newview.snatch.SnatchView;
	import newview.team.TeamView;
	
	import ui.navi.ResourceNaviMenuView;
	
	import utils.BitmapUtils;


	/**
	 * 说明：MainNaviView
	 * @author Victor
	 * 2012-11-12
	 */

	public class MainNaviView extends SpriteBase
	{
		private static var _instance : MainNaviView;

		/** 冒险 */
		private const BTN_ADVENTURE_NAME : String = "btnAdventure";
		/** 组队 */
		private const BTN_TEAM_NAME : String = "btnTeam";
		/** 斗法 */
		private const BTN_FIGHT_NAME : String = "btnFight";
		/** 夺宝 */
		private const BTN_SNATCH_NAME : String = "btnSnatch";
		/** 商城 */
		private const BTN_SHOP_NAME : String = "btnShop";
		/** 装备 */
		private const BTN_EQUIP_NAME : String = "btnEquip";
		/** 强化 */
		private const BTN_INTENSIFY_NAME : String = "btnIntensify";


		private const BTN_ARRAY : Array = [ BTN_ADVENTURE_NAME, BTN_FIGHT_NAME, BTN_SHOP_NAME, BTN_SNATCH_NAME, BTN_TEAM_NAME, BTN_EQUIP_NAME, BTN_INTENSIFY_NAME ];

		private var naviView : ResourceNaviMenuView;
		private var btnMenuSelectedStatus : DisplayObject;
		private var currentTabName : String = "";
		private var backgroundSound  : SoundChannel;


		public function MainNaviView()
		{
			if ( _instance )
				throw new Error( "this is the Singleton Class, cannot create again!" );
			_instance = this;
		}

		override protected function createResource() : void
		{
			naviView = new ResourceNaviMenuView();
			addChild( naviView );
			btnMenuSelectedStatus = naviView.btnMenuSelectedStatus as DisplayObject;
		}

		override protected function addedToStageHandler( event : Event ) : void
		{
			super.addedToStageHandler( event );

			show();
		}

		override protected function mouseDownHandler( event : MouseEvent ) : void
		{
			super.mouseDownHandler( event );

			if ( BTN_ARRAY.indexOf( clickTargetName ) == -1 || currentTabName == clickTargetName )
				return;

			currentTabName = clickTargetName;
			var cls : Class;
			switch ( clickTargetName )
			{
				case BTN_ADVENTURE_NAME: // 冒险
					cls = AdventureView;
					break;
				case BTN_FIGHT_NAME: // 斗法
					cls = FightView;
					break;
				case BTN_SNATCH_NAME: // 夺宝
					cls = SnatchView;
					break;
				case BTN_TEAM_NAME: // 组队
					cls = TeamView;
					break;
				case BTN_INTENSIFY_NAME: // 强化
					cls = IntensifyView;
					break;
				case BTN_EQUIP_NAME: // 装备
					cls = EquipView;
					break;
				case BTN_SHOP_NAME: // 商城
					cls = ShopView;
					break;
			}
			openUIMainPage( cls );
		}

		private function tweenOutCompleteHandler( event : TweenEvent ) : void
		{
			var child : DisplayObject = event.target.target as DisplayObject;
			TweenMax.killTweensOf( child );
			if ( child && child.parent )
				child.parent.removeChild( child );
			child = null;
		}

		private function tweenInCompleteListener( event : TweenEvent ) : void
		{
			var child : DisplayObject = event.target.target as DisplayObject;
			TweenMax.killTweensOf( child );
			child.cacheAsBitmap = false;
			child.cacheAsBitmapMatrix = null;
			child = null;
			
			Global.stage.mouseChildren = true;
		}

		///////////////////////// private //////////////////////////////

		private function moveBtnMenuSelectedStatusObject( target : DisplayObject ) : void
		{
			if ( target == null )
				return;
			TweenMax.killTweensOf( btnMenuSelectedStatus );
			TweenMax.to( btnMenuSelectedStatus, 0.6, { x: target.x, ease: Back.easeOut, onComplete: function() : void
			{
				TweenMax.killTweensOf( btnMenuSelectedStatus );
			}});
		}

		///////////////////////// public ///////////////////////////////

		public function openUIMainPage( className : Class ) : void
		{
			var tabCurrent : DisplayObject = naviView[ clickTargetName ] as DisplayObject;
			moveBtnMenuSelectedStatusObject( tabCurrent );

			var tweenTime : Number = 0.8;
			var boo : Boolean = tabCurrent.x > btnMenuSelectedStatus.x;
			var endX_Out : Number = boo ? Global.stageWidth : -Global.stageWidth;
			var startxIn : Number = boo ? -Global.stageWidth : Global.stageWidth;
			var leng : int = UIMainManager.container.numChildren;
			var child : DisplayObject;
			Global.stage.mouseChildren = false;
			for ( var i : int = 0; i < leng; i++ )
			{
				child = UIMainManager.container.getChildAt( i );
				if ( child )
				{
					if ( child.parent )
						child.parent.removeChild( child );
					UIMainManager.container.addChild( child );
					BitmapUtils.cacheAsBitmap( child );
					TweenMax.killTweensOf( child );
//					TweenMax.to(child, tweenTime, {x:endX_Out, ease: Back.easeOut, onCompleteListener:tweenOutCompleteHandler});
					TweenMax.to( child, tweenTime, { x: endX_Out, onCompleteListener: tweenOutCompleteHandler });
				}
				child = null;
			}
			if ( className )
			{
				child = ( new className()) as DisplayObject;
				child.x = startxIn;
				BitmapUtils.cacheAsBitmap( child );
				UIMainManager.addChild( child );
//				TweenMax.to(child, tweenTime, {x:0, ease: Back.easeOut, onCompleteListener:tweenInCompleteListener});
				TweenMax.to( child, tweenTime, { x: 0, onCompleteListener: tweenInCompleteListener });
			}
		}

		public function show() : void
		{
			this.visible = true;
			if ( this.parent == null )
				UINaviManager.addChild( this );

			var dis : DisplayObject;
			if ( BTN_ARRAY.indexOf( currentTabName ) != -1 )
				dis = naviView[ currentTabName ] as DisplayObject;
			else
				dis = naviView.btnAdventure as DisplayObject;
			currentTabName = "";
			dis.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_DOWN ));
			if (backgroundSound)
				backgroundSound.stop();
			backgroundSound = EmbededSound.play(SoundResource.instance.background, 9999);
		}

		public function hide() : void
		{
			this.visible = false;
			backgroundSound.stop();
			trace('SOUND STOP');
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////

		public static function get instance() : MainNaviView
		{
			if ( _instance == null )
				new MainNaviView();
			return _instance;
		}

	}

}
