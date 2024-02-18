<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  언박싱 콘테스트 
' History : 2019-02-12 최종원 
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
	eCode = "90225"		
Else
	eCode = "92388"	
End If

eventStartDate  = cdate("2019-02-13")		'이벤트 시작일
eventEndDate 	= cdate("2019-02-28")		'이벤트 종료일
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

'- 마케팅 띠배너 (W)
'main_mkt
'- 메인롤링 (W)
'main_mainroll
'- 페이스북
'rdsite=mktp

dim trackingType

dim gaparam
dim rdsite

gaparam = request("gaparam")
rdsite  = request("rdsite")

if gaparam <> "" or rdsite <> "" then
    if inStr(gaparam, "main_mkt") then
        trackingType="마케팅 띠배너 (W)"
    elseif inStr(gaparam, "main_mainroll") then
        trackingType="메인롤링 (W)"
    elseif inStr(gaparam, "today_mkt") then
        trackingType="마케팅 띠배너 (M)"    
    elseif inStr(gaparam, "today_mainrol") then    
        trackingType="메인롤링 (M)"        
    elseif inStr(rdsite, "mktp") then            
        trackingType="페이스북"
    end if
end if
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
snpTitle	= Server.URLEncode("택배 뜯을 때의 설렘을 나누자! 텐바이텐 언박싱 영상 찍고 총 150만원의 기프트카드 받아가세요!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre		= Server.URLEncode("텐텐 언박싱 콘테스트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/92388/unboxing_kakao.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[텐텐 언박싱 콘테스트]"
strPageKeyword = "택배 뜯을 때의 설렘을 나누자!"
strPageDesc = "텐바이텐 언박싱 영상 찍고 총 150만원의 기프트카드 받아가세요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/92388/unboxing_kakao.jpg"
%>
<style type="text/css">
    .evt92388 {background-color:#ff6990;}
    .evt92388 button,
    .evt92388 area {background:none; outline:none}
    .evt92388 input:focus::-webkit-input-placeholder {opacity: 0;} 
    .evt92388 .inner {position:relative; width:1140px; margin:0 auto;}
    .evt92388 .topic {position:relative; padding:50px 0 40px; background:linear-gradient(#ff4052,#ff494b) 50% 100% repeat-x;}
    .evt92388 .topic dt {position:absolute; left: 50%; top: 133px; margin-left: 80px;}
    .evt92388 .topic dt img{animation: ev2_05 cubic-bezier(0.175, 0.885, 0.32, 1.275) 5s 1.0s both 20;}
    .evt92388 .topic dd {position:absolute; left: 50%; top: 246px; margin-left: -11px;}
    .evt92388 .unbox-guide {position: relative; padding-bottom: 70px; background: linear-gradient(#ff6e99, #ff6181);}
    .evt92388 .unbox-guide h3 {height: 157px; padding-top: 70px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/92388/bg_guide.jpg); box-sizing: border-box}
    .evt92388 .unbox-guide .vod-area {margin-bottom: 75px;}
    .evt92388 .unbox-guide .vod-area ul {text-align: center;} 
    .evt92388 .unbox-guide .vod-area ul li {display: inline-block; margin:0 3px; }
    .evt92388 .unbox-guide .vod-area ul li a {display: block; width: 158px; height: 54px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/92388/btn_tab.png); text-indent: -9999px;}
    .evt92388 .unbox-guide .vod-area ul li.tab2 a {background-position-x: -168px;}
    .evt92388 .unbox-guide .vod-area ul li.tab3 a {background-position-x: -336px;}
    .evt92388 .unbox-guide .vod-area ul li.on a {background-position-y: bottom;}
    .evt92388 .unbox-guide .vod-area ol li {display: none;}
    .evt92388 .unbox-guide .vod-area ol li.on {display: block;}
    .evt92388 .unbox-guide .vod-area ol li span {display: inline-block; border-radius: 20px; background-color: #fff; box-shadow: 3px 3px 1px #961d3896;  border: 14px solid #fff;} 
    .evt92388 .unbox-guide .vod-area ol li span iframe {width: 875px; height: 482px;}
    .evt92388 .unbox-guide .guide {position: relative;}
    .evt92388 .unbox-guide .guide a {position: absolute; display: block; top:205px; left: 50%; width: 180px; height: 35px; margin-left: -455px; text-indent: -9999px;}
    .evt92388 .unbox-url {background: url(//webimage.10x10.co.kr/fixevent/event/2019/92388/bg_url.jpg) repeat-x #b55dff; padding-bottom: 90px;}
    .evt92388 .unbox-url h3 {margin-bottom:50px; padding-top: 115px;}
    .evt92388 .unbox-url input {width:645px; height:75px; border:8px solid #fff; margin-right:40px; padding:0 30px; background-color:#dfb8ff; font-family: 'applegothic','malgun Gothic','맑은고딕',sans-serif; font-size:20pt; color:#2e2054;}
    .evt92388 .unbox-url input::-webkit-input-placeholder {color: #2e2054;} 
    .evt92388 .unbox-url button {vertical-align: top;}
    .evt92388 .unbox-url p {margin-top: 18px; margin-left: -546px;}
    .evt92388 .unbox-sns {position: relative; background-color: #5fc89d;}
    .evt92388 .unbox-sns a {position: absolute; top: 0; height: 100%; width: 65px; text-indent: -9999px;}
    .evt92388 .unbox-sns a.fb {margin-left: 200px;}
    .evt92388 .unbox-sns a.tw {margin-left: 265px;}
    .evt92388 .unbox-youtube {background-color: #ffd165;}
    .evt92388 .notice {padding:60px 0; background-color:#3b4657;}
    .evt92388 .notice .inner {position:relative; display:table; width:1140px; margin:0 auto;}
    .evt92388 .notice p {display:table-cell; width:280px; height:100%; vertical-align:middle; color: #fff963; font-weight: bold; font-size: 18px; font-family: 'applegothic','malgun Gothic','맑은고딕',sans-serif; }
    .evt92388 .notice ul {margin-left:10px;}
    .evt92388 .notice li {text-align:left; color:#bfc9d9; line-height:30px;}
    .evt92388 .notice li:before {content:'-';display:inline-block;width:10px;margin-left:-10px;}
    .evt92388 .notice li.bold {color:#fff; font-weight:bold;}
    .evt92388 .layer-popup {display:none; position:absolute; left:0; top:0; z-index:9997; width:100%; height:100%;} 
    .evt92388 .layer-popup .layer {overflow:hidden; position:fixed; left: 50%; top:10%; width: 500px; margin-left: -250px; z-index:99999; border-radius: 5px } 
    .evt92388 .layer-popup .layer > div {position: relative;}
    .evt92388 .layer-popup .layer .btn-close{position: absolute; top:0; right: 0; background:none;} 
    .evt92388 .layer-popup .mask {display: block; width: 100%; height: 100%; background-color: #00000075;}
    .evt92388 .layer-popup#submit .layer {height: 680px; background-color: #fff;}
    .evt92388 .layer-popup#submit button {position: absolute; bottom: 55px; margin-left: -156px;}
    .evt92388 .bnr-floationg {position:fixed; right:50%; bottom:234px; z-index:1001; width:180px; margin-right:-672px;}
    .evt92388 .bnr-floationg a {display:block;}
    .evt92388 .bnr-floationg button {position: relative; display:block; margin:10px auto 0; background:transparent; outline:0; color: #fff; font-size: 11px; opacity: .8;}
    .evt92388 .bnr-floationg button em {font-size: 15px; vertical-align: -1px;}
    .evt92388 .bnr-floationg button:after {position: absolute; bottom: 1px; left: 0; height: 1px; width: 100%; background-color: #fff; content: '';}
    .evt92388 .bnr-floationg img {vertical-align:top;}
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
        //탭
        $('.vod-area ul li').click(function(e){
            var i=$(this).index();
            $('.vod-area ul li').eq(i).addClass('on').siblings().removeClass('on')
	        $('.vod-area ol li').eq(i).addClass('on').siblings().removeClass('on')
            e.preventDefault();
        })
        //레이어팝업
        $('.btn-layer').click(function(e) {
            $(this.hash).fadeIn();
            e.preventDefault();
        });
        $('.layer-popup .btn-close,.layer-popup .mask').click(function(e){
            $('.layer-popup').fadeOut();
            e.preventDefault();
        });
    });
</script>
<script type="text/javascript">
function setCookieTempBanner(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays*24*60*60*1000));
	var expires = "expires="+d.toUTCString();
	document.cookie = cname + "=" + cvalue + "; " + expires;
}
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
    $('#submit').fadeIn();
}
function doAction(mode) {    
	var videoLink = document.getElementById('videoLink').value;
	<% if (eventStartDate > currentDate or eventEndDate < currentDate) and GetLoginUserLevel <> "7" then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>				
	<% If LoginUserid <> "" Then %>
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
		var str = $.ajax({
			type: "post",
			url:"/event/etc/doeventsubscript/doUnboxingEventSubscript.asp",
			data: {
				mode: mode,
                videoLink: videoLink, 
                trackingType: '<%=trackingType%>',
                eCode: '<%=eCode%>'
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
				alert("PUSH 알림이 신청되었습니다.\n텐바이텐 앱에서 'PUSH 수신 동의'를 해주세요");
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
			<div>응모 수: <a href="/event/etc/doeventsubscript/doUnboxingEventSubscript.asp?mode=viewEntryList&eCode=<%=eCode%>"><%=cnt%></a></div>			
			<% end if %>
                        <div class="evt92388">
                            <div class="topic">
                               <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/92388/img_top.png" alt="제2회 텐텐언박싱"></h2>
                               <dl>
                                    <dt><img src="//webimage.10x10.co.kr/fixevent/event/2019/92388/img_top_ani.png" alt=""></dt>
                                    <dd><img src="//webimage.10x10.co.kr/fixevent/event/2019/92388/img_top_box.png" alt=""></dd>
                                </dl>
                            </div>				
				            <% If Trim(request.Cookies("unboxingEvtFloatingBnr"))="" Then %>                
                            <div class="bnr-floationg" id="unboxingEvtFloatingBnr">
                                <a href="https://www.youtube.com/channel/UCm_O8oKOLZSWPFH0V4BRSaw" onclick="fnAmplitudeEventMultiPropertiesAction('click_evt_92388_youtube_btn','','')"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92388/bnr_youtube.png" alt="텐바이텐 공식 유튜브 구독하러 가기"></a>
                                <button type="button" onclick="setCookieTempBanner('unboxingEvtFloatingBnr','Y',3);$('#unboxingEvtFloatingBnr').hide();return false;">오늘 그만보기 <em>&#215;</em></button>                                
                            </div>
                            <% End If %>

                            <div class="unbox-guide">
                                <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/92388/tit_winner.png" alt="제1회 콘테스트 수상작"></h3>
                                <div class="vod-area">
                                    <ul>
                                        <li class="tab1 on"><a href="#">top1</a></li>
                                        <li class="tab2"><a href="#">top2</a></li>
                                        <li class="tab3"><a href="#">top3</a></li>
                                    </ul>
                                    <ol>
                                        <li class="on"><span><iframe src="https://www.youtube.com/embed/4LC8Decq6oU" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe></span></li>
                                        <li><span><iframe src="https://www.youtube.com/embed/0livqhigkyY" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe></span></li>
                                        <li><span><iframe src="https://www.youtube.com/embed/AO4WHabPnGs" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe></span></li>
                                    </ol>
                                </div>
                                <div class="guide">
                                    <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/92388/txt_guide.png" alt="참여방법"></p>
                                    <a href="#ship-guide" class="btn-layer">텐바이텐 배송상품이란?</a>
                                </div>
                            </div>
                            <div class="unbox-url">
                                <h3><img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/tit_url.png" alt="업로드한 영상 URL을 올려주세요! "></h3>
                                <div>
                                    <input type="text" id="videoLink" placeholder="영상 URL " onclick="chkLogin();" />
                                    <a href="javascript:void(0)" onclick="doAction('entryEvt')" class="btn-layer"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/btn_go.jpg" alt="지원하기"></a>
                                </div>
                                <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/txt_url.jpg" alt="한 ID로 여러 영상 지원 가능합니다. (중복 영상은 불가) "></p>
                            </div>
                            <div class="notice">
                                <div class="inner">
                                    <p>유의사항</p>
                                    <ul>
                                        <li class="bold">개인 SNS는 유튜브, 인스타그램, 페이스북, 블로그입니다.</li>
                                        <li>한 ID로 여러 영상 지원 가능합니다. (중복 영상은 불가)</li>
                                        <li>모든 수상작의 저작권을 포함한 일체 권리는 ㈜텐바이텐에 귀속됩니다.</li>
                                        <li>지원기간은 2019년 2월 13일 수요일부터 2019년 2월 28일 목요일 자정까지입니다.</li>
                                        <li>수상자 발표는 2019년 3월 5일 화요일 예정이며, 수상자는 텐바이텐 공지사항에 기재 및 개별 연락드릴 예정입니다.</li>
                                        <li>해시태그를 하지 않았을 경우 혹은 링크 주소가 존재하지 않는 경우 심사가 불가능합니다.</li>
                                        <li>수상자에게는 세무 신고에 필요한 개인 정보를 요청할 수 있으며, 제세공과금은 텐바이텐 부담입니다.</li>
                                        <li>비슷한 응모작이 있을 경우, 최초 응모작만 인정됩니다.</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="unbox-sns">
                                <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/btn_sns.jpg" alt="텐텐 언박싱 콘테스트 이벤트를 친구에게 공유해주세요!"></p>
                                <div>
                                    <a class="fb" href="javascript:snschk('fb');">페이스북</a>
                                    <a class="tw" href="javascript:snschk('tw');">트위터</a>
                                </div>
                            </div>
                            <div class="unbox-youtube">
                                <a href="https://www.youtube.com/channel/UCm_O8oKOLZSWPFH0V4BRSaw" onclick="fnAmplitudeEventMultiPropertiesAction('click_evt_92388_youtube_btn','','')"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/btn_link.jpg" alt="텐바이텐 공식 유튜브 구독하러 가기"></a>
                            </div>
                            <!-- 텐바이텐 배송상품이란? 레이어팝업 -->
                            <div class="layer-popup" id="ship-guide"> 
                                <div class="layer"> 
                                    <img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/layer_ship.jpg" alt="텐바이텐 배송상품이란? 텐바이텐 물류센터에서 직접 운영하는 배송 서비스입니다. 최적의 상품 상태를 유지하기 위해 체계적으로 꼼꼼하게 관리">
                                    <a href="" class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/layer_close.png" alt="닫기"></a>
                                </div> 
                                <div class="mask"></div> 
                            </div>
                            <!--지원완료 레이어팝업 -->
                            <div class="layer-popup" id="submit"> 
                                <div class="layer"> 
                                    <img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/layer_ok.jpg" alt="지원완료">
                                    <button onclick="doAction('regAlram')"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/layer_btn.jpg" alt="발표 알림 받기"></button>
                                    <a href="" class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/92388/layer_close.png" alt="닫기"></a>
                                </div> 
                                <div class="mask"></div> 
                            </div>
                        </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->