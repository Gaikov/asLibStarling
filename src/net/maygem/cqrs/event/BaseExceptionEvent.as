package net.maygem.cqrs.event
{
import net.maygem.cqrs.domain.event.BaseEvent;

public class BaseExceptionEvent implements BaseEvent
{
    public var message:String;

    function BaseExceptionEvent(message:String)
    {
        this.message = message;
    }
}
}