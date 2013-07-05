package victor.data
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-3
	 */
	public class LevelConfig
	{
		public function LevelConfig()
		{
		}


		public static function getCurLevelVo( level:int ):LevelVo
		{
			return levels[ level - 1 ];
		}

		public static function get maxLevel():int
		{
			return 100;
		}

		private static var _levels:Vector.<LevelVo>;

		private static function get levels():Vector.<LevelVo>
		{
			if ( _levels == null )
			{
				var maxLv:int = maxLevel;
				var maxTime:int = 60 + maxLv;
				var numGap:int = int( maxLv / 15 );
				var numSta:int = 15;
				var numScroe:int = 100;
				_levels = new Vector.<LevelVo>( maxLv );
				for ( var i:int = 1; i <= maxLv; i++ )
				{
					var boo:Boolean = i % numGap == 0;
					var vo:LevelVo = new LevelVo();
					vo.level = i;
					vo.score = i % 5 == 0 ? numScroe += 5 : numScroe;
					vo.picNum = boo ? numSta++ : numSta;
					vo.limitTime = boo ? maxTime -= 15 : maxTime;
					_levels[ i - 1 ] = vo;
				}
			}
			return _levels;
		}



	}
}
