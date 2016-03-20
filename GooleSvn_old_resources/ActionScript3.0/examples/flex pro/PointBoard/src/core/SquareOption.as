package core 
{
	import api.*;
	import flash.events.Event;
	import fl.events.SliderEvent;
	import fl.controls.Slider;
	
	
	/**
	 * ...
	 * @author King
	 */
	public class SquareOption extends Option implements IPolygon
	{
		private var _lineStyle:Number = 1;
		private var _lineAlpha:Number = 0.8;
		private var _lineColor:uint = 0xff0000;
		private var _hasBorder:Boolean = true;
		private var _hasFill:Boolean = true;
		private var _fillColor:Number = 0xff0000;
		private var _fillAlpha:Number = 0.8;
		
		public function SquareOption() 
		{
			
		}
		
		
		override protected function stageHandler(e:Event):void 
		{
			super.stageHandler(e);
			
			if ( e.type == Event.ADDED_TO_STAGE )
			{
				removeEventListener(Event.ADDED_TO_STAGE, stageHandler);
				borderCheckBox.selected         = hasBorder = true;
				borderAlphaSlider.value         = lineAlpha = 1;
				borderStyleSlider.value         = lineStyle = 2;
				borderColorPicker.selectedColor = lineColor = 0x000000;
				fillCheckBox.selected           = hasFill   = true;
				fillAlphaSlider.value           = fillAlpha = 1;
				fillColorPicker.selectedColor   = fillColor = 0xff0000;
				
				borderCheckBox.addEventListener   (Event.CHANGE,       ChangedHandler);
				borderAlphaSlider.addEventListener(SliderEvent.CHANGE, ChangedHandler);
				borderStyleSlider.addEventListener(SliderEvent.CHANGE, ChangedHandler);
				borderColorPicker.addEventListener(Event.CHANGE,       ChangedHandler);
				fillCheckBox.addEventListener     (Event.CHANGE,       ChangedHandler);
				fillAlphaSlider.addEventListener  (SliderEvent.CHANGE, ChangedHandler);
				fillColorPicker.addEventListener  (Event.CHANGE,       ChangedHandler);
			}
		}
		
		
		private function ChangedHandler(e:Event):void 
		{
			var targetName:String = e.target.name;
			if      (targetName == 'borderCheckBox'   ) hasBorder = e.currentTarget.selected;
			else if (targetName == 'borderAlphaSlider') lineAlpha = e.target.value;
			else if (targetName == 'borderStyleSlider') lineStyle = e.target.value;
			else if (targetName == 'borderColorPicker') lineColor = e.target.selectedColor;
			else if (targetName == 'fillCheckBox'     ) hasFill   = e.currentTarget.selected;
			else if (targetName == 'fillAlphaSlider'  ) fillAlpha = e.target.value;
			else if (targetName == 'fillColorPicker'  ) fillColor = e.target.selectedColor;
		}
		
		//==================================================
		public function get hasBorder():Boolean { return _hasBorder };
		
		public function set hasBorder(value:Boolean):void
		{
			_hasBorder = options.hasBorder = value;
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
			_lineColor = options.lineColor = value;
		}		
		
		//==================================================
		public function get hasFill():Boolean { return _hasFill; }
		
		public function set hasFill(value:Boolean):void 
		{
			_hasFill = options.hasFill = value;
		}
		
		public function get fillColor():uint { return _fillColor; }
		
		public function set fillColor(value:uint):void 
		{
			_fillColor = options.fillColor = value;
		}
		
		public function get fillAlpha():Number { return _fillAlpha; }
		
		public function set fillAlpha(value:Number):void 
		{
			_fillAlpha = options.fillAlpha = value;
		}
		
	}

}