<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
	Dim vQuery, vCateCode, vBody, vTotalCount, vEitemimg, vEventName, vSaleTag
	vCateCode = Request.Form("catecode")
	
	If Request.Form("gb") <> "proc" Then
		Response.Write "<script>alert('잘못된 접근임!');window.close();</script>"
		dbget.close()
		Response.End
	End IF
	
	If vCateCode = "" Then
		Response.Write "<script>alert('잘못된 접근임!');window.close();</script>"
		dbget.close()
		Response.End
	End IF
	
	If isNumeric(vCateCode) = False Then
		Response.Write "<script>alert('잘못된 접근임!');window.close();</script>"
		dbget.close()
		Response.End
	End IF
	'----------------------------------------------------------------------------------------------------------------------------------------
	vQuery = "SELECT TOP 2 b.evt_code, e.evt_name, e.evt_subcopyK, e.evt_startdate, convert(varchar(10),e.evt_enddate,102) as evt_enddate, "
	vQuery = vQuery & " 	case when d.evt_LinkType = 'I' then d.evt_bannerlink else '/event/eventmain.asp?eventid=' + convert(varchar,b.evt_code) end as evt_link, "
	vQuery = vQuery & "		d.issale, d.isgift, d.iscoupon, d.isOnlyTen, d.isoneplusone, d.isfreedelivery, d.isbookingsell, d.iscomment, d.etc_itemid, d.evt_mo_listbanner "
	vQuery = vQuery & " 	FROM [db_sitemaster].[dbo].tbl_category_main_eventBanner as b "
	vQuery = vQuery & "	INNER Join [db_event].dbo.tbl_event e on b.evt_code = e.evt_code "
	vQuery = vQuery & "	INNER Join [db_event].dbo.tbl_event_display d on b.evt_code = d.evt_code "
	vQuery = vQuery & " WHERE b.disp1 = '" & vCateCode & "' AND b.isusing = 'Y' "
	vQuery = vQuery & " ORDER BY b.viewidx asc, b.idx desc"
	rsget.Open vQuery,dbget,1
	vTotalCount = rsget.RecordCount
	
	If CStr(vTotalCount) <> "2" Then
		rsget.close
		Response.Write "<script>alert('이벤트베너 에 올릴 이벤트는 4개가 되어야합니다.');</script>"
		dbget.close()
		Response.End
	End If
	
	IF Not rsget.Eof Then
		vBody = ""
		
		Do Until rsget.Eof

'		If rsget("isOnlyTen") Then
'			vBody = vBody & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif"" alt=""ONLY"" /> "
'		End IF
'		If rsget("issale") Then
'			vBody = vBody & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif"" alt=""SALE"" /> "
'		End IF
'		If rsget("iscoupon") Then
'			vBody = vBody & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif"" alt=""쿠폰"" /> "
'		End IF
'		If rsget("isoneplusone") Then
'			vBody = vBody & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_oneplus.gif"" alt=""1+1"" /> "
'		End IF
'		If rsget("isgift") Then
'			vBody = vBody & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_gift.gif"" alt=""GIFT"" /> "
'		End IF
'		If datediff("d",rsget("evt_startdate"),date)<=3 Then
'			vBody = vBody & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif"" alt=""NEW"" /> "
'		End IF
'		If rsget("iscomment") Then
'			vBody = vBody & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_involve.gif"" alt=""참여"" /> "
'		End IF
		'vBody = vBody & "								<p><img src=""" & rsget("evt_mo_listbanner") & """ alt=""" & Replace(db2html(rsget("evt_name")),chr(34),"") & """ /></p>" & vbCrLf
		
		If rsget("issale") Or rsget("iscoupon") Then
			if ubound(Split(rsget("evt_name"),"|"))> 0 Then
				If rsget("issale") Or (rsget("issale") And rsget("iscoupon")) then
					vEventName	= cStr(Split(rsget("evt_name"),"|")(0))
					vSaleTag	= " <span style=color:red>"&cStr(Split(rsget("evt_name"),"|")(1))&"</span>"
				ElseIf rsget("issale") = False And rsget("iscoupon") = True Then
					vEventName	= cStr(Split(rsget("evt_name"),"|")(0))
					vSaleTag	= " <span style=color:green>"&cStr(Split(rsget("evt_name"),"|")(1))&"</span>"
				End If 
			else
				vEventName = rsget("evt_name")
			end if
		Else
			vEventName = rsget("evt_name")
		End If
		
		vBody = vBody & "						<li>" & vbCrLf
		vBody = vBody & "							<a href=""" & rsget("evt_link") & """>" & vbCrLf
		vBody = vBody & "								<p><img src=""" & rsget("evt_mo_listbanner") & """ alt=""event" & rsget("evt_code") & """ /></p>" & vbCrLf
		vBody = vBody & "								<p class=""evtTitV15""><strong>" & chrbyte(db2html(vEventName),56,"Y") & vSaleTag & "</strong></p>" & vbCrLf
		vBody = vBody & "								<p>" & chrbyte(Replace(db2html(rsget("evt_subcopyK")),vbCrLf,""),60,"Y") & "</p>" & vbCrLf
		vBody = vBody & "							</a>" & vbCrLf
		vBody = vBody & "						</li>" & vbCrLf

		vSaleTag = ""
		vEventName = ""
		
		rsget.MoveNext
		Loop

	    if (vBody<>"") then
	    	Dim fso
			Set fso = Server.CreateObject("ADODB.Stream")
			fso.Type = 2
			fso.Charset = "utf-8"
			fso.Open
			fso.WriteText (vBody)
			fso.SaveToFile server.mappath("/chtml_test/dispcate/main/")+ "\"&"catemain_eventbanner_"&vCateCode&".html", 2
			Set fso = nothing
	    end if

	End If
	rsget.close()
%>
<script>alert("OK!!");</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->