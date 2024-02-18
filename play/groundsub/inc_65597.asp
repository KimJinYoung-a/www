<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 텐바이텐여름 인스타그램
' History : 2015.08.14 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->

<%
Dim eCode, eCodedisp
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64853
	eCodedisp = 64853
Else
	eCode   =  65597
	eCodedisp = 65597
End If

dim userid, i, vreload
	userid = getloginuserid()
	vreload	= requestCheckVar(Request("reload"),2)

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt, sqlstr
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 4		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 15	'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 15	'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'// sns데이터 총 카운팅 가져옴
sqlstr = "select count(*) "
sqlstr = sqlstr & " from [db_Appwish].[dbo].[tbl_snsSelectData]"
sqlstr = sqlstr & " Where evt_code="& eCode &""

'response.write sqlstr & "<br>"
rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
	iCTotCnt = rsCTget(0)
rsCTget.close

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
img {vertical-align:top;}
.groundHeadWrap {width:100%; background-image:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_head_sky.jpg);}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:95px 20px 0;}
.summerCont {position:relative; width:1140px; margin:0 auto;}
.playGr20150817 {overflow:hidden; text-align:center;}
.intro {position:relative; height:980px; background:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_cont_sky.jpg) 0 0 repeat-y; background-size:100% auto;}
.intro h2 span {position:absolute; z-index:40; margin-left:10px; opacity:0;}
.intro h2 span.t01 {left:285px; top:321px;}
.intro h2 span.t02 {left:429px; top:310px;}
.intro h2 span.t03 {left:613px; top:310px;}
.intro h2 span.t04 {left:782px; top:281px;}
.intro .wave {position:absolute; left:435px; top:472px; width:0; height:16px; background:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_wave.png) 0 0 no-repeat; z-index:40;}
.intro .sea {position:absolute; left:0; top:0; width:100%; height:980px; background:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_sea.jpg) 0 0 no-repeat; z-index:30; opacity:0;}
.purpose {width:100%; height:0; text-align:left; background:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_bar.png) 0 0 repeat; z-index:50;}
.purpose .shareBtn {position:absolute; right:57px; top:55px;}
.purpose .summerCont {padding-top:62px;}
.purpose p {padding:0 0 35px 80px;}
.yourSummer {padding:94px 0 90px; background:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_noise.gif) 0 0 repeat;}
.yourSummer ul {position:relative; overflow:hidden; width:1706px; height:1417px; margin:195px auto 0;}
.yourSummer li {position:absolute; width:286px;}
.yourSummer li p {padding:16px 14px 0 0; font-size:13px; line-height:13px; color:#999; text-align:right; font-weight:bold;}
.yourSummer li em {color:#6e9ba3; letter-spacing:0.02em; padding-right:3px;}
.yourSummer .pic {width:274px; height:274px; padding:12px 0 0 12px; text-align:left; background:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_box.png) 0 0 no-repeat;}
.yourSummer .pic img {width:260px; height:260px;}
.yourSummer .pageMove {display:none;}
.applyEvent {height:702px; background:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_gradation.jpg) 0 0 repeat-x;}
.applyEvent h3 {padding:84px 0 25px;}
.packageInfo {background:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_line.gif) 50% 0 no-repeat;}
.packageInfo .summerCont {padding:272px 0; background:url(http://webimage.10x10.co.kr/play/ground/20150817/bg_line02.gif) 50% 100% no-repeat;}
.packageInfo h3 {position:absolute; left:343px; top:239px; z-index:30;}
.slide {position:relative; width:100%;}
.slide img {width:100%;}
.slidesjs-pagination {position:absolute; left:50%; bottom:6.5%; width:258px; margin-left:-128px; z-index:30;}
.slidesjs-pagination li {float:left; width:56px; padding:0 4px;}
.slidesjs-pagination li a {display:block; height:20px; background:url(http://webimage.10x10.co.kr/play/ground/20150817/btn_pagination.png) 0 0 no-repeat; text-indent:-9999px;}
.slidesjs-pagination li a.active {background-position:100% 0;}
</style>
<script>
$(function(){
	// slide
	$('.slide').slidesjs({
		width:"1920",
		height:"1140",
		navigation:false,
		pagination:{effect:"fade"},
		play: {interval:3200, effect:"fade", auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$(".shareBtn").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
	function moveBtn () {
		$(".shareBtn").animate({"margin-top":"10px"},600).animate({"margin-top":"0"},600, moveBtn);
	}
	$('.yourSummer li:nth-child(1)').css({'left':'0', 'top':'0'});
	$('.yourSummer li:nth-child(2)').css({'left':'355px', 'top':'183px'});
	$('.yourSummer li:nth-child(3)').css({'left':'710px', 'top':'0'});
	$('.yourSummer li:nth-child(4)').css({'left':'1065px', 'top':'183px'});
	$('.yourSummer li:nth-child(5)').css({'left':'1420px', 'top':'0'});
	$('.yourSummer li:nth-child(6)').css({'left':'0', 'top':'396px'});
	$('.yourSummer li:nth-child(7)').css({'left':'355px', 'top':'578px'});
	$('.yourSummer li:nth-child(8)').css({'left':'710px', 'top':'396px'});
	$('.yourSummer li:nth-child(9)').css({'left':'1065px', 'top':'578px'});
	$('.yourSummer li:nth-child(10)').css({'left':'1420px', 'top':'396px'});
	$('.yourSummer li:nth-child(11)').css({'left':'0', 'top':'790px'});
	$('.yourSummer li:nth-child(12)').css({'left':'355px', 'top':'973px'});
	$('.yourSummer li:nth-child(13)').css({'left':'710px', 'top':'790px'});
	$('.yourSummer li:nth-child(14)').css({'left':'1065px', 'top':'973px'});
	$('.yourSummer li:nth-child(15)').css({'left':'1420px', 'top':'790px'});
	$('.yourSummer li:gt(4)').css({'margin-top':'10px','opacity':'0'});
	function myPic() {
		$('.yourSummer li:nth-child(6)').animate({"opacity":"1","margin-top":"0"}, 600);
		$('.yourSummer li:nth-child(7)').delay(400).animate({"opacity":"1","margin-top":"0"}, 600);
		$('.yourSummer li:nth-child(8)').delay(600).animate({"opacity":"1","margin-top":"0"}, 600);
		$('.yourSummer li:nth-child(9)').delay(200).animate({"opacity":"1","margin-top":"0"}, 600);
		$('.yourSummer li:nth-child(10)').delay(800).animate({"opacity":"1","margin-top":"0"}, 600);
		$('.yourSummer li:nth-child(11)').delay(1800).animate({"opacity":"1","margin-top":"0"}, 600);
		$('.yourSummer li:nth-child(12)').delay(1200).animate({"opacity":"1","margin-top":"0"}, 600);
		$('.yourSummer li:nth-child(13)').delay(1400).animate({"opacity":"1","margin-top":"0"}, 600);
		$('.yourSummer li:nth-child(14)').delay(1800).animate({"opacity":"1","margin-top":"0"}, 600);
		$('.yourSummer li:nth-child(15)').delay(1600).animate({"opacity":"1","margin-top":"0"}, 600);
	}
	function intro() {
		$('.intro .sea').animate({"opacity":"1"}, 2500);
		$('.intro .wave').delay(1200).animate({"width":"273px"}, 3000);
		$('.intro .t01').delay(1200).animate({"margin-left":"0","opacity":"1"}, 1200);
		$('.intro .t02').delay(1500).animate({"margin-left":"0","opacity":"1"}, 1200);
		$('.intro .t03').delay(1800).animate({"margin-left":"0","opacity":"1"}, 1200);
		$('.intro .t04').delay(2100).animate({"margin-left":"0","opacity":"1"}, 1200);
	}
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 200 ) {
			intro();
		}
		if (scrollTop > 1200 ) {
			$('.purpose').animate({"height":"324px"}, 1000);
			moveBtn();
		}
		if (scrollTop > 2000 ) {
			myPic ();
		}
	});

	<% if vreload<>"" then %>
		$('html,body').animate({scrollTop: $("#instagram").offset().top},'slow');
	<% end if %>
});

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

</script>
</head>
<body>

<!-- SUMMER #2 -->
<div class="playGr20150817">
	<div class="intro">
		<div class="summerCont">
			<h2>
				<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150817/tit_summer01.png" alt="그" /></span>
				<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150817/tit_summer02.png" alt="해" /></span>
				<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20150817/tit_summer03.png" alt="여" /></span>
				<span class="t04"><img src="http://webimage.10x10.co.kr/play/ground/20150817/tit_summer04.png" alt="름" /></span>
			</h2>
			<div class="wave"></div>
		</div>
		<div class="sea"></div>
	</div>
	<div class="yourSummer">
		<div class="purpose">
			<div class="textBar">
				<div class="summerCont">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150817/txt_purpose01.png" alt="여김없이 돌아온 무더위를 보내며, 문득 여러분의 여름이 궁금해졌습니다. 휴가를 떠나 시원하게 보내고 계신가요? 혹은 떠나지 않더라도 나만의 특별한 여름을 즐기고 계신가요?" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150817/txt_purpose02.png" alt="텐바이텐이 선물한 그해 여름 패키지를 통해 여러분의 기억 속 올해 여름을 간직하고, 설레는 마음으로 내년에 다시 돌아올 여름을 기대해보세요." /></p>
					<a href="#applyEvent" class="shareBtn"><img src="http://webimage.10x10.co.kr/play/ground/20150817/btn_share.png" alt="여름 사진 공유 하기" /></a>
				</div>
			</div>
		</div>
		<% '<!-- 인스타그램 이미지 불러오기 --> %>
		<div class="instagram" id="instagram">
			<%
			sqlstr = "Select * From "
			sqlstr = sqlstr & " ( "
			sqlstr = sqlstr & " 	Select row_Number() over (order by idx desc) as rownum, snsid, link, img_low, img_thum, img_stand, text, snsuserid, snsusername, regdate "
			sqlstr = sqlstr & " 	From db_AppWish.dbo.tbl_snsSelectData "
			sqlstr = sqlstr & " 	Where evt_code="& eCode &""
			sqlstr = sqlstr & " ) as T "
			sqlstr = sqlstr & " Where RowNum between "&(iCCurrpage*iCPageSize)-14&" And "&iCCurrpage*iCPageSize&" "
			
			'response.write sqlstr & "<br>"
			rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
			If Not(rsCTget.bof Or rsCTget.eof) Then
			%>
				<ul>
					<%
					Do Until rsCTget.eof
					%>
					<% '15개 뿌리기 %>
					<li>
						<div class="pic">
							<a href="<%=rsCTget("link")%>"  target="_blank">
							<img src="<%=rsCTget("img_stand")%>" alt=""></a>
						</div>
						<p><em><%= printUserId(rsCTget("snsusername"),2,"*") %></em>님의 여름</p>
					</li>
					<%
					rsCTget.movenext
					Loop
					%>
				</ul>
				<div class="pageWrapV15 tMar20">
					<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,10,"jsGoComPage") %>
				</div>
			<%
			End If
			rsCTget.close
			%>
		</div>
		<% '<!--// 인스타그램 이미지 불러오기 --> %>
	</div>
	<!-- 이벤트 참여 -->
	<div class="applyEvent" id="applyEvent">
		<div class="summerCont">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150817/tit_apply.png" alt="그해 여름 이벤트 참여방법" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150817/txt_apply.png" alt="1. 기억으로 남기고픈 여름 사진을 촬영하거나 선택합니다./2. 인스타그램에 #텐바이텐여름 해시태그와 함께 업로드합니다." /></p>
			<p style="padding-top:32px;"><img src="http://webimage.10x10.co.kr/play/ground/20150817/txt_event_gift.png" alt="추첨을 통해 3분에게 그해 여름 PACKAGE를 선물로 드립니다! 이벤트기간:2015년 8월17일~8월 31일/당첨자발표:2015년 9월 1일" /></p>
			<p style="padding-top:56px;"><img src="http://webimage.10x10.co.kr/play/ground/20150817/txt_event_noti.png" alt="NOTICE - 1.인스타그램 계정이 비공개인 경우, 집계가 되지 않습니다./2.이벤트 기간 동안 #텐바이텐여름 해시태그로 업로드 한 사진을 이벤트 참여를 의미하며, 텐바이텐 플레이 페이지에 노출됨을 동의하는 것으로 간주합니다." /></p>
		</div>
	</div>
	<!--// 이벤트 참여 -->
	<div class="packageInfo">
		<div class="summerCont">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150817/tit_package.gif" alt="그해 여름 PACKAGE" /></h3>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150817/img_package.jpg" alt="그해 여름 패키지에는 사진 인화 상품권, 액자 10개 세트, 인화 사진 1장이 포함되어 있습니다." /></div>
		</div>
	</div>
	<div class="slide">
		<div><img src="http://webimage.10x10.co.kr/play/ground/20150817/img_slide01.jpg" alt="" /></div>
		<div><img src="http://webimage.10x10.co.kr/play/ground/20150817/img_slide02.jpg" alt="" /></div>
		<div><img src="http://webimage.10x10.co.kr/play/ground/20150817/img_slide03.jpg" alt="" /></div>
		<div><img src="http://webimage.10x10.co.kr/play/ground/20150817/img_slide04.jpg" alt="" /></div>
	</div>
</div>
<!-- // SUMMER #2 -->
<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
	<input type="hidden" name="iCC" value="1">
	<input type="hidden" name="reload" value="ON">
	<input type="hidden" name="iCTot" value="<%= iCTotCnt %>">
</form>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbCTclose.asp" -->