package sounds
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import res.Resource;
	
	
	public class SounderManager
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		private static var _instance:SounderManager;
		
		private var localSound:SoundChannel;
		private var s:Sound;
		
		public function SounderManager()
		{
			super();
			if(_instance)
			{
				throw new Error();
			}
			else
			{
				_instance=this;
			}
			
		}
		public static function get instance():SounderManager
		{
			if(_instance==null)
			{
				_instance=new SounderManager();
			}
			return _instance;
		}
		
		/**
		 *加载背景音乐 
		 * @param urlStr
		 * 
		 */		
		public function initBgm(urlStr:String):void
		{
			if (Global.isOpenMusic)
			{
				var url:URLRequest = new URLRequest(urlStr);
				s = new Sound();
				s.load(url);
				localSound = s.play();
			}
		}
		/**
		 *停止播放 
		 * @return 
		 * 
		 */		
		public function stop():void
		{
			if (Global.isOpenMusic == false) return ;
			 localSound.stop();
		}
		/**
		 *重新播放 
		 * @return 
		 * 
		 */		
		public function rePlay():void
		{
			if (Global.isOpenMusic == false) return ;
			localSound=s.play();
		}
		/**
		 *
		 * @param type
		 * 
		 */		
		/**
		 * 播放某一种小声音 
		 * @param type 
		 * @param startTime (default = 0) — 应开始回放的初始位置（以毫秒为单位）。 
		 * @param loops (default = 0) — 定义在声道停止回放之前，声音循环回 startTime 值的次数。
		 * @param sndTransform (default = null) — 分配给该声道的初始 SoundTransform 对象。
		 * 
		 */
		public function playSound(type:String, startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):void
		{
			if (Global.isOpenMusic == false) return ;
			var sound:Sound = Resource.getClass(type) as Sound;
			sound.play(startTime, loops, sndTransform);
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}