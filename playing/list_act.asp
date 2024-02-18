<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/playing/playingCls.asp" -->
<%
	Dim cPl, i, vStartDate, vState, vPage, vPageSize, vTotalCount, vCate, vLastDidx
	vStartDate = "getdate()"
	vState = "7"
	
	vPage = NullFillWith(RequestCheckVar(request("cpg"),3),"1")
	vPage = vPage - 1
	vCate = NullFillWith(RequestCheckVar(request("cate"),5),"")
	vLastDidx = NullFillWith(RequestCheckVar(request("didx"),10),"")
	vPageSize = "16"
	'vPageSize = "4"

	SET cPl = New CPlay
	cPl.FRectDidx			= vLastDidx
	cPl.FCurrPage			= vPage
	cPl.FPageSize 		= vPageSize
	cPl.FRectTop			= vPage*vPageSize
	cPl.FRectStartdate 	= vStartDate
	cPl.FRectState 		= vState
	cPl.FRectCate 		= vCate
	
	'### m.midx, m.volnum, m.title, m.mo_bgcolor
	cPl.fnPlayMainCornerListAjax()

If (cPl.FResultCount < 1) Then
Else
	For i = 0 To cPl.FResultCount-1
%>
	<div class="<%=LCase(fnClassNameToCate(cPl.FItemList(i).Fcate))%>">
		<a href="view.asp?didx=<%=cPl.FItemList(i).Fdidx%>">
			<%
			'### 띵41,띵띵41,아지트3 이고 테그노출인경우. 노출기간, 발표일 기간 따로 정해져있음.
			If cPl.FItemList(i).Fcate = "1" OR cPl.FItemList(i).Fcate = "3" OR cPl.FItemList(i).Fcate = "41" OR cPl.FItemList(i).Fcate = "42" Then
				If cPl.FItemList(i).Fistagview Then
					If CDate(cPl.FItemList(i).Ftag_sdate) <= date() AND CDate(cPl.FItemList(i).Ftag_edate) => date() Then
						Response.Write "<span class=""label together""><em>참여</em></span>"
					End If
					If CDate(cPl.FItemList(i).Ftag_announcedate) <= date() Then
						Response.Write "<span class=""label done""><em>당첨<br />발표</em></span>"
					End If
				Else
					If DateDiff("d",cPl.FItemList(i).Fstartdate,Now()) < 4 Then	'### 오픈후 3일동안
						Response.Write "<span class=""label""><em>NEW</em></span>"
					End If
				End If
			Else
				If DateDiff("d",cPl.FItemList(i).Fstartdate,Now()) < 4 Then	'### 오픈후 3일동안
					Response.Write "<span class=""label""><em>NEW</em></span>"
				End If
			End IF
			
			Response.Write "<div class=""figure"">"
			Response.Write "	<img src=""" & cPl.FItemList(i).Fimgurl & """ width=""255"" height=""255"" alt="""" />"
			If cPl.FItemList(i).Fcate = "1" OR cPl.FItemList(i).Fcate = "3" OR cPl.FItemList(i).Fcate = "6" Then
				If cPl.FItemList(i).Fcate = "3" Then
					Response.Write "<span class=""ico""><img src="""&cPl.FItemList(i).Ficonimg&""" alt= """"/></span>"
				Else
					Response.Write "<span class=""ico""><img src=""http://fiximage.10x10.co.kr/m/2016/play/ico_pictogram_00"&cPl.FItemList(i).Fcate&".png"" alt= """"/></span>"
				End If
			End If
			If cPl.FItemList(i).Fcate = "5" Then
				Response.Write "<span class=""btnView""><i>보러가기</i></span>"
			End If
			Response.Write "</div>"
			%>
			<div class="desc">
				<p>
					<b><%=cPl.FItemList(i).Ftitle%></b>
					<span><%=fnPlayingCateVer2("topname",cPl.FItemList(i).Fcate)%></span>
					<%
					If cPl.FItemList(i).Fcate <> "5" Then
						Response.Write "<span class=""btnView""><i>보러가기</i></span>"
					End If
					%>
				</p>
			</div>
		</a>
	</div>
<%
	Next
End If
%>
<% SET cPl = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->