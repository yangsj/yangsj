package net.victor.project.views.homepage
{
	import flash.events.MouseEvent;
	
	import net.victor.project.views.JTViewBase;
	import net.victor.project.views.JTViewEvent;
	
	
	/** 
	 * 说明：
	 * @author 杨胜金
	 * 2011-11-14 下午02:54:41
	 */
	public class HomePageView extends JTViewBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		
		public function HomePageView()
		{
			super();
			initVars();
			addAndRemoveEvents(true);
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		/**
		 * 初始化
		 * @param value
		 * 
		 */
		public function initialization(value:Object):void
		{
			
		}
		
		/**
		 * 清楚变量
		 * 
		 */
		public function clears():void
		{
			addAndRemoveEvents(false);
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function initVars():void
		{
			this.graphics.beginFill(0xff0000, 0.5);
			this.graphics.drawRect(0,0,550,400);
			this.graphics.endFill();
			
			this.x = (appStage.stageWidth - this.width) * 0.5;
			this.y = (appStage.stageHeight- this.height)* 0.5;
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addAndRemoveEvents(isAdd:Boolean):void
		{
			if (isAdd)
			{
				this.addEventListener(MouseEvent.CLICK, clickHandler);
			}
			else
			{
				this.removeEventListener(MouseEvent.CLICK, clickHandler);
			}
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			this.dispatchEvent(new JTViewEvent(JTViewEvent.PANEL_CLOSE));
		}
		
	}
	
}