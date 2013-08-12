package app.data
{
	import app.module.main.DirectionType;

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
			level = Math.max( 1, level );
			level = Math.min( level, maxLevel );
			return levels[ level - 1 ];
		}

		public static function get maxLevel():int
		{
			return DirectionType.MAX;
		}

		private static var _levels:Vector.<LevelVo>;

		private static function get levels():Vector.<LevelVo>
		{
			if ( _levels == null )
			{
				var maxLv:int = maxLevel;
				var numGap:int = int( maxLv / 15 );
				var numSta:int = 15;
				var numScroe:int = 100;
				var max:uint = DirectionType.MAX;
				_levels = new Vector.<LevelVo>( maxLv );
				for ( var i:int = 1; i <= maxLv; i++ )
				{
					var boo:Boolean = i % numGap == 0;
					var vo:LevelVo = new LevelVo();
					vo.level = i;
					vo.score = numScroe + ( 5 * ( i - 1 ));
										vo.picNum = 2;// test
										vo.direction = DirectionType.byCenterFromLeftAndRightAndUpAndDown;
					vo.limitTime = 180;
					vo.picNum = 21;//boo ? numSta += 2 : numSta; // ok
					vo.direction = (i - 1) % max;
					_levels[ i - 1 ] = vo;
				}
			}
			return _levels;
		}



	}
}
