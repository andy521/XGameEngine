﻿package XGameEngine
{
	import XGameEngine.Manager.GameObjectManager;
	import XGameEngine.Manager.*;
	import XGameEngine.Manager.TimeManager;
	import XGameEngine.Advanced.Debug.*;
	import flash.display.Stage;
	import flash.events.Event;
	import XGameEngine.Advanced.Interface.LoopAble;
	import XGameEngine.Structure.*;
	/**
	 * ...
	 * a class that control the overall gameengine
	 */
	public class GameEngine 
	{
		static private var _instance:GameEngine;
		
		
		static public function getInstance():GameEngine
		{
				if (_instance == null)
				{
					_instance = new GameEngine();
				}
				return _instance;
		}
		
		
		private var s:Stage;
		private var list:List = new List();
		private var _debug:Boolean = false;
		
		/**
		 * 游戏运行中能否改变debug状态 发行版游戏中一般设置为false
		 */
		public var canChangeDebug:Boolean=false;
		/**
		 * this should be called when game inited,generally from the entry class
		 * @param	s
		 */
		public function Init(s:Stage)
		{
			Input.Init(s);
			this.s = s;
			s.addEventListener(Event.ENTER_FRAME, loop);
			InitManager();
			
		}
		
		
		//初始化
		public function InitManager()
		{
			
			TimeManager.getInstance();
			HitManager.getInstance();
		}
		
		public function getTimeManager():TimeManager
		{
			return TimeManager.getInstance();
		}
		
		public function getTagManager():TagManager
		{
			return TagManager.getInstance();
		}
		
		public function getGameObjectManager():GameObjectManager
		{
			return GameObjectManager.getInstance();
		}
		public function getLayerManager():LayerManager
		{
			return LayerManager.getInstance();
		}
		public function getHitManager():HitManager
		{
			return HitManager.getInstance();
		}
		
		
		private function loop(e:Event)
		{
			for (var i = 0; i < list.size; i++)
			{
				(list.get(i) as LoopAble).loop();
			}
		}
		
		public function addLoopAble(l:LoopAble)
		{
			list.add(l);
			
		}
		
		public function getStage():Stage 
		{
			return s;
		}
		
		public function get debug():Boolean 
		{
			return _debug;
		}
		
		public function set debug(value:Boolean):void 
		{
			if (canChangeDebug)
			{
				_debug = value;
			}
			
		}
		
	}
	
}