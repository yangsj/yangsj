package view.prestige_exchange
{
	import flash.events.MouseEvent;
	
	import ui.resource.ResourcePrestigeExchangeView;
	
	import view.ViewBase;
	
	
	/**
	 * 说明：PrestigeExchangeView
	 * @author Victor
	 * 2012-10-3
	 */
	
	public class PrestigeExchangeView extends ViewBase
	{
		private var prestigeExchangeView:ResourcePrestigeExchangeView;
		
		public function PrestigeExchangeView()
		{
			super();
			
			createResource();
		}
		
		private function createResource():void
		{
			prestigeExchangeView = new ResourcePrestigeExchangeView();
			addChild(prestigeExchangeView);
			
			adjustSize(prestigeExchangeView);
		}		
		
		override protected function onClick(event:MouseEvent):void
		{
			super.onClick(event);
			if (targetName == prestigeExchangeView.btnReturn.name)
			{
				exit();
			}
			else if (targetName == prestigeExchangeView.btnExchange.name)
			{
				
			}
		}
		
	}
	
}