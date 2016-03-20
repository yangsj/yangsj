package app.chapter_04
{
	import code.SpriteBase;
	import code.chapter_04.AStar;
	import code.chapter_04.Grid;
	import code.chapter_04.Node;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	/**
	 * 说明：GridView
	 * @author victor
	 * 2012-8-3 上午8:25:27
	 */
	
	public class GridView extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _cellSize:int = 20;
		private var _grid:Grid;
		
		public function GridView($grid:Grid)
		{
			_grid = $grid;
			super();
		}
		
		override protected function initialization():void
		{
			drawGrid();
			findPath();
			addEventListener(MouseEvent.CLICK, onGridClick);
		}
		
		private function drawGrid():void
		{
			graphics.clear();
			var numCols:int = _grid.numCols;
			var numRows:int = _grid.numRows;
			for (var i:int = 0; i < numCols; i++)
			{
				for (var j:int = 0; j < numRows; j++)
				{
					var node:Node = _grid.getNode(i, j);
					graphics.lineStyle(0);
					graphics.beginFill(getColor(node));
					graphics.drawRect(i * _cellSize, j * _cellSize, _cellSize, _cellSize);
				}
			}
		}
		
		private function getColor(node:Node):uint
		{
			if (!node.walkable) return 0x000000;
			if (node == _grid.startNode) return 0x666666;
			if (node == _grid.endNode) return 0x666666;
			return 0xffffff;
		}
		
		private function onGridClick(e:MouseEvent):void
		{
			var xpos:int = int(e.localX / _cellSize);
			var ypos:int = int(e.localY / _cellSize);
			
			_grid.setWalkable(xpos, ypos, !_grid.getNode(xpos, ypos).walkable);
			drawGrid();
			findPath();
		}
		
		private function findPath():void
		{
			var astar:AStar = new AStar();
			if (astar.findPath(_grid))
			{
				showVisited(astar);
				showPath(astar);
			}
		}
		
		private function showVisited(astar:AStar):void
		{
			var visited:Array = astar.visited;
			var leng:int = visited.length;
			for (var i:int = 0; i < leng; i++)
			{
				graphics.beginFill(0xccccccc);
				graphics.drawRect(visited[i].x * _cellSize, visited[i].y * _cellSize, _cellSize, _cellSize);
				graphics.endFill();
			}
		}
		
		private function showPath(astar:AStar):void
		{
			var path:Array = astar.path;
			var leng:int = path.length;
			for (var i:int = 0; i < leng; i++)
			{
				graphics.lineStyle(0);
				graphics.beginFill(0xffffff);
				var cell:Node = path[i] as Node;
				graphics.drawCircle(cell.x * _cellSize + _cellSize * 0.5, cell.y * _cellSize + _cellSize * 0.5, _cellSize / 3);
			}
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}