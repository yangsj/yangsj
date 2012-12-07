package newview.pvp
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import newview.SpriteBase;
	import newview.navi.MainNaviView;
	
	import ui.pvp.ResourcePvpResultViewPane;
	
	
	/**
	 * 说明：PvpResultView
	 * @author Victor
	 * 2012-11-22
	 */
	
	public class PvpResultView extends SpriteBase
	{
		
		private var resultView:ResourcePvpResultViewPane;
		
		public function PvpResultView()
		{
			super();
		}
		
		override protected function createResource():void
		{
			resultView = new ResourcePvpResultViewPane();
			addChild(resultView);
		}
		
		public function get getBtnClose():InteractiveObject
		{
			return resultView.btnClose;
		}
		
	}
	
}