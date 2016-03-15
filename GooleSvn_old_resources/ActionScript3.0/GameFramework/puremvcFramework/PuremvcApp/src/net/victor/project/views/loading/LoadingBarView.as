package net.victor.project.views.loading
{
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.text.TextField;
	
	import net.victor.project.views.JTViewBase;
	
	internal class LoadingBarView extends JTViewBase
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		private var _loadingBarBg:Shape = new Shape();
		private var _loadingBarBlock:Shape = new Shape();
		
		private const loadingBarW:Number = 435;
		private const distanceX:Number = 118;
		
		public function LoadingBarView()
		{
			super();
			init();
		}
		/////////////////////////////////////////public /////////////////////////////////
		public function setProgress(current:Number, total:Number):void
		{
			_loadingBarBlock.width = 500 * current / total;
		}
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		protected function init():void
		{
			_loadingBarBg.graphics.lineStyle(1, 0x000000, 0.8);
			_loadingBarBg.graphics.beginFill(0x000000, 0.5);
			_loadingBarBg.graphics.drawRoundRect(0, 0, 500, 30, 5, 5);
			_loadingBarBg.graphics.endFill();
			
			_loadingBarBlock.graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0x0000FF], [1, 1], [0, 127]);
			_loadingBarBlock.graphics.drawRoundRect(0, 0, 500, 30, 5, 5);
			_loadingBarBlock.graphics.endFill();
			
			addChild(_loadingBarBg);
			addChild(_loadingBarBlock);
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}