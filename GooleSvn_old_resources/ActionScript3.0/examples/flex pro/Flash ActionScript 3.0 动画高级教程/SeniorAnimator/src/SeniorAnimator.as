package
{
	import app.chapter_01.GridCollision;
	import app.chapter_01.GridCollision2;
	import app.chapter_01.GridCollision3;
	import app.chapter_01.NodeGardenGrid;
	import app.chapter_01.NodeGardenLines;
	import app.chapter_02.ArriveTest;
	import app.chapter_02.FleeTest;
	import app.chapter_02.PursueTest;
	import app.chapter_02.SeekFleeTest1;
	import app.chapter_02.SeekFleeTest2;
	import app.chapter_02.SeekTest;
	import app.chapter_02.VehicleTest;
	import app.chapter_03.BoxTest;
	import app.chapter_03.CollisionTest;
	import app.chapter_03.DepthTest;
	import app.chapter_03.DepthTest2;
	import app.chapter_03.GraphicTest;
	import app.chapter_03.IsoTransFormTest;
	import app.chapter_03.MapTest;
	import app.chapter_03.MotionTest;
	import app.chapter_03.MotionTest2;
	import app.chapter_03.TileTest;
	import app.chapter_04.GridView;
	import app.chapter_05.CameraTest;
	import app.chapter_05.EdgeTracking;
	import app.chapter_05.MicrophoneTest;
	import app.chapter_05.MotionTracking;
	import app.chapter_05.SoundFlier;
	import app.chapter_06.Euler;
	import app.chapter_06.Hinge;
	import app.chapter_06.RK2;
	import app.chapter_06.RK4;
	import app.chapter_06.Square;
	import app.chapter_06.Square2;
	import app.chapter_06.Triangle;
	import app.chapter_06.VerletPointTest;
	import app.chapter_06.VerletStrckTest;
	import app.chapter_07.Container3D;
	import app.chapter_07.DepthSort;
	import app.chapter_07.Position3D;
	import app.chapter_07.Test3D;
	import app.chapter_08.BitmapTriangles;
	import app.chapter_08.BitmapTrianglesUV2;
	import app.chapter_08.BitmapTrianglesUV3;
	import app.chapter_08.HistoryDraw;
	import app.chapter_08.ImageSphere;
	import app.chapter_08.ImageTube;
	import app.chapter_08.PathSketch;
	import app.chapter_08.SingleLine;
	
	import code.chapter_04.Grid;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
//	[SWF(width="320", height="240", backgroundColor="0x000000")]
	[SWF(width="1092", height="614", backgroundColor="0x000000", frameRate="60")]
	
	/**
	 * 说明：SeniorAnimator
	 * @author victor
	 * 2012-4-8 下午12:54:49
	 */
	
	public class SeniorAnimator extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function SeniorAnimator()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.graphics.lineStyle(0, 0xff0000);
			this.graphics.beginFill(0xff0000, 0.05);
			this.graphics.drawRect(0,0,stage.stageWidth-1, stage.stageHeight-1);
			this.graphics.endFill();
			
			////*************chapter_01******************/////
//			var gridCollision:GridCollision = new GridCollision();
//			this.addChild(gridCollision);
//			gridCollision.initialization();
			
//			var gridCollision2:GridCollision2 = new GridCollision2();
//			this.addChild(gridCollision2);
			
//			var gridCollision3:GridCollision3 = new GridCollision3();
//			this.addChild(gridCollision3);
			
//			var nodeGardenLines:NodeGardenLines = new NodeGardenLines();
//			this.addChild(nodeGardenLines);
			
//			var nodeGardenGrid:NodeGardenGrid = new NodeGardenGrid();
//			this.addChild(nodeGardenGrid);
			
			
			////*************chapter_02******************/////
//			var vehicleTest:VehicleTest = new VehicleTest();
//			this.addChild(vehicleTest);
			
//			var seekTest:SeekTest = new SeekTest();
//			this.addChild(seekTest);
			
//			var fleeTest:FleeTest = new FleeTest();
//			this.addChild(fleeTest);
			
//			var seekFleeTest1:SeekFleeTest1 = new SeekFleeTest1();
//			this.addChild(seekFleeTest1);
			
//			var arriveTest:ArriveTest = new ArriveTest();
//			this.addChild(arriveTest);
			
//			var pursueTest:PursueTest = new PursueTest();
//			this.addChild(pursueTest);
			
			
			////*************chapter_03******************/////
//			var isoTransFormTest:IsoTransFormTest = new IsoTransFormTest();
//			this.addChild(isoTransFormTest);
			
//			var tileTest:TileTest = new TileTest();
//			this.addChild(tileTest);
			
//			var boxTest:BoxTest = new BoxTest();
//			this.addChild(boxTest);
			
//			var depthTest:DepthTest = new DepthTest();
//			this.addChild(depthTest);
			
//			var depthTest:DepthTest2 = new DepthTest2();
//			this.addChild(depthTest);
			
//			var motionTest:MotionTest = new MotionTest();
//			this.addChild(motionTest);
			
//			var motionTest:MotionTest2 = new MotionTest2();
//			this.addChild(motionTest);
			
//			var collisionTest:CollisionTest = new CollisionTest();
//			this.addChild(collisionTest);
			
//			var graphicTest:GraphicTest = new GraphicTest();
//			this.addChild(graphicTest);
			
//			var mapTest:MapTest = new MapTest();
//			this.addChild(mapTest);
			
			
			////*************chapter_04******************/////
			
//			var grid:Grid = new Grid(50, 25);
//			grid.setStartNode(0,2);
//			grid.setEndNode(48, 24);
//			var gridView:GridView = new GridView(grid);
//			gridView.x = 50;//(this.stage.stageWidth - gridView.width) * 0.5;
//			gridView.y = 50;//(this.stage.stageHeight - gridView.height) * 0.5;
//			this.addChild(gridView);
			
			////*************chapter_05******************/////
			
//			var microphoneTest:MicrophoneTest = new MicrophoneTest();
//			this.addChild(microphoneTest);
			
//			var soundFlier:SoundFlier = new SoundFlier();
//			this.addChild(soundFlier);
			
//			var cameraTest:CameraTest = new CameraTest();
//			this.addChild(cameraTest);
//			cameraTest.x = (stage.stageWidth - cameraTest.width) * 0.5;
//			cameraTest.y = (stage.stageHeight - cameraTest.height) * 0.5;
			
//			var motionTracking:MotionTracking = new MotionTracking();
//			this.addChild(motionTracking);
			
//			var edgeTracking:EdgeTracking = new EdgeTracking();
//			this.addChild(edgeTracking);
			
			////*************chapter_06******************/////
			
//			var euler:Euler = new Euler();
//			this.addChild(euler);
			
//			var rk2:RK2 = new RK2();
//			this.addChild(rk2);
			
//			var rk4:RK4 = new RK4();
//			this.addChild(rk4);
			
//			var verletPointTest:VerletPointTest = new VerletPointTest();
//			this.addChild(verletPointTest);
			
//			var verletStrckTest:VerletStrckTest = new VerletStrckTest();
//			this.addChild(verletStrckTest);
			
//			var triangle:Triangle = new Triangle();
//			this.addChild(triangle);
			
//			var square:Square = new Square();
//			this.addChild(square);
			
//			var square2:Square2 = new Square2();
//			this.addChild(square2);
			
//			var hinge:Hinge = new Hinge();
//			this.addChild(hinge);
			
			////*************chapter_07******************/////
			
//			var test3D:Test3D = new Test3D();
//			this.addChild(test3D);
			
//			var position3D:Position3D = new Position3D();
//			this.addChild(position3D);
			
//			var depthSort:DepthSort = new DepthSort();
//			this.addChild(depthSort);
			
//			var container3D:Container3D = new Container3D();
//			this.addChild(container3D);
			
			////*************chapter_08******************/////
			
//			var singleLine:SingleLine = new SingleLine();
//			this.addChild(singleLine);
			
//			var pathSketch:PathSketch = new PathSketch();
//			this.addChild(pathSketch);
			
			var bitmapTriangles:BitmapTriangles = new BitmapTriangles();
			this.addChild(bitmapTriangles);
			
//			var bitmapTrianglesUV2:BitmapTrianglesUV2 = new BitmapTrianglesUV2();
//			this.addChild(bitmapTrianglesUV2);
			
//			var bitmapTrianglesUV3:BitmapTrianglesUV3 = new BitmapTrianglesUV3();
//			this.addChild(bitmapTrianglesUV3);
			
//			var imageTube:ImageTube = new ImageTube();
//			this.addChild(imageTube);
			
//			var imageSphere:ImageSphere = new ImageSphere();
//			this.addChild(imageSphere);
			
//			var historyDraw:HistoryDraw = new HistoryDraw();
//			this.addChild(historyDraw);
			
			////*************chapter_09******************/////
			
			
			
			////*************chapter_10******************/////
			
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}