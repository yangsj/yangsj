package test
{
	import battle.XiaBin;

	import utils.SpriteUtils;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author Chenzhe
	 */
	public class FormationPosition extends Sprite
	{
		public function FormationPosition()
		{
			//getPos(new Formation1(), XiaBin);
		}

		private function getPos(map : Sprite, pawnClass : Class) : *
		{
			addChild(map);
			var pos : Array = [];
			SpriteUtils.forEachChild(map, function(child : DisplayObject) : void
			{
				if (child is pawnClass)
				{
					pos.push(new Point(child.x, child.y));
				}
			});
			pos.sortOn(['x', 'y'], [Array.NUMERIC, Array.NUMERIC]);
			var code : String = '[' + String(pos).replace(/\(/g, 'new Point(').replace(/x=/g, '').replace(/y=/g, '') + ']';
			trace('code: ' + (code));
		}
	}
}
