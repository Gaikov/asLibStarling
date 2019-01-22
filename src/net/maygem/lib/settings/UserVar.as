package net.maygem.lib.settings
{
import flash.events.EventDispatcher;

public class UserVar extends EventDispatcher
{
	private var _name:String;
	private var _needFlash:Boolean;

	public function UserVar(name:String, defValue:Object, needFlash:Boolean = true)
	{
		_name = name;
		_needFlash = needFlash;
		UserSettingsManager.instance().addParam(name, defValue, _needFlash);
	}

	public function get value():*
	{
		return UserSettingsManager.instance().getParam(_name);
	}

	public function set value(value:*):void
	{
		UserSettingsManager.instance().setParam(_name, value, _needFlash);
	}

	public function forceValue(value:*):void
	{
		UserSettingsManager.instance().setParam(_name, value, _needFlash, true);
	}
}
}