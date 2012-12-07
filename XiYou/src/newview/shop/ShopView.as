package newview.shop
{
	import newview.SpriteBase;
	
	import ui.shop.ResourceShopView;
	
	
	/**
	 * 说明：ShopView
	 * @author Victor
	 * 2012-11-14
	 */
	
	public class ShopView extends SpriteBase
	{
		
		private var shopView:ResourceShopView;
		
		public function ShopView()
		{
			super();
		}
		
		override protected function createResource():void
		{
			shopView = new ResourceShopView();
			addChild(shopView);
		}
		
		
		
	}
	
}