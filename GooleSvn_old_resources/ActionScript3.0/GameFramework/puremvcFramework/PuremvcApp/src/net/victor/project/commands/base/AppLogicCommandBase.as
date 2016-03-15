package net.victor.project.commands.base
{
	
	import flash.display.MovieClip;
	
	import net.victor.app.managers.ManagerNames;
	import net.victor.project.models.ModelProxyNames;
	import net.victor.project.models.conf.ConfigureModelProxy;
	import net.victor.code.app.managers.interfaces.IEffectsManager;
	import net.victor.code.app.managers.interfaces.IPanelManager;
	import net.victor.code.app.managers.interfaces.ITimerManager;
	import net.victor.code.framework.AppCommand;
	import net.victor.code.managers.interfaces.IKeyboardManager;
	import net.victor.code.managers.interfaces.INetworkDelegate;
	import net.victor.code.managers.interfaces.IUIResourceManager;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	
	public class AppLogicCommandBase extends AppCommand
	{
		/**
		 * 通信管理器代理 
		 * @return 
		 * 
		 */		
		protected function get netWorkRouter():INetworkDelegate
		{
			return this.managerCenter.getManager(ManagerNames.NetWorkRouter) as INetworkDelegate;
		}
		
		/**
		 *  面板管理器
		 * @return 
		 * 
		 */		
		protected function get panelManager():IPanelManager
		{
			return this.managerCenter.getManager(ManagerNames.AppPanelManager) as IPanelManager;
		}
		
		
		protected function get effectsManager():IEffectsManager
		{
			return this.managerCenter.getManager(ManagerNames.EffectsManager) as IEffectsManager;
		}
		
		protected function get timerManager():ITimerManager
		{
			return managerCenter.getManager(ManagerNames.TimerManager) as ITimerManager;
		}
		
		protected function get uiResourceManager():IUIResourceManager
		{
			return managerCenter.getManager(ManagerNames.UIResourceManager) as IUIResourceManager;
		}
		
		protected function get keyboardManager():IKeyboardManager
		{
			return managerCenter.getManager(ManagerNames.KeyboardManager) as IKeyboardManager;
		}
		
		protected function get confProxy():ConfigureModelProxy
		{
			return this.facade.retrieveProxy(ModelProxyNames.ConfigureModelProxy) as ConfigureModelProxy;
		}
		
	}
}