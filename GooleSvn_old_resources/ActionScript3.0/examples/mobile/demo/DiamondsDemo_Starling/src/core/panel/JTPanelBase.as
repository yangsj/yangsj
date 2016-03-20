package core.panel
{
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	
	
	/**
	 * 说明：JTPanelBase
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-12
	 */
	
	public class JTPanelBase extends Sprite
	{
		
		
		public function JTPanelBase()
		{
			super();
		}
		
		protected function createUIItem($linkage:String):Object
		{
			var TargetClass:Class = Global.appDomain.getDefinition($linkage) as Class;
			
			return new TargetClass();
		}
		
	}
	
}