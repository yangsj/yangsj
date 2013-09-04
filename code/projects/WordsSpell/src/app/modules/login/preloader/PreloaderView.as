package app.modules.login.preloader
{
	import flash.text.TextField;
	
	import victor.framework.core.BaseScene;
	import victor.framework.utils.TextFiledUtil;
	import app.utils.appStage;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class PreloaderView extends BaseScene
	{
		public var txtValue:TextField;
		
		public function PreloaderView()
		{
			super();
			
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, appStage.stageWidth, appStage.stageHeight);
			this.graphics.endFill();
		}
		
		public function setProgressValue( value:Number ):void
		{
			txtValue ||= TextFiledUtil.create( "", 45, 0xffffff );
			txtValue.text = ( value * 100 ).toFixed( 2 ) + "%";
			txtValue.width = txtValue.textWidth + 15;
			txtValue.height = txtValue.textHeight + 5;
			txtValue.x = ( width - txtValue.textWidth ) >> 1;
			txtValue.y = ( height - txtValue.textHeight ) >> 1;
			addChild( txtValue );
		}
		
	}
}