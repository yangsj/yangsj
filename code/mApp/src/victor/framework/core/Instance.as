package victor.framework.core
{
	import flash.utils.Dictionary;
	
	import victor.framework.interfaces.IScene;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-13
	 */
	public class Instance
	{
		private static const dict:Dictionary = new Dictionary( false );
		
		public static function getSceneInstance( cls:Class ):IScene
		{
			return new cls() as IScene;
			return getInstance( cls ) as IScene;
		}
		
		public static function getInstance( cls:Class ):*
		{
			if ( cls )
			{
				var instance:* = dict[ cls ];
				if ( instance == null )
				{
					trace( "+++++++++++++++创建新的实例++++++++++++++++" );
					instance = new cls();
					dict[ cls ] = instance;
					dict[ instance ] = cls;
				}
				return instance;
			}
			return new Class();
		}
		
		public static function removeInstance( cls:Class ):*
		{
			if ( cls )
			{
				var temp:* = dict[ cls ];
				delete dict[ temp ];
				delete dict[ cls ];
				return temp;
			}
			return null;
		}
		
	}
}