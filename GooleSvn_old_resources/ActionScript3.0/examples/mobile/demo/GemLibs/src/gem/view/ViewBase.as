package gem.view
{

	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manager.ui.UIMainManager;
	


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
			TweenMax.to(this, 0.1, {alpha: 1, onComplete: tweenComplete, onCompleteParams: [false]});
			
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
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function removeEvents():void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
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

		final protected function adjustSize(dis : DisplayObject) : void
		{
			if (dis)
			{
//				if (Global.STANDARD_WIDTH < dis.width || Global.STANDARD_HEIGHT < dis.height)
//				{
//					var scale_x : Number = Global.STANDARD_WIDTH / dis.width;
//					var scale_y : Number = Global.STANDARD_HEIGHT / dis.height;
//					var scale : Number = Math.min(scale_x, scale_y);
//
//					dis.scaleX = dis.scaleY = scale;
//					dis.x = (Global.STANDARD_WIDTH - dis.width) * 0.5;
//					dis.y = (Global.STANDARD_HEIGHT - dis.height) * 0.5;
//				}
			}
		}
		
		/**
		 * 指定两个显示对象的对齐方式
		 * @param $dis1
		 * @param $dis2
		 * @param $type 0=左上/1=上中/2=右上/3=左中/4=居中/5=右中/6=左下/7=下中/8=右下
		 * 
		 */
		final protected function alignDisplayObjectOfTwo($dis1:DisplayObject, $dis2:DisplayObject, $type:int = 4):void
		{
			if ($dis1 == null || $dis2 == null) return ;
			
		}

		/**
		 * 在需要退出或移除本身时的调用
		 */
		protected function actionClose() : void
		{
			UIMainManager.removeChild(this);
		}
		
		protected function actionOpen():void {}

	}

}
