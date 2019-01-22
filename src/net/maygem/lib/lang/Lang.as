package net.maygem.lib.lang
{
import mx.resources.ResourceManager;

import net.maygem.lib.utils.UString;

public class Lang
{
	static public function getString(name:String, defaultValue:String = ""):String
	{
		var res:String = ResourceManager.getInstance().getString(null, name);
		if (!res)
			res = defaultValue ? defaultValue : name;
		return res ? res : "";
	}

	static public function replaceParams(name:String, params:Object):String
	{
		var map:Object = {};
		for (var id:String in params)
			map[id] = Lang.getString(params[id]);

		return UString.replaceParams(getString(name), map);
	}
}
}