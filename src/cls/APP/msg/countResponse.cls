Class APP.msg.countResponse Extends Ens.Response
{

Property nb As %Integer;

Storage Default
{
<Data name="countResponseDefaultData">
<Subscript>"countResponse"</Subscript>
<Value name="1">
<Value>nb</Value>
</Value>
</Data>
<DefaultData>countResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
