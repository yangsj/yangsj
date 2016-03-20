package net.vyky.control.button
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import net.vyky.utils.VMovieClipUtils;
	
	
	/** 
	 * 说明：可以分别传入按钮的三个状态的显示对象，或者直接传入一个MovieClip包含三个状态标签显示对象<br>
	 * mouseOver  鼠标  移上的  状态<br>
	 * mouseOut   鼠标  移开的(正常)  状态<br>
	 * mouseDown  鼠标  选中的  状态<br>
	 * @author 杨胜金
	 * 2011-10-27 下午04:25:47
	 */
	public class VTabMovieClipButton extends Sprite
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var _mouseOverStatus:InteractiveObject;
		private var _mouseDownStatus:InteractiveObject;
		private var _mouseOutStatus:InteractiveObject;
		
		private var _targetButton:InteractiveObject;
		private var isClickDown:Boolean = false;
		
		public var type:String = "";
		
		/**
		 * mouseOver  鼠标  移上的  状态<br>
		 * mouseOut   鼠标  移开的(正常)  状态<br>
		 * mouseDown  鼠标  选中的  状态<br>
		 */
		public function VTabMovieClipButton()
		{
			super();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.mouseEnabled = true;
			addAndRemoveEvents(true);
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function start():void
		{
			forbiddenEnabled();
		}
		
		public function setVisibleFromStatus($type:String):void
		{	
			isClickDown = $type == VTabButtonType.TYPE_MOUSEDOWN;
			if (targetButton)
			{
				if (VMovieClipUtils.hasFrameLabel(MovieClip(targetButton), $type))
				{
					MovieClip(targetButton).gotoAndStop($type);
				}
				
				targetButton["buttonMode"] = !isClickDown;
				
				return ;
			}
			
			switch ($type)
			{
				case VTabButtonType.TYPE_MOUSEDOWN:
					mouseDownStatus.visible = true;
					mouseOutStatus.visible = false;
					mouseOverStatus.visible = false;
					break;
				case VTabButtonType.TYPE_MOUSEOUT:
					mouseDownStatus.visible = false;
					mouseOutStatus.visible = true;
					mouseOverStatus.visible = false;
					break;
				case VTabButtonType.TYPE_MOUSEOVER:
					mouseDownStatus.visible = false;
					mouseOutStatus.visible = false;
					mouseOverStatus.visible = true;
					break;
			}
			this.buttonMode = !isClickDown;
		}
		
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
		public function set mouseOverStatus(value:InteractiveObject):void
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
		public function set mouseDownStatus(value:InteractiveObject):void
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
		public function set mouseOutStatus(value:InteractiveObject):void
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
		
		/**
		 * @private
		 */
		public function set targetButton(value:InteractiveObject):void
		{
			_targetButton = value;
			if (value)
			{
				if (value is MovieClip)
				{
					value.mouseEnabled = true;
					value["mouseChildren"] = false;
					value["buttonMode"] = true;
					if (VMovieClipUtils.hasFrameLabels(MovieClip(value), VTabButtonType.TYPE_MOUSEDOWN, VTabButtonType.TYPE_MOUSEOUT, VTabButtonType.TYPE_MOUSEOVER))
					{
						MovieClip(value).gotoAndStop(VTabButtonType.TYPE_MOUSEOUT);
					}
				}
				else
				{
					throw new Error("该对象不是MovieClip类型，请再试...");
				}
				addAndRemoveEvents(true);
			}
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		/**
		 * 仅用 状态对象的 mouseEnabled 和 mouseChildren 属性
		 */
		private function forbiddenEnabled():void
		{
			if (mouseOverStatus) 
			{
				mouseOverStatus.mouseEnabled = false;
				if (mouseOverStatus.hasOwnProperty("mouseChildren"))
				{
					mouseOverStatus["mouseChildren"] = false;
				}
				mouseOverStatus.visible = false;
				this.addChild(mouseOverStatus);
				mouseOverStatus.x = mouseOverStatus.y = 0;
			}
			if (mouseOutStatus) 
			{
				mouseOutStatus.mouseEnabled = false;
				if (mouseOutStatus.hasOwnProperty("mouseChildren"))
				{
					mouseOutStatus["mouseChildren"] = false;
				}
				mouseOutStatus.visible = true;
				this.addChild(mouseOutStatus);
				mouseOutStatus.x = mouseOutStatus.y = 0;
			}
			if (mouseDownStatus) 
			{
				mouseDownStatus.mouseEnabled = false;
				if (mouseDownStatus.hasOwnProperty("mouseChildren"))
				{
					mouseDownStatus["mouseChildren"] = false;
				}
				mouseDownStatus.visible = false;
				this.addChild(mouseDownStatus);
				mouseDownStatus.x = mouseDownStatus.y = 0;
			}
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addAndRemoveEvents(isAdd:Boolean):void
		{
			if (isAdd)
			{
				if (targetButton)
				{
					targetButton.addEventListener(MouseEvent.CLICK, clickHandler);
					targetButton.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
					targetButton.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
				}
				else
				{
					this.addEventListener(MouseEvent.CLICK, clickHandler);
					this.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
					this.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
				}
			}
			else 
			{
				if (targetButton)
				{
					targetButton.removeEventListener(MouseEvent.CLICK, clickHandler);
					targetButton.removeEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
					targetButton.removeEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
				}
				else
				{
					this.removeEventListener(MouseEvent.CLICK, clickHandler);
					this.removeEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
					this.removeEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
				}
			}
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			if (isClickDown) return ;
			setVisibleFromStatus(VTabButtonType.TYPE_MOUSEDOWN);
			
			var evt:VTabButtonEvent = new VTabButtonEvent(VTabButtonEvent.TYPE_TARGET_CLICK);
			evt.clickBtn = this;
			DisplayObject(e.target.parent).dispatchEvent(evt);
		}
		
		private function mouseHandler(e:MouseEvent):void
		{
			if (isClickDown) return ;
			setVisibleFromStatus(e.type);
		}
		
	}
	
}