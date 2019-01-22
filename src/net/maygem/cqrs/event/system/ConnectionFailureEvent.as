package net.maygem.cqrs.event.system
{
import net.maygem.cqrs.event.BaseExceptionEvent;

public class ConnectionFailureEvent extends BaseExceptionEvent
{
    public function ConnectionFailureEvent(message:String)
    {
        super(message);
    }
}
}
