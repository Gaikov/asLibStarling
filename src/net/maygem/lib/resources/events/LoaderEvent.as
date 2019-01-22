package net.maygem.lib.resources.events
{
import flash.events.Event;

public class LoaderEvent extends Event
{
	static public const ERROR:        String = "loadError";
	static public const PROGRESS:     String = "loadProgress";
	static public const COMPLETE:     String = "loadComplete";

	public function LoaderEvent( type:String )
	{
		super( type );
	}

	override public function clone():Event
	{
		return new LoaderEvent( type );
	}
}
}