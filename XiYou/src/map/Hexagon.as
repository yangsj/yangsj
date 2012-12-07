package map
{

	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import utils.BitmapUtils;
	import flash.display.BitmapData;
	import utils.SpriteUtils;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;


	/**
	 * @author Chenzhe
	 */
	public class Hexagon extends MovieClip
	{

		private static var instances : Array = [];

		public static var focus : Hexagon;

		private var _color : String = 'blue';

		private static var bmd : BitmapData;

		public function Hexagon()
		{
			if (bmd == null)
			{
				bmd = BitmapUtils.draw(this, null, false, 0, 0, new ColorTransform(1, 1, 1, 1, 255, -255, -255, 255));
			}
			cacheAsBitmap = true;
			stop();
			if (instances.push(this) == 1)
				addEventListener(Event.ADDED_TO_STAGE, function() : void
				{
					stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
				});
		}

		private static function onStageMouseMove(event : MouseEvent) : void
		{
			var stage : Stage = event.currentTarget as Stage;
			for each (var instance : Hexagon in instances)
			{
				if (instance.hitTestPoint(stage.mouseX, stage.mouseY, true))
				{
					if (focus && focus != instance)
						focus.gotoAndStop(focus.color + '_1');
					focus = instance;
					instance.gotoAndStop(focus.color + '_2');
					return;
				}
				if (focus)
					focus.gotoAndStop(focus.color + '_1');
			}
		}

		override public function hitTestObject(obj : DisplayObject) : Boolean
		{
			if (super.hitTestObject(obj))
				return BitmapUtils.hitTest(this, obj, bmd, false);
			return false;
		}

		override public function toString() : String
		{
			return "map.Hexagon - x: " + x + " | y: " + y;
		}

		public function set color(color : String) : void
		{
			_color = color;
			gotoAndStop(_color + '_' + currentFrameLabel.split('_')[1]);
		}

		public function get color() : String
		{
			return _color;
		}
	}
}
