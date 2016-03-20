package code.chapter_04
{
	
	/**
	 * 说明：Grid
	 * @author victor
	 * 2012-7-29 上午11:09:22
	 */
	
	public class Grid
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _startNode:Node;
		private var _endNode:Node;
		private var _nodes:Array;
		private var _numCols:int;
		private var _numRows:int;
		
		public function Grid(numCols:int, numRows:int)
		{
			_numCols = numCols;
			_numRows = numRows;
			_nodes = new Array();
			for (var i:int = 0; i < _numCols; i++)
			{
				var temp:Array = [];
				_nodes[i] = temp;
				for (var j:int = 0; j < _numRows; j++)
				{
					temp[j] = new Node(i, j);
				}
			}
		}
		
		public function getNode(x:int, y:int):Node
		{
			return _nodes[x][y] as Node;
		}
		
		public function setEndNode(x:int, y:int):void
		{
			_endNode = _nodes[x][y] as Node;
		}
		
		public function setStartNode(x:int, y:int):void
		{
			_startNode = _nodes[x][y] as Node;
		}
		
		public function setWalkable(x:int, y:int, value:Boolean):void
		{
			_nodes[x][y].walkable = value;
		}
		
		
		public function get endNode():Node
		{
			return _endNode;
		}
		
		public function get startNode():Node
		{
			return _startNode;
		}
		
		public function get numCols():int
		{
			return _numCols;
		}
		
		public function get numRows():int
		{
			return _numRows;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}