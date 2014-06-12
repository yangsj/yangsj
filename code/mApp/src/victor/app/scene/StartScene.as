package victor.app.scene
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import victor.app.Main;
	import victor.framework.constant.ScreenType;
	import victor.framework.constant.TransitionType;
	import victor.framework.core.AutoLayout;
	import victor.framework.core.Instance;
	import victor.framework.core.Scene;
	import victor.framework.utils.Display;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2014-6-13
	 */
	public class StartScene extends Scene
	{
		private var uiSetting:UI_Setting;
		private var timeNum:int = 4;
		private var countTotal:int = 10;
		private var countCur:int = 1;
		private var isRunning:Boolean = false;
		private var count:int = 0;

		public function StartScene()
		{
		}

		override public function dispose():void
		{
			uiSetting.removeEventListener( MouseEvent.CLICK, uiSettingClickHandler );
			uiSetting = null;

			super.dispose();
		}

		override protected function transitionInComplete():void
		{
			super.transitionInComplete();
			timeNum = 4;
			count = 0;
			countCur = 0;
			countTotal = 10;
			setTextTimeString();
		}

		private function setTextTimeString():void
		{
			timeNum = Math.max( 4, timeNum );
			timeNum = Math.min( 99, timeNum );
			uiSetting.txtNum.text = timeNum + "";

			countTotal = Math.max( 10, countTotal );
			countTotal = Math.min( 999, countTotal );
			uiSetting.txtNum2.text = countTotal + "";
		}

		override protected function createUI():void
		{
			uiSetting = new UI_Setting();
			addChild( uiSetting );
			AutoLayout.layout( uiSetting );
			
			timeNum = 4;
			count = 0;
			countCur = 0;
			countTotal = 10;
			setTextTimeString();

			uiSetting.addEventListener( MouseEvent.CLICK, uiSettingClickHandler );
		}

		protected function uiSettingClickHandler( event:MouseEvent ):void
		{
			var target:InteractiveObject = event.target as InteractiveObject;
			if ( target == uiSetting.btnBack )
			{
				TweenLite.killDelayedCallsTo( onStartTime );
				Instance.getSceneInstance( Main ).transitionIn( TransitionType.RIGHT_LEFT );
			}
			else if ( target == uiSetting.btnGo && !isRunning )
			{
				isRunning = true;
				onStartTime();
			}
			else if ( target == uiSetting.btnPrev && !isRunning )
			{
				timeNum--;
				setTextTimeString();
			}
			else if ( target == uiSetting.btnNext && !isRunning )
			{
				timeNum++;
				setTextTimeString();
			}
			else if ( target == uiSetting.btnPrev2 && !isRunning )
			{
				countTotal--;
				setTextTimeString();
			}
			else if ( target == uiSetting.btnNext2 && !isRunning )
			{
				countTotal++;
				setTextTimeString();
			}
		}

		private function onStartTime():void
		{
			if ( countCur >= countTotal )
			{
				isRunning = false;
				return;
			}
			var n1:int = timeNum * 1;
			var n2:int = timeNum * 4;
			var n3:int = timeNum * 2;
			var yushu:int = count % ( n1 + n2 + n3 );
			var sprite:Sprite;
			if ( yushu < n1 )
			{
				if ( yushu == 0 )
				{
					countCur++;
					sprite = getWordSprite( 0 );
				}
				else
				{
					sprite = createNum( yushu );
				}
			}
			else if ( yushu < n1 + n2 )
			{
				if ( yushu == n1 )
				{
					sprite = getWordSprite( 1 );
				}
				else
				{
					sprite = createNum( yushu - n1 );
				}
			}
			else
			{
				if ( yushu == n1 + n2 )
				{
					sprite = getWordSprite( 2 );
				}
				else
				{
					sprite = createNum( yushu - n1 - n2 );
				}
			}
			
			addChild( sprite );

			var sx:Number = ScreenType.screenWidth * 0.5;
			var sy:Number = ScreenType.screenHeight * 0.5;
			var ex:Number = sx - sprite.width * 0.5;
			var ey:Number = sy - sprite.height * 0.5;
			sprite.x = sx;
			sprite.y = sy;
			sprite.scaleX = 0.01;
			sprite.scaleY = 0.01;
			TweenLite.to( sprite, 0.9, { x: ex, y: ey, scaleX: 1, scaleY: 1, onComplete: function( sprite:Sprite ):void
			{
				Display.removedFromParent( sprite );
			}, onCompleteParams:[sprite] });
			
			TweenLite.delayedCall( 1, onStartTime );

			count++;
		}

		private function createNum( num:int ):Sprite
		{
			var con:Sprite = new Sprite();
			var arr:Array = num.toString().split( "" );
			var mc:DisplayObject;
			for ( var i:int = 0; i < arr.length; i++ )
			{
				mc = con.addChild( getNumSprite( int( arr[ i ])));
				mc.x = mc.width * i;
			}
			return con;
		}

		private function getNumSprite( num:int ):Sprite
		{
			switch ( num )
			{
				case 0:
					return new N0();
					break;
				case 1:
					return new N1();
					break;
				case 2:
					return new N2();
					break;
				case 3:
					return new N3();
					break;
				case 4:
					return new N4();
					break;
				case 5:
					return new N5();
					break;
				case 6:
					return new N6();
					break;
				case 7:
					return new N7();
					break;
				case 8:
					return new N8();
					break;
				case 9:
					return new N9();
					break;
			}
			return new Sprite();
		}

		private function getWordSprite( num:int ):Sprite
		{
			switch ( num )
			{
				case 0:
					return new W0();
					break;
				case 1:
					return new W1();
					break;
				case 2:
					return new W2();
					break;
			}
			return new Sprite();
		}

	}
}