package com.ns.utils
{
	public class UTime
	{
		static public function Now():uint
		{
			var d:Date = new Date();
			return d.getTime();
		}
		
		static public function AddZero(value:int):String
		{
			return value < 10 ? ("0" + value) : value.toString();
		}
		
		static public function TimeFormatMin(value:int):String
		{
			var min:int = value / 60;
			var sec:int = value % 60;
			
			return AddZero(min) + ":" + AddZero(sec);
		}
		
		static public function CustomDateFormat(date:Date):String
		{
			return date.toDateString().split(" ")[1] + ", " + date.date + " " 
				+ date.toTimeString().split(" ")[0];
		}		
	}
}