package module
{

	import character.FrameLabels;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import global.Global;
	import module.vo.FrameInfo;
	import utils.ArrayUtils;
	import utils.Heartbeat;






	/**
	 * 解析帧动画的模块，仅针对有帧标签的MovieClip类。
	 */
	public class FrameAnimationModule
	{
		private var frameInfo : Dictionary = new Dictionary();
		private var movie : MovieClip;
		private var interval : int;
		private var _paused : Boolean;

		public function FrameAnimationModule(movie : MovieClip)
		{
			this.movie = movie;
			parseFrames();
		}

		public function get currentFrame() : String
		{
			return movie.currentLabel;
		}

		public function play(info : *) : TweenMax
		{
			for each (var t : TweenMax in TweenMax.getTweensOf(movie))
			{
//				trace(t.data);
				t.kill();
			}
			if (TweenMax.getTweensOf(movie).length)
				throw 'ERROR';
			var loop : Boolean = info.loop == null ? true : info.loop;
			var frames : Array = info.frames;
			var frame : String = frames.shift();
			var onComplete : Function = info.onComplete;
			var onFrameEnd : Function = info.onFrameEnd;
			var onUpdate : Function = info.onUpdate;
			var currentFrame : int = -1;
			movie.gotoAndStop(frame);
			var tween : TweenMax = TweenMax.to(movie, frameInfo[frame].duration / 1000, {frame: frameInfo[frame].end, ease: Linear.easeNone, repeat: -1, onRepeat: function() : void
			{
				if (onFrameEnd)
					onFrameEnd(frame);
				if (frames.length)
				{
					frame = frames.shift();
					movie.gotoAndStop(frame);
					tween.updateTo({frame: frameInfo[frame].end});
					tween.duration = frameInfo[frame].duration / 1000;
//					tween.startTime = 0;
				}
				else
				{
					if (!loop)
						tween.kill();
					if (onComplete)
					{
						onComplete();
						onComplete = null;
					}
				}
			}, onUpdate: function() : void
			{
				if (currentFrame == movie.currentFrame)
					return;
				currentFrame = movie.currentFrame;
				if (onUpdate)
					onUpdate(frame, movie.currentFrame - frameInfo[frame].start);
			}});
//			tween.startTime = 0;
			return tween;
		}

		/**
		 * 获取某个标签的动画信息，包括开始的帧编号，结束的帧编号，在全局FPS下的播放时长，以毫秒为单位
		 */
		public function getAnimInfo(frameLabel : String) : FrameInfo
		{
			return frameInfo[frameLabel];
		}

		/**
		 * 解析帧动画的起止，用于确定某个动作什么时候结束
		 */
		public function parseFrames() : void
		{
			var frames : Array = movie.currentLabels;
			var tPerFrame : Number = 1000 / Global.FPS;
			frames.sortOn('frame', Array.NUMERIC);
			for (var i : int = 0; i < frames.length; i++)
			{
				var frame : FrameLabel = frames[i];
				var nextFrame : FrameLabel = frames[i + 1];
				var start : int = frame.frame;
				var end : int = (nextFrame ? nextFrame.frame : movie.totalFrames) - 1;
				var info : FrameInfo = new FrameInfo();
				info.start = start;
				info.end = end;
				info.length = end - start;
				info.duration = (end - start) * tPerFrame;
				frameInfo[frame.name] = info;
//				trace(frame.name, end - start);
			}
		}

		public function getDuration(label : String) : Number
		{
			return frameInfo[label].duration;
		}

		public function pause() : int
		{
			throw 'not impl'
			return 0;
		}
	}
}
