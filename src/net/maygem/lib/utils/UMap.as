package net.maygem.lib.utils
{
public class UMap
{
	static public function collectNames(map : Object) : Array
	{
		var res:Array = [];
		for (var name:String in map)
			res.push(name);
		return res;
	}

	static public function collectValues(map:Object):Array
	{
		var res:Array = [];
		for each (var value:Object in map)
			res.push(value);
		return res;
	}

	public static function count(map : Object) : int
	{
		var count : int = 0;
		for each (var object : Object in map)
		{
			count++;
		}
		return count;
	}

	public static function clone(map : Object) : Object
	{
		var res : Object = {};
		for (var id : String in map)
			res[id] = map[id];
		return res;
	}

	public static function collectKeys(obj:Object):Array
	{
		var res:Array = [];
		for (var key:Object in obj)
		{
			res.push(key);
		}
		return res;
	}
}
}