package newview.adventure
{
	import level.Dungeon1;
	import level.Dungeon2;
	import level.Dungeon3;
	
	import manager.ui.UIMainManager;
	
	import newview.navi.MainNaviView;
	
	import view.battle.BattleView;
	
	/**
	 * 说明：AdventureStartBattle
	 * @author Victor
	 * 2012-11-16
	 */
	
	public class AdventureBattleEnemyerTeams
	{
		
		
		public function AdventureBattleEnemyerTeams()
		{
		}
		
		public static function getEnemyerTeams(enemyTeamId:String):Array
		{
			return enemyID(enemyTeamId);
		}
		
		private static function enemyID(enemyTeamId:String) : Array
		{
			var array : Array = []; 
			switch (enemyTeamId)
			{
				case "0":
					array = new Dungeon1().levels;
					break;
				case "1":
					array = new Dungeon2().levels;
					break;
				case "2":
					array = new Dungeon3().levels;
					break;
				default :
					array = new Dungeon1().levels;
			} 
			return array;
		}
		
	}
	
}