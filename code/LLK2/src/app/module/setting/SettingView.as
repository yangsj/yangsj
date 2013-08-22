package app.module.setting
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import app.AppStage;
	import app.manager.SoundManager;
	import app.module.model.Global;
	
	import framework.BasePanel;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class SettingView extends BasePanel
	{
		private var bgSndBar:Bar;
		private var effectSndBar:Bar;
		private var vibrateSwitch:Switch;
		private var container:Sprite;
		
		public function SettingView()
		{
			
			this.graphics.beginFill(0);
			this.graphics.drawRect(0,0,AppStage.stageWidth, AppStage.stageHeight);
			this.graphics.endFill();
			
			container = new Sprite();
			addChild( container );
			
			bgSndBar = new Bar("背景音乐", SoundManager.setBgSndVoice);
			effectSndBar = new Bar("音效音量", SoundManager.setEffectSndVoice);
			vibrateSwitch = new Switch("震动开关", switchCallBack);
			
			effectSndBar.y = bgSndBar.y + bgSndBar.height * 2;
			vibrateSwitch.y = effectSndBar.y + effectSndBar.height * 2;
			
			container.addChild( bgSndBar );
			container.addChild( effectSndBar );
			container.addChild( vibrateSwitch );
			
			container.y = 200;
			container.x = (AppStage.stageWidth - container.width)>> 1;
			
			AppStage.adjustXYScaleXY( container );
			
			initValue();
			
			super();
		}
		
		private function switchCallBack():void
		{
			Global.switchResultVibrate = vibrateSwitch.switchResult;
		}
		
		public function initValue():void
		{
			bgSndBar.setValue( SoundManager.bgSndTransform.volume );
			effectSndBar.setValue( SoundManager.effectSndTransform.volume );
		}
		
		override protected function clickHandler(event:MouseEvent):void
		{
			if ( event.target is SettingView )
			{
				super.clickHandler( event );
			}
		}
		
	}
}