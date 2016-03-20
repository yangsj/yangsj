package code.chapter_03
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	
	/**
	 * 说明：IsoWorld
	 * @author victor
	 * 2012-7-14 下午09:03:44
	 */
	
	public class IsoWorld extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _floor:Sprite;
		private var _objects:Array;
		private var _world:Sprite;
		
		public function IsoWorld()
		{
			super();
			
			_floor = new Sprite();
			this.addChild(_floor);
			
			_world = new Sprite();
			this.addChild(_world);
			
			_objects = new Array();
		}
		
		public function addChildToWorld(child:IsoObject):void
		{
			_world.addChild(child);
			_objects.push(child);
			sort();
		}
		
		public function addChildToFloor(child:IsoObject):void
		{
			_floor.addChild(child);
		}
		
		public function sort():void
		{
			_objects.sortOn("depth", Array.NUMERIC);
			var leng:int = _objects.length;
			for (var i:int = 0; i < leng; i++)
			{
				_world.setChildIndex(_objects[i], i);
			}
		}
		
		public function canMove(obj:IsoObject):Boolean
		{
			var rect:Rectangle = obj.rect;
			rect.offset(obj.vx, obj.vz);
			var leng:int = _objects.length;
			for (var i:int = 0; i < leng; i++)
			{
				var objB:IsoObject = _objects[i] as IsoObject;
				if (obj != objB && objB.walkable && rect.intersects(objB.rect))
				{
					return false;
				}
			}
			return true;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}