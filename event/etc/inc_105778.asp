<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'#################################################################
' Description : 다이어리 스토리 오픈 이벤트 
' History : 2020-09-09 정태훈
'#################################################################
%>
<%
Dim userid, currentDate, eventStartDate, eventEndDate, evtdiv
currentDate =  now()
userid = GetEncLoginUserID()
eventStartDate  = cdate("2020-09-14")		'이벤트 시작일
eventEndDate 	= cdate("2020-10-04")		'이벤트 종료일
evtdiv = requestcheckvar(request("evtdiv"),5)
if evtdiv="" then evtdiv="evt1"

if userid="ley330" or userid="greenteenz" or userid="rnldusgpfla" or userid="cjw0515" or userid="thensi7" or userid = "motions" or userid = "jj999a" or userid = "phsman1" or userid = "jjia94" or userid = "seojb1983" or userid = "kny9480" or userid = "bestksy0527" or userid = "mame234" or userid = "corpse2" or userid = "starsun726" then
	currentDate = #09/14/2020 09:00:00#
end if

Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  102223
Else
	eCode   =  105778
End If

dim commentcount, i, subscriptcount
	

If userid <> "" then
	commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "1", "")
Else
	commentcount = 0
End If

dim cEComment, cdl, com_egCode, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	isMyComm	= requestCheckVar(request("isMC"),1)

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 4		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
iCPageSize = 4		'메뉴가 있으면 10개		'/수기이벤트 둘다 강제 12고정

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt      '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt            '리스트 총 갯수
set cEComment = nothing

%>
<style type="text/css">
.evt105778 {padding-bottom:130px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/bg_grid1.png) repeat center/contain;}
.evt105778 button {background-color:transparent; font-size:0;}
.evt105778 h2 {padding-top:40px;}
.evt105778 .tab-nav {height:100px;}
.evt105778 .tab-nav ul {display:flex; width:1140px; height:100px; margin:0 auto; background-color:#fff;}
.evt105778 .tab-nav li {width:33.333%; height:100%; border-radius:15px 15px 0 0;background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/tab1_v2.png); background-repeat:no-repeat; background-position:0 0;}
.evt105778 .tab-nav li.tab2 {background-position:-380px 0;}
.evt105778 .tab-nav li:last-child {background-position:100% 0;}
.evt105778 .tab-nav li a {display:block; width:100%; height:100%; text-indent:-999em;}
.evt105778 .tab-nav2 li {width:50%; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/tab2.png);}
.evt105778.is-fixed .tab-nav ul {position:fixed; top:0; left:50%; z-index:30; transform:translateX(-50%);}

