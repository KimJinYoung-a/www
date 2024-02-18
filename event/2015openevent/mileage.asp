<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  2015오픈이벤트
' History : 2015.04.08 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/2015openevent/event60830Cls.asp" -->
<%
dim eCode, userid
	eCode = getevt_code()
	userid = getloginuserid()

dim cEvent, cEventItem, arrItem, arrGroup, intI, intG, rdmNo
dim arrRecent, intR
dim bidx
dim ekind, emanager, escope, ename, esdate, eedate, estate, eregdate, epdate
dim ecategory, ecateMid, blnsale, blngift, blncoupon, blncomment, blnbbs, blnitemps, blnapply
dim etemplate, emimg, ehtml, eitemsort, ebrand,gimg,blnFull,blnItemifno,blnBlogURL, bimg, edispcate, vDisp, vIsWide, j
dim itemid : itemid = ""
Dim evtFile
Dim evtFileyn
dim egCode, itemlimitcnt,iTotCnt, strBrandListURL
dim cdl, cdm, cds
dim com_egCode : com_egCode = 0
Dim blnitempriceyn, clsEvt, isMyFavEvent, favCnt, vDateView
Dim onlyForMDTab, intTab
Dim evt_mo_listbanner , vIsweb , vIsmobile , vIsapp
Dim vTmpgcode : vTmpgcode = "" '//상품없는 그룹 숨김용 변수
Dim iPageSize '//마감임박 이벤트용

Dim upin '카카오 이벤트 key값 parameter
	upin = requestCheckVar(Request("upin"),200)

IF eCode = "" THEN
	response.redirect("/shoppingtoday/shoppingchance_allevent.asp")
	dbget.close()	:	response.End
elseif Not(isNumeric(eCode)) then
	Call Alert_Return("잘못된 이벤트번호입니다.")
	dbget.close()	:	response.End
END IF

egCode = getNumeric(requestCheckVar(Request("eGC"),8))	'이벤트 그룹코드

IF egCode = "" THEN
	egCode = 0
end if


	itemlimitcnt = 105	'상품최대갯수
	'이벤트 개요 가져오기
	set cEvent = new ClsEvtCont
		cEvent.FECode = eCode

		cEvent.fnGetEvent

		eCode		= cEvent.FECode
		ekind		= cEvent.FEKind
		emanager	= cEvent.FEManager
		escope		= cEvent.FEScope
		ename		= cEvent.FEName
		esdate		= cEvent.FESDate
		eedate		= cEvent.FEEDate
		estate		= cEvent.FEState
		eregdate	= cEvent.FERegdate
		epdate		= cEvent.FEPDate
		ecategory	= cEvent.FECategory
		ecateMid	= cEvent.FECateMid
		blnsale		= cEvent.FSale
		blngift		= cEvent.FGift
		blncoupon	= cEvent.FCoupon
		blncomment	= cEvent.FComment
		blnBlogURL	= cEvent.FBlogURL
		blnbbs		= cEvent.FBBS
		blnitemps	= cEvent.FItemeps
		blnapply	= cEvent.FApply
		etemplate	= cEvent.FTemplate
		emimg		= cEvent.FEMimg
		ehtml		= cEvent.FEHtml
		eitemsort	= cEvent.FItemsort
		ebrand		= cEvent.FBrand
		gimg		= cEvent.FGimg
		blnFull		= cEvent.FFullYN
		blnItemifno = cEvent.FIteminfoYN
		evtFile		= cEvent.FevtFile
		evtFileyn	= cEvent.FevtFileyn

		If Not(cEvent.FEItemImg="" or isNull(cEvent.FEItemImg)) then
			bimg		= cEvent.FEItemImg
		ElseIf cEvent.FEItemID<>"0" Then
			If cEvent.Fbasicimg600 <> "" Then
				bimg		= "http://webimage.10x10.co.kr/image/basic600/" & GetImageSubFolderByItemid(cEvent.FEItemID) & "/" & cEvent.Fbasicimg600 & ""
			Else
				bimg		= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(cEvent.FEItemID) & "/" & cEvent.Fbasicimg & ""
			End IF
		Else
			bimg		= ""
		End If

		blnitempriceyn = cEvent.FItempriceYN
		favCnt		= cEvent.FfavCnt
		edispcate	= cEvent.FEDispCate
		vDisp		= edispcate
		vIsWide		= cEvent.FEWideYN
		vDateView	= cEvent.FDateViewYN

		evt_mo_listbanner	= cEvent.FEmolistbanner
		vIsweb				= cEvent.Fisweb
		vIsmobile			= cEvent.Fismobile
		vIsapp				= cEvent.Fisapp

		IF etemplate = "3" OR etemplate = "7" THEN	'그룹형(etemplate = "3" or "7")일때만 그룹내용 가져오기
		cEvent.FEGCode = 	egCode
		arrGroup =  cEvent.fnGetEventGroup
		onlyForMDTab = cEvent.fnGetEventGpcode0
		END IF

		cEvent.FECategory  = ecategory
		arrRecent = cEvent.fnGetRecentEvt_Cache ''fnGetRecentEvt
	set cEvent = nothing
		cdl = ecategory
		cdm = ecateMid

		IF vDisp = "" THEN blnFull= True	'카테고리가 없을경우 전체페이지로
		IF eCode = "" THEN
		Alert_return("유효하지 않은 이벤트 입니다.")
		dbget.close()	:	response.End
		END IF

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 사월의 꿀 맛 - 삼시세번"		'페이지 타이틀 (필수)
	strPageDesc = "당신의 달콤한 쇼핑 라이프를 위해! 사월의 꿀 맛. 당신과 텐바이텐의 연결고리 - 삼시세번"		'페이지 설명
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2015/60830/m/txt_mileage.png"		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/event/2015openevent/mileage.asp"			'페이지 URL(SNS 퍼가기용)

	'//이벤트 종료시
	Dim strExpireMsg : strExpireMsg=""
	'' 있어도 표시가 안되는것 같은 (오류만 발생) - 제거 (20150425; 허진원)
	''IF (datediff("d",eedate,date()) >0) OR (estate =9) Then
	''	<!-- #include virtual="/event/inc_end_event_list.asp" -->
	''END IF


