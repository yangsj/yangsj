package code.pic_glide
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import net.vyky.code.regular.InvertedImage;
	
	
	/**
	 * 说明：Item
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-5
	 */
	
	public class Item extends MovieClip
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		private var _nameTxt:TextField;
		private var _vo:ItemVO;
		private var _id:int;
		private var _url:String;
		
		private var connection:NetConnection;
		private var stream:NetStream;
		private var videoContainer:Sprite;
		private var isPreload:Boolean = true;
		private var videoClient:CustomClient;
		
		private var videoIsPlay:Boolean = false;
		
		public function Item()
		{
			super();
			init();
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function playVideo():void
		{
			if (url)
			{
				initVideoPlayer();
			}
		}
		
		public function pauseVideo():void
		{
			if (stream)
			{
				videoIsPlay = false;
				stream.pause();
				this.removeEventListener(Event.ENTER_FRAME, thisEnterFrameHandler);
			}
		}
		
		public function resumeVideo():void
		{
			if (stream)
			{
				videoIsPlay = true;
				stream.resume();
				this.addEventListener(Event.ENTER_FRAME, thisEnterFrameHandler);
			}
		}
		
		public function get nameTxt():TextField
		{
			return _nameTxt;
		}
		
		public function set nameTxt(value:TextField):void
		{
			_nameTxt = value;
		}
		
		public function get vo():ItemVO
		{
			return _vo;
		}
		
		public function set vo(value:ItemVO):void
		{
			_vo = value;
		}
		
		public function initAttribute():void
		{
			this.x 			= vo.x;
			this.y 			= vo.y;
			this.width 		= vo.width;
			this.height		= vo.height;
			this.alpha 		= vo.alpha;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			_url = value;
			
		}

		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function init():void
		{
			videoContainer = new Sprite();
			videoContainer.graphics.beginFill(Math.random() * 0xffffff, Math.random()* 5 *0.1 + 0.5);
			videoContainer.graphics.drawRect(0,0,160,120);
			videoContainer.graphics.endFill();
			this.addChild(videoContainer);
			
			var forMat:TextFormat = new TextFormat();
			forMat.align = TextFormatAlign.CENTER;
			forMat.size = 14;
			
			_nameTxt = new TextField();
			_nameTxt.width = 100;
			_nameTxt.height= 18;
			_nameTxt.defaultTextFormat = forMat;
			_nameTxt.y = (100 - 18) * 0.5;
			
			this.addChild(_nameTxt);
			
			this.mouseChildren = false;
			
		}
		
		private function initVideoPlayer():void
		{
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatudEventHandler);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityEventHandler);
			connection.addEventListener(IOErrorEvent.IO_ERROR, ioErrorEventHandler);
			connection.connect(null);
		}
		
		private function netStatudEventHandler(e:NetStatusEvent):void
		{
			switch (e.info.code)
			{
				case "NetConnection.Connect.Success" :
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound" :
					trace("Stream not found: " + url);
					break;
			}
			
		}
		
		private function securityEventHandler(e:SecurityErrorEvent):void
		{
			
		}
		
		private function ioErrorEventHandler(e:IOErrorEvent):void
		{
			
		}
		
		private function connectStream():void
		{
			stream = new NetStream(connection);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatudEventHandler);
			videoClient = new CustomClient();
			stream.client = videoClient;
			var video:Video = new Video();
			video.width = 160;
			video.height= 120;
			video.attachNetStream(stream);
			stream.play(url);
			videoContainer.addChild(video);
			this.addEventListener(Event.ENTER_FRAME, thisEnterFrameHandler);
			InvertedImage.createRef(videoContainer);
			pauseVideo();
		}
		
		private function thisEnterFrameHandler(e:Event):void
		{
			if (videoIsPlay || isPreload)
			{
				InvertedImage.createRef(videoContainer);
				isPreload = false;
			}
			
			if (stream.time >= videoClient.totalTime)
			{
				trace("video is over");
			}
			
			trace(stream.time + "/" + videoClient.totalTime);
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
		

	}
	
}