package utils
{

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;


	/**
	 * 说明：FunctionUtils
	 * @author Victor
	 * 2012-10-29
	 */

	public class FunctionUtils
	{


		public function FunctionUtils()
		{
		}


		/**
		 * 移除显示对象从其父容器中
		 * @param child 指定要移除显示的显示对象
		 * @param removeAll 是否将其设置为 null， 默认true
		 *
		 */
		public static function removeChild(child : DisplayObjectContainer, removeAll : Boolean = true) : void
		{
			if (child)
			{
				if (child.parent) 
					child.parent.removeChild(child); 
				child = null;
			}
		}

		/**
		 * 指定元件是否存在指定的   帧
		 * @param clip
		 * @param frame
		 * @param isGoto 是否跳到指定   帧
		 * @param isPlay 跳到指定   帧   后是否播放
		 * @return
		 *
		 */
		public static function movieClipHasFrame(clip : MovieClip, frame : int, isGoto : Boolean = false, isPlay : Boolean = false) : Boolean
		{
			var boo : Boolean = frame < clip.totalFrames;
			if (isGoto && boo) 
				clip[isPlay ? "gotoAndPlay" : "gotoAndStop"](frame); 
			return boo;
		}

		/**
		 * 指定的元件是否包含指定的    帧标签
		 * @param clip
		 * @param frameLabel
		 * @param isGoto 是否跳到指定   帧标签
		 * @param isPlay 跳到指定   帧标签   后是否播放
		 * @return
		 *
		 */
		public static function movieClipHasFrameLabel(clip : MovieClip, frameLabel : String, isGoto : Boolean = false, isPlay : Boolean = false) : Boolean
		{
			var labels : Array = clip.currentLabels;
			var boo : Boolean = false;
			for (var i:int = 0; i < labels.length; i++)
			{
				if (frameLabel == labels[i].name)
				{
					boo = true;
					break;
				}
			}
			if (isGoto && boo) 
				clip[isPlay ? "gotoAndPlay" : "gotoAndStop"](frameLabel); 
			return boo;
		}


	}

}
