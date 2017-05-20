﻿package XGameEngine.GameObject.Component.Collider
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import XGameEngine.GameEngine;
	import XGameEngine.Structure.List;
	
	/**
	 * ...
	 * 不规则碰撞器 使用与地图等不规则形状 一般在编辑器中创建形状 但是也可以调用函数添加多个形状组合
	 */
	public class MeshCollider extends Collider
	{
		
		private var c:Sprite; 
		
		/**
		 * 可以使用编辑器中创建的不规则形状初始化该碰撞器
		 * @param	a
		 */
		public function MeshCollider(a:Sprite=null)
		{
			if (a != null)
			{
				//a必须只有一个子级而且必须是shape
				getCommonlyComponent().throwWhileNotTrue(a.numChildren == 1 && (a.getChildAt(0) is Shape), "mesh collider init error");
				
				c = a;
				addChild(c);
			
				
			}
			
			
		}
		
		
		/**
		 * 这里不返回点 该碰撞器只作为被测试对象在碰撞管理器中被调用 不过这样做的后果是两个多边形碰撞器无法互相检测到
		 * 即该碰撞器只能检测和方形碰撞器的碰撞
		 * 不过两个多边形碰撞需要检测的时候我还没遇到过 真遇到了再添加一个特殊的算法吧
		 * @return
		 */
		override public function getCheckPoint():List
		{
			var list:List = new List();
			
			
			return list;
		}
	
	
		override public function debugShape() 
		{
			if (GameEngine.getInstance().debug && debug)
			{
				//这里必须要有一个shape 就算不是debug模式 也要设置为透明 因为碰撞器必须实际存在
				
				c.alpha = 0.5;
			}
			else if(GameEngine.getInstance().debug==false || debug==false)
			{
				c.alpha = 0;
			}
		}
		
		
		
		
	}
	
}