package
{
	import code.Navi;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="300", height="450", alpha="0")]
	/**
	 * 说明：BingHongCha2
	 * @author victor
	 * 2012-5-28 下午09:34:51
	 */
	
	public class BingHongCha2 extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function BingHongCha2()
		{
			if (this.stage) init();
			else this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		private function init(e:Event=null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var url:String = this.stage.loaderInfo.parameters.hasOwnProperty("configUrl") ? this.stage.loaderInfo.parameters.configUrl : "";
			var id:int = this.stage.loaderInfo.parameters.hasOwnProperty("id") ? int(this.stage.loaderInfo.parameters.id) : 0;
			
			this.addChild(new Navi(url, id));
		}
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}