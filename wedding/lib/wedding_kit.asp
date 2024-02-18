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
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : wedding_md_pick // cache DB경유
' History : 2018-04-18 정태훈 생성
'#######################################################
Dim poscode , icnt ,jcnt, totalsaleper, totalprice
Dim sqlStr , rsMem, arrList, intI, arrItemID

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "WeddingKit_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "WeddingKit"
End If

'// foryou
sqlStr = "EXEC [db_sitemaster].[dbo].[usp_WWW_Wedding_Kit_Get]"
set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next

If IsArray(arrList) Then
%>
			<div class="kit-inner">
				<h3>오직 텐바이텐에서만 만날 수 있는 <span>심플 웨딩 세트</span></h3>
				<ul class="kit-list" id="kit-list">
					<% For intI = 0 To ubound(arrlist,2) %>
					<% If arrList(6,intI) <> "" Then %>
					<li class="kit kitB">
						<a href="/shopping/category_prd.asp?itemid=<%=arrList(0,intI)%>" class="overHidden">
							<div class="detail  ftLt">
								<div class="name">
									<span><%=arrList(1,intI)%></span>
									<p><%=arrList(2,intI)%></p>
								</div>
								<p class="tag"><%=arrList(3,intI)%></p>
								<p class="price">할인가<span>할인율</span></p>
							</div>
							<div class="thumb ftRt">
								<img src="<%=arrList(6,intI)%>" alt="">
								<div class="txt">
									<div class="inner">
										<p><%=arrList(7,intI)%><br/ ><%=nl2br(arrList(4,intI))%></p>
										<span>구매하러 가기</span>
									</div>
								</div>
							</div>
						</a>
					</li>
					<% Else %>
					<li class="kit kitA">
						<a href="/shopping/category_prd.asp?itemid=<%=arrList(0,intI)%>" class="overHidden">
							<div class="detail kitA ftLt">
								<div class="name">
									<span><%=arrList(1,intI)%></span>
									<p><%=arrList(2,intI)%></p>
								</div>
								<p class="tag"><%=arrList(3,intI)%></p>
								<p class="price">할인가<span>할인율</span></p>
							</div>
							<div class="thumb ftRt">
								<img src="<%=arrList(5,intI)%>" alt="">
								<div class="txt">
									<div class="inner">
										<p><%=arrList(7,intI)%><br/ ><%=nl2br(arrList(4,intI))%></p>
										<span>구매하러 가기</span>
									</div>
								</div>
							</div>
						</a>
					</li>
					<% End If %>
					<%arrItemID = arrItemID+Cstr(arrList(0,intI))+","%>
					<% Next %>
				</ul>
			</div>
<%
End If
on Error Goto 0
%>
<script type="text/javascript">
$(function(){
	fnApplyItemInfoList({
		items:"<%=left(arrItemID,Cint(Len(arrItemID)-1))%>",
		target:"kit-list",
		fields:["sale","price"],
		unit:"ew"
	});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->