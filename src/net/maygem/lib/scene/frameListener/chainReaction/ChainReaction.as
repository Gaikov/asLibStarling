/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.06.12
 */
package net.maygem.lib.scene.frameListener.chainReaction
{
import starling.animation.IAnimatable;
import starling.core.Starling;

public class ChainReaction implements IAnimatable
{
	private var _actions:Array = [];
	private var _timeInterval:Number;
	private var _timeLeft:Number = 0;
	private var _completeCallback:Function;
	
	public function ChainReaction(timeInterval:Number, completeCallback:Function = null)
	{
		_timeInterval = timeInterval;
		_completeCallback = completeCallback;
		Starling.juggler.add(this);
	}

	public function set completeCallback(value:Function):void
	{
		_completeCallback = value;
	}

	public function isActive():Boolean
	{
		return _actions.length != 0;
	}

	public function addAction(action:Function):void
	{
		_actions.push(action);
	}

	public function addActionPolicy(action:IChainAction):void
	{
		_actions.push(action);
	}

	public function clear():void
	{
		_actions.length = 0;
		Starling.juggler.remove(this);
	}

	public function advanceTime(time:Number):void
	{
		_timeLeft -= time;
		if (_timeLeft <= 0)
		{
			_timeLeft = _timeInterval;
			var action:Object = _actions.shift();
			if (action)
			{
				doAction(action);

				if (!_actions.length)
				{
					Starling.juggler.remove(this);
					if (_completeCallback != null)
					{
						_completeCallback();
					}
				}
			}
		}
	}

	private static function doAction(action:Object):void
	{
		if (action is Function)
		{
			(action as Function)();
		}
		else if (action is IChainAction)
		{
			(action as IChainAction).doAction();
		}
	}
}
}
