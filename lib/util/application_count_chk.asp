<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%

'채용정보 및 디자인핑거스, 컬쳐스테이션 리셋!
'Application("chk_recruit_date") = dateadd("d",-1,now())
'response.write Application("chk_recruit_date") & "<br>"
'response.write "!" & Application("comp_recruiting_cnt") & "!" & "<br>"
'response.write "!" & Application("comp_designfingers_cnt") & "!" & "<br>"
'response.write "!" & Application("comp_culture_cnt") & "!" & "<br>"

	'신규 채용정보 여부 확인 & 핑거스와 컬쳐스테이션(하루전) 새글 확인
	On Error Resume Next
	'if Application("chk_recruit_date") <> date() then
		'Application("chk_recruit_date") = date()
			'rsget.Open "select count(rcb_sn) from [192.168.0.78].db_company.dbo.tbl_recruit_board where rcb_state=0 and getdate() between rcb_startdate and rcb_enddate+' 23:59:59' ",dbget,1
			'	Application("comp_recruiting_cnt") = rsget(0)
			'rsget.Close
			'rsget.Open "SELECT count(DFSeq) From [db_sitemaster].[dbo].[tbl_designfingers] WHERE OpenDate = Left(getdate(),10) AND IsDisplay = 'true' ",dbget,1
			'	Application("comp_designfingers_cnt") = rsget(0)
			'rsget.Close
			'rsget.Open "SELECT count(evt_code) From [db_culture_station].[dbo].[tbl_culturestation_event] WHERE getdate() Between regdate And DateAdd(dd,1,regdate) ",dbget,1
			'	Application("comp_culture_cnt") = rsget(0)
			'rsget.Close
			rsget.Open "SELECT catecode FROM [db_sitemaster].[dbo].[tbl_dispcate_hot]",dbget,1
			Dim i, vTemp
			If Not rsget.Eof Then
				For i = 0 To rsget.RecordCount-1
					vTemp = vTemp & CStr(rsget(0)) & ","
					rsget.MoveNext
				Next
				vTemp = Trim(Left(vTemp,Len(vTemp)-1))
			End IF
			Application("comp_cate_hot") = vTemp
			rsget.Close
	'end if



Function fnGetHotCatelist()
    
	rsget.Open "SELECT catecode FROM [db_sitemaster].[dbo].[tbl_dispcate_hot]",dbget, 1
	If not rsget.Eof Then
		fnGetHotCatelist = rsget.getRows()
	End If
	rsget.close()
	
End Function

Dim iBufJsALL,ii,fso
    '' js hot 생성
	Dim iHotArray : iHotArray = fnGetHotCatelist()
	iBufJsALL = ""
	iBufJsALL = iBufJsALL&"function jsHotCateShow(idisp){"&VbCRLF
	if isArray(iHotArray) then
	    for ii=0 To UBound(iHotArray,2)
	        iBufJsALL = iBufJsALL&"if (idisp=='"&LEFT(iHotArray(0,ii),3)&"') $('#tophotdisp"&iHotArray(0,ii)&"').show();"&VbCRLF  ''$('#tophotdisp101104').show();
	    next
	end if
	iBufJsALL = iBufJsALL&"}"&VbCRLF
	
	Set fso = Server.CreateObject("ADODB.Stream")
	fso.Type = 2
	fso.Charset = "utf-8"
	fso.Open
	fso.WriteText (iBufJsALL)
	fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_hot.js", 2
	Set fso = nothing
	
	'' js hot include
	iBufJsALL = ""
	iBufJsALL = "<script type=""text/javascript"" src=""/chtml/dispcate/html/cate_menu_hot.js?v="&FormatDate(now(),"00000000000000")&"""></script>"
	Set fso = Server.CreateObject("ADODB.Stream")
	fso.Type = 2
	fso.Charset = "utf-8"
	fso.Open
	fso.WriteText (iBufJsALL)
	fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_hot_js_loader.html", 2
	Set fso = nothing
	
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
