package pet.game.panels.continuousLanding.control.tabbutton
{

	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import pet.game.panels.continuousLanding.control.YsjMovieClipUtils;


	/**
	 * 说明：可以分别传入按钮的三个状态的显示对象，或者直接传入一个MovieClip包含三个状态标签显示对象<br>
	 * mouseOver  鼠标  移上的  状态<br>
	 * mouseOut   鼠标  移开的(正常)  状态<br>
	 * mouseDown  鼠标  选中的  状态<br>
	 * @author yangshengjin
	 */
	public class YsjTabMovieClipButton extends Sprite
	{
		/////////////////////////////////////////vars /////////////////////////////////

		private var _mouseOverStatus:InteractiveObject;
		private var _mouseDownStatus:InteractiveObject;
		private var _mouseOutStatus:InteractiveObject;

		private var _targetButton:InteractiveObject;
		private var isClickDown:Boolean = false;

		public var type:String = "";
		public var data:Object;

		/**
		 * mouseOver  鼠标  移上的  状态<br>
		 * mouseOut   鼠标  移开的(正常)  状态<br>
		 * mouseDown  鼠标  选中的  状态<br>
		 */
		public function YsjTabMovieClipButton()
		{
			super();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.mouseEnabled = true;
		}

		/////////////////////////////////////////public /////////////////////////////////

		public function dispose():void
		{
			addAndRemoveEvents( false, targetButton ? targetButton : this );
			_mouseOverStatus = null;
			_mouseDownStatus = null;
			_mouseOutStatus = null;
			_targetButton = null;
			data = null;
		}

		public function start():void
		{
			forbiddenEnabled( mouseDownStatus );
			forbiddenEnabled( mouseOverStatus );
			forbiddenEnabled( mouseOutStatus, true );
			addAndRemoveEvents( true, targetButton ? targetButton : this );
		}

		public function setVisibleFromStatus( $type:String ):void
		{
			isClickDown = $type == YsjTabButtonType.TYPE_MOUSEDOWN;
			if ( targetButton )
			{
				if ( YsjMovieClipUtils.hasFrameLabel( targetButton as MovieClip, $type ))
					MovieClip( targetButton ).gotoAndStop( $type );
				targetButton[ "buttonMode" ] = !isClickDown;

				return;
			}

			mouseDownStatus.visible = $type == YsjTabButtonType.TYPE_MOUSEDOWN;
			mouseOutStatus.visible = $type == YsjTabButtonType.TYPE_MOUSEOUT;
			mouseOverStatus.visible = $type == YsjTabButtonType.TYPE_MOUSEOVER;

			this.buttonMode = !isClickDown;
		}

		/**
		 * @private
		 */
		public function set targetButton( value:InteractiveObject ):void
		{
			_targetButton = value;
			if ( value )
			{
				if ( value is MovieClip )
				{
					value.mouseEnabled = true;
					value[ "mouseChildren" ] = false;
					value[ "buttonMode" ] = true;
					if ( YsjMovieClipUtils.hasFrameLabels( value as MovieClip, YsjTabButtonType.TYPE_MOUSEDOWN, YsjTabButtonType.TYPE_MOUSEOUT, YsjTabButtonType.TYPE_MOUSEOVER ))
					{
						MovieClip( value ).gotoAndStop( YsjTabButtonType.TYPE_MOUSEOUT );
					}
				}
				else
				{
					throw new Error( "该对象不是MovieClip类型，请再试..." );
				}
				addAndRemoveEvents( true, targetButton );
			}
		}

		/////////////////////////////////////////private ////////////////////////////////

		/**
		 * 仅用 状态对象的 mouseEnabled 和 mouseChildren 属性
		 */
		private function forbiddenEnabled( target:InteractiveObject = null, visible:Boolean = false ):void
		{
			if ( target )
			{
				target.mouseEnabled = false;
				if ( target.hasOwnProperty( "mouseChildren" ))
					target[ "mouseChildren" ] = false;
				target.visible = false;
				this.addChild( target );
				target.x = target.y = 0;
			}
		}

		/////////////////////////////////////////events//////////////////////////////////

		private function addAndRemoveEvents( isAdd:Boolean, target:InteractiveObject ):void
		{
			if ( isAdd )
			{
				target.addEventListener( MouseEvent.CLICK, clickHandler );
				target.addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
				target.addEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
//				if ( targetButton )
//				{
//					targetButton.addEventListener( MouseEvent.CLICK, clickHandler );
//					targetButton.addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
//					targetButton.addEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
//				}
//				else
//				{
//					this.addEventListener( MouseEvent.CLICK, clickHandler );
//					this.addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
//					this.addEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
//				}
			}
			else
			{
				target.removeEventListener( MouseEvent.CLICK, clickHandler );
				target.removeEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
				target.removeEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
//				if ( targetButton )
//				{
//					targetButton.removeEventListener( MouseEvent.CLICK, clickHandler );
//					targetButton.removeEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
//					targetButton.removeEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
//				}
//				else
//				{
//					this.removeEventListener( MouseEvent.CLICK, clickHandler );
//					this.removeEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
//					this.removeEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
//				}
			}
		}

		private function clickHandler( e:MouseEvent ):void
		{
			if ( isClickDown )
				return;
			setVisibleFromStatus( YsjTabButtonType.TYPE_MOUSEDOWN );

			var evt:YsjTabButtonEvent = new YsjTabButtonEvent( YsjTabButtonEvent.TYPE_TARGET_CLICK );
			evt.clickBtn = this;
			DisplayObject( e.target.parent ).dispatchEvent( evt );
		}

		private function mouseHandler( e:MouseEvent ):void
		{
			if ( isClickDown )
				return;
			setVisibleFromStatus( e.type );
		}

		///////////////// getter/setter ///////////////////

		/**
		 * 鼠标 <b>移动</b> 到按钮上的状态
		 */
		public function get mouseOverStatus():InteractiveObject
		{
			return _mouseOverStatus;
		}

		/**
		 * @private
		 */
		public function set mouseOverStatus( value:InteractiveObject ):void
		{
			_mouseOverStatus = value;
		}

		/**
		 * 鼠标在按钮上 <b>按下</b> 的状态
		 */
		public function get mouseDownStatus():InteractiveObject
		{
			return _mouseDownStatus;
		}

		/**
		 * @private
		 */
		public function set mouseDownStatus( value:InteractiveObject ):void
		{
			_mouseDownStatus = value;
		}

		/**
		 * 正常状态
		 */
		public function get mouseOutStatus():InteractiveObject
		{
			return _mouseOutStatus;
		}

		/**
		 * @private
		 */
		public function set mouseOutStatus( value:InteractiveObject ):void
		{
			_mouseOutStatus = value;
		}

		/**
		 * 需要设置的 对象
		 */
		public function get targetButton():InteractiveObject
		{
			return _targetButton;
		}

	}

}
