package net.maygem.lib.utils
{
import flash.utils.getTimer;

public class UTimeStep
{
	private var _lastTime:Number = getTimer();

	public function UTimeStep()
	{
	}

	public function get elapsedMilliseconds():Number
	{
		var currTime:Number = getTimer();
		var res:Number = currTime - _lastTime;
		_lastTime = currTime;
		return res;
	}

	public function get elapsedSeconds():Number
	{
		return elapsedMilliseconds / 1000;
	}

	public function get elapsedMinutes():Number
	{
		return elapsedSeconds / 60;
	}
}
}