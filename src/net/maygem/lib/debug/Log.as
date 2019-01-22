package net.maygem.lib.debug
{
import starling.display.Stage;

public class Log
{
	// constants
	static private var _con:Console = new Console;

	static public function attachToStage(stage:Stage):void
	{
		_con.attachToStage(stage);
	}

	static public function isConsoleActive():Boolean
	{
		return _con.visible;
	}

	static public function allowConsole(allow:Boolean):void
	{
		_con.allowed = allow;
	}

	static public function print(text:String, color:uint = 0xffffff):void
	{
		_con.trace(text, color);
		trace(text);
	}

	static public function info(...params:Array):void
	{
		print(params.join(""));
	}

	static public function warning(...params:Array):void
	{
		print("WARNING: " + params.join(""), 0xffff00);
	}

	static public function error(...params:Array):void
	{
		print("ERROR: " + params.join(""), 0xff0000);
	}

	static public function critical(text:String):void
	{
		text = "CRITICAL ERROR: " + text;
		print(text, 0xff0000);
		throw new Error(text);
	}

	static public function traceObject(color:uint, obj:*, indent:int = 0):void
	{
		var indentString:String = "";
		var i:uint;
		var prop:String;
		var val:*;

		for (i = 0; i < indent; i++)
		{
			indentString += "\t";
		}

		for (prop in obj)
		{
			val = obj[prop];
			if (typeof(val) == "object")
			{
				print(indentString + " " + val + ": [Object]", color);
				traceObject(color, val, indent + 1);
			}
			else
			{
				print(indentString + " " + prop + ": " + val, color);
			}
		}
	}
}
}