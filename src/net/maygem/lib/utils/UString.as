package net.maygem.lib.utils
{
public class UString
{
	static public function replaceParams(pattern:String, map:Object):String
	{
		var res:String = pattern;
		for (var name:String in map)
		{
			var value:Object = map[name];
			res = res.replace("{" + name + "}", value);
		}

		return res;
	}

	static public function clamp(str:String, maxLength:int):String
	{
		if (!str) return "";

		maxLength -= 3;
		if (str.length > maxLength)
			str = str.slice(0, maxLength) + "...";

		return str;
	}

	static public function clampTakeWords(str : String, maxLength : int) : String
	{
		if (str.length > maxLength)
		{
			var words : Array = str.split(" ");
			var tmp : String = "";
			for (var i : int = 0; i < words.length; i++)
			{
				tmp += words[i] + " ";
				if (tmp.length > maxLength && i != words.length - 1)
					return tmp + "...";
			}
		}
		return str;
	}

	static public function prefixZero(value:int, size:int):String
	{
		var strVal:String = value.toString();
		if (strVal.length < size)
		{
			var prefix:String = "";
			for (var i:int = 0; i < size - strVal.length; i++)
			{
				prefix += "0";
			}
			strVal = prefix + strVal;
		}
		return strVal;
	}

	// "*" - arbitrary sequence of characters
	static public function compareWithPattern(source:String, pattern:String):Boolean
	{
		var reg:RegExp = new RegExp("^" + pattern.replace("*", ".*"), "g");
		var match:Array = source.match(reg);
		return match && match.length;
	}
}
}