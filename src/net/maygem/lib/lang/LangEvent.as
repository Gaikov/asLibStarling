package net.maygem.lib.lang
{
import flash.events.Event;

public class LangEvent extends Event
{
	//constants
	static public const LOAD_LIST_COMPLETE:String = "listLoadComplete";
	static public const LOAD_LIST_ERROR:String = "listLoadError";
	static public const LOAD_LANG_ERROR:String = "langLoadError";

	//constructor
	public function LangEvent(type:String)
	{
		super(type);
	}

	//methods
	public override function clone():Event
	{
		return new LangEvent(this.type);
	}
}
}