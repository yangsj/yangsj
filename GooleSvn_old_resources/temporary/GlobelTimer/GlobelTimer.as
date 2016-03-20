package 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * 说明：GlobelTimer
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-17
	 */
	
	public class GlobelTimer
	{
		
		/////////////////////////////////static ////////////////////////////
		
		private static var functionParams:Dictionary = new Dictionary();
		private static var movieClip:MovieClip;
		private static var frameRate:Number = 24;
		private static var stage:Stage;
		private static var countEnterframe:int = 0;
		private static var lastGetTimer:Number;
		
		///////////////////////////////// vars /////////////////////////////////
		
		
		
		public function GlobelTimer()
		{
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public static function initialization($stage:Stage):void
		{
			stage = $stage;
			if (movieClip == null)
			{
				lastGetTimer = getTimer();
				movieClip = new MovieClip();
				movieClip.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		public static function addFunction($name:String, $callFunction:Function, ...params):void
		{
			if (functionParams == null) functionParams = new Dictionary();
			if (functionParams[$name])
			{
				throw new Error("在GlobalTimer中增加"+$name + "的$callFunction已经存在，请更换一个标记名称。。。");
				return ;
			}
			functionParams[$name] = [$callFunction, params];
		}
		
		public static function removeFunction($name:String):void
		{
			
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private static function enterFrameHandler(e:Event):void
		{
			//if (stage)
//			{
//				frameRate = stage.frameRate;
//			}
//			trace("frameRate:::::::::::::::::", frameRate);
//			if (countEnterframe % frameRate == 0)
//			{
//				for each (var ary:Array in functionParams)
//				{
//					var callFun:Function = ary[0] as Function;
//					var params:Array = ary[1] as Array;
//					callFun.apply(null, params);
//				}
//			}
//			countEnterframe++;
			
			if (getTimer() - lastGetTimer >= 1000)
			{
				lastGetTimer = getTimer();
				for each (var ary:Array in functionParams)
				{
					var callFun:Function = ary[0] as Function;
					var params:Array = ary[1] as Array;
					callFun.apply(null, params);
				}
			}
		}
		
		
	}
	
}