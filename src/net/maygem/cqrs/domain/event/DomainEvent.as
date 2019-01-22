package net.maygem.cqrs.domain.event
{
import net.maygem.cqrs.domain.common.VersionedId;

public class DomainEvent implements BaseEvent
{
    public var aggregateRootId:VersionedId;

    function DomainEvent()
    {
    }
}
}