﻿package XGameEngine.GameObject.Map
{
	import Script.GameObject.GameMap;
	
	import XGameEngine.GameObject.BaseGameObject;
	import XGameEngine.GameObject.BaseComponent.FunComponent;
	import XGameEngine.GameObject.BaseComponent.GameObjectComponent;
	import XGameEngine.GameObject.BaseComponent.TransformComponent;
	import XGameEngine.Math.Vector2;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * 普通单层地图
	 * @author o
	 */
	public class BaseMap extends AbstractMap  
	{
	
		/**
		 * 地图的边界是否可以显示在地图内
		 */
		public var canOver:Boolean = false;
		
		/**
		 *移动缩放系数 
		 */		
		public var moveScale:Number = 1;
		
		public function BaseMap(moveScale:Number=-1)
		{
			this.xname ="BaseMap "+this.name;
			
			if (moveScale != -1)
			{
				this.moveScale = moveScale;
			}
		
			
		}
		
		
		/**
		 *移动 如果无法继续移动则返回false 只有xy都可以移动时才会真正改变位置 
		 * @param x 移动的x值
		 * @param y 移动的y值
		 * @return  移动缩放后移动的距离
		 * 
		 */		
		override public function move(x:Number,y:Number):Vector2
		{
			
			
			//基于移动缩放系数转换成真实值
			var v:Vector2 = getRealValue(x, y);
			var moveX:Number = v.x;
			var moveY:Number = v.y;
			
			//这次移动是否成功(xy都需要移动成功才行,只有同时成功时才可以真正移动)
			if (canMove(moveX,moveY))
			{
				this.x += moveX;
				this.y += moveY;
				
				return new Vector2(moveX, moveY);
			}
			
			//返回移动的实际值	
			return new Vector2(0,0);
			
		
			//throw new Error("can't call the base function!");
		}
		
		
		/**
		 *计算移动的实际值	 
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */		
		private function getRealValue(x:Number, y:Number):Vector2 
		{	
			var p:Vector2 = new Vector2(x*moveScale,y*moveScale);
			return p;
		}
		
	
		
		
		/**
		 * 测试能否移动
		 * @param	moveX
		 * @param	moveY
		 * @return
		 */
		override public function canMove(moveX:Number,moveY:Number):Boolean
		{
			
			
			var b:int = 0;
			
			var leftTopGlobal:Point=this.localToGlobal(this.getTransformComponent().aabb.getLeftTopPoint());
			var rightTopGlobal:Point=this.localToGlobal(this.getTransformComponent().aabb.getRightTopPoint());
			var leftBottomGlobal:Point=this.localToGlobal(this.getTransformComponent().aabb.getLeftBottomPoint());
			
			if (canOver == false)
			{
				//测试x值是否能够移动(这边怕有一些微小的计算偏差而导致出现白边  所以加了5个像素值作为缓冲)
				
				//x往右移动 此时左上角的点x必须加上移动距离后<0
				if (moveX > 0&&leftTopGlobal.x+moveX < -5)
				{
						b += 1;				
				}
				//x往左移动 此时右上角的点x减去移动距离必须大于舞台右侧
				else if (moveX < 0 && rightTopGlobal.x+moveX > stage.stageWidth+5)
				{
					b += 1;
				}
				else if (moveX == 0)
				{
					b += 1;
				}
				
				
				//测试y值是否能够移动
				
				//y往下移动 此时左上角的点y必须小于0
				if (moveY > 0&&leftTopGlobal.y+moveY < -5)
				{
						b += 1;					
				}
				//y往上移动 此时左下角的点的y必须在舞台下侧
				else if (moveY < 0 && leftBottomGlobal.y +moveY> stage.stageHeight+5)
				{
					b += 1;
				}
				else if (moveY == 0)
				{
					b += 1;
				}
			}
			else
			{
				//没有越界限制则直接返回true
					return true;
			}
			
			//xy值是否都可以移动
				return b==2;

		}
		
		
		
		
	}
	
}