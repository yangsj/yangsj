package map
{

	import flash.display.DisplayObject;
	import utils.SpriteUtils;

	import flash.display.Sprite;
	import flash.utils.setTimeout;


	/**
	 * @author Administrator
	 */
	public class HexagonMap extends Sprite
	{
		public var mapCells : Array = [];

		public function HexagonMap()
		{
			var _this : HexagonMap = this;
			setTimeout(function() : void
			{
				SpriteUtils.forEachChild(_this, function(child : Hexagon) : void
				{
					mapCells.push(child);
				});
			}, 200);
		}

		public function hitTest(indicator : DisplayObject) : Array
		{
			var inRange : Array = [];
			addChild(indicator);
			SpriteUtils.forEachChild(this, function(child : Sprite) : void
			{
				if (child != indicator && child.hitTestObject(indicator))
					inRange.push(child);
			});
			removeChild(indicator);
			return inRange;
		}
	}
}
