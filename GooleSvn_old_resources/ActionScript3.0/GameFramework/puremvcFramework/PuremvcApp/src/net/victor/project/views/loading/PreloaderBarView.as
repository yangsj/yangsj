package net.victor.project.views.loading
{
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import net.victor.project.views.JTViewBase;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-19 下午01:15:44
	 */
	public class PreloaderBarView extends JTViewBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var preloader:MovieClip;
		
		public function PreloaderBarView()
		{
			super();
			init();
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function setProgress(current:Number, total:Number):void
		{
			rateTxt.text = int((current / total) * 100) + "%";
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		protected function init():void
		{
			preloader = this.createUIItem("net.jt_tech.ui.icon.FirstLogoLoading") as MovieClip;
			rateTxt.text = "0%";
			this.addChild(preloader);
		}
		
		private function get rateTxt():TextField
		{
			if (preloader.rateTxt)
			{
				return preloader.rateTxt as TextField;
			}
			return new TextField();
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}