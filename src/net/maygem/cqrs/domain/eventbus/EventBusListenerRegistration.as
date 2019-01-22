package net.maygem.cqrs.domain.eventbus {

internal class EventBusListenerRegistration implements ListenerRegistration
{
    private var removeListenerFunction:Function;

    public function EventBusListenerRegistration(removeListenerFunction:Function)
    {
        this.removeListenerFunction = removeListenerFunction;
    }

    public function removeListener():void
    {
        removeListenerFunction();
    }
}
}