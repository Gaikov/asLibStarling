/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 18.09.12
 */
package com.grom.localization
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;

public class LangManager
{
	private static var _instance:LangManager;

	private var _langsMap:Object = {};
	private var _currentLang:String = "en";

	public function LangManager()
	{
	}

	public static function get instance():LangManager
	{
		if (!_instance)
		{
			_instance = new LangManager();
		}
		return _instance;
	}

	public function get currentLang():String
	{
		return _currentLang;
	}

	public function set currentLang(value:String):void
	{
		_currentLang = value;
	}

	public function registerLang(id:String, map:Object):void
	{
		_langsMap[id] = map;
	}

	public function translateContainer(c:DisplayObjectContainer, fontName:String = null, fieldOffset:Point = null):void
	{
		if (!getCurrentMap()) return;

		for (var i:int = 0; i < c.numChildren; i++)
		{
			var child:DisplayObject = c.getChildAt(i);
			if (child is TextField)
			{
				translateField(TextField(child), fontName, fieldOffset);
			}
			else if (child is DisplayObjectContainer)
			{
				translateContainer(DisplayObjectContainer(child), fontName);
			}
		}
	}

	private function translateField(field:TextField, font:String, fieldOffset:Point):void
	{
		var map:Object = getCurrentMap();
		var id:String = field.text.replace("\r", "").replace("\n", "");
		var str:String = map[id];
		if (str)
		{
			field.text = str;
			field.mouseEnabled = false;
			if (font)
			{
				var tf:TextFormat = field.defaultTextFormat;
				tf.font = font;
				field.setTextFormat(tf);
			}

			if (fieldOffset)
			{
				field.x += fieldOffset.x;
				field.y += fieldOffset.y;
			}
		}
	}

	private function getCurrentMap():Object
	{
		var map:Object = _langsMap[_currentLang];
		if (!map)
		{
			map = _langsMap["en"];
		}
		return map;
	}


}
}
