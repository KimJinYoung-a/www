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
' Discription : wedding_md_pick // cache DB경유
' History : 2018-04-18 정태훈 생성
'#######################################################
Dim poscode , icnt ,jcnt, totalsaleper, totalprice
Dim sqlStr , rsMem, arrList, intI, arrItemID

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "WeddingMDPick_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "WeddingMDPick"
End If

'// foryou
sqlStr = "EXEC [db_sitemaster].[dbo].[usp_WWW_Wedding_MDPick_Get]"
set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

Function GetItemBasicImage(itemid, Img, upload_img)
	If upload_img<>"" Then
		GetItemBasicImage=upload_img
	Else
		GetItemBasicImage = webImgUrl & "/image/basic/" + GetImageSubFolderByItemid(itemid) + "/" + Img
	End If
End Function

on Error Resume Next

If IsArray(arrList) Then
%>
			<div class="md-pick">
				<p class="sub">텐바이텐 MD들이 엄선한 힙한 웨딩 아이템</p>
				<h3>MD’s Pick</h3>
				<ul id="md-prd">
					<% For intI = 0 To ubound(arrlist,2) %>
					<li>
						<a href="/shopping/category_prd.asp?itemid=<%=arrList(0,intI)%>">
							<img src="<%=GetItemBasicImage(arrList(0,intI), arrList(1,intI), arrList(3,intI))%>" alt="" />
							<p class="prd-name"><%=arrList(2,intI)%></p>
							<p class="price">할인가<span>할인율</span></p>
						</a>
					</li>
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
		target:"md-prd",
		fields:["sale","price"],
		unit:"ew"
	});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->