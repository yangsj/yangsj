package 
{   
    import com.adobe.serialization.json.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.getDefinitionByName;
    
    import loaders.LoaderManager;
    import loaders.LoaderProgressEvent;
    
    import model.*;

	[SWF(width="1200", height="650")]
    public class tlsLoader extends Sprite
    {
        private var field:TextField;
        private var loaderMc:loadingMv;
        private var bg:Bg;
        private var introMv:IntrolMv;
        private var loading:Boolean = false;// // www.imilk.com.cn
        private var urlHead:String = "http://222.73.41.217:801/niuniu/Tpl/default/Public/flash/";
        private var loadList:Array;
        private var mainSwf:String;
        private var context:LoaderContext;
        private var percentText:int = 0;
		
		private var configPath:String = "";
		
		private var loaderManager:LoaderManager;

        public function tlsLoader()
        {
			
			if (stage)
				initialization();
			else
				addEventListener(Event.ADDED_TO_STAGE, initialization);
            
            return;
		}
		
		protected function initialization(event:Event = null):void
		{
			Security.allowDomain("*");
			this.loadList = ["libs/swc5.swf", "libs/swc2.swf", "libs/3DMv.swf", "libs/swc3.swf", "libs/book.swf", "libs/swc4.swf", "libs/swc6.swf", "libs/tigerMachine.swf", "libs/tigerPanel.swf", "libs/swc7.swf", "libs/swc8.swf", "libs/game.swf", "libs/newsPage.swf"];
			loaderManager = new LoaderManager();
			this.context = new LoaderContext(false, ApplicationDomain.currentDomain);
			this.bg = new Bg();
			addChild(this.bg);
			configPath = stage.loaderInfo.parameters.configPath;
			//configPath = configPath ? configPath : "E:/myResources/ActionScript3.0/Projects/tlsLoader/bin-debug/config.xml";
			if (!configPath)
			{
				var url:String = stage.loaderInfo.url;
				configPath = url.substr(0,url.search("tlsLoader.swf")) + "config.xml";
			}
			trace("configPath: " + configPath);
			loadingConfig();
		}
		// end function
		
		private function loadingConfig():void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, configLoadComplete);
			urlLoader.load(new URLRequest(configPath));
			urlLoader = null;
		}
		
		protected function configLoadComplete(event:Event):void
		{
			var urlLoader:URLLoader = event.target as URLLoader;
			urlLoader.removeEventListener(Event.COMPLETE, configLoadComplete);
			var xml:XML = XML(urlLoader.data);// as XML;
			
			urlHead = String(xml.path0[0].@path);
			InitDomain.instance.urlHead = String(xml.path1[0].@path);
			InitDomain.instance.urlHead_fram = String(xml.path2[0].@path);
			InitDomain.instance.urlHead_tiger = String(xml.path3[0].@path);
			
			if (!urlHead)
			{
				var url:String = stage.loaderInfo.url;
				urlHead = url.substr(0,url.search("tlsLoader.swf"));
			}
			
			urlLoader = null;
			
			startApp();
		}
		
		private function startApp():void
		{
			this.mainSwf = this.urlHead + "libs/Main.swf";
			this.loadstatic();
		}

        private function loadstatic() : void
        {
			if (InitDomain.instance.urlHead)
			{
				var _loc_1:* = UrlManager.instance.getUrl("staticInfo", 1);
				var _loc_2:* = new URLVariables();
				var _loc_3:* = new URLRequest(_loc_1);
				_loc_3.data = _loc_2;
				_loc_3.method = URLRequestMethod.POST;
				var _loc_4:* = new URLLoader();
				_loc_4.addEventListener(Event.COMPLETE, this._loader_complete);
				_loc_4.addEventListener(IOErrorEvent.IO_ERROR, this._loader_error);
				_loc_4.addEventListener(ProgressEvent.PROGRESS, this._loader_progress);
				_loc_4.load(_loc_3);
			}
			else
			{
				this.showLoaderMc();
			}
            return;
        }// end function

        private function _loader_complete(event:Event) : void
        {
            var _loc_2:* = com.adobe.serialization.json.JSON.decode(event.target.data);
            if (_loc_2.status != -1)
            {
                InitDomain.instance.registerNum = _loc_2.data.userNumber;
                trace("InitDomain.instance.registerNum", InitDomain.instance.registerNum);
                this.introMv = new IntrolMv();
                addChild(this.introMv);
                this.introMv.addEventListener(Event.ADDED_TO_STAGE, this._introMvaddTostage);
                this.introMv.addEventListener(Event.ENTER_FRAME, this._frame);
                this.addEventListener(MouseEvent.CLICK, this._mouse_click);
                this.addEventListener(MouseEvent.MOUSE_MOVE, this._mouse_move);
            }
            return;
        }// end function

        private function _introMvaddTostage() : void
        {
            this.introMv.removeEventListener(Event.ADDED_TO_STAGE, this._introMvaddTostage);
            this.introMv.x = (this.introMv.stage.stageWidth - this.introMv.width) / 2;
            this.introMv.y = (this.introMv.stage.stageHeight - this.introMv.height) / 2;
            return;
        }// end function

        private function _loader_error(event:Event) : void
        {
            return;
        }// end function

        private function _loader_progress(event:ProgressEvent) : void
        {
            return;
        }// end function

        private function _frame(event:Event) : void
        {
            if (this.introMv.currentFrame == this.introMv.totalFrames)
            {
                this.showLoaderMc();
            }
            return;
        }// end function

        private function _mouse_move(event:MouseEvent) : void
        {
            if (this.introMv["skipBtn"] != undefined)
            {
                this.introMv["skipBtn"].x = event.stageX - 10;
                this.introMv["skipBtn"].y = event.stageY - 10;
            }
            return;
        }// end function

        private function _mouse_click(event:MouseEvent) : void
        {
            switch(event.target.name)
            {
                case "skipBtn":
                {
                    this.showLoaderMc();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function showLoaderMc() : void
        {
            this.removeEventListener(MouseEvent.CLICK, this._mouse_click);
            if (introMv)
			{
				if (contains(this.introMv))
				{
					removeChild(this.introMv);
				}
				this.introMv.removeEventListener(Event.ENTER_FRAME, this._frame);
			}
			
            this.loaderMc = new loadingMv();
            addChild(this.loaderMc);
            this.loaderMc.addEventListener(Event.ENTER_FRAME, this._enterFrame);
            this.loaderMc.x = this.loaderMc.stage.stageWidth / 2;
            this.loaderMc.y = this.loaderMc.stage.stageHeight / 2;
            return;
        }

        private function _enterFrame(event:Event) : void
        {
            if (!this.field)
            {
            }
            if (this.loaderMc.percent)
            {
                //trace("find percent");
                this.field = this.loaderMc.percent.percenttxt as TextField;
                this.setPercent();
            }
            if (!this.loading)
            {
            }
            if (loading == false && (this.loaderMc as MovieClip).currentFrame == (this.loaderMc as MovieClip).totalFrames)
            {
                this.beginLoad();
                this.loading = true;
				loaderMc.stop();
            }
            if (this.field && loading == false)
            {
                this.field.text = (this.loaderMc as MovieClip).currentFrame.toString() + "%";
                this.setPercent();
            }
            return;
        }

        private function beginLoad() : void
        {
			loaderManager.context = context;
			loaderManager.addEventListener(Event.COMPLETE, this._complete);
			loaderManager.addEventListener(LoaderProgressEvent.PROGRESS,this._progress);
            var _loc_1:int = 0;
            while (_loc_1 < this.loadList.length)
            {
				loaderManager.add(this.urlHead + this.loadList[_loc_1] + "?t=" + (new Date()).time);
                _loc_1 = _loc_1 + 1;
            }
			loaderManager.add(mainSwf);
			loaderManager.start();
            return;
        }

		private function _complete(event:Event) : void
        {
            trace("complete----------------------------------");
			loaderManager.removeEventListener(Event.COMPLETE, this._complete);
			loaderManager.removeEventListener(LoaderProgressEvent.PROGRESS,this._progress);
            this.loadMainSwf();
            return;
        }

        private function loadMainSwf() : void
        {
			var disObject:DisplayObject = loaderManager.items[mainSwf] as DisplayObject;
			addChild(disObject);
			
			if (contains(this.loaderMc))
			{
				removeChild(this.loaderMc);
			}
			this.loaderMc.removeEventListener(Event.ENTER_FRAME, this._enterFrame);
			
			loaderManager.dispose();
			loaderManager = null;
			
            return;
        }

		private function _progress(event:LoaderProgressEvent) : void
        {
			this.percentText = int(event.current);
			trace("加载进度", percentText);
			setPercent();
			
            return;
        }

        private function setPercent() : void
        {
            if (this.field)
            {
                this.field.text = this.percentText.toString() + "%";
            }
            return;
        }// end function

    }
}