.evt105778 .btn-delete,
.evt105778 .btn-close {width:40px; height:40px; border-radius:50%; background:#fff url(//webimage.10x10.co.kr/fixevent/event/2020/105778/btn_delete.png) no-repeat center/contain;}
.evt105778 .btn-modify {background:#fff url(//webimage.10x10.co.kr/fixevent/event/2020/105778/btn_modify.png) repeat center/contain;}

.cont1 {width:1140px; margin:0 auto;}
.cont1 .cmt-evt {position:relative;}
.cont1 .write-cmt {display:flex; position:absolute; top:0; left:50%; width:630px; height:100%; transform:translateX(-315px);}
.cont1 .write-cmt input {width:462px; height:100%; padding:0 40px; border:none; font-size:22px; font-weight:500; color:#444; background-color:#fff; border-radius:15px 0 0 15px; box-sizing:border-box;}
.cont1 .write-cmt input::-webkit-input-placeholder {color:#999;}
.cont1 .write-cmt input::-ms-input-placeholder {color:#999;}
.cont1 .write-cmt input::-moz-placeholder {color:#999;}
.cont1 .write-cmt .btn-submit {width:168px; color:transparent;}
.cont1 .cmt-list {padding-bottom:100px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/bg_grid2.png) repeat center/contain;}
.cont1 .cmt-list ul {display:flex; flex-wrap:wrap; justify-content:space-between; margin-top:57px; padding:0 80px;}
.cont1 .cmt-list .cmt-wrap {display:flex; flex-direction:column; justify-content:center; position:relative; width:480px; height:212px; padding-bottom:30px; margin-top:0; background-position:50% 50%; background-size:100%; background-repeat:no-repeat; box-sizing:border-box;}
.cont1 .cmt-list .cmt-wrap .num {position:absolute; top:45px; left:45px; font-size:20px; color:#666;}
.cont1 .cmt-list .cmt-wrap .btn-group {position:absolute; top:-10px; right:-10px; z-index:10;}
.cont1 .cmt-list .cmt-wrap .btn-group button {width:50px; height:50px; background-color:#fffff8; border-radius:50%;}
.cont1 .cmt-list .cmt-wrap .btn-group .btn-submit {position:absolute; top:0; right:0; font-size:20px;}
.cont1 .cmt-list .cmt-wrap .cmt-cont {position:relative; font-size:26px; font-weight:500; text-align:center;}
.cont1 .cmt-list .cmt-wrap .cmt-cont input[type=text] {position:absolute; top:-2px; left:0; width:100%; height:100%; padding:0; border:0; border-radius:0; background-color:transparent; font-weight:inherit; font-size:inherit; line-height:inherit; text-align:center;}
.cont1 .cmt-list .cmt-wrap .user-info {font-size:20px; color:#888; text-align:center;}
.cont1 .cmt-list li:nth-child(2n) {margin-top:90px;}
.cont1 .cmt-list li:nth-child(2n) .cmt-wrap .num {top:47px;}
.cont1 .cmt-list li:nth-child(8n-7) .cmt-wrap {margin-top:0; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/bg_cmt1.png);}
.cont1 .cmt-list li:nth-child(8n-6) .cmt-wrap {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/bg_cmt2.png);}
.cont1 .cmt-list li:nth-child(8n-5) .cmt-wrap {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/bg_cmt3.png);}
.cont1 .cmt-list li:nth-child(8n-4) .cmt-wrap {height:274px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/bg_cmt4.png);}
.cont1 .cmt-list li:nth-child(8n-3) .cmt-wrap {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/bg_cmt5.png);}
.cont1 .cmt-list li:nth-child(8n-2) .cmt-wrap {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/bg_cmt6.png);}
.cont1 .cmt-list li:nth-child(8n-1) .cmt-wrap {height:274px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/bg_cmt7.png);}
.cont1 .cmt-list li:nth-child(8n) .cmt-wrap {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/bg_cmt8.png);}
.cont1 .cmt-list li:nth-child(8n-6) .cmt-wrap .num,
.cont1 .cmt-list li:nth-child(8n-3) .cmt-wrap .num,
.cont1 .cmt-list li:nth-child(8n) .cmt-wrap .num {left:42px;}
.cont1 .cmt-list li:nth-child(8n-6) .cmt-wrap .btn-group,
.cont1 .cmt-list li:nth-child(8n-3) .cmt-wrap .btn-group,
.cont1 .cmt-list li:nth-child(8n) .cmt-wrap .btn-group {top:-5px; right:5px;}
.cont1 .btn-go {display:block; width:50.93%; padding:3.41rem 1.71rem 5.12rem 0; margin-left:auto;}
.cont1 .pageWrapV15 {margin-top:45px; padding:0 0 55px; background-color:transparent;}

