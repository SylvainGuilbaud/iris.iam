Class APP.struct.patient Extends (%SerialObject, %XML.Adaptor)
{

Property IPP As %String;

Property firstName As %String;

Property lastName As %String;

Property HL7 As array Of %String(MAXLEN = "");

Storage Default
{
<Data name="patientState">
<Value name="1">
<Value>IPP</Value>
</Value>
<Value name="2">
<Value>firstName</Value>
</Value>
<Value name="3">
<Value>lastName</Value>
</Value>
<Value name="4">
<Value>HL7</Value>
</Value>
</Data>
<State>patientState</State>
<StreamLocation>^APP.struct.patientS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
