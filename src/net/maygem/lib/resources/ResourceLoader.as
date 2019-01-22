package net.maygem.lib.resources
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;

import net.maygem.lib.debug.Log;
import net.maygem.lib.resources.customLoaders.BitmapLoader;
import net.maygem.lib.resources.customLoaders.ClassLoader;
import net.maygem.lib.resources.customLoaders.LoadMarker;
import net.maygem.lib.resources.customLoaders.XMLLoader;
import net.maygem.lib.resources.events.LoaderEvent;

public class ResourceLoader extends EventDispatcher
{
	static public const EVENT_START:String = "resourcesStart";
	static public const EVENT_PROGRESS:String = "resourcesProgress";
	static public const EVENT_ERROR:String = "resourcesError";
	static public const EVENT_COMPLETE:String = "resourcesComplete";

	private static var _inst:ResourceLoader;

	private var _loadChain:Array = [];
	private var _loadedClasses:Object = {};
	private var _currentLoader:ClassLoaderWrapper;
	private var _loadedCount:int = 0;
	private var _root:String = "assets/";

	public function ResourceLoader()
	{
	}

	static public function instance():ResourceLoader
	{
		if (!_inst)
			_inst = new ResourceLoader();
		return _inst;
	}

	public function set root(value:String):void
	{
		_root = value;
	}

	public function get root():String
	{
		return _root;
	}

	public function get progress():Number
	{
		var total:int = _loadedCount + _loadChain.length;
		if (total)
		{
			var res:Number;
			if (_currentLoader)
			{
				total += 1;
				res = _loadedCount / total;
				res += _currentLoader._loader.progress / total;
			}
			else
				res = _loadedCount / total;

			return res;
		}
		return 0;
	}

	public function loadXML(fileName:String, onResultCallback:Function):void
	{
		var loader:XMLLoader = new XMLLoader(_root + fileName, onResultCallback);
		addToChain(new ClassLoaderWrapper(loader));
	}

	public function loadDisplayClass(fileName:String, className:String, classID:String = null, onResultCallback:Function = null):void
	{
		var loader:ClassLoader = new ClassLoader(_root + fileName, className, onResultCallback);
		addToChain(new ClassLoaderWrapper(loader, classID));
	}

	public function loadBitmap(fileName : String, classID:String = null, onResultCallback: Function = null) : void
	{
		var loader:BitmapLoader = new BitmapLoader(_root + fileName, onResultCallback);
		addToChain(new ClassLoaderWrapper(loader, classID));
	}

	public function addMarker(callback:Function):void
	{
		addToChain(new ClassLoaderWrapper(new LoadMarker(callback)));
	}

	public function getDisplayClass(classID:String):Class
	{
		var cls:Class = _loadedClasses[classID] as Class;
		if (!cls)
		{
			Log.warning(classID + "- display CLASS not found!");
			return null;
		}
		return cls;
	}

	public function createDisplayObject(classID:String):DisplayObject
	{
		var cls:Class = getDisplayClass(classID);
		return cls ? new cls() : new Sprite();
	}

	private function addToChain(loader:ClassLoaderWrapper):void
	{
		_loadChain.push(loader);
		if (!_currentLoader)
		{
			loadNext();
			dispatchEvent(new Event(EVENT_START));
		}
	}

	private function loadNext():Boolean
	{
		if (_currentLoader)
		{
			removeCurrentListeners();
			_currentLoader = null;
		}

		if (!_loadChain.length)
			return false;

		var lw:ClassLoaderWrapper = ClassLoaderWrapper(_loadChain.shift());
		_currentLoader = lw;
		lw._loader.addEventListener(LoaderEvent.COMPLETE, onComplete);
		lw._loader.addEventListener(LoaderEvent.ERROR, onError);
		lw._loader.addEventListener(LoaderEvent.PROGRESS, onProgress);
		lw._loader.load();

		return true;
	}

	private function removeCurrentListeners():void
	{
		_currentLoader._loader.removeEventListener(LoaderEvent.COMPLETE, onComplete);
		_currentLoader._loader.removeEventListener(LoaderEvent.ERROR, onError);
		_currentLoader._loader.removeEventListener(LoaderEvent.PROGRESS, onProgress);
	}

	private function onError(e:Event):void
	{
		dispatchEvent(new Event(EVENT_ERROR));
		if (!loadNext())
			dispatchEvent(new Event(EVENT_COMPLETE));
	}

	private function onComplete(e:Event):void
	{
		if (_currentLoader._classID)
			_loadedClasses[ _currentLoader._classID ] = _currentLoader._loader.loadedContent;
		_loadedCount ++;
		if (!loadNext())
			dispatchEvent(new Event(EVENT_COMPLETE));
	}

	private function onProgress(e:Event):void
	{
		dispatchEvent(new Event(EVENT_PROGRESS));
	}
}
}

import net.maygem.lib.resources.customLoaders.ILoader;

class ClassLoaderWrapper
{
	public var _loader:ILoader;
	public var _classID:String;

	function ClassLoaderWrapper(loader:ILoader, classID:String = null)
	{
		_loader = loader;
		_classID = classID;
	}
}
