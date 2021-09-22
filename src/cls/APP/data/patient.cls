Class APP.data.patient Extends %Persistent
{

Property IPP As %String;

Property firstName As %String;

Property lastName As %String;

Property HL7 As array Of EnsLib.HL7.Message;

Index IPPIdx On IPP [ Unique ];

ClassMethod getPatient(IPP As %String, ByRef sc As %Status) As APP.data.patient
{
    set patient=..%New(),sc=$$$OK
    set sql($i(sql))="SELECT"
    set sql($i(sql))="ID"
    set sql($i(sql))="FROM APP_data.patient"
    set sql($i(sql))="WHERE IPP=?"
    set result=##class(%SQL.Statement).%ExecDirect(,.sql,IPP)
    if result.%SQLCODE = 0 {
        do result.%Next() 
        if result.%SQLCODE = 0 {
            set ID = result.%Get("ID")
            if ..%ExistsId(ID) {
                set patient = ..%OpenId(ID)
            } else {
                set sc=$system.Status.Error(5001,"No patient exists for IPP="_IPP_" with ID:"_ID)
            }
        } else {
            set sc=$system.Status.Error(5001,"No patient found for IPP="_IPP_" (SQLCODE:"_result.%SQLCODE_")")
        }
    } else {
            set sc=$system.Status.Error(5001,"ERROR WHILE SEARCHING patient for IPP="_IPP_" (SQLCODE:"_result.%SQLCODE_")")
    }
    set patient.IPP = IPP
    return patient
}

Storage Default
{
<Data name="HL7">
<Attribute>HL7</Attribute>
<Structure>subnode</Structure>
<Subscript>"HL7"</Subscript>
</Data>
<Data name="patientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IPP</Value>
</Value>
<Value name="3">
<Value>firstName</Value>
</Value>
<Value name="4">
<Value>lastName</Value>
</Value>
</Data>
<DataLocation>^APP.data.patientD</DataLocation>
<DefaultData>patientDefaultData</DefaultData>
<IdLocation>^APP.data.patientD</IdLocation>
<IndexLocation>^APP.data.patientI</IndexLocation>
<StreamLocation>^APP.data.patientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
