package code
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 * 说明：DragItem
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-4-16
	 */
	
	public class DragItem extends Sprite
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		private var _endx:Number;
		private var _endy:Number;
		
		private const dist:int = 30;
		
		public function DragItem()
		{
			super();
			addAndRemoveEvent(true);
			this.buttonMode = true;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function dispose():void
		{
			addAndRemoveEvent(false);
		}
		
		public function get endx():Number
		{
			return _endx;
		}
		
		public function set endx(value:Number):void
		{
			_endx = value;
		}
		
		public function get endy():Number
		{
			return _endy;
		}
		
		public function set endy(value:Number):void
		{
			_endy = value;
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function checkPoint():void
		{
			if (this.x < endx + dist && this.x > endx - dist && this.y > endy - dist && this.y < endy + dist)
			{
				this.x = endx;
				this.y = endy;
				this.mouseChildren = this.mouseEnabled = false;
				addAndRemoveEvent(false);
				this.parent.addChildAt(this, 0);
				this.parent.dispatchEvent(new DragItemEvent(DragItemEvent.ITEM_OVER, this));
//				this.alpha = 0;
//				this.scaleX = this.scaleY = 0.8;
//				TweenMax.to(this, 0.5, {scaleX:1, scaleY:1, alpha:1, ease:Elastic.easeOut});
			}
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addAndRemoveEvent($isAdd:Boolean):void
		{
			if ($isAdd)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
				this.addEventListener(MouseEvent.MOUSE_UP,   mouseHandler);
				this.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			}
			else
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
				this.removeEventListener(MouseEvent.MOUSE_UP,   mouseHandler);
				this.removeEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			}
		}
		
		private function mouseHandler(e:MouseEvent):void
		{
			if (e.type == MouseEvent.MOUSE_DOWN) 
			{
				this.startDrag();
			}
			else if (e.type == MouseEvent.MOUSE_UP)
			{
				this.stopDrag();
				checkPoint();
			}
			else
			{
				this.parent.addChild(this);
			}
		}
		
		


	}
	
}