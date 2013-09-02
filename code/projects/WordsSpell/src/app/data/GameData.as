package app.data
{
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class GameData extends Actor
	{
		////////////////////////////////////////////////////////
		
		private static var _instance:GameData;
		public static function get instance():GameData
		{
			if ( _instance == null )
				new GameData();
			return _instance;
		}
		
		////////////////////////////////////////////////////////
		
		public function GameData()
		{
			if ( _instance )
				throw new Error("GameData重复创建！！！");
			_instance = this;
		}
	}
}