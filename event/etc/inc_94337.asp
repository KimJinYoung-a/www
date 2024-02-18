<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  스페셜 마일리지
' History : 2019-03-11 최종원 
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
	eCode = "90273"
Else
	eCode = "94337"
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
eventStartDate = cdate("2019-05-03")

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
snpTitle	= Server.URLEncode("단 3일간 사용 가능한 스페셜 마일리지를 받아보세요!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre		= Server.URLEncode("마일리지 3,333원 받자!")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/94337/bnr_kakao.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[마일리지 3,333원 받자!]"
strPageKeyword = "마일리지 3,333원 받자!"
strPageDesc = "단 3일간 사용 가능한 스페셜 마일리지를 받아보세요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/94337/bnr_kakao.jpg"
%>
<style type="text/css">
.evt94337 {position: relative;}
.evt94337 .blind {display: none; height: 0; line-height: 0; opacity: 0;}
.bnr-area {*zoom:1} 
.bnr-area:after {display:block; clear:both; content:'';}
.bnr-area a,
.bnr-area div {float: left; display: block; width: 50%;}
.ani1 {position: absolute; top: 220px; left: 700px; animation:bounce .7s 30;}
button {position: absolute; top: 1045px; left: 0; width: 100%; outline: none; background: none; }
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
</style>
<script>
$(function(){
    $(window).scroll(function() {
        $('.ani2').addClass('animation')
    })
})
</script>
<script type="text/javascript">
function doAction() {	
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
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
					// console.log(resultData.data)
					// showPopup();		
				}else{
					var errorMsg = reStr[1].replace(">?n", "\n");
					alert(errorMsg);
		//				document.location.reload();
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
			<!-- 94337 마일리지 -->
			<div class="evt94337">
				<div>
					<img src="//webimage.10x10.co.kr/fixevent/event/2019/94337/img_mileage.jpg?v=1.01" alt="단 3일간 사용 가능한 스페셜 마일리지를 드립니다" />
					<p class="ani1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94337/img_ani.png" alt="단 3일간" /></p>
					<button type="button" onclick="doAction()"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94337/btn_submit.jpg" alt="마일리지 받기" /></button>
					<div class="blind">
						<h3>이벤트 유의사항</h3>
						<ul>
							<li>본 이벤트는 로그인 후에 참여할 수 있습니다. </li>
							<li>ID당 1회만 참여가 가능합니다. </li>
							<li>주문하시는 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
							<li>지급된 마일리지는 <b>3만원 이상 구매 시 현금처럼 사용 가능<b>합니다.</li>
							<li>주문결제 시 마일리지 란에서 사용 가능합니다.</li>
							<li>기간 내에 사용하지 않은 마일리지는 5월 9일 목요일 00:00에 자동 소멸됩니다. </li>
							<li>이벤트는 조기 마감될 수 있습니다. </li>
						</ul>
					</div>
				</div>
				<div class="bnr-area">
					<div>
						<img src="//webimage.10x10.co.kr/fixevent/event/2019/94337/bnr_01.jpg" alt="마일리지 이벤트 친구에게 공유하기" usemap="#map1">
						<map name="map1" id="map1">
							<area shape="rect" coords="123,72,286,233" href="javascript:snschk('fb');" alt="facebook" />
							<area shape="rect" coords="286,72,457,233" href="javascript:snschk('tw');" alt="twitter" />								
						</map>
					</div>
					<a href="/event/eventmain.asp?eventid=94031"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94337/bnr_02.jpg" alt="당신의 추억이 새로워 지는 순간"></a>
					<a href="/event/eventmain.asp?eventid=93945"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94337/bnr_03.jpg" alt="때가 됐다! 봄 신상 살 때!"></a>
				</div>
			</div>
			<!-- // 94337 마일리지 --> 
<!-- #include virtual="/lib/db/dbclose.asp" -->