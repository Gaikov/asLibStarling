package net.maygem.lib.resources.customLoaders
{
import flash.events.EventDispatcher;

import net.maygem.lib.resources.events.LoaderEvent;

public class LoadMarker extends EventDispatcher implements ILoader
{
	private var _callback:Function;

	public function LoadMarker(callback:Function)
	{
		_callback = callback;
	}

	public function get progress() : Number
	{
		return 1;
	}

	public function get loadedContent() : *
	{
		return null;
	}

	public function load() : void
	{
		_callback();
		dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE));
	}
}
}