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
' Discription : pc_main_video // cache DB경유
' History : 2020.06.18 정태훈 생성
'#######################################################
Dim poscode , icnt ,jcnt, totalsaleper, totalprice
Dim sqlStr , rsMem, arrList

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "MainVideo_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "MainVideo"
End If

'// foryou
sqlStr = "EXEC [db_sitemaster].[dbo].[usp_WWW_PCMain_Video_Get]"
set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next

If IsArray(arrList) Then
%>
						<div class="video-bnr">
                            <% if arrlist(2,0)="1" then %>
							<a href="http://www.10x10.co.kr/shopping/category_prd.asp?itemid=<%=arrlist(3,0)%>&gaparam=main_gif" onclick="fnAmplitudeEventMultiPropertiesAction('click_maingifbanner','','');">상품 바로가기</a>
                            <% elseif arrlist(2,0)="2" then %>
							<a href="http://www.10x10.co.kr/event/eventmain.asp?eventid=<%=arrlist(3,0)%>&gaparam=main_gif" onclick="fnAmplitudeEventMultiPropertiesAction('click_maingifbanner','','');">이벤트 바로가기</a>
                            <% elseif arrlist(2,0)="3" then %>
							<a href="http://www.10x10.co.kr/hitchhiker/?gaparam=main_gif" onclick="fnAmplitudeEventMultiPropertiesAction('click_maingifbanner','','');">히치하이커 바로가기</a>
                            <% elseif arrlist(2,0)="4" then %>
							<a href="http://www.10x10.co.kr/street/street_brand.asp?makerid=<%=arrlist(3,0)%>&gaparam=main_gif" onclick="fnAmplitudeEventMultiPropertiesAction('click_maingifbanner','','');">브랜드 바로가기</a>
                            <% elseif arrlist(2,0)="5" then %>
							<a href="http://www.10x10.co.kr/diarystory2020/daccutv_detail.asp?cidx=<%=arrlist(3,0)%>&gaparam=main_gif" onclick="fnAmplitudeEventMultiPropertiesAction('click_maingifbanner','','');">다꾸TV 바로가기</a>
                            <% end if %>
							<!-- html5 -->
							<video id="video-cnt" preload="auto" autoplay="true" loop="loop" muted="muted" volume="0" style="width:540px; height:540px;">
								<source src="//webimage.10x10.co.kr/video/<%=arrlist(0,0)%>" type="video/mp4">
								<img src="//webimage.10x10.co.kr/video/<%=arrlist(1,0)%>">
							</video>
							<!--// html5 -->
						</div>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->