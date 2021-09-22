Class APP.operation.archivage Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Property ARCHIVAGE As %String [ InitialExpression = "APP" ];

Parameter SETTINGS = "ARCHIVAGE:app";

Method HL7(pRequest As EnsLib.HL7.Message, Output pResponse As Ens.StringResponse) As %Status
{
	set sc = $$$OK
	
	try{
        if pRequest.DocType '= "" {
            set trace={}
            set trace.DocType=(pRequest.DocType)
            $$$TRACE(trace.%ToJSON())
            set pResponse = ##class(Ens.StringResponse).%New()
            set IPP=pRequest.GetValueAt("PIDgrp.PID:PatientIDExternalID.ID")
            set trace.IPP=(IPP)
            $$$TRACE(trace.%ToJSON())
            set patient=$CLASSMETHOD("APP.data.patient","getPatient",IPP)
            set patient.lastName=pRequest.GetValueAt("PIDgrp.PID:PatientName.familyName")
            set trace.lastName=(patient.lastName)
            $$$TRACE(trace.%ToJSON())
            set patient.firstName=pRequest.GetValueAt("PIDgrp.PID:PatientName.givenName")
            set trace.firstName=(patient.firstName)
            $$$TRACE(trace.%ToJSON())
            // add the full HL7 message in patient HL7 messages array
            do patient.HL7.SetAt(pRequest.%ConstructClone(),patient.HL7.Count()+1)
            set sc=patient.%Save()
            if sc {
                set trace.status=(sc)
                set pResponse.StringValue = "successfully inserted in "_..ARCHIVAGE_" data:"_trace.%ToJSON()
                $$$LOGINFO(pResponse.StringValue)
            } else {
                set pResponse.StringValue = "ERROR WHILE INSERTING in "_..ARCHIVAGE_" ("_$system.Status.GetErrorText(sc)_" data:"_trace.%ToJSON()_")"
                $$$LOGWARNING(pResponse.StringValue)
            }
        } else {
            set pResponse.StringValue = "NO DOCTYPE DEFINED"
        }
	}
	catch exp
	{
		set sc = exp.AsStatus()
	}
	return sc
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="EnsLib.HL7.Message"> 
		<Method>HL7</Method>
	</MapItem>
</MapItems>
}

}