.cont2 {padding-bottom:120px;}
.cont2 .cmt-evt-wrap {position:relative; z-index:2; width:1140px; margin:0 auto; padding-top:65px; padding-bottom:70px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/bg_grid3.png) repeat center/contain;}
.cont2 .cmt-evt-wrap h3 {padding-bottom:50px;}
.cont2 .cmt-evt-wrap .selct-dr {position:relative; height:400px;}
.cont2 .cmt-evt-wrap .selct-dr .btn-selct,
.cont2 .cmt-evt-wrap .selct-dr .thumbnail {position:relative; display:inline-block; width:400px; height:100%; margin:0 auto;}
.cont2 .cmt-evt-wrap .selct-dr .thumbnail {width:360px; height:360px; border:solid 20px #fff; border-radius:10px; background-color:#fff;}
.cont2 .cmt-evt-wrap .selct-dr .thumbnail img {width:100%; height:100%; border-radius:10px;}
.cont2 .cmt-evt-wrap .selct-dr .thumbnail .btn-delete {position:absolute; top:-35px; right:-35px;}
.cont2 .cmt-evt-wrap .write-cmt {margin-top:40px; font-size:0;}
.cont2 .cmt-evt-wrap .write-cmt textarea {width:600px; height:200px; padding:35px 55px; border-radius:10px; font-weight:500; font-size:22px; line-height:2.14; color:#444; box-sizing:border-box;}
.cont2 .cmt-evt-wrap .btn-submit {margin-bottom:40px; vertical-align:top;}
.cont2 .cmt-evt-wrap .share {margin-top:45px;}

.cont2 .cmt-list {position:relative; margin:80px auto 0;}
.cont2 .cmt-list::before {content:''; position:absolute; top:-193px; left:50%; z-index:1; width:1790px; height:100%; padding-top:193px; transform:translateX(-50%); background:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/bg_circle_v2.png) repeat-y 50% 0/100%;}
.cont2 .cmt-list h4 {position:relative; z-index:2; width:1340px; margin:0 auto; padding:105px 0 80px; background-color:#fff;}
.cont2 .cmt-list ul {display:flex; flex-wrap:wrap; position:relative; z-index:10; width:1340px; margin:0 auto; padding:0 55px; background-color:#fff; box-sizing:border-box;}
.cont2 .cmt-list ul li {width:350px; margin:0 30px 80px;}
.cont2 .cmt-list .thumbnail {overflow:hidden; position:relative; width:100%; height:350px; border-radius:15px;}
.cont2 .cmt-list .thumbnail img {width:100%; height:100%;}
.cont2 .cmt-list .thumbnail .num {display:inline-block; position:absolute; top:20px; left:20px; height:49px; padding:0 20px; border-radius:40px; background-color:#fff; font-size:22px; line-height:50px;}
.cont2 .cmt-list .user-info {display:flex; align-items:center; margin:34px 0 20px; text-align:left;}
.cont2 .cmt-list .user-info .user-grade {display:inline-block; width:60px; height:60px; margin-right:10px; background-repeat:no-repeat; background-size:100%;}
.cont2 .cmt-list .white {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/img_white.png);}
.cont2 .cmt-list .red {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/img_red.png);}
.cont2 .cmt-list .vip {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/img_vip.png);}
.cont2 .cmt-list .vvip {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/img_vvip.png);}
.cont2 .cmt-list .vvipgold {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/m/img_vvipgold.png);}
.cont2 .cmt-list .user-info .user-id {font-weight:700; font-size:24px; color:#444;}
.cont2 .cmt-list .btn-group {position:relative; margin-left:auto;}
.cont2 .cmt-list .btn-group button {display:inline-block; width:50px; height:50px; margin-left:8px; border-radius:50%; background-color:#ebebeb; vertical-align:top;}
.cont2 .cmt-list .cmt-cont {position:relative; width:100%; height:auto; font-weight:500; font-size:20px; line-height:1.8; color:#444; text-align:left;}
.cont2 .cmt-list textarea {position:absolute; top:0; left:0; width:100%; height:100%; padding:0; border:none; background-color:transparent; font-weight:500; font-size:20px; line-height:1.8; color:#444;}
.cont2 .pageWrapV15 {width:1340px;}

.evt105778 .lyr {top:0; left:0; z-index:105; width:100vw;}
.evt105778 .lyr .mask {position:fixed; top:0; left:0; z-index:105; width:100vw; height:100%; background-color:rgba(208, 208, 208, .95);}
.evt105778 .lyr .inner {position:relative; z-index:110; width:1140px; margin:0 auto;}

.evt105778 .lyr-dr {position:absolute;}
.evt105778 .lyr-dr .inner {width:975px; padding:90px 20px 50px; background-color:#fff;}
.evt105778 .lyr-dr p {margin-bottom:60px;}
.evt105778 .lyr-dr ul {display:flex; flex-wrap:wrap;}
.evt105778 .lyr-dr ul li {overflow:hidden; width:285px; margin:0 20px 38px; cursor:pointer;}
.evt105778 .lyr-dr .thumbnail {width:100%; margin-bottom:16px;}
.evt105778 .lyr-dr .thumbnail img {width:100%;}
.evt105778 .lyr-dr .prd-name {font-size:20px; color:#444; text-align:left; word-break:keep-all;}
.evt105778 .lyr-dr .btn-close {position:absolute; top:0; right:0; width:100px; height:100px; border-radius:0; background-size:30px; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='31' height='31'%3e%3cpath fill-rule='evenodd' fill='%23C1C1C1' d='M30.372 28.885l-1.487 1.487-13.393-13.393L2.263 30.208.792 28.737l13.229-13.229L.628 2.115 2.115.628l13.393 13.393L28.737.792l1.471 1.471-13.229 13.229 13.393 13.393z'/%3e%3c/svg%3e");}

.evt105778 .lyr-cmp {position:fixed; display:flex; align-items:center; height:100vh;}
.evt105778 .lyr-cmp .mask {background-color:rgba(255,255,255,.9);}
.evt105778 .lyr-cmp .btn-close {position:absolute; top:0; left:50%; width:100px; height:100px; margin-left:235px; background-image:none; background-color:transparent; border-radius:0;}

.evt105778 .cmt-list .cmt-wrap .btn-submit {display:none; font-size:20px; line-height:50px; color:#444;}
.evt105778 .cmt-list .cmt-wrap.modifying .btn-delete {display:none;}
.evt105778 .cmt-list .cmt-wrap.modifying .btn-submit {display:inline-block;}
.evt105778 .cmt-list .cmt-wrap.modifying .cmt-cont > div {color:transparent;}

.pageWrapV15 {position:relative; z-index:2; width:100%; margin:0 auto; padding:0 0 100px; background-color:#fff;}
.paging {height:auto;}
.paging a {overflow:visible; height:auto; line-height:normal; border:0 none;}
.paging a.current {position:relative; border:0 none;}
.paging a, .paging a:hover, .paging a.current, .paging a.current:hover, .paging a.arrow {background:none;}
.paging a span {height:auto; padding:0 43px; font-size:20px; line-height:29px; color:#ccc;}
.paging a.current span {color:#222;}
.paging a.arrow {margin:0 20px;}
.paging a.arrow span {width:30px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/105778/btn_nav.png) center no-repeat;}
.paging a.next span {transform:scaleX(-1);}
.paging a.first, .paging a.end, .pageWrapV15 .pageMove {display:none;}
</style>
<script>
var _selectedPdt=0;
var _selectedPdtIMG="";
$(window).load(function(){
	// tab
<% if evtdiv="evt1" then %>
	$(".tabContent").hide();
	$("#cont1").show();
<% elseif evtdiv="evt2" then %>
	$(".tabContent").hide();
	$("#cont2").show();
<% elseif evtdiv="evt3" then %>
	$(".tabContent").hide();
	$("#cont3").show();
<% end if %>


	// 탭
	var nav = $(".tab-nav"),
		navY = nav.offset().top,
		lydiaryH,
		cont2H,
		cont2Y,
		currentY;

	$(".tab-nav li a").click(function(){
		$('html, body').animate({scrollTop :nav.offset().top}, 10);
		var thisCont = $(this).attr("href");
		$(".tabContent").hide();
		$(thisCont).show();
		return false;
	});

	// EVT2 레이어:다이어리 선택 노출
	$('.cont2 .btn-selct').click(function (e) {
		$('.lyr-dr').show();
		toggleScrolling();
		e.preventDefault();
	});

	// EVT2 레이어 닫기
	$('.cont2 .btn-close, .cont2 .mask').click(function () {
		$('.lyr').hide();
		toggleScrolling();
	});

	// EVT2 코멘트 수정
	$('.cont2 .btn-modify').click(function (e) {
		var cmt_wrap = $(this).parents('.cmt-wrap'),
			cmt_cont = $(this).parents('.user-info').siblings('.cmt-cont'),
			cmt_txt = cmt_cont.children('div').text(),
			cmt_textarea;

		cmt_wrap.addClass('modifying');
		cmt_cont.append('<textarea name="etxtcomm" id="etxtcomm" cols="30" rows="10"></textarea>');
		cmt_textarea = cmt_cont.children('textarea');
		cmt_textarea.val(cmt_txt).focus();

		$('.btn-submit').click(function (e) {
			cmt_wrap.removeClass('modifying');
			cmt_txt = cmt_textarea.val();
			cmt_cont.children('div').text(cmt_txt);
			cmt_textarea.remove();
		});
	});

	// EVT1 코멘트 수정
	$('.cont1 .btn-modify').click(function (e) {
		var cmt_wrap = $(this).parents('.cmt-wrap'),
			cmt_cont = cmt_wrap.children('.cmt-cont'),
			cmt_txt = cmt_cont.children('div').text(),
			cmt_textarea;

		cmt_wrap.addClass('modifying');
		cmt_cont.append('<input type="text" name="etxtcomm2" id="etxtcomm2">');
		cmt_textarea = cmt_cont.children('input');
		cmt_textarea.val(cmt_txt).focus();

		$('.btn-submit').click(function (e) {
			cmt_wrap.removeClass('modifying');
			cmt_txt = cmt_textarea.val();
			cmt_cont.children('div').text(cmt_txt);
			cmt_textarea.remove();
		});
	});

	$("#txtcomm2").keyup(function (event) {
		regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
		v = $(this).val();
		if (regexp.test(v)) {
			alert("한글만 입력가능 합니다.");
			$(this).val(v.replace(regexp, ''));
		}
	});

	$("#etxtcomm2").keyup(function (event) {
		regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
		v = $(this).val();
		if (regexp.test(v)) {
			alert("한글만 입력가능 합니다.");
			$(this).val(v.replace(regexp, ''));
		}
	});

    getDiaryItems(1);
	jsGoComPage(1);
	jsGoComPage2(1);
});

// 모달 호출, 닫을 때 스크롤 위치 & 스크롤 height
function toggleScrolling() {
	if ($('.lyr-dr').is(':visible')) {
		lydiaryH = $('.lyr-dr').height();
		currentY = $(window).scrollTop();
		cont2H = $('.evt105778 .cont2').height();
		cont2Y = $('.evt105778 .cont2').offset().top;
		$('.evt105778 .cont2').css('height', lydiaryH - cont2Y);
		$('html, body').animate({scrollTop :0}, 0);
	} else {
		$('.evt105778 .cont2').css('height', cont2H);
		$('html, body').animate({scrollTop :currentY}, 0);
	}
}

function eventTry(){
	<% If Not(IsUserLoginOK) Then %>
        if(confirm("로그인 하시겠습니까?")){
            location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
            return;
        }
	<% else %>
		<% If (currentDate >= eventStartDate And currentDate <= eventEndDate) Then %>
			if(!$("#txtcomm2").val()){
				alert("코멘트를 적어주세요!");
				return false;
			}

			if (GetByteLength($("#txtcomm2").val()) < 12 || GetByteLength($("#txtcomm2").val()) > 12){
				alert("6글자로 채워주세요");
				return false;
			}
			var makehtml="";
			var returnCode, itemid, data
			var data={
				mode: "addcomment",
				txtcomm: $("#txtcomm2").val()
			}
			$.ajax({
				type:"POST",
				url:"/event/lib/doEventCommentProc.asp",
				data: data,
				dataType: "JSON",
				success : function(res){
					fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode|option1','<%=eCode%>|tap1')
						if(res!="") {
							// console.log(res)
							if(res.response == "ok"){
								makehtml = '\
								<li id="list_' + res.cidx + '">\
									<div class="cmt-wrap">\
										<div class="btn-group">\
											<button class="btn-modify" onclick="fnMyCommentEdit2(' + res.cidx + ')">수정하기</button>\
											<button class="btn-submit" onclick="fnEditComment2(' + res.cidx + ');">확인</button>\
										</div>\
										<div class="cmt-cont">\
											<div>' + $("#txtcomm2").val() + '</div>\
										</div>\
										<div class="user-info"><%=userid%>님</div>\
									</div>\
								</li>\
								'
								$("#clist2").prepend(makehtml);
								$("#txtcomm2").val("");
								alert(res.returnstr);
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
					alert("잘못된 접근 입니다2.");
					return false;
				}
			});
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% End If %>
	<% End If %>
}

function event2Try(){
	<% If Not(IsUserLoginOK) Then %>
        if(confirm("로그인 하시겠습니까?")){
            location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
            return;
        }
	<% else %>
		<% If (currentDate >= eventStartDate And currentDate <= eventEndDate) Then %>
            <% if commentcount>=1 then %>
                alert("이벤트는 1회 참여 가능 합니다.");
				return false;
            <% else %>
                if (_selectedPdt==0){
					alert("다이어리를 선택해주세요.");
					return false;
				}

                if(!$("#txtcomm").val()){
					alert("코멘트를 적어주세요!");
					return false;
				}

				if (GetByteLength($("#txtcomm").val()) < 20){
					alert("최소 10자 이상 입력해주세요.");
					return false;
				}
                var makehtml="";
                var returnCode, itemid, data
                var data={
                    mode: "add",
                    selectedPdt: _selectedPdt,
                    selectedPdtIMG: _selectedPdtIMG,
                    txtcomm: $("#txtcomm").val()
                }
                $.ajax({
                    type:"POST",
                    url:"/event/lib/doEventCommentProc.asp",
                    data: data,
                    dataType: "JSON",
                    success : function(res){
                        fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode|option1','<%=eCode%>|' + _selectedPdt)
                            if(res!="") {
                                // console.log(res)
                                if(res.response == "ok"){
                                    makehtml = '\
                                    <li id="list' + res.cidx + '">\
                                        <div class="thumbnail">\
                                        <a href="http://m.10x10.co.kr/category/category_itemprd.asp?itemid=' + _selectedPdt + '&pEtr=<%=eCode%>" class="mWeb"><img src="' + _selectedPdtIMG + '" alt=""></a>\
                                        </div>\
                                        <div class="cmt-wrap">\
                                            <div class="user-info">\
                                                <em class="user-grade vip"></em><span class="user-id"><%=userid%>님</span>\
                                                <div class="btn-group">\
                                                    <button class="btn-modify" onclick="fnMyCommentEdit(' + res.cidx + ')">수정하기</button>\
                                                    <button class="btn-delete" onclick="fnDelComment(' + res.cidx + ');">삭제하기</button>\
                                                    <button class="btn-submit" onclick="fnEditComment(' + res.cidx + ');">확인</button>\
                                                </div>\
                                            </div>\
                                            <div class="cmt-cont">\
												<div>' + $("#txtcomm").val() + '</div>\
                                            </div>\
                                        </div>\
                                    </li>\
                                    '
                                    $("#resultpop").show();
                                    _selectedPdt=0;
                                    _selectedPdtIMG="";
                                    $('#selectitem').hide();
                                    $("#clist").prepend(makehtml);
									$("#txtcomm").val("");
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
                        alert("잘못된 접근 입니다2.");
                        return false;
                    }
                });
            <% end if %>
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% End If %>
	<% End If %>
}

function getDiaryItems(vpage){
    var deliType   = "";
    var giftdiv     = "";
    var pageSize    = 200;
    var SubShopCd   = 100;

    $.ajax({
        type: "POST",
        url: "/diarystory2021/api/diaryItems.asp",
        data: {
            srm: "bs",
            cpg: vpage,
            pageSize: pageSize,
            SubShopCd: SubShopCd,
            deliType: deliType,
            giftdiv: giftdiv,
            attribCd: '',
            colorCd: '',
            subShopGroupCode : '100101',
            cateCode : '',
        },
        dataType: "json",
        success: function(Data){
            items = Data.items
            renderItemList(items)
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.')
            //$("#listContainer").empty();
        }
    })
}

function renderItemList(itemList){
	var $rootEl = $("#itemList")
	var itemEle = tmpEl = ""
    $rootEl.empty();
    <%'// 오픈 리스트 %>
	if(itemList.length > 0){
        var newArr = itemList
		newArr.forEach(function(item){

            tmpEl = '\
                <li onclick="fnselectItem('+ item.itemid + ',\'' + item.itemImg +'\')" style="cursor:pointer">\
                    <div class="thumbnail"><img src="' + item.itemImg + '" alt=""></div>\
                    <div class="prd-name">' + item.itemName + '</div>\
                </li>\
            '
		    itemEle += tmpEl        
        });
	}
	<%'// 대기 리스트 %>
	$rootEl.append(itemEle)
}

function jsGoComPage(vpage){
    $.ajax({
        type: "POST",
        url: "/event/etc/inc_105778list.asp",
        data: {
            iCC: vpage
        },
        success: function(Data){
            $("#commentlist").html(Data);
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.')
            //$("#listContainer").empty();
        }
    })
}

function jsGoComPage2(vpage){
    $.ajax({
        type: "POST",
        url: "/event/etc/inc_105778list2.asp",
        data: {
            iCC: vpage
        },
        success: function(Data){
            $("#commentlist2").html(Data);
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.')
            //$("#listContainer").empty();
        }
    })
}

function fnselectItem(itemid,itemimg){
    _selectedPdt=itemid;
    _selectedPdtIMG=itemimg;
    itemimg = itemimg.replace("w=240","w=350");
    itemimg = itemimg.replace("h=240","h=350")
    $('#selectitem').show();
    $('#selectdiary').hide();
    $('#itemimg').attr('src',itemimg);
    $('.lyr').hide();
    toggleScrolling();
}

function fnDeleteDiary(){
    _selectedPdt=0;
    _selectedPdtIMG="";
    $('#selectdiary').show();
    $('#selectitem').hide();
}

function fnDelComment(Cindex){
	<% If Not(IsUserLoginOK) Then %>
        if(confirm("로그인 하시겠습니까?")){
            location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
            return;
        }
	<% else %>
        if(confirm("삭제 하시겠습니까?")){
			var returnCode, itemid, data
			var data={
				mode: "del",
				Cidx: Cindex
			}
			$.ajax({
				type:"POST",
				url:"/event/lib/doEventCommentProc.asp",
				data: data,
				dataType: "JSON",
				success : function(res){
					if(res!=""){
						if(res.response == "ok"){
							$("#list"+Cindex).hide();
							return false;
						}else{
							alert(res.faildesc);
							return false;
						}
					}else {
						alert("잘못된 접근 입니다.");
						document.location.reload();
						return false;
					}
				},
				error:function(err){
					console.log(err)
					alert("잘못된 접근 입니다.");
					return false;
				}
			});
		}
    <% end if %>
}

function fnEditComment(Cindex){
	<% If Not(IsUserLoginOK) Then %>
        if(confirm("로그인 하시겠습니까?")){
            location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
            return;
        }
	<% else %>
		<% If (currentDate >= eventStartDate And currentDate <= eventEndDate) Then %>
            var _txtcomm = $("#etxtcomm").val();
            if(!$("#etxtcomm").val()){
                alert("코멘트를 적어주세요!");
                return false;
            }

            if (GetByteLength($("#etxtcomm").val()) < 20){
                alert("최소 10자 이상 입력해주세요.");
                return false;
            }
            var returnCode, itemid, data
            var data={
                mode: "edit",
                Cidx: Cindex,
                txtcomm: $("#etxtcomm").val()
            }
            $.ajax({
                type:"POST",
                url:"/event/lib/doEventCommentProc.asp",
                data: data,
                dataType: "JSON",
                success : function(res){
                    if(res!="") {
                        // console.log(res)
                        if(res.response == "ok"){
							var cmt_wrap = $("#list"+Cindex).children(".cmt-wrap"),
								cmt_cont = cmt_wrap.children('.cmt-cont'),
								cmt_txt = cmt_cont.children('div').text(),
								cmt_textarea;
							cmt_wrap.removeClass('modifying');
							cmt_textarea = cmt_cont.children('textarea');
							cmt_txt = cmt_textarea.val();
							cmt_cont.children('div').text(_txtcomm);
							cmt_textarea.remove();
                            return false;
                        }else{
                            alert(res.faildesc);
                            return false;
                        }
                    } else {
                        alert("잘못된 접근 입니다.");
                        document.location.reload();
                        return false;
                    }
                },
                error:function(err){
                    console.log(err)
                    alert("잘못된 접근 입니다.");
                    return false;
                }
            });
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% End If %>
	<% End If %>
}

function fnEditComment2(Cindex){
	<% If Not(IsUserLoginOK) Then %>
        if(confirm("로그인 하시겠습니까?")){
            location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
            return;
        }
	<% else %>
		<% If (currentDate >= eventStartDate And currentDate <= eventEndDate) Then %>
            var _txtcomm2 = $("#etxtcomm2").val();
            if(!$("#etxtcomm2").val()){
                alert("코멘트를 적어주세요!");
                return false;
			}
            if (GetByteLength($("#etxtcomm2").val()) < 12 || GetByteLength($("#etxtcomm2").val()) > 12){
				alert("6글자로 채워주세요");
				return false;
			}
            var returnCode, itemid, data
            var data={
                mode: "editcomment",
                Cidx: Cindex,
                txtcomm: $("#etxtcomm2").val()
            }
            $.ajax({
                type:"POST",
                url:"/event/lib/doEventCommentProc.asp",
                data: data,
                dataType: "JSON",
                success : function(res){
                    if(res!="") {
                        // console.log(res)
                        if(res.response == "ok"){
							var cmt_wrap = $("#list_"+Cindex).children(".cmt-wrap"),
								cmt_cont = cmt_wrap.children('.cmt-cont'),
								cmt_txt = cmt_cont.children('div').text(),
								cmt_textarea;
							cmt_wrap.removeClass('modifying');
							cmt_textarea = cmt_cont.children('input');
							cmt_txt = cmt_textarea.val();
							cmt_cont.children('div').text(_txtcomm2);
							cmt_textarea.remove();
                            return false;
                        }else{
                            alert(res.faildesc);
                            return false;
                        }
                    } else {
                        alert("잘못된 접근 입니다.");
                        document.location.reload();
                        return false;
                    }
                },
                error:function(err){
                    console.log(err)
                    alert("잘못된 접근 입니다.");
                    return false;
                }
            });
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% End If %>
	<% End If %>
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
        if(confirm("로그인 하시겠습니까?")){
            location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
            return;
        }
	}
}

function fnMyCommentEdit(idx){
	var cmt_wrap = $("#list"+idx).children(".cmt-wrap"),
		cmt_cont = cmt_wrap.children('.cmt-cont'),
		cmt_txt = cmt_cont.children('div').text(),
		cmt_textarea;
	cmt_wrap.addClass('modifying');
	cmt_cont.append('<textarea name="etxtcomm" id="etxtcomm" cols="30" rows="10"></textarea>');
	cmt_textarea = cmt_cont.children('textarea');
	cmt_textarea.val(cmt_txt).focus();
}

function fnMyCommentEdit2(idx){
	var cmt_wrap = $("#list_"+idx).children(".cmt-wrap"),
		cmt_cont = cmt_wrap.children('.cmt-cont'),
		cmt_txt = cmt_cont.children('div').text(),
		cmt_textarea;
	cmt_wrap.addClass('modifying');
	cmt_cont.append('<input type="text" name="etxtcomm2" id="etxtcomm2">');
	cmt_textarea = cmt_cont.children('input');
	cmt_textarea.val(cmt_txt).focus();
}

</script>

					<div class="evt105778">
							<h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/tit_dr.png" alt="깜짝이벤트"></h2>
							<div class="tab-nav">
								<%'<!-- for dev msg 오픈일 ~ 9/27 노출 -->%>
					            <% If (currentDate >= eventStartDate And currentDate < "2020-09-28") Then %>
								<ul class="tab-nav1">
									<li class="tab1"><a href="#cont1">EVENT1</a></li>
									<li class="tab2"><a href="#cont2">EVENT2</a></li>
									<li class="tab3"><a href="#cont3">EVENT3</a></li>
								</ul>
                                <% else %>
								<%'<!-- for dev msg 9/28 부터 노출%>
								<ul class="tab-nav2">
									<li class="tab1"><a href="#cont1">EVENT1</a></li>
									<li class="tab2"><a href="#cont2">EVENT2</a></li>
								</ul>
                                <% end if %>
							</div>
							<div class="tab-container">
								<!-- EVT1 -->
								<div id="cont1" class="tabContent cont1">
									<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/txt_evt1.png" alt="6글자로 말해요!"></h3>
									<div class="cmt-evt">
										<img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/btn_submit1.png" alt="">
										<div class="write-cmt">
											<input type="text" name="txtcomm2" id="txtcomm2" placeholder="<%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>6글자로 적어주세요<%END IF%>" onClick="jsCheckLimit();"<%IF NOT(IsUserLoginOK) THEN%> readonly<%END IF%>>
											<button class="btn-submit" onclick="eventTry(); return false;">입력</button>
										</div>
									</div>
									<div class="cmt-list" id="commentlist2"></div>
								</div>
								<div id="cont2" class="tabContent cont2">
									<div class="cmt-evt-wrap">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/txt_evt2.png" alt="다이어리를 골라봐"></h3>
										<div class="cmt-evt">
											<div class="selct-dr">
												<button class="btn-selct" id="selectdiary"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/btn_selct.png" alt="클릭하여 다이어리를 골라주세요."></button>
												<div class="thumbnail" id="selectitem" style="display:none"><img src="http://thumbnail.10x10.co.kr/webimage/image/basic/300/B003006219-2.jpg" id="itemimg"><button class="btn-delete" onclick="fnDeleteDiary();">삭제하기</button></div>
											</div>
											<div class="write-cmt">
												<textarea name="txtcomm" id="txtcomm" cols="30" rows="10" onClick="jsCheckLimit();" placeholder="이유를 100자 이내로 작성해주세요."></textarea>
											</div>
											<button class="btn-submit" onclick="event2Try();"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/btn_submit2.png" alt="입력"></button>
											<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/txt_date2.png" alt="당첨자 발표일 :10월 14일 * 공지사항 기재 및 개별 연락 예정"></p>
										</div>
										<div class="share"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/txt_qr2.png" alt="친구에게 공유하면 당첨 확률 UP!"></div>
									</div>
									<div class="cmt-list" id="commentlist"></div>

									<!-- 레이어:다이어리 선택 -->
									<div class="lyr lyr-dr" style="display:none;">
										<div class="inner">
											<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/txt_pop1.png" alt="원하는 다이어리를 골라보세요!"></p>
											<ul id="itemList"></ul>
											<button class="btn-close">닫기</button>
										</div>
										<div class="mask"></div>
									</div>

									<!-- 레이어:응모완료 -->
									<div class="lyr lyr-cmp" id="resultpop" style="display:none;">
										<div class="inner">
											<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/txt_pop2_v2.png" alt="입력이 완료되었습니다!"></p>
											<button class="btn-close">닫기</button>
										</div>
										<div class="mask"></div>
									</div>
								</div>

								<!-- EVT3 -->
								<div id="cont3" class="tabContent cont3">
									<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/txt_evt3.png" alt="포토후기를 남겨요!"></h3>
									<a href="/my10x10/goodsusing.asp" target="_blank"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105778/btn_review.png" alt="포토후기 작성하러 가기"></a>
								</div>
							</div>
						</div>