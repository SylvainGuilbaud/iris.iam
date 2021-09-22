Class APP.msg.detailPatients Extends Ens.Request
{

Property retrieveHL7Messages As %Boolean [ InitialExpression = 1 ];

Storage Default
{
<Data name="detailPatientsDefaultData">
<Subscript>"detailPatients"</Subscript>
<Value name="1">
<Value>retrieveHL7Messages</Value>
</Value>
</Data>
<DefaultData>detailPatientsDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
