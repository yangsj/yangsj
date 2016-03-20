package 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.Event;

	public class BezierCurve extends Sprite
	{
		/* 属性 */
		private var _radius:int = 70;// 定义半径
		private var _numberPoint:Number = 30;// 定义点的数量
		private var _points:Array;
		private var _pre_r:Number = 0.000314159;
		private var _radians:Number = 0;
		private var _centX:Number;// X坐标的位置
		private var _centY:Number;// Y坐标的位置
		private var _timer:Timer;// 创建刷新用的计时器
		private var _color:uint;// 对象的颜色
		private var _gf:GlowFilter;// 使对象产生发光效果
		private var _loc_1:int;
		private var _loc_2:Point;

		/* 构造函数*/
		public function BezierCurve(_x:Number, _y:Number)
		{
			super();
			//在此初始化数值
			_color = 0x3377dd;// 初始化【颜色】
			_centX = _x;// 初始化【X】坐标
			_centY = _y;// 初始化【Y】坐标
			_gf=new GlowFilter();// 初始化【发光效果】，颜色为0x00ffff
			_gf.blurX = _loc_1;// 初始化【水平】模糊量
			_gf.blurY = 32;// 初始化【垂直】模糊量
			_gf.color = _color;// 初始化【光晕颜色】
			filters = [_gf];// 着色器
			_points=new Array();// 初始化一个数组，用以
			/* 以下为 —— 启动刷新计时器 */
			//this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			// 启动计时器;
			/* —— 结束计时器 */
		}
		
		public function sta():void
		{
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function sto():void
		{
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		/* 方法 */
		private function onEnterFrame(event:Event):void
		{
			// 刷新后的动作
			// trace(“成功执行Timer”);
			run();//进行一个run动作

		}

		private function run():void
		{
			this.graphics.clear();
			// 清除绘制到此 Graphics 对象的图形，并重置填充和线条样式设置;
			_points = [];
			_radians = _radians + _pre_r;
			_loc_1 = 0;// 设置水平模糊变量
			// ——————————————- Begin While ——————————————-
			while (_loc_1 < _numberPoint)
			{
				_loc_2 = new Point();// 每执行一次while都新建一个Point数组
				_loc_2.x = _centX + Math.cos(_radians * _loc_1) * 140;
				_loc_2.y = _centY + Math.sin(_radians * _loc_1) * 140;
				_points.push(_loc_2);
				// 将一个或多个元素添加到数组的结尾，并返回该数组的新长度;
				_loc_1 +=  1;
			}
			// ------------------------------------------- End While -------------------------------------------
			this.graphics.beginFill(_color, 0.2);
			this.graphics.lineStyle(1, _color , 0.8);
			// 设定线条颜色;
			this.graphics.moveTo(_centX, _centY);
			// 移动;
			_loc_1 = 2;
			while (_loc_1 < _numberPoint - 2 )
			{
				this.graphics.curveTo(_points[_loc_1 - 1].x, _points[_loc_1 - 1].y, _points[_loc_1].x, _points[_loc_1].y);
				this.graphics.curveTo(_points[_loc_1 + 1].x, _points[_loc_1 + 1].y, _centX, _centY);
				_loc_1 +=  1;
			}
			this.graphics.endFill();
		}
	}
}//绘制贝塞尔曲线
