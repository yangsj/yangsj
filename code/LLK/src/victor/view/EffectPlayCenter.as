package victor.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import ui.components.UIReadyGoAnimation;
	import ui.components.UITimeupAnimation;
	import ui.components.UIWordEffect;
	import ui.componets.UICombNumberSkin;
	import ui.componets.UIWordSkinGood;
	
	import victor.GameStage;
	import victor.utils.DisplayUtil;
	import victor.utils.MovieClipUtil;
	import victor.utils.NumberUtil;
	import victor.utils.safetyCall;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-5
	 */
	public class EffectPlayCenter extends Sprite
	{
		public function EffectPlayCenter()
		{
			super();
		}

		private static var _instance:EffectPlayCenter;

		public static function get instance():EffectPlayCenter
		{
			if ( _instance == null )
				_instance = new EffectPlayCenter();
			return _instance;
		}
		
		private function get wordEffectSkin():MovieClip
		{
			var mc:MovieClip = new UIWordEffect();
			mc.x = GameStage.stageWidth >> 1;
			mc.y = GameStage.stageHeight >> 1;
			GameStage.adjustScaleXY(mc);
			addChild(mc);
			return mc;
		}

		public function playGoodWords( callBack:Function = null ):void
		{
			var mc:MovieClip = wordEffectSkin;
			var word:Sprite = new UIWordSkinGood();
			var container:Sprite = mc.container;
			container.removeChildren();
			container.addChild(word);
			mc.y -= 50;
			MovieClipUtil.playMovieClip(mc, complete, mc);
			function complete( mc:MovieClip ):void
			{
				DisplayUtil.removedFromParent( mc );
				safetyCall( callBack );
			}
		}

		public function playCombWords( comb:int, callBack:Function = null ):void
		{
			var combNum:Sprite = NumberUtil.createNumSprite( comb );
			combNum.x = 25;
			combNum.y = -combNum.height >> 1;
			var mc:MovieClip = new UICombNumberSkin();
			mc.con.addChild( combNum );
			mc.x = GameStage.stageWidth >> 1;
			mc.y = GameStage.stageHeight >> 1;
			addChild( mc );
			GameStage.adjustScaleXY( mc );
			MovieClipUtil.playMovieClip( mc, complete, mc );
			function complete( mc:MovieClip ):void
			{
				DisplayUtil.removedFromParent( mc );
				safetyCall( callBack );
			}
		}

		public function playReadyGo( callBack:Function = null ):void
		{
			var mc:MovieClip = new UIReadyGoAnimation();
			mc.x = GameStage.stageWidth >> 1;
			mc.y = GameStage.stageHeight >> 1;
			addChild( mc );
			GameStage.adjustScaleXY( mc );
			MovieClipUtil.playMovieClip( mc, complete, mc );
			function complete( mc:MovieClip ):void
			{
				DisplayUtil.removedFromParent( mc );
				safetyCall( callBack );
			}
		}

		public function playTimeup( callBack:Function = null ):void
		{
			var mc:MovieClip = new UITimeupAnimation();
			mc.x = GameStage.stageWidth >> 1;
			mc.y = GameStage.stageHeight >> 1;
			addChild( mc );
			GameStage.adjustScaleXY( mc );
			MovieClipUtil.playMovieClip( mc, complete );
			function complete():void
			{
				DisplayUtil.removedFromParent( mc );
				safetyCall( callBack );
			}
		}


	}
}
