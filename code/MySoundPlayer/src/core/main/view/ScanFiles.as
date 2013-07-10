package core.main.view
{
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-7-10
	 */
	public class ScanFiles
	{
		private var fileReferenceList:FileReferenceList;
		
		public function ScanFiles()
		{
		}
		
		public function brower():void
		{
			fileReferenceList ||= new FileReferenceList();
			fileReferenceList.addEventListener(Event.SELECT, selectedHandler);
			fileReferenceList.browse([new FileFilter("Documents", "*.*")]);
		}
		
		protected function selectedHandler(event:Event):void
		{
			fileReferenceList.removeEventListener(Event.SELECT, selectedHandler);
			var fileList:Vector.<FileReference> = new Vector.<FileReference>();
			for each (var fileReference:FileReference in fileReferenceList.fileList)
			{
				fileList.push(fileReference);
			}
			
		}
		
	}
}