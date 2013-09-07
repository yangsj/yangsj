package app.core.components.controls.combo
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.core.components.controls.ControlFrameType;
	
	import victor.framework.interfaces.IDisposable;
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-7
	 */
	public class ComboItem extends Sprite implements IDisposable
	{
		private var skin:ui_SkinComboBox_Item;
		
		private var upSkin:Sprite;
		private var overSkin:Sprite;
		private var downSkin:Sprite;
		private var txtLabel:TextField;
		
		private var _isSelected:Boolean = false;
		
		private var _data:ComboItemVo;
		
		public function ComboItem( itemVo:ComboItemVo, skinWidth:Number = 150 )
		{
			
			skin = new ui_SkinComboBox_Item();
			addChild( skin );
			
			upSkin = skin.upSkin;
			overSkin = skin.overSkin;
			downSkin = skin.downSkin;
			txtLabel = skin.txtLabel;
			
			upSkin.width = skinWidth;
			overSkin.width = skinWidth;
			downSkin.width = skinWidth;
			
			txtLabel.width = skinWidth - 25;
			
			mouseChildren = false;
			data = itemVo;
			
			addEventListener( MouseEvent.CLICK, mouseHandler );
			addEventListener( MouseEvent.ROLL_OUT, mouseHandler );
			addEventListener( MouseEvent.ROLL_OVER, mouseHandler );
			
			data = itemVo;
			
		}
		
		private function setLabel():void
		{
			txtLabel.text = data.label;
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			var type:String = event.type;
			if ( type == MouseEvent.CLICK )
			{
				_isSelected = true;
				dispatchEvent( new ComboEvent( ComboEvent.SELECTED, this, true ));
				setSkinStatus( ControlFrameType.FRAME_DOWN );
			}
			else if ( type == MouseEvent.ROLL_OUT )
			{
				setSkinStatus( ControlFrameType.FRAME_UP );
			}
			else if ( type == MouseEvent.ROLL_OVER )
			{
				setSkinStatus( ControlFrameType.FRAME_OVER );
			}
		}
		
		public function selectedDefault():void
		{
			dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
		}
		
		public function setSkinStatus( frameLabel:String ):void
		{
			upSkin.visible = _isSelected == false && frameLabel == ControlFrameType.FRAME_UP;
			overSkin.visible = _isSelected == false && frameLabel == ControlFrameType.FRAME_OVER;
			downSkin.visible = _isSelected || frameLabel == ControlFrameType.FRAME_DOWN;
		}
		
		public function dispose():void
		{
			removeEventListener( MouseEvent.CLICK, mouseHandler );
			removeEventListener( MouseEvent.ROLL_OUT, mouseHandler );
			removeEventListener( MouseEvent.ROLL_OVER, mouseHandler );
			
			DisplayUtil.removedFromParent( skin );
			
			data = null;
			upSkin = null;
			overSkin = null;
			downSkin = null;
			txtLabel = null;
		}

		public function get data():ComboItemVo
		{
			return _data;
		}

		public function set data(value:ComboItemVo):void
		{
			_data = value;
			
			setLabel();
		}

		public function get isSelected():Boolean
		{
			return _isSelected;
		}

		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
		}

		
	}
}