dim subscriptcountclear, mileagescount, totalsubscriptcountclear
	subscriptcountclear=0
	mileagescount=0
	totalsubscriptcountclear=0

if getloginuserid<>"" then
	subscriptcountclear = getevent_subscriptexistscount(eCode, userid, "", "4", "")
	'mileagescount = getmileageexistscount(userid, eCode, "", "", "N")
end if

totalsubscriptcountclear = getevent_subscripttotalcount(eCode, getnowdate, "4", "")
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* 2015 open event common style */
#eventDetailV15 .gnbWrapV15 {height:38px;}
#eventDetailV15 #contentWrap {padding-top:0; padding-bottom:127px;}
.eventContV15 .tMar15 {margin-top:0;}
.aprilHoney {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_wave.png) repeat-x 50% 0;}
.honeyHead {position:relative; width:1140px; margin:0 auto; text-align:left;}
.honeyHead .hgroup {position:absolute; top:22px; left:0;}
.honeyHead .hgroup p {visibility:hidden; width:0; height:0;}
.honeyHead ul {overflow:hidden; width:656px; margin-left:484px;}
.honeyHead ul li {float:left; width:131px;}
.honeyHead ul li.nav5 {width:132px;}
.honeyHead ul li a {overflow:hidden; display:block; position:relative; height:191px; font-size:11px; line-height:191px; text-align:center;}
.honeyHead ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_nav_12pm.png) no-repeat 0 0;}
.honeyHead ul li.nav1 a:hover span {background-position:0 -191px;}
.honeyHead ul li.nav2 a span {background-position:-131px 0;}
.honeyHead ul li.nav2 a:hover span {background-position:-131px -191px;}
.honeyHead ul li.nav2 a.on span {background-position:-131px 100%;}
.honeyHead ul li.nav3 a span {background-position:-262px 0;}
.honeyHead ul li.nav3 a:hover span {background-position:-262px -191px;}
.honeyHead ul li.nav3 a.on span {background-position:-262px 100%;}
.honeyHead ul li.nav4 a span {background-position:-393px 0;}
.honeyHead ul li.nav4 a:hover span {background-position:-393px -191px;}
.honeyHead ul li.nav4 a.on span {background-position:-393px 100%;}
.honeyHead ul li.nav5 {position:relative;}
.honeyHead ul li.nav5 a span {background-position:100% 0;}
.honeyHead ul li.nav5 a:hover span {background-position:100% -191px;}
.honeyHead ul li.nav5 a.on span {background-position:100% 100%;}
.honeyHead ul li.nav5 .hTag {position:absolute; top:9px; left:77px;}
.honeyHead ul li.nav5:hover .hTag {-webkit-animation-name: bounce; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name: bounce; -moz-animation-iteration-count: infinite; -moz-animation-duration:0.5s; -ms-animation-name: bounce; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function: ease-out;}
	50% {margin-top:8px; -webkit-animation-timing-function: ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function: ease-out;}
	50% {margin-top:8px; animation-timing-function: ease-in;}
}
.honeySection {padding-top:70px; background-color:#fff;}

/* 삼시세번 */
.honeyMileage .topic {position:relative; width:1140px; margin:0 auto; padding-bottom:70px; text-align:left;}
.honeyMileage .topic h3 {visibility:hidden; width:0; height:0;}
.honeyMileage .topic p {padding-left:250px;}
.honeyMileage .topic .coin {position:absolute; bottom:-15px; left:70px;}
.honeyMileage .topic .floor {position:absolute; right:75px; bottom:-15px;}
.honeyMileage .topic .three {position:absolute; right:160px; bottom:0; z-index:5;}
.honeyMileage .topic .medal {position:absolute; top:287px; right:155px; z-index:10;}
.honeyMileage .topic .hat {position:absolute; top:106px; right:237px; z-index:10;}
.honeyMileage .topic .m {position:absolute; top:416px; right:329px; z-index:10;}
.honeyMileage .topic .coinright1 {position:absolute; top:390px; right:350px;}
.honeyMileage .topic .coinright2 {position:absolute; top:418px; right:102px; z-index:10;}
.honeyMileage .eventarea {background-color:#f5f5f5;}
.stepbystep {overflow:hidden; width:1140px; margin:0 auto; padding-top:80px; padding-bottom:90px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60830/bg_step.png) no-repeat 377px 80px;}
.stepbystep .step {float:left; position:relative; width:296px; height:422px; padding-left:60px;}
.stepbystep .step .clear {display:none; position:absolute; top:3px; left:108px;}
.stepbystep .step1 {padding-left:88px;}
.stepbystep .step1 .clear {position:absolute; left:136px;}
.stepbystep .step .btnwrap {margin-top:23px;}
.stepbystep .step .btnwrap p {margin-bottom:18px;}
.stepbystep .step .btnwrap p strong {display:inline-block; *display:inline; *zoom:1; width:91px; height:36px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60830/bg_round_box.png) no-repeat 50% 50%; color:#d50c0c; font-size:14px; font-family:'Verdana', 'Dotum', '돋움'; line-height:34px; text-align:center;}
.stepbystep .step .btnwrap .btncheck {margin-left:-5px; background-color:transparent;}
.honeyMileage .give {padding:50px 0; border-bottom:1px solid #fff; background-color:#52e4c0;}
.honeyMileage .give .btngive {margin-bottom:10px;}
.honeyMileage .give .before p {margin-top:20px;}
.honeyMileage .give .before p strong {padding:0 5px; color:#000; font-size:18px; font-family:'Verdana', 'Dotum', '돋움'; line-height:1.063em;}
.honeyMileage .give .after p {margin-bottom:30px; }
.btngive {background-color:transparent;}
.noti {padding-top:58px; border-top:1px solid #52e4c0;}
.noti .inner {width:1140px; margin:0 auto; text-align:left;}
.noti ul {overflow:hidden; padding-top:33px;}
.noti ul li {float:left; width:544px; margin-top:4px; padding-left:26px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60830/blt_circle_yellow.png) no-repeat 0 6px; color:#555; font-size:11px; line-height:1.75em;}
.animated {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-fill-mode:both; animation-fill-mode:both;}
/* FadeIn animation */
@-webkit-keyframes fadeIn {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes fadeIn {
	0% {opacity:0;}
	100% {opacity:1;}
}
.fadeIn {-webkit-animation-name:fadeIn; animation-name:fadeIn; -webkit-animation-iteration-count:7; animation-iteration-count:7;}
</style>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/css/numSpinner.css" />
<script type="text/javascript">
$(function(){
	function moveFlower () {
		$(".honeyHead .hgroup h2").animate({"margin-top":"0"},1000).animate({"margin-top":"3px"},1000, moveFlower);
	}
	//moveFlower();

	$(".honeyMileage .topic .coinright1").css("top", "250px");
	$(".honeyMileage .topic .coinright2").css("top", "300px");
	$(".honeyMileage .topic .m").css("top", "30px");
	function animation() {
		$(".honeyMileage .topic .coinright1").animate({'top':"390px"},2000, animation);
		$(".honeyMileage .topic .coinright2").animate({'top':"418px"},2800, animation);
		$(".honeyMileage .topic .m").animate({'top':"416px"},3800, animation);
	}
	animation();
});

function gowish(){
	<% If IsUserLoginOK Then %>
		<% if not( getnowdate>="2015-04-13" and getnowdate<"2015-04-25" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if staffconfirm and  GetLoginUserLevel()=7 then		'		'/M , A		'	'/WWW %>
				alert("텐바이텐 스탭이시군요! 죄송합니다. 참여가 어렵습니다. :)");
				return;
			<% else %>
				var rstStr = $.ajax({
					type: "POST",
					url: "/event/2015openevent/doEventSubscript60830.asp",
					data: "mode=wish",
					dataType: "text",
					async: false
				}).responseText;
				if (rstStr.substring(0,2) == "01"){
					$("#wishclear").show();
					$("#wishbefore").hide();
					$("#wishaftercount").html( rstStr.substring(5,15) );
					$("#wishaftercount").show();
					$("#wishafterval").show();
					return false;
				}else if (rstStr.substring(0,2) == "02"){
					$("#wishclear").hide();
					$("#wishbefore").hide();
					$("#wishaftercount").html( rstStr.substring(5,15) );
					$("#wishaftercount").show();
					$("#wishafterval").show();
					return false;
				}else if (rstStr == "98"){
					alert('텐바이텐 스탭이시군요! 죄송합니다. 참여가 어렵습니다. :)');
					return false;
				}else if (rstStr == "99"){
					alert('로그인을 해주세요.');
					return false;
//				}else if (rstStr == "14"){
//					alert('이미 오늘 1,000명이 마일리지를 받으셨습니다.');
//					return false;
				}else if (rstStr == "12"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
//				}else if (rstStr == "11"){
//					alert('이미 마일리지를 받으셨습니다.');
//					return false;
				}else{
					alert('정상적인 경로가 아닙니다.');
					return false;
				}
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}

function gotalk(){
	<% If IsUserLoginOK Then %>
		<% if not( getnowdate>="2015-04-13" and getnowdate<"2015-04-25" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if staffconfirm and  GetLoginUserLevel()=7 then		'	'/M , A				'/WWW %>
				alert("텐바이텐 스탭이시군요! 죄송합니다. 참여가 어렵습니다. :)");
				return;
			<% else %>
				if ( $("#wishclear").css("display")=='none' ){
					alert('위시리스트를 먼저 담아 주세요.');
					return false;
				}

				var rstStr = $.ajax({
					type: "POST",
					url: "/event/2015openevent/doEventSubscript60830.asp",
					data: "mode=talk",
					dataType: "text",
					async: false
				}).responseText;
				if (rstStr.substring(0,2) == "01"){
					$("#talkclear").show();
					$("#talkbefore").hide();
					$("#talkaftercount").html( rstStr.substring(5,15) );
					$("#talkaftercount").show();
					$("#talkafterval").show();
					return false;
				}else if (rstStr.substring(0,2) == "02"){
					$("#talkclear").hide();
					$("#talkbefore").hide();
					$("#talkaftercount").html( rstStr.substring(5,15) );
					$("#talkaftercount").show();
					$("#talkafterval").show();
					return false;
				}else if (rstStr == "98"){
					alert('텐바이텐 스탭이시군요! 죄송합니다. 참여가 어렵습니다. :)');
					return false;
				}else if (rstStr == "99"){
					alert('로그인을 해주세요.');
					return false;
//				}else if (rstStr == "14"){
//					alert('이미 오늘 1,000명이 마일리지를 받으셨습니다.');
//					return false;
				}else if (rstStr == "13"){
					alert('위시리스트를 먼저 담아 주세요.');
					return false;
				}else if (rstStr == "12"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
//				}else if (rstStr == "11"){
//					alert('이미 마일리지를 받으셨습니다.');
//					return false;
				}else{
					alert('정상적인 경로가 아닙니다.');
					return false;
				}
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}

function gobaguni(){
	<% If IsUserLoginOK Then %>
		<% if not( getnowdate>="2015-04-13" and getnowdate<"2015-04-25" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if staffconfirm and  GetLoginUserLevel()=7 then		'		'/M , A				'/WWW %>
				alert("텐바이텐 스탭이시군요! 죄송합니다. 참여가 어렵습니다. :)");
				return;
			<% else %>
				if ( $("#wishclear").css("display")=='none' ){
					alert('위시리스트를 먼저 담아 주세요.');
					return false;
				}
				if ( $("#talkclear").css("display")=='none' ){
					alert('GIFT TALK에 먼저 투표해 주세요.');
					return false;
				}

				var rstStr = $.ajax({
					type: "POST",
					url: "/event/2015openevent/doEventSubscript60830.asp",
					data: "mode=baguni",
					dataType: "text",
					async: false
				}).responseText;
				if (rstStr.substring(0,2) == "01"){
					$("#baguniclear").show();
					$("#bagunibefore").hide();
					$("#baguniaftercount").html( rstStr.substring(5,15) );
					$("#baguniaftercount").show();
					$("#baguniafterval").show();
					return false;
				}else if (rstStr.substring(0,2) == "02"){
					$("#baguniclear").hide();
					$("#bagunibefore").hide();
					$("#baguniaftercount").html( rstStr.substring(5,15) );
					$("#baguniaftercount").show();
					$("#baguniafterval").show();
					return false;
				}else if (rstStr == "98"){
					alert('텐바이텐 스탭이시군요! 죄송합니다. 참여가 어렵습니다. :)');
					return false;
				}else if (rstStr == "99"){
					alert('로그인을 해주세요.');
					return false;
				}else if (rstStr == "15"){
					alert('GIFT TALK에 먼저 투표해 주세요.');
					return false;
//				}else if (rstStr == "14"){
//					alert('이미 오늘 1,000명이 마일리지를 받으셨습니다.');
//					return false;
				}else if (rstStr == "13"){
					alert('위시리스트를 먼저 담아 주세요.');
					return false;
				}else if (rstStr == "12"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
//				}else if (rstStr == "11"){
//					alert('이미 마일리지를 받으셨습니다.');
//					return false;
				}else{
					alert('정상적인 경로가 아닙니다.');
					return false;
				}
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}

function gomileage(){
	<% If IsUserLoginOK Then %>
		<% if not( getnowdate>="2015-04-13" and getnowdate<"2015-04-25" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<%
			'if clng(subscriptcountclear) > 0 or clng(mileagescount) > 0 then
			if clng(subscriptcountclear) > 0 then
			%>
				alert('이미 마일리지를 받으셨습니다.');
				return false;
			<% else %>
				<%
				'if clng(totalsubscriptcountclear) > clng(getmileagelimit) or clng(totalmileagescount) > clng(getmileagelimit) then
				if clng(totalsubscriptcountclear) > clng(getmileagelimit) then
				%>
					alert('이미 오늘 1,000명이 마일리지를 받으셨습니다.');
					return false;
				<% else %>
					<% if staffconfirm and  GetLoginUserLevel()=7 then		'	'/WWW %>
						alert("텐바이텐 스탭이시군요! 죄송합니다. 참여가 어렵습니다. :)");
						return;
					<% else %>
						if ( $("#wishclear").css("display")=='none' ){
							alert('위시리스트를 먼저 담아 주세요.');
							return false;
						}
						if ( $("#talkclear").css("display")=='none' ){
							alert('GIFT TALK에 먼저 투표해 주세요.');
							return false;
						}
						if ( $("#baguniclear").css("display")=='none' ){
							alert('장바구니에 먼저 상품을 담아 주세요.');
							return false;
						}

						var rstStr = $.ajax({
							type: "POST",
							url: "/event/2015openevent/doEventSubscript60830.asp",
							data: "mode=mileage",
							dataType: "text",
							async: false
						}).responseText;
						if (rstStr == "01"){
							alert('3,000 마일리지가 지급 되었습니다.\n삼시세번 이벤트에 참여해주셔서 감사합니다.');
							location.replace('/event/2015openevent/mileage.asp')
							return false;
						}else if (rstStr == "98"){
							alert('텐바이텐 스탭이시군요! 죄송합니다. 참여가 어렵습니다. :)');
							return false;
						}else if (rstStr == "99"){
							alert('로그인을 해주세요.');
							return false;
						}else if (rstStr == "15"){
							alert('GIFT TALK에 먼저 투표해 주세요.');
							return false;
						}else if (rstStr == "16"){
							alert('장바구니에 먼저 상품을 담아 주세요.');
							return false;
						}else if (rstStr == "14"){
							alert('이미 오늘 1,000명이 마일리지를 받으셨습니다.');
							return false;
						}else if (rstStr == "13"){
							alert('위시리스트를 먼저 담아 주세요.');
							return false;
						}else if (rstStr == "12"){
							alert('이벤트 응모 기간이 아닙니다.');
							return false;
						}else if (rstStr == "11"){
							alert('이미 마일리지를 받으셨습니다.');
							return false;
						}else if (rstStr == "17"){
							alert('마일리지 발급은 오전 10시부터 가능합니다.');
							return false;
						}else{
							alert('정상적인 경로가 아닙니다.');
							return false;
						}
					<% end if %>
				<% end if %>
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}

</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">

				<div class="eventContV15">
					<div class="contF contW tMar15">
						<!-- 2015 RENEWAL 사월의 꿀 맛 -->
						<div class="aprilHoney">
							<!-- #include virtual="/event/2015openevent/inc_header.asp" -->

							<!-- 삼시세번 -->
							<div class="honeySection honeyMileage">
								<div class="topic">
									<h3>삼시세번</h3>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_mileage.png" alt="당신과 텐바이텐의 연결고리 3단계 미션을 모두 달성하고 3,000마일리지 받자! 매일 오전 10시부터 1,000명에게 선착순으로 선물합니다." /></p>
									<span class="coin"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/img_deco_coin_left.png" alt="" /></span>
									<span class="floor"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/img_deco_floor.png" alt="" /></span>
									<span class="three"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/img_deco_three.png" alt="" /></span>
									<span class="medal"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/img_deco_medal.png" alt="" /></span>
									<span class="coinright1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/img_deco_coin_right_01.png" alt="" /></span>
									<span class="coinright2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/img_deco_coin_right_02.png" alt="" /></span>
									<span class="m"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/img_deco_mileage.png" alt="" /></span>
									<span class="medal"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/img_deco_medal.png" alt="" /></span>
									<span class="hat animated fadeIn"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/img_deco_hat.png" alt="" /></span>
								</div>

								<div class="eventarea">
									<div class="stepbystep">
										<div class="step step1">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_step_01.png" alt="1단계 의욕충만 : 위시리스트 담기 위시리스트의 공개 폴더 속에 상품을 10개 이상 담아 주세요. (4/13 이후로 담은 기준)" /></p>
											<% '<!-- for dev msg : 미션완료후 보여주세요 --> %>
											<strong class="clear" id="wishclear"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_mission_clear.png" alt="미션완료" /></strong>
											<div class="btnwrap">
												<p>
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_my_wish.png" alt="나의 위시리스트 속 상품은" />
													<% '<!-- for dev msg : 확인 전 --> %>
													<button type="button" id="wishbefore" onclick="gowish();" class="btncheck"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/btn_check.png" alt="확인하기" /></button>
													<% '<!-- for dev msg : 확인 후 --> %>
													<strong id="wishaftercount" style="display:none;">0</strong>
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_count.png" id="wishafterval" style="display:none;" alt="개" />
												</p>
												<a href="/my10x10/popularwish.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/btn_wish.png" alt="위시리스트 채우러 가기" /></a>
											</div>
										</div>
										<div class="step step2">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_step_02.png" alt="2단계 물어보기 : Gift Talk 하기 Gift Talk에서 질문에 3가지 이상 투표를 남겨주세요." /></p>
											<strong class="clear" id="talkclear"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_mission_clear.png" alt="미션완료" /></strong>
											<div class="btnwrap">
												<p>
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_vote.png" alt="내가 남긴 Gift Talk 투표는" />
													<% '<!-- for dev msg : 확인 전 --> %>
													<button type="button" id="talkbefore" onclick="gotalk();" class="btncheck"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/btn_check.png" alt="확인하기" /></button>
													<% '<!-- for dev msg : 확인 후 --> %>
													<strong id="talkaftercount" style="display:none;">0</strong>
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_count.png" id="talkafterval" style="display:none;" alt="개" />
												</p>
												<a href="/gift/talk/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/btn_gift_talk.png" alt="GIFT TALK 투표하러 가기" /></a>
											</div>
										</div>
										<div class="step step3">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_step_03.png" alt="3단계 결제준비 : 장바구니 담기 장바구니 속에 사고 싶은 상품을 5개 이상 담아 주세요. " /></p>
											<strong class="clear" id="baguniclear"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_mission_clear.png" alt="미션완료" /></strong>
											<div class="btnwrap">
												<p>
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_my_shopping_bag.png" alt="나의 장바구니 속 상품은" />
													<% '<!-- for dev msg : 확인 전 --> %>
													<button type="button" id="bagunibefore" onclick="gobaguni();" class="btncheck"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/btn_check.png" alt="확인하기" /></button>
													<% '<!-- for dev msg : 확인 후 --> %>
													<strong id="baguniaftercount" style="display:none;">0</strong>
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_count.png" id="baguniafterval" style="display:none;" alt="개" />
												</p>
												<a href="/award/awardlist.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/btn_put.png" alt="장바구니 채우러 가기" /></a>
											</div>
										</div>
									</div>
								</div>

								<div class="give">
									<%
									'if clng(subscriptcountclear) > 0 or clng(mileagescount) > 0 then
									if clng(subscriptcountclear) > 0 then
									%>
										<% '<!-- for dev msg : 마일리지받기 후 --> %>
										<div class="after">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_thanks.png" alt="삼시세번 이벤트에 참여해주셔서 감사합니다. 적립된 마일리지를 활용해 더욱 즐거운 쇼핑을 즐겨보세요 !" /></p>
											<a href="/shoppingtoday/shoppingchance_allevent.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/btn_go.png" alt="상품 기획전 보러가기" /></a>
										</div>
									<% else %>
										<% '<!-- for dev msg : 마일리지받기 전 --> %>
										<div class="before">
											<button type="button" onclick="gomileage();" class="btngive"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/btn_give_mileage.png" alt="3천 마일리지 주세요" /></button>
											<p>
												<img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_today.png" alt="오늘" />
												<% If Now() > #04/13/2015 10:00:00# Then %>
													<strong><%= CurrFormat(totalsubscriptcountclear) %></strong>
												<% Else %>
													<strong>0</strong>
												<% End If %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_get_mileage.png" alt="명이 마일리지를 받으셨습니다." />
											</p>
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/txt_limited.png" alt="이벤트 기간 중 한 ID 당 1회만 가능합니다. 매일 1,000명 선착순으로 종료 됩니다." /></p>
										</div>
									<% end if %>
								</div>

								<div class="noti">
									<div class="inner">
										<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60830/tit_noti.png" alt="이벤트 유의사항" /></h4>
										<ul>
											<li>텐바이텐 고객님을 위한 이벤트 입니다. (비회원 참여 불가)</li>
											<li>위시리스트는 4월 13일 이후 공개된 폴더에 담긴 상품을 기준으로 적용됩니다.</li>
											<li>마일리지 지급은 매일 오전 10시 부터 선착순으로 1,000명에게 지급됩니다.</li>
											<li>미션은 1단계부터 차례대로 수행해주세요.</li>
											<li>한 ID 당 1회만 마일리지를 지급받을 수 있습니다.</li>
											<li>장바구니 속에 담긴 상품은 14일 동안만 보관됩니다.</li>
										</ul>
									</div>
								</div>
							</div>

						</div>
						<!--// 2015 RENEWAL 사월의 꿀 맛 -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->