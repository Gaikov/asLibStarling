package net.maygem.lib.debug.ui
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;

import net.maygem.lib.debug.CmdManager;
import net.maygem.lib.debug.Log;

public class DebugUIManager
{
	private static var _instance:DebugUIManager;

	private var _root:Sprite = new Sprite();
	private var _viewsMap:Object = {};
	private var _stage:Stage;

	public function DebugUIManager()
	{
		_root.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		CmdManager.instance().register("debug_view", cmdDebugView);
		_root.mouseEnabled = false;

		addView("mem", new MemoryDebugView);
	}

	public static function instance() : DebugUIManager
	{
		if (!_instance)
			_instance = new DebugUIManager();
		return _instance;
	}

	public function addView(id:String, view:IDebugView):void
	{
		var old:DisplayObject = _viewsMap[id];
		if (old && old.parent == _root)
			_root.removeChild(old);

		_viewsMap[id] = DisplayObject(view);
	}

	public function showView(id:String):void
	{
		var view:DisplayObject = _viewsMap[id];
		if (!view)
			Log.warning(id, " - debug view not found!");
		else if (view.parent != _root)
		{
			_root.addChild(view);
			IDebugView(view).updateLayout(_stage.stageWidth, _stage.stageHeight);
		}
		else
			_root.removeChild(view);
	}

	private function onAddedToStage(event : Event) : void
	{
		_stage = _root.stage;
		_stage.addEventListener(Event.RESIZE, onStageResize);
	}

	private function onStageResize(event : Event) : void
	{
		for each (var view:DisplayObject in _viewsMap)
		{
			if (view.parent == _root)
				IDebugView(view).updateLayout(_stage.stageWidth, _stage.stageHeight);
		}
	}

	private function cmdDebugView(args:Array):void
	{
		if (args.length)
			showView(args[0]);
		else
			Log.info("usage: debug_view [id]");
	}

	public function get root() : Sprite
	{
		return _root;
	}
}
}