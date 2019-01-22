package net.maygem.cqrs.event.system
{
import net.maygem.cqrs.event.BaseExceptionEvent;

[RemoteClass(alias="net.subjectivity.cqrs.event.system.CommandHandlerExceptionEvent")]
public class CommandHandlerExceptionEvent extends BaseExceptionEvent
{
    public function CommandHandlerExceptionEvent(message:String = null)
    {
        super(message);
    }
}
}
