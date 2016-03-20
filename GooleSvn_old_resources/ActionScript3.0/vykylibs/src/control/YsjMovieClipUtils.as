package pet.game.panels.continuousLanding.control
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	
	
	/**
	 * 说明：
	 * @author yangshengjin
	 */
	
	public class YsjMovieClipUtils
	{
		
		////////////////////////////////////////// var /////////////////////////////////
		
		/** 一个回调函数 */
		private static var callBackFun:Function;
		
		/** 指定的 movieclip 所要跳到的指定帧标签 */
		private static var gotoLabel:String	= "";
		
		/** 指定的 movieclip 所要跳到的指定帧 */
		private static var gotoFrame:int		= 0;
		
		
		public function YsjMovieClipUtils()
		{
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 单个帧标签断定是否存在
		 * @param clip 指定的 Movieclip <br>
		 * @param $frameLabel 是需要断定的帧标签
		 * @return Boolean
		 */
		static public function hasFrameLabel(clip:MovieClip, $frameLabel:String):Boolean
		{
			var labels:Array = clip.currentLabels;
			
			for (var i:int = 0; i < labels.length; i++)
			{
				if ($frameLabel == labels[i].name)
				{
					labels = null;
					return true;
				}
			}
			
			labels = null;
			return false;
		}
		
		/** 
		 * 多个帧标签断定是否存在
		 * @param clip 指定的Movieclip 
		 * @param ...parameter 是需要断定的多个帧标签
		 * @return Boolean
		 */
		static public function hasFrameLabels(clip:MovieClip, ...parameter):Boolean
		{
			var labels:Array = clip.currentLabels;
			var hasAll:Boolean;
			
			for (var i:int = 0; i < parameter.length; i++)
			{
				hasAll = false;
				for (var j:int = 0; j < labels.length; j++)
				{
					if (parameter[i] == labels[j].name)
					{
						hasAll = true;
						break;
					}
				}
			}
			
			return hasAll;
		}
		
		/**
		 * 会先执行指定的$frame$label参数判断，若存在则在clip跳到 指定的$frame$label后执行指定的函数$callBack
		 * @param clip 为指定movieclip <br>
		 * @param $frame$label 为指定 clip 将要跳到的位置，可以是具体的某一帧frame， 也可以是某个帧标签frameLabal <br>
		 * @param $callBack 为指定的回调函数，是在 clip 跳到指定的$frame$label后执行
		 */
		static public function gotoListener(clip:MovieClip, $frame$label:*, $callBack:Function):void
		{
			if ($frame$label is String)
			{
				callBackFun = $callBack;
				if (hasFrameLabel(clip, $frame$label))
				{
					gotoLabel = $frame$label;
					addEvent(clip);
					clip.gotoAndStop($frame$label);
				}
			}
			else if ($frame$label && ($frame$label is Number))
			{
				callBackFun = $callBack;
				if (clip.totalFrames >= $frame$label)
				{
					gotoFrame = $frame$label;
					addEvent(clip);
					clip.gotoAndStop($frame$label);
				}
			}
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		static private function clipFrameHandler(e:Event):void
		{
			var clip:MovieClip = e.target as MovieClip;
			if (gotoLabel != "")
			{
				if (clip.currentLabel == gotoLabel)
				{
					gotoLabel = "";
					removeEvent(clip);
				}
			}
			else if (gotoFrame)
			{
				if (clip.currentFrame == gotoFrame)
				{
					gotoFrame = 0;
					removeEvent(clip);
				}
			}
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		static private function addEvent(clip:MovieClip):void
		{
			clip.addEventListener(Event.ENTER_FRAME, clipFrameHandler);
		}
		
		static private function removeEvent(clip:MovieClip):void
		{
			clip.removeEventListener(Event.ENTER_FRAME, clipFrameHandler);
			if (callBackFun())
			{
				callBackFun.apply();
				callBackFun = null;
			}
		}
	}
	
	
}