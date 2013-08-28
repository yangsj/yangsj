package victor.framework.core
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import app.managers.LoaderManager;
	import app.modules.panel.PanelLoading;
	import app.utils.appStage;
	
	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BasePanel extends ViewSprite
	{
		
		/**
		 * 关闭按钮
		 */
		public var btnClose:InteractiveObject;
		/**
		 * 拖拽对象
		 */
		public var dragTarget:Sprite;
		
		public function BasePanel()
		{
		}
		
		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler( event );
			
			if ( btnClose )
				btnClose.addEventListener(MouseEvent.CLICK, btnCloseClickHandler );
			
			if ( dragTarget )
				dragTarget.addEventListener(MouseEvent.MOUSE_DOWN, dragTargetMouseHandler );
		}
		
		override protected function removedFromStageHandler(event:Event):void
		{
			super.removedFromStageHandler( event );
			
			if ( btnClose )
				btnClose.removeEventListener(MouseEvent.CLICK, btnCloseClickHandler );
			
			if ( dragTarget )
				dragTarget.removeEventListener(MouseEvent.MOUSE_DOWN, dragTargetMouseHandler );
		}
		
		protected function dragTargetMouseHandler(event:MouseEvent):void
		{
			if ( event.type == MouseEvent.MOUSE_DOWN )
			{
				var rect:Rectangle = this.getBounds( this );
				dragTarget.buttonMode = true;
				this.startDrag( false, new Rectangle(-rect.x, -rect.y, appStage.stageWidth - dragTarget.width, appStage.stageHeight - dragTarget.height));
				appStage.addEventListener(MouseEvent.MOUSE_UP, dragTargetMouseHandler );
			}
			else if ( event.type == MouseEvent.MOUSE_UP )
			{
				this.stopDrag();
				dragTarget.buttonMode = false;
				appStage.removeEventListener(MouseEvent.MOUSE_UP, dragTargetMouseHandler );
			}
		}
		
		private function btnCloseClickHandler(event:MouseEvent):void
		{
			hide();
		}
		
		override public function show():void
		{
			if ( resNames && resNames.length == 0 )
				addDisplayList();
			
			else startLoadResource();
		}

		override public function hide():void
		{
			TweenMax.killTweensOf( this );
			TweenMax.to( this, 0.3, { scaleX: 0.6, scaleY: 0.6, alpha: 0, ease: Back.easeIn, onUpdate: changePos, onComplete: ViewStruct.removePanel, onCompleteParams: [ this ]});
		}

		private function changePos():void
		{
			var rect:Rectangle = this.getBounds( this );
			x = (( appStage.stageWidth - rect.width * scaleX ) >> 1 ) - rect.x * scaleX;
			y = (( appStage.stageHeight - rect.height * scaleY ) >> 1 ) - rect.y * scaleY;
		}
		
		private function addDisplayList():void
		{
			PanelLoading.instance.hide();
			
			loadComplete();
			
			ViewStruct.addPanel( this );
			
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			
			changePos();
			
			TweenMax.to( this, 0.5, { scaleX: 1, scaleY: 1, alpha: 1, onUpdate: changePos, ease: Back.easeOut });
		}
		
		private function startLoadResource():void
		{
			PanelLoading.instance.show();
			LoaderManager.instance.load( resNames, addDisplayList, loadProgress);
		}
		
		private function loadProgress( perent:Number ):void
		{
			PanelLoading.instance.setProgressValue( perent );
		}
		
		protected function loadComplete():void
		{
		}
		
		/**
		 * 需要加载的资源在配置文件中名称清单，若是该数组的长度是0，则默认不加载
		 */
		protected function get resNames():Array
		{
			return [];
		}

	}
}
