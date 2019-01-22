/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 30.11.12
 */
package net.maygem.lib.sound.controllers
{
import flash.geom.Point;

import net.maygem.lib.sound.IVoice;
import net.maygem.lib.sound.SoundManager;

public class ComplexVoiceController
{
	private var _beginClass:Class;
	private var _loopClass:Class;
	private var _endClass:Class;

	private var _voice:IVoice;
	private var _pos:Point = new Point();

	public function ComplexVoiceController(beginClass:Class, loopClass:Class, endClass:Class)
	{
		_beginClass = beginClass;
		_loopClass = loopClass;
		_endClass = endClass;
	}

	public function play(pos:Point):void
	{
		if (_voice)
		{
			SoundManager.instance.stopStereo(_voice);
		}

		_pos.x = pos.x;
		_pos.y = pos.y;
		_voice = SoundManager.instance.playStereo(_beginClass, pos.x, pos.y);
		if (_voice)
		{
			_voice.addCompleteHandler(function ():void
			{
				_voice = SoundManager.instance.playStereo(_loopClass, _pos.x, _pos.y, true);
			});
		}
	}

	public function updatePos(pos:Point):void
	{
		_pos.x = pos.x;
		_pos.y = pos.y;

		if (_voice)
		{
			SoundManager.instance.setPosition(_voice, _pos.x, _pos.y);
		}
	}

	public function stop():void
	{
		if (_voice)
		{
			SoundManager.instance.stopStereo(_voice);
			_voice = null;
			SoundManager.instance.playStereo(_endClass, _pos.x, _pos.y);
		}
	}


}
}
