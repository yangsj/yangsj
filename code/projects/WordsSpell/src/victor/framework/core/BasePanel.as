package victor.framework.core
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
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
		
		private var hideX:Number;
		private var hideY:Number;
		
		public function BasePanel()
		{
		}
		
////////////// events handlers /////////////////
		
		protected function dragTargetMouseHandler(event:MouseEvent):void
		{
			if ( event.type == MouseEvent.MOUSE_DOWN )
			{
				dragTarget.buttonMode = true;
				startDrag( false, new Rectangle(-rectangle.x, -rectangle.y, appStage.stageWidth - dragTarget.width, appStage.stageHeight - dragTarget.height));
				appStage.addEventListener(MouseEvent.MOUSE_UP, dragTargetMouseHandler );
			}
			else if ( event.type == MouseEvent.MOUSE_UP )
			{
				stopDrag();
				dragTarget.buttonMode = false;
				appStage.removeEventListener(MouseEvent.MOUSE_UP, dragTargetMouseHandler );
			}
		}
		
		private function btnCloseClickHandler(event:MouseEvent):void
		{
			hide();
		}

///////////// override functions ///////////////////////////
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			if ( btnClose )
			{
				btnClose.addEventListener(MouseEvent.CLICK, btnCloseClickHandler );
				if (　btnClose.hasOwnProperty( "buttonMode" ) )
				{
					btnClose["buttonMode"] = true;
				}
			}
			
			if ( dragTarget )
				dragTarget.addEventListener(MouseEvent.MOUSE_DOWN, dragTargetMouseHandler );
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			if ( btnClose )
				btnClose.removeEventListener(MouseEvent.CLICK, btnCloseClickHandler );
			
			if ( dragTarget )
				dragTarget.removeEventListener(MouseEvent.MOUSE_DOWN, dragTargetMouseHandler );
			
			btnClose = null;
			dragTarget = null;
		}
		
		override public function show():void
		{
			if ( resNames && resNames.length == 0 )
				addDisplayList();
			
			else startLoadResource();
		}

		override public function hide():void
		{
			mouseChildren = false;
			
			hideX = x;
			hideY = y;
			TweenMax.killTweensOf( this );
			TweenMax.to( this, 0.3, { scaleX: 0.6, scaleY: 0.6, alpha: 0, ease: Back.easeIn, onUpdate: changePosAtHide, onComplete: ViewStruct.removePanel, onCompleteParams: [ this ]});
		}

////////////// private functions //////////////////////////////////
		
		private function changePosAtOpen():void
		{
			x = (( appStage.stageWidth - rectangle.width * scaleX ) >> 1 ) - rectangle.x * scaleX;
			y = (( appStage.stageHeight - rectangle.height * scaleX ) >> 1 ) - rectangle.y * scaleY;
		}
		
		private function changePosAtHide():void
		{
			x = hideX + (( rectangle.width - rectangle.width * scaleX ) >> 1 );
			y = hideY + (( rectangle.height - rectangle.height * scaleX ) >> 1 );
		}
		
		private function addDisplayList():void
		{
			mouseChildren = true;
			
			PanelLoading.instance.hide();
			
			loadComplete();
			
			ViewStruct.addPanel( this );
			
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			
			changePosAtOpen();
			
			TweenMax.killTweensOf( this );
			TweenMax.to( this, 0.5, { scaleX: 1, scaleY: 1, alpha: 1, onUpdate: changePosAtOpen, ease: Back.easeOut, onComplete:openComplete });
		}
		
		private function startLoadResource():void
		{
			PanelLoading.instance.show();
			LoaderManager.instance.load( resNames, addDisplayList, loadProgress, domainName );
		}
		
		private function loadProgress( perent:Number ):void
		{
			PanelLoading.instance.setProgressValue( perent );
		}
		
///////////////// protected functions //////////////////////////////
		
		protected function openComplete():void
		{
		}
		
		protected function loadComplete():void
		{
		}

///////////////// getters/setters ////////////////////////////////
		
		/**
		 * 需要加载的资源在配置文件中名称清单，若是该数组的长度是0，则默认不加载
		 */
		protected function get resNames():Array
		{
			return [];
		}

	}
}
