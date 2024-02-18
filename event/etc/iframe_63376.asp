<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  신나는 예술, 즐거운 기부! [ Mr. Gibro ] 
' History : 2015.06.09 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->

<%
dim nowdate
dim eCode, ename, userid, sub_idx, i, intCLoop, leaficonimg
	userid = getloginuserid()
dim iCPerCnt, iCPageSize, iCCurrpage
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호

	nowdate = date()
'	nowdate = "2015-06-10"		'''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  63782
	Else
		eCode   =  63376
	End If

	IF iCCurrpage = "" THEN iCCurrpage = 1
	iCPageSize = 12		' 한페이지에 보여지는 댓글 수
	iCPerCnt = 10		'한페이지에 보여지는 페이징번호 1~10
	
	dim ccomment, cEvent
	set ccomment = new Cevent_etc_common_list
		ccomment.FPageSize        = iCPageSize
		ccomment.FCurrpage        = iCCurrpage
		ccomment.FScrollCount     = iCPerCnt
		ccomment.event_subscript_one
		ccomment.frectordertype="new"
		ccomment.frectevt_code    = eCode
		ccomment.event_subscript_paging
	
	set cEvent = new ClsEvtCont
		cEvent.FECode = eCode
		cEvent.fnGetEvent
		
		eCode		= cEvent.FECode	
		ename		= cEvent.FEName
	set cEvent = nothing

%>
<style type="text/css">
img {vertical-align:top;}
.evt63376 {background-color:#fff; text-align:center;}
.topic {height:466px; background:#fecd1a url(http://webimage.10x10.co.kr/eventIMG/2015/63376/bg_pattern_yellow.png) no-repeat 0 0;}
.topic .collabo {position:absolute; top:0; left:25px;}
.topic h1 {position:absolute; top:100px; left:50%; width:688px; margin-left:-344px;}
.topic h1 span {position:absolute; top:0; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/63376/bg_title.png) no-repeat 0 0; text-indent:-999em;}
.letter1, .letter2, .letter3, .letter4, .letter5, .letter6, .letter7 {height:78px;}
.topic h1 .letter1 {left:0; width:53px;}
.topic h1 .letter2 {left:60px; width:140px; background-position:-60px 0;}
.topic h1 .letter3 {left:212px; width:96px; background-position:-212px 0;}
.topic h1 .letter4 {left:311px; width:65px; background-position:-311px 0;}
.topic h1 .letter5 {left:384px; width:142px; background-position:-384px 0;}
.topic h1 .letter6 {left:536px; width:95px; background-position:-536px 0;}
.topic h1 .letter7 {right:0; width:53px; background-position:100% 0;}
.topic h1 .letter8 {top:78px; left:0; width:688px; height:164px; background-position:100% 100%;}
.letter4 { -webkit-animation-name:bounce; -webkit-animation-iteration-count:8; -webkit-animation-duration:1s; -moz-animation-name:bounce; -moz-animation-iteration-count:8; -moz-animation-duration:1s; -ms-animation-name:bounce; -ms-animation-iteration-count:8; -ms-animation-duration:1s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:7px; -webkit-animation-timing-function:ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:7px; animation-timing-function:ease-in;}
}


