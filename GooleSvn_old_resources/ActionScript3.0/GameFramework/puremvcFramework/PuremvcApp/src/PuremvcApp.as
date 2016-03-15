package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	import net.victor.app.AppNotificationName;
	import net.victor.app.AppStartCommand;
	import net.victor.code.framework.AppFacade;
	
	
	[SWF(width="760", height="600")]
	/**
	 * 说明：PuremvcApp
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-14
	 */
	
	public class PuremvcApp extends Sprite
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		
		
		public function PuremvcApp()
		{
			appStage = this.stage;
			this.stage.showDefaultContextMenu = false;
			this.stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			AppFacade.instance.registerCommand(AppNotificationName.AppStartCommand, AppStartCommand);
			AppFacade.instance.sendNotification(AppNotificationName.AppStartCommand, this.stage);
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}