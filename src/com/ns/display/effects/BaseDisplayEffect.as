/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 03.08.12
 */
package com.ns.display.effects
{
import flash.display.DisplayObject;

import net.maygem.lib.scene.frameListener.FramePolicy;
import net.maygem.lib.scene.frameListener.IFrameListener;

public class BaseDisplayEffect implements IFrameListener
{
	private var _object:DisplayObject;
	private var _framePolicy:FramePolicy;
	private var _completedCallback:Function;

	public function BaseDisplayEffect(object:DisplayObject)
	{
		_object = object;
		//_framePolicy = new FramePolicy(this, object);
	}

	public function destroy():void
	{
		_framePolicy.destroy();
	}

	final protected function get object():DisplayObject
	{
		return _object;
	}

	public function start(onCompleted:Function = null):void
	{
		_completedCallback = onCompleted;
	}

	public function onEnterFrame():void
	{
	}

	final protected function triggerCompleted():void
	{
		if (_completedCallback != null)
		{
			_completedCallback();
		}
	}
}
}
