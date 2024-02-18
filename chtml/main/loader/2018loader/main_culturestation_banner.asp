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
' Discription : pc_main_hitchhiker // cache DB경유
' History : 2018-03-06 이종화 생성
'#######################################################
Dim poscode , intI
Dim sqlStr , rsMem , arrList
Dim gaParam : gaParam = "&gaparam=main_culture_" '//GA 체크 변수

poscode = 714

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PCCUL_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "PCCUL"
End If

IF poscode = "" THEN
	Call Alert_Return("잘못된 접근입니다.")
	response.End
END IF

sqlStr = "db_sitemaster.dbo.[usp_WWW_PCMain_CultureStationBanner_Get] @poscode = "&poscode
'Response.write sqlStr

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next
If IsArray(arrList) Then

%>
<div class="section culture-station">
	<div class="inner-cont">
		<div class="ftLt" style="width:280px;">
			<h2><a href="/culturestation/?gaparam=main_culture_0"><b>컬쳐</b> 스테이션</a></h2>
			<a href="/culturestation/?gaparam=main_culture_0" class="btn-linkV18 link2">컬쳐 스테이션 더 보기 <span></span></a>
		</div>
		<div class="ftRt" style="width:860px;">
			<div class="list-culture">
				<ul>
<%

	Dim img , link , altname , alink , maincopy , subcopy , contents , evtcode , cmtcnt , evttype , amplitudecultureval

	For intI = 0 To ubound(arrlist,2)

		img				= db2Html(arrlist(0,intI))
		link			= db2Html(arrlist(1,intI))
		altname			= db2Html(arrlist(4,intI))
		maincopy		= db2Html(arrlist(5,intI))
		subcopy			= db2Html(arrlist(7,intI))
		contents		= nl2br(arrlist(11,intI))
		evtcode			= db2Html(arrlist(14,intI))
		cmtcnt			= db2Html(arrlist(15,intI))
		evttype			= arrlist(16,intI)

		alink = link & gaparam & intI

		amplitudecultureval = "{'CultureNumber':'"&intI&"'}"
		amplitudecultureval = Replace(amplitudecultureval, "'", "\""")
%>
					<li class="<%=chkiif(evttype,"read","feel")%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_mainculture','indexnumber|link','<%=intI+1%>|<%=link%>');">
						<a href="<%=alink%>">
							<div class="thumbnail"><img src="<%=img%>" alt="<%=altname%>" /></div>
							<div class="desc">
								<% If cmtcnt > 0 Then %>
									<span class="labelV18 label-s label-black"><b><%=cmtcnt%></b></span>
								<% End If %>
								<p class="headline"><%=maincopy%></p>
								<p class="present"><span class="icoV18"></span><%=subcopy%></p>
								<p class="story"><%=chrbyte(contents,"55","Y")%></p>
							</div>
						</a>
					</li>
<%
	Next
%>
				</ul>
			</div>
		</div>
	</div>
	<script>function AmpEventCulture(jsonval){ AmplitudeEventSend('MainCulture', jsonval, 'eventProperties'); }</script>
</div>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->