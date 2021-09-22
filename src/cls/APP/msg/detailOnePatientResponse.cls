Class APP.msg.detailOnePatientResponse Extends Ens.Response
{

Property patient As APP.struct.patient;

Storage Default
{
<Data name="detailOnePatientResponseDefaultData">
<Subscript>"detailOnePatientResponse"</Subscript>
<Value name="1">
<Value>patient</Value>
</Value>
</Data>
<DefaultData>detailOnePatientResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
