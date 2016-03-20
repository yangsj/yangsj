package gem.view.dispel
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.dispelscene.ResourceGem_1;
	import ui.dispelscene.ResourceGem_10;
	import ui.dispelscene.ResourceGem_2;
	import ui.dispelscene.ResourceGem_3;
	import ui.dispelscene.ResourceGem_4;
	import ui.dispelscene.ResourceGem_5;
	import ui.dispelscene.ResourceGem_6;
	import ui.dispelscene.ResourceGem_7;
	import ui.dispelscene.ResourceGem_8;
	import ui.dispelscene.ResourceGem_9;
	import ui.dispelscene.ResourceProp_101;
	import ui.dispelscene.ResourceProp_102;
	import ui.dispelscene.ResourceProp_103;
	import ui.dispelscene.ResourceProp_104;
	import ui.dispelscene.ResourceProp_105;
	import ui.dispelscene.ResourceProp_106;
	import ui.dispelscene.ResourceProp_107;
	import ui.dispelscene.ResourceProp_108;
	import ui.dispelscene.ResourceProp_109;
	
	
	/**
	 * 说明：Gem
	 * @author Victor
	 * 2012-10-7
	 */
	
	public class Gem extends Sprite
	{
		// some const vars 
		public static var WIDTH:Number = 53;
		public static var HEIGHT:Number = 53;
		public static var WIDTH_HALF:Number = 26.5;
		public static var HEIGHT_HALF:Number = 26.5;
		
		// some public attribute
		public var rows:int = 0; // vertical direction
		public var cols:int = 0; // horizontal direction
		public var endY:Number = 0; // the end stop y axis point
		public var id:int = 0; // the mark of same gems 
		public var former_x:Number; // gems former x axis point(end stop x axis)
		public var former_y:Number; // gems former y axis point(end stop y axis)
		public var isPushToMove:Boolean = false; // in seek, a mark push to move array
		public var moveType:int = 0; // the prompt move direction
		
		///
		
		private static const PREFIX_POOL_NAME:String = "PREFIX_POOL_NAME";
		
		private var gems:DisplayObject;
		private var changeTwoTime:Number = 0.2;
		
		public static function create($id:int=0):Gem
		{
			if (DispelPool.hasObject(PREFIX_POOL_NAME + $id))
			{
				return DispelPool.getObject(PREFIX_POOL_NAME + $id) as Gem;
			}
			else
			{
				return new Gem($id);
			}
		}
		
		public function Gem($id:int=0)
		{
			id = $id;
			draw();
			this.mouseChildren = false;
			addTransparentBg();
			setArrowMcAttr(false);
		}
		
		public function redraw($id:int):void
		{
			if (id != $id)
			{
				if (gems && gems.parent) gems.parent.removeChild(gems);
				id = $id;
				draw();
			}
		}
		
		/**
		 * 灰色状态
		 */
		public function grayStatus():void
		{
			grayMc.visible 		= true;
			brightMc.visible 	= false;
		}
		
		/**
		 * 正常状态（亮色状态）
		 */
		public function brightStatus():void
		{
			grayMc.visible 		= false;
			brightMc.visible 	= true;
		}
		
		public function setRowsCols($rows:int, $cols:int):void
		{
			this.rows = $rows;
			this.cols = $cols;
			this.scaleX = this.scaleY = this.alpha = 1;
		}
		
		public function setFormerPointValue(formerX:Number, formerY:Number):void
		{
			this.former_x = formerX;
			this.former_y = formerY;
			this.scaleX = this.scaleY = this.alpha = 1;
		}
		
		/**
		 * 移动到指定的点
		 * @param $x 指定的x值
		 * @param $y 指定的y值
		 */
		public function moveTo($x:Number, $y:Number):void
		{
			setThisParentEnabled(false);
			TweenMax.to(this, changeTwoTime, {x:$x, y:$y, onComplete:tweenOnCompelte, onCompleteParams:[false]});
		}
		
		/**
		 * 移动到指定的点后返回原来的点位置
		 * @param $x 指定的x值
		 * @param $y 指定的y值
		 */
		public function moveBack($x:Number, $y:Number, $index:int):void
		{
			setThisParentEnabled(false);
			TweenMax.to(this, changeTwoTime, {x:$x, y:$y, onComplete:tweenOnCompelte, onCompleteParams:[true, $index]});
		}
		
		public function selected():void
		{
			grayStatus();
		}
		
		public function unSelected():void
		{
			brightStatus();
		}
		
		public function prompt():void
		{
			this.parent.addEventListener(MouseEvent.MOUSE_DOWN, promptClickHandler);
			if (moveType > 0)
			{
				setArrowMcAttr(true);
			}
			else
			{
				setArrowMcAttr(false);
			}
		}
		
		public function removeFromParent():void
		{
			TweenMax.to(this, 0.3, {scaleX:0, scaleY:0, alpha:0, onComplete:tweenHandler});
		}
		
		protected function promptClickHandler(event:MouseEvent):void
		{
			this.parent.removeEventListener(MouseEvent.MOUSE_DOWN, promptClickHandler);
			setArrowMcAttr(false);
		}
		
		private function tweenHandler():void
		{
			DispelPool.setObject(this, PREFIX_POOL_NAME + id);
			if (this.parent) this.parent.removeChild(this);
			TweenMax.killTweensOf(this);
			this.scaleX = this.scaleY = this.alpha = 1;
			isPushToMove = false;
			
			setArrowMcAttr(false);
		}
		
		private function setArrowMcAttr($visible:Boolean):void
		{
			moveType = $visible ? moveType : 0;
			arrowMc.visible = moveType > 0 ? $visible : false;
			arrowMc.rotation = $visible ? 90 * (moveType - 1) : 0;
			if ($visible)
				arrowMc["gotoAndPlay"](1);
			else 
				arrowMc["gotoAndStop"](0);
		}
		
		private function draw():void
		{
			switch (id)
			{
				case DispelType.GEM_1:
					gems = new ResourceGem_1();
					break;
				case DispelType.GEM_2:
					gems = new ResourceGem_2();
					break;
				case DispelType.GEM_3:
					gems = new ResourceGem_3();
					break;
				case DispelType.GEM_4:
					gems = new ResourceGem_4();
					break;
				case DispelType.GEM_5:
					gems = new ResourceGem_5();
					break;
				case DispelType.GEM_6:
					gems = new ResourceGem_6();
					break;
				case DispelType.GEM_7:
					gems = new ResourceGem_7();
					break;
				case DispelType.GEM_8:
					gems = new ResourceGem_8();
					break;
				case DispelType.GEM_9:
					gems = new ResourceGem_9();
					break;
				case DispelType.GEM_10:
					gems = new ResourceGem_10();
					break;
				case DispelType.GEM_101:
					gems = new ResourceProp_101();
					break;
				case DispelType.GEM_102:
					gems = new ResourceProp_102();
					break;
				case DispelType.GEM_103:
					gems = new ResourceProp_103();
					break;
				case DispelType.GEM_104:
					gems = new ResourceProp_104();
					break;
				case DispelType.GEM_105:
					gems = new ResourceProp_105();
					break;
				case DispelType.GEM_106:
					gems = new ResourceProp_106();
					break;
				case DispelType.GEM_107:
					gems = new ResourceProp_107();
					break;
				case DispelType.GEM_108:
					gems = new ResourceProp_108();
					break;
				case DispelType.GEM_109:
					gems = new ResourceProp_109();
					break;
			}
			if (gems)
			{
				gems.width = WIDTH;
				gems.height= HEIGHT;
				addChild(gems);
			}
		}
		
		/**
		 * 添加一个透明色块填充四个角空缺部分
		 */
		private function addTransparentBg():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0xff0000, 0);
			this.graphics.drawRect(-WIDTH_HALF, -HEIGHT_HALF, WIDTH, HEIGHT);
			this.graphics.endFill();
		}
		
		private function get grayMc():DisplayObject
		{
			if (gems && gems.hasOwnProperty("grayMc"))
				return gems["grayMc"] as DisplayObject;
			return new Sprite();
		}
		
		private function get brightMc():DisplayObject
		{
			if (gems && gems.hasOwnProperty("brightMc"))
				return gems["brightMc"] as DisplayObject;
			return new Sprite();
		}
		
		private function get arrowMc():MovieClip
		{
			if (gems && gems.hasOwnProperty("arrow"))
				return gems["arrow"] as MovieClip;
			return new MovieClip();
		}
		
		private function tweenOnCompelte(isBack:Boolean, index:int = -1):void
		{
			setThisParentEnabled(!isBack);
			TweenMax.killTweensOf(this);
			if (isBack)
			{
				if (index > -1)
				{
					this.parent.setChildIndex(this, index);
				}
				TweenMax.to(this, changeTwoTime, {x:former_x, y:former_y, onComplete:tweenOnCompelte, onCompleteParams:[false]});
			}
		}
		
		private function setThisParentEnabled(enabled:Boolean):void
		{
			if (this.parent)
			{
				this.parent.mouseChildren = this.parent.mouseEnabled = enabled;
			}
		}
		
		
	}
	
}