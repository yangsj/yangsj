package app.managers
{
	import flash.utils.getDefinitionByName;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-28
	 */
	public class ResourceManager
	{
		private static var _instance:ResourceManager;

		public static function get instance():ResourceManager
		{
			return _instance ||= new ResourceManager();
		}

		public function ResourceManager()
		{
		}

		public function getObjInstance( linkName:String ):Object
		{
			try
			{
				return new ( getClass( linkName ))();
			}
			catch ( e:Error )
			{
			}
			return null;
		}

		public function getClass( linkName:String ):Class
		{
			try
			{
				return getDefinitionByName( "ui.UILogin" ) as Class;
			}
			catch ( e:Error )
			{
			}
			return null;
		}


	}
}
