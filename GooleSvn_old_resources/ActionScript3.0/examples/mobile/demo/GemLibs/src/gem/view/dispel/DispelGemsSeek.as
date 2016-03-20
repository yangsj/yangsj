package gem.view.dispel
{
	
	/**
	 * 说明：DispelGemsSeek
	 * @author Victor
	 * 2012-10-9
	 */
	
	public class DispelGemsSeek
	{
		
		public static var gemsArray:Array;
		
		
		/**
		 * 用于测试
		 * @return
		 */
		public static function testAutoDispelProgram():Array
		{
			for each (var array:Array in gemsArray)
			{
				for each (var gems:Gem in array)
				{
					gems = promptSeekItem(gems);
					if (gems)
					{
						var gems2:Gem;
						if (gems.moveType == DispelType.GEM_MOVE_DOWN) 
							gems2 = gemsArray[gems.rows + 1][gems.cols] as Gem; 
						else if (gems.moveType == DispelType.GEM_MOVE_UP) 
							gems2 = gemsArray[gems.rows - 1][gems.cols] as Gem; 
						else if (gems.moveType == DispelType.GEM_MOVE_LEFT) 
							gems2 = gemsArray[gems.rows][gems.cols - 1] as Gem; 
						else if (gems.moveType == DispelType.GEM_MOVE_RIGHT) 
							gems2 = gemsArray[gems.rows][gems.cols + 1] as Gem; 
						return [gems, gems2];
					}
				}
			}
			return [];
		}
		
		
		/**
		 * 查找是否有可以自动消除的部分
		 * @return Array 查找到符合条件的对象
		 */
		public static function autoSeek():Array
		{
			var gems:Gem;
			var array:Array;
			var rows:int = DispelType.ROWS - 1;
			var cols:int = DispelType.COLS - 1;
			for (var i:int = rows; i > -1; i--)
			{
				for (var j:int = cols; j > -1; j--)
				{
					gems = gemsArray[i][j] as Gem;
					array = seek(gems);
					if (array.length > 2) 
						return array;
				}
			}
			return [];
		}
		
		/**
		 * 用于普通查寻
		 * @param gems 用于查找的目标
		 * @return Array 查找到符合条件的对象
		 */
		public static function seek(gems:Gem):Array
		{
			var rows:int = gems.rows;
			var cols:int = gems.cols;
			var tempGems:Gem;
			var i:int = 0;
			var array1:Array = [gems];
			var array2:Array = [gems];
			for (i = rows - 1; i >= 0; i--) // up
			{
				tempGems = gemsArray[i][cols] as Gem;
				if (gems.id == tempGems.id)
				{
					if (array1.indexOf(tempGems) == -1) 
						array1.push(gemsArray[i][cols]); 
				}
				else break; 
			}
			for (i = rows + 1; i < DispelType.ROWS; i++) // down
			{
				tempGems = gemsArray[i][cols] as Gem;
				if (gems.id == tempGems.id)
				{
					if (array1.indexOf(tempGems) == -1) 
						array1.push(gemsArray[i][cols]); 
				}
				else break; 
			}
			
			for (i = cols - 1; i >= 0; i--) // left
			{
				tempGems = gemsArray[rows][i] as Gem;
				if (gems.id == tempGems.id)
				{
					if (array2.indexOf(tempGems) == -1) 
						array2.push(gemsArray[rows][i]); 
				}
				else break; 
			}
			for (i = cols + 1; i < DispelType.COLS; i++) // right
			{
				tempGems = gemsArray[rows][i] as Gem;
				if (gems.id == tempGems.id)
				{
					if (array2.indexOf(tempGems) == -1) 
						array2.push(gemsArray[rows][i]); 
				}
				else break; 
			}
			
			if (array1.length > 2 && array2.length > 2)
			{
				for each (var object:Object in array2)
				{
					if (array1.indexOf(object) == -1) 
						array1.push(object); 
				}
			}
			else if (array1.length < 3 && array2.length > 2)
			{
				array1 = array2;
			}
			
			return array1;
		}
		
		/**
		 * 提示
		 */
		public static function promptSeek():void
		{
			for each (var array:Array in gemsArray)
			{
				for each (var gems:Gem in array)
				{
					gems = promptSeekItem(gems);
					if (gems) 
						return ; 
				}
			}
		}
		
		private static function promptSeekItem(gems:Gem):Gem
		{
			var temp_gems:Gem;
			var s_rows:int = gems.rows; // 起点rows
			var s_cols:int = gems.cols; // 起点cols
			if (s_cols + 1 < DispelType.COLS)
			{
				temp_gems = gemsArray[s_rows][s_cols + 1] as Gem;
				if (temp_gems.id == gems.id)
				{
					if (s_cols - 1 >= 0 && s_rows - 1 >= 0)
					{
						temp_gems = gemsArray[s_rows - 1][s_cols - 1] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_DOWN;
							return temp_gems;
						}
					}
					if (s_cols - 1 >= 0 && s_rows + 1 < DispelType.ROWS)
					{
						temp_gems = gemsArray[s_rows + 1][s_cols - 1] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_UP;
							return temp_gems;
						}
					}
					if (s_cols - 2 >= 0)
					{
						temp_gems = gemsArray[s_rows][s_cols - 2] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_RIGHT;
							return temp_gems;
						}
					}
					if (s_cols + 3 < DispelType.COLS)
					{
						temp_gems = gemsArray[s_rows][s_cols + 3] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_LEFT;
							return temp_gems;
						}
					}
					if (s_cols + 2 < DispelType.COLS && s_rows - 1 >= 0)
					{
						temp_gems = gemsArray[s_rows - 1][s_cols + 2] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_DOWN;
							return temp_gems;
						}
					}
					if (s_cols + 2 < DispelType.ROWS && s_rows + 1 < DispelType.ROWS)
					{
						temp_gems = gemsArray[s_rows + 1][s_cols + 2] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_UP;
							return temp_gems;
						}
					}
				}
			}
			
			if (s_cols + 2 < DispelType.COLS)
			{
				temp_gems = gemsArray[s_rows][s_cols + 2] as Gem;
				if (temp_gems.id == gems.id)
				{
					if (s_rows - 1 >= 0)
					{
						temp_gems = gemsArray[s_rows - 1][s_cols + 1] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_DOWN;
							return temp_gems;
						}
					}
					if (s_rows + 1 < DispelType.ROWS)
					{
						temp_gems = gemsArray[s_rows + 1][s_cols + 1] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_UP;
							return temp_gems;
						}
					}
				}
			}
			
			if (s_rows + 1 < DispelType.ROWS)
			{
				temp_gems = gemsArray[s_rows + 1][s_cols] as Gem;
				if (temp_gems.id == gems.id)
				{
					if (s_cols - 1 >= 0)
					{
						if (s_rows - 1 >= 0)
						{
							temp_gems = gemsArray[s_rows - 1][s_cols - 1] as Gem;
							if (temp_gems.id == gems.id)
							{
								temp_gems.prompt();
								temp_gems.moveType = DispelType.GEM_MOVE_RIGHT;
								return temp_gems;
							}
						}
						if (s_rows + 2 < DispelType.ROWS)
						{
							temp_gems = gemsArray[s_rows + 2][s_cols - 1] as Gem;
							if (temp_gems.id == gems.id)
							{
								temp_gems.prompt();
								temp_gems.moveType = DispelType.GEM_MOVE_RIGHT;
								return temp_gems;
							}
						}
					}
					if (s_cols + 1 < DispelType.COLS)
					{
						if (s_rows - 1 >= 0)
						{
							temp_gems = gemsArray[s_rows - 1][s_cols + 1] as Gem;
							if (temp_gems.id == gems.id)
							{
								temp_gems.prompt();
								temp_gems.moveType = DispelType.GEM_MOVE_LEFT;
								return temp_gems;
							}
						}
						if (s_rows + 2 < DispelType.ROWS)
						{
							temp_gems = gemsArray[s_rows + 2][s_cols + 1] as Gem;
							if (temp_gems.id == gems.id)
							{
								temp_gems.prompt();
								temp_gems.moveType = DispelType.GEM_MOVE_LEFT;
								return temp_gems;
							}
						}
					}
					if (s_rows - 2 >= 0)
					{
						temp_gems = gemsArray[s_rows - 2][s_cols] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_DOWN;
							return temp_gems;
						}
					}
					if (s_rows + 3 < DispelType.ROWS)
					{
						temp_gems = gemsArray[s_rows + 3][s_cols] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_UP;
							return temp_gems;
						}
					}
					
				}
			}
			
			if (s_rows + 2 < DispelType.ROWS)
			{
				temp_gems = gemsArray[s_rows + 2][s_cols] as Gem;
				if (temp_gems.id == gems.id)
				{
					if (s_cols - 1 >= 0)
					{
						temp_gems = gemsArray[s_rows + 1][s_cols - 1] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_RIGHT;
							return temp_gems;
						}
					}
					if (s_cols + 1 < DispelType.COLS)
					{
						temp_gems = gemsArray[s_rows + 1][s_cols + 1] as Gem;
						if (temp_gems.id == gems.id)
						{
							temp_gems.prompt();
							temp_gems.moveType = DispelType.GEM_MOVE_LEFT;
							return temp_gems;
						}
					}
				}
			}
			
			return null;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}