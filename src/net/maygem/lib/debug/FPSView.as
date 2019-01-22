package
net.maygem.lib.debug
{
import flash.system.System;
import flash.utils.getTimer;

import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class FPSView extends TextField
{
	static private const MAX_FRAMES:int = 30;

	private var _prevTime:int = getTimer();
	private var _numFrames:int = 0;

	public function FPSView()
	{
		super(250, 50, "999 fps");
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		touchable = false;
		vAlign = VAlign.TOP;
		hAlign = HAlign.LEFT;
		height = textBounds.height + 5;

		addEventListener(Event.ADDED_TO_STAGE, function():void
		{
			y = stage.stageHeight - height;
		});
	}

	private function onEnterFrame(event:Event):void
	{
		_numFrames ++;
		if (_numFrames > MAX_FRAMES)
		{
			var currTime:int = getTimer();
			var time:int = currTime - _prevTime;
			_prevTime = currTime;
			text = String(int(_numFrames * 1000 / time)) + " FPS, mem: " + System.totalMemory / 1024 + " Kb";
			_numFrames = 0;
		}
	}
}
}