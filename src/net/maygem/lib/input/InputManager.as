package net.maygem.lib.input
{
import net.maygem.lib.debug.Log;
import net.maygem.lib.input.keyboard.IKeyListener;
import net.maygem.lib.utils.UArray;

import starling.display.Stage;
import starling.events.KeyboardEvent;

public class InputManager
{
	static private var _inst:InputManager;

	private var _stage:Stage;
	private var _keyListeners:Array = [];

	public function InputManager()
	{
	}

	static public function instance():InputManager
	{
		if (!_inst)
			_inst = new InputManager();
		return _inst;
	}

	public function attachToStage(stage:Stage):void
	{
		if (!stage) return;
		_stage = stage;
		_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	public function addListener(listener:IKeyListener, capture:Boolean = false):void
	{
		_keyListeners.push(listener);
	}

	public function removeListener(listener:IKeyListener):void
	{
		UArray.removeItem(_keyListeners, listener);
	}

	private function onKeyDown(event:KeyboardEvent):void
	{
		for each (var listener:IKeyListener in _keyListeners)
			listener.onKeyDown(event.keyCode);
		Log.info("key down: ", event.keyCode);
	}

	private function onKeyUp(event:KeyboardEvent):void
	{
		for each (var listener:IKeyListener in _keyListeners)
			listener.onKeyUp(event.keyCode);
	}
}
}