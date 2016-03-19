package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	
	
	
	/**
	 * 说明：SpriteClip
	 * @author victor
	 * 2012-9-15 下午2:20:17
	 */
	
	public class SpriteClip extends Sprite
	{
		
		static public const TOP_LEFT:String = "top_left";
		static public const TOP_CENTER:String = "top_center";
		static public const TOP_RIGHT:String = "top_right";
		static public const LEFT_CENTER:String = "left_center";
		static public const LEFT_BOTTOM:String = "left_bottom";
		static public const RIGHT_CENTER:String = "right_center";
		static public const RIGHT_BOTTOM:String = "right_bottom";
		static public const BOTTOM_CENTER:String = "bottom_center";
		static public const CENTER:String = "center";
		
		
		////////////////// vars /////////////////////////////////
		
		private const XML_CLASS_NAME:String = "className";
		private const XML_ID:String = "id";
		private const XML_FRAME:String = "frame";
		private const XML_FRAME_RATE:String = "frameRate";
		
		
		
		private var _xml:XML;
		private var _currentFrame:int = 1;
		private var _totalFrames:int = 1;
		private var _frameRate:int = 24;
		private var _playNumber:int=0;
		private var _completeCallFunction:Function;
		private var _updateCallFunction:Function;
		private var _gotoStopFrame:int = -1;
		private var _currentPlayNumber:int = 1;
		private var _registrarType:String = TOP_LEFT;
		
		private var bitmap:Bitmap;
		private var bitmapDataArray:Vector.<BitmapData>;
		private var timer:Timer;
		private var delayTime:Number = 40;
		
		public function SpriteClip()
		{
			super();
			bitmap = new Bitmap();
			bitmapDataArray = new Vector.<BitmapData>();
			initialization();
			
			this.graphics.beginFill(0xff0000);
			this.graphics.drawRect(-3,-3,6,6);
			this.graphics.endFill();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		public function dispose():void
		{
			_xml = null;
			_completeCallFunction = null;
			_updateCallFunction = null;
			
			if (bitmapDataArray)
			{
				while (bitmapDataArray.length > 0) bitmapDataArray.shift().dispose();
				bitmapDataArray = null;
			}
			if (bitmap)
			{
				if (bitmap.parent) bitmap.parent.removeChild(bitmap);
				bitmap.bitmapData = null;
				bitmap.visible = false;
				bitmap = null;
			}
			
			clearTimer();
		}
		
		public function play():void
		{
			addEvents();
			createTimer();
			if (timer)
			{
				timer.delay = delayTime;
				timer.start();
			}
		}
		
		public function stop():void
		{
			removeEvents();
			if (timer)
			{
				timer.stop();
			}
		}
		
		public function gotoAndPlay($frame:int):void
		{
			_currentFrame = $frame;
			play();
		}
		
		public function gotoAndStop($frame:int):void
		{
			_gotoStopFrame = $frame < 1 ? 1 : $frame > _totalFrames ? _totalFrames : $frame;
		}
		
		////////////////// private ////////////////////////////////
		
		private function createTimer():void
		{
			if (timer == null)
			{
				timer = new Timer(delayTime);
			}
			if (timer.hasEventListener(TimerEvent.TIMER) == false)
			{
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
			}
		}
		
		private function clearTimer():void
		{
			if (timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				timer = null;
			}
		}
		
		private function initialization():void
		{
			_currentFrame = 1;
			_playNumber = 0;
			_gotoStopFrame = -1;
			_currentPlayNumber = 1;
			_gotoStopFrame = -1;
		}
		
		private function parseXml():void
		{
			frameRate = int(xml.@frameRate);
			var xmlList:XMLList = xml.children();
			var leng:int = xmlList.length();
			var xl:XML;
			for each (xl in xmlList)
			{
				var srcPath:String = xl.@className.toString();
				var frame:int = int(xl.@frame);
				frame = frame > 1 ? frame : 1;
				if (srcPath)
				{
					var imageClass:Object = Resource.getClass(srcPath);
					var bitmapData:BitmapData;
					if (imageClass is BitmapData)
					{
						bitmapData = imageClass as BitmapData;
					}
					else if (imageClass is DisplayObject)
					{
						bitmapData = new BitmapData(imageClass.width, imageClass.height, true, 0);
						bitmapData.draw(imageClass as DisplayObject, null, new ColorTransform(1,1,1,1) , null, null, false);
					}
					else
					{
						continue ;
					}
					
					for (var i:int = 0; i < frame; i++)
					{
						if (bitmapDataArray == null) bitmapDataArray = new Vector.<BitmapData>();
						bitmapDataArray.push(bitmapData);
					}
				}
			}
			_totalFrames = bitmapDataArray.length;
		}
		
		private function addEvents():void
		{
			if (this.hasEventListener(Event.REMOVED_FROM_STAGE) == false)
			{
				this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			}
		}
		
		private function removeEvents():void
		{
			if (this.hasEventListener(Event.REMOVED_FROM_STAGE))
			{
				this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			}
		}
		
		private function completed():void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
			this.stop();
			initialization();
			if (completeCallFunction != null)
			{
				completeCallFunction.apply(this);
			}
		}
		
		private function setThePoint():void
		{
			if (bitmap == null) return ;
			const b_w:Number = bitmap.width;
			const b_h:Number = bitmap.height;
			var xx:Number = 0;
			var yy:Number = 0;
			switch (registrarType)
			{
				case TOP_LEFT:
					xx = 0;
					yy = 0;
					break;
				case TOP_CENTER:
					xx = - b_w * 0.5;
					yy = 0;
					break;
				case TOP_RIGHT:
					xx = - b_w;
					yy = 0;
					break;
				case LEFT_CENTER:
					xx = 0;
					yy = - 0.5 * b_h;
					break;
				case LEFT_BOTTOM:
					xx = 0;
					yy = - b_h;
					break;
				case RIGHT_CENTER:
					xx = - b_w;
					yy = - 0.5 * b_h;
					break;
				case RIGHT_BOTTOM:
					xx = - b_w;
					yy = - b_h;
					break;
				case BOTTOM_CENTER:
					xx = - b_w * 0.5;
					yy = - b_h;
					break;
				case CENTER:
					xx = - b_w * 0.5;
					yy = - 0.5 * b_h;
					break;
			}
			bitmap.x = xx;
			bitmap.y = yy;
		}
		
		////////////////// events//////////////////////////////////
		
		protected function removedFromStageHandler(event:Event):void
		{
			this.stop();
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			if (bitmapDataArray == null) 
			{
				clearTimer();
				return ;
			}
			bitmap.bitmapData = bitmapDataArray[currentFrame - 1];
			this.addChild(bitmap as DisplayObject);
			setThePoint();
			
			if (updateCallFunction != null)
			{
				updateCallFunction.apply(this);
			}
			
			if (_currentFrame == _gotoStopFrame)
			{
				this.stop();
				return ;
			}
			
			_currentFrame++;
			if  (_currentFrame > _totalFrames)
			{
				// 循环一次完成
				_currentFrame = 1;
				if (playNumber > 0)
				{
					if (playNumber == _currentPlayNumber)
					{
						completed();
						return ;
					}
					_currentPlayNumber ++;
				}
			}
		}
		
		///////////// getter/setter /////////////////////////////
		
		/**
		 * 获取当前动画的当前播放帧头位置
		 */
		public function get currentFrame():int
		{
			return _currentFrame < 1 ? 1 : (_currentFrame > _totalFrames ? _totalFrames : _currentFrame);
		}
		
		/**
		 * 获取当前动画的总帧数值
		 */
		public function get totalFrames():int
		{
			return _totalFrames;
		}
		
		/**
		 * 获取或设置当前动画播放的帧频，默认值24
		 */
		public function get frameRate():int
		{
			return _frameRate;
		}
		
		/**
		 * @private
		 */
		public function set frameRate(value:int):void
		{
			_frameRate = value > 0 ? value : 24;
			delayTime = 1000 / _frameRate;
		}
		
		/**
		 * 获取或设置配置信息
		 */
		public function get xml():XML
		{
			return _xml;
		}
		
		/**
		 * @private
		 */
		public function set xml(value:XML):void
		{
			_xml = value;
			if (_xml)
			{
				parseXml();
			}
		}

		/**
		 * 指定动画循环次数, 默认值为0，表示无限循环。
		 */
		public function get playNumber():int
		{
			return _playNumber;
		}

		/**
		 * @private
		 */
		public function set playNumber(value:int):void
		{
			_playNumber = value < 0 ? 1 : value;
		}

		/**
		 * 当指定动画循环次数循环结束调用的函数
		 */
		public function get completeCallFunction():Function
		{
			return _completeCallFunction;
		}

		/**
		 * @private
		 */
		public function set completeCallFunction(value:Function):void
		{
			_completeCallFunction = value;
		}

		/**
		 * 动画没帧渲染时的一个回调函数
		 */
		public function get updateCallFunction():Function
		{
			return _updateCallFunction;
		}

		/**
		 * @private
		 */
		public function set updateCallFunction(value:Function):void
		{
			_updateCallFunction = value;
		}

		/**
		 * 指定注册点的位置
		 */
		public function get registrarType():String
		{
			return _registrarType;
		}

		/**
		 * @private
		 */
		public function set registrarType(value:String):void
		{
			_registrarType = value;
		}


	}
}