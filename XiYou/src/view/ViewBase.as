package view
{

	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import global.Global;
	
	import manager.ui.UIMainManager;
	
	import view.home.MainView;


	/**
	 * 说明：ViewBase
	 * @author Victor
	 * 2012-9-30
	 */

	public class ViewBase extends Sprite
	{
		
		protected var targetName:String;

		public function ViewBase()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		protected function addedToStageHandler(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			this.alpha = 0;
			TweenMax.to(this, 0.5, {alpha: 1, onComplete: tweenComplete, onCompleteParams: [false]});
			
			addEvents();
		}

		protected function removedFromStageHandler(event : Event) : void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			removeEvents();
			
			clear();
		}
		
		protected function clear():void { }
		
		protected function addEvents():void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		protected function removeEvents():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}

		protected function onClick(event : MouseEvent) : void
		{
			targetName = event.target.name;
		}
		
		private function tweenComplete(isClose : Boolean = false) : void
		{
			TweenMax.killTweensOf(this);
			if (isClose)
			{
				TweenMax.killChildTweensOf(this);
				System.gc();
				actionClose();
			}
			else
			{
				actionOpen();
			}
		}

		/**
		 * 使用一个从不透明到透明的缓动退出或移除本身。将会调用actionClose()函数。该方法不支持override覆盖。
		 */
		final protected function exit() : void
		{
			TweenMax.to(this, 0.5, {alpha: 0, onComplete: tweenComplete, onCompleteParams: [true]});
		}

		final protected function adjustSize(dis : DisplayObject, $width:Number=0, $height:Number=0, isMax:Boolean=false) : void
		{
			if (dis)
			{
				$width  = $width  > 0 ? $width  : dis.width;
				$height = $height > 0 ? $height : dis.height;
				if (Global.standardWidth < $width || Global.standardHeight < $height)
				{
					var scale_x : Number = Global.standardWidth / $width;
					var scale_y : Number = Global.standardHeight / $height;
					var scale : Number = isMax ? Math.max(scale_x, scale_y) : Math.min(scale_x, scale_y);

					dis.scaleX = dis.scaleY = scale;
					dis.x = (Global.standardWidth - $width * scale) * 0.5;
					dis.y = (Global.standardHeight - $height * scale) * 0.5;
				}
			}
		}

		/**
		 * 在需要退出或移除本身时的调用
		 */
		protected function actionClose() : void
		{
			UIMainManager.removeChild(this);
			UIMainManager.addChild(new MainView());
		}
		
		protected function actionOpen():void {}

	}

}
