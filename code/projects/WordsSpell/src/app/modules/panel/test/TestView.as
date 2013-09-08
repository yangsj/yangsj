package app.modules.panel.test
{
	import com.riaidea.text.RichTextField;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextFormat;
	
	import app.core.Alert;
	import app.core.components.controls.combo.ComboBox;
	import app.core.components.controls.combo.ComboData;
	import app.core.components.controls.combo.ComboItemVo;
	import app.managers.LoaderManager;
	import app.utils.log;
	
	import victor.framework.components.TabButtonControl;
	import victor.framework.components.scroll.GameScrollPanel;
	import victor.framework.core.BasePanel;
	import victor.framework.utils.HtmlText;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class TestView extends BasePanel
	{
		private var container:Sprite;
		
		public function TestView()
		{
			
		}
		
		override protected function setSkinWithName(skinName:String):void
		{
			super.setSkinWithName( skinName );
			
			
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			var funcNames:Array = [
				 "滚动条测试"
				,"富文本测试"
				,"ComboBox"
				,"Alert"
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				,""
				];
			
			container = new Sprite();
			container.y = 30;
			addChild( container );
			
			var tabControl:TabButtonControl = new TabButtonControl( tabButtonControl );
			for (var i:int = 0; i < funcNames.length; i++)
			{
				var mc:MovieClip = LoaderManager.instance.getObj( "test_ui_SkinTabTest", domainName ) as MovieClip;
				mc.x = -170 + 85 * (i % 11);
				mc.y = -30 * int(i/11);
				mc.txtLabel.text = funcNames[ i ] + "";
				addChild( mc );
				tabControl.addTarget( mc );
				container.addChild( new Sprite() );
			}
			tabControl.setTargetByIndex( 0 );
		}
		
		private function tabButtonControl( target:MovieClip, tabName:* ):void
		{
			for (var i:int = 0; i < container.numChildren;i++)
				container.getChildAt( i ).visible = false;
			
			var temp:Sprite = container.getChildAt( int( tabName ) ) as Sprite;
			temp.visible = true;
			if ( temp.numChildren == 0 )
			{
				switch ( tabName )
				{
					case 0:
						testScrollPanel( temp );
						break;
					case 1:
						testRichTextField( temp );
						break;
					case 2:
						testComboBox( temp );
						break;
					case 3:
						testAlert( temp );
						break;
				}
			}
		}
		
		private function testScrollPanel( con:Sprite ):void
		{
			var itemContainer:Sprite = new Sprite();
			itemContainer.x = 55;
			itemContainer.y = 35;
			con.addChild( itemContainer );
			var gameScroll:GameScrollPanel = new GameScrollPanel();
			gameScroll.setTargetShow(itemContainer, 0, 0, 440, 330);
			
			for (var i:int = 0; i < 24; i++)
			{
				var item:TestItem = new TestItem();
				item.setIndex( i );
				itemContainer.addChild( item );
			}
			gameScroll.updateMainHeight( itemContainer.height );
			gameScroll.setPos( 0 );
		}
		
		private function testRichTextField( con:Sprite ):void
		{
			var rtf:RichTextField = new RichTextField();
			rtf.x = 10;
			rtf.y = 10;
			rtf.html = true;
			rtf.setSize( 500, 50 );
			con.addChild(rtf);
			rtf.textfield.selectable = false;
			rtf.defaultTextFormat = new TextFormat("Arial", 20, 0x000000);
			rtf.textfield.addEventListener(TextEvent.LINK, linkHandler );
//			rtf.append( HtmlText.urlEvent("this", "yangsj", 0xff0000)+ "  is test RichTextField",[{index:5, index:5, src:"ui_test_skin"}], true);
			var xml:XML = 	<rtf>
							  <htmlText></htmlText>
							  <sprites>
								<sprite src="ui_test_skin" index="4"/>
							  </sprites>
							</rtf>

			xml.htmlText[0] = HtmlText.urlEvent( "this", "yangsj,victor,king", 0xff0000) + "  is RichTextField";
			rtf.importXML( xml );
			trace( rtf.exportXML() );
			function linkHandler(event:TextEvent):void
			{
				log( event.text );
			}
		}
		
		private function testComboBox( con:Sprite ):void
		{
			var comboData:ComboData = new ComboData();
			for (var i:int = 0; i < 10; i++)
			{
				var vo:ComboItemVo = new ComboItemVo();
				vo.label = "label_" + i;
				comboData.addItem( vo );
			}
			
			var comboBox:ComboBox = new ComboBox( comboData );
			con.addChild( comboBox );
			
			var comboBox1:ComboBox = new ComboBox( comboData, 100 );
			con.addChild( comboBox1 );
			comboBox1.x = 200;
		}
		
		protected function testAlert( con:Sprite ):void
		{
			Alert.show( "希望每个单身的人都能够相信爱情，一爱再爱不要低下头，最终有情人终成眷属。", function abc( type:uint ):void{ log( type )}, "下一关" );
		}
		
		override protected function openComplete():void
		{
		}
		
		override public function hide():void
		{
			super.hide();
		}
		
		override protected function get skinName():String
		{
			return "test.UITestViewPanel";
		}
		
		override protected function get resNames():Array
		{
			return [ "testPanel"];
		}
		
		override protected function get domainName():String
		{
			return "testPanel";
		}
		
	}
}