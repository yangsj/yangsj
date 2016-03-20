package code.chapter_03
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	
	
	/**
	 * 说明：MapLoader
	 * @author victor
	 * 2012-7-15 上午12:16:51
	 */
	
	public class MapLoader extends EventDispatcher
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _grid:Array;
		private var _loader:URLLoader;
		private var _tileTypes:Object;
		
		public function MapLoader(target:IEventDispatcher=null)
		{
			super(target);
			
			_tileTypes = new Object();
		}
		
		public function loadMap(url:String):void
		{
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onLoad);
			_loader.load(new URLRequest(url));
		}
		
		private function onLoad(e:Event):void
		{
			_grid = new Array();
			
			var data:String = _loader.data;
			
			var lines:Array = data.split("\n");
			var linesLength:int = lines.length;
			for (var i:int = 0; i < linesLength; i++)
			{
				var line:String = lines[i];
				if (isDefinition(line))
				{
					parseDefinition(line);
				}
				else if (line.charCodeAt(0) != 13 && !lineIsEmpty(line) && !isComment(line))
				{
					var cells:Array = line.split(" ");
					_grid.push(cells);
				}
			}
			
			for each (var array1:Array in _grid)
			{
				for (var key:* in array1)
				{
					var element:String = array1[key];
					if (element.indexOf("\r") >= 0 )
					{
						element = element.replace("\r", "");
						array1[key] = element;
					}
				}
			}
			
			for each (var obj:Object in _tileTypes)
			{
				for (key in obj)
				{
					var string:String = obj[key];
					if (string.indexOf("\r") >= 0 )
					{
						string = string.replace("\r", "");
						obj[key] = string;
					}
				}
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function isDefinition(line:String):Boolean
		{
			return line.indexOf("#") == 0;
		}
		
		private function parseDefinition(line:String):void
		{
			var tokens:Array = line.split(" ");
			tokens.shift();
			var symbol:String = tokens.shift() as String;
			var definition:Object = new Object();
			var leng:int = tokens.length;
			for (var i:int = 0; i < leng; i++)
			{
				var elment:Array = tokens[i].split(":") as Array;
				var key:String = elment[0];
				var val:String = elment[1];
				definition[key] = val;
			}
			setTileType(symbol, definition);
		}
		
		private function lineIsEmpty(line:String):Boolean
		{
			var leng:int = line.length;
			for (var i:int = 0; i < leng; i++)
			{
				if (line.charAt(i) != " ") return false;
			}
			return true;
		}
		
		private function isComment(line:String):Boolean
		{
			return line.indexOf("//") == 0;
		}
		
		public function setTileType(symbol:String, definition:Object):void
		{
			_tileTypes[symbol] = definition;
		}
		
		public function makeWorld(size:int):IsoWorld
		{
			var world:IsoWorld = new IsoWorld();
			var leng:int = _grid.length;
			for (var i:int = 0; i < leng; i++)
			{
				var tempArr:Array = _grid[i] as Array;
				var leng2:int = tempArr.length;
				for (var j:int = 0; j < leng2; j++)
				{
					var cellType:String = tempArr[j];
					var cell:Object = _tileTypes[cellType];
					var tile:IsoObject;
					trace(cellType, cell);
					switch (cell.type)
					{
						case "DrawnIsoTile":
							tile = new DrawnIsoTile(size, parseInt(cell.color), parseInt(cell.height));
							break;
						case "DrawnIsoBox":
							tile = new DrawnIsoBox(size, parseInt(cell.color), parseInt(cell.height));
							break;
						case "GraphicTile":
							var graphicClass:Class = getDefinitionByName(cell.graphicClass) as Class;
							tile = new GraphicTile(size, graphicClass, parseInt(cell.xoffset), parseInt(cell.yoffset));
							break;
						default :
							tile = new IsoObject(size);
							break;
					}
					tile.walkable = cell.walkable == "true";
					tile.x = j * size;
					tile.z = i * size;
					world.addChild(tile);
				}
			}
			return world;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}