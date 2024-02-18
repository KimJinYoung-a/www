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
' Discription : pc_main_look // cache DB경유
' History : 2018-03-21 원승현 생성
'#######################################################
Dim poscode , intI ,intJ, totalsale
Dim sqlStr , rsMem , arrList, arrItem
Dim gaParam : gaParam = "&gaparam=main_" '//GA 체크 변수
Dim CtrlDate : CtrlDate = now()
Dim playingGubun, targetNum, intT, amplitudelookVal

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PBLOOKMAIN_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "PBLOOKMAIN_"
End If

sqlStr = "db_sitemaster.dbo.[usp_Ten_pcmain_LookList]"

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close


If IsArray(arrList) Then
sqlStr = "exec db_sitemaster.dbo.[usp_Ten_pcmain_LookItem] '"&arrlist(0,0)&"'"
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
<div class="section lookbook" style="background-color:#<%=arrlist(2,0)%>;"><%' for dev msg : 어드민에서 배경컬러 등록 %>
	<h2><img src="<%=arrlist(1,0)%>" alt="Look Book" /><%' for dev msg : alt값에 타이틀명 넣어주세요 %></h2>
	<div id="slider" class="look-list">
		<ul>
			<% For intI = 0 To UBound(arrItem, 2) %>
				<% 
					amplitudelookval = "{'LookNumber':'"&intI&"'}" 
					amplitudelookval = Replace(amplitudelookval, "'", "\""")

					If arrItem(15, intI) = "Y" And arrItem(18, intI) = "Y" Then
						If arrItem(16, intI) = "1" Then
							'//할인 + %쿠폰
							totalsale = CLng((arrItem(11, intI)-(arrItem(10, intI) - CLng(arrItem(17, intI)*arrItem(10, intI)/100)))/arrItem(11, intI)*100)&"%"
						ElseIf arrItem(16, intI) = "2" Then
							'//할인 + 원쿠폰
							totalsale = CLng((arrItem(11, intI)-(arrItem(10, intI) - arrItem(17, intI)))/arrItem(11, intI)*100)&"%"
						Else
							'//할인 + 무배쿠폰
							totalsale = CLng((arrItem(11, intI)-arrItem(10, intI))/arrItem(11, intI)*100)&"%"
						End If 
					ElseIf arrItem(15, intI) = "Y" and arrItem(18, intI) = "N" Then
						If CLng((arrItem(11, intI)-arrItem(10, intI))/arrItem(11, intI)*100)> 0 Then
							totalsale = CLng((arrItem(11, intI)-arrItem(10, intI))/arrItem(11, intI)*100)&"%"
						End If
					elseif arrItem(15, intI) = "N" And arrItem(18, intI) = "Y" And arrItem(17, intI)>0 Then
						If arrItem(16, intI) = "1" Then
							totalsale = CStr(arrItem(17, intI)) & "%"
						ElseIf arrItem(16, intI) = "2" Then
							totalsale = "쿠폰"
						ElseIf arrItem(16, intI) = "3" Then
							totalsale = "쿠폰"
						Else
							totalsale = arrItem(17, intI) &"%"
						End If
					Else 
						totalsale = ""
					End If
				%>
				<li class="<% If arrItem(6, intI)="U" Then %>top<% Else %>bottom<% End If %>"><%' for dev msg : 상품이 위로 붙을 경우 top / 아래로 붙을 경우 bottom %>
					<div class="image">
						<a href="/shopping/category_prd.asp?itemid=<%=arrItem(2, intI)%><%=gaParam%>look_<%=intI+1%>" onclick=AmpEventLook(JSON.parse('<%=amplitudelookval%>'));fnAmplitudeEventMultiPropertiesAction('click_mainlookbanner','indexnumber|itemid|categoryname|brand_id','<%=intI+1%>|<%=arrItem(2, intI)%>|<%=fnItemIdToCategory1DepthName(arrItem(2, intI))%>|<%=fnItemIdToBrandName(arrItem(2, intI))%>');>
							<img src="<%=arrItem(4, intI)%>" alt="LookItem" />
							<% If arrItem(24, intI)="Y" Then %>
								<% If Trim(totalsale)<>"" Then %>
									<p <% If arrItem(18, intI)="Y" Then %> class="color-green"<% End If %>><span><%=totalsale%> SALE</span></p><%' for dev msg : 할인 있을 경우 노출%>
								<% End If %>
							<% End If %>
						</a>
					</div>
				</li>
			<% Next %>
		</ul>
	</div>
	<script>function AmpEventLook(jsonval){	AmplitudeEventSend('MainLookBook', jsonval, 'eventProperties');	}</script>
</div>
<% End If %>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->