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

	Dim cPl, i, intLoop, vVolArr, vCoArr, vStartDate, vState, vCate, vCurrPage
	vCurrPage = NullFillWith(requestCheckVar(Request("cpg"),5),1)
	vStartDate = "getdate()"
	vState = "7"
	
	SET cPl = New CPlay
	cPl.FPageSize 		= 5
	cPl.FCurrPage			= vCurrPage
	cPl.FRectStartdate 	= vStartDate
	cPl.FRectState 		= vState
	
	'### m.midx, m.volnum, m.title, m.mo_bgcolor
	vVolArr = cPl.fnPlayMainVolList()


	IF isArray(vVolArr) THEN
		For intLoop=0 To UBound(vVolArr,2)
%>
		<div class="section">
			<div class="hgroup">
				<h3>Vol.<%=vVolArr(1,intLoop)%></h3>
				<p class="date"><%=vVolArr(2,intLoop)%></p>
			</div>
			<div class="listThumbnail">
			<%
			cPl.FRectIsMain = True
			cPl.FRectTop = "100"
			cPl.FRectDevice = "p"
			cPl.FRectMIdx = vVolArr(0,intLoop)
			vCoArr = cPl.fnPlayMainCornerList()
			'### d.didx, d.title, d.cate, ca.catename, d.startdate, imgurl, d.mo_bgcolor, d.iconimg
			
			IF isArray(vCoArr) THEN
				For i=0 To UBound(vCoArr,2)
			%>
				<div class="<%=LCase(fnClassNameToCate(vCoArr(2,i)))%>" <%=CHKIIF(vCoArr(2,i)=5,"style=""background-color:#"&vCoArr(6,i)&";""","")%>>
					<a href="view.asp?didx=<%=vCoArr(0,i)%>" target="_blank">
						<%
						'### 띵41,띵띵41,아지트3 이고 테그노출인경우. 노출기간, 발표일 기간 따로 정해져있음.
						If vCoArr(2,i) = "1" OR vCoArr(2,i) = "3" OR vCoArr(2,i) = "41" OR vCoArr(2,i) = "42" Then
							If vCoArr(9,i) Then
								If CDate(vCoArr(10,i)) <= date() AND CDate(vCoArr(11,i)) => date() Then
									Response.Write "<span class=""label together""><em>참여</em></span>"
								End If
								If CDate(vCoArr(12,i)) <= date() Then
									Response.Write "<span class=""label done""><em>당첨<br />발표</em></span>"
								End If
							Else
								If DateDiff("d",vCoArr(4,i),Now()) < 4 Then	'### 오픈후 3일동안
									Response.Write "<span class=""label""><em>NEW</em></span>"
								End If
							End If
						Else
							If DateDiff("d",vCoArr(4,i),Now()) < 4 Then	'### 오픈후 3일동안
								Response.Write "<span class=""label""><em>NEW</em></span>"
							End If
						End IF
						
						Response.Write "<div class=""figure"">"
						Response.Write "<img src=""" & vCoArr(5,i) & """ alt="""" />"
						If vCoArr(2,i) = "1" OR vCoArr(2,i) = "3" OR vCoArr(2,i) = "6" Then
							If vCoArr(2,i) = "3" Then
								Response.Write "<span class=""ico""><img src="""&fnPlayIconImgPCName(vCoArr(7,i))&""" alt= """"/></span>"
							Else
								Response.Write "<span class=""ico""><img src=""http://fiximage.10x10.co.kr/m/2016/play/ico_pictogram_00"&vCoArr(2,i)&"_pc.png"" alt= """"/></span>"
							End If
						End If
						If vCoArr(2,i) = "5" Then
							Response.Write "<span class=""btnView""><i>보러가기</i></span>"
						End If
						Response.Write "</div>"
						%>
						<div class="desc">
							<p>
								<b><%=db2html(vCoArr(1,i))%></b>
								<span><%=fnPlayingCateVer2("topname",vCoArr(2,i))%></span>
								<%
								If vCoArr(2,i) <> "5" Then
									Response.Write "<span class=""btnView""><i>보러가기</i></span>"
								End If
								%>
							</p>
						</div>
					</a>
				</div>
			<%
				Next
			End IF
			%>
			</div>
		</div>
<%
		Next
	End IF
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->