package victor.core
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	import music.BgMusic0;

	/**
	 * ……
	 * @author yangsj
	 */
	public class SoundManager
	{
		private static var _last10SecondSound:Sound;
		private static var _last10SecondChannel:SoundChannel;
		private static var _last10SecondStopPosition:int = 0;
		private static var _isPlayLast10Second:Boolean = false;

		private static var _bgSound:Sound;
		private static var _bgChannel:SoundChannel;
		private static var _bgTransform:SoundTransform;
		private static var _bgPosition:int = 0;

		private static var _soundTempTransform:SoundTransform;


		public function SoundManager()
		{
		}

		//**************** bg music ****************

		public static function setBgVoice( value:Number ):void
		{
			_bgTransform ||= new SoundTransform( 0.5 );
			_bgTransform.volume = value;
		}

		public static function stopBgMusic():void
		{
			if ( _bgChannel )
			{
				_bgPosition = _bgChannel.position;
				_bgChannel.stop();
			}
			removeBgChannelListener();
		}

		public static function playBgMusic():void
		{
			stopBgMusic();
			_bgTransform ||= new SoundTransform( 0.5 );
			_bgSound ||= new BgMusic0();
			_bgChannel = _bgSound.play( _bgPosition, 1, _bgTransform );
			if ( _bgChannel )
				_bgChannel.addEventListener( Event.SOUND_COMPLETE, soundCompleteHandler );
		}

		protected static function soundCompleteHandler( event:Event ):void
		{
			removeBgChannelListener();
			_bgSound = null;
			playBgMusic();
		}

		protected static function removeBgChannelListener():void
		{
			if ( _bgChannel )
				_bgChannel.removeEventListener( Event.SOUND_COMPLETE, soundCompleteHandler );
		}

		//**********************   **********************************

		/**
		 * 点击（正确）
		 */
		public static function playClick():void
		{
			playTempSound( Sounds613 );
		}

		/**
		 * 点击（错误）
		 */
		public static function playClickError():void
		{
			playTempSound( Sounds248 );
		}

		/**
		 * ready go 准备
		 */
		public static function playReadyGo():void
		{
			playTempSound( Sounds354 );
		}

		/**
		 * 时间结束
		 */
		public static function playTimeEnd():void
		{
			playTempSound( Sounds270 );
		}

		public static function playRemoveItems():void
		{
			playTempSound( Sounds317 );
		}

		/**
		 * 播放倒计时最后10秒提示声音
		 */
		public static function playLast10Second( percent:Number = 0 ):void
		{
			stopLast10Second();
			_last10SecondSound ||= new Sounds454();
			_last10SecondChannel = _last10SecondSound.play( _last10SecondSound.length * percent );
			_isPlayLast10Second = true;
		}

		/**
		 * 停止倒计时最后10秒提示声音
		 */
		public static function stopLast10Second():void
		{
			if ( _last10SecondChannel )
			{
				_last10SecondStopPosition = _last10SecondChannel.position;
				_last10SecondChannel.stop();
			}
			_isPlayLast10Second = false;
		}

		/**
		 * 重启倒计时最后10秒提示声音
		 */
		public static function resetLast10Second():void
		{
			if ( _last10SecondSound )
			{
				_last10SecondChannel = _last10SecondSound.play( _last10SecondStopPosition );
			}
			else
			{
				playLast10Second();
			}
			_isPlayLast10Second = true;
		}


		private static function playTempSound( soundClass:Class ):void
		{
			var sound:Sound = new soundClass();
			sound.play( 0, 1, soundTransform );
		}


		public static function get isPlayLast10Second():Boolean
		{
			return _isPlayLast10Second;
		}

		public static function get soundTransform():SoundTransform
		{
			if ( _soundTempTransform == null )
				_soundTempTransform = new SoundTransform( 1 );
			return _soundTempTransform;
		}

	}
}
