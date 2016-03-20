package code.pic_glide
{
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.setInterval;
	
	
	/**
	 * 说明：Main
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-5
	 */
	
	public class PicGlideMain extends Sprite
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		private var pointLayoutArr:Array = [];
		private var limitsValue:int = 2;
		private var itemVector:Vector.<Item>;
		private var itemContainer:Sprite;
		private var setTimerId:uint;
		private var lengthObject:int = 20;
		private var time:Number = 0.5;
		private var loader:URLLoader;
		private var configXml:XML;
		
		private var canClick:Boolean = true;
		
		public function PicGlideMain()
		{
			super();
			initLoaderConfig();
			
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function init():void
		{
			initVars();
			initPointLayoutArr();
			initLayout();
		}
		
		private function initLoaderConfig():void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onCompletedHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(new URLRequest("config.xml"));
		}
		
		private function initVars():void
		{
			itemVector 		= new Vector.<Item>();
			itemContainer 	= new Sprite();
			this.addChild(itemContainer);
		}
		
		private function initPointLayoutArr():void
		{
			pointLayoutArr.push(new ItemVO(13,278,50,37.5 * 2,0,0));
			pointLayoutArr.push(new ItemVO(79,228,80,60 * 2,1,1));
			pointLayoutArr.push(new ItemVO(182,164,120,90 * 2,1,2));
			pointLayoutArr.push(new ItemVO(320,100,160,120 * 2,1,3));
			pointLayoutArr.push(new ItemVO(488,164,120,90 * 2,1,4));
			pointLayoutArr.push(new ItemVO(642,228,80,60 * 2,1,5));
			pointLayoutArr.push(new ItemVO(736,278,50,37.5 * 2,0,6));
			
			limitsValue = int((pointLayoutArr.length + 1) * 0.5) - 1;
		}
		
		private function initLayout():void
		{
			var leng:int = pointLayoutArr.length - 2;
			var xmllist:XMLList = configXml.child("item");
			lengthObject = xmllist.length();
			for (var i:int = 0; i < lengthObject; i++)
			{
				var item:Item		= new Item();
				item.nameTxt.text	= "NO." + i;
				item.id = int(xmllist[i].@id);
				item.url = xmllist[i].@src.toString();
				item.playVideo();
				if (i < leng)
				{
					var vo:ItemVO = pointLayoutArr[i+1] as ItemVO;
					item.vo		  = vo;
					item.initAttribute();
					itemContainer.addChild(item);
					if (vo.index == 3)
					{
						item.resumeVideo();
					}
				}
				itemVector.push(item);
				item.addEventListener(MouseEvent.CLICK, itemMouseClickedHandler);
			}
		}
		
		private function setMouseEnabledValid():void
		{
			canClick = true;
		}
		
		private function loop(arr1:Array, $type:String):void
		{
			var len:int = arr1.length;
			var target:Item;
			var vo1:ItemVO;
			var vo2:ItemVO;
			var i:int;
			if ($type == Type.RIGHT)
			{
				for (i = len-1; i > -1; i--)
				{
					target = arr1[i];
					vo1 = pointLayoutArr[i + 1] as ItemVO;
					vo2 = pointLayoutArr[i] as ItemVO;
					if (target.parent == null)
					{
						target.vo = vo2;
						target.initAttribute();
						itemContainer.addChild(target);
					}
					tweenMax(target, vo1);
				}
			}
			else
			{
				for (i = 0; i < len; i++)
				{
					target = arr1[i];
					vo1 = pointLayoutArr[i] as ItemVO;
					vo2 = pointLayoutArr[i + 1] as ItemVO;
					if (target.parent == null)
					{
						target.vo = vo2;
						target.initAttribute();
						itemContainer.addChild(target);
					}
					tweenMax(target, vo1);
				}
			}
		}
		
		private function tweenMax($target:Item, $vo:ItemVO):void
		{
			$target.vo = $vo;
			if ($vo.index == 3)
			{
				$target.resumeVideo();
			}
			else
			{
				$target.pauseVideo();
			}
			TweenMax.to($target, time, {x:$vo.x, y:$vo.y, width:$vo.width, height:$vo.height, alpha:$vo.alpha, onCompleteListener:tweenCompleteHandler});
		}
		
		private function tweenCompleteHandler(e:TweenEvent):void
		{
			var target:DisplayObject = e.target.target as DisplayObject;
			TweenMax.killTweensOf(target);
			if (target.alpha < 1) 
			{
				if (target.parent) target.parent.removeChild(target);
			}
			setMouseEnabledValid();
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function onCompletedHandler(e:Event):void
		{
			configXml = XML(loader.data);
			init();
		}
		
		private function ioErrorHandler(e:Event):void
		{
			
		}
		
		private function itemMouseClickedHandler(e:MouseEvent):void
		{
			if (canClick == false) return ;
			canClick = false;
			var target:Item = e.target as Item;
			var index:int = target.vo.index;
			var ary:Array = [];
			trace("index:::",index, "id:", target.id, "url:", target.url);
			var removeArr:Array = [];
			var type:String = index < limitsValue ? Type.RIGHT : Type.LEFT;
			if (index < limitsValue)
			{
				while (index < limitsValue)
				{
					var dis:Item = itemVector.pop() as Item;
					itemVector.unshift(dis);
					ary = getItemsArr([itemVector[pointLayoutArr.length - 2]], type);
					loop(ary, type);
					index++;
				}
			}
			else if (index > limitsValue)
			{
				while (index > limitsValue)
				{
					var dis1:Item = itemVector.shift() as Item;
					itemVector.push(dis1);
					ary = getItemsArr([dis1], type);
					loop(ary, type);
					index--;
				}
			}
			removeArr = null;
		}
		
		private function getItemsArr($removeArr:Array, $type:String):Array
		{
			var arys:Array = [];
			for (var i:int = 0; i < pointLayoutArr.length - 2; i++)
			{
				arys.push(itemVector[i]);
			}
			
			for each (var j:Item in $removeArr)
			{
				if ($type == Type.RIGHT)
				{
					arys.push(j);
				}
				else
				{
					arys.unshift(j);
				}
			}
			
			return arys;
		}
		
		
	}
	
}