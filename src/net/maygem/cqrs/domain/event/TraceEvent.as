package net.maygem.cqrs.domain.event
{
public class TraceEvent implements BaseEvent
{
	private var _message:String;
	private var _color:uint;
	private var _object:Object;

	public function TraceEvent(msg:String, color:uint, object:Object)
	{
		super();
		_message = msg;
		_color = color;
		_object = object;
	}

	public function get message():String
	{
		return _message;
	}

	public function get color():uint
	{
		return _color;
	}

	public function get object():Object
	{
		return _object;
	}
}
}