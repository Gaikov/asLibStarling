package net.maygem.cqrs.domain.common
{
[RemoteClass(alias="net.subjectivity.cqrs.common.domain.VersionedId")]
public class VersionedId
{
    public var entityId:EntityId;
    public var version:Number;

    public function VersionedId()
    {
    }
}
}