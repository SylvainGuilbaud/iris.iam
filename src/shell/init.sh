#!/bin/bash

iris session $ISC_PACKAGE_INSTANCENAME -U %SYS << END
write ##class(Security.Users).UnExpireUserPasswords("*")
do \$SYSTEM.OBJ.Load("/src/cls/init/install.cls", "ck") 
set sc = ##class(init.install).init() 
zn "app"
write ##class(Ens.Director).SetAutoStart("APP.production")
write ##class(Ens.Director).StartProduction("APP.production")
write ##class(Ens.Config.Credentials).SetCredential("IRIS","_system","SYS",1)
do \$SYSTEM.OBJ.LoadDir("/src/cls/Sample", "ck",,1) 
do ##class(Sample.Person).AddTestData()
halt
END
exit=$?