<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2011.01.12 허진원 생성
'	Description : QR코드 페이지 이동 및 로그처리
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp"-->
<!-- #include virtual="/lib/chkDevice.asp"-->
<!-- #include virtual="/lib/inc_const.asp"-->
<%
	dim qrSn, qrDiv, qrContent
	dim sqlStr, strCont
	qrSn = rdmSerialDec(Request("key"))

	if qrSn="" then
		Call Alert_move("비정상적인 접속입니다.","/")
		dbget.Close : Response.End
	end if

	'// QR정보 접수
	sqlStr = "select qrDiv, qrContent " + vbcrlf
	sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_QRCodeList " + vbcrlf
	sqlStr = sqlStr + " where isUsing='Y' and qrSn = '" + qrSn + "' "
	rsget.Open sqlStr,dbget,1

	if  not rsget.EOF  then
		qrDiv = rsget("qrDiv")
		qrContent = db2html(rsget("qrContent"))
	end if

	rsget.Close

	if qrDiv="" or qrContent="" then
		Call Alert_move("삭제되었거나 없는 키 값입니다.\n텐바이텐 사이트로 이동합니다.","/")
		dbget.Close : Response.End
	end if

	'// 카운트 및 로그저장
	sqlStr = "Update db_sitemaster.dbo.tbl_QRCodeList set qrHitCount=qrHitCount+1 Where qrSn='" & qrSn & "';" & vbCrLf &_
			"Insert into db_log.dbo.tbl_QRCodeLog (qrSn,refIP, DevDiv, BrowserInfo) values " &_
			" (" & qrSn & ",'" & request.ServerVariables("REMOTE_ADDR") & "','" & flgDevice & "','" & html2db(uAgent) & "');"
	dbget.Execute(sqlStr)
	
	'// 87941이벤트에서 들어왔을 때 기기가 안드로이드일경우 2018-07-24 
	If qrSn = 389 and flgDevice="A" Then
		Call Alert_move("PLAY는 현재 IOS 앱에서만\n지원되는 기능입니다.\nAndroid 올 하반기 중 오픈 예정","/")
		dbget.Close : Response.End
	End if	

	'// 해당 페이지로 이동
	Select Case qrDiv
		Case 1	'URL
			strCont = getConvertAppUrl(qrContent)
		Case 2	'TEXT
			strCont = chkIIF(flgDevice<>"W",mobileUrl,wwwUrl) & "/apps/QR/TextView.asp"
		Case 3	'이미지
			strCont = chkIIF(flgDevice<>"W",mobileUrl,wwwUrl) & "/apps/QR/ImgView.asp"
		Case 4	'동영상
			strCont = chkIIF(flgDevice<>"W",mobileUrl,wwwUrl) & "/apps/QR/MovView.asp"
		Case 5	'APP URL
			strCont = qrContent
	End Select

	response.Redirect strCont


	'// URL의 APP Path 확인 및 변환
	Function getConvertAppUrl(url)
		dim rpUrl, arrQL

		if isApp and inStr(Lcase(url),"10x10.co.kr")>0 then
			arrQL = Split(Lcase(url),"/")

			'URL 직접 링크 또는 특수 페이지는 ByPass
			if inStr(Lcase(url),"/apps/link/")>0 or inStr(Lcase(url),"/appdown/")>0 or inStr(Lcase(url),"/apps/appcom/wish/")>0 then
				getConvertAppUrl = url
				exit function
			end if
			
			'Domain 제거
			rpUrl = replace(Lcase(url),arrQL(0)&"//"&arrQL(2),"")
			
			if inStr(rpUrl,"/category_prd.asp")>0 then
				'PC상품 링크
				getConvertAppUrl = mobileUrl & "/apps/appcom/wish/web2014" & replace(rpUrl,"/shopping/category_prd.asp","/category/category_itemprd.asp")
			elseif isNumeric(arrQL(ubound(arrQL))) and ubound(arrQL)=3 then
				'// 상품 단축 링크
				getConvertAppUrl = mobileUrl & "/apps/appcom/wish/web2014/category/category_itemprd.asp?itemid=" & arrQL(ubound(arrQL))
			else
				getConvertAppUrl = mobileUrl & "/apps/appcom/wish/web2014" & rpUrl
			end if
		else
			getConvertAppUrl = url
		end if
	end Function

	'// 텐바이텐 APP접속여부 확인
	Function isApp()
	 	isApp = false

		if inStr(Lcase(Request.ServerVariables("HTTP_USER_AGENT")),"tenapp")>0 then
			isApp = true
		end if
	end Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->