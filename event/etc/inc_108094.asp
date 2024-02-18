<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : #즐겨찾기_서촌 01 텐바이텐X서촌도감
' History : 2020-12-29 정태훈
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/event/RealtimeEventCls.asp" -->
<%
dim eCode, LoginUserid, pwdEvent
IF application("Svr_Info") = "Dev" THEN
	eCode = "104288"
Else
	eCode = "108094"
End If

dim eventEndDate, currentDate, eventStartDate
dim subscriptcount, totalsubscriptcount, mileage
dim currentcnt

eventStartDate  = cdate("2021-02-24")		'이벤트 시작일
eventEndDate 	= cdate("2021-03-09")		'이벤트 종료일
currentDate 	= date()
LoginUserid		= getencLoginUserid()

if LoginUserid="ley330" or LoginUserid="greenteenz" or LoginUserid="rnldusgpfla" or LoginUserid="cjw0515" or LoginUserid="thensi7" or LoginUserid = "motions" or LoginUserid = "jj999a" or LoginUserid = "phsman1" or LoginUserid = "jjia94" or LoginUserid = "seojb1983" or LoginUserid = "kny9480" or LoginUserid = "bestksy0527" or LoginUserid = "mame234" or LoginUserid = "corpse2" or LoginUserid = "bora2116" then
	currentDate = #01/06/2021 09:00:00#
end if

dim isSecondTried
dim isFirstTried
dim triedNum : triedNum = 0
dim isShared : isShared = False
isSecondTried = false

if LoginUserid <> "" then
	set pwdEvent = new RealtimeEventCls
	pwdEvent.evtCode = eCode
	pwdEvent.userid = LoginUserid
	isSecondTried = pwdEvent.isParticipationDayBase(2)
	isFirstTried = pwdEvent.isParticipationDayBase(1)
	isShared = pwdEvent.isSnsShared
end if

triedNum = chkIIF(isFirstTried, 1, 0)
triedNum = chkIIF(isSecondTried, 2, triedNum)

'// SNS 공유용
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpImg, appfblink

