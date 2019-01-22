/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 03.08.12
 */
package com.ns.display.effects
{
import caurina.transitions.Equations;
import caurina.transitions.Tweener;

import flash.display.DisplayObject;

// http://hosted.zeh.com.br/tweener/docs/en-us/parameters/transition.html
public class JellyShowUp extends BaseDisplayEffect
{
	private var _time:Number;
	private var _completedTriggered:Boolean = false;
	private var _completeOnFrame:int;
	private var _framesLeft:int;

	public function JellyShowUp(object:DisplayObject,time:Number, completeOnFrame:int)
	{
		super(object);
		_time = time;
		_completeOnFrame = completeOnFrame;
	}

	override public function start(completedCallback:Function = null):void
	{
		super.start(completedCallback);
		Tweener.removeTweens(object);
		object.scaleX = 0;
		object.scaleY = 0;
		Tweener.addTween(object,
			{
				scaleX:1,
				scaleY:1,
				time:_time,
				onComplete:callCompleted,
				transition:Equations.easeOutElastic
			});

		_framesLeft = _completeOnFrame;
		_completedTriggered = false;
	}

	override public function onEnterFrame():void
	{
		if (!_completedTriggered)
		{
			_framesLeft --;
			if (_framesLeft <= 0)
			{
				callCompleted();
			}
		}
	}

	private function callCompleted():void
	{
		if (!_completedTriggered)
		{
			_completedTriggered = true;
			triggerCompleted();
		}
	}
}
}
