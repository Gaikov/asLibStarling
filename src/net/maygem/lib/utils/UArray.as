package net.maygem.lib.utils
{
public class UArray
{
	static public function removeItem(a:Array, item:Object):Boolean
	{
		for (var i:int = 0; i < a.length; i++)
		{
			if (a[i] == item)
			{
				a.splice(i, 1);
				return true;
			}
		}
		return false;
	}

	static public function getRandom(list:Array):*
	{
		if (!list || !list.length)
		{
			return null;
		}
		return list[UMath.random(list.length - 1)];
	}

	static public function mixRandom(list:Array):Array
	{
		var mixArray:Array = [];
		for each (var item:Object in list)
		{
			mixArray.push(new MixEntry(item));
		}

		mixArray.sortOn("sortValue", Array.NUMERIC);

		var res:Array = [];
		for each (var mixEntry:MixEntry in mixArray)
		{
			res.push(mixEntry.obj);
		}

		return res;
	}

	public static function cycleLeft(list:Array):void
	{
		var first:* = list[0];
		for (var i:int = 1; i < list.length; i++)
		{
			list[i - 1] = list[i];
		}
		list[list.length - 1] = first;
	}

	public static function cycleRight(list:Array):void
	{
		var last:* = list[list.length - 1];
		for (var i:int = list.length - 1; i > 0; i--)
		{
			list[i] = list[i - 1];
		}
		list[0] = last;
	}
}
}

class MixEntry
{
	public var obj:Object;
	public var sortValue:Number;

	public function MixEntry(obj:Object)
	{
		this.obj = obj;
		sortValue = Math.random() * 10000;
	}
}