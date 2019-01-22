package net.maygem.lib.resources.customLoaders
{
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.MovieClip;

import flash.events.Event;
import flash.events.IOErrorEvent;

import flash.utils.ByteArray;

import net.maygem.lib.debug.Log;
import net.maygem.lib.utils.UContainer;

public class ClassLoader extends BinaryLoader
{
	private var _className:String;

	private var _loader:Loader;

	public function ClassLoader(fileName:String, className:String, resultCallBack:Function = null)
	{
		super(fileName, resultCallBack);
		_className = className;

		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
	}

	private function onComplete(event:Event):void
	{
		var cls:Class;
		try
		{
			cls = Class(_loader.contentLoaderInfo.applicationDomain.getDefinition(_className));
		}
		catch (e:Error)
		{
			Log.error("can't get " + _className + " from resource: " + fileName);
		}

		if (_loader.content is DisplayObjectContainer)
			UContainer.removeAllChildren(DisplayObjectContainer(_loader.content));
		if (_loader.content is MovieClip)
			MovieClip(_loader.content).stop();
		_loader.unload();

		onDataExtracted(cls);
	}

	private function onIOError(event:IOErrorEvent):void
	{
		onDataExtracted(null);
	}

	override protected function extractData(bytes:ByteArray):void
	{
		if (bytes.length)
		_loader.loadBytes(bytes);
		else
			onDataExtracted(null);
	}
}
}