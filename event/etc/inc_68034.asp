<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'###########################################################
' Description : 선물포장 이벤트 i 선물 u
' History : 2015.12.10 원승현
'###########################################################

dim eCode, cnt, sqlStr, couponkey, regdate, gubun, arrList, i, totalsum, linkeCode, imgLoop, imgLoopVal, irdsite20, arrRdSite, vUserID, evtCnt, giftCnt
	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "65980"
	Else
		eCode 		= "68034"
	End If

	vUserID = GetEncLoginUserID

	If IsUserLoginOK Then
		'// 선물포장 이벤트 신청자인지 확인한다.
		sqlstr = "Select count(sub_idx) as cnt" &_
				" From db_event.dbo.tbl_event_subscript" &_
				" WHERE evt_code='" & eCode & "' and userid='" & vUserID & "'"
				'response.write sqlstr
		rsget.Open sqlStr,dbget,1
			evtCnt = rsget(0)
		rsget.Close

		'// 선물포장 신청 대상자인지 확인한다.
		sqlstr = " select count(distinct m.userid) "
		sqlstr = sqlstr & " from db_order.dbo.tbl_order_master as m "                                                                                                                                                                                                                                                                                                                                                                                     
		sqlstr = sqlstr & " inner join db_order.dbo.tbl_order_detail as d "
		sqlstr = sqlstr & " on m.orderserial=d.orderserial "
		sqlstr = sqlstr & " where m.jumundiv<>'9' and m.ipkumdiv > 3 and m.cancelyn = 'N' "
		sqlstr = sqlstr & " and d.cancelyn<>'Y' and d.itemid<>'0' "
		sqlstr = sqlstr & " and m.regdate >= '2015-12-14' And ordersheetyn='P' And m.userid='"&vUserID&"' "
		rsget.Open sqlStr,dbget,1
			giftCnt = rsget(0)
		rsget.close

		'// 선물포장 신청 총 카운트
		sqlstr = "Select count(sub_idx) as cnt" &_
				" From db_event.dbo.tbl_event_subscript" &_
				" WHERE evt_code='" & eCode & "' "
				'response.write sqlstr
		rsget.Open sqlStr,dbget,1
			totalsum = rsget(0)
		rsget.Close
	End If
%>
<style type="text/css">
img {vertical-align:top;}

