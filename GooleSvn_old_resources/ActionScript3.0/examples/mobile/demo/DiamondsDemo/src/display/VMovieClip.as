package display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	
	
	/**
	 * 说明：VMovieClip
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-21
	 */
	
	public class VMovieClip extends Sprite
	{
		private var bitmapData:BitmapData;
		private var xml:XML;
		private var bitmapArray:Vector.<DisplayObject>;
		private var timer:Timer;
		private var target:Sprite;
		
		private var _fps:int = 24;
		private var _currentFrame:int = 0;
		private var _totalFrame:int = 0;
		private var _loop:Boolean = true;
		private var _running:Boolean = false;
		private var _registrarType:String = InitialPointType.TOP_LEFT;
		
		
		public var onUpdate:Function;
		public var onComplete:Function;
		
		public function VMovieClip($bitmapData:BitmapData, $xml:XML, $fps:int = 24)
		{
			bitmapData = $bitmapData;
			xml = $xml;
			_fps = $fps;
			bitmapArray = new Vector.<DisplayObject>();
			createResourceArray();
			refresh();
		}
		
		private function createResourceArray():void
		{
			target = new Sprite();
			this.addChild(target);
			
			var xmlList:XMLList = xml.children();
			var xl:XML;
			var matrix:Matrix = new Matrix();
			for each (xl in xmlList)
			{
				var b_x:Number = Number(xl.@x);
				var b_y:Number = Number(xl.@y);
				var b_w:Number = Number(xl.@width);
				var b_h:Number = Number(xl.@height);
				
				var bm:Bitmap = new Bitmap();
				var bmd:BitmapData = new BitmapData(b_w, b_h, true, 0);
				
				matrix.tx = -b_x;
				matrix.ty = -b_y;
				
				bmd.draw(bitmapData, matrix);
				bm.bitmapData = bmd;
				
				bitmapArray.push(bm);
			}
			_totalFrame = bitmapArray.length;
		}
		
		////////////// public functions //////////////
		
		public function dispose():void
		{
			if (timer)
			{
				if (timer.hasEventListener(TimerEvent.TIMER))
				{
					timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				}
				timer.stop();
				timer = null;
			}
			onUpdate = null;
			onComplete = null;
			bitmapData = null;
			xml = null;
		}
		
		public function play():void
		{
			_running = true;
			if (timer == null)
			{
				timer = new Timer(50);
			}
			if (timer.hasEventListener(TimerEvent.TIMER) == false)
			{
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
			}
			timer.delay = 1000 / _fps;
			timer.start();
			refresh();
		}
		
		public function stop():void
		{
			if (timer)
			{
				timer.stop();
			}
			_currentFrame = 0;
			_running = false;
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			refresh();
		}
		
		private function refresh():void
		{
			while (target.numChildren > 0) target.removeChildAt(0);
			var dis:DisplayObject = bitmapArray[_currentFrame] as DisplayObject;
			target.addChild(dis);
			
			setThePoint();
			
			_currentFrame++;
			
			runUpdate();
			
			if (_currentFrame >= _totalFrame)
			{
				_currentFrame = 0;
				runComplete();
				if (_loop == false)
				{
					stop();
				}
			}
		}
		
		private function runUpdate():void
		{
			if (_running)
			{
				if (onUpdate != null)
				{
					onUpdate.apply(this);
				}
			}
		}
		
		private function runComplete():void
		{
			if (onComplete != null)
			{
				onComplete.apply(this);
			}
		}
		
		private function setThePoint():void
		{
			if (target == null) return ;
			const b_w:Number = target.width;
			const b_h:Number = target.height;
			var xx:Number = 0;
			var yy:Number = 0;
			switch (registrarType)
			{
				case InitialPointType.TOP_LEFT:
					xx = 0;
					yy = 0;
					break;
				case InitialPointType.TOP_CENTER:
					xx = - b_w * 0.5;
					yy = 0;
					break;
				case InitialPointType.TOP_RIGHT:
					xx = - b_w;
					yy = 0;
					break;
				case InitialPointType.LEFT_CENTER:
					xx = 0;
					yy = - 0.5 * b_h;
					break;
				case InitialPointType.LEFT_BOTTOM:
					xx = 0;
					yy = - b_h;
					break;
				case InitialPointType.RIGHT_CENTER:
					xx = - b_w;
					yy = - 0.5 * b_h;
					break;
				case InitialPointType.RIGHT_BOTTOM:
					xx = - b_w;
					yy = - b_h;
					break;
				case InitialPointType.BOTTOM_CENTER:
					xx = - b_w * 0.5;
					yy = - b_h;
					break;
				case InitialPointType.CENTER:
					xx = - b_w * 0.5;
					yy = - 0.5 * b_h;
					break;
			}
			target.x = xx;
			target.y = yy;
		}

		
		////////////// override functions //////////////
		
		
		
		////////////// private functions //////////////
		
		
		
		////////////// events functions handle/////////
		
		
		
		////////////// getter/setter //////////////////
		
		public function get fps():int
		{
			return _fps;
		}
		
		public function set fps(value:int):void
		{
			_fps = value;
		}
		
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		
		public function set currentFrame(value:int):void
		{
			_currentFrame = value;
		}
		
		public function get totalFrame():int
		{
			return _totalFrame;
		}

		public function get loop():Boolean
		{
			return _loop;
		}

		public function set loop(value:Boolean):void
		{
			_loop = value;
		}

		public function get running():Boolean
		{
			return _running;
		}

		public function set running(value:Boolean):void
		{
			_running = value;
		}

		public function get registrarType():String
		{
			return _registrarType;
		}

		public function set registrarType(value:String):void
		{
			_registrarType = value;
		}

		
	}
	
}