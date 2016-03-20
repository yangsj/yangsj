package sounds
{
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import res.Resource;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-14 下午01:53:04
	 */
	public class SingleMusic 
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		private var _currentPosition:Number = 0;
		private var loops:int = 0;
		private var sndTransform:SoundTransform;
		private var leng:Number = 0;
		private var _isRunning:Boolean = false;
		
		public function SingleMusic($sourceName:String, $loops:Number = 0, $sndTransform:SoundTransform = null)
		{
			if (Global.isOpenMusic)
			{
				sound = Resource.getClass($sourceName) as Sound;
				loops = $loops;
				sndTransform = $sndTransform;
				leng = sound.length;
				soundChannel = sound.play(currentPosition, loops, sndTransform);
				isRunning = true;	
			}
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function clear():void
		{
			stop();
			sound = null;
		}
		
		/**
		 * 播放
		 */
		public function rePlay():void
		{
			if (Global.isOpenMusic == false) return ;
			if (isRunning == false)
			{
				isRunning = true;
				soundChannel = sound.play(currentPosition, loops);
			}
		}
		
		/**
		 * 暂停
		 */
		public function pause():void
		{
			isRunning = false;
			if (soundChannel)
			{
				currentPosition = soundChannel.position;
				soundChannel.stop();
			}
		}
		
		/**
		 * 停止
		 */
		public function stop():void
		{
			isRunning = false;
			currentPosition = 0;
			if (soundChannel)
			{
				soundChannel.stop();
			}
		}
		
		public function load(stream:URLRequest, context:SoundLoaderContext = null):void 
		{
			sound.load(stream, context);
		}
		
		public function close():void
		{
			if (sound)
			{
				sound.close();
			}
		}
		
		public function get bytesLoaded():uint
		{
			return sound.bytesLoaded;
		}
		
		public function get bytesTotal():int
		{
			return sound.bytesTotal;
		}
		
		public function get id3():ID3Info
		{
			return sound.id3;
		}
		
		public function get isBuffering():Boolean
		{
			return sound.isBuffering;
		}
		
		public function get url():String
		{
			return sound.url;
		}
		
		public function get length():Number
		{
			return leng;
		}
		
		/**
		 * startTime 应开始回放的初始位置（以毫秒为单位）。
		 */
		public function get currentPosition():Number
		{
			return _currentPosition;
		}
		
		/**
		 * @private
		 */
		public function set currentPosition(value:Number):void
		{
			_currentPosition = value;
		}
		
		/////////////////////////////////////////private ////////////////////////////////

		/**
		 * 音乐是否是播放中
		 */
		public function get isRunning():Boolean
		{
			return _isRunning;
		}

		/**
		 * @private
		 */
		public function set isRunning(value:Boolean):void
		{
			_isRunning = value;
		}

		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}