package character
{

	import global.Global;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;


	/**
	 * @author Administrator
	 */
	public class FrameInfoParser
	{
		private var dic_frameInfo : Object = {};

		public function FrameInfoParser(mc : MovieClip)
		{
			var frames : Array = mc.currentLabels.sortOn('frame', Array.NUMERIC);
			for (var i : * in frames)
			{
				var frame : FrameLabel = frames[i];
				var nextFrame : FrameLabel = frames[i + 1];
				dic_frameInfo[frame.name] = new FrameInfo(frame.name, frame.frame, nextFrame ? nextFrame.frame - 1 : mc.totalFrames, Global.FPS);
			}
		}

		public function getFrameInfo(frame : String) : FrameInfo
		{
			return dic_frameInfo[frame];
		}
	}
}
