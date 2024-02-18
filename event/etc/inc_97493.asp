<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2222 마일리지
' History : 2019-09-24 최종원 
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
	eCode = "90392"
Else
	eCode = "97493"
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
eventStartDate = Cdate("2019-09-24")

mileage = 2222
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
snpTitle	= Server.URLEncode("단 2일간! 목요일 자정에 사라지니 서둘러요!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre		= Server.URLEncode("마일리지 2,222원 사용 가능")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/97493/m/img_kakao_share.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[마일리지 2,222원 사용 가능]"
strPageKeyword = "마일리지 2,222원 사용 가능"
strPageDesc = "단 2일간! 목요일 자정에 사라지니 서둘러요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/97493/m/img_kakao_share.jpg"
%>
<style type="text/css">
.evt97493 {position:relative;}
.evt97493 .txt-only {position:absolute; top:348px; left:50%; margin-left:-279px; animation:bounce 1s 100;}
.evt97493 .btn-mileage {position:absolute; top:700px; left:50%; margin-left:-163px; background:none; animation:shake .7s 100;}
@keyframes bounce {
    from, to {transform:translateY(0); animation-timing-function:ease-in;}
    50% {transform:translateY(15px); animation-timing-function:ease-out;}
}
@keyframes shake {
    from, to {transform:translateX(3px);}
    50% {transform:translateX(-3px);}
}
.sns-share {position:relative;}
.sns-share ul {display:flex; position:absolute; top:0; left:618px; width:230px; height:100%;}
.sns-share ul li {flex-basis:50%;}
.sns-share ul li a {display:inline-block; width:100%; height:100%; text-indent:-999em;}
.noti {display:flex; align-items:center; padding:50px 0; background-color:#c05c34;}
.noti h3 {flex-basis:370px; text-align:right;}
.noti ul {padding-left:50px;}
.noti ul li {padding:4px 0; color:#fff; font-size:14px; font-family:'MalgunGothic'; text-align:left;}
.bnr-list {position:relative;}
.bnr-list ul {display:flex; position:absolute; top:0; left:0; width:100%; height:100%;}
.bnr-list ul li {flex-basis:50%;}
.bnr-list ul li a {display:inline-block; width:100%; height:100%; text-indent:-999em;}
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
					alert('마일리지 발급이 완료되었습니다.\n사용하지 않은 마일리지는 이벤트 기간 이후 자동 소멸됩니다.');
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
	fnAmplitudeEventMultiPropertiesAction('click_event_share','evtcode|sns','<%=eCode%>|'+snsnum)	
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
						<!-- 마일리지 2222 -->
						<div class="evt97493">
							<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/97493/img_evt.jpg" alt="2222 마일리지"></p>
							<span class="txt-only"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97493/txt_only.png" alt="단 2일간"></span>
                            <button type="button" class="btn-mileage" onclick="doAction();"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97493/btn_mileage.png" alt="마일리지 받기"></button>
                            <div class="sns-share">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2019/97493/img_share.png" alt="9월 마일리지 이벤트 친구에게 공유하기 ">
                                <ul>
                                    <li><a href="javascript:snschk('fb');">페이스북 공유</a></li>
                                    <li><a href="javascript:snschk('tw');">트위터 공유</a></li>
                                </ul>
                            </div>
							<div class="noti">
                                <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/97493/tit_noti.png" alt="이벤트 유의사항"></h3>
                                <ul>
                                    <li>· 본 이벤트는 <strong>로그인 후, ID당 1회만 참여 가능</strong>합니다.</li>
                                    <li>· 주문하시는 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
                                    <li>· 지급된 마일리지는 <strong>3만원 이상 구매 시 현금처럼 사용</strong> 가능합니다.</li>
                                    <li>· 주문결제 시 마일리지 란에서 사용 가능합니다.</li>
                                    <li>· 기간 내에 사용하지 않은 마일리지는 <strong>9월 27일 금요일 00:00:00에 자동 소멸</strong>됩니다. </li>
                                    <li>· 이벤트 기간 이후에 주문 취소 시, 마일리지는 다시 회수될 예정입니다.</li>
                                </ul>
                            </div>
                            <div class="bnr-list">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2019/97493/bnr_evts.jpg" alt="">
                                <ul>
                                    <li><a href="/event/eventmain.asp?eventid=97295">컬러별 작은집 인테리어 싱글룸 사용 설명서 이벤트로 이동</a></li>
                                    <li><a href="/event/eventmain.asp?eventid=97423">초록창에서 사랑받는 아이템, 최최최저가로 사기 이벤트로 이동</a></li>
                                </ul>
                            </div>
						</div>
						<!-- // 마일리지 2222 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->