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
			return _instance ||= new GameData();
		}
		
		////////////////////////////////////////////////////////
		
		public function GameData()
		{
		}
	}
}