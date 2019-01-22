package net.maygem.lib.settings
{
import flash.net.*;
import flash.events.EventDispatcher;

public class UserSettingsManager extends EventDispatcher
{
	static private var _inst:UserSettingsManager = null;
	private var _so:SharedObject;

	function UserSettingsManager()
	{
		this._so = SharedObject.getLocal("local_settings");
	}

	public static function instance():UserSettingsManager
	{
		if (_inst == null) _inst = new UserSettingsManager();
		return _inst;
	}

	public function addParam(nameSetting:String, defaultValue:Object, needFlush:Boolean = true):Boolean
	{
		if (this._so.data[nameSetting] != undefined) return false;
		this._so.data[nameSetting] = defaultValue;

		if (needFlush) this._so.flush();
		return true;
	}

	public function getParam(nameSetting:String):Object
	{
		return this._so.data[nameSetting];
	}

	public function setParam(nameSetting:String, value:Object, needFlush:Boolean = true, force:Boolean = false):Boolean
	{
		if (force || this._so.data[nameSetting] != value)
		{
			this._so.data[nameSetting] = value;
			if (needFlush) this._so.flush();
			return true;
		}
		return false;
	}
}
}