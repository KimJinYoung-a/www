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
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_enjoy_event // cache DB경유
' History : 2018-03-12 정태훈 생성
'#######################################################
Dim poscode , icnt ,jcnt, totalsaleper, totalprice
Dim sqlStr , rsMem, arrList, arrList2, rsMem2, amplitudeenjoyval
Dim categoryname, brand_id
'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName , dummyName2
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "EnjoyEvent_"&Cint(timer/60)
	dummyName2 = "EnjoyEvent_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "EnjoyEvent"
	dummyName2 = "EnjoyEvent"
End If

'// foryou
sqlStr = "EXEC [db_sitemaster].[dbo].[usp_WWW_PCMain_EnjoyEvent_Get]"
set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

If IsArray(arrList) Then
sqlStr = "EXEC [db_sitemaster].[dbo].[usp_WWW_PCMain_EnjoyEventItem_Get] '" & Cstr(arrList(5,0)) & "','" & Cstr(arrList(6,0)) & "','" & Cstr(arrList(7,0)) & "'"
set rsMem2 = getDBCacheSQL(dbget, rsget, dummyName2, sqlStr, cTime)
IF Not (rsMem2.EOF OR rsMem2.BOF) THEN
	arrList2 = rsMem2.GetRows
END IF
rsMem2.close
End If
Dim itemid, basicimage, itemname, sellcash, orgprice, sailyn, itemcouponyn, itemcoupontype, couponbyprice, itemcouponvalue
on Error Resume Next

If IsArray(arrList) Then
%>
			<div class="section color-exhibition" style="background-color:<%=arrList(0,0)%>"><!-- for dev msg : 어드민에서 배경컬러 입력-->
				<div class="inner-cont">
					<div class="big-thumbnail";><a href="/event/eventmain.asp?eventid=<%=arrList(1,0)%>&gaparam=main_bgenjoy_0" onclick=fnAmplitudeEventMultiPropertiesAction('click_maincolorevent','eventcode','<%=arrList(1,0)%>');><img src="<%=arrList(8,0)%>" alt="<%=arrList(2,0)%>" /></a></div>
					<div class="copy">
						<a href="/event/eventmain.asp?eventid=<%=arrList(1,0)%>&gaparam=main_bgenjoy_0">
							<h2>
								<p><%=arrList(2,0)%><% If arrList(4,0)<>"" Then %> <span class="discount color-red"><%=arrList(4,0)%></span><% End If %></p>
							</h2>
							<p><%=arrList(3,0)%></p>
						</a>
					</div>
					<% If IsArray(arrList2) Then %>
					<div class="items type-thumb item-150">
						<ul>
							<% For jcnt = 0 To ubound(arrList2,2) %>
							<%
								itemid			= arrList2(0,jcnt)
								basicimage		= webImgUrl & "/image/basic/" & GetImageSubFolderByItemid(itemid) + "/" & (arrList2(1,jcnt))
								itemname		= arrList2(2,jcnt)
								sellcash		= arrList2(3,jcnt)
								orgprice		= arrList2(4,jcnt)
								sailyn			= arrList2(5,jcnt)
								itemcouponyn	= arrList2(6,jcnt)
								itemcoupontype	= arrList2(7,jcnt)
								couponbyprice	= arrList2(8,jcnt)
								itemcouponvalue = arrList2(9,jcnt)

								'// 가격 할인
								If sailyn = "N" and itemcouponyn = "N" Then
									totalprice = formatNumber(orgPrice,0)
								End If
								If sailyn = "Y" and itemcouponyn = "N" Then
									totalprice = formatNumber(sellCash,0)
								End If

								if itemcouponyn = "Y" And itemcouponvalue>0 Then
									If itemcoupontype = "1" Then
										totalprice =  formatNumber(sellCash - CLng(itemcouponvalue*sellCash/100),0)
									ElseIf itemcoupontype = "2" Then
										totalprice =  formatNumber(sellCash - itemcouponvalue,0)
									ElseIf itemcoupontype = "3" Then
										totalprice =  formatNumber(sellCash,0)
									Else
										totalprice =  formatNumber(sellCash,0)
									End If
								End If
								
								If sailyn = "Y" And itemcouponyn = "Y" And itemcouponvalue>0 Then
									If itemcoupontype = "1" Then
										'//할인 + %쿠폰
										totalsaleper = "<span class='discount color-red'>"& CLng((orgPrice-(sellCash - CLng(itemcouponvalue*sellCash/100)))/orgPrice*100)&"%</span>"
									ElseIf itemcoupontype = "2" Then
										'//할인 + 원쿠폰
										totalsaleper = "<span class='discount color-red'>"& CLng((orgPrice-(sellCash - itemcouponvalue))/orgPrice*100)&"%</span>"
									Else
										'//할인 + 무배쿠폰
										totalsaleper = "<span class='discount color-red'>"& CLng((orgPrice-sellCash)/orgPrice*100)&"%</span>"
									End If
								elseif sailyn = "Y" and itemcouponyn = "N" Then
									If CLng((orgPrice-sellCash)/orgPrice*100)> 0 Then
										totalsaleper = "<span class='discount color-red'>" & CLng((orgPrice-sellCash)/orgPrice*100) &"%</span>"
									End If
								elseif itemcouponyn = "Y" And itemcouponvalue>0 Then
									If itemcoupontype = "1" Then
										totalsaleper ="<span class='discount color-green'>" &  CStr(itemcouponvalue) &"%</span>"
									ElseIf itemcoupontype = "2" Then
										totalsaleper = ""
									ElseIf itemcoupontype = "3" Then
										totalsaleper = ""
									Else
										totalsaleper = "<span class='discount color-green'>" & CStr(itemcouponvalue) &"%</span>"
									End If
								Else
										totalsaleper = ""
								End If
								
								amplitudeenjoyval = "{'EnjoyNumber':'"&jcnt&"'}" 
								amplitudeenjoyval = Replace(amplitudeenjoyval, "'", "\""")
								categoryname = fnItemIdToCategory1DepthName(itemid)
								brand_id = fnItemIdToBrandName(itemid)
							%>
							<li>
								<a href="/shopping/category_prd.asp?itemid=<%=itemid%>&gaparam=main_bgenjoy_<%=jcnt+1%>" onclick=fnAmplitudeEventMultiPropertiesAction('click_maincolorevent','eventcode|itemid|categoryname|brand_id','<%=arrList(1,0)%>|<%=itemid%>|<%=categoryname%>|<%=brand_id%>');AmpEnjoyEvent(JSON.parse('<%=amplitudeenjoyval%>'));>
									<div class="thumbnail"><img src="<%=getThumbImgFromURL(basicimage,200,200,"true","false")%>" alt="<%=itemname%>"></div>
									<div class="desc">
										<div class="price">
											<%=totalsaleper%>
											<span class="sum"><%=totalprice%></span>
										</div>
									</div>
								</a>
							</li>
							<% Next %>
						</ul>
						<button type="button" class="btn-go" 
						onclick="location.href='/event/eventmain.asp?eventid=<%=arrList(1,0)%>&gaparam=main_bgenjoy_0';fnAmplitudeEventMultiPropertiesAction('click_maincolorevent','eventcode','<%=arrList(1,0)%>');"><i class="icoV18"></i><span>더보기</span></button>
					</div>
					<% End If %>
				</div>
				<script>
					function AmpEnjoyEvent(jsonval)
					{
						AmplitudeEventSend('MainEnjoyEvent', jsonval, 'eventProperties');
					}
				</script>
			</div>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->