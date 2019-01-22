package net.maygem.lib.ui.layout.builder
{
import flash.display.DisplayObject;

import flash.display.Sprite;

import net.maygem.lib.debug.Log;

public class SkinsRegistry
{
	static private var _instance : SkinsRegistry;

	private var _skinsMap : Object = {};

	public function SkinsRegistry()
	{
	}

	static public function instance() : SkinsRegistry
	{
		if (!_instance)
			_instance = new SkinsRegistry();
		return _instance;
	}

	public function registerSkin(id : String, cls : Class) : void
	{
		if (_skinsMap[id])
			Log.warning("skin already registered with id: ", id);
		else
			_skinsMap[id] = cls;
	}

	public function createSkin(id : String) : DisplayObject
	{
		var cls : Class = _skinsMap[id];
		if (!cls)
		{
			cls = Sprite;
			Log.warning("skin not found by id: ", id);
		}
		return new cls();
	}

	public function getSkinClass(id : String) : Class
	{
		var cls : Class = _skinsMap[id];
		if (!cls)
			Log.warning("skin class not found by id: ", id);
		return cls;
	}
}
}