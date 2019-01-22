package net.maygem.cqrs.domain.eventbus {
import net.maygem.cqrs.domain.event.BaseEvent;

public interface IEventBus
{
    function addEventListener(eventClass:Class, listener:Function):ListenerRegistration;

    function dispatchEvent(event:BaseEvent):void;
}
}