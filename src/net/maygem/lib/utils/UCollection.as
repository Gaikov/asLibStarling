package net.maygem.lib.utils
{
public class UCollection
{
	static public function selectWherePropertyIs(collection:Object, propName:String, value:Object):Array
	{
		var list:Array = [];
		for each (var obj:Object in collection)
		{
			if (obj.hasOwnProperty(propName) && obj[propName] == value)
				list.push(obj);
		}
		return list;
	}

	static public function forEachCall(collection:Object, func:Function):void
	{
		for each (var item:Object in collection)
			func(item);
	}
}
}