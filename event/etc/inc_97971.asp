<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 롯데뮤지엄 스누피 전시 이벤트 
' History : 2019-10-14 원승현 생성
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim oItem
dim evtStartDate, evtEndDate, currentDate, oExhibition
Dim mastercode, listType, bestItemList
dim totalPrice , salePercentString , couponPercentString , totalSalePercent '// 할인율 관련
	currentDate =  date()

    evtStartDate = Cdate("2019-10-14")
    evtEndDate = Cdate("2019-12-31")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90413
    mastercode =  9
Else
	eCode   =  97971
    mastercode =  12
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 6		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 6		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

'// 전체 유저 참여수(unique user)
Dim strSql, uniqueUserCnt
strSql = " SELECT COUNT(DISTINCT userid) as userCnt FROM db_event.dbo.tbl_event_comment WITH(NOLOCK) WHERE evtcom_using='Y' AND evt_code='"&eCode&"' "
rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
uniqueUserCnt = rsget("userCnt")
rsget.close

'// 가운데 상품 리스트
listType = "A"
SET oExhibition = new ExhibitionCls
bestItemList = oExhibition.getItemsListProc( listType, 8, mastercode, "", "1", "" )     '리스트타입, row개수, 마스터코드, 디테일코드, best아이템 구분, 카테고리 정렬 구분 

%>
<style type="text/css">
.evt97971 {background-color:#fff; font-family:'Roboto','Noto Sans KR','malgun Gothic','맑은고딕';}
.evt97971 .top {position:relative; padding-top:704px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/bg_top.jpg); background-repeat:repeat-x; background-position:-100% 0; opacity:0; transition:all 1s;}
.evt97971 .top h2 {position:absolute; top:115px; left:50%; margin-left:-800px; opacity:0; transition:all 1s .3s;}
.evt97971 .top.on {background-position:50% 0; opacity:1;}
.evt97971 .top.on h2 {margin-left:-570px; opacity:1;}
.evt97971 .top .museum {position:relative;}
.evt97971 .top .museum a {display:inline-block; position:absolute; bottom:80px; left:50%; margin-left:-130px; width:300px; height:50px; text-indent:-999em;}
.evt97971 .collabo {background-color:#f9e14d;}

.space-art {overflow:hidden; position:relative; height:1524px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/bg_sky.jpg) repeat 50% 0;}
.space-art:after {width:100%; height:1084px; position:absolute; bottom:0; left:50%; z-index:3; margin-left:-50%; background:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/bg_planet.png) repeat 50% 0; content:' ';}
.space-art h3 {width:452px; margin:0 auto; padding-top:70px; padding-bottom:16px;}
.space-art h3 span {position:relative; z-index:10;}
.space-art h3 .t2 {top:-15px;}
.space-art h3 .t3 {top:-17px;}

