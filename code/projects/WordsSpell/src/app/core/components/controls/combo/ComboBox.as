package app.core.components.controls.combo
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.core.components.controls.ControlFrameType;
	import app.utils.appStage;
	
	import victor.framework.components.scroll.GameScrollPanel;
	import victor.framework.interfaces.IDisposable;
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-7
	 */
	public class ComboBox extends Sprite implements IDisposable
	{
		private var skin:ui_SkinComboBox;
		
		private var upSkin:Sprite;
		private var overSkin:Sprite;
		private var downSkin:Sprite;
		private var txtLabel:TextField;
		
		private var comboData:ComboData;
		private var container1:Sprite;
		private var container2:Sprite;
		private var scrollPanel:GameScrollPanel;
		
		private var _selectedItem:ComboItem;
		
		public function ComboBox( comboVo:ComboData = null, skinWidth:Number = 150 )
		{
			skin = new ui_SkinComboBox();
			addChild( skin );
			
			skin.mouseChildren = false;
			
			upSkin = skin.upSkin;
			overSkin = skin.overSkin;
			downSkin = skin.downSkin;
			txtLabel = skin.txtLabel;
			
			upSkin.width = skinWidth;
			overSkin.width = skinWidth;
			downSkin.width = skinWidth;
			txtLabel.width = skinWidth - 30;
			
			container1 = new Sprite();
			container1.y = skin.height;
			addChild( container1 );
			
			container2 = new Sprite();
			container1.addChild( container2 );
			
			scrollPanel = new GameScrollPanel();
			scrollPanel.setTargetShow( container2, 0, 0, skinWidth, 105 );
			
			addEventListener( ComboEvent.SELECTED, selectedItemHandler );
			skin.addEventListener( MouseEvent.ROLL_OUT, skinMouseHandler );
			skin.addEventListener( MouseEvent.ROLL_OVER, skinMouseHandler );
			skin.addEventListener( MouseEvent.MOUSE_DOWN, skinMouseHandler );
			skin.addEventListener( MouseEvent.MOUSE_UP, skinMouseHandler );
			
			container1.visible = false;
			
			if ( comboVo )
			{
				setData( comboVo );
			}
		}
		
		protected function skinMouseHandler( event:MouseEvent ):void
		{
			var type:String = event.type;
			if ( type == MouseEvent.ROLL_OUT )
			{
				setSkinStatus( ControlFrameType.FRAME_UP );
			}
			else if ( type == MouseEvent.ROLL_OVER )
			{
				setSkinStatus( ControlFrameType.FRAME_OVER );
			}
			else if ( type == MouseEvent.MOUSE_DOWN )
			{
				setSkinStatus( ControlFrameType.FRAME_DOWN );
				container1.visible = !container1.visible;
			}
			else if ( type == MouseEvent.MOUSE_UP )
			{
				setSkinStatus( ControlFrameType.FRAME_OVER );
			}
		}
		
		protected function stageClickHandler( event:MouseEvent ):void
		{
			appStage.removeEventListener(MouseEvent.CLICK, stageClickHandler );
			container1.visible = false;
		}
		
		private function setSkinStatus( frameLabel:String ):void
		{
			upSkin.visible = frameLabel == ControlFrameType.FRAME_UP;
			overSkin.visible = frameLabel == ControlFrameType.FRAME_OVER;
			downSkin.visible = frameLabel == ControlFrameType.FRAME_DOWN;
		}
		
		protected function selectedItemHandler( event:ComboEvent ):void
		{
			var item:ComboItem = event.data as ComboItem;
			if ( _selectedItem )
			{
				_selectedItem.isSelected = false;
				_selectedItem.setSkinStatus( ControlFrameType.FRAME_UP );
			}
			if ( item )
			{
				_selectedItem = item;
				_selectedItem.isSelected = true;
				item.setSkinStatus( ControlFrameType.FRAME_DOWN );
				txtLabel.text = item.data.label;
				container1.visible = false;
			}
		}
		
		public function dispose():void
		{
			removeEventListener( ComboEvent.SELECTED, selectedItemHandler );
			if ( skin )
			{
				skin.removeEventListener( MouseEvent.ROLL_OUT, skinMouseHandler );
				skin.removeEventListener( MouseEvent.ROLL_OVER, skinMouseHandler );
				skin.removeEventListener( MouseEvent.MOUSE_DOWN, skinMouseHandler );
				skin.removeEventListener( MouseEvent.MOUSE_UP, skinMouseHandler );
			}
			disposeItems();
			if ( scrollPanel )
				scrollPanel.dispose();
			DisplayUtil.removedFromParent( skin );
			skin = null;
			upSkin = null;
			overSkin = null;
			downSkin = null;
			txtLabel = null;
			scrollPanel = null;
			_selectedItem = null;
		}
		
		public function setData( comboVo:ComboData ):void
		{
			if ( comboData != comboVo )
			{
				comboData = comboVo;
				
				createList();
			}
		}
		
		private function createList():void
		{
			disposeItems();
			
			var item:ComboItem;
			var defaultItem:ComboItem;
			for each (var vo:ComboItemVo in comboData.list )
			{
				item = new ComboItem( vo, width );
				item.y = container2.height;
				container2.addChild( item );
				defaultItem ||= item;
			}
			defaultItem.selectedDefault();
			scrollPanel.updateMainHeight( container2.height );
			scrollPanel.setPos( 0 );
		}
		
		private function disposeItems():void
		{
			if ( container2 )
			{
				var item:ComboItem;
				while ( container2.numChildren > 0 )
				{
					item = container2.removeChildAt( 0 ) as ComboItem;
					if ( item )
						item.dispose();
				}
			}
		}

		public function get selectedItem():ComboItem
		{
			return _selectedItem;
		}

		
	}
}