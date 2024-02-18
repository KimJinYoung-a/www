<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 3333 마일리지
' History : 2019-07-02 최종원 
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode, userid, currenttime
IF application("Svr_Info") = "Dev" THEN
	eCode = "90323"
Else
	eCode = "95733"
End If

currenttime = now()
userid = GetEncLoginUserID()

dim eventEndDate, currentDate, eventStartDate
dim subscriptcount, totalsubscriptcount, mileage
dim limitcnt, currentcnt, eventType, soldOutMsg, timeLimitMsg
dim evtinfo : evtinfo = getEventDate(eCode)


if not isArray(evtinfo) then
	Call Alert_Return("잘못된 이벤트번호입니다.")
	dbget.close()	:	response.End
end if


'변수 초기화
eventStartDate = cdate(evtinfo(0,0))
eventEndDate = cdate(evtinfo(1,0))
currentDate = date()
'currentDate = Cdate("2019-05-04")
eventStartDate = cdate("2019-07-02")

mileage = 3333
subscriptcount=0
totalsubscriptcount=0
limitcnt = 9999
eventType = ""
soldOutMsg = "오늘의 마일리지가 모두 소진 되었습니다!"
timeLimitMsg = "마일리지는 오전 10시부터 받으실수 있습니다."

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", mileage, "")
end if

'//전체 참여수
totalsubscriptcount = getevent_subscripttotalcount(eCode, "", mileage, "")

currentcnt = limitcnt - totalsubscriptcount
'//본인 참여 여부
if currentcnt < 1 then currentcnt = 0
%>
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"") & chkIIF(gaparam<>"","&gaparam=" & gaparam,"")
			REsponse.End
		end if
	end if
end if
%>
<%
'공유관련
'// 쇼셜서비스로 글보내기 
Dim strPageTitle, strPageDesc, strPageUrl, strHeaderAddMetaTag, strPageImage, strPageKeyword
Dim strRecoPickMeta		'RecoPick환경변수
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("단 2일간! 스페셜 마일리지를 받아보세요!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre		= Server.URLEncode("현금처럼 사용하는 3,333 마일리지")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/95733/share.png")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[현금처럼 사용하는 3,333 마일리지]"
strPageKeyword = "현금처럼 사용하는 3,333 마일리지"
strPageDesc = "단 2일간! 스페셜 마일리지를 받아보세요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/95733/share.png"
%>
<style type="text/css">
.evt95733 {position:relative;}
.evt95733 .btn-mileage {position:absolute; top:649px; left:50%; margin-left:-170px; background:none; animation:bounce .7s 40;}
@keyframes bounce { 50% {transform:translateX(-5px);} }
.evt95733 .bot {overflow:hidden; display:flex;}
.evt95733 .share {position:relative;}
.evt95733 .share a {position:absolute; top:100px; width:130px; height:130px; font-size:0; color:transparent;}
.evt95733 .share a:first-child {left:140px;}
.evt95733 .share a:last-child {left:300px;}
.evt95733 .bnr a {display:block;}
</style>
<script type="text/javascript">
function doAction() {	
	<% if not (currentDate >= eventStartDate and currentDate <= eventEndDate) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>			
	<% If IsUserLoginOK() Then %>			
		<% if subscriptcount > 0 then %>
			alert("ID당 1회만 참여 가능합니다.");
			return;
		<% else %>	
			<% if eventType = "limitedEvent" then %>
				<% if currentcnt < 1 then %>
					alert("<%=soldOutMsg%>");
					return false;
				<% end if %>			
				<% if Hour(currenttime) < 10 then %>
					alert("<%=timeLimitMsg%>");
					return false;
				<% end if %>	
			<% end if %>
				var str = $.ajax({
					type: "post",
					url:"/event/etc/doeventsubscript/specialMileageEventSubscript.asp",
					data: {
						eventType: '<%=eventType%>',
						eventCode: '<%=eCode%>'
					},
					dataType: "text",
					async: false
				}).responseText;	

				if(!str){alert("시스템 오류입니다."); return false;}

				var resultData = JSON.parse(str);

				var reStr = resultData.data[0].result.split("|");
				var currentcnt = resultData.data[0].currentcnt;
				var userMileage = resultData.data[0].mileage;

				if(reStr[0]=="OK"){		
					alert('마일리지가 발급되었습니다.');
					fnAmplitudeEventMultiPropertiesAction('click_mileage_button','evtcode','<%=eCode%>')
					// console.log(resultData.data)
					// showPopup();		
				}else{
					var errorMsg = reStr[1].replace(">?n", "\n");
					alert(errorMsg);
					// document.location.reload();
				}			
				// console.log(resultData);
				<% if eventType = "limitedEvent" then %>		
				$("#dispCnt").html(currentcnt)
				$("#dispMileage").html(setComma(userMileage))
				<% end if %>
			return false;
		<% end if %>
	<% else %>
		jsEventLogin();
	<% End If %>
}
function jsEventLogin(){
	if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}
</script>
			<% if GetLoginUserLevel = "7" then %>
			<div style="color:red">*스태프만 노출</div>
			<div>받은 고객 수 : <%=totalsubscriptcount%></div>
			<% end if %>
			<!-- 3333마일리지 -->
			<div class="evt95733">
				<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95733/img_evt_v1.jpg" alt="3333 마일리지"></p>
				<button type="button" class="btn-mileage" onclick="doAction();"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95733/btn_v1.png" alt="마일리지 받기"></button>
				<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95733/txt_noti.jpg" alt="이벤트 유의사항"></p>
				<div class="bot">
					<div class="share">
						<a href="javascript:snschk('fb');">facebook 페이스북</a>
						<img src="//webimage.10x10.co.kr/fixevent/event/2019/95733/img_share.jpg" alt="마일리지 이벤트 친구에게 공유하기">
						<a href="javascript:snschk('tw');">twitter 트위터</a>
					</div>
					<div class="bnr">
						<a href="/event/eventmain.asp?eventid=95554"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95733/bnr_1.jpg" alt=""></a>
						<a href="/event/eventmain.asp?eventid=94973"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95733/bnr_2.jpg" alt=""></a>
					</div>
				</div>
			</div>
			<!-- // 3333마일리지 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->