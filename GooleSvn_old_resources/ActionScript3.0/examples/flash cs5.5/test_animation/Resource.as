package
{
	import flash.utils.getDefinitionByName;
	
	/**
	 * 说明：Resource
	 * @author victor
	 * 2012-9-15 下午3:54:41
	 */
	
	public class Resource
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function Resource()
		{
			
		}
		
		////////////////// static /////////////////////////////////
		
		static public function getClass(name:String):Object
		{
			var TargetClass:Class = getDefinitionByName(name) as Class;
			
			return new TargetClass();
		}
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		////////////////// getter/setter //////////////////////////
		
		
	}
}