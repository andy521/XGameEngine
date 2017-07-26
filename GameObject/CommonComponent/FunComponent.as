﻿package XGameEngine.GameObject.CommonComponent
{
	import XGameEngine.Structure.List;
	
	/**
	 * ...
	 * @author o
	 */
	public class FunComponent
	{
		
		private var delayFuns:List = new List();
		public function FunComponent()
		{
			
		}
		
		
		/**
		 * 添加一个延迟调用的方法 可以通过不停调用AddInvokeTime来增加延时触发回调,
		 * 或者设置为自动回调 则按帧数自动累加
		 * @param string 标识id 不可重复
		 * @param number 回调前需要累加延时的次数(如果是自动累加则为帧数)
		 * @param fun 回调方法
		 * @param array 需要传递给回调方法的参数数组
		 * @param autoRecall 是否自动回调
		 * @param once 是否回调一次后就删除
		 * @return 
		 * 
		 */		
		public function addRecallFun(string:String, number:Number, fun:Function, array:Array=null,autoRecall:Boolean=false,once:Boolean=false)
		{
			var r:ReCallFun = new ReCallFun();
			r.name = string;
			r.delay = number;
			r.currentSum = 0;
			r.recall = fun;
			r.params = array;
			r.autoRecall=autoRecall;
			r.once=once;
			
			//不能重名
			for each(var f:ReCallFun in delayFuns.Raw)
			{
				if (f.name == string)
				{
					throw new Error("the name " + string + " has existed!");
				}
			}
			delayFuns.add(r);
		}
		
		
		public function loop():void 
		{
			//给自动回调的累加延时
			for each(var f:ReCallFun in delayFuns.Raw)
			{
				if(f.autoRecall)
				{
					f.currentSum++;
					checkInvoke();
				}
			}
		}
		
		/**
		 *检查一次是否有方法触发 
		 * 
		 */		
		private function checkInvoke():void
		{
			
			var needDelete:List=new List();
			
			for each(var f:ReCallFun in delayFuns.Raw)
			{
				if (f.currentSum >=f.delay)
				{
					//重新计时
					f.currentSum=0;
					if (f.params != null)
					{
						f.recall(f.params);
					}
					else
					{
						f.recall();
					}
					
					
					//如果只回调一次
					if(f.once==true)
					{
						needDelete.add(f);
					}
				}
			}
			
			
			//因为循环时没法删除 现在删除只回调一次的
			delayFuns.removeAll(needDelete.Raw);
			
		}
		
		/**
		 *累加延时值 
		 * @param name 需要累加延时值的方法的标识名字
		 * 
		 */		
		public function AddInvokeTime(name:String):void 
		{
			
			var f:ReCallFun=delayFuns.find(name,"name")as ReCallFun;
			f.currentSum++;
			
			//检查
			checkInvoke();
			
		}
		
		/**
		 * 快速调用某个方法任意次
		 * @param	fun
		 * @param	times
		 * @param	params
		 */
		public function RepeatInvokeFun(fun:Function,times:Number,params:Array=null):void 
		{
			for (var i:Number = 0; i < times; i++)
			{
				fun(params);
			}
		}
		
		
	}
	
}

class ReCallFun
{
	/**
	 *名字 只作为一个标识 
	 */	
	public var name:String;
	/**
	 *需要达到的延时 比如10 
	 */	
	public var delay:Number;
	/**
	 *当前累加的延时 
	 */	
	public var currentSum:Number;
	/**
	 *需要回调的方法 
	 */	
	public var recall:Function;
	/**
	 *需要传递给回调方法的参数数组 
	 */	
	public var params:Array;
	/**
	 *是否自动根据帧数累加延时值 
	 */	
	public var autoRecall:Boolean;
	/**
	 *是否回调一次之后就删除 
	 */	
	public var once:Boolean;
}