snpTitle	= Server.URLEncode("[텐바이텐X서촌도감]")
snpLink		= Server.URLEncode("http://m.10x10.co.kr/event/eventmain.asp?eventid="& eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2020/108094/m/img_kakao.jpg")
appfblink	= "http://m.10x10.co.kr/event/eventmain.asp?eventid="& eCode 

'// 카카오링크 변수
Dim kakaotitle : kakaotitle = "[텐바이텐X서촌도감]"
Dim kakaodescription : kakaodescription = "서촌도감 구경하며 퀴즈도 풀고 상품도 받아가세요!"
Dim kakaooldver : kakaooldver = "서촌도감 구경하며 퀴즈도 풀고 상품도 받아가세요!"
Dim kakaoimage : kakaoimage = "http://webimage.10x10.co.kr/fixevent/event/2020/108094/m/img_kakao.jpg"
Dim kakaoAppLink, kakaoMobileLink, kakaoWebLink 
kakaoAppLink 	= "http://m.10x10.co.kr/apps/appcom/wish/web2014/event/eventmain.asp?eventid="& eCode
kakaoMobileLink = "http://m.10x10.co.kr/event/eventmain.asp?eventid="& eCode
kakaoWebLink = "http://www.10x10.co.kr/event/eventmain.asp?eventid="& eCode
%>
<style type="text/css">
    .evt108094 {background:#fff;}
    .evt108094 .txt-hidden {text-indent: -9999px; font-size:0;}
    .evt108094 .navi-area {display:flex; align-items:center; justify-content:space-between; width:1140px; margin:0 auto;}
    .evt108094 .navi-wrap {width:300px;}
    .evt108094 .navi-container .swiper-slide .txt {width:64px; height:32px; margin:0 10px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/txt_soon.png) no-repeat 0 0; background-size:100%;}
    .evt108094 .navi-container .swiper-slide a {margin:0 10px; font-size:18px; color:#222; font-weight:700;}
    .evt108094 .navi-container .swiper-wrapper {display:flex; align-items:center; justify-content:center; height:120px; margin:0 auto;}
    .evt108094 .navi-container .swiper-button-prev {position:absolute; left:0; top:50%; transform: translate(0,-50%); width:2rem; height:100%; background:#fff url(//webimage.10x10.co.kr/fixevent/event/2020/108094/m/icon_left.png) no-repeat 0 50%; background-size:6px 13px;}
    .evt108094 .navi-container .swiper-button-next {position:absolute; right:0; top:50%; transform: translate(0,-50%); width:2rem; height:100%; background:#fff url(//webimage.10x10.co.kr/fixevent/event/2020/108094/m/icon_right.png) no-repeat right 50%; background-size:6px 13px;}
    .evt108094 .topic {position:relative; width:100%; height:1313px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/img_tit.jpg) no-repeat 50% 0;}
    .evt108094 .topic .iocn-arrow {position:absolute; left:50%; bottom:280px; transform:translate(-50%,0); animation: updown .7s ease-in-out alternate infinite;}
    .evt108094 .pagination {position:absolute; right:2rem; bottom:6%; z-index:100;}
    .evt108094 .pagination .swiper-pagination-switch.swiper-active-switch {background-color:#ec4a18;}
    .evt108094 .pagination .swiper-pagination-switch {display:inline-block; width:12px; height:12px; margin:0 0.5rem; background-color:#ededed; border-radius:100%;}
    .evt108094 .flex {display:flex;}
    .evt108094 .section-01 .half,
    .evt108094 .section-02 .half,
    .evt108094 .section-03 .half,
    .evt108094 .section-04 .half {width:50%;} 
    .evt108094 .section-02 .animate-txt {text-align:right; padding:117px 50px 0 0;}
    .evt108094 .section-04 .animate-txt {text-align:right; padding:210px 50px 0 0;}
    .evt108094 .section-01 .swiper-wrapper,
    .evt108094 .section-03 .swiper-wrapper,
    .evt108094 .section-08 .swiper-wrapper {display:flex; align-items:center; height: 100% !important;}
    .evt108094 .swiper-container {height:100%;}
    .evt108094 .swiper-container .swiper-slide {height:100% !important;}
    .evt108094 .section-01 .slide-area,
    .evt108094 .section-03 .slide-area {width:50%; position:relative;}
    .evt108094 .section-08 .slide-area {width:580px; position:relative;}
    .evt108094 .section-06 {position:relative; width:100%; height:979px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/img_benefit.jpg) no-repeat 50% 0;}
    .evt108094 .section-06 .btn-detail {width:250px; height:100px; position:absolute; left:50%; top:770px; transform: translate(-195%,0); background:transparent;}
    .evt108094 .section-07 {width:100%; height:217px; display:flex; align-items:center; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/img_insta.jpg) no-repeat 50% 0;}
    .evt108094 .section-07 a {display:inline-block; width:100%; height:100%;}
    .evt108094 .section-08 {justify-content:center; padding:0 0 104px 0; background-color:#f2eeeb;}
    .evt108094 .section-08 .slide-area,
    .evt108094 .section-08 .sns-txt {box-shadow: 0px 19px 27px 0px rgba(75, 75, 75, 0.2);}
    .evt108094 .section-05 {padding-bottom:150px; background: #da5745;}
    .evt108094 .section-05 .tit {position:relative; width:100%; height:1442px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/img_quiz_tit.jpg) no-repeat 50% 0;}
    .evt108094 .section-05 .tit .btn-detail {width:660px; height:100px; position:absolute; left:50%; bottom:340px; transform: translate(-50%,0); background:transparent;}
    .evt108094 .section-05 .quiz-container {display:flex; align-items:center; justify-content:space-between; width:1140px; margin:0 auto;}
    .evt108094 .section-05 .quiz-container .quiz-contents {position:relative;}
    .evt108094 .section-05 .quiz-container .quiz-contents .view-list div {position:absolute; left:50%; top:30px; transform:translate(-50%,0);}
    .evt108094 .section-05 .view-example {position:relative; width:604px; height:215px; margin:0 auto; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/img_view_item.png) no-repeat 50% 0;}
    .evt108094 .section-05 .view-example .btn-list {display:flex; align-items:center; position:absolute; left:170px; top:30px;}
    .evt108094 .section-05 .view-example .btn-list button {margin:0 11px; background:transparent;}
    .evt108094 .section-05 .view-example .icon-click {position:absolute; left:9%; top:130px; animation:swing .7s ease-in-out alternate infinite;}
    .evt108094 .section-05 .btn-apply {display:block; margin:24px auto 0; background:transparent;}
    .evt108094 .section-05 .btn-re {display:block; margin:-15px auto; background:transparent;}
    .evt108094 .section-09 {width:100%; height:1756px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/img_noti.jpg) no-repeat 50% 0;}
    .evt108094 .sub-tit02 {width:100%; height:176px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/img_sub_tit.jpg) no-repeat 50% 0;}
    .evt108094 .animate-txt {opacity:0; transform:translateY(10%); transition:all 1s;}
    .evt108094 .animate-txt.on {opacity:1; transform:translateY(0);}
    .evt108094 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
    .evt108094 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
    .evt108094 .pop-container .pop-inner a {display:inline-block;}
    .evt108094 .pop-container .pop-inner .btn-close {position:absolute; right:28px; top:28px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
    .evt108094 .pop-container.detail .contents-inner,
    .evt108094 .pop-container.win .contents-inner,
    .evt108094 .pop-container.fail .contents-inner {position:relative; width:670px; margin:0 auto;}
    .evt108094 .pop-container.fail .btn-review {width:670px; height:200px; position: absolute; left:0; bottom:0; background:transparent;}
    .evt108094 .pop-container.review {z-index:160;}
    .evt108094 .pop-container.review .contents-inner {position:relative; display:flex; align-items:center; justify-content:space-between; width:1140px; margin:0 auto;}
    .evt108094 .pop-container.review .contents-inner .quiz-review {position:relative;}
    .evt108094 .pop-container.review .contents-inner .quiz-review .view-list div {position:absolute; left:50%; top:30px; transform: translate(-50%,0);}
    .evt108094 .pop-container.review .contents-inner .quiz-review .win {position:absolute; left:50%; top:48px; transform: translate(-50%,0);}
    .evt108094 .pop-container.review .contents-inner .quiz-review .fail {position:absolute; left:50%; top:60px; transform: translate(-50%,0);}
    .evt108094 .pop-container.review .btn-share {margin-top:30px; background:transparent;}
    .evt108094 .pop-container.review .btn-close {top:-50px; right:0; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_close02.png) no-repeat 0 0; background-size:100%;}
    @keyframes updown {
        0% {bottom:270px;}
        100% {bottom:290px;}
    }
    @keyframes swing {
        0% {left:7%;}
        100% {left:11%;}
    }
</style>
<script>
    $(function() {
        /* 자세히보기 팝업 */
        $('.evt108094 .btn-detail').click(function(){
            $('.pop-container.detail').fadeIn();
        })
        /* 틀린문제 다시보기 팝업 */
        $('.evt108094 .btn-review').click(function(){
            $('.pop-container.review').fadeIn();
            var myswiper = new Swiper(".slide-review .swiper-container", {
            speed: 500,
            slidesPerView:'auto',
            pagination:".slide-review .pagination",
            loop:true
            });
        })
        /* 팝업 닫기 */
        $('.evt108094 .btn-close').click(function(){
            $(".pop-container").fadeOut();
        })
        /* slide */
        var swiper = new Swiper(".section-01 .swiper-container", {
            autoplay: 1,
            speed: 2000,
            slidesPerView:1,
            pagination:".section-01 .pagination",
            loop:true
        });
        var swiper = new Swiper(".section-03 .swiper-container", {
            autoplay: 1,
            speed: 2000,
            slidesPerView:1,
            pagination:".section-03 .pagination",
            loop:true
        });
        var swiper = new Swiper(".section-08 .swiper-container", {
            autoplay: 1,
            speed: 2000,
            slidesPerView:1,
            pagination:".section-08 .pagination",
            loop:true
        });
        /* 글자,이미지 스르륵 모션 */
        $(window).scroll(function(){
            $('.animate-txt').each(function(){
            var y = $(window).scrollTop() + $(window).height() * 1;
            var imgTop = $(this).offset().top;
            if(y > imgTop) {
                $(this).addClass('on');
            }
            });
        });
    });

    var numOfTry = '<%=triedNum%>';
    var isShared = "<%=isShared%>";
    var _ReplyNum=1;
    function fnReplySet(num){
        var tmpEl=tmpEl2="";
        var $rootEl=$("#reply"+_ReplyNum);
        var $rootEl2=$("#scoring"+_ReplyNum);

	    $rootEl.empty();
        if(num==1){
            tmpEl='<div class="list02"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply02.png" alt="오수 이끼 초록 코스터"></div>';
            tmpEl2='<div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_re_apply01.png" alt="오수 이끼 초록 코스터"></div>';
        }else if(num==2){
            tmpEl='<div class="list03"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply03.png" alt="허스키 텀블러"></div>';
            tmpEl2='<div class="list02"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_re_apply02.png" alt="허스키 텀블러"></div>';
        }else if(num==3){
            tmpEl='<div class="list04"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply04.png" alt="오선주 오일 버너"></div>';
            tmpEl2='<div class="list03"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_re_apply03.png" alt="오선주 오일 버너"></div>';
        }
        $rootEl.append(tmpEl);
        $rootEl2.append(tmpEl2);
        $("#replybtn"+num).hide();
        $("#a"+_ReplyNum).val(num);
        if(_ReplyNum<3){
            _ReplyNum++;
        }
    }

    function doAction() {
        <% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
            alert("이벤트 참여기간이 아닙니다.");
            return false;
        <% end if %>
        <% If IsUserLoginOK() Then %>
            if($("#a1").val()==""||$("#a2").val()==""||$("#a3").val()==""){
                alert("보기 선택 후 진행해주세요.");
                return false;
            }
            var returnCode, itemid, data
            var data={
                mode: "add",
                a1: $("#a1").val(),
                a2: $("#a2").val(),
                a3: $("#a3").val()
            }
            $.ajax({
                type:"POST",
                url:"/event/etc/doeventSubscript108094.asp",
                data: data,
                dataType: "JSON",
                success : function(res){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode|option1','<%=eCode%>|' + $("#a1").val()+$("#a2").val()+$("#a3").val())
                        if(res!="") {
                            // console.log(res)
                            if(res.response == "ok"){
                                popResult(res.returnCode, res.answer1, res.answer2, res.answer3);
                                return false;
                            }else{
                                alert(res.faildesc);
                                return false;
                            }
                        } else {
                            alert("잘못된 접근 입니다.1");
                            document.location.reload();
                            return false;
                        }
                },
                error:function(err){
                    console.log(err)
                    alert("잘못된 접근 입니다.2");
                    return false;
                }
            });
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

    function popResult(returnCode, answer1, answer2, answer3){
        if(returnCode[0] == "A"){
            numOfTry++;
            $("#fail").show();
            if(answer1=="O"){
                $("#winfail1").empty().append('<img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_win.png" alt="문제 맞춤">');
            }
            else{
                $("#winfail1").empty().append('<img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_fail.png" alt="문제 틀림">');
            }
            if(answer2=="O"){
                $("#winfail2").empty().append('<img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_win.png" alt="문제 맞춤">');
            }
            else{
                $("#winfail2").empty().append('<img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_fail.png" alt="문제 틀림">');
            }
            if(answer3=="O"){
                $("#winfail3").empty().append('<img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_win.png" alt="문제 맞춤">');
            }
            else{
                $("#winfail3").empty().append('<img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_fail.png" alt="문제 틀림">');
            }
        }else if(returnCode[0] == "R"){
            numOfTry++;
            $("#win").show();
        }
    }

    function snschk(snsnum) {
		$.ajax({
			type: "GET",
			url:"/event/etc/doeventSubscript108094.asp",
			data: "mode=snschk&snsnum="+snsnum,
			dataType: "JSON",
			success: function(res){
                isShared = "True"
                if(snsnum == "tw") {
                    popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>');
                }else if(snsnum=="fb"){
                    popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
                }else if(snsnum=="pt"){
                    pinit('<%=snpLink%>','<%=snpImg%>');
                }
                $("#reply1").empty().append('<div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply01.png" alt="디폴트"></div>');
                $("#reply2").empty().append('<div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply01.png" alt="디폴트"></div>');
                $("#reply3").empty().append('<div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply01.png" alt="디폴트"></div>');
                $("#replybtn1").show();
                $("#replybtn2").show();
                $("#replybtn3").show();
                $("#a1").val("");
                $("#a2").val("");
                $("#a3").val("");
                _ReplyNum=1;
			},
			error: function(err){
				alert('잘못된 접근입니다.')
			}
		})
    }

    function fnQAReset(){
        $("#reply1").empty().append('<div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply01.png" alt="디폴트"></div>');
        $("#reply2").empty().append('<div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply01.png" alt="디폴트"></div>');
        $("#reply3").empty().append('<div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply01.png" alt="디폴트"></div>');
        $("#replybtn1").show();
        $("#replybtn2").show();
        $("#replybtn3").show();
        $("#a1").val("");
        $("#a2").val("");
        $("#a3").val("");
        _ReplyNum=1;
    }
</script>
<style type="text/css">
.hobby iframe {display:block; width:100%;}
</style>
<div class="hobby">
    <iframe id="" src="/event/etc/group/iframe_favorites.asp?eventid=108094" width="300" height="120" frameborder="0" scrolling="no" title="서촌도감"></iframe>
</div>
                <div class="evt108094">
                    <div class="topic">
                        <p class="txt-hidden">텐바이텐X서촌도감</p>
                        <span class="iocn-arrow"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_arrow_down.png" alt="arrow"></span>
                    </div>
                    <div class="section-01 flex">
                        <div class="slide-area">
                            <div class="swiper-container">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_slide1_01.png" alt="slide01">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_slide1_02.png" alt="slide02">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_slide1_03.png" alt="slide03">
                                    </div>
                                </div>
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_sub01.jpg" alt="서촌도감은 지속 가능한 생활 양식을 전하는 곳 이에요.">
                        </div>
                    </div>
                    <div class="section-02 flex">
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_su02.png" alt="‘후대에 전할 만한 좋은 습관과 양식’을 뜻하는 미풍양속과 공생을 컨셉을 갖고 있어요. 다실 및 전시 공간에는 다양한 작가들의 친환경 상품과 지역 작가와의 협업 전시가 큐레이션 되어있습니다.">
                        </div>
                        <div class="half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_thum01.png" alt="img">
                        </div>
                    </div>
                    <div class="section-03 flex">
                        <div class="slide-area">
                            <div class="swiper-container">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_slide2_01.png" alt="slide01">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_slide2_02.png" alt="slide02">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_slide2_03.png" alt="slide03">
                                    </div>
                                </div>
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_sub03.jpg" alt="전시된 친환경 상품 옆에는 마치 도감을 읽는 듯한 친절한 코멘트를 찾아보는 재미도 있답니다.">
                        </div>
                    </div>
                    <div class="section-04 flex">
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_su04.png" alt="여러분도 자연의 향과 소리가 느껴지는 서촌도감에서 제로웨이스트를 시작해보세요.">
                        </div>
                        <div class="half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_thum02.png" alt="img">
                        </div>
                    </div>
                    <div class="section-09">
                        <p class="txt-hidden">서촌도감에 대해 더 알아보기</p>
                    </div>
                    <div class="section-06">
                        <button type="button" class="btn-detail"></button>
                    </div>
                    <div class="section-05">
                        <div class="tit txt-hidden">서촌도감을 완성해주세요. 해당 설명에 맞는 설명을 골라 보세요.
                            <button type="button" class="btn-detail"></button>
                        </div>
                        <div class="quiz-container">
                            <!-- 첫 번째 문제 -->
                            <div class="quiz-contents">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_card01.jpg" alt="첫 번째 문제 이미지">
                                <div class="view-list" id="reply1">
                                    <div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply01.png" alt="디폴트"></div>
                                </div>
                            </div>
                            <!-- 두 번째 문제 -->
                            <div class="quiz-contents">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_card02.jpg" alt="두 번째 문제 이미지">
                                <div class="view-list" id="reply2">
                                    <div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply01.png" alt="디폴트"></div>
                                </div>
                            </div>
                            <!-- 세 번째 문제 -->
                            <div class="quiz-contents">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_card03.jpg" alt="세 번째 문제 이미지">
                                <div class="view-list" id="reply3">
                                    <div class="list01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_apply01.png" alt="디폴트"></div>
                                </div>
                            </div>
                        </div>
                        <div class="view-example">
                            <div class="btn-list">
                                <button type="button" onClick="fnReplySet(1)" id="replybtn1"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_item01.png" alt="오수 아끼 초록 코스터"></button>
                                <button type="button" onClick="fnReplySet(2)" id="replybtn2"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_item02.png" alt="허스키 텀블러"></button>
                                <button type="button" onClick="fnReplySet(3)" id="replybtn3"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_item03.png" alt="오선주 오일 버너"></button>
                            </div>
                            <div class="icon-click"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_click.png" alt="click"></div>
                        </div>
                        <input type="hidden" name="a1" id="a1">
                        <input type="hidden" name="a2" id="a2">
                        <input type="hidden" name="a3" id="a3">
                        <button type="button" class="btn-apply" onClick="doAction();"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_btn_apply.png" alt="정답 제출 하기"></button>
                        <!-- 2021-01-25 다시 풀기 버튼 추가 -->
                        <button type="button" class="btn-re" onClick="fnQAReset();"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_btn_re.png" alt="다시 풀기"></button>
                        <!-- 틀린문제 다시보기 팝업 -->
                        <div class="pop-container review">
                            <div class="pop-inner">
                                <div class="pop-contents">
                                    <div class="contents-inner">
                                        <div class="quiz-review">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_re_card01.png" alt="slide01">
                                            <div class="view-list" id="scoring1"></div>
                                            <div class="win" id="winfail1"></div>
                                        </div>
                                        <div class="quiz-review">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_re_card02.png" alt="slide02">
                                            <div class="view-list" id="scoring2"></div>
                                            <div class="win" id="winfail2"></div>
                                        </div>
                                        <div class="quiz-review">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_re_card03.png" alt="slide03">
                                            <div class="view-list" id="scoring3"></div>
                                            <div class="win" id="winfail3"></div>
                                        </div>
                                        <button type="button" class="btn-close">닫기</button>
                                    </div>
                                    <button type="button" class="btn-share" onclick="snschk('fb');return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_share_link.png" alt="링크 공유하기"></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="sub-tit02"></div>
                    <div class="section-08 flex">
                        <div class="slide-area">
                            <div class="swiper-container">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_slide3_01.png" alt="slide01">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_slide3_02.png" alt="slide02">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_slide3_03.png" alt="slide03">
                                    </div>
                                </div>
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <div class="sns-txt"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/img_sns.png" alt="sns 이벤트 알림 : 서촌도감 방문 후, 매장 사진을 찍어 아래 해시태그와 함께 인스타그램에 업로드해주세요!"></div>
                    </div>
                    <div class="section-07">
                        <!-- 인스타그램으로 이동 -->
                        <a href="https://tenten.app.link/5Z9lxU3a6bb" onclick="fnAmplitudeEventMultiPropertiesAction('landing_instagram','evtcode|option1','<%=eCode%>|');" target="_blank"><span class="txt-hidden">서촌도감을 더 알고싶으세요?</span></a>
                        <!-- 즐겨찾길 메인으로 이동 -->
                        <a href="https://tenten.app.link/Cl6bQPapxdb" onclick="fnAmplitudeEventMultiPropertiesAction('landing_bookmark_seochon','evtcode|option1','<%=eCode%>|');" target="_blank"><span class="txt-hidden">텐바이텐 x 서촌 # 즐겨찾길 구경하러 가기</span></a>
                    </div>
                    <div class="pop-container detail">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/pop_detail.png" alt="플랑드비 비건 올라이트 바디솝">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="pop-container win" id="win">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/pop_win_01.png" alt="축하합니다! 서촌도감을 전부 완성하셨습니다. 이벤트 당첨자는 3월 12일, 텐바이텐 공지사항을 통해 발표됩니다.">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="pop-container fail" id="fail">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/pop_fail.png" alt="아쉽지만 오답! 틀린 문제를 확인하고 다시 풀어보세요!">
                                    <button type="button" class="btn-close">닫기</button>
                                    <button type="button" class="btn-review"></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->