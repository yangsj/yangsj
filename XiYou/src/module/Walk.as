package module
{
	import character.FrameLabels;
	import charactersOld.Character;
	import charactersOld.CharacterEvent;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import interfaces.IWalkImpl;
	import interfaces.IWalkable;
	import org.osmf.elements.DurationElement;
	import utils.MathUtils;
	use namespace status;









	/**
	 * 实现基本的走路逻辑以及功能
	 */
	public class Walk extends Action
	{
		/**
		 *
		 * @default
		 */
		protected var host : Character;

		protected var movement : TweenMax;
		private var anim : TweenMax;
		private var _destination : *;
		public var onUpdate : Function;

		/**
		 * @param host 实际移动的宿主，需要实现IWalkable接口
		 */
		public function Walk(host : Character)
		{
			this.host = host;
			super('walk');
		}

		/**
		 * 朝向某个位置
		 * @param _x 目标位置的x轴坐标
		 */
		public function turnTo(_x : Number) : void
		{
			_x < host.x ? host.turnLeft() : host.turnRight();
		}

		/**
		 *
		 * @param _x
		 * @param _y
		 * @param arrival
		 */
		override status function start() : void
		{
			//首先转向
			turnTo(destination.x);
//			trace(host.name, 'WALK START');
			anim = host.play({frames: [FrameLabels.WALK]});
			anim.data = host.name + '>walk<';
			//计算距离和移动的时长
//			var distance : Number = MathUtils.distance(host.x, host.y, destination.x, destination.y);
//			var duration : Number = distance / host.speed;

			movement = TweenMax.to(host, 1000, {ease: Linear.easeNone, x: destination.x, y: destination.y, onUpdate: function() : void
			{
				var distance : Number = MathUtils.distance(host.x, host.y, destination.x, destination.y);
				var duration : Number = distance / host.speed;
				turnTo(destination.x);
				movement.duration = duration;
				movement.updateTo({x: destination.x, y: destination.y}, true);
				if (duration < 0.05)
					movement.complete();
//				trace(duration);
				onUpdate();
			}, onComplete: complete});
		}

		override status function complete(... args) : void
		{
			anim.kill();
			movement.kill();
//			trace(host.name, 'WALK COMPLETED');
			super.complete();
		}

		/**
		 * 暂停移动
		 */
		override status function pause() : void
		{
			anim.pause();
			movement.pause();
		}

		override status function abort() : void
		{
			anim.kill();
			movement.kill();
		}

		/**
		 * 继续移动
		 */
		override status function resume() : void
		{
			anim.resume();
			movement.resume();
		}

		public function get destination() : *
		{
			return _destination;
		}

		public function set destination(value : *) : void
		{
			if (value == null)
				value = new Point(host.x, host.y);
			_destination = value;
		}

	}
}
