package code
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import ui.UIMain01;
	import ui.UIMain02;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class Main extends Sprite
	{
		private var _skin:MovieClip;
		
		private const LENGTH:int = 4;
		
		private var aryPath:Array = [];
		private var vecBar:Vector.<BarTips>;
		
		public function Main()
		{
			if ( Global.projectType == Global.PROJECT_01 )
			{
				_skin = new UIMain01();
			}
			else if ( Global.projectType == Global.PROJECT_02 )
			{
				_skin = new UIMain02();
			}
			addChild( _skin );
			
			vecBar = new Vector.<BarTips>();
			
			initMenu();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler );
			
			_skin.addEventListener( MEvent.SELECTED_MENU, selectedMenuHandler );
			
		}
		
		protected function selectedMenuHandler(event:MEvent):void
		{
			initMenu();
			
			trace( event.index, event.visible);
			
			var menu:Sprite = _skin["menu" + event.index];
			if ( menu )
				menu.alpha = event.visible ? 1 : 0;
		}
		
		protected function menuClickHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if ( targetName.indexOf("menu") != -1)
			{
				var index:int = int( targetName.substr(targetName.length - 1));
				var bar:BarTips = vecBar[index];
				if ( bar )
					bar.gotoUrl();
			}
		}
		
		protected function menuRollHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if ( targetName.indexOf("menu") != -1 && vecBar )
			{
				var index:int = int( targetName.substr(targetName.length - 1));
				var bar:BarTips = vecBar[index];
				if ( bar )
				{
					if ( event.type == MouseEvent.ROLL_OUT)
						bar.mouseOut();
					else bar.mouseOver();
				}
			}
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler );
			
			loaderXml();
		}
		
		private function initMenu():void
		{
			for (var i:int = 0; i < LENGTH; i++)
			{
				var menu:MovieClip = _skin["menu" + i] as MovieClip;
				if ( menu )
				{
					menu.mouseChildren = false;
					menu.buttonMode = true;
					menu.alpha = 0;
					if ( menu.hasEventListener( MouseEvent.ROLL_OUT ) == false )
						menu.addEventListener(MouseEvent.ROLL_OUT, menuRollHandler);
					if ( menu.hasEventListener( MouseEvent.ROLL_OVER ) == false )
						menu.addEventListener(MouseEvent.ROLL_OVER, menuRollHandler);
					if ( menu.hasEventListener( MouseEvent.CLICK ) == false )
						menu.addEventListener(MouseEvent.CLICK, menuClickHandler);
				}
			}
		}
		
		private function loaderXml():void
		{
			try
			{
				var url:String;
				if ( stage.loaderInfo.parameters.hasOwnProperty("pathUrl") ) 
					url = stage.loaderInfo.parameters["pathUrl"];
				
				else
					url = stage.loaderInfo.loaderURL.substr( 0, url.lastIndexOf("/") );
				
				if ( url.indexOf(".xml") == -1 )
				{
					if ( Global.projectType == Global.PROJECT_01 )
						url += "/pathUrl01.xml?v=" + new Date().time;
					
					else if ( Global.projectType == Global.PROJECT_02 )
						url += "/pathUrl02.xml?v=" + new Date().time;
				}
				
				startLoad( url );
			}
			catch( e:* )
			{
				initTips( null );
			}
		}
		
		private function startLoad(url:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, completeHandler );
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorHandler );
			loader.load( new URLRequest( url ));
		}
		
		private function removeLoad( loader:URLLoader ):void
		{
			if ( loader )
			{
				loader.close();
				loader.removeEventListener(Event.COMPLETE, completeHandler );
				loader.removeEventListener(IOErrorEvent.IO_ERROR, loaderErrorHandler );
				loader = null;
			}
		}
		
		protected function loaderErrorHandler(event:IOErrorEvent):void
		{
			var loader:URLLoader = event.target as URLLoader;
			removeLoad( loader );
			
			initTips( null );
		}
		
		protected function completeHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			initTips( new XML( loader.data ) );
			
			removeLoad( loader );
		}		
		
		private function initTips( xml:XML ):void
		{
			if ( xml == null )
			{
				if ( Global.projectType == Global.PROJECT_01 )
				{
					xml = <data>
							<item id="0" url="" name="古建筑项目" window="_blank" />
							<item id="1" url="" name="3D商业秀" window="_blank" />
							<item id="2" url="" name="地产项目" window="_blank" />
							<item id="3" url="" name="规划馆项目" window="_blank" />
						  </data>
				}
				else if ( Global.projectType == Global.PROJECT_02 )
				{
					xml = <data>
							<item id="0" url="www.baidu.com" name="三维动画影片" window="_blank" />
							<item id="1" url="www.baidu.com" name="三维互动系统" window="_blank" />
							<item id="2" url="www.baidu.com" name="互动数字沙盘" window="_blank" />
							<item id="3" url="www.baidu.com" name="传动展项" window="_blank" />
						  </data>
				}
			}
			var xmllist:XMLList = xml.children();
			for each (xml in xmllist)
			{
				aryPath.push( new PathVo( int(xml.@id), String(xml.@url), String(xml.@name), String(xml.@window) ));
			}
			
			for ( var i:int = 0; i < LENGTH; i++)
			{
				var mc:MovieClip = _skin["mc" + i] as MovieClip;
				var bar:BarTips = new BarTips( mc, i < aryPath.length ? aryPath[i] : new PathVo( i ) );
				bar.playLoopOnce( i * 0.2);
				vecBar.push( bar );
			}
			
		}
		
	}
}