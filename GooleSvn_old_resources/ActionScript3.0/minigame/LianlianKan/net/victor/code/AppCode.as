package net.victor.code
{
	import flash.display.Sprite;
	import net.victor.ui.BaseMc;
	import flash.utils.getDefinitionByName;
	import flash.display.DisplayObject;
	import net.victor.ui.DefaultMc;
	import net.victor.ui.MC001;
	import net.victor.ui.MC002;
	import net.victor.ui.MC003;
	import net.victor.ui.MC004;
	import net.victor.ui.MC005;
	import net.victor.ui.MC006;
	import net.victor.ui.MC007;
	import net.victor.ui.MC008;
	import net.victor.ui.MC009;
	import net.victor.ui.MC010;
	import net.victor.ui.MC012;
	import net.victor.ui.MC013;
	import net.victor.ui.MC014;
	import net.victor.ui.MC015;
	import net.victor.ui.MC016;
	import net.victor.ui.MC011;
	import net.victor.ui.MC017;
	import net.victor.ui.MC018;
	import net.victor.ui.MC019;
	import net.victor.ui.MC020;
	import net.victor.ui.MC021;
	import net.victor.ui.MC022;
	import net.victor.ui.MC025;
	import net.victor.ui.MC023;
	import net.victor.ui.MC024;
	import flash.events.MouseEvent;

	public class AppCode extends Sprite
	{
		/** 显示容器 */
		private var disContainer:Sprite;
		/** 存储显示容器中的显示对象 */
		private var disArr:Array;
		private var initDisArr:Array;
		private var clickTarget:BaseMc;
		
		/** 起始位置 */
		private const startXY:int = 25;
		/** 间距 */
		private const distanceXY:int = 55;
		/** 列数 */
		private const lineX:int = 10;
		/** 行数 */
		private const lineY:int = 5;

		public function AppCode()
		{
			super();
			
			initVars();
			initLayout();
			addAndRemoveEvent(true);
		}
		
		///////////////////////  public ///////////////////////////
		
		
		
		///////////////////////  private ///////////////////////////
		
		private function initVars():void
		{
			disContainer = new Sprite();
			disContainer.mouseEnabled = false;
			this.addChild(disContainer);
			
			disArr = new Array();
			initDisArr = [MC001, MC001, MC002, MC002, MC003 ,MC003,
						  MC004, MC004, MC005, MC005, MC006 ,MC006,
						  MC007, MC007, MC008, MC008, MC009 ,MC009,
						  MC010, MC010, MC012, MC012, MC013 ,MC013,
						  MC014, MC014, MC015, MC015, MC016 ,MC016,
						  MC011, MC011, MC017, MC017, MC018 ,MC018,
						  MC019, MC019, MC020, MC020, MC021 ,MC021,
						  MC022, MC022, MC023, MC023, MC024 ,MC024,
						  MC025, MC025
						  ];
						  
		}
		
		private function initLayout():void
		{
			var lenX:int = lineX + 2;
			var lenY:int = lineY + 2;
			var len:int = lenX * lenY;
			
			for (var i:int = 0; i < len; i++)
			{
				var bmc:BaseMc;
				if ( int(i / lenX) == 0 || int(i / lenX) == lenY - 1 || i % lenX == 0 || i % lenX == lenX - 1)
				{
					bmc = new DefaultMc();
				}
				else
				{
					var rand:int = int(Math.random() * initDisArr.length);
					var cls:Class = initDisArr.splice(rand, 1)[0];
					bmc = new cls();
				}
				
				bmc.hideWireFrame();
				
				bmc.x = startXY + distanceXY * (i % lenX);
				bmc.y = startXY + distanceXY * (int(i / lenX));
				
				disContainer.addChild(bmc);
				
				if (disArr == null) disArr = new Array();
				if (disArr[int(i / lenX)] == null) disArr[int(i / lenX)] = [];
				bmc.lineX = i % lenX;
				bmc.lineY = int(i / lenX);
				disArr[int(i / lenX)][i % lenX] = bmc;
				
			}
		}
		
		private function searchCondition($target1:BaseMc, $target2:BaseMc, $type:String):Array
		{
			var tg1:BaseMc = disArr[clickTarget.lineY][clickTarget.lineX + 1];
			var tg2:BaseMc = disArr[clickTarget.lineY][clickTarget.lineX - 1];
			var tg3:BaseMc = disArr[clickTarget.lineY + 1][clickTarget.lineX];
			var tg4:BaseMc = disArr[clickTarget.lineY - 1][clickTarget.lineX];
			
			if ($type == AppType.left)
			{
				
			}
			else if ($type == AppType.right)
			{
				
			}
			else if ($type == AppType.up)
			{
				
			}
			else if ($type == AppType.down)
			{
				
			}
			else if ($type == AppType.any)
			{
				
			}
			return [];
		}
		
		///////////////////////  events ///////////////////////////
		
		private function addAndRemoveEvent(isAdd:Boolean):void
		{
			if (isAdd)
			{
				disContainer.addEventListener(MouseEvent.CLICK, clickContainerHandler);
			}
			else
			{
				disContainer.removeEventListener(MouseEvent.CLICK, clickContainerHandler);
			}
		}
		
		private function clickContainerHandler(e:MouseEvent):void
		{
			var bmc:BaseMc = e.target as BaseMc;
			if (clickTarget)
			{
				if (clickTarget.id == bmc.id)
				{
					if (clickTarget.lineX > bmc.lineX && clickTarget.lineY == bmc.lineY)
					{
						searchCondition(clickTarget, bmc, AppType.right);
					}
					else if (clickTarget.lineX < bmc.lineX && clickTarget.lineY == bmc.lineY)
					{
						searchCondition(clickTarget, bmc, AppType.left);
					}
					else if (clickTarget.lineX == bmc.lineX && clickTarget.lineY > bmc.lineY)
					{
						searchCondition(clickTarget, bmc, AppType.down);
					}
					else if (clickTarget.lineX == bmc.lineX && clickTarget.lineY < bmc.lineY)
					{
						searchCondition(clickTarget, bmc, AppType.up);
					}
					else
					{
						searchCondition(clickTarget, bmc, AppType.any);
					}
					clickTarget.parent.removeChild(clickTarget);
					bmc.parent.removeChild(bmc);
					bmc = null;
				}
				clickTarget.isClickOthers();
			}
			if (bmc == null) return ;
			bmc.isClickDown();
			clickTarget = bmc;
		}
		
	}

}