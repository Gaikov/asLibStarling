package net.maygem.lib.lang
{
import flash.events.*;

import mx.resources.*;

import net.maygem.lib.debug.Log;
import net.maygem.lib.resources.ResourceLoader;

public class LangLoader extends EventDispatcher
{
	private var _langList:Array = new Array();
	private var _langToApply:String;
	private var _currentLang:String;
	private var _langSource:String = "";

	static private var _inst:LangLoader;

    public function LangLoader()
    {
    }

    [Bindable(event="listLoadComplete")]
	public function get LocaleList():Array
	{
		var list:Array = new Array();
		for (var i:uint = 0; i < _langList.length; i++)
		{
			var item:LangDesc = _langList[i];
			list.push({ label:item._label, id:item._id });
		}
		return list;
	}

	public function get currentLang():String
	{
		return _currentLang;
	}

	// methods
	static public function instance():LangLoader
	{
		if (!_inst)
			_inst = new LangLoader;
		return _inst;
	}

	public function load(url:String):void
	{
		_langSource = url;
		Log.info("... prepare languages");

		ResourceLoader.instance().loadXML(_langSource, onListComplete);
	}

	public function applyLang(langID:String):void
	{
		if (_langToApply && _langToApply == langID)
			return;

		var i:int = getLangIndex(langID);
		if (i < 0)
		{
			Log.warning("lang not found: " + langID);
		}
		else
		{
			var item:LangDesc = _langList[i];
			if (item.content)
				ResourceManager.getInstance().localeChain = [langID];
			else
				_langToApply = langID;
		}
	}

	private function onListComplete(data:*):void
	{
		if (data != null)
		{
			var xml:XML = new XML(data);
			var count:int = 0;

			for each(var lang:XML in xml.lang)
			{
				var src:String = lang.@src;
				addLang(lang.@id, lang.@name, src);
				count ++;
			}

			if (!count)
			{
				Log.error("invalid languages list format!");
				dispatchEvent(new LangEvent(LangEvent.LOAD_LIST_ERROR));
			}
			else
			{
				Log.info(count + " - languages parsed");
				applyLang(_langList[0]._id);
				dispatchEvent(new LangEvent(LangEvent.LOAD_LIST_COMPLETE));
			}
		}
		else
			dispatchEvent(new LangEvent(LangEvent.LOAD_LIST_ERROR));
	}


	private function addLang(id:String, name:String, src:String):void
	{
		var desc:LangDesc = new LangDesc(id, name, src);
		desc.addEventListener(LangDesc.EVENT_COMPLETE, onLocalLoad);
		desc.addEventListener(LangDesc.EVENT_ERROR, onLocalError);
		_langList.push(desc);
		desc.load();
	}

	private function onLocalLoad(e:Event):void
	{
		var desc:LangDesc = e.target as LangDesc;
		ResourceManager.getInstance().addResourceBundle(desc.content);

		if (_langToApply && _langToApply == desc._id)
		{
			ResourceManager.getInstance().localeChain = [_langToApply];
			ResourceManager.getInstance().update();
			_currentLang = _langToApply;
			_langToApply = null;
			dispatchEvent(new Event("localeChange"));
		}
	}

	private function onLocalError(e:Event):void
	{
		var lang:LangDesc = e.target as LangDesc;
		var index:int = getLangIndex(lang._id);
		_langList.splice(index, 1);
		if (lang._id == _langToApply && _langList.length)
			applyLang(_langList[0]._id);

		dispatchEvent(new LangEvent(LangEvent.LOAD_LANG_ERROR));
	}

	private function getLangIndex(langID:String):int
	{
		for (var i:int = 0; i < _langList.length; i++)
		{
			var item:LangDesc = _langList[i];
			if (item._id == langID)
				return i;
		}
		return -1;
	}
}
}

import flash.events.Event;
import flash.events.EventDispatcher;

import mx.resources.ResourceBundle;

import net.maygem.lib.debug.Log;
import net.maygem.lib.resources.ResourceLoader;

class LangDesc extends EventDispatcher
{
	static public const EVENT_COMPLETE:String = "langDescComplete";
	static public const EVENT_ERROR:String = "langDescError";

	public var _id:String;
	public var _label:String;
	public var _src:String;
	public var _bundle:ResourceBundle;

	public function LangDesc(id:String, label:String, src:String)
	{
		_id = id;
		_label = label;
		_src = src;
	}

	public function get content():ResourceBundle
	{
		return _bundle;
	}

	public function load():void
	{
		ResourceLoader.instance().loadXML(_src, onLoad);
	}

	private function onLoad(data:*):void
	{
		if (data)
		{
			Log.info("parsing lang: " + _src);

			var xml:XML = new XML(data);

			_bundle = new ResourceBundle(_id);
			for each(var str:XML in xml.string)
				_bundle.content[str.@id] = str;

			dispatchEvent(new Event(EVENT_COMPLETE));
		}
		else
			dispatchEvent(new Event(EVENT_ERROR));
	}
}