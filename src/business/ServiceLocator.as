package business
{
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	import mx.rpc.http.HTTPService;

	public class ServiceLocator
	{
		public function ServiceLocator()
		{
			if(__instance)
			{
				throw new Error("There is should be only one ServiceLocator instance.");
			}
		}
		
		private static var __instance:ServiceLocator;
		
		public static function get instance():ServiceLocator
		{
			if(__instance == null)
			{
				__instance = new ServiceLocator();
			}
			return __instance;
		}
		
		public function getService():URLLoader
		{
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			return loader;
		}
	}
}