.rolling {height:698px; background:#fed61f url(http://webimage.10x10.co.kr/eventIMG/2015/63376/bg_pattern_yellow.png) no-repeat 0 -466px;}
.slide-wrap {position:relative; width:920px; margin:0 auto;}
.slide {height:522px;}
.slide img {height:522px;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:29px; height:47px; margin-top:-23px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/63376/btn_nav.png); background-repeat:no-repeat; text-indent:-999em;}
.slide .slidesjs-previous {left:-48px; background-position:0 0;}
.slide .slidesjs-next {right:-48px; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:-30px; left:50%; z-index:50; width:130px; margin-left:-65px;}
.slidesjs-pagination li {float:left; padding:0 6px;}
.slidesjs-pagination li a {display:block; width:14px; height:14px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/63376/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:100% 0;}
.btnget {margin-top:46px;}
.btnget:hover {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-name:flash; animation-name:flash; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
/* flash animation */
@-webkit-keyframes flash {
	0% {opacity:0.5;}
	100% {opacity:1;}
}
@keyframes flash {
	0% {opacity:0.5;}
	100% {opacity:1;}
}

.howto {position:relative; height:384px; padding-top:62px; background-color:#fff33b;}
.howto p {position:relative; z-index:10; margin-top:38px;}
.howto .arrow {position:absolute; top:172px; left:74px; z-index:5;}

.commentevt {height:313px; padding-top:56px; background:#eaf4f7 url(http://webimage.10x10.co.kr/eventIMG/2015/63376/bg_pattern_grey.png) no-repeat 0 0;}
.field {position:relative; width:848px; margin:36px auto 0; text-align:left;}
.field textarea {width:646px; height:38px; padding:15px; border:2px solid #ff7814; color:#777; font-size:12px;}
.field .btnsubmit {position:absolute; top:0; right:0;}

.count {position:relative; margin-bottom:2px; border-bottom:1px solid #ffe65e;}
.count strong {position:absolute; top:28px; left:501px; width:98px; height:30px; color:#ff7814; font-size:20px; font-family:'Verdana', 'Dotum', '돋움'; font-weight:normal; line-height:30px; text-align:center;}

.commentwrap { padding:50px 0 20px; border-top:1px solid #ffe65e; border-bottom:1px solid #ffe65e;}
.commentlist {overflow:hidden; width:1160px; margin-right:-20px;}
.commentlist .col {float:left; position:relative; width:270px; height:235px; margin-right:20px; margin-bottom:30px; padding-top:35px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/63376/bg_pig.png); background-repeat:no-repeat; font-size:11px;}
.commentlist .col2 {background-position:100% 0;}
.commentlist .col .no, .commentlist .col .id, .commentlist .col .date {display:block; color:#fff; font-family:'Verdana', 'Dotum', '돋움';}
.commentlist .col .no {margin-bottom:16px; line-height:20px;}
.commentlist .col .no img {margin-right:8px;}
.commentlist .col .id {margin-top:13px;}
.btndel {position:absolute; top:11px; right:46px; width:28px; height:28px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/63376/btn_del.png) no-repeat 50% 0; text-indent:-999em;}
.scrollbarwrap .overview .msg {color:#000; line-height:2em; letter-spacing:-0.05em;}
/* tiny scrollbar */
.scrollbarwrap {width:186px; margin:0 auto;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:180px; height:132px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#f1f1f1;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#f1f1f1;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#3f3f3f; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}

.pageWrapV15 {margin-top:2px; padding-top:40px; border-top:1px solid #ffe65e;}
.pageWrapV15 .pageMove {display:none; /*top:40px;*/}
</style>
<script type="text/javascript">
<% if Request("iCC") <> "" then %>
	$(function(){
		window.parent.$('html,body').animate({scrollTop:$(commentdiv).offset().top+310}, 200);
	});
<% end if %>

function jsSubmitComment(frm){      //코멘트 입력
	<% If IsUserLoginOK() Then %>
		<% If Now() > #09/30/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If nowdate>="2015-06-16" and nowdate<"2015-10-01" Then %>
				if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 200 || frm.txtcomm.value == '100글자 이내로 남겨주세요.'){
					alert("코멘트가 없거나 제한길이를 초과하였습니다.(100자 이하로 써주세요)");
					frm.txtcomm.focus();
					return;
				}

		   		frm.mode.value="addcomment";
				frm.action="/event/etc/doeventsubscript/doEventSubscript63376.asp";
				frm.target="evtFrmProc";
				frm.submit();
				return;
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>				
		<% End If %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jsDelComment(sub_idx)	{
	if(confirm("삭제하시겠습니까?")){
		frmcomm.sub_idx.value = sub_idx;
		frmcomm.mode.value="delcomment";
		frmcomm.action="/event/etc/doeventsubscript/doEventSubscript63376.asp";
		frmcomm.target="evtFrmProc";
   		frmcomm.submit();
	}
}

function jsGoComPage(iP){
	document.frmcomm.iCC.value = iP;
	document.frmcomm.submit();
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}
	
	if (frmcomm.txtcomm.value == '100글자 이내로 남겨주세요.'){
		frmcomm.txtcomm.value='';
	}
}
</script>
</head>
<body>
	<!-- 신나는 예술, 즐거운 기부! Mr. Gibro -->
	<div class="evt63376">
		<div class="topic">
			<p class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/txt_collabo.png" alt="텐바이텐과 서울문화재단" /></p>
			<h1>
				<span class="letter1"></span>
				<span class="letter2">신나는</span>
				<span class="letter3">예술</span>
				<span class="letter4"></span>
				<span class="letter5">즐거운</span>
				<span class="letter6">기부</span>
				<span class="letter7"></span>
				<span class="letter8">Mr. Gibro</span>
			</h1>
		</div>

		<div class="rolling">
			<div class="slide-wrap">
				<div id="slide1" class="slide">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/img_slide_01.png" alt="기부는 또 하나의 예술! Mr. Gibro 를 소개합니다." /></p>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/img_slide_02.png" alt="소외계층의 문화활동을 돕고 어려운 예술가들을 후원하기 위해 태어났어요." /></p>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/img_slide_03.png" alt="동전으로 미스터 기부로를 채우고, 표면에는 보드마카를 사용해서 그림을 그려 주세요." /></p>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/img_slide_04.png" alt="모아진 기부로 저금통은 서울시청 앞에서 또 다른 예술 작품으로 태어나게 될 예정입니다." /></p>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/img_slide_05.png" alt="예술을 후원하는 캠페인, 미스터 기부로와 함께 소중한 움직임에 동참해주세요!" /></p>
				</div>
			</div>

			<!-- for dev msg : 링크 -->
			<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1301039" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/btn_get.png" alt="미스터 기부로 구매하러 가기" /></a></div>
		</div>

		<div class="howto">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/tit_howto.png" alt="미스터 기부로는 이렇게 사용하세요!" /></h2>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/txt_howto.png" alt="텐바이텐에서 미스터 기부로 구입한 후 저금통 표면에 그림을 그려 나만의 기부로를 만들고 미스터 기부로를 알뜰살뜰 동전으로 가둑 채운 후 가득찬 저금통을 보내고 새로운 기부로를 받으세요" /></p>
			<div class="arrow"><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/img_arrow.png" alt="" /></div>
		</div>

		<div class="good">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/txt_good.png" alt="미스터 기부로는 이런 점이 좋아요! 저금통을 다 채워서 서울문화재단으로 보내주시면 새로운 기브로를 받을 수 있어요. 저금통의 금액은 소외계층의 문화활동 지원을 위한 기부금으로 사용하게 되죠. 서울시청 등지에서 예쁘게 꾸며진 기부로가 전시되어 누군가에게 즐거움을 줄거에요." /></p>
		</div>

		<!-- for dev msg : comment -->
		<div class="commentevt">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/txt_comment.png" alt="미스터 기부로에게 메시지를 남기고 기부하세요! 작성해주신 응원의 메시지는 1개당 100원씩 서울문화재단에 기부됩니다." /></p>
			<div class="field">
				<form name="frmcomm" action="" onsubmit="return false;" method="post" style="margin:0px;">
				<input type="hidden" name="mode">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="sub_idx">
					<fieldset>
					<legend>미스터 기부로에게 메시지를 남기기</legend>
						<textarea cols="60" rows="3" title="응원 메시지 입력" name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <% IF NOT(IsUserLoginOK) THEN %>readonly<% END IF %>><% IF NOT IsUserLoginOK THEN %>로그인 후 글을 남길 수 있습니다.<% else %>100글자 이내로 남겨주세요.<% END IF %></textarea>
						<div class="btnsubmit"><input type="image" onclick="jsSubmitComment(frmcomm); return false;" src="http://webimage.10x10.co.kr/eventIMG/2015/63376/btn_submit.png" alt="등록하기" /></div>
					</fieldset>
				</form>
			</div>
		</div>

		<!-- for dev msg : count -->
		<div class="count" id="commentdiv">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/txt_count.png" alt="현재 총 메시지" />
			<strong><%= ccomment.ftotalcount %></strong>
		</div>

		<% IF ccomment.ftotalcount>0 THEN %>
			<!-- comment list -->
			<div class="commentwrap">
				<div class="commentlist">
					<!-- for dev msg : 한페이지당 12개 -->
					<% for i = 0 to ccomment.fresultcount - 1 %>
						<div class="col col<%= i mod 2+1 %>">
							<strong class="no"><% if ccomment.FItemList(i).fdevice = "M" then %><img src="http://webimage.10x10.co.kr/eventIMG/2015/63376/ico_mobile.png" alt="모바일에서 작성" /><% end if %>No.<%=ccomment.FTotalCount-i-(ccomment.FPageSize*(ccomment.FCurrPage-1))%></strong>
							<div class="scrollbarwrap">
								<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
								<div class="viewport">
									<div class="overview">
										<p class="msg"><%= ReplaceBracket(ccomment.FItemList(i).fsub_opt3) %></p>
									</div>
								</div>
							</div>
							<strong class="id"> <%= printUserId(ccomment.FItemList(i).fuserid,2,"*") %></strong>
							<span class="date"><%=FormatDate(ccomment.FItemList(i).fregdate,"0000-00-00")%></span>
							<% if ((userid = ccomment.FItemList(i).fuserid) or (userid = "10x10")) and ( ccomment.FItemList(i).fuserid<>"") then %>
								<button type="butotn" class="btndel" onclick="jsDelComment('<%= ccomment.FItemList(i).fsub_idx %>'); return false;">삭제</button>
							<% End If %>
						</div>
					<% next %>
				</div>
			</div>
			
			<div class="pageWrapV15">
				<!-- paging -->
				<%= fnDisplayPaging_New(ccomment.FCurrpage, ccomment.ftotalcount, ccomment.FPageSize, ccomment.FScrollCount,"jsGoComPage") %>
			</div>
		<% end if %>
	</div>
	<!-- //신나는 예술, 즐거운 기부! Mr. Gibro -->
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});
$(function(){
	$('#slide1').slidesjs({
		width:"920",
		height:"522",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:1500, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide1').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	animation();
		$(".topic h1 span").css({"opacity":"0"});
		$(".topic h1 .letter8").css({"top":"88px"});
	function animation () {
		$(".topic h1 .letter2").delay(200).animate({"opacity":"1"},300);
		$(".topic h1 .letter3").delay(600).animate({"opacity":"1"},300);
		$(".topic h1 .letter5").delay(1000).animate({"opacity":"1"},300);
		$(".topic h1 .letter6").delay(1500).animate({"opacity":"1"},300);
		$(".topic h1 .letter8").delay(2000).animate({"opacity":"1", "top":"78px"},600);
		$(".topic h1 .letter4").delay(3700).animate({"opacity":"1"},300);
		$(".topic h1 .letter1").delay(2500).animate({"opacity":"1"},300);
		$(".topic h1 .letter7").delay(2800).animate({"opacity":"1"},300);
	}

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1200){
			animation1();
		}
	});

	$(".howto div").css({"width":"0", "opacity":"0"});
	function animation1 () {
		$(".howto div").delay(200).animate({"opacity":"1"},300);
		$(".howto div").delay(500).animate({"width":"1007px"},800);
	}
});
</script>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width="0" height="0"></iframe>
</body>
</html>
<% set ccomment=nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->