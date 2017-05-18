﻿package XGameEngine.GameObject.Component
{
	import flash.text.TextFieldAutoSize;
	import flash.geom.Point;
	import XGameEngine.UI.Draw.*;
	import XGameEngine.UI.*;
	import XGameEngine.GameEngine;
	import XGameEngine.GameObject.BaseGameObject;
	
	/**
	 * ...
	 * @author o
	 */
	public class StateComponent extends BaseComponent
	{
		
		public var lastState:String;
		
		
		private var debug_stateTF:XTextField;
		public function StateComponent(o:BaseGameObject)
		{
			super(o);
			
			
		}
		
		
		public function changeState(newState:String)
		{
			//如果上一个状态存在的话
			if (lastState != null)
			{
				host.onStateExit(lastState);
			}
			host.onStateEnter(newState, lastState)
			
			lastState = newState;
			
		}
		
		public function loop()
		{
			if (host.state != null)
			{
			host.onStateDuring(host.state);	
			}
			
			
			DebugState();
		}
		
		
		/**
		 * 绘制当前状态
		 */
		public function DebugState()
		{
			if (GameEngine.getInstance().debug)
			{
				if (host.state != null)
				{
					if (debug_stateTF == null)
					{
						debug_stateTF = new XTextField();
						host.stage.addChild(debug_stateTF);
						debug_stateTF.size = 20;
						debug_stateTF.textColor = Color.BLACK;

						debug_stateTF.autoSize = TextFieldAutoSize.CENTER;
						
						
					}
					
					 var point:Point = host.getTransformComponent().oldaabb.getTopPoint();
					 var point2:Point=host.localToGlobal(point);
					debug_stateTF.x = point2.x-debug_stateTF.textWidth/2;
					debug_stateTF.y = point2.y-20;
					
					debug_stateTF.setText(host.state);
				}
			}
		}
		
	}
	
}