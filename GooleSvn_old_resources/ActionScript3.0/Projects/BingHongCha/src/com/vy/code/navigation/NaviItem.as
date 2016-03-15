package com.vy.code.navigation
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.events.TweenEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	
	
	/**
	 * 说明：NaviItem
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-12
	 */
	
	public class NaviItem extends Sprite
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		private var _idOverTxt:TextField;
		private var _cityOverTxt:TextField;
		private var _spellOverTxt:TextField;
		private var _idOutTxt:TextField;
		private var _cityOutTxt:TextField;
		private var _spellOutTxt:TextField;
		private var _itemVO:NaviItemVO;
		
		private var isClicked:Boolean = false;
		private var itemRes:MovieClip;
		
		private const alphaValue:Number = 0.8;
		private const scaleXY:Number = 1.6;
		private var _openType:String = "1";
		
		private var animationRes:AnimationItemRes;
		
		/**
		 * 是否是当前被选中
		 */
		public var isSelected:Boolean = false;
		public var url:String = "http://tongyi-icetea.pps.tv/";
		public var startY:Number;
		public var startX:Number;
		public var order:int;
		
		public function NaviItem()
		{
			super();
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function initialization($vo:NaviItemVO = null):void
		{
			trace(url);
			if ($vo) 
			{
				itemVO = $vo;
				initVars();
				addAndRemoveEvents(true);
				initContent();
			}
		}
		
		/**
		 * 是否显示原始比例
		 * @param $original 默认不显示， 为缩放
		 * 
		 */
		public function setScaleXY($original:Boolean = false, $init:Boolean = true):void
		{
			if ($original)
			{
				isClicked = true;
//				itemRes.bg.mouseEnabled = false;
//				itemRes.gotoAndStop(MouseEvent.MOUSE_OVER);
//				outStatus.scaleX = outStatus.scaleY = scaleXY;
				animationRes.mouseChildren = animationRes.mouseEnabled = false;
				animationRes.gotoAndStop("overEnd");
				this.alpha = 1;
			}
			else
			{
				isClicked = false;
//				itemRes.bg.mouseEnabled = true;
//				itemRes.gotoAndStop(MouseEvent.MOUSE_OUT);
//				outStatus.scaleX = outStatus.scaleY = 1;
				animationRes.mouseChildren = animationRes.mouseEnabled = true;
				animationRes.gotoAndPlay($init ? "outEnd" : MouseEvent.MOUSE_OUT);
				this.alpha = alphaValue;
			}
		}
		
		/**
		 * ID显示文本框
		 */
		public function get idOverTxt():TextField
		{
			return _idOverTxt;
		}
		
		/**
		 * 城市名称显示文本框
		 */
		public function get cityOverTxt():TextField
		{
			return _cityOverTxt;
		}
		
		/**
		 * 城市名拼音显示文本框
		 */
		public function get spellOverTxt():TextField
		{
			return _spellOverTxt;
		}
		
		public function get itemVO():NaviItemVO
		{
			return _itemVO;
		}
		
		public function set itemVO(value:NaviItemVO):void
		{
			_itemVO = value;
		}
		
		/**
		 * 网页打开形式：
		 * "0" "_self"指定当前窗口中的当前帧。
		 * "1" "_blank"指定一个新窗口。
		 * "2" "_parent"指定当前帧的父级。
		 * "3" "_top"指定当前窗口中的顶级帧。
		 */
		public function get openType():String
		{
			return _openType;
		}
		
		/**
		 * @private
		 */
		public function set openType(value:String):void
		{
			_openType = value;
			switch (_openType)
			{
				case "0":
					_openType = "_self";
					break;
				case "1":
					_openType = "_blank";
					break;
				case "2":
					_openType = "_parent";
					break;
				case "3":
					_openType = "_top";
					break;
			}
		}
		
		public function get idOutTxt():TextField
		{
			return _idOutTxt;
		}
		
		public function get cityOutTxt():TextField
		{
			return _cityOutTxt;
		}
		
		public function get spellOutTxt():TextField
		{
			return _spellOutTxt;
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function initVars():void
		{
//			if (itemVO.city.length == 2)
//			{
//				itemRes = new NaviItemResource2();
//			}
//			else if (itemVO.city.length == 4)
//			{
//				itemRes = new NaviItemResource4();
//			}
//			else
//			{
//				itemRes = new NaviItemResource2();
//			}
			
			switch (itemVO.id)
			{
				case "01":
					itemRes = new BeiJing();
					break;
				case "02":
					itemRes = new ShangHai();
					break;
				case "03":
					itemRes = new GuangZhou();
					break;
				case "04":
					itemRes = new ZhengZhou();
					break;
				case "05":
					itemRes = new HeFei();
					break;
				case "06":
					itemRes = new NanJing();
					break;
				case "07":
					itemRes = new NanNing();
					break;
				case "08":
					itemRes = new XiaMen();
					break;
				case "09":
					itemRes = new WuHan();
					break;
				case "10":
					itemRes = new ChengDu();
					break;
				case "11":
					itemRes = new WuLuMuQi();
					break;
				case "12":
					itemRes = new ChangSha();
					break;
				case "13":
//					itemRes = new KunMing();
					itemRes = new ChongQing();
					break;
				case "14":
//					itemRes = new ChongQing();
					break;
			}
			trace(itemRes);
			if (itemRes == null) return ;
			itemRes.gotoAndStop(MouseEvent.MOUSE_OUT);
			itemRes.mouseChildren = itemRes.mouseEnabled = false;
			animationRes = new AnimationItemRes();
			this.addChild(animationRes);
			animationRes.con.addChild(itemRes);
			
			overStatus.mouseEnabled = overStatus.mouseChildren = false;
			outStatus.mouseEnabled  = outStatus.mouseChildren  = false;
//			overStatus.scaleX = overStatus.scaleY = 0.8;
			overStatus.visible = false;
			
			this.mouseEnabled = false;
//			itemRes.bg.buttonMode = true;
			animationRes.colorLump.buttonMode = true;
			animationRes.colorLump.alpha = 0;
			animationRes.colorLump.scaleX = animationRes.colorLump.scaleY = 1.5;
			setScaleXY(isSelected);
		}
		
		private function get overStatus():MovieClip
		{
			return itemRes.overStatus;
		}
		
		private function get outStatus():MovieClip
		{
			return itemRes.outStatus;
		}
		
		private function initContent():void
		{
//			idOverTxt.text		= itemVO.id;
//			cityOverTxt.text	= itemVO.city;
//			spellOverTxt.text	= itemVO.spell;
//			
//			idOutTxt.text = itemVO.id;
//			cityOutTxt.text	= itemVO.city;
//			spellOutTxt.text	= itemVO.spell;
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addAndRemoveEvents($isAdd:Boolean):void
		{
			if ($isAdd)
			{
				animationRes.colorLump.addEventListener(MouseEvent.CLICK, clickHandler);
				animationRes.colorLump.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
				animationRes.colorLump.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
				this.addEventListener(Event.ADDED_TO_STAGE, addedTOStageHandler);
			}
			else
			{
				animationRes.colorLump.removeEventListener(MouseEvent.CLICK, clickHandler);
				animationRes.colorLump.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
				animationRes.colorLump.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
				this.removeEventListener(Event.ADDED_TO_STAGE, addedTOStageHandler);
			}
		}
		
		private function addedTOStageHandler(e:Event):void
		{
			startX = this.x;
			startY = this.y;
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			setScaleXY(true);
			var evt:NaviEvent = new NaviEvent(NaviEvent.CLICK_ITEM);
			evt.naviItem = this;
			this.parent.dispatchEvent(evt);
			navigateToURL(new URLRequest(url), openType);
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
//			TweenMax.killTweensOf(outStatus);
			this.alpha = 1;
			animationRes.gotoAndPlay(MouseEvent.MOUSE_OVER);
			
			var evt:NaviEvent = new NaviEvent(NaviEvent.OVER_ITEM);
			evt.naviItem = this;
			this.parent.dispatchEvent(evt);
			
//			outStatus.scaleX = outStatus.scaleY = 0.1;
//			TweenMax.to(outStatus, 1, {scaleX:scaleXY, scaleY:scaleXY, ease:Elastic.easeOut, onCompleteListener: tweenOnCompletedHandler});
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			if (isClicked) return ;
			
//			TweenMax.killTweensOf(outStatus);
			
			var evt:NaviEvent = new NaviEvent(NaviEvent.OUT_ITEM);
			evt.naviItem = this;
			this.parent.dispatchEvent(evt);
			
			animationRes.gotoAndPlay(MouseEvent.MOUSE_OUT);
			this.alpha = alphaValue;
//			outStatus.scaleX = outStatus.scaleY = scaleXY;
//			TweenMax.to(outStatus, 0.5, {scaleX:1, scaleY:1, ease:Elastic.easeOut, onCompleteListener: tweenOnCompletedHandler});
		}
		
//		private function tweenOnCompletedHandler(e:TweenEvent):void
//		{
//			TweenMax.killTweensOf(e.target.target);
//		}


	}
	
}