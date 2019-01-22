package net.maygem.cqrs.event.system
{
import net.maygem.cqrs.domain.event.BaseEvent;

[RemoteClass(alias="net.maygem.common.event.system.EventsTokenEvent")]
public class EventsTokenEvent implements BaseEvent
{
    public var token:Number;

    public function EventsTokenEvent()
    {
    }
}
}