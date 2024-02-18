<%
''INIWEB test 임시
Function getINIJson2NVP(istrData)
    dim ret
    ret = istrData
    ret = replace(ret,vbCRLF,"")
    ret = replace(ret,vbCR,"")
    ret = replace(ret,vbLF,"")
    ret = replace(ret," ","")
    
    ''ret = replace(ret,""": """,""":""")
    ''ret = replace(ret,""",  """,""",""")
    ''ret = replace(ret,""", """,""",""")
    
    ret = replace(ret,""":""","=")
    ret = replace(ret,""",""","&")
    ret = replace(ret,"""","")
    ret = replace(ret,"{","")
    ret = replace(ret,"}","")

    ret = replace(ret,"\""","")
     
    getINIJson2NVP = ret
end Function

'//바이너리 데이터 TEXT형태로 변환
Function  BinaryToText(BinaryData, CharSet)
	 Const adTypeText = 2
	 Const adTypeBinary = 1

	 Dim BinaryStream
	 Set BinaryStream = CreateObject("ADODB.Stream")

	'원본 데이터 타입
	 BinaryStream.Type = adTypeBinary

	 BinaryStream.Open
	 BinaryStream.Write BinaryData
	 ' binary -> text
	 BinaryStream.Position = 0
	 BinaryStream.Type = adTypeText

	' 변환할 데이터 캐릭터셋
	 BinaryStream.CharSet = CharSet

	'변환한 데이터 반환
	 BinaryToText = BinaryStream.ReadText

	 Set BinaryStream = Nothing
End Function

function fnHashSHA256(iVal)
    dim Obj
    IF (application("Svr_Info")	= "Dev") Then
        Set Obj = Server.CreateObject("TenCrypto.Crypto")  '' 2018/08/02 개발환경 구성
        fnHashSHA256 = Obj.SHA256Hashing(iVal)
        set Obj = nothing
    ELSE
        Set Obj = Server.CreateObject("nonnoi_ASPEncrypt.ASPEncrypt")  ''object is faster then asp code
        Obj.RegisterName = "SEO SEOK"
        Obj.RegisterKey  = "63918C68A2D78AF7-5755"
        Obj.HashAlgorithm = 6 'sha256
        fnHashSHA256 = (Obj.HashString(iVal))
    END IF
    set Obj = nothing
end function

function getIniWebTimestamp()
    ''getIniWebTimestamp = Replace(Left(Now(),10),"-","") &hour(now())&minute(now())&second(now())  ''문제가 있음
    getIniWebTimestamp = DateDiff("s", "1970-01-01 09:00:00", now)*1000+clng(timer)  
end function

function getIniWebOID()
    getIniWebOID = Right(application("Svr_Info"),3) & Replace(Left(Now(),10),"-","") &hour(now())&minute(now())&second(now())& session.sessionid
end function

function getIniWebSignature(iordno,iprice,itimestamp)
    dim buf : buf = "oid=" & iordno & "&price=" & iprice & "&timestamp=" & itimestamp 
    getIniWebSignature = fnHashSHA256(buf)
end function

function getIniWebConfirmSignature(iauthToken,itimestamp)
    dim buf : buf = "authToken=" & iauthToken & "&timestamp=" & itimestamp 
    getIniWebConfirmSignature = fnHashSHA256(buf)
end function

Dim INIWEB_isSSL : INIWEB_isSSL = Request.ServerVariables("SERVER_PORT")="443"
Dim INIWEB_Domain
Dim INIWEB_Jscript

if (INIWEB_isSSL) then
    INIWEB_Domain = "https://www.10x10.co.kr"
    INIWEB_Jscript = "https://stdpay.inicis.com/stdjs/INIStdPay.js"
else
    INIWEB_Domain = "https://www.10x10.co.kr"
    INIWEB_Jscript = "https://stdpay.inicis.com/stdjs/INIStdPay.js"
end if

dim INIWEB_returnUrl : INIWEB_returnUrl = INIWEB_Domain&"/inipay/iniWeb/INIWeb_return.asp"
dim INIWEB_popupUrl : INIWEB_popupUrl = INIWEB_Domain&"/inipay/iniWeb/INIWeb_popup.asp"
dim INIWEB_closeUrl : INIWEB_closeUrl = INIWEB_Domain&"/inipay/iniWeb/INIWeb_close.asp"
dim INIWEB_RelayUrl : INIWEB_RelayUrl = INIWEB_Domain&"/inipay/iniWeb/INIWeb_Relay.asp"
dim INIWEB_ProcUrl : INIWEB_ProcUrl = INIWEB_Domain&"/inipay/INIWeb_Proc.asp"
dim INIWEB_ChangePayURL : INIWEB_ChangePayURL = INIWEB_Domain&"/my10x10/orderPopup/INIWebChangePay.asp"
dim INIWEB_signKey : INIWEB_signKey = "OU5MWGcyMEtkSTFoblI1ZHdWMktOZz09"  ''실서버 용(teenxteen4)
dim INIWEB_signKey6 : INIWEB_signKey6 = "RzZrNXhQQXMvUHhDMlh2UG5LdHJmdz09"  ''실서버 용(teenxteen6)
dim INIWEB_signKey8 : INIWEB_signKey8 = "RG1ydG1YZis2VUcrQXRRV1EzVUFpZz09"  ''실서버 용(teenxteen8)
dim INIWEB_signKeyH : INIWEB_signKeyH = "aXVRUlUvcmNtWXpaVFBhZk1aYjhTZz09"  ''실서버 용(teenxteeha)
dim INIWEB_signKey10 : INIWEB_signKey10 = "bUNBNFB5OXVJakpUaUtaRWIxZ1RnUT09"  ''실서버 용(teenteen10)
dim INIWEB_signKeyR : INIWEB_signKeyR = "eGUxbHQybWtsZkd2dmJFZmRGdVhMQT09"   ''실서버 용(teenxteenr), 이니렌탈용
dim INIWEB_signKeySP : INIWEB_signKeySP = "WUpmZUxWTnZDR0JMVWxFSElFeFhqdz09"   ''실서버 용(teenxteesp), 삼성페이

dim INIWEB_ProcUrl_BaguniTMP : INIWEB_ProcUrl_BaguniTMP = INIWEB_Domain&"/inipay/iniWeb/ordertemp_INIWebProc.asp"  ''2018/01/04추가

if (application("Svr_Info")="Dev") then
    INIWEB_returnUrl = "https://2015www.10x10.co.kr/inipay/iniWeb/INIWeb_return.asp"
    INIWEB_popupUrl = "https://2015www.10x10.co.kr/inipay/iniWeb/INIWeb_popup.asp"
    INIWEB_closeUrl = "https://2015www.10x10.co.kr/inipay/iniWeb/INIWeb_close.asp"
    INIWEB_RelayUrl = "https://2015www.10x10.co.kr/inipay/iniWeb/INIWeb_Relay.asp"
    INIWEB_ProcUrl = "https://2015www.10x10.co.kr/inipay/INIWeb_Proc.asp"
    INIWEB_ChangePayURL = "https://2015www.10x10.co.kr/my10x10/orderPopup/INIWebChangePay.asp"
    INIWEB_signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS" 
    INIWEB_signKey6 = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"
    INIWEB_signKey8 = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"
    INIWEB_signKeyH = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"
    INIWEB_signKey10 = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"
    INIWEB_signKeyR = "MjQrMEIvMzR4cCtpN3BHQXpDWXRLdz09"
    INIWEB_signKeySP = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"
    
    INIWEB_ProcUrl_BaguniTMP = "https://2015www.10x10.co.kr/inipay/iniWeb/ordertemp_INIWebProc.asp"  ''2018/01/04추가

    INIWEB_popupUrl = "/inipay/iniWeb/INIWeb_popup.asp"
end if

dim INIWEB_ver : INIWEB_ver="1.0"
dim INIWEB_timestamp : INIWEB_timestamp = getIniWebTimestamp()
dim INIWEB_oid : INIWEB_oid = getIniWebOID()

dim INIWEB_mKey : INIWEB_mKey = fnHashSHA256(INIWEB_signKey)
dim INIWEB_mKey6 : INIWEB_mKey6 = fnHashSHA256(INIWEB_signKey6)
dim INIWEB_mKey8 : INIWEB_mKey8 = fnHashSHA256(INIWEB_signKey8)
dim INIWEB_mKeyH : INIWEB_mKeyH = fnHashSHA256(INIWEB_signKeyH)
dim INIWEB_mKey10 : INIWEB_mKey10 = fnHashSHA256(INIWEB_signKey10)
dim INIWEB_mKeyR : INIWEB_mKeyR = fnHashSHA256(INIWEB_signKeyR)
dim INIWEB_mKeySP : INIWEB_mKeySP = fnHashSHA256(INIWEB_signKeySP)
%>