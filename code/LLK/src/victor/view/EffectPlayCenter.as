package victor.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	import ui.components.UIReadyGoAnimation;
	import ui.components.UISuccessAccessAllGuanQia;
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
		private static var _instance:EffectPlayCenter;

		private var _wordEffectSkin:MovieClip;

		public function EffectPlayCenter()
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}

		public static function get instance():EffectPlayCenter
		{
			if ( _instance == null )
				_instance = new EffectPlayCenter();
			return _instance;
		}

		public function playGoodWords( callBack:Function = null ):void
		{
			var mc:MovieClip = wordEffectSkin;
			var word:Sprite = new UIWordSkinGood();
			var container:Sprite = mc.container;
			container.removeChildren();
			container.addChild( word );
			mc.y -= 50;
			addChild( mc );
			playMovieClip( mc, callBack );
		}

		/**
		 * 播放连击次数动画
		 * @param comb
		 * @param callBack
		 */
		public function playCombWords( comb:int, callBack:Function = null ):void
		{
			var mc:MovieClip = new UICombNumberSkin();
			var combNum:Sprite = NumberUtil.createNumSprite( comb );
			combNum.x = 25;
			combNum.y = -combNum.height >> 1;
			mc.con.addChild( combNum );
			centerPlayMovieClip( mc, callBack );
		}

		/**
		 * 播放ReadyGO动画
		 * @param callBack
		 */
		public function playReadyGo( callBack:Function = null ):void
		{
			var mc:MovieClip = new UIReadyGoAnimation();
			centerPlayMovieClip( mc, callBack );
		}

		/**
		 * 时间倒计时结束动画
		 * @param callBack
		 */
		public function playTimeup( callBack:Function = null ):void
		{
			var mc:MovieClip = new UITimeupAnimation();
			centerPlayMovieClip( mc, callBack );
		}

		/**
		 * 完成所有关卡动画提示
		 */
		public function playSuccessAccessAllGuanQia():void
		{
			var mc:MovieClip = new UISuccessAccessAllGuanQia();
			centerToStage( mc );
		}

		//************ private functions **************

		/**
		 * 将mc放到舞台中间，并播放动画
		 * @param mc
		 * @param callBack
		 */
		private function centerPlayMovieClip( mc:MovieClip, callBack:Function = null ):void
		{
			centerToStage( mc );
			playMovieClip( mc, callBack );
		}

		/**
		 * 将mc添加到舞台中间显示
		 * @param mc
		 */
		private function centerToStage( mc:MovieClip ):void
		{
			mc.x = GameStage.stageWidth >> 1;
			mc.y = GameStage.stageHeight >> 1;
			addChild( mc );
			GameStage.adjustScaleXY( mc );
		}

		/**
		 * 播放mc动画
		 * @param mc
		 * @param callBack
		 */
		private function playMovieClip( mc:MovieClip, callBack:Function = null ):void
		{
			MovieClipUtil.playMovieClip( mc, complete );
			function complete():void
			{
				DisplayUtil.removedFromParent( mc );
				safetyCall( callBack );
			}
		}

		/**
		 * 文字播放动画效果模版动画
		 */
		private function get wordEffectSkin():MovieClip
		{
			if ( _wordEffectSkin == null )
			{
				_wordEffectSkin = new UIWordEffect();
				centerToStage( _wordEffectSkin );
			}
			return _wordEffectSkin;
		}

	}
}
