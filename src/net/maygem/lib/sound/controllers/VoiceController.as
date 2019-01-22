/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.11.12
 */
package net.maygem.lib.sound.controllers
{
import net.maygem.lib.sound.*;

import flash.geom.Point;

public class VoiceController
{
	private var _voice:IVoice;
	private var _class:Class;

	public function VoiceController(soundClass:Class)
	{
		_class = soundClass;
	}

	public function play(pos:Point):void
	{
		if (!_voice)
		{
			_voice = SoundManager.instance.playStereo(_class, pos.x, pos.y, true);
		}
		else
		{
			updatePos(pos);
		}
	}

	public function updatePos(pos:Point):void
	{
		if (_voice)
		{
			SoundManager.instance.setPosition(_voice, pos.x, pos.y);
		}
	}

	public function stop():void
	{
		if (_voice)
		{
			SoundManager.instance.stopStereo(_voice);
			_voice = null;
		}
	}
}
}