.contF {background-color:#fff;}
.evt68034 {min-height:2351px; background:#fef7ca url(http://webimage.10x10.co.kr/eventIMG/2015/68034/bg_pattern.png) no-repeat 50% 0;}
.evt68034 button {background-color:transparent;}
.hwrap {overflow:hidden; position:relative; }
.hwrap .line {position:absolute; top:24px; left:50%; width:745px; height:1px; background-color:#fbe98b; opacity:0.8;}
.hwrap .lineL {margin-left:-960px;}
.hwrap .lineR {margin-left:214px;}

.topic {position:relative; height:467px;}
.topic .ribon {position:absolute; top:55px; left:50%; margin-left:-172px;}
.topic .hwrap {position:absolute; top:213px; left:50%; width:379px; height:184px; margin-left:-189px;}
.topic .hwrap h2 span {position:absolute; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68034/tit_i_present_u.png) no-repeat 0 0; text-indent:-9999em;}
.topic .hwrap h2 .letter1 {top:0; left:0; width:379px; height:19px;}
.topic .hwrap h2 .letter2 {top:50px; left:0; width:82px; height:91px; background-position:0 -50px;}
.topic .hwrap h2 .letter3 {top:50px; left:94px; width:163px; height:91px; background-position:-94px -50px;}
.topic .hwrap h2 .letter4 {top:50px; left:275px; width:104px; height:91px; background-position:-275px -50px;}
.topic .hwrap p {position:absolute; top:169px; left:0; width:379px; height:15px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68034/tit_i_present_u.png) no-repeat 0 100%; text-indent:-9999em;}

.good p {margin-top:71px;}
.good .checkList {position:relative; width:1040px; height:178px; margin:72px auto 0; text-align:left;}
.good .checkList h4 {position:absolute; top:36px; left:139px;}
.good .checkList ul {margin-left:379px; padding-top:26px;}
.good .checkList ul li {margin-bottom:20px; padding-left:14px; color:#727272; font-family:'Gulim', 'Verdana'; line-height:1.5em; text-indent:-14px;}
.good .checkList ul li u {color:#e24a4a;}

.preview {position:relative; padding-top:110px; padding-bottom:92px;}
.preview .hwrap .lineL {margin-left:-973px;}
.preview .hwrap .lineR {margin-left:227px;}
.preview .btnGo {position:absolute; bottom:70px; left:50%; margin-left:-520px;}

.slideWrap {width:1068px; margin:60px auto 0;}
.slide {overflow:visible !important; position:relative; height:685px !important; margin-left:-28px;}
.slidesjs-container {height:685px !important;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:0; right:12px; z-index:50;}
.slidesjs-pagination li {float:left; padding-left:4px;}
.slidesjs-pagination li a {display:block; width:14px; height:14px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68034/btn_pagination.png) no-repeat 0 0; text-indent:-999em; transition:all 0.7s;}
.slidesjs-pagination li a.active {background-position:0 100%;}
.slide .btnClick {position:absolute; z-index:50;}
.slide .step1 .btnClick {top:523px; left:520px; width:193px; height:133px;}
.slide .step1 .btnClick img {padding-top:43px; padding-left:7px;}
.slide .step2 .btnClick {top:349px; left:437px; width:223px; height:135px;}
.slide .step2 .btnClick img {padding-top:46px; padding-left:25px;}
.slide .step3 .btnClick {top:528px; left:210px; width:680px; height:145px;}
.slide .step3 .btnClick img {padding-top:55px; padding-left:25px;}
.slide .step3 .typing {position:absolute; top:380px; left:235px;}
.typing {overflow:hidden; width:150px; color:#555; font-family:'Dotum', 'Verdana'; font-size:11px; text-align:left; white-space:nowrap;}
.typing {animation:type 2.5s steps(60, end);}
.typing span{animation: blink 1s infinite;}

@keyframes type{ 
	from {width:0;}
}

@keyframes type2{
	0%{width:0;}
	50%{width:0;}
	100%{width:100;}
}

@keyframes blink{
	to{opacity:.0;}
}

.slide .step4 .ico {position:absolute; top:502px; left:930px;}

.event .hwrap .lineL {margin-left:-950px;}
.event .hwrap .lineR {margin-left:204px;}
.event .desc {position:relative; width:758px; margin:68px auto 0; text-align:left;}
.event .desc .btnEvent {position:absolute; top:29px; right:0;}
.event .desc .btnEvent:hover {animation-name:shake; animation-duration:5s; animation-fill-mode:both; animation-iteration-count:infinite;}
@keyframes shake {
	0%, 100% {transform: translateX(0);}
	10%, 30%, 50%, 70%, 90% {transform: translateX(-5px);}
	20%, 40%, 60%, 80% {transform: translateX(10px);}
}

/* css3 animation */
@keyframes updown {
	0%, 20%, 50%, 60%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-10px);}
	60% {transform: translateY(-5px);}
}
.updown {animation-duration:5s; animation-name:updown; animation-iteration-count:infinite;}

@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}
.twinkle {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:1s; animation-fill-mode:both;}
</style>

