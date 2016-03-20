package code.chapter_02
{
	
	/**
	 * 说明：SteeredVehicle
	 * @author victor
	 * 2012-4-10 下午11:43:33
	 */
	
	public class SteeredVehicle extends Vehicle
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _maxForce:Number = 1;
		private var _steeringForce:Vector2D;
		private var _arrivalThreshold:Number = 100;
		
		public function SteeredVehicle()
		{
			_steeringForce = new Vector2D();
			super();
		}
		
		public function get maxForce():Number
		{
			return _maxForce;
		}
		
		public function set maxForce(value:Number):void
		{
			_maxForce = value;
		}
		
		public function seek(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);
		}
		
		public function flee(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.subtract(force);
		}
		
		public function arrive(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			
			var dist:Number = _position.dist(target);
			if (dist > _arrivalThreshold)
			{
				desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			}
			else
			{
				desiredVelocity = desiredVelocity.multiply(_maxSpeed * dist / _arrivalThreshold);
			}
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);
		}
		
		public function pursue(target:Vehicle):void
		{
			var lookAheadTime:Number = position.dist(target.position) / _maxSpeed;
			var predictedTarget:Vector2D = target.position.add(target.velocity.multiply(lookAheadTime));
			seek(predictedTarget);
		}
		
		override public function update():void
		{
			_steeringForce.truncate(_maxForce);
			_steeringForce = _steeringForce.divide(_mass);
			_velocity = _velocity.add(_steeringForce);
			_steeringForce = new Vector2D();
			super.update();
		}

		public function get arrivalThreshold():Number
		{
			return _arrivalThreshold;
		}

		public function set arrivalThreshold(value:Number):void
		{
			_arrivalThreshold = value;
		}

		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
		

	}
}