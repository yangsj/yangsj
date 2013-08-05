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

		[Embed( source = "/assets/sound/click.mp3" )]
		private static var SoundClickItem:Class; // 点击

		[Embed( source = "/assets/sound/link.mp3" )]
		private static var SoundLinkItem:Class; // link

		[Embed( source = "/assets/sound/button.mp3" )]
		private static var SoundClickButton:Class; //点击按钮

		[Embed( source = "/assets/sound/uwin.mp3" )]
		private static var SoundWin:Class; //win

		[Embed( source = "/assets/sound/ulose.mp3" )]
		private static var SoundLose:Class; //lose


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
			_bgChannel = _bgSound.play( _bgPosition, int.MAX_VALUE, _bgTransform );
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

		public static function playSoundWin():void
		{
			playTempSound( SoundWin );
		}

		public static function playSoundLose():void
		{
			playTempSound( SoundLose );
		}

		public static function playClickButton():void
		{
			playTempSound( SoundClickButton );
		}

		/**
		 * 点击（正确）
		 */
		public static function playClickItem():void
		{
			playTempSound( SoundClickItem );
		}

		/**
		 * 点击（错误）
		 */
		public static function playClickError():void
		{
			playTempSound( SoundClickError );
		}

		/**
		 * 时间结束
		 */
		public static function playTimeEnd():void
		{
			playTempSound( SoundTimeOver );
		}

		public static function playLinkItem():void
		{
			playTempSound( SoundLinkItem );
		}

		/**
		 * 播放倒计时最后10秒提示声音
		 */
		public static function playLast10Second( percent:Number = 0 ):void
		{
			stopLast10Second();
			_last10SecondSound ||= new SoundLast10Second();
			_last10SecondChannel = _last10SecondSound.play( _last10SecondSound.length * percent );
			_isPlayLast10Second = true;
		}

		/**
		 * 停止倒计时最后10秒提示声音
		 */
		public static function stopLast10Second():void
		{
			if ( _last10SecondChannel && _isPlayLast10Second )
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
