package core.game.resource
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class DispelBgFrameBlaze extends Sprite
	{
		[Embed(source="assets/xml/DiamondsFrameBlaze_Skin.xml", mimeType="application/octet-stream")]
		private var FrameFlameXML:Class;
		
		[Embed(source="assets/xml/DiamondsFrameBlaze_Skin.png")]
		private var FrameFlameImage:Class;
		
		private var frameFlame:MovieClip;
		
		public function DispelBgFrameBlaze()
		{
			super();
			
			var textureAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new FrameFlameImage()), XML(new FrameFlameXML));
			frameFlame = new MovieClip(textureAtlas.getTextures("DiamondsFrameBlaze_Skin"), 12);
			Starling.juggler.add(frameFlame);
			this.addChild(frameFlame);
			frameFlame.stop();
		}
		
		public function play():void
		{
			frameFlame.addEventListener(Event.COMPLETE, onCompleted);
			frameFlame.play();
		}
		
		public function stop():void
		{
			frameFlame.removeEventListener(Event.COMPLETE, onCompleted);
			frameFlame.stop();
		}
		
		private function onCompleted():void
		{
			frameFlame.currentFrame = 5;
		}
		
		
	}
}