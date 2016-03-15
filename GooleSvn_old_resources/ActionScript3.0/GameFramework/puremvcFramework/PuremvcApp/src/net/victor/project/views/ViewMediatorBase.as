package net.victor.project.views
{
	import net.victor.project.models.ModelProxyNames;
	import net.victor.project.models.user.UserModelProxy;
	import net.victor.code.framework.AppViewMediator;
	
	/**
	 * 此类不能被实例化 
	 * 要重写initAbstract()方法
	 * 
	 */	
	public class ViewMediatorBase extends AppViewMediator
	{
		protected static const ABSTRACT_ERROR_MSG:String = "此方法限定此类为抽象类，必须完全重写此方法并不能调用super.initAbstract();";
		public function ViewMediatorBase(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			initAbstract();
		}
		
		override public function dispose():void
		{
			
		}
/////////////////////////////常用成员///////////////////////////////////////
/////////////////////////////protected///////////////////////////////////
		/**
		 * 主要用来限定此类为抽象类 ，不做任何功能。
		 * 
		 */		
		protected function initAbstract():void
		{
			throw new Error(ABSTRACT_ERROR_MSG);
		}
		
		protected function get getUserProxy():UserModelProxy
		{
			return this.getProxy(ModelProxyNames.UserModelProxy) as UserModelProxy;
		}
		
//////////////////////////////protected/////////////////////////////////////
	}
}