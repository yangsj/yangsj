package victor.core
{
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import music.BgMusic;

	/**
	 * ……
	 * @author yangsj
	 */
	public class SoundManager
	{
		private static var last10SecondSound:Sound;
		private static var last10SecondChannel:SoundChannel;
		private static var last10SecondStopPosition:int = 0;
		private static var _isPlayLast10Second:Boolean = false;

		private static var _bgSound:Sound;
		private static var _bgChannel:SoundChannel;
		private static var _bgPosition:int = 0;


		public function SoundManager()
		{
		}

		public static function playBgMusic():void
		{
			stopBgMusic();
			_bgSound = new BgMusic();
			_bgChannel = _bgSound.play( _bgPosition, int.MAX_VALUE );
		}

		public static function stopBgMusic():void
		{
			if ( _bgChannel )
			{
				_bgPosition = _bgChannel.position;
				_bgChannel.stop();
			}
		}

		/**
		 * 点击（正确）
		 */
		public static function playClick():void
		{
			var sound:Sound = new Sounds613();
			sound.play();
		}

		/**
		 * 点击（错误）
		 */
		public static function playClickError():void
		{
			var sound:Sound = new Sounds248();
			sound.play();
		}

		/**
		 * ready go 准备
		 */
		public static function playReadyGo():void
		{
			var sound:Sound = new Sounds354();
			sound.play();
		}

		/**
		 * 时间结束
		 */
		public static function playTimeEnd():void
		{
			var sound:Sound = new Sounds270();
			sound.play();
		}

		public static function playRemoveItems():void
		{
			var sound:Sound = new Sounds317();
			sound.play();
		}

		/**
		 * 播放倒计时最后10秒提示声音
		 */
		public static function playLast10Second( percent:Number = 0 ):void
		{
			stopLast10Second();
			last10SecondSound ||= new Sounds454();
			last10SecondChannel = last10SecondSound.play( last10SecondSound.length * percent );
			_isPlayLast10Second = true;
		}

		/**
		 * 停止倒计时最后10秒提示声音
		 */
		public static function stopLast10Second():void
		{
			if ( last10SecondChannel )
			{
				last10SecondStopPosition = last10SecondChannel.position;
				last10SecondChannel.stop();
			}
			_isPlayLast10Second = false;
		}

		/**
		 * 重启倒计时最后10秒提示声音
		 */
		public static function resetLast10Second():void
		{
			if ( last10SecondSound )
			{
				last10SecondChannel = last10SecondSound.play( last10SecondStopPosition );
			}
			else
			{
				playLast10Second();
			}
			_isPlayLast10Second = true;
		}

		public static function get isPlayLast10Second():Boolean
		{
			return _isPlayLast10Second;
		}

	}
}
