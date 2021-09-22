Class APP.operation.database Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Property SCHEMA As %String [ InitialExpression = "APP_data" ];

Parameter SETTINGS = "SCHEMA:app";

Method nb(pRequest As APP.msg.count, Output pResponse As APP.msg.countResponse) As %Status
{
	
	set sc = $$$OK
	
	try{
		set pResponse = ##class(APP.msg.countResponse).%New()
		set query = "",hasNext=""
		set query = query_"SELECT count(*) as nb FROM "_ ..SCHEMA_"."_pRequest.tablename

		$$$TRACE(query)

		$$$ThrowOnError(..Adapter.ExecuteQuery(.rs,query))

		if rs.%Next() {
			set nb = rs.%Get("nb")
			$$$LOGINFO("nb:" _ nb)
		} else {
			$$$LOGINFO("NO DATA FOUND FOR "_ ..SCHEMA_"."_pRequest.tablename)
		}
		
		set pResponse.nb = nb
	}
	catch exp
	{
		set sc = exp.AsStatus()
	}
	return sc
}

Method detailPatients(pRequest As APP.msg.detailPatients, Output pResponse As APP.msg.detailPatientsResponse) As %Status
{
	
	set sc = $$$OK
	
	try{
		set pResponse = ##class(APP.msg.detailPatientsResponse).%New()
		set query = "",hasNext=""
		set query = query_"SELECT id FROM "_ ..SCHEMA_".patient ORDER BY id"

		$$$TRACE(query)

		$$$ThrowOnError(..Adapter.ExecuteQuery(.rs,query))

		while rs.%Next() {
			set id = rs.%Get("id")
			$$$LOGINFO("id:" _ id)
			set patient = ##class(APP.data.patient).%OpenId(id)
			set p = ##class(APP.struct.patient).%New()
			set p.IPP = patient.IPP
			set p.lastName = patient.lastName
			set p.firstName = patient.firstName
			if pRequest.retrieveHL7Messages {
				for i = 1:1:patient.HL7.Count() {
					do p.HL7.SetAt(patient.HL7.GetAt(i).RawContent,p.HL7.Count()+1)
				}
			}
			do pResponse.patients.SetAt(p,pResponse.patients.Count()+1)
		} 		
	}
	catch exp
	{
		set sc = exp.AsStatus()
	}
	return sc
}

Method detailOnePatient(pRequest As APP.msg.detailOnePatient, Output pResponse As APP.msg.detailOnePatientResponse) As %Status
{
	
	set sc = $$$OK
	
	try{
		set pResponse = ##class(APP.msg.detailOnePatientResponse).%New()
		set query = "",hasNext=""
		set query = query_"SELECT id FROM "_ ..SCHEMA_".patient WHERE IPP = ?"

		$$$TRACE(query)

		$$$ThrowOnError(..Adapter.ExecuteQuery(.rs,query,pRequest.IPP))

		if rs.%Next() {
			set id = rs.%Get("id")
			$$$LOGINFO("id:" _ id)
			set patient = ##class(APP.data.patient).%OpenId(id)
			set p = ##class(APP.struct.patient).%New()
			set p.IPP = patient.IPP
			set p.lastName = patient.lastName
			set p.firstName = patient.firstName
			if pRequest.retrieveHL7Messages {
				for i = 1:1:patient.HL7.Count() {
					do p.HL7.SetAt(patient.HL7.GetAt(i).RawContent,p.HL7.Count()+1)
				}
			}
			set pResponse.patient = p
		} else {
			$$$LOGINFO("NO DATA FOUND FOR IPP:"_pRequest.IPP)
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
	<MapItem MessageType="APP.msg.count"> 
		<Method>nb</Method>
	</MapItem>
	<MapItem MessageType="APP.msg.detailPatients"> 
		<Method>detailPatients</Method>
	</MapItem>
	<MapItem MessageType="APP.msg.detailOnePatient"> 
		<Method>detailOnePatient</Method>
	</MapItem>
</MapItems>
}

}
