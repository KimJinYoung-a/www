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
' Discription : pc_main_playing // cache DB경유
' History : 2018-03-12 원승현 생성
'#######################################################
Dim poscode , intI ,intJ
Dim sqlStr , rsMem , arrList
Dim gaParam : gaParam = "&gaparam=main_playing_" '//GA 체크 변수
Dim CtrlDate : CtrlDate = now()
Dim PlayingBgColor
Dim amplitudePlaying

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PBPLAYINGMAIN_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "PBPLAYINGMAIN"
End If

sqlStr = "db_sitemaster.dbo.[usp_Ten_pcmain_PLAYingBanner]"
'Response.write sqlStr

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

PlayingBgColor = arrlist(4,0)

on Error Resume Next

intJ = 0
If IsArray(arrList) Then
%>
<div class="section playing" style="background-color:#<%=PlayingBgColor%>;"><%' 플레잉 볼륨별 기본컬러 %>
	<div class="inner-cont">
		<div class="ftLt">
			<h2><img src="http://fiximage.10x10.co.kr/web2018/main/tit_playing.png" alt="PLAYing" /></h2>
			<p class="desc">당신의 감성을 플레이하다</p>
		</div>
		<div class="ftRt">
			<div class="items type-thumb item-hover">
				<ul>
<%
	Dim didx, midx, volnum, title, bgcolor, catename, playingimg

	For intI = 0 To ubound(arrlist,2)

		didx = arrlist(0,intI)
		midx = arrlist(1,intI)
		volnum = arrlist(2,intI)
		title = db2Html(arrlist(3,intI))
		bgcolor = arrlist(4,intI)
		catename = Split(db2Html(arrlist(5,intI)), "||")
		playingimg = db2Html(arrlist(6,intI))

%>
					<% 
						amplitudePlaying = "{'Kind':'"&catename(0)&"'}" 
						amplitudePlaying = Replace(amplitudePlaying, "'", "\""")
					%>
					<li>
						<a href="/playing/view.asp?didx=<%=didx&gaParam&didx%>" onclick=AmpEventPlaying(JSON.parse('<%=amplitudePlaying%>'));>
							<div class="thumbnail"><img src="<%=playingimg%>" alt="<%=title%>" /></div>
							<div class="desc">
								<p class="headline"><%=catename(0)%></p>
								<p class="subcopy"><%=title%></p>
								<p class="vol">Vol.<%=volnum%></p>
							</div>
						</a>
					</li>
<%
		intJ = intJ + 1
	Next
%>
				</ul>
			</div>
		</div>
	</div>
	<script>function AmpEventPlaying(jsonval){ AmplitudeEventSend('MainPlaying', jsonval, 'eventProperties'); }</script>
</div>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->