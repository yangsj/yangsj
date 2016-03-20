package core.diamonds
{
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import core.panel.JTPanelBase;
	
	
	/**
	 * 说明：ContinuousClickNumberEffect
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-6-15
	 */
	
	public class ContinuousClickNumberEffect extends JTPanelBase
	{
		private var _container:Sprite;
		private var targetX:Number;
		private var targetY:Number;
		private var target:Sprite;
		private var pool:Vector.<Sprite>;
		
		public function ContinuousClickNumberEffect()
		{
			super();
			
//			pool = new Vector.<Sprite>();
		}
		
		public function get container():Sprite
		{
			return _container;
		}

		public function set container(value:Sprite):void
		{
			_container = value;
		}
		
		public function setTargetXY($targetX:Number, $targetY:Number):void
		{
			targetX = $targetX;
			targetY = $targetY;
		}

		public function play($number:Number):void
		{
//			initAndClearTarget();
//			var stringNumber:String = "+"+$number;
//			var labelIndex:int = $number - 1 < 0 ? 0 : $number - 1;
//			var numberResource:Sprite;
//			if (pool.hasOwnProperty(labelIndex) && pool[labelIndex])
//			{
//				numberResource = pool[labelIndex] as Sprite;
//			}
//			else
//			{
//				numberResource = Numeric.getNumericMovieClip(stringNumber);
//				pool[labelIndex] = numberResource;
//			}
//			var numberRectangle:Rectangle = numberResource.getBounds(numberResource);
//			numberResource.x = numberRectangle.x - numberRectangle.width*0.5;
//			numberResource.y = numberRectangle.y - numberRectangle.height*0.5;
//			target.addChild(numberResource);
//			var endy:Number = targetY - (Math.random() * 20 + 180);
//			TweenMax.to(target, 1, {scaleX:1, scaleY:1, y:endy, alpha:1, onCompleteListener:onCompleteHandler});
//			numberResource = null;
		}
		
		private function initAndClearTarget():void
		{
//			if (target == null)
//			{
//				target = new Sprite();
//				container.addChild(target);
//			}
//			else
//			{
//				while (target.numChildren > 0)
//				{
//					target.removeChildAt(0);
//				}
//			}
//			target.x = targetX;
//			target.y = targetY;
//			TweenMax.killTweensOf(target);
//			target.scaleX = target.scaleY = 0;
//			target.alpha = 1;
		}
		
		private function onCompleteHandler(e:TweenEvent):void
		{
//			initAndClearTarget();
		}
		
		
	}
	
}