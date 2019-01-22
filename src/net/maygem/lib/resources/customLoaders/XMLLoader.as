package net.maygem.lib.resources.customLoaders
{
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLLoader;

import flash.net.URLRequest;

import flash.events.EventDispatcher;

import net.maygem.lib.debug.Log;
import net.maygem.lib.resources.events.LoaderEvent;

public class XMLLoader extends EventDispatcher implements ILoader
{
	private var _fileName:          String;
	private var _resultCallBack:    Function;
	private var _loader:            URLLoader = new URLLoader();
	private var _state:             int = States.NONE;

	public function XMLLoader(fileName:String, resultCallBack:Function)
	{
		super();

		_fileName = fileName;
		_resultCallBack = resultCallBack;

		_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		_loader.addEventListener(Event.COMPLETE, onComplete);
		_loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
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
			return _loader.data;
		return null;
	}

	public function load():void
	{
		//Log.info("... loading: " + _fileName);
		_loader.load(new URLRequest(_fileName));
		_state = States.LOADING;
	}

	private function onIOError(e:Event):void
	{
		_state = States.ERROR;
		Log.error("can't load resource: " + _fileName);
		_resultCallBack(null);
		dispatchEvent(new LoaderEvent(LoaderEvent.ERROR));
	}

	private function onComplete(e:Event):void
	{
		_state = States.COMPLETE;
		Log.info("... loaded: " + _fileName);
		_resultCallBack(_loader.data);
		dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE));
	}

	private function onProgress(e:Event):void
	{
		dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS));
	}
}
}