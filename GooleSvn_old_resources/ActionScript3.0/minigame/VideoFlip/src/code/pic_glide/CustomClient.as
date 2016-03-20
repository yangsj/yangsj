package code.pic_glide
{
	import nl.demonsters.debugger.MonsterDebugger;

	public class CustomClient
	{
		
		public var totalTime:int = 0;
		public var videoWidth:int = 0;
		public var videoHeight:int = 0;
		public var videoFramerate:int = 24;
		public var fileSize:int = 0;

		public function CustomClient()
		{
			// constructor code
		}
		
		public function onMetaData(info:Object):void
		{
			MonsterDebugger.trace("metadata:info", info);
			
			totalTime = info.duration;
			videoWidth = info.width;
			videoHeight = info.height;
			videoFramerate = info.framerate;
			fileSize = info.filesize;
			trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		}
		
		public function onCuePoint(info:Object):void
		{
			trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
		}


	}

}