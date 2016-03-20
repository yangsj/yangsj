package net.vyky.code.iphonetween
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * e.g:<br>
	 * var v_iphone:VIphoneTween = new VIphoneTween(false);<br>
	 * v_iphone.target = mc;<br>
	 * v_iphone.setCompleteAndParams(onComplete, ["close complete"]);<br>
	 * v_iphone.close();或v_iphone.open(); <br>
	 * 
	 * @author victor
	 */
	public class VIphoneTween extends Sprite 
	{
		
		/** 图片边上面的点数（包括两端）横竖都分一样。段数越多越细腻，越吃资源 */ 
		private const SEGMENT:int = 30;
		
		/** 点到目标点的距离和延迟时间的系数 */ 
		private const DELAY:Number = 1 / 1500;
		/** 点到目标点补间所用时间 */
		private const TIME:Number = 0.2;
		
		//一些图片尺寸和位置信息
		private var img_width:Number = 320;
		private var img_height:Number = 240;
		private var img_x:Number = 125;
		private var img_y:Number = 80;
		
		//位图资源
		private var img:BitmapData;
		/** 是否在播放动画 */
		private var isTweening:Boolean = false;
		
		private var pointsLength:int = SEGMENT * SEGMENT;
		
		/** Graphics.drawTriangles方法的第一个参数 */
		private var vertexes:Vector.<Number> = new Vector.<Number>(pointsLength * 2);
		
		/** Graphics.drawTriangles方法的第二个参数 */
		private var indices:Vector.<int> = new Vector.<int>((SEGMENT - 1) * (SEGMENT - 1) * 6);
		
		/** 纹理，对应API的Graphics.drawTriangles方法的第三个参数 */
		private var uvs:Vector.<Number> = new Vector.<Number>(pointsLength * 2);
		
		/** 意义同vertexes，points被缓动，然后把值赋给vertexes进行渲染 */
		private var points:Vector.<Point> = new Vector.<Point>(pointsLength);
		
		/** 缓动时间轴，用于回放动画 */
		private var tweens:TimelineLite;
		
		/** 打开或关闭的x位置 */
		private var tweenX:Number = 0;
		
		/** 打开或关闭的y位置 */
		private var tweenY:Number = 0;
		
		private var _target:DisplayObject;
		private var _onComplete:Function;
		private var _onCompleteParams:Array;
		
		private var _isOpen:Boolean = true;
		/** 当打开或关闭结束后是否销毁该对象 */
		private var _isCompleteDispose:Boolean = false;
		
		public function VIphoneTween(isCompleteDispose:Boolean=false):void 
		{
			_isCompleteDispose = isCompleteDispose;
		}
		
		public function setCompleteAndParams(onComplete:Function, onCompleteParams:Array=null):void
		{
			this.onComplete = onComplete;
			this.onCompleteParams = onCompleteParams;
		}
		
		public function dispose():void
		{
			_target = null;
			_onComplete = null;
			_onCompleteParams = null;
			if (tweens) tweens.clear();
			tweens = null;
			vertexes = null;
			points = null;
			indices = null;
			uvs = null;
			img = null;
		}
		
		public function open():void
		{
			var boo:Boolean = check(true);
			if (boo == false) return ;
			if (tweens == null)
			{
				var i:int = pointsLength - 1;//遍历的中间变量
				var dist:Number;
				tweens = new TimelineLite( { paused:true, onComplete:tweenOver, onReverseComplete:tweenOver } );
				do
				{	
					var point:Point = points[i];
					var endx:Number = point.x;
					var endy:Number = point.y;
					points[i].x = tweenX;
					points[i].y = tweenY;
					point = points[i];
					dist = Math.sqrt(Math.pow(tweenX - endx, 2) + Math.pow(tweenY - endy, 2));
					//在时间轴上添加对Point数据的缓动，缓动开始时间和点到目标点的距离成正比，这个是效果的关键
					tweens.insert(TweenLite.to(point, TIME, { x:endx, y:endy }), dist * DELAY);
				}
				while (i--);
				
				tweens.play();
				isTweening = true;
			}
			else
			{
				start();
			}
		}
		
		public function close():void
		{
			var boo:Boolean = check(false);
			if (boo == false) return ;
			
			//创建一个缓动时间轴动画，并在动画播放完后执行tweenOver
			if (tweens == null)
			{
				var i:int = pointsLength - 1;//遍历的中间变量
				var dist:Number;
				tweens = new TimelineLite( { paused:true, onComplete:tweenOver, onReverseComplete:tweenOver } );
				do
				{
					var point:Point = points[i];
					//计算点到目标点，也就是鼠标点击的点的距离
					dist = Math.sqrt(Math.pow(tweenX - point.x, 2) + Math.pow(tweenY - point.y, 2));
					//在时间轴上添加对Point数据的缓动，缓动开始时间和点到目标点的距离成正比，这个是效果的关键
					tweens.insert(TweenLite.to(point, TIME, { x:tweenX, y:tweenY } ), dist * DELAY);
				}
				while (i--);
				
				tweens.play();
				isTweening = true;
			}
			else
			{
				start();
			}
		}
		
		private function check(type:Boolean):Boolean
		{
			if (_target == null) return false ;
			_isOpen = type;
			if (_target.stage == null)
			{
				_target.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
				return false;
			}
			if (isTweening == true) return false;
			this.addEventListener(Event.ENTER_FRAME, onFrameEvent);
			_target.visible = false;
			draw();
			return true;
		}
		
		private function addedToStageHandler(e:Event):void
		{
			_target.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			target = _target;
			_isOpen ? open() : close();
		}
		
		private function init():void
		{
			if (_target)
			{
				if (img == null)
				{
					img = new BitmapData(img_width, img_height, true, 0);
					img.draw(_target);//存到位图里面
					
					var u:Number = img_width / (SEGMENT - 1);//水平相邻点距离
					var v:Number = img_height / (SEGMENT - 1);//竖直相邻点距离
					var s:Number = 1 / (SEGMENT - 1);//水平和竖直相邻点距离占总长的百分比（uv纹理用的）
					var vi:int = 0;
					var ii:int = 0;
					for (var i:int = 0; i < SEGMENT; i++)
					{
						for (var j:int = 0; j < SEGMENT; j++)
						{
							//计算点的坐标并写入对应的数组位置
							var lp:Point = new Point(j * u + img_x, i * v + img_y);
							vertexes[vi] = lp.x;
							uvs[vi++] = j * s;
							vertexes[vi] = lp.y;
							uvs[vi++] = i * s;
							points[i * SEGMENT + j] = lp;
						}
					}
					vi = 0;
					for (i = 0; i < SEGMENT - 1; i++)
					{
						for (j = 0; j < SEGMENT - 1; j++)
						{
							//指定三角形各个点和vertexes中点的对应关系
							indices[ii++] = vi;
							indices[ii++] = vi + 1;
							indices[ii++] = vi + SEGMENT + 1;
							indices[ii++] = vi;
							indices[ii++] = vi + SEGMENT;
							indices[ii++] = vi + SEGMENT + 1;
							vi++;
						}
						vi++;
					}	
				}	
			}
		}
		
		private function addThisToParent():void
		{
			if (this.parent == null)
			{
				if (_target.parent)
				{
					_target.parent.addChild(this);
				}
			}
		}
		
		private function removeThisFromParent():void
		{
			if (this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
		private function start():void
		{
			//将隐藏的动画反向播放
			tweens.reversed ? tweens.play() : tweens.reverse();
			
			//设置为正在播放
			isTweening = true;
		}
		
		//动画播放结束调用
		private function tweenOver():void
		{
			isTweening = false;
			this.removeEventListener(Event.ENTER_FRAME, onFrameEvent);//动画播放完毕 停止渲染
			
			if (this._target)
			{
				this._target.visible = _isOpen;
			}
			
			if (_onComplete != null)
			{
				if (_onCompleteParams)
				{
					_onComplete.apply(this, _onCompleteParams);
				}
				else
				{
					_onComplete.apply(this);
				}
			}
			
			if (_isCompleteDispose)
			{
				removeThisFromParent();
				dispose();
			}
		}
		
		private function setImgInfo(img_width:Number, img_height:Number, img_x:Number, img_y:Number):void
		{
			this.img_width = img_width;
			this.img_height = img_height;
			this.img_x = img_x;
			this.img_y = img_y;
		}
		
		//渲染
		private function onFrameEvent(e:Event):void
		{
			var vi:int = 0;
			var pi:int = 0;
			var i:int = pointsLength;
			//把Point的数据写到vertexes中
			while (i--)
			{
				vertexes[vi++] = points[pi].x;
				vertexes[vi++] = points[pi++].y;
			}
			//绘制
			draw();
		}
		
		private function draw():void
		{
			this.graphics.clear();
			this.graphics.beginBitmapFill(img);
			this.graphics.drawTriangles(vertexes, indices, uvs);
			this.graphics.endFill();
			
			addThisToParent();
		}

		/**
		 * target
		 */
		public function get target():DisplayObject
		{
			return _target;
		}

		public function set target(value:DisplayObject):void
		{
			_target = value;
			if (_target)
			{
				if ( _target.parent )
				{
					setImgInfo(_target.width, _target.height, _target.x, _target.y);
				}
				if (_target.stage)
				{
					tweenX = _target.stage.stageWidth * Math.random();
					tweenY = _target.stage.stageHeight * Math.random();
				}
				init();
			}
		}
		
		/**
		 * 是否是打开的状态，否则为关闭
		 */
		public function get isOpen():Boolean
		{
			return _isOpen;
		}

		/**
		 * 一个在打开或关闭完成时的回调函数
		 */
		public function set onComplete(value:Function):void
		{
			_onComplete = value;
		}

		/**
		 * onComplete回调函数所定义的参数
		 */
		public function set onCompleteParams(value:Array):void
		{
			_onCompleteParams = value;
		}


	}
	
}