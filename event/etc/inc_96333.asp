<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  행운의 편지
' History : 2019-07-30 최종원 
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode, userid
IF application("Svr_Info") = "Dev" THEN
	eCode = "90359"
Else
	eCode = "96333"
End If

userid = GetEncLoginUserID()

dim eventEndDate, currentDate, eventStartDate
dim subscriptcount, totalsubscriptcount, presentDate
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
eventStartDate = cdate("2019-05-10")
presentDate = "9월 1일"

dim sqlstr, isAcceptUser

	if userid<>"" then		
		sqlstr = "SELECT EMAILOK "
		sqlstr = sqlstr & " FROM DB_USER.DBO.TBL_USER_N "		
		sqlstr = sqlstr & " WHERE USERID = '"& userid &"'"
		
		rsget.Open sqlstr,dbget
		IF not rsget.EOF THEN
			isAcceptUser = rsget("EMAILOK")
		END IF
		rsget.close	

		subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")		
	end if	
	totalsubscriptcount = getevent_subscripttotalcount(eCode, "", "", "")	
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
snpTitle	= Server.URLEncode("[행운의 편지] 10,000 마일리지를 받을 수 있는 기회! 텐바이텐 메일 수신하고 행운의 편지를 받아보세요!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre		= Server.URLEncode("행운의 편지")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/94436/m/img_bnr_kakao.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[행운의 편지]"
strPageKeyword = "행운의 편지"
strPageDesc = "[행운의 편지] 10,000 마일리지를 받을 수 있는 기회! 텐바이텐 메일 수신하고 행운의 편지를 받아보세요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/94436/m/img_bnr_kakao.jpg"
%>
<style>
.evt96333 button { background-color:transparent;}
.share,
.evt-conts,
.topic {position:relative;}
.topic .intro,
.topic span,
.topic h2 {position:absolute; top:165px; left:50%; margin-left:-221px;}
.topic h2 button {position:absolute; top:197px; left:128px; animation:moveX 1s .8s 1000;}
.topic span {top:367px; margin-left:-258px;}
.topic .intro {top:477px; margin-left:-278px;}

.evt-conts button {position:absolute; top:187px; left:310px;}
.evt-conts button i {position:absolute; top:-53px; left:98px; animation:moveY 1s 1000;}

.share ul {overflow:hidden; position:absolute; top:122px; left:625px; height:75px; width:160px;}
.share ul li {float:left; height:100%; width:50%;}
.share ul li a {display:inline-block; width:100%; height:100%; text-indent:-999em;}

.noti {position: absolute; bottom: 55px;}
.noti ul {padding-top:14px; padding-left:275px;}
.noti ul li {position:relative; padding-top:14px; color:#000; font-size:13px; line-height:1; font-family: 'malgun Gothic','맑은고딕',sans-serif; text-align:left; letter-spacing:-.3px; }
.noti ul li:before {display:inline-block; position:absolute; top:18px; left:-13px; width:4px; height:4px; border-radius:50%; background-color:#000; content:' ';}
.noti ul li a {color:#000; text-decoration:underline;}

.evt96333 .layer {position:absolute; top:0; left:0; z-index:20; width:100%; height:100%; background-color: rgba(255, 164, 176, .8);}
.evt96333 .layer .inner {position:absolute; top:87px; left:50%; margin-left:-322px;}
.evt96333 .layer-detail {cursor:pointer;}
.evt96333 .layer-agree .inner {top:610px;}
.evt96333 .layer-agree .btn-group {position:absolute; top:250px; left:145px;}
.evt96333 .layer-agree .btn-group button {margin-right:50px;}
.evt96333 .layer-agree .btn-close {position:absolute; top:45px; right:80px; cursor:pointer;}

@keyframes moveX{
    from {transform:translateX(0); z-index:10;}
    50% {transform:translateX(20px);}
    to {transform:translateX(0); z-index:10;}
}
@keyframes moveY{
    from {transform:translateY(0);}
    50% {transform:translateY(10px);}
    to {transform:translateY(0);}
}
</style>
<script type="text/javascript">
$(function() {
    // title animation
	titleAnimation();
	$(".intro").css({"margin-top":"30px","opacity":"0"});
	function titleAnimation() {
		$(".topic h2").animate({"top":"70px"},800);
		$(".intro ").delay(200).animate({"margin-top":"0", "opacity":"1"},800);
	}

    $(".evt96333 .btn-detail").click(function(){
        $('.evt96333 .layer-detail').fadeIn();
    });
    // $(".evt96333 .btn-agree").click(function(){
    //     $('.evt96333 .layer-agree').fadeIn();
    // });
    $(".evt96333 .layer").click(function(){
        $(this).fadeOut();
    });
});
</script>
<script type="text/javascript">
var isAgree = false;

function doAction() {	
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>			
	<% If IsUserLoginOK() Then %>			
		<% if isAcceptUser = "Y" then %>
			alert("이미 메일 수신에 동의하셨습니다.\n매달 첫번째 월요일을 기다려주세요!");
			return;
		<% else %>
				var str = $.ajax({
					type: "post",
                    url:"/event/etc/doeventsubscript/doMailingEventAction.asp",
					data: {
						isAcceptUser: "<%=isAcceptUser%>",
						evtCode: "<%=eCode%>",
						presentDate: "<%=presentDate%>"						
					},
					dataType: "text",
					async: false
				}).responseText;					
				if(!str){alert("시스템 오류입니다."); return false;}

				var resultData = JSON.parse(str);

				var reStr = resultData.data[0].result.split("|");

				if(reStr[0]=="OK"){	
					fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>')
					isAgree = true;																
					alert(reStr[1].replace(">?n", "\n"));					
				}else{
					var errorMsg = reStr[1].replace(">?n", "\n");
					alert(errorMsg);
				}			
				
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
function chkLogin(){
	<% if isAcceptUser = "Y" then %>
		alert("이미 메일 수신에 동의하셨습니다.\n매달 첫번째 월요일을 기다려주세요!");
		return;
	<% else %>				
		<% If IsUserLoginOK() Then %>		
		if(!isAgree){	
			$('.evt96333 .layer-agree').fadeIn()
		}else{
			alert("이미 메일 수신에 동의하셨습니다.\n매달 첫번째 월요일을 기다려주세요!");
		}
		<% else %>
		jsEventLogin()
		<% end if %>
	<% end if %>
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
			<div>응모 고객 수 : <%=totalsubscriptcount%></div>			
			<% end if %>			
						<div class="evt96333">
                            <div class="topic">
                                <h2>
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/tit_lucky.png" alt="행운의 편지">
                                    <!--<button class=btn-detail><img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/btn_detail.png" alt="자세히보기"></button>-->
                                </h2>
                                <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/img_envelope.png" alt=""></span>
                                <p class="intro"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/txt_intro.png" alt="텐바이텐 메일을 수신 동의한 고객 중  추첨을 통해 행운의 편지를 보내드립니다 "></p>
                                <img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/bg_lucky.jpg" alt="">
                            </div>
                            <div class="evt-conts">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/txt_conts.jpg" alt="참여방법 1위 버튼 클릭하고 텐바이텐 이메일 수신 동의하기! 2 매달 첫 번째 월요일 행운의 편지 기다리기!">
                                <button class="btn-agree" type="button" onclick="chkLogin();">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/btn_agree.png" alt="이메일 수신 동의하러가기">
                                    <i><img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/txt_click.png" alt="클릭"></i>
                                </button>
                            </div>
                            <!-- 공유하기 -->
                            <div class="share">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/img_share.jpg" alt="행운의 편지 이벤트를 친구에게도 알려주세요!">
                                <ul>
                                    <li><a href="javascript:snschk('fb');">페이스북 공유</a></li>
                                    <li><a href="javascript:snschk('tw');">트위터 공유</a></li>
                                </ul>
                            </div>
                            <div class="noti">
                                <ul>
                                    <li>본 이벤트는 텐바이텐 메일 수신 동의한 고객이라면 자동으로 응모되는 이벤트 입니다.</li>
                                    <li>이벤트 당첨자는 메일을 통해 행운의 편지가 발송 될 예정입니다.</li>
                                    <li>메일 주소가 정확하지 않은 경우, 메일 발송이 불가합니다. MY 회원정보 페이지에서 메일 주소를 확인해주세요.</li>
                                    <li>당첨자 발표 이전에 메일 수신을 해지하는 경우에는 당첨이 불가합니다.</li>
                                </ul>
                            </div>
                            <!-- 레이어팝업 (수신동의) -->
                            <div class="layer layer-agree" style="display:none;">
                                <div class="inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/txt_agree.png" alt="이메일 수신동의 텐바이텐 이메일 수신 동의를 하시면 다양한 할인 혜택과 이벤트 ,신상품 등의 정보를 빠르게 만나실 수 있습니다. 텐바이텐 이메일로 다양한 정보를 받아 보시겠습니까?
                                   ">
                                    <div class="btn-group">
                                        <button type="button" onclick="doAction();"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/btn_yes.png" alt="예"></button>
                                        <button><img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/btn_no.png" alt="아니오"></button>
                                    </div>
                                    <button class="btn-close"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96333/btn_close.png" alt="닫기"></button>
                                </div>
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->