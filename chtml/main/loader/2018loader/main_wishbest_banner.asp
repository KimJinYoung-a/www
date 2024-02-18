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
' Discription : pc_main_wishbest // cache DB경유
' History : 2018-04-16 원승현 생성
'#######################################################
Dim poscode , intI ,intJ
Dim sqlStr , rsMem , arrList, arrItem
Dim gaParam : gaParam = "&gaparam=main_" '//GA 체크 변수
Dim CtrlDate : CtrlDate = now()
Dim playingGubun, targetNum, intT, amplitudewishbestVal, totalprice, totalsale

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PBWISHBESTMAIN_"&Cint(timer/60)
Else
	cTime = 60*5
'	cTime = 1*1
	dummyName = "PBWISHBESTMAIN_"
End If

sqlStr = "db_sitemaster.dbo.[usp_Ten_pcmain_wishbestList]"

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close


If IsArray(arrList) Then
sqlStr = "exec db_sitemaster.dbo.[usp_Ten_pcmain_wishbestItem] '"&arrlist(0,0)&"'"
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
<div class="section wish-best">
	<div class="inner-cont">
		<div class="ftLt" style="width:360px;">
			<h2><%=arrList(1, 0)%><br /><b><%=arrList(2, 0)%></b></h2>
			<% If Trim(arrList(3, 0))<>"" Then %>
				<% If InStr(arrList(3, 0), "?") > 0 Then %>
					<a href="<%=arrList(3, 0)%>&gaparam=main_textenjoy_item0" class="btn-linkV18 link2">더 보러 가기 <span></span></a>
				<% Else %>
					<a href="<%=arrList(3, 0)%>?gaparam=main_textenjoy_item0" class="btn-linkV18 link2">더 보러 가기 <span></span></a>
				<% End If %>
			<% End If %>
		</div>
		<div class="ftRt" style="width:780px;">
			<div class="items type-thumb item-180">
				<ul>
					<% For intI = 0 To UBound(arrItem, 2) %>
					<% 
						amplitudewishbestVal = "{'ItemId':'"&arrItem(2, intI)&"'}" 
						amplitudewishbestVal = Replace(amplitudewishbestVal, "'", "\""")

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
							<a href="/shopping/category_prd.asp?itemid=<%=arrItem(2, intI)%><%=gaParam%>textenjoy_item<%=intI+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_mainwishbest','indexnumber|itemid|categoryname|brand_id','<%=intI+1%>|<%=arrItem(2, intI)%>|<%=fnItemIdToCategory1DepthName(arrItem(2, intI))%>|<%=fnItemIdToBrandName(arrItem(2, intI))%>');">
								<div class="thumbnail"><img src="<%=arrItem(16,intI)%>" alt="<%=arrItem(6,intI)%>" /></div>
								<div class="desc">
									<p class="name"><%=arrItem(6,intI)%></p>
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
	</div>
	<script>
		function AmpEventWishBest(jsonval)
		{
			AmplitudeEventSend('Maintextenjoy', jsonval, 'eventProperties');
		}
	</script>
</div>
<% End If %>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->