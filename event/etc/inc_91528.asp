<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  언박싱 콘테스트 
' History : 2019-01-02 최종원 
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, resultParam, alertMsg, sqlstr, cnt, LoginUserid
dim eventEndDate, currentDate, eventStartDate, alarmRegCnt 
dim i
dim evtItemCode

IF application("Svr_Info") = "Dev" THEN
	eCode = "90204"		
Else
	eCode = "91528"	
End If

eventStartDate = cdate("2018-12-21")
eventEndDate = cdate("2019-01-31")
currentDate = date()
LoginUserid	= getencLoginUserid()

if LoginUserid <> "" then
	'이벤트 응모
	sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE evt_code='"& eCode &"' and sub_opt2 <> '1' "
	rsget.Open sqlstr, dbget, 1
		cnt = rsget("cnt")
	rsget.close

	'알람 응모
	sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode &" and sub_opt2 = '1' "
	rsget.Open sqlstr, dbget, 1
		alarmRegCnt = rsget("cnt")
	rsget.close	
end if
%>
<%
'트래킹 기능 추가

'마케팅 웹 띠배너 배너 : &gaparam=main_mkt_2
'마케팅 모바일 배너 : &gaparam=today_mkt_2
'이벤트 : &gaparam=enjoyevent_all_17
'페이스북 : &rdsite=mktp

dim trackingType

dim gaparam
dim rdsite

gaparam = request("gaparam")
rdsite  = request("rdsite")

select case rdsite
    case "mktp"
        trackingType = "페이스북"
    case else
        trackingType = ""
end select 

if gaparam <> "" then
    Select Case gaparam
        Case "main_mkt_2"
            trackingType = "웹 띠배너"        
        Case "today_mkt_2"
            trackingType = "모바일 배너"                
        Case "enjoyevent_all_17"
            trackingType = "이벤트"        
        case else
            trackingType = ""    
    end Select
end if
%>

