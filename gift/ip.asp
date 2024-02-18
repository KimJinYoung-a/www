<%
'###########################################################
' Description :  기프트
' History : 2015.01.26 한용민 생성
'###########################################################

Dim conIp, arrIp, tmpIp
conIp = Request.ServerVariables("REMOTE_ADDR")
arrIp = split(conIp,".")
tmpIp = Num2Str(arrIp(0),3,"0","R") & Num2Str(arrIp(1),3,"0","R") & Num2Str(arrIp(2),3,"0","R") & Num2Str(arrIp(3),3,"0","R")
response.write tmpIp
response.end
%>
