﻿package XGameEngine.GameObject.Component
{
	import XGameEngine.GameObject.BaseGameObject;
	
	/**
	 * ...
	 * @author o
	 */
	public class BaseComponent 
	{
		protected var host:BaseGameObject;
		public var enable:Boolean = true;
		
		public function BaseComponent(o:BaseGameObject)
		{
			host = o;
		}
		
		
	}
	
}