package app.startup
{
	import flash.events.MouseEvent;
	
	import net.hires.debug.Stats;
	
	import victor.framework.core.BaseCommand;
	import app.Global;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class FlashVarsCommand extends BaseCommand
	{
		public function FlashVarsCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var parameters:Object = contextView.stage.loaderInfo.parameters;
			
			
			
			setDebug();
		}
		
		private function setDebug():void
		{
			if ( Global.isDebug )
			{
				var status:Stats = new Stats();
				contextView.addChild( status );
				status.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
				contextView.addEventListener(MouseEvent.MOUSE_UP, mouseHandler );
				function mouseHandler( event:MouseEvent ):void
				{
					if ( event.type == MouseEvent.MOUSE_DOWN )
					{
						status.startDrag();
					}
					else if ( event.type == MouseEvent.MOUSE_UP )
					{
						status.stopDrag();
					}
				}
			}
		}
		
	}
}