package app.core
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	import app.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class ProgressBar extends Sprite
	{
		private var bgShape:Shape;
		private var barShape:Shape;
		private var txtLoading:TextField;
		private var barW:Number;
		private var barH:Number;
		private var ellipseH:Number;
		
		public function ProgressBar( w:Number, isCenter:Boolean = false )
		{
			barW = w;
			barH = 40;
			ellipseH = 40;
			
			bgShape = new Shape();
			bgShape.graphics.lineStyle( 2, 0xffffff, 0.8 );
			bgShape.graphics.beginFill( 0xffffff );
			bgShape.graphics.drawRoundRect( 0,0, barW, barH, ellipseH );
			bgShape.graphics.endFill();
			addChild( bgShape );
			
			barShape = new Shape();
			addChild( barShape );
			
			txtLoading = DisplayUtil.getTextFiled( 34, 0xffffff, TextFormatAlign.CENTER);
			txtLoading.text = "已下载：0%";
			txtLoading.width = barW;
			txtLoading.height = txtLoading.textHeight + 5;
			txtLoading.y = isCenter ? ( barH - txtLoading.textHeight ) * 0.5 : ( barH + 10 );
			addChild( txtLoading );
			
			setProgress( 0 );
		}
		
		public function setProgress(value:Number):void
		{
			barShape.graphics.clear();
			barShape.graphics.beginFill( 0x00CC33 );
			barShape.graphics.drawRoundRect(0,0,barW * value, barH, ellipseH );
			barShape.graphics.endFill();
			
			txtLoading.text = "已下载：" + (( value * 100 ).toFixed( 2 )) + "%";
		}
		
		
	}
}