<script type="text/javascript">

	function checkform(){
		<% If vUserID = "" Then %>
			if ("<%=IsUserLoginOK%>"=="False") {
				if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
					var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
					winLogin.focus();
					return;
				}
			}
		<% End If %>
		<% If vUserID <> "" Then %>
			<% If Now() >= #12/10/2015 10:00:00# And now() < #01/01/2016 00:00:00# Then %>
				<% if evtCnt > 0 then %>
					alert("마일리지 페이백 신청은 1회만 가능합니다.");
					return;				
				<% else %>
					<% if giftCnt > 0 then %>
						$.ajax({
							type:"GET",
							url:"/event/etc/doEventSubscript68034.asp",
							dataType: "text",
							async:false,
							cache:true,
							success : function(Data, textStatus, jqXHR){
								if (jqXHR.readyState == 4) {
									if (jqXHR.status == 200) {
										if(Data!="") {
											var str;
											for(var i in Data)
											{
												 if(Data.hasOwnProperty(i))
												{
													str += Data[i];
												}
											}
											str = str.replace("undefined","");
											res = str.split("|");
											if (res[0]=="OK")
											{
												okMsg = res[1].replace(">?n", "\n");
												alert(okMsg);
												return false;
											}
											else
											{
												errorMsg = res[1].replace(">?n", "\n");
												alert(errorMsg);
												document.location.reload();
												return false;
											}
										} else {
											alert("잘못된 접근 입니다.");
											document.location.reload();
											return false;
										}
									}
								}
							},
							error:function(jqXHR, textStatus, errorThrown){
								alert("잘못된 접근 입니다.");
								//var str;
								//for(var i in jqXHR)
								//{
								//	 if(jqXHR.hasOwnProperty(i))
								//	{
								//		str += jqXHR[i];
								//	}
								//}
								//alert(str);
								document.location.reload();
								return false;
							}
						});
					<% else %>
						alert("선물포장 서비스를 이용하셔야 신청하실 수 있습니다.");
						return;				
					<% end if %>
				<% end if %>
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;				
			<% end if %>
		<% End If %>
	}

</script>
<div class="contF contW">
	<div class="evt68034">
		<div id="titleAnimation" class="topic">
			<span class="ribon updown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/img_ribon.png" alt="" /></span>
			<div class="hwrap">
				<h2>
					<span class="letter1">텐바이텐 선물 포장 서비스 런칭</span>
					<span class="letter2">I</span>
					<span class="letter3">선물</span>
					<span class="letter4">U</span>
				</h2>
				<p>당신의 마음까지 포장하세요</p>
			</div>
		</div>

		<div class="good">
			<div class="hwrap">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/tit_good.png" alt="포장 서비스 이런 점이 좋아요" /></h3>
				<span class="line lineL"></span>
				<span class="line lineR"></span>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/txt_good.png" alt="여러 가지 상품을 한번에 모아서 주고 싶을 때 여러 사람에게 줄 선물을 한 번에 준비해야 할 때 누군가에게 줄 선물도 사면서 내가 필요한 것도 사고 싶을 때 받아서 포장하고 카드 쓰는 번거로움을 줄이고 싶을 때" /></p>
			<div class="checkList">
				<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/tit_check.png" alt="선물 포장 서비스 이용 전 확인사항" /></h4>
				<ul>
					<li>1. 여러 개의 상품을 한 번에 결제하고, 그중 <u>일부만 포장 가능</u>합니다.</li>
					<li>2. 텐바이텐 배송 상품이 아닌 <u>업체 배송 상품은 현재 포장 서비스가 불가</u>합니다. (차후 오픈 예정)</li>
					<li>3. 하나의 주문 건은 <u>한 곳의 주소로만 배송</u>받을 수 있습니다. <br />(배송지가 다른 경우 주문을 나누어서 진행해 주세요)</li>
				</ul>
			</div>
		</div>

		<div class="preview">
			<div class="hwrap">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/tit_preview.png" alt="포장 서비스 미리 이용해 보세요" /></h3>
				<span class="line lineL"></span>
				<span class="line lineR"></span>
			</div>
			<div class="slideWrap">
				<div id="slide" class="slide">
					<div class="step1">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/img_slide_01.png" alt="STEP1 포장 가능한 상품인지 확인하고 바로구매 클릭" /></p>
						<button type="button" class="btnClick bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/btn_click.png" alt="클릭" /></button>
					</div>
					<div class="step2">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/img_slide_02.png" alt="STEP2 주문결제 페이지에서 선물포장 신청 클릭" /></p>
						<button type="button" class="btnClick bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/btn_click.png" alt="클릭" /></button>
					</div>
					<div class="step3">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/img_slide_03_v1.png" alt="STEP3 선물포장 될 상품들을 확인하고, 메시지도 적기" /></p>
						<p class="typing">추카추카추 :) 생일축하해!! <span>|</span></p>
						<button type="button" class="btnClick bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/btn_click.png" alt="클릭" /></button>
					</div>
					<div class="step4">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/img_slide_04.png" alt="STEP4 선물포장 부분의 선물상자가 빨간색이면 성공" /></p>
						<span class="ico twinkle"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/ico_wrapping.png" alt="" /></span>
					</div>
				</div>
			</div>

			<!-- for dev msg : 선물 포장 가능한 상품 보러 가기 -->
			<div class="btnGo"><a href="/shoppingtoday/gift_recommend.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/btn_go.png" alt="선물 포장 가능한 상품 보러 가기" /></a></div>
		</div>

		<div class="event">
			<div class="hwrap">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/tit_event.png" alt="포장 서비스 이용 하셨나요?" /></h3>
				<span class="line lineL"></span>
				<span class="line lineR"></span>
			</div>
			<div class="desc">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/txt_event.png" alt="선물포장 서비스를 무료로 이용하세요 선물포장 서비스를 이용하고 응모하세요. 선착순 100분에게 2,000마일리지를 페이백 해드립니다. 신청자가 많을 경우 자동 종료됩니다." /></p>
				<%' for dev msg : 페이백 신청하기 %>
				<% If totalsum >= 100 Then %>
					<button type="button" class="btnEvent" onclick="alert('마일리지 페이백이 종료되었습니다.');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/btn_event.png" alt="2,000 마일리지 페이백 신청하기" /></button>
				<% Else %>
					<button type="button" class="btnEvent" onclick="checkform();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/btn_event.png" alt="2,000 마일리지 페이백 신청하기" /></button>
				<% End If %>
			</div>
		</div>
	</div>
