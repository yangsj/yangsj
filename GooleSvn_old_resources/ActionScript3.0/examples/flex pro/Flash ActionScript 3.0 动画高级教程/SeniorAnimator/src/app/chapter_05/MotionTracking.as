package app.chapter_05
{
	import code.SpriteBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	
	
	/**
	 * 说明：Moiokin
	 * @author victor
	 * 2012-8-5 下午11:24:12
	 */
	
	public class MotionTracking extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _cam:Camera;
		private var _vid:Video;
		private var _newFrame:BitmapData;
		private var _oldFrame:BitmapData;
		private var _blendFrame:BitmapData;
		private var _cbRect:Sprite;
		private var _paddle:Sprite;
		
		public function MotionTracking()
		{
			super();
		}
		
		override protected function initialization():void
		{
			const vw:Number = 320 * 1;
			const vh:Number = 240 * 1;
			
			_cam = Camera.getCamera();
			_cam.setMode(vw, vh, 15);
			
			_vid = new Video(vw, vh);
			_vid.attachCamera(_cam);
			_vid.filters = [new BlurFilter(10,10,1)];
			
			_newFrame = new BitmapData(vw, vh, false);
			_oldFrame = _newFrame.clone();
			_blendFrame = _newFrame.clone();
			addChild(new Bitmap(_newFrame));
			
			_cbRect = new Sprite();
			addChild(_cbRect);
			
			_paddle = new Sprite();
			_paddle.graphics.beginFill(0xffffff);
			_paddle.graphics.drawRect(-100, -20, 200, 40);
			_paddle.graphics.endFill();
			_paddle.x = stage.stageWidth * 0.5;
			_paddle.y = stage.stageHeight- 50;
			addChild(_paddle);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_blendFrame.draw(_oldFrame);
			_newFrame.draw(_vid, new Matrix(-1, 0, 0, 1, _newFrame.width, 0));
			_oldFrame.draw(_newFrame);
			_blendFrame.draw(_newFrame, null, null, BlendMode.DIFFERENCE);
			_blendFrame.threshold(_blendFrame, _blendFrame.rect, new Point(), "<", 0x00330000, 0xff000000, 0x00ff0000, true);
			
			var rect:Rectangle = _blendFrame.getColorBoundsRect(0xffffff, 0x000000, false);
			
			_cbRect.graphics.clear();
			_cbRect.graphics.lineStyle(1, 0xff0000);
			_cbRect.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			
			if (!rect.isEmpty())
			{
				if (rect.x < _blendFrame.width * 0.5)
				{
					_paddle.x -= 20;
				}
				else
				{
					_paddle.x += 20;
				}
			}
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}