<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_brandbig // cache DB경유
' History : 2018-03-23 원승현 생성
'#######################################################
Dim poscode , intI ,intJ
Dim sqlStr , rsMem , arrList, arrItem
Dim gaParam : gaParam = "&gaparam=main_" '//GA 체크 변수
Dim CtrlDate : CtrlDate = now()
Dim playingGubun, targetNum, intT, amplitudebrandbigVal, totalprice, totalsale

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PBBRANDBIGMAIN_"&Cint(timer/60)
Else
	cTime = 60*5
	'cTime = 1*1
	dummyName = "PBBRANDBIGMAIN_"
End If

sqlStr = "db_sitemaster.dbo.[usp_Ten_pcmain_BrandBigList]"

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close


If IsArray(arrList) Then
sqlStr = "exec db_sitemaster.dbo.[usp_Ten_pcmain_BrandBigItem] '"&arrlist(0,0)&"'"
'Response.write sqlStr
'response.End

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrItem = rsMem.GetRows
END IF
rsMem.close



on Error Resume Next

intJ = 0
%>
<% If IsArray(arrItem) Then %>
<div class="section rec-brand" style="background-image:url(<%=arrlist(1,0)%>);"><%' 1920x640 배경 이미지 등록 %>
	<div class="inner-cont">
		<h2>BRAND;</h2>
		<h3><b><%=arrlist(4,0)%></b> <span><%=arrlist(5,0)%></span></h3>
		<p class="story"><%=chrbyte(arrlist(6,0),270,"Y")%></p>
		<em class="btn-linkV18 link2">더보기 <span></span></em>
		<div class="items type-thumb item-180 item-hover">
			<ul>
				<% For intI = 0 To UBound(arrItem, 2) %>
					<% 
						amplitudebrandbigVal = "{'ItemId':'"&arrItem(2, intI)&"'}" 
						amplitudebrandbigVal = Replace(amplitudebrandbigVal, "'", "\""")

						if arrItem(15, intI) = "N" and arrItem(19, intI) = "N" Then
							totalprice = formatNumber(arrItem(11, intI),0)
						End If
						If arrItem(15, intI) = "Y" and arrItem(19, intI) = "N" Then
							totalprice = formatNumber(arrItem(10, intI),0)
						End If
						if arrItem(19, intI) = "Y" And arrItem(18, intI)>0 Then

							If arrItem(17, intI) = "1" Then
							totalprice = formatNumber(arrItem(10, intI) - CLng(arrItem(18, intI)*arrItem(10, intI)/100),0)
							ElseIf arrItem(17, intI) = "2" Then
							totalprice = formatNumber(arrItem(10, intI) - arrItem(18, intI),0)
							ElseIf arrItem(17, intI) = "3" Then
							totalprice = formatNumber(arrItem(10, intI),0)
							Else
							totalprice = formatNumber(arrItem(10, intI),0)
							End If
						End If
						If arrItem(15, intI) = "Y" And arrItem(19, intI) = "Y" Then
							If arrItem(17, intI) = "1" Then
								'//할인 + %쿠폰
								totalsale = CLng((arrItem(11, intI)-(arrItem(10, intI) - CLng(arrItem(18, intI)*arrItem(10, intI)/100)))/arrItem(11, intI)*100)&"%"
							ElseIf arrItem(17, intI) = "2" Then
								'//할인 + 원쿠폰
								totalsale = CLng((arrItem(11, intI)-(arrItem(10, intI) - arrItem(18, intI)))/arrItem(11, intI)*100)&"%"
							Else
								'//할인 + 무배쿠폰
								totalsale = CLng((arrItem(11, intI)-arrItem(10, intI))/arrItem(11, intI)*100)&"%"
							End If 
						ElseIf arrItem(15, intI) = "Y" and arrItem(19, intI) = "N" Then
							If CLng((arrItem(11, intI)-arrItem(10, intI))/arrItem(11, intI)*100)> 0 Then
								totalsale = CLng((arrItem(11, intI)-arrItem(10, intI))/arrItem(11, intI)*100)&"%"
							End If
						elseif arrItem(15, intI) = "N" And arrItem(19, intI) = "Y" And arrItem(18, intI)>0 Then
							If arrItem(17, intI) = "1" Then
								totalsale = CStr(arrItem(18, intI)) & "%"
							ElseIf arrItem(17, intI) = "2" Then
								totalsale = "쿠폰"
							ElseIf arrItem(17, intI) = "3" Then
								totalsale = "쿠폰"
							Else
								totalsale = arrItem(18, intI) &"%"
							End If
						Else 
							totalsale = ""
						End If

					%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=<%=arrItem(2, intI)%><%=gaParam%>brandbig_item<%=intI+1%>"" onclick=AmpEventBrandBig(JSON.parse('<%=amplitudebrandbigVal%>'));>
							<div class="thumbnail">
							<% If totalsale <> "" Then %>
								<% If Trim(arrItem(19, intI)) = "Y" Then %>
									<span class="discount color-green"><%=totalsale%></span>
								<% Else %>
									<span class="discount color-red"><%=totalsale%></span>
								<% End If %>
							<% End If %>
								<img src="<%=arrItem(16, intI)%>" alt="<%=arrItem(6, intI)%>">
							</div>
							<div class="desc">
								<p class="name"><%=arrItem(6, intI)%> </p>
								<div class="price">
									<% If Trim(arrItem(19, intI)) = "Y" Then %>
										<span class="discount color-green"><%=totalsale%></span>
									<% Else %>
										<span class="discount color-red"><%=totalsale%></span>
									<% End If %>
									<span class="sum"><%=totalprice%></span>
								</div>
							</div>
						</a>
					</li>
				<% Next %>
			</ul>
		</div>
	</div>
	<a href="<%=arrlist(2,0)%><%=gaParam%>brandbig_banner" class="btn-go" onclick="fnAmplitudeEventMultiPropertiesAction('click_main_brandbig','','');">더보기 <span></span></a>
	<script>
		function AmpEventBrandBig(jsonval)
		{
			AmplitudeEventSend('MainBrandBig', jsonval, 'eventProperties');
		}
	</script>
</div>
<% End If %>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->