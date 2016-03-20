package victor.test
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * 说明：Helloworld
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-6-14
	 */
	
	public class TestHelloworld extends Sprite
	{
		private var m_world:b2World;
		private var m_velocityIterations:int = 10;
		private var m_positionIterations:int = 10;
		private var m_timeStep:Number = 1.0/24.0;
		
		private var body:b2Body;
		private var bodyDef:b2BodyDef;
		private var boxShape:b2PolygonShape;
		private var circleShape:b2CircleShape;
		private var fixtureDef:b2FixtureDef;
		
		public function TestHelloworld()
		{
			if (this.stage) init();
			else this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event=null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initEnterFrameEventHandler();
			initWorld();
		}
		
		private function initWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			var doSleep:Boolean = true;
			m_world = new b2World( gravity, doSleep);
			
			initDebugDraw();
			
			bodyDef = new b2BodyDef();
			bodyDef.position.Set(10, 12);
			boxShape = new b2PolygonShape();
			boxShape.SetAsBox(30, 3);
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = 0.3;
			fixtureDef.density = 0;
			bodyDef.userData = new PhysGround();
			bodyDef.userData.width = 30 * 2 * 30; 
			bodyDef.userData.height = 30 * 2 * 3; 
			addChild(bodyDef.userData);
			body = m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			addSomeObjects();
		}
		
		private function initDebugDraw():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(this);
			debugDraw.SetDrawScale(30.0);
			debugDraw.SetFillAlpha(0.3);
			debugDraw.SetLineThickness(1.0);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			m_world.SetDebugDraw(debugDraw);
			m_world.DrawDebugData();
		}
		
		private function addSomeObjects():void
		{
			for (var i:int = 1; i < 10; i++)
			{
				bodyDef = new b2BodyDef();
				bodyDef.position.x = Math.random() * 15 + 5;
				bodyDef.position.y = Math.random() * 10;
				bodyDef.type = b2Body.b2_dynamicBody;
				var rX:Number = Math.random() + 0.5;
				var rY:Number = Math.random() + 0.5;
				if (Math.random() < 0.5)
				{
					boxShape = new b2PolygonShape();
					boxShape.SetAsBox(rX, rY);
					fixtureDef.shape = boxShape;
					fixtureDef.density = 1.0;
					fixtureDef.friction = 0.5;
					fixtureDef.restitution = 0.2;
					bodyDef.userData = new PhysBox();
					bodyDef.userData.width = rX * 2 * 30; 
					bodyDef.userData.height = rY * 2 * 30; 
					body = m_world.CreateBody(bodyDef);
					body.CreateFixture(fixtureDef);
				}
				else
				{
					circleShape = new b2CircleShape(rX);
					fixtureDef.shape = circleShape;
					fixtureDef.density = 1.0;
					fixtureDef.friction = 0.5;
					fixtureDef.restitution = 0.2;
					bodyDef.userData = new PhysCircle();
					bodyDef.userData.width = rX * 2 * 30; 
					bodyDef.userData.height = rX * 2 * 30; 
					body = m_world.CreateBody(bodyDef);
					body.CreateFixture(fixtureDef);
				}
				addChild(bodyDef.userData);
			}
		}
		
		private function initEnterFrameEventHandler():void
		{
			this.addEventListener(Event.ENTER_FRAME, enterFrameEventHandler);
		}
		
		private function enterFrameEventHandler(e:Event):void
		{
			update();
		}
		
		private function update():void
		{
			m_world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
			
			// Go through body list and update sprite positions/rotations
			for (var bb:b2Body = m_world.GetBodyList(); bb; bb = bb.GetNext())
			{
				if (bb.GetUserData() is Sprite)
				{
					var sprite:Sprite = bb.GetUserData() as Sprite;
					sprite.x = bb.GetPosition().x * 30;
					sprite.y = bb.GetPosition().y * 30;
					sprite.rotation = bb.GetAngle() * (180/Math.PI);
				}
			}
		}
		
		
	}
	
}