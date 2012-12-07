package utils
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;

	import global.Global;



	public class Heartbeat
	{
		public static const NO_DELAY : int = -1;
		public static const instance : Heartbeat = new Heartbeat();
		private var queue : * = {};
		private var i : uint = 0;
		private var interval : Number;
		private var tick : uint;

		public function Heartbeat()
		{
			interval = 1000 / Global.FPS;
			reset();
		}

		public function reset() : void
		{
			clearInterval(tick);
			tick = setInterval(ticking, interval);
			queue = {};
			i = 0;
		}

		public function addOnTick(func : Function, delay : int = -1, repeat : Boolean = false) : int
		{
			queue[i++] = new CallbackInfo(func, delay, repeat);
			return i;
		}

		public function tween(target : *, time : Number, vars : *) : int
		{
			var times : int = int(time / interval);
			var step : * = {};
			var begin : * = {};
			var onUpdate : Function = vars.onUpdate;
			var onComplete : Function = vars.onComplete;
			delete vars.onUpdate;
			delete vars.onComplete;
			for (var i : * in vars)
			{
				begin[i] = target[i];
				step[i] = (vars[i] - target[i]) / times;
			}
			var k : int = 0;
			return addOnTick(function() : void
			{
				for (var j : * in step)
				{
					target[j] = begin[i] + step[i] * k++;
				}
				if (onUpdate != null)
					onUpdate();
				if (onComplete != null)
				{
					if (--times == 0)
						onComplete();
				}

			}, time, true);
		}

		public function remove(id : int) : int
		{
			queue[id] = null;
			delete queue[id];
			return -1;
		}

		protected function ticking() : void
		{
			for (var i : * in queue)
			{
				executeCallback(i, queue[i]);
			}
		}

		private function executeCallback(i : *, info : CallbackInfo) : void
		{
			switch (info.delay)
			{
				case 0:
				{
					info.callback();
					remove(i);
					break;
				}
				case -1:
				{
					info.callback();
					break;
				}
				default:
				{
					info.delay--;
					if (info.repeat)
						info.callback();
					break;
				}
			}
		}
	}
}
