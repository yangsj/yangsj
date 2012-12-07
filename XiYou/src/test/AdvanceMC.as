package test
{
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	import character.FrameInfo;
	import character.FrameInfoParser;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Administrator
	 */
	public class AdvanceMC extends MovieClip
	{
		public static const MAX_SCALE : Number = 1.5;
		private static const dic_class_cachedFrames : * = {};
		private var dic_frameScript : Array = [];
		private var cachedFrames : Vector.<Bitmap>;
		public var frameParser : FrameInfoParser;
		public var mc : MovieClip;
		private var i : int = 1;
		private var mcClassName : String;
		private var bounding : Number;

		public function AdvanceMC(mc : MovieClip, cacheFrames : Vector.<String>, bounding : Number = 0)
		{
			this.bounding = bounding;
			if (mc.parent != null)
			{
				trace('确保不要共享一个mc.');
			}
			this.mc = mc;
			mc.stop();
			addChild(mc);
			cachedFrames = new Vector.<Bitmap>(mc.totalFrames + 1, true);
			mcClassName = getQualifiedClassName(mc);
			if (dic_class_cachedFrames[mcClassName] != null)
			{
				var scale : Number = mc.scaleX / MAX_SCALE;
				for (var i : int = 1; i < mc.totalFrames + 1; i++)
				{
					var source : Bitmap = dic_class_cachedFrames[mcClassName][i];
					if (source == null)
						continue;
					var bm : Bitmap = new Bitmap(source.bitmapData, 'auto', true);
					bm.visible = false;
					bm.x = source.x * (scale / source.scaleX);
					bm.y = source.y * (scale / source.scaleY);
					bm.scaleX = bm.scaleY = scale;
					cachedFrames[i] = bm;
					addChild(bm);
				}
			}
			else
			{
				dic_class_cachedFrames[mcClassName] = cachedFrames;
			}

			frameParser = new FrameInfoParser(mc);
			this.cacheFrames = cacheFrames;
			gotoAndStop(1);
		}

		override public function addFrameScript(... args) : void
		{
			for (var i : int = 0; i < args.length; i += 2)
			{
				dic_frameScript[int(args[i])] = args[i + 1];
			}
		}

		override public function play() : void
		{
			// XXX 简单实现
			var itv : uint = setInterval(function() : void
			{
				if (i == totalFrames)
					clearInterval(itv);
				else
					nextFrame();
			}, 1000 / stage.frameRate);
		}

		override public function gotoAndStop(frame : Object, scene : String = null) : void
		{
			if (frame is String)
			{
				var info : FrameInfo = frameParser.getFrameInfo(String(frame));
				frame = info.start;
				if (frame < 1 || frame > mc.totalFrames)
					throw '超过帧范围，必须大于0，小于等于' + mc.totalFrames;
			}
			if (cachedFrames[i])
				cachedFrames[i].visible = false;
			if (cachedFrames[frame] != null)
			{
				if (mc.parent != null)
					removeChild(mc);
				cachedFrames[frame].visible = true;
			}
			else
			{
				if (mc.parent == null)
					addChild(mc);
			}
			i = int(frame);
			mc.gotoAndStop(i);
			if (dic_frameScript[i] != null)
				dic_frameScript[i]();
		}

		override public function nextFrame() : void
		{
			if (cachedFrames[i])
				cachedFrames[i].visible = false;
			i++;
			if (cachedFrames[i] != null)
			{
				if (mc.parent != null)
					removeChild(mc);
				cachedFrames[i].visible = true;
			}
			else
			{
				if (mc.parent == null)
					addChild(mc);
			}
			mc.gotoAndStop(i);
			if (dic_frameScript[i] != null)
				dic_frameScript[i]();
		}

		private function set cacheFrames(frames : Vector.<String>) : void
		{
			var sourceScale : Number = mc.scaleX;
			var scale : Number = sourceScale / MAX_SCALE;
			mc.scaleX = mc.scaleY = MAX_SCALE;
			for each (var frame : String in frames)
			{
				var info : FrameInfo = frameParser.getFrameInfo(frame);
				if (info == null)
				{
					trace(mc, '没有帧:', frame);
					continue;
				}
				if (cachedFrames[info.start] != null)
				{
					// 该帧标签段已经被缓存
					continue;
				}
				mc.gotoAndStop(info.start);
				for (var i : int = info.start; i <= info.end; i++)
				{
					mc.nextFrame();
					var rect : Rectangle = mc.getBounds(mc);
					if (rect.width == 0 || rect.height == 0)
					{
						trace('空帧:', i);
						cachedFrames[i] = new Bitmap(new BitmapData(1, 1));
						continue;
					}
					var bmd : BitmapData = new BitmapData(mc.width + bounding * 2, mc.height + bounding * 2, true, 0);
					bmd.draw(mc, new Matrix(mc.scaleX, 0, 0, mc.scaleY, -rect.left * mc.scaleX + bounding, -rect.top * mc.scaleY + bounding));
					bmd.lock();
					var bm : Bitmap = new Bitmap(bmd, 'auto', true);
					bm.x = rect.x * mc.scaleX * scale - bounding;
					bm.y = rect.y * mc.scaleY * scale - bounding;
					bm.visible = false;
					bm.scaleX = bm.scaleY = scale;
					cachedFrames[i] = bm;
					addChild(bm);
				}
			}
			mc.scaleX = mc.scaleY = sourceScale;
		}

		override public function get currentFrame() : int
		{
			return i;
		}

		override public function get totalFrames() : int
		{
			return mc.totalFrames;
		}

		override public function get currentLabels() : Array
		{
			return mc.currentLabels;
		}

		override public function get currentLabel() : String
		{
			return mc.currentLabel;
		}

		override public function get height() : Number
		{
			return mc.height;
		}

		override public function get width() : Number
		{
			return mc.width;
		}

		override public function get scaleX() : Number
		{
			return mc.scaleX * super.scaleX;
		}

		override public function get scaleY() : Number
		{
			return mc.scaleY * super.scaleY;
		}
	}
}
