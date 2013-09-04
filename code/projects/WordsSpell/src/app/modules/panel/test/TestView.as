package app.modules.panel.test
{
	import com.riaidea.text.RichTextField;
	
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.text.TextFormat;
	
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
		private var itemContainer:Sprite;
		private var gameScroll:GameScrollPanel;
		
		public function TestView()
		{
			
		}
		
		override protected function setSkinWithName(skinName:String):void
		{
			super.setSkinWithName( skinName );
			
			itemContainer = new Sprite();
			itemContainer.x = 55;
			itemContainer.y = 35;
			addChild( itemContainer );
			gameScroll = new GameScrollPanel();
			gameScroll.setTargetShow(itemContainer, 0, 0, 440, 330);
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			for (var i:int = 0; i < 24; i++)
			{
				var item:TestItem = new TestItem();
				item.setIndex( i );
				itemContainer.addChild( item );
			}
			gameScroll.updateMainHeight( itemContainer.height );
			gameScroll.setPos( 0 );
			
			var rtf:RichTextField = new RichTextField();
			rtf.x = 10;
			rtf.y = 10;
			rtf.html = true;
			rtf.setSize( 500, 50 );
			addChild(rtf);
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
			
		}
		
		protected function linkHandler(event:TextEvent):void
		{
			trace( event.text );
		}
		
		override protected function openComplete():void
		{
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