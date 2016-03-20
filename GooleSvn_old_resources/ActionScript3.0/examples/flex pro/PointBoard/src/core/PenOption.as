package core 
{
	import api.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.events.SliderEvent;
	
	
	/**
	 * ...
	 * @author King
	 */
	public class PenOption extends Option implements IPenOption
	{
		private var _lineStyle:Number;
		private var _lineAlpha:Number;
		private var _lineColor:uint;
		
		public function PenOption() 
		{
			lineAlpha = 0.8;
			lineColor = 0Xff0000;
			lineStyle = 1;			
		}
		
		override protected function stageHandler(e:Event):void 
		{
			super.stageHandler(e);
			
			if ( e.type == Event.ADDED_TO_STAGE )
			{
				alphaSlider.addEventListener(SliderEvent.CHANGE, sliderChanged);
				styleSlider.addEventListener(SliderEvent.CHANGE, sliderChanged);
				colorPicker.addEventListener(Event.CHANGE, sliderChanged);
			}
		}
		
		private function sliderChanged(e:Event):void 
		{
			var targetName:String = e.target.name;
			if      (targetName == 'alphaSlider') lineAlpha = e.target.value;
			else if (targetName == 'styleSlider') lineStyle = e.target.value;
			else if (targetName == 'colorPicker') lineColor = e.target.selectedColor;
		}
		
		public function get lineStyle():Number { return _lineStyle; }
		
		public function set lineStyle(value:Number):void 
		{
			if ( value < 1 ) value = 1;
			else if ( value > 10 ) value = 10;
			_lineStyle = options.lineStyle = value
		}
		
		public function get lineAlpha():Number { return _lineAlpha; }
		
		public function set lineAlpha(value:Number):void 
		{
			_lineAlpha = options.lineAlpha = value
		}
		
		public function get lineColor():uint { return _lineColor; }
		
		public function set lineColor(value:uint):void 
		{
			_lineColor = options.lineColor = value
		}
		
		
	}

}