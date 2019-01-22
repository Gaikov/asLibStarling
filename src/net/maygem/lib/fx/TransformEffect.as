package net.maygem.lib.fx
{
import flash.events.EventDispatcher;

import net.maygem.lib.fx.events.TransformEvent;
import net.maygem.lib.utils.UMath;

internal class TransformEffect extends EventDispatcher implements ITransformEffect 
{
	protected var _lerp:Number = 0;
	protected var _lerpStep:Number;
	protected var _currStep:Number = 0;

	public function TransformEffect(frameStep:Number)
	{
		FXManager.instance().addEffect(this);
		_lerpStep = frameStep;
		transformFunction();
	}

	public function destroy():void
	{
		FXManager.instance().removeEffect(this);
	}

	final public function isActive():Boolean
	{
		return _currStep != 0;
	}

	public function get value():Number
	{
		return _lerp;
	}

	final public function setPosition(value:Number):void
	{
		value = UMath.clamp(value, 0, 1);
		if (value != _lerp)
		{
			_lerp = value;
			dispatchEvent(new TransformEvent(TransformEvent.VALUE_CHANGED, transformFunction()));
		}
	}

	final public function forward():void
	{
		_currStep = _lerpStep;
	}

	final public function backward():void
	{
		_currStep = -_lerpStep;
	}

	final public function stop():void
	{
		_currStep = 0;
	}

	internal function transformFunction():Number
	{
		return 0;
	}

	internal function step():void
	{
		if (!_currStep) return;

		var complete:Boolean = false;

		_lerp += _currStep;
		if (_lerp >= 1)
		{
			_lerp = 1;
			_currStep = 0;
			complete = true;
		}
		else if (_lerp <= 0)
		{
			_lerp = 0;
			_currStep = 0;
			complete = true;
		}

		var res:Number = transformFunction();
		dispatchEvent(new TransformEvent(TransformEvent.VALUE_CHANGED, res));

		if (complete)
			dispatchEvent(new TransformEvent(TransformEvent.TRANSFORM_COMPLETE, res));
	}
}
}