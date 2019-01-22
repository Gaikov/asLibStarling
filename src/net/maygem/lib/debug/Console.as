package net.maygem.lib.debug
{
import flash.ui.Keyboard;

import starling.display.Stage;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.text.TextField;

internal class Console
{
	private var _tf:TextField = new TextField(100, 100, "");
	private var _tfInput:TextField = new TextField(100, 100, "");
	private var _visible:Boolean;
	private var _stage:Stage;
	private var _allowed:Boolean = true;

	public function Console()
	{
		_tf.border = true;
		_tfInput.border = true;
		_tfInput.addEventListener(KeyboardEvent.KEY_DOWN, onInputKeyDown);
	}

	public function set allowed(value:Boolean):void
	{
		if (_allowed != value)
		{
			_allowed = value;

			if (_stage)
			{
				if (_allowed)
					_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				else
					_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
		}
	}

	public function get visible():Boolean
	{
		return _visible;
	}

	public function trace(text:String, color:uint = 0xffffff):void
	{
		_tf.text += text;
	}

	public function attachToStage(stage:Stage):void
	{
		_stage = stage;
		_stage.addEventListener(Event.RESIZE, onStageResize);

		if (_allowed)
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

		updateSize();
	}

	private function onStageResize(e:Event):void
	{
		updateSize();
	}

	private function onInputKeyDown(e:KeyboardEvent):void
	{
		if (e.keyCode == Keyboard.ENTER)
		{
			var cmd:String = _tfInput.text;
			_tfInput.text = "";
			CmdManager.instance().exec(cmd);
		}
		else if (e.keyCode == Keyboard.END && _tfInput.text)
		{
			var name:String = CmdManager.instance().autoComplete(_tfInput.text);
			if (name)
				_tfInput.text = name;
		}
	}

	private function onKeyDown(e:KeyboardEvent):void
	{
		if (!_stage) return;

		if ( e.keyCode == 192 )
			toggle(!_visible);
		if (e.keyCode == 67 && e.ctrlKey && e.shiftKey)
			toggle(!_visible);
		else if (e.keyCode == 27)
			toggle(false);
	}

	private function toggle(on:Boolean):void
	{
		if (_visible == on) return;

		_visible = on;
		if (_visible)
		{
			_stage.addChild(_tf);
			_stage.addChild(_tfInput);
			_tfInput.addEventListener(Event.ENTER_FRAME, onInputFrame);
			updateSize();
		}
		else
		{
			_stage.removeChild(_tf);
			_stage.removeChild(_tfInput);
		}
	}

	private function onInputFrame(e:Event):void
	{
		_tfInput.removeEventListener(Event.ENTER_FRAME, onInputFrame);
	}

	private function updateSize():void
	{
		_tf.width = _stage.stageWidth;
		_tf.height = _stage.stageHeight / 2;

		_tfInput.y = _tf.height;
		_tfInput.width = _stage.stageWidth;
		_tfInput.height = 20;
	}
}
}