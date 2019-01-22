package net.maygem.lib.utils
{
	public class UDate
	{
		static public function now():uint
		{
			var d:Date = new Date();
			return d.getTime();
		}
		
		static public function addZero(value:int):String
		{
			return value < 10 ? ("0" + value) : value.toString();
		}
		
		static public function timeFormat(value:int):String
		{
			var min:int = value / 60;
			var sec:int = value % 60;
			
			return UDate.addZero(min) + ":" + UDate.addZero(sec);
		}
	}
}