package
{

	import com.demonsters.debugger.MonsterDebugger;
	import com.vy.code.navigation.NaviMain;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	[SWF(width="1000", height="105", alpha="0")] // city1
	
//	[SWF(width="1000", height="230", alpha="0")] // city

	public class Ctiy extends MovieClip
	{


		public function Ctiy()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			var url:String = this.stage.loaderInfo.parameters.hasOwnProperty("configUrl") ? this.stage.loaderInfo.parameters.configUrl : "";
			var id:int = this.stage.loaderInfo.parameters.hasOwnProperty("id") ? int(this.stage.loaderInfo.parameters.id) : 0;
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace("rootURL:", url);
			MonsterDebugger.trace("id:", id);
			var naviMain:NaviMain = new NaviMain(url, id, 105);
			this.addChild(naviMain);
		}
	}

}
