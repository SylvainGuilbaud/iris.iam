Class APP.msg.count Extends Ens.Request
{

Property tablename As %String [ InitialExpression = "patient" ];

Storage Default
{
<Data name="countDefaultData">
<Subscript>"count"</Subscript>
<Value name="1">
<Value>tablename</Value>
</Value>
</Data>
<DefaultData>countDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
