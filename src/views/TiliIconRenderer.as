package views
{
	import flashx.textLayout.formats.LineBreak;
	
	import spark.components.IconItemRenderer;
	
	public class TiliIconRenderer extends IconItemRenderer
	{
		public function TiliIconRenderer()
		{
			super();
			messageFunction = messageProcess;
		}
		
		override protected function createMessageDisplay():void
		{
			super.createMessageDisplay();
		}
		
		private function messageProcess(item:Object):String
		{
			if((item.value as String).length > 200)
			{
				return (item.value as String).substr(0, 200) + " ...";
			}else
			{
				return item.value;
			}
		}
	}
}