.space-art .main-items {position:relative; z-index:5;}
.space-art .main-items span {position:relative; z-index:5;}
.space-art .main-items .main-item1 {right:-25px; z-index:8;}
.space-art .main-items .main-item2 {left:-25px;}
.space-art .main-items .item-name {margin-top:60px;}
.space-art .bg_main-item, .space-art .dc {position:absolute;  left:50%; z-index:5;}
.space-art .bg_main-item {top:400px; margin-left:-248px; z-index:4;}
.space-art .dc1 {top:100px; margin-left:-723px;}
.space-art .dc2 {top:480px; z-index:2; margin-left:-823px;}
.space-art .dc3 {top:287px; margin-left:677px;}
.space-art .dc4 {top:620px; z-index:2; margin-left:-960px; animation:rocketMove 7s infinite linear;}
.space-art .dc5 {top:278px; margin-left:-599px;}
.space-art .dc5 img {display:inline-block; transform:rotate(-10deg);}
.space-art .dc6 {top:379px; margin-left:367px;}
.space-art .dc7 {top:782px; margin-left:-354px;}
@keyframes rocketMove {
    from {transform:translate(0,0)}
    50% {transform:translate(2500px, -900px) rotate(0deg);}
    70% {transform:translate(1500px, -800px) rotate(115deg);}
    90% {transform:translate(1500px, 100px) rotate(115deg);}
   100% {transform:translate(0,0) rotate(200deg);}
}
.character-items {position:relative; z-index:5; margin:85px 0 70px; text-align:left;}
.character-items a {text-decoration:none; color:#000;}
.character-items .slider-horizontal {width:100%; margin:0 auto;}
.character-items .www_FlowSlider_com-branding {display:none !important;}
.character-items .item {width:240px; height:355px; margin:0 10px; font-size:16px; font-weight:bold; color:#000; text-align:center;}
.character-items .item .num {display:inline-block; border-bottom:solid 3px #000;}
.character-items .item .thumbnail {overflow:hidden; width:100%; height:240px; border-radius:50%; margin:10px 0 20px;}

.character-items .item .price {margin-top:8px; color:#000; font-size:16px; line-height:1.1;}
.btn-more {position:relative; z-index:5;}

.flex-inner {display:flex; align-items:center; justify-content:space-between; width:1140px; margin:0 auto;}
.snoopy-night {padding-top:120px; background:#bedce2 url(//webimage.10x10.co.kr/fixevent/event/2019/97971/bg_star.jpg) repeat-x 50% 0;}
.cmt-evt {margin-top:80px;}
.cmt-evt .flex-inner {align-items:flex-start;}
.cmt-evt .inner {position:relative; width:1140px; margin:0 auto; padding:80px 0; background-color:#f7d648;}
.cmt-evt .inner:after, .cmt-evt .inner:before {position:absolute; top:0; height:100%; width:230px; background-color:#f7d648; content:'';}
.cmt-evt .inner:before {left:-230px;}
.cmt-evt .inner:after {right:-230px;}
.cmt-evt .flex-inner p {position:relative; right:-100px; opacity:0; transition:all .8s;}
.cmt-evt.on .flex-inner p {right:0; opacity:1;}

.cmt-evt .select-char {display:flex; justify-content:space-around; width:750px; padding-top:15px;}
.cmt-evt .select-char .char {position:relative; width:117px; height:265px; right:-100px; opacity:0; transition:all .8s .5s;}
.cmt-evt.on .select-char .char {right:0; opacity:1;}
.cmt-evt.on .select-char .char2 {transition-delay:.7s;}
.cmt-evt.on .select-char .char3 {transition-delay:1s;}
.cmt-evt.on .select-char .char4 {transition-delay:1.3s;}
.cmt-evt.on .select-char .char5 {transition-delay:1.6s;}
.cmt-evt .select-char .char input {position:absolute; top:0; left:0; width:0; height:0; visibility:hidden;}
.cmt-evt .select-char .char label {display:flex; flex-direction:column; justify-content:space-between; height:100%; cursor:pointer;}
.cmt-evt .select-char .char label i {display:inline-block; width:100%; height:30px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_select.png?v=1.01)no-repeat 50% 0; content:'';}
.cmt-evt .select-char .char input:checked + label i {background-position:50% 100%;}

.cmt-evt .write-cont {position:relative; width:1140px; height:152px; margin:60px 0 20px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/bg_input.png)no-repeat 0 0;}
.cmt-evt .write-cont .flex-inner {align-items:center;}
.cmt-evt .write-cont input {width:981px; height:152px; padding:0 55px; color:#000; font-size:18px; font-weight:bold; box-sizing:border-box; background-color:transparent;}
.cmt-evt .write-cont input::-webkit-input-placeholder {color:#000;}
.cmt-evt .write-cont input:focus::-webkit-input-placeholder {opacity:0;}
.cmt-evt .write-cont input::-ms-clear {display:none;}
.cmt-evt .caution {text-align:left; color:#806000; font-size:14px;}

.cmt-list {position:relative;}
.cmt-list:before {display:inline-block; position:absolute; top:30px; left:50%; width:31px; height:31px; margin-left:-450px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/bg_star.png); content:'';}
.cmt-list ul {display:flex; justify-content:space-between; flex-wrap:wrap;}
.cmt-list ul li {position:relative; width:564px; height:166px; margin-top:80px; color:#000; background:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/bg_reply.png)no-repeat 50% 100%;}
.cmt-list ul li .info {display:flex; justify-content:space-between; padding-left:180px;}
.cmt-list ul li .info span {display:inline-block; font-size:16px;}
.cmt-list ul li .info .user {font-weight:bold;}
.cmt-list ul li .info .delete {margin-right:10px; background-color:transparent; color:#d90035; font-size:16px; font-weight:bold; font-family:'Roboto','Noto Sans KR','malgun Gothic','맑은고딕';}
.cmt-list ul li .char {position:absolute; top:-55px; left:40px; width:117px; height:200px; background-repeat:no-repeat; background-position:0 0; background-size:auto 100%;}
.cmt-list ul li .char1 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char1.png);}
.cmt-list ul li .char2 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char2.png);}
.cmt-list ul li .char3 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char3.png);}
.cmt-list ul li .char4 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char4.png);}
.cmt-list ul li .char5 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char5.png);}
.cmt-list ul li .conts {display:flex; justify-content:center; align-items:center; height:133px; margin-top:9px; padding-left:180px; padding-right:50px;}
.cmt-list ul li .conts span {overflow:hidden; display:inline-block; width:100%; max-height:80%; text-align:left; font-size:18px; line-height:26px; font-weight:bold; word-break:break-all;}
.cmt-list .paging {height:40px; margin-top:52px;}
.cmt-list .paging a {width:40px; height:40px; margin:0 12.5px; font-weight:bold; font-size:14px; line-height:40px; border:0; background-color:transparent;}
.cmt-list .paging a span {width:40px; height:40px; padding:0; color:#000;}
.cmt-list .paging .arrow {background-color:transparent;}
.cmt-list .paging .arrow span {width:40px;height:40px; padding:0; text-indent:-999em; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/btn_prev.png); background-position:0 0;}
.cmt-list .paging .next span {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/btn_next.png);}
.cmt-list .paging a.current {background-color:#bedce2; border:0; border-radius:50%; color:#000; font-weight:bold;}
.cmt-list .paging a.current span {color:#000;}
.cmt-list .paging a.current:hover {background-color:#bedce2;}
.cmt-list .paging a.arrow.first,
.cmt-list .paging a.arrow.end {display:none;}
.cmt-list .paging a:hover {background-color:transparent;}

.related-event {margin-top:0;}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>

$(function () {
    $(".slider").FlowSlider({
        marginStart:0,
        marginEnd:0,
        startPosition:0.55
    });

    // parallax
    $(".dc1").parallax({speed:10,ascending:false,delay:800});
    $(".dc2").parallax({speed:20,ascending:false,delay:600});
    $(".dc3").parallax({speed:10,ascending:false,delay:700});

    // animation
    $('.top').addClass('on');
    $(window).scroll(function() {
        var st=$(this).scrollTop();
        var winH=window.innerHeight;
        $('.animove').each(function(){
            var innerH=$(this).innerHeight()
            var ofs=$(this).offset().top;
            if(st>ofs-winH && ofs+ innerH>st){$(this).addClass('on')}
            else{$(this).removeClass('on')}
        })
    })    

	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>

    $('input[name=char]').click(function(){	        
        $("#spoint").val($(this).val())
    })    
});

// parallax
(function ($) {
    $.fn.parallax = function (options) {
        var parallax_element = this;
        var settings = {
            speed:'100',
            ascending:true,
            delay:'1000'
        };

        if (options) {
            $.extend(settings, options);
        }

        var ad = "+";
        if (!settings['ascending'] == true) {
            var ad = "-";
        }

        $(window).scroll(function () {
            var wScroll = $(this).scrollTop();
            parallax_element.css({
                "transform":"translate(0px, " + ad + wScroll / settings['speed'] + "%)",
                "transition-duration":settings['delay'] + "ms"
            });
        });
    }
}(jQuery));

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".cmt-list").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( currentDate >= evtStartDate and currentDate <= evtEndDate ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
            if(frm.txtcomm1.value == ""){
                alert('내용을 넣어주세요')
                frm.txtcomm1.focus()
                return false;
            }
            frm.txtcomm.value = frm.txtcomm1.value
            frm.action = "/event/lib/comment_process.asp";
            frm.submit();
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
   		document.frmdelcom.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	}
}

function fnChkByte(obj) {
    var maxByte = 100; //최대 입력 바이트 수
    var str = obj.value;
    var str_len = str.length;
 
    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";
 
    for (var i = 0; i < str_len; i++) {
        one_char = str.charAt(i);
 
        if (escape(one_char).length > 4) {
            rbyte += 2; //한글2Byte
        } else {
            rbyte++; //영문 등 나머지 1Byte
        }
 
        if (rbyte <= maxByte) {
            rlen = i + 1; //return할 문자열 갯수
        }
    }    
 
    if (rbyte > maxByte) {
        alert("한글 "+ (maxByte / 2) +"자 이내로 작성 가능합니다.");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
    } else {
        //document.getElementById('byteInfo').innerText = Math.ceil(rbyte / 2);
    }
}
</script>
<div class="evt97971">
    <div class="top">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/tit_peanuts.png" alt="To the Moon  with Snoopy" /></h2>
        <div class="museum">
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/txt_museum.png" alzt="lotte musuem of art" />
            <a href="https://www.lottemuseum.com/" target="_blank">전지자세히 보러가기</a>
        </div>
    </div>
    <div class="collabo"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/txt_collabo.png" alt="To the Moon with Snoopy의 공식 MD는 텐바이텐과 함께 합니다." /></div>
    <div class="space-art">
        <h3>
            <span class="t1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/tit_collec_1.png" alt="Space Art Collection" /></span>
            <span class="t2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/tit_collec_2.png" alt="Limited Edition" /></span>
            <span class="t3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/tit_collec_3.png" alt="예약판매 10월 28일부터 순차 배송" /></span>
        </h3>
        <div class="main-items">
            <a href="/shopping/category_prd.asp?itemid=2535148&pEtr=97971"><span class="main-item1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/img_doll1.png" alt="찰리브라운" /></span></a>
            <a href="/shopping/category_prd.asp?itemid=2535141&pEtr=97971"><span class="main-item2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/img_doll2.png" alt="스누피" /></span></a>
            <i class="bg_main-item"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/bg_shadow.png" alt="" /></i>
            <p class="item-name"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/txt_item_name.gif" alt="스누피 & 찰리브라운 인형 25cm" /></p>
        </div>
        <!-- 상품 리스트 -->
        <div class="character-items slider">
            <% if Ubound(bestItemList) > 0 then %>
                <%  
                    for i = 0 to Ubound(bestItemList) - 1
                    call bestItemList(i).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)
                %>
                    <div class="item">
                        <a href="/shopping/category_prd.asp?itemid=<%=bestItemList(i).Fitemid%>&pEtr=97971">
                            <div class="num"><% If Len(i) < 2 Then %>0<% End If %><%=i+1%></div>
                            <div class="thumbnail">
                                <% If Trim(bestItemList(i).FTentenImg400) <> "" Then %>
                                    <img src="<%=bestItemList(i).FTentenImg400%>" width="240" height="240" alt="<%=bestItemList(i).FAddtext1%>" />
                                <% Else %>
                                    <img src="<%=bestItemList(i).FBasicimage%>" width="240" height="240" alt="<%=bestItemList(i).FAddtext1%>" />
                                <% End If %>                            
                            </div>
                            <div class="name">
                                <% 
                                    If Trim(bestItemList(i).FAddtext1) <> "" Then 
                                        Response.Write bestItemList(i).FAddtext1
                                    Else
                                        Response.Write bestItemList(i).Fitemname
                                    End If
                                %>
                            </div>
                            <p class="price"><%=formatNumber(totalPrice, 0)%>원</p>
                        </a>
                    </div>
                <%
                    next
                %>
            <% End If %>
        </div>
        <!--// 상품 리스트 -->
        <div class="deco">
            <span class="dc dc1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/img_planet1.png" alt="" /></span>
            <span class="dc dc2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/img_planet2.png" alt="" /></span>
            <span class="dc dc3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/img_planet3.png" alt="" /></span>
            <span class="dc dc4"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/img_rocket.png" alt="" /></span>
            <span class="dc dc5"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/img_character1.png" alt="" /></span>
            <span class="dc dc6"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/img_character2.png" alt="" /></span>
            <span class="dc dc7"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/img_hole1.png" alt="" /></span>
        </div>
    </div>
    <!-- 코멘트 이벤트 -->
    <div class="snoopy-night">
        <div class="flex-inner">
            <h4><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/tit_snoopy_night.png" alt="특별한 당신에게 snoopy night" /></h4>
            <p class="info"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/txt_info.png" alt="11월 1일(금) 저녁 7시 오직 40명을 위해 PRIVATE전시가 열립니다" /></p>
        </div>
        <div class="cmt-evt animove">
            <div class="inner">
                <div class="flex-inner">
                    <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/txt_cmt_evt.png" alt="좋아하는 친구를 선택하고 전시 기대평을 남겨주세요. 1인 2매 증정!" /></p>
                    <div class="select-char">
                        <div class="char char1"><input type="radio" id="char1" name="char" checked value="1" /><label for="char1"><i></i><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char1.png" alt="" /></label></div>
                        <div class="char char2"><input type="radio" id="char2" name="char" value="2" /><label for="char2"><i></i><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char2.png" alt="" /></label></div>
                        <div class="char char3"><input type="radio" id="char3" name="char" value="3" /><label for="char3"><i></i><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char3.png" alt="" /></label></div>
                        <div class="char char4"><input type="radio" id="char4" name="char" value="4" /><label for="char4"><i></i><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char4.png" alt="" /></label></div>
                        <div class="char char5"><input type="radio" id="char5" name="char" value="5" /><label for="char5"><i></i><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/ico_char5.png" alt="" /></label></div>
                    </div>
                </div>
                <form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
                    <input type="hidden" name="eventid" value="<%=eCode%>">
                    <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                    <input type="hidden" name="bidx" value="<%=bidx%>">
                    <input type="hidden" name="iCC" value="<%=iCCurrpage%>">
                    <input type="hidden" name="iCTot" value="">
                    <input type="hidden" name="mode" value="add">
                    <input type="hidden" id="spoint" name="spoint" value="1">
                    <input type="hidden" name="isMC" value="<%=isMyComm%>">
                    <input type="hidden" name="pagereload" value="ON">
                    <input type="hidden" name="txtcomm">
                    <input type="hidden" name="gubunval"> 
                    <div class="write-cont">
                        <div class="flex-inner">
                            <input type="text" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="fnChkByte(this);" maxlength="40" placeholder="최대 40글자까지 입력 가능합니다. 1줄만 입력할 수 있습니다.">
                            <button type="button" class="btn-submit" onclick="jsSubmitComment(document.frmcom);return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97971/btn_submit.jpg" alt="입력하기" /></button>
                        </div>
                    </div>
                </form>
                <form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
                    <input type="hidden" name="eventid" value="<%=eCode%>">
                    <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                    <input type="hidden" name="bidx" value="<%=bidx%>">
                    <input type="hidden" name="Cidx" value="">
                    <input type="hidden" name="mode" value="del">                                        
                </form>                
                <p class="caution">통신예절에 어긋나는 글은 관리자에 의해  사전 통보 없이 삭제될 수 있습니다.  </p>
                <div class="cmt-list">
                    <% IF isArray(arrCList) THEN %>
                    <ul>
                        <% 
                            dim tmpImgCode
                            For intCLoop = 0 To UBound(arrCList,2) 

                            tmpImgCode = Format00(1, arrCList(3,intCLoop))
                        %>    
                                <%' for dev msg 선택한 캐릭터에 따라 [char1 ~ char5] 클래스 추가 // 6개씩 노출 %>
                                <li>
                                    <div class="info"><span class="user"><%=printUserId(arrCList(2,intCLoop),2,"*")%></span>
                                        <p>
                                            <% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
                                                <button class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');">[삭제]</button>
                                            <% End If %>
                                            <span class="date"><%= FormatDate(arrCList(4,intCLoop),"0000.00.00") %></span>
                                        </p>
                                    </div>
                                    <span class="char char<%=tmpImgCode%>"></span>
                                    <div class="conts"><span><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></span></div>
                                </li>
                        <%
                            next
                        %>
                    </ul>
                    <% End IF %>
                    <div class="pageWrapV15">
                        <div class="paging">
                            <% IF isArray(arrCList) THEN %>
                                <%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
                            <% End If %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--// 코멘트 이벤트 -->
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->