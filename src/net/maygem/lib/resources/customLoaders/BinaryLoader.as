package net.maygem.lib.resources.customLoaders
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;

import flash.utils.ByteArray;

import net.maygem.lib.debug.Log;
import net.maygem.lib.resources.events.LoaderEvent;

public class BinaryLoader extends EventDispatcher implements ILoader
{
	private var _loader:            URLLoader = new URLLoader();
	private var _fileName:          String;
	private var _resultCallBack:    Function;
	private var _state:             int = States.NONE;
	private var _data:              Object;

	public function BinaryLoader(fileName:String, resultCallBack:Function = null)
	{
		super();

		_fileName = fileName;
		_resultCallBack = resultCallBack;

		_loader = new URLLoader();
		_loader.dataFormat = URLLoaderDataFormat.BINARY; 
		_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		_loader.addEventListener(Event.COMPLETE, onComplete);
		_loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
	}

	public function get fileName():String
	{
		return _fileName;
	}

	public function get progress():Number
	{
		if (_state == States.LOADING)
			return _loader.bytesLoaded / _loader.bytesTotal;
		else if (_state == States.COMPLETE)
			return 1;
		return 0;
	}

	public function get loadedContent():*
	{
		if (_state == States.COMPLETE)
			return _data;
		return null;
	}

	public function load():void
	{
		//Log.info("... loading: " + _fileName);
		_loader.load(new URLRequest(_fileName));
	}

	private function onIOError(e:Event):void
	{
		_state = States.ERROR;
		Log.error("can't load resource: " + _fileName);
		dispatchEvent(new LoaderEvent(LoaderEvent.ERROR));
	}

	protected function extractData(bytes:ByteArray):void
	{
		onDataExtracted(bytes);
	}

	protected function onDataExtracted(data:Object):void
	{
		_data = data;

		if (_data)
		{
			_state = States.COMPLETE;
			if (_resultCallBack != null)
			{
				_resultCallBack(_data);
				_resultCallBack = null;
			}
			dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE));
		}
		else
		{
			_state = States.ERROR;
			Log.error("can't extract resource: " + _fileName);
			dispatchEvent(new LoaderEvent(LoaderEvent.ERROR));
		}
	}

	private function onComplete(e:Event):void
	{
		Log.info("... loaded: " + _fileName);
		extractData(_loader.data);
	}

	private function onProgress(e:Event):void
	{
		dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS));
	}
}
}