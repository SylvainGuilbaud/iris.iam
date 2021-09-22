Class APP.msg.detailPatientsResponse Extends Ens.Response
{

Property patients As array Of APP.struct.patient;

Storage Default
{
<Data name="patients">
<Attribute>patients</Attribute>
<Structure>subnode</Structure>
<Subscript>"APP.msg.detailPatientsResponse.patients"</Subscript>
</Data>
<Type>%Storage.Persistent</Type>
}

}
