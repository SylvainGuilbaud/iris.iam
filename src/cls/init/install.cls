Class init.install
{

XData install [ XMLNamespace = INSTALLER ]
{
<Manifest>
  <Var Name="DBDIR" Value="/databases/"/>
  
  <Var Name="NAMESPACE" Value="APP"/>
  <Var Name="DBCODE" Value="${NAMESPACE}-CODE"/>
  <Var Name="DBDATA" Value="${NAMESPACE}-DATA"/>
  <Var Name="APPPATH" Dir="${DBDIR}${NAMESPACE}/" />
  <Var Name="RESOURCECODE" Value="%DB_${DBCODE}" /> 
  <Var Name="RESOURCEDATA" Value="%DB_${DBDATA}" /> 
  <Log Level="3" Text="NAMESPACE = ${NAMESPACE}"/>
  <Namespace Name="${NAMESPACE}" Code="${DBCODE}" Data="${DBDATA}" Create="yes" Ensemble="1">
    <Configuration>
      <Database Name="${DBCODE}" Dir="${APPPATH}${DBCODE}" Create="yes" Resource="${RESOURCECODE}"/>
      <Database Name="${DBDATA}" Dir="${APPPATH}${DBDATA}" Create="yes" Resource="${RESOURCEDATA}"/>
    </Configuration>
    <Import File="/src/cls/${NAMESPACE}" Recurse="1"/>

  </Namespace>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "install")
}

ClassMethod init() As %Status
{
  set sc = $$$OK
  set sc = ..setup()
  set $namespace = "APP"
  // Enable analytics for the APP namespace.
  set app = $System.CSP.GetDefaultApp($namespace) _ "/"
  do EnableDeepSee^%SYS.cspServer(app)
  return sc
}

}
