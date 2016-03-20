package net.vyky.control.button
{
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * 说明：ButtonManager<br>使用例：<br>
	 * var tabButton:TabButtonControl = new TabButtonControl();<br>
	 * tabButton.addEventListener(TabButtonEvent.BUTTON_EVENT_CLICK, tabButtonClickHandler);<br>
	 * tabButton.addTabMovieClip(target1, container, TAB_BUTTON_ONE, true);<br>
	 * private function tabButtonClickHandler(e:TabButtonEvent):void<br>
	 * {<br>
	 * switch(e.nameType)<br>
	 * {<br>
	 * case TAB_BUTTON_ONE:<br>
	 * doSomeThing();<br>
	 * break;<br>
	 * }<br>
	 * }<br>
	 * 编写：yangshengjin
	 * QQ729264471
	 * 2011-10-28 下午09:28:50
	 */
	
	public class VTabButtonControl extends EventDispatcher
	{
		private var container:DisplayObjectContainer;
		private var currentBtn:VTabMovieClipButton;
		
		public function VTabButtonControl()
		{
			
		}
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		/**
		 * 
		 * @param $clip 包含指定标签的MovieClip对象
		 * @param $parent $clip的父容器
		 * @param $type  用以 侦听 事件 区分按钮的 type
		 * @param $isCurrent 是否设置为当前默认的按钮
		 * 
		 */
		public function addTabMovieClip($clip:MovieClip, $parent:DisplayObjectContainer, $type:String, $isCurrent:Boolean = false):void
		{
			var btn:VTabMovieClipButton = new VTabMovieClipButton();
			btn.targetButton = $clip;
			btn.type = $type;
			container = $parent;
			
			addAndRemoveEvents(true);
			
			if ($isCurrent)
			{
				if (currentBtn) currentBtn.setVisibleFromStatus(VTabButtonType.TYPE_MOUSEOUT);
				currentBtn = btn;
				currentBtn.setVisibleFromStatus(VTabButtonType.TYPE_MOUSEDOWN);
				
				var evt:VTabButtonEvent = new VTabButtonEvent(VTabButtonEvent.BUTTON_EVENT_CLICK);
				evt.nameType = currentBtn.type;
				this.dispatchEvent(evt);
			}
		}
		
		/**
		 * 自定义三个状态
		 * @param $out 鼠标移出状态， 正常状态
		 * @param $over 鼠标移上时 状态
		 * @param $down 鼠标按下状态， 选中状态
		 * @param $container 按钮 添加到的 容器
		 * @param $x 按钮位置 x
		 * @param $y 按钮位置 y
		 * @param $type 用以 侦听 事件 区分按钮的 type
		 * @param isCurrent 是否设置为当前默认的按钮
		 * 
		 */
		public function addTabStatusClip($out:InteractiveObject, $over:InteractiveObject, $down:InteractiveObject, $container:DisplayObjectContainer, $x:Number, $y:Number, $type:String, $isCurrent:Boolean = false):void
		{
			var btn:VTabMovieClipButton = new VTabMovieClipButton();
			btn.mouseOutStatus = $out;
			btn.mouseOverStatus = $over;
			btn.mouseDownStatus = $down;
			btn.type = $type;
			btn.start();
			btn.x = $x;
			btn.y = $y;
			$container.addChild(btn);
			container = $container;
			
			addAndRemoveEvents(true);
			
			if ($isCurrent)
			{
				if (currentBtn) currentBtn.setVisibleFromStatus(VTabButtonType.TYPE_MOUSEOUT);
				currentBtn = btn;
				currentBtn.setVisibleFromStatus(VTabButtonType.TYPE_MOUSEDOWN);
				
				var evt:VTabButtonEvent = new VTabButtonEvent(VTabButtonEvent.BUTTON_EVENT_CLICK);
				evt.nameType = currentBtn.type;
				this.dispatchEvent(evt);
			}
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function clears():void
		{
			
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addAndRemoveEvents(isAdd:Boolean):void
		{
			if (isAdd)
			{
				if (container)
				{
					container.addEventListener(VTabButtonEvent.TYPE_TARGET_CLICK, buttonEventHandler);
					container.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
				}
			}
			else
			{
				if (container)
				{
					container.removeEventListener(VTabButtonEvent.TYPE_TARGET_CLICK, buttonEventHandler);
					container.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
				}
			}
		}
		
		private function removedFromStage(e:Event):void
		{
			addAndRemoveEvents(false);
		}
		
		private function buttonEventHandler(e:VTabButtonEvent):void
		{
			if (currentBtn == e.clickBtn) return ;
			currentBtn.setVisibleFromStatus(VTabButtonType.TYPE_MOUSEOUT);
			
			var evt:VTabButtonEvent = new VTabButtonEvent(VTabButtonEvent.BUTTON_EVENT_CLICK);
			evt.nameType = e.clickBtn.type;
			
			this.dispatchEvent(evt);
			
			currentBtn = e.clickBtn;
		}
	}
}