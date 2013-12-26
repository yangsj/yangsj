package view
{	
	import flash.display.Sprite;
	
	import view.ui.SpriteButton;
	import view.ui.SpriteTextFiled;


	/**
	 * ……
	 * @author yangsj
	 */
	public class MainView extends Sprite
	{
		public var btnBrowerStorage:SpriteButton;
		public var btnBrowerDirectory:SpriteButton;
		public var textArea:SpriteTextFiled;
		public var textDirectoryUrl:SpriteTextFiled;
		
		private static var _instance:MainView;

		public function MainView()
		{
			_instance = this;
			preinit();
		}
		
		public static function get instance():MainView
		{
			if (_instance == null)
				new MainView();
			return _instance;
		}

		private function preinit():void
		{
			textDirectoryUrl = new SpriteTextFiled();
			textDirectoryUrl.x = 20;
			textDirectoryUrl.y = 20;
			textDirectoryUrl.width = 400;
			textDirectoryUrl.height = 22;
			addChild( textDirectoryUrl );

			btnBrowerStorage = new SpriteButton();
			btnBrowerStorage.label = "数据存储";
			btnBrowerStorage.x = 430;
			btnBrowerStorage.y = 20;
			addChild( btnBrowerStorage );
			
			btnBrowerDirectory = new SpriteButton();
			btnBrowerDirectory.label = "数据来源";
			btnBrowerDirectory.x = 430;
			btnBrowerDirectory.y = 20;
			addChild( btnBrowerDirectory );
			textArea = new SpriteTextFiled();
			textArea.x = 25;
			textArea.y = 60;
			textArea.width = 500;
			textArea.height = 300;
			addChild( textArea );
		}



	}
}
