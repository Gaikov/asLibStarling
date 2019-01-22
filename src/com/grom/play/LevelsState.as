/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 17.12.12
 * Time: 8:02
 * To change this template use File | Settings | File Templates.
 */
package com.grom.play
{
import net.maygem.lib.settings.UserSettingsManager;
import net.maygem.lib.settings.UserVar;

public class LevelsState
{
	private var _lastUnlockedLevel:UserVar;
	private var _settings:UserSettingsManager = UserSettingsManager.instance();
	private var _levelPrefix:String;
	private var _numLevels:int;

	public function LevelsState(gameMode:int, numLevels:int)
	{
		_numLevels = numLevels;
		_levelPrefix = "mode" + gameMode + "_level_";
		_lastUnlockedLevel = new UserVar("last_unlocked_level" + gameMode, 0);

		for (var i:int = 0; i < _numLevels; i++)
		{
			_settings.addParam(_levelPrefix + i, 0);
		}
	}

	public function get lastUnlockedLevel():int
	{
		return int(_lastUnlockedLevel.value);
	}

	public function set lastUnlockedLevel(level:int):void
	{
		_lastUnlockedLevel.value = level;
	}

	public function getLevelSkill(level:int):int
	{
		return int(_settings.getParam(_levelPrefix + level));
	}

	public function updateLevelSkill(level:int, stars:int):void
	{
		var curr:int = getLevelSkill(level);
		if (curr < stars)
		{
			_settings.setParam(_levelPrefix + level, stars);
		}
	}

	public function reset():void
	{
		_lastUnlockedLevel.value = 0;
		for (var i:int = 0; i < _numLevels; i++)
		{
			_settings.setParam(_levelPrefix + i, 0);
		}
	}
}
}
