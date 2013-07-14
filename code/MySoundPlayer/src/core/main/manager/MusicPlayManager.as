package core.main.manager
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.FileReference;
	
	import core.Global;
	import core.Setting;
	import core.main.event.AppEvent;

	[Event( name = "buffering", type = "core.main.event.AppEvent" )]
	[Event( name = "buffer_complete", type = "core.main.event.AppEvent" )]
	[Event( name = "progress", type = "flash.events.ProgressEvent" )]
	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-10
	 */
	public class MusicPlayManager extends EventDispatcher
	{
		private static var _instance:MusicPlayManager;

		public static function get instance():MusicPlayManager
		{
			_instance ||= new MusicPlayManager();
			return _instance;
		}

		private var defaultList:Vector.<Sound>;
		private var soundCurrent:Sound;
		private var soundChannel:SoundChannel;
		private var soundTransform:SoundTransform;
		private var soundPosition:int;
		private var soundCurtIndex:int = -1;
		private var isPlayDefalutList:Boolean = false;
		private var scanListFile:Vector.<FileReference>;
		private var scanListSound:Vector.<Sound>;
		private var fileReference:FileReference;

		private var _isPlaying:Boolean;

		public function MusicPlayManager()
		{
			defaultList = new Vector.<Sound>();
			defaultList.push( new BgMusic1());
			defaultList.push( new BgMusic2());
			defaultList.push( new BgMusic3());
			defaultList.push( new BgMusic4());
			defaultList.push( new BgMusic5());
		}

		public function setSoundTransform( value:Number ):void
		{
			soundTransform ||= new SoundTransform();
			value = isNaN( value ) ? 40 : value;
			Setting.currentVoice = value;
			soundTransform.volume = value * 0.01;
			if ( soundChannel )
				soundChannel.soundTransform = soundTransform;
		}

		public function autoPlay():void
		{
		}

		public function playScanList( scanList:Vector.<FileReference> ):void
		{
			soundCurtIndex == -1;
			stopSound();
			soundCurrent = null;
			if ( scanList )
			{
				isPlayDefalutList = false;
				scanListFile = scanList;
				scanListSound = new Vector.<Sound>( scanList.length );
				playSound();
			}
			else
			{
				playDefaultList();
			}
		}

		public function playDefaultList():void
		{
			if ( isPlayDefalutList && _isPlaying )
				return;
			stopSound();
			soundCurrent = null;
			soundCurtIndex == -1;
			isPlayDefalutList = true;
			playSound();
		}

		public function stopSound():void
		{
			if ( soundChannel )
			{
				soundChannel.stop();
				soundChannel.removeEventListener( Event.SOUND_COMPLETE, soundCompleteHandler );
			}
			_isPlaying = false;

			Global.stage.removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}

		public function pauseSound():void
		{
			if ( soundChannel )
				soundPosition = soundChannel.position;
			stopSound();
		}

		public function playSound():void
		{
			stopSound();
			Global.stage.addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			if ( isPlayDefalutList )
				playDefault();
			else
				playScan();
		}

		private function playDefault():void
		{
			if ( soundCurrent == null )
			{
				soundPosition = 0;
				if ( Setting.playSingle )
				{
					soundCurtIndex = Math.max( soundCurtIndex, 0 );
					soundCurrent = defaultList[ soundCurtIndex ];
				}
				else if ( Setting.playRandom )
				{
					soundCurtIndex = int( Math.random() * defaultList.length );
					soundCurrent = defaultList[ soundCurtIndex ];
				}
				else
				{
					soundCurtIndex++;
					soundCurtIndex = soundCurtIndex >= defaultList.length ? 0 : soundCurtIndex;
					soundCurrent = defaultList[ soundCurtIndex ];
				}
			}
			setSoundChannel();
		}

		private function playScan():void
		{
			if ( scanListFile )
			{
				if ( soundCurrent == null )
				{
					soundPosition = 0;
					if ( Setting.playSingle )
					{
						soundCurtIndex = Math.max( soundCurtIndex, 0 );
						soundCurrent = scanListSound[ soundCurtIndex ];
					}
					else if ( Setting.playRandom )
					{
						soundCurtIndex = int( Math.random() * defaultList.length );
						soundCurrent = scanListSound[ soundCurtIndex ];
					}
					else
					{
						soundCurtIndex++;
						soundCurtIndex = soundCurtIndex >= scanListFile.length ? 0 : soundCurtIndex;
						soundCurrent = scanListSound[ soundCurtIndex ];
					}
					if ( soundCurrent == null )
					{
						dispatchEvent( new AppEvent( AppEvent.BUFFERING ));

						fileReference = scanListFile[ soundCurtIndex ];
						fileReference.addEventListener( IOErrorEvent.IO_ERROR, ioErrorLoadHandler );
						fileReference.addEventListener( Event.COMPLETE, loadCompleteHandler );
						fileReference.load();
					}
					else
					{
						setSoundChannel();
					}
				}
				else
				{
					setSoundChannel();
				}
			}
			else
			{
				playDefault();
			}
		}

		private function setSoundChannel():void
		{
			soundChannel = soundCurrent.play( soundPosition, 1, soundTransform );
			soundChannel.addEventListener( Event.SOUND_COMPLETE, soundCompleteHandler );
			_isPlaying = true;

			dispatchEvent( new AppEvent( AppEvent.BUFFER_COMPLETE ));
			fileReference = null;
		}

		protected function enterFrameHandler( event:Event ):void
		{
			if (soundChannel && soundCurrent)
				dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, soundChannel.position, soundCurrent.length ));
		}

		protected function soundCompleteHandler( event:Event ):void
		{
			soundCurrent = null;
			soundPosition = 0;
			playSound();
		}

		protected function loadCompleteHandler( event:Event ):void
		{
			if ( fileReference )
			{
				soundCurrent = new Sound();
				soundCurrent.loadCompressedDataFromByteArray(fileReference.data,fileReference.data.length);
				if ( soundCurrent )
					scanListSound[ soundCurtIndex ] = soundCurrent;
				fileReference.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorLoadHandler );
				fileReference.removeEventListener( Event.COMPLETE, loadCompleteHandler );
			}
			if ( soundCurrent )
				setSoundChannel();
			else
			{
				scanListFile.splice( soundCurtIndex, 1 );
				scanListSound.splice( soundCurtIndex, 1 );
				playSound();
			}
		}

		protected function ioErrorLoadHandler( event:IOErrorEvent ):void
		{
			if ( fileReference )
			{
				fileReference.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorLoadHandler );
				fileReference.removeEventListener( Event.COMPLETE, loadCompleteHandler );
			}
			scanListFile.splice( soundCurtIndex, 1 );
			scanListSound.splice( soundCurtIndex, 1 );
			playSound();
		}

		/**
		 * 是否正在播放
		 */
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}


	}
}
