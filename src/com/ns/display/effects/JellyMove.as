/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.06.12
 */
package com.ns.display.effects
{
import flash.display.DisplayObject;

public class JellyMove extends BaseDisplayEffect
{
	private var _scaleAmp:Number = 0;
	private var _angleStep:Number = 0;
	private var _ampDownSpeed:Number = 0;
	private var _angle:Number = 0;
	private var _continueAmp:Boolean;
	private var _startAmp:Number;

	public function JellyMove(object:DisplayObject,startAmp:Number, angleStep:Number, ampDownSpeed:Number, continueAmp:Boolean = false)
	{
		super(object);
		_startAmp = startAmp;
		_scaleAmp = startAmp;
		_angleStep = angleStep;
		_ampDownSpeed = ampDownSpeed;
		_continueAmp = continueAmp;
	}

	override public function start(onCompleted:Function = null):void
	{
		super.start(onCompleted);
		if (!_continueAmp)
		{
			_angle = 0;
		}
		_scaleAmp = _startAmp;
	}

	override public function onEnterFrame():void
	{
		if (_scaleAmp <= 0)
		{
			return;
		}

		_angle += _angleStep;
		_scaleAmp -= _ampDownSpeed;
		if (_scaleAmp <= 0)
		{
			object.scaleX = object.scaleY = 1;
			triggerCompleted();
		}
		else
		{
			var s:Number = _scaleAmp * Math.sin(_angle);
			object.scaleX = 1 + s;
			object.scaleY = 1 - s;
		}
	}
}
}
