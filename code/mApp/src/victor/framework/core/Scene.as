package victor.framework.core
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import victor.framework.constant.TransitionType;
	import victor.framework.interfaces.IScene;
	import victor.framework.utils.apps;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2014-6-12
	 */
	public class Scene extends Sprite implements IScene
	{
		private static var _curScene:IScene;

		/**
		 * 获取当前场景
		 */
		public static function get curScene():IScene
		{
			return _curScene;
		}

		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/

		private const TRANSITION_TIME:Number = 0.5;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function Scene()
		{
			super();
			createUI();
		}

		protected function createUI():void
		{
		}

		final public function transitionIn( transitionType:int = TransitionType.DEFUALT ):void
		{
			ViewStruct.addChild( this, ViewStruct.SCENE );

			if ( _curScene )
			{
				trace( "------------------TransitionType：" + transitionType );
				apps.mouseChildren = false;
				switch( transitionType )
				{
					case TransitionType.LEFT_RIGHT:
						this.x = -apps.fullScreenWidth;
						TweenLite.to( this, TRANSITION_TIME, { x: 0, ease: Linear.easeNone, onComplete: complete });
						break;
					case TransitionType.RIGHT_LEFT:
						this.x = apps.fullScreenWidth;
						TweenLite.to( this, TRANSITION_TIME, { x: 0, ease: Linear.easeNone, onComplete: complete });
						break;
					case TransitionType.UP_DOWN:
						this.y = -apps.fullScreenHeight;
						TweenLite.to( this, TRANSITION_TIME, { y: 0, ease: Linear.easeNone, onComplete: complete });
						break;
					case TransitionType.DOWN_UP:
						this.y = apps.fullScreenHeight;
						TweenLite.to( this, TRANSITION_TIME, { y: 0, ease: Linear.easeNone, onComplete: complete });
						break;
					default:
						this.alpha = 0;
						TweenLite.to( this, TRANSITION_TIME, { alpha: 1, ease: Linear.easeNone, onComplete: complete });
						break;
				}
				_curScene.transitionOut( transitionType );
			}
			else
			{
				complete();
			}
			
			function complete():void
			{
				apps.mouseChildren = true;
				transitionInComplete();
			}
			_curScene = this;
		}

		protected function transitionInComplete():void
		{
		}

		final public function transitionOut( transitionType:int = TransitionType.DEFUALT ):void
		{
			switch( transitionType )
			{
				case TransitionType.LEFT_RIGHT:
					TweenLite.to( this, TRANSITION_TIME, { x: apps.fullScreenWidth, ease: Linear.easeNone, onComplete: complete, onCompleteParams:[this] });
					break;
				case TransitionType.RIGHT_LEFT:
					TweenLite.to( this, TRANSITION_TIME, { x:-apps.fullScreenWidth, ease: Linear.easeNone, onComplete: complete, onCompleteParams:[this] });
					break;
				case TransitionType.UP_DOWN:
					TweenLite.to( this, TRANSITION_TIME, { y: apps.fullScreenHeight, ease: Linear.easeNone, onComplete: complete, onCompleteParams:[this] });
					break;
				case TransitionType.DOWN_UP:
					TweenLite.to( this, TRANSITION_TIME, { y:-apps.fullScreenHeight, ease: Linear.easeNone, onComplete: complete, onCompleteParams:[this] });
					break;
				default:
					TweenLite.to( this, TRANSITION_TIME, { alpha: 0, ease: Linear.easeNone, onComplete: complete, onCompleteParams:[this] });
					break;
			}
			
			function complete( displayObject:DisplayObject ):void
			{
				ViewStruct.removeChild( displayObject );
				transitionOutComplete();
				clear();
			}
		}

		protected function transitionOutComplete():void
		{
		}
		
		protected function clear():void
		{
		}

		public function dispose():void
		{
			clear();
		}


	}
}
