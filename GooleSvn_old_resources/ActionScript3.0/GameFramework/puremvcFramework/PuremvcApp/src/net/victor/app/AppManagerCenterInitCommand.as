package net.victor.app
{
	import net.victor.app.managers.EffectsManager;
	import net.victor.app.managers.ManagerNames;
	import net.victor.project.commands.start.StatGameLogicCommand;
	import net.victor.project.notificationNames.StartGameNotificationNames;
	import net.victor.code.app.managers.AppPanelManager;
	import net.victor.code.app.managers.TimerManager;
	import net.victor.code.app.managers.interfaces.IEffectsManager;
	import net.victor.code.framework.AppCommand;
	import net.victor.code.managers.AppManagerIn;
	import net.victor.code.managers.KeyboardManager;
	import net.victor.code.managers.NetworkDelegate;
	import net.victor.code.managers.UIResourceManager;
	import net.victor.code.managers.interfaces.IKeyboardManager;
	import net.victor.code.managers.interfaces.IManagerCernterable;
	import net.victor.code.managers.interfaces.IUIResourceManager;
	import net.victor.code.network.INetworkRoute;
	
	import org.puremvc.as3.interfaces.INotification;
	
	/**
	 * 初始化管理中心部中的管理器
	 */	
	public class AppManagerCenterInitCommand extends AppCommand
	{
		override public function execute(notification:INotification):void
		{
			//添到网络路由中心
			var networkRouter:INetworkRoute = new NetworkDelegate();
			networkRouter.setManagerName(ManagerNames.NetWorkRouter);
			
			this.managerCenter.addManager(networkRouter);
			
			//添加面板管理器
			var panelManager:IManagerCernterable = new AppPanelManager();
			panelManager.setManagerName(ManagerNames.AppPanelManager);
			this.managerCenter.addManager(panelManager);
			
			//添加特效管理器
			var effectManager:IEffectsManager = new EffectsManager();
			effectManager.setManagerName(ManagerNames.EffectsManager);
			this.managerCenter.addManager(effectManager);
			
			//添加定时管理器
			this.managerCenter.addManagerByClass(TimerManager, ManagerNames.TimerManager);
			
			//添加UI资源管理器
			var uiMamanger:IUIResourceManager = UIResourceManager.AppManagerIn::instance;
			uiMamanger.setManagerName(ManagerNames.UIResourceManager);
			this.managerCenter.addManager(uiMamanger);
			
			//快捷键管理器
			this.managerCenter.addManagerByClass(KeyboardManager, ManagerNames.KeyboardManager);
			var ikeyboardManager:IKeyboardManager = managerCenter.getManager(ManagerNames.KeyboardManager) as IKeyboardManager;
			ikeyboardManager.init(appStage);
			
			//启动游戏逻辑
			facade.registerCommand(StartGameNotificationNames.StatGameLogicCommand, StatGameLogicCommand);
			facade.sendNotification(StartGameNotificationNames.StatGameLogicCommand);
			
		}

	}
}