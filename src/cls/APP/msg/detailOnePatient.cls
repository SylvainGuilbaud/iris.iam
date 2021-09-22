Class APP.msg.detailOnePatient Extends Ens.Request
{

Property IPP As %String;

Property retrieveHL7Messages As %Boolean [ InitialExpression = 1 ];

Storage Default
{
<Data name="detailOnePatientDefaultData">
<Subscript>"detailOnePatient"</Subscript>
<Value name="1">
<Value>IPP</Value>
</Value>
<Value name="2">
<Value>retrieveHL7Messages</Value>
</Value>
</Data>
<DefaultData>detailOnePatientDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
