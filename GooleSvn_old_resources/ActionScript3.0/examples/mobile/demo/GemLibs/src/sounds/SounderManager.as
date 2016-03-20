package sounds
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	
	public class SounderManager
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		private static var pool:Dictionary = new Dictionary();
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		/**
		 * 播放某一种小声音 
		 * @param type 
		 * @param startTime (default = 0) — 应开始回放的初始位置（以毫秒为单位）。 
		 * @param loops (default = 0) — 定义在声道停止回放之前，声音循环回 startTime 值的次数。
		 * @param sndTransform (default = null) — 分配给该声道的初始 SoundTransform 对象。
		 * 
		 */
		public static function playSound(type:String, startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):void
		{
//			if (Global.isOpenMusic == false) return ;
			var sound:Sound;
			if (pool[type])
			{
				sound = pool[type] as Sound;
			}
			else
			{
				sound = getSound(type) as Sound;
				pool[type] = sound;
			}
			sound.play(startTime, loops, sndTransform);
		}
		
		public static function getSound(className:String):Sound
		{
			switch (className)
			{
				case SoundType.Sounds102 	: return new Sounds102(); 	break;
				case SoundType.Sounds164 	: return new Sounds164(); 	break;
				case SoundType.Sounds248	: return new Sounds248(); 	break;
				case SoundType.Sounds249 	: return new Sounds249(); 	break;
				case SoundType.Sounds270 	: return new Sounds270(); 	break;
				case SoundType.Sounds317 	: return new Sounds317(); 	break;
				case SoundType.Sounds354 	: return new Sounds354(); 	break;
				case SoundType.Sounds366 	: return new Sounds366(); 	break;
				case SoundType.Sounds367 	: return new Sounds367(); 	break;
				case SoundType.Sounds41 	: return new Sounds41(); 	break;
				case SoundType.Sounds445 	: return new Sounds445(); 	break;
				case SoundType.Sounds446 	: return new Sounds446(); 	break;
				case SoundType.Sounds447 	: return new Sounds447(); 	break;
				case SoundType.Sounds448 	: return new Sounds448(); 	break;
				case SoundType.Sounds449 	: return new Sounds449(); 	break;
				case SoundType.Sounds450 	: return new Sounds450(); 	break;
				case SoundType.Sounds451 	: return new Sounds451(); 	break;
				case SoundType.Sounds452 	: return new Sounds452(); 	break;
				case SoundType.Sounds453 	: return new Sounds453(); 	break;
				case SoundType.Sounds454 	: return new Sounds454(); 	break;
				case SoundType.Sounds52 	: return new Sounds52(); 	break;
				case SoundType.Sounds604 	: return new Sounds604(); 	break;
				case SoundType.Sounds613 	: return new Sounds613(); 	break;
				case SoundType.Sounds640 	: return new Sounds640(); 	break;
				case SoundType.Sounds8 		: return new Sounds8(); 	break;
			}
			return new Sound();
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}