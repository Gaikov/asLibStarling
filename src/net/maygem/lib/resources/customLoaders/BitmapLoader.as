package net.maygem.lib.resources.customLoaders
{
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;

import flash.utils.ByteArray;

import net.maygem.lib.debug.Log;

public class BitmapLoader extends BinaryLoader
{
	private var _loader:Loader;

	public function BitmapLoader(fileName : String, resultCallBack : Function)
	{
		super(fileName, resultCallBack);

		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
	}

	private function onComplete(event:Event):void
	{
		var bitmap:Bitmap = _loader.content as Bitmap;
		if (!bitmap)
		{
			Log.error(fileName + " - is not bitmap!");
			onDataExtracted(null);
		}
		else
			onDataExtracted(bitmap.bitmapData);
	}

	private function onIOError(event:IOErrorEvent):void
	{
		onDataExtracted(null);
	}

	override protected function extractData(bytes:ByteArray):void
	{
		_loader.loadBytes(bytes);
	}
}
}