<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=91528" & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"") & chkIIF(gaparam<>"","&gaparam=" & gaparam,"")
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
snpTitle	= Server.URLEncode("택배 뜯을 때의 설렘을 나누자! 텐바이텐 언박싱 영상 찍고 총 150만원의 기프트카드 받아가세요!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=91528")
snpPre		= Server.URLEncode("텐텐 언박싱 콘테스트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/91528/unboxing_kakao.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[텐텐 언박싱 콘테스트]"
strPageKeyword = "택배 뜯을 때의 설렘을 나누자!"
strPageDesc = "텐바이텐 언박싱 영상 찍고 총 150만원의 기프트카드 받아가세요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=91528"
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/91528/unboxing_kakao.jpg"
%>
<style type="text/css">
    .evt91528 {background-color:#ff494b;}
    .evt91528 button {background:none; outline:none}
    .evt91528 .inner {position:relative; width:1140px; margin:0 auto;}
    .evt91528 .topic {position:relative; padding-top:50px; background:url(http://webimage.10x10.co.kr/fixevent/event/2019/91528/bg_top.png) 50% 0 repeat-x;}
    .evt91528 .topic dt {position:absolute; left: 50%; top: 133px; margin-left: 80px;}
    .evt91528 .topic dt img{animation: ev2_05 cubic-bezier(0.175, 0.885, 0.32, 1.275) 5s 1.0s both 20;}
    .evt91528 .topic dd {position:absolute; left: 50%; top: 246px; margin-left: -11px;}
    .evt91528 .unbox-guide {padding-top:110px; background:url(http://webimage.10x10.co.kr/fixevent/event/2019/91528/bg_guide.png) #b55dff 50% 0 repeat-x;}
    .evt91528 .unbox-guide {padding-bottom:90px;}
    .evt91528 .unbox-guide h3 {margin:180px auto 50px;}
    .evt91528 .unbox-guide div input {width:645px; height:75px; border:8px solid #fff; margin-right:40px; padding:0 30px; background-color:#dfb8ff; font-family: 'applegothic','malgun Gothic','맑은고딕',sans-serif; font-size:20pt; color:#2e2054;}
    .evt91528 .unbox-guide div input::-webkit-input-placeholder {color: #2e2054;} 
    .evt91528 .unbox-guide div button {display:inline-block; vertical-align:top;} 
    .evt91528 .unbox-guide div p {text-align:left; margin:20px 0 0 100px;}
    .evt91528 .notice {padding:60px 0; background-color:#3b4657;}
    .evt91528 .notice .inner {display:table; }
    .evt91528 .notice p {display:table-cell; width:280px; height:100%; vertical-align:middle; }
    .evt91528 .notice ul {margin-left:10px;}
    .evt91528 .notice li {text-align:left; color:#bfc9d9; line-height:30px;}
    .evt91528 .notice li:before {content:'-';display:inline-block;width:10px;margin-left:-10px;}
    .evt91528 .notice li.bold {color:#fff; font-weight:bold;}
    .evt91528 .unbox-sns {background-color:#5fc99d;}
    .evt91528 .unbox-sns p,
    .evt91528 .unbox-sns a {display:inline-block; line-height:80px; }
    .evt91528 .unbox-sns p {margin-right:25px;}
    .evt91528 .unbox-sns img {vertical-align:middle;}
    .evt91528 .unbox-link {background-color: #ffd265;}
    .evt91528 .layer-popup {display:none; position:absolute; left:0; top:0; z-index:9997; width:100%; height:100%;} 
    .evt91528 .layer-popup .layer {overflow:hidden; position:absolute; left: 50%; top:0; width:500px; min-height: 200px; margin-left : -250px; margin-top: -150px; background:none; z-index:99999;} 
    .evt91528 .layer-popup .layer > div {position: relative;}
    .evt91528 .layer-popup .layer .btn-close{position: absolute; top:0; right: 0;} 
    .evt91528 .layer-popup .mask {display:block; position:absolute; left:0; top:0; z-index:9998; width:100%; height:100%; background:rgba(0,0,0,.5);}
    .evt91528 .layer-popup button {position:absolute; bottom:62px; left:93px;}
    
    @keyframes ev2_05 {
    0% {transform:translateY(100px);}
    13% {transform:translateY(0);}
    30% {transform:translateY(0);}
    34% {transform:translateY(28px);}
    38% {transform:translateY(0);}
    42% {transform:translateY(28px);}
    46% {transform:translateY(0);}
    100% {transform:translateY(0);}
    }
    
</style>
<script type="text/javascript">
    $(function(){
        //텐텐배송상품이란
        var scrollY2 = $('.unbox-guide').offset().top 
        $('.layer-popup#lyrSch2 .layer').css({'top':scrollY2})
        $('#layer2').click(function(){
            $('#lyrSch2').fadeIn();
            $('html,body').animate({scrollTop:scrollY2}, 800);
        })
        //닫기
        $('.layer-popup .btn-close').click(function(e){ 
            $('.layer-popup').fadeOut();
            e.preventDefault()
        }); 
        $('.layer-popup .mask').click(function(){ 
            $('.layer-popup').fadeOut(); 
        });       
    });
</script>
<script type="text/javascript">
function jsEventLogin(){
	if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
function pagedown(){
	window.$('html,body').animate({scrollTop:$("#selArea").offset().top}, 0);
}
function isUrl(url){    
    if((new RegExp(/(\w*\W*)?\w*(\.(\w)+)+(\W\d+)?(\/\w*(\W*\w)*)*/)).test(url)){
        return true;
    }
    return false;
}
function showPopup(){
    var scrollY = $('.unbox-guide h3').offset().top 
    $('.layer-popup#lyrSch .layer').css({'top':scrollY-200})
    $('#lyrSch').fadeIn();
    $('html,body').animate({scrollTop:scrollY-200}, 800);
}
function doAction(mode) {
	var videoLink = document.getElementById('videoLink').value;
	if(mode=='entryEvt'){
		if(videoLink == ""){
			alert('입력한 내용이 없습니다.');
			document.getElementById('videoLink').focus()
			return false;
		}
		if(!isUrl(videoLink)){
			alert('올바른 URL주소를 넣어주세요.');
			return false;
		}        	
	}
	<% if (eventStartDate > currentDate or eventEndDate < currentDate) and GetLoginUserLevel <> "7" then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>				
	<% If LoginUserid <> "" Then %>
		var str = $.ajax({
			type: "post",
			url:"/event/etc/doeventsubscript/doEventSubscript91528.asp",
			data: {
				mode: mode,
                videoLink: videoLink, 
                trackingType: '<%=trackingType%>'
			},
			dataType: "text",
			async: false
		}).responseText;	

		if(!str){alert("시스템 오류입니다."); return false;}

		var reStr = str.split("|");

		if(reStr[0]=="OK"){
			if(reStr[1] == "entry"){	//응모
                showPopup();
			}else if(reStr[1] == "alram"){	//알람신청
				alert("PUSH 알림이 신청되었습니다.\n(푸시 수신은 텐바이텐'앱'이 있는 경우에만 수신 가능)");
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		}else{
			var errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
//			document.location.reload();
			return false;
		}	
	<% else %>
		if ("<%=IsUserLoginOK%>"=="False") {
			jsEventLogin();
		}
	<% End If %>
}
function closePopup(e){
	$('.layer-popup').fadeOut();	
}
function chkLogin(){
	if ("<%=IsUserLoginOK%>"=="False") {
		jsEventLogin();
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
			<div>응모 수: <a href="/event/etc/doeventsubscript/doEventSubscript91528.asp?mode=viewEntryList"><%=cnt%></a></div>			
			<% end if %>
                        <div class="evt91528">
                            <div class="topic">
                                <h2><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/img_top.png" alt="텐텐 언박싱 콘테스트 gift card 총 150만원!" /></h2>
                                <dl>
                                    <dt><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/img_top_ani.png" alt=""></dt>
                                    <dd><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/img_top_box.png" alt=""></dd>
                                </dl>
                            </div>
                            <div class="unbox-guide">
                                <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/img_step_01.png" alt="참여방법 텐바이텐 배송상품을 받은 후, 언박싱 영상 촬영" usemap="#Map1" /></p>
                                <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/img_step_02.png" alt="참가대상 ‘텐바이텐 배송상품’을 주문한 고객 누구나!"></p>
                                <h3><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/tit_url.png" alt="업로드한 영상 URL을 올려주세요! "></h3>
                                <div class="inner">
                                    <input type="text" id="videoLink" placeholder="영상 URL " onclick="chkLogin();" />
                                    <button id="layer1" onclick="doAction('entryEvt')"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/btn_go.png" alt="지원하기"></button>
                                    <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/txt_guide.png" alt="한 ID로 여러 영상 지원 가능합니다. (중복 영상은 불가) "></p>
                                </div>
                            </div>
                            <div class="notice">
                                <div class="inner">
                                    <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/tit_note.png" alt="유의사항"></p>
                                    <ul>
                                        <li class="bold">개인 SNS는 유튜브, 인스타그램, 페이스북, 블로그입니다.</li>
                                        <li>한 ID로 여러 영상 지원 가능합니다. (중복 영상은 불가)</li>
                                        <li>모든 수상작의 저작권을 포함한 일체 권리는 ㈜텐바이텐에 귀속됩니다.</li>
                                        <li>지원기간은 2019년 1월 7일 월요일부터 2019년 1월 31일 목요일 자정까지입니다.</li>
                                        <li>수상자 발표는 2019년 2월 15일 금요일 예정이며, 수상자는 텐바이텐 공지사항에 게재 및 개별 연락드릴 예정입니다. </li>
                                        <li>해시태그를 하지 않았을 경우 혹은 링크 주소가 존재하지 않는 경우 심사가 불가능합니다.</li>
                                        <li>수상자에게는 세무 신고에 필요한 개인 정보를 요청할 수 있으며, 제세공과금은 텐바이텐 부담입니다.</li>
                                        <li>비슷한 응모작이 있을 경우, 최초 응모작만 인정됩니다.</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="unbox-sns">
                                <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/txt_sns.png" alt="텐텐 언박싱 콘테스트 이벤트를 친구에게 공유해주세요!"></p>
                                <a href="javascript:snschk('fb');"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/ico_fb.png" alt="페이스북"></a>
                                <a href="javascript:snschk('tw');"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/ico_tw.png" alt="트위터"></a>
                            </div>
                            <div class="unbox-sns unbox-link">
                                <a href="https://www.youtube.com/channel/UCm_O8oKOLZSWPFH0V4BRSaw"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/btn_link.png?v=1.01" alt="텐바이텐 공식 유튜브 구독하러 가기"></a>
                            </div>
                            <div class="layer-popup" id="lyrSch"> 
                                <div class="layer"> 
                                    <img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/layer_ok.png" alt="알림 신청하고  수상자 발표도 놓치지 마세요! 발표예정일 2019년 2월 15일  ">
                                    <a href="" class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/layer_close.png" alt="닫기"></a>
                                    <button onclick="doAction('regAlram')"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/layer_btn.png" alt="발표 알림 받기"></button>
                                </div> 
                                <div class="mask"></div> 
                            </div>
                            <div class="layer-popup" id="lyrSch2"> 
                                <div class="layer"> 
                                    <img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/layer_ship.png" alt="텐바이텐 배송상품이란? 텐바이텐 물류센터에서 직접 운영하는 배송 서비스입니다. 최적의 상품 상태를 유지하기 위해 체계적으로 꼼꼼하게 관리">
                                    <a href="" class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91528/layer_close.png" alt="닫기"></a>
                                </div> 
                                <div class="mask"></div> 
                            </div>
                            <map name="Map1" id="Map1">
                                <area id="layer2" alt="텐바이텐 배송상품이란?" shape="rect" coords="75,464,256,492" href="#" onfocus="this.blur();"/>
                            </map>
                        </div>			
<!-- #include virtual="/lib/db/dbclose.asp" -->