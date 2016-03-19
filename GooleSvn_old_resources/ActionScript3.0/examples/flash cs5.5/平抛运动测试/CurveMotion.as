package 
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.greensock.events.TweenEvent;
	
	import flash.display.DisplayObject;
	
	/**
	 * 说明：JTCurveMotion
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-5-10
	 */
	
	public class CurveMotion
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		private var ary:Array = [{label:"Linear.easeNone",data:Linear.easeNone},{label:"Back.easeOut",data:Back.easeOut},{label:"Back.easeIn",data:Back.easeIn},
			{label:"Back.easeInOut",data:Back.easeInOut},{label:"Bounce.easeOut",data:Bounce.easeOut},{label:"Bounce.easeIn",data:Bounce.easeIn},
			{label:"Bounce.easeInOut",data:Bounce.easeInOut},{label:"Circ.easeOut",data:Circ.easeOut},{label:"Circ.easeIn",data:Circ.easeIn},
			{label:"Circ.easeInOut",data:Circ.easeInOut},{label:"Cubic.easeOut",data:Cubic.easeOut},{label:"Cubic.easeIn",data:Cubic.easeIn},
			{label:"Cubic.easeInOut",data:Cubic.easeInOut},{label:"Elastic.easeOut",data:Elastic.easeOut},{label:"Elastic.easeIn",data:Elastic.easeIn},
			{label:"Elastic.easeInOut",data:Elastic.easeInOut},{label:"Expo.easeOut",data:Expo.easeOut},{label:"Expo.easeIn",data:Expo.easeIn},
			{label:"Expo.easeInOut",data:Expo.easeInOut},{label:"Quad.easeOut",data:Quad.easeOut},{label:"Quad.easeIn",data:Quad.easeIn},
			{label:"Quad.easeInOut",data:Quad.easeInOut},{label:"Quart.easeOut",data:Quart.easeOut},{label:"Quart.easeIn",data:Quart.easeIn},
			{label:"Quart.easeInOut",data:Quart.easeInOut},{label:"Quint.easeOut",data:Quint.easeOut},{label:"Quint.easeIn",data:Quint.easeIn},
			{label:"Quint.easeInOut",data:Quint.easeInOut},{label:"Sine.easeOut",data:Sine.easeOut},{label:"Sine.easeIn",data:Sine.easeIn},
			{label:"Sine.easeInOut",data:Sine.easeInOut}];
		
		private var tween:TweenMax;
		private var target:DisplayObject;
		private var type:String;
		private var duration:Number;
		private var endx:Number;
		private var endy:Number;
		private var isRemove:Boolean;
		private var x_axis:Boolean;
		
		public function CurveMotion($target:DisplayObject, $type:String, $duration:Number, $endx:Number, $endy:Number, $isRemove:Boolean, $x_axis:Boolean=true)
		{
			target		= $target;
			type		= $type;
			duration	= $duration;
			endx 		= $endx;
			endy		= $endy;
			isRemove	= $isRemove;
			x_axis		= $x_axis;
			
			var fun:Function = Linear.easeNone;
			for each (var obj:Object in ary)
			{
				if (obj.label == $type)
				{
					fun = obj.data;
					break;
				}
			}
			if ($x_axis)
			{
				tween = TweenMax.to($target, $duration, {x:endx, ease:fun, onUpdate:onUpdateHandler, onCompleteListener:completedHandler});
			}
			else
			{
				tween = TweenMax.to($target, $duration, {y:endy, ease:fun, onUpdate:onUpdateHandler, onCompleteListener:completedHandler});
			}
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public static function to($target:DisplayObject, $type:String, $duration:Number, $endx:Number, $endy:Number, $isRemove:Boolean, $x_axis:Boolean=true):CurveMotion
		{
			return new CurveMotion($target, $type, $duration, $endx, $endy, $isRemove, $x_axis);
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function onUpdateHandler():void
		{
			if (x_axis)
			{
				target.y = (tween.currentTime / tween.duration) * endy;
			}
			else
			{
				target.x = (tween.currentTime / tween.duration) * endx;
			}
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function completedHandler(e:TweenEvent):void
		{
			if (target == null) return ;
			TweenMax.killTweensOf(target);
			if (isRemove)
			{
				if (target.parent) target.parent.removeChild(target);
			}
			target = null;
			tween.kill();
			tween = null;
		}
		
		
	}
	
}