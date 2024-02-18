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
' Discription : 메인페이지 상단 기획전 신규
' History : 2018-11-27 최종원 생성
'#######################################################
Dim intI 
Dim sqlStr , rsMem , arrList, arrItem, arrItemCount, contentImg, ampContentType, ampContentCode, itemId, evtCode
Dim gaParam
dim currentDate, testdate
dim displayInfoClass, contentInfo, eventInfoOption

dim linkurl 
dim evt_mo_listbanner
dim maincopy 
dim subcopy
dim coupon_per 
dim sale_per
dim dispOption
dim contentType
dim evtstdate
dim evteddate
gaParam = "main_topevent_"
dim strSql, isUsing		
	strSql = " SELECT top 1 isUsing "
	strSql = strSql & "	FROM db_sitemaster.DBO.tbl_pcmain_top_exhibition_ctrl WHERE flatform = 'PCWEB' order by idx asc "	
	
	rsget.CursorLocation = adUseClient
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
	
	if Not rsget.Eof Then
		isUsing = rsget("isUsing")
	End If
	rsget.close		

testdate = request("testdate")
if testdate <> "" Then
	currentDate = cdate(testdate) 
end if

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PBJUST1DAYNEWMAINs_"&Cint(timer/60)
Else
	cTime = 60*5
'	cTime = 1*1
	dummyName = "PBJUST1DAYNEWMAINs"
End If


sqlStr = "db_sitemaster.dbo.usp_Ten_pcmain_top_exhibition '"& currentDate &"'"

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrItem = rsMem.GetRows
	arrItemCount = rsMem.RecordCount
END IF
rsMem.close

on Error Resume Next
%>
<% if isusing = 1 then %>
	<% If IsArray(arrItem) Then %>
		<% If arrItemCount >= 3 Then %>
			<div class="section text-exhibition">
				<div class="inner-cont">
					<div class="list-card">
						<ul>						
						<%						
						For intI = 0 To UBound(arrItem, 2)
							linkurl = arrItem(0,intI)
							evt_mo_listbanner = arrItem(1,intI)						
							maincopy = arrItem(2,intI)
							subcopy = arrItem(3,intI)
							coupon_per = arrItem(4,intI)
							sale_per = arrItem(5,intI)
							dispOption = arrItem(6,intI)
							contentType = arrItem(7,intI)
							evtstdate = arrItem(8,intI)
							evteddate = arrItem(9,intI)		
							contentImg = arrItem(10,intI)					
							evtCode = arrItem(11,intI)		
							itemId = arrItem(12,intI)	
							contentInfo = arrItem(13,intI)	
							eventInfoOption = arrItem(14,intI)	

							'이벤트 정보 추가 //2019-05-16
							displayInfoClass = "color-red"
							if contentType = 1 then		'이벤트
								ampContentCode = evtCode
								ampContentType = "event"

								Select Case eventInfoOption
									Case "1"
										displayInfoClass = "color-red"	
									Case "2"
										displayInfoClass = "color-green"	
									case "3", "4", "5", "6", "7"
										displayInfoClass = "color-blue"			
									case else							
										displayInfoClass = "color-red"			
								End Select								
							else 						'상품
								ampContentCode = itemId
								ampContentType = "product"
								if sale_per <> "" and coupon_per <> "" then
									contentInfo = sale_per
									displayInfoClass = "color-red"
								elseif coupon_per <> "" then
									contentInfo = coupon_per
									displayInfoClass = "color-green"
								else 	
									contentInfo = sale_per
									displayInfoClass = "color-red"							
								end if														
							end if												
						%>						
							<li>
								<a href="<%=linkurl & "&gaparam=" & gaParam & intI + 1 %>" onclick="fnAmplitudeEventMultiPropertiesAction('click_top_event_banner', 'number|content_type|code','<%=intI + 1%>|<%=ampContentType%>|<%=ampContentCode%>');">
									<div class="thumbnail">
										<% if contentType = 2 then %>
											<img src="<%=contentImg%>" alt="" />
										<% else %>
											<img src="<%=evt_mo_listbanner%>" alt="" />
										<% end if %>										
									</div>
									<div class="desc">
										<p class="headline">
											<span class="ellipsis"><%=maincopy%></span>
											<b class="discount <%=displayInfoClass%>"><%=contentInfo%></b>
										</p>										
										<p class="subcopy">											
											<%=subcopy%>
										</p>
									</div>
								</a>
							</li>			
						<% 					
							If intI >= 2 Then
								Exit For
							End If
						%>							
						<% Next %>							
						</ul>
					</div>
				</div>
			</div>
		<% End If %>
	<% End If %>	
<% end if %>				
<%
	on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->