</div>
<div class="event">
	<p class="tMar30"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68034/txt_with.png" alt="서물 포장 서비스와 함께 하면 더 좋은 상품들" /></p>
</div>
<script type="text/javascript">
$(function(){
	$("#slide").slidesjs({
		width:"1068",
		height:"639",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:3500, effect:"fade", auto:false},
		effect:{fade: {speed:300, crossfade:true}}
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("linkStep1");
	$(".slidesjs-pagination li:nth-child(2)").addClass("linkStep2");
	$(".slidesjs-pagination li:nth-child(3)").addClass("linkStep3");
	$(".slidesjs-pagination li:nth-child(4)").addClass("linkStep4");

	$(".step1 .btnClick").click(function(){
		$(".slidesjs-pagination li.linkStep2 a").click();
		return false;
	});
	$(".step2 .btnClick").click(function(){
		$(".slidesjs-pagination li.linkStep3 a").click();
		return false;
	});
	$(".step3 .btnClick").click(function(){
		$(".slidesjs-pagination li.linkStep4 a").click();
		return false;
	});

	function bounce() {
		$(".bounce").animate({"margin-top":"3px"},300).animate({"margin-top":"0"},600, bounce);
	}
	bounce();

	/* title animation */
	$("#titleAnimation h2 span").css({"opacity":"0"});
	$("#titleAnimation h2 .letter1").css({"top":"5px"});
	$("#titleAnimation h2 .letter2").css({"left":"40px"});
	$("#titleAnimation h2 .letter4").css({"left":"245px"});
	$("#titleAnimation p").css({"top":"165px", "opacity":"0"});
	function titleAnimation() {
		$("#titleAnimation h2 .letter1").delay(800).animate({"top":"0", "opacity":"1"},800);
		$("#titleAnimation h2 .letter2").delay(50).animate({"left":"0", "opacity":"1"},800);
		$("#titleAnimation h2 .letter3").delay(50).animate({"opacity":"1"},800);
		$("#titleAnimation h2 .letter4").delay(50).animate({"left":"275px", "opacity":"1"},800);
		$("#titleAnimation p").delay(800).animate({"top":"169px", "opacity":"1"},800);
	}
	titleAnimation();
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->