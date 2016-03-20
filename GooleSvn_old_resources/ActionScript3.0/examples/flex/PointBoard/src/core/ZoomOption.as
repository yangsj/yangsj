package core 
{
	import api.IZoomOption;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author King
	 */
	public class ZoomOption extends Option implements IZoomOption 
	{
		private var _hasBig:Boolean;
		private var _hasSmall:Boolean;
		private var _hasPlace:Boolean;
		
		public function ZoomOption() 
		{
			
		}
		
		override protected function stageHandler(e:Event):void 
		{
			if (e.type == Event.ADDED_TO_STAGE)
			{
				removeEventListener(Event.ADDED_TO_STAGE, stageHandler);
				
				zoomBig.selected   = hasBig   = true;
				zoomSmall.selected = hasSmall = false;
				zoomSmall.selected = hasPlace = false;
				
				zoomBig.addEventListener  (Event.CHANGE, checkBoxChanged);
				zoomSmall.addEventListener(Event.CHANGE, checkBoxChanged);
				zoomPlace.addEventListener(Event.CHANGE, checkBoxChanged);
			}
			
		}
		
		private function checkBoxChanged(e:Event):void
		{
			var targetName:String = e.target.name;
			if (targetName == 'zoomBig') 
			{
				hasBig = e.target.selected;
				hasSmall = hasPlace = zoomSmall.selected = zoomPlace.selected = false;
				
				trace('zoomBig    :hasBig:'+hasBig+'  \\  '+'hasSmall:'+hasSmall);
			}
			else if (targetName == 'zoomSmall')
			{
				hasSmall = e.target.selected;
				hasBig = hasPlace = zoomBig.selected = zoomPlace.selected = false;
				
				trace('zoomSmall  : hasBig:'+hasBig+'  \\  '+'hasSmall:'+hasSmall);
			}
			else if (targetName == 'zoomPlace')
			{
				hasPlace = e.target.selected;
				hasBig = hasSmall = zoomBig.selected = zoomSmall.selected = false;
				
				trace('zoomPlace  : hasBig:'+hasBig+'  \\  '+'hasSmall:'+hasSmall);
			}
		}
		
		public function get hasBig():Boolean { return _hasBig; }
		
		public function set hasBig(value:Boolean):void 
		{
			_hasBig = value;
		}
		
		public function get hasSmall():Boolean { return _hasSmall; }
		
		public function set hasSmall(value:Boolean):void 
		{
			_hasSmall = value;
		}
		
		public function get hasPlace():Boolean { return _hasPlace; }
		
		public function set hasPlace(value:Boolean):void 
		{
			_hasPlace = value;
		}
		
	}

}