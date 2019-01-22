package net.maygem.cqrs.event.system
{
import net.maygem.cqrs.event.BaseExceptionEvent;

public class RemoteObjectExceptionEvent extends BaseExceptionEvent
{
    public function RemoteObjectExceptionEvent(message:String)
    {
        super(message);
    }
}
}