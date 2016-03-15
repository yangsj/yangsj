package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.vy.code.navigation.NaviMain;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
//	[SWF(width="1000", height="105", alpha="0")]
	
	[SWF(width="1000", height="230", alpha="0")]
	
	/**
	 * 说明：Main
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-12
	 */
	public class Main extends Sprite
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		private var naviMain:NaviMain;
		private var txt:TextField;
		
		public function Main()
		{
//			MonsterDebugger.initialize(this);
//			MonsterDebugger.trace(this + "navi 构造函数", "添加Event.ADDED_TO_STAGE事件");
			trace("navi 构造函数");
//			txt = new TextField();
//			txt.text = "构造函数：";
//			txt.y = 125;
//			this.addChild(txt);
//			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void
		{
			MonsterDebugger.trace("addToStageHandler:loaderInfo.parameters = ", this.stage.loaderInfo.parameters);
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			var url:String = this.stage.loaderInfo.parameters.hasOwnProperty("configUrl") ? this.stage.loaderInfo.parameters.configUrl : "";
			var id:int = this.stage.loaderInfo.parameters.hasOwnProperty("id") ? int(this.stage.loaderInfo.parameters.id) : 0;
			MonsterDebugger.trace("url:", url);
			MonsterDebugger.trace("id", id);
//			txt.appendText("url="+url + "//// id="+id);
			naviMain = new NaviMain(url, id, 230);
			this.addChild(naviMain);
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}