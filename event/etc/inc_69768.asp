<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [2016 S/S 웨딩] Wedding Membership
' History : 2016.03.16 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
Dim vGubun, i, evt_code, userid, totalbonuscouponcountusingy

userid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66067
Else
	evt_code   =  69768
End If

dim subscriptcount
subscriptcount=0
totalbonuscouponcountusingy=0

'' 실섭 833,834,835,836,837
'' 테섭 2774,2775,2776,2777,2778
		
'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(evt_code, userid, "", "", "")
	totalbonuscouponcountusingy = getbonuscoupontotalcount("833,834,835,836,837", "N", "Y","")
end if

%>
<style type="text/css">
img {vertical-align:top;}

#contentWrap {padding-bottom:0;}

.weddingMembership {min-height:1661px; background:#daf4f1 url(http://webimage.10x10.co.kr/eventIMG/2016/69768/bg_pattern_leaf.png) repeat-x 50% 0;}

.topic {position:relative; height:127px; padding-top:359px;}
.topic h2 {width:870px; height:232px; position:absolute; top:83px; left:50%; margin-left:-435px;}
.topic h2 span {position:absolute;}
.topic h2 .letter1 {top:0; left:50%; margin-left:-133px;}
.topic h2 .letter2 {right:23px; bottom:0;}
.topic h2 .bird {top:114px; right:0;}
.topic .date {position:absolute; top:38px; left:50%; margin-left:335px;}
.topic .bnr {position:absolute; top:38px; left:50%; margin-left:-586px;}

.benefit {overflow:hidden; width:1206px; margin:47px auto 0;}
.benefit .desc {float:left; position:relative;}
.benefit .desc button {position:absolute; bottom:179px;}
.benefit .desc button:hover {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.6s;}
@keyframes bounce {
	from, to{margin-bottom:0; animation-timing-function:ease-out;}
	50% {margin-bottom:5px; animation-timing-function:ease-in;}
}

.benefit .desc1 button {left:192px;}
.benefit .desc2 button {left:167px;}

.form {overflow:hidden; width:1140px; height:702px; margin:0 auto; padding:48px 23px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69768/bg_box.png) no-repeat 50% 0;}
.form .tit {margin-bottom:25px; margin-left:50px; text-align:left;}
.form .table, .form .check {float:left; width:570px; text-align:left;}
.form .check {width:445px;}
.form .table {margin-top:-15px;}
.form .table table {width:470px; margin-left:50px;}
.form .table table th, .form .table table td {padding:30px 0; border-bottom:1px solid #f0f0f0;}
.form .table table .last th, .form .table table .last td {border-bottom:0;}
.form .table table th {width:123px; padding:40px 0 30px 20px;}
.form .table table .last th {padding-top:10px;}
.form .table table tr:first-child th {padding-top:0;}
.form .table table td {position:relative; width:327px; color:#5d5d5d;}
.form .table table td label {margin-right:17px;}
.form .table table td label img {margin-top:10px;}
.form .table table td #myId {border:0; background-color:transparent;}
#spouseName {margin-bottom:14px;}
.form .table table td b {display:inline-block; margin:0 22px 0 7px;}
.form .table table td .ex {position:absolute; top:50%; right:0; margin-top:-6px;}
.form .table table .itext {width:218px; height:14px; padding:8px 15px; border:1px solid #ddd; color:#5d5d5d; font-family:'Dotum', 'Verdana'; font-size:12px; font-weight:bold;}
.form .table table .ifile {width:322px; height:30px; margin-bottom:14px; background-color:#fff; border:1px solid #ddd;}
.form .check {padding-left:53px;}
.form .check .agree {margin-top:27px;}
.form .check .agree li {margin-bottom:15px;}

/* tiny scrollbar */
.scrollbarwrap {width:443px; margin-top:23px; border:1px solid #ddd; background-color:#fff;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:424px; height:143px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:10px; border-left:1px solid #ddd; background-color:#fff;}
.scrollbarwrap.track {position: relative; width:10px; height:100%; background-color:#fff;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:10px; height:24px; background-color:#efefef; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}

.scrollbarwrap .policy h3 {visibility:hidden; width:0; height:0;}
.scrollbarwrap .policy h3, .scrollbarwrap .policy h4, .scrollbarwrap .policy h5 {font-weight:normal;}
.policy {padding:20px 28px; font-family:'Dotum', 'Verdana'; font-size:12px;}
.policy h3 + h4 {margin-top:0;}
.policy h4, .policy h5 {margin-top:20px;}

.form .btnarea {clear:both; width:100%; padding-top:20px;}
.form .btnarea input {margin-top:15px; vertical-align:top;}

.noti {padding:60px 0 56px; background-color:#f6f6f7; text-align:left;}
.noti .inner {position:relative; width:1140px; margin:0 auto;}
.noti h3 {position:absolute; top:50%; left:136px; margin-top:-12px;}
.noti ul {padding-left:420px;}
.noti ul li {position:relative; padding-left:13px; color:#868686; line-height:2.2em;}
.noti ul li span {position:absolute; top:12px; left:0; width:5px; height:1px; background-color:#868686;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(function(){
	/* tinyscrollbar */
	$(".scrollbarwrap").tinyscrollbar();

	animation();
	$("#animation h2 span").css({"opacity":"0"});
	$("#animation h2 .letter1").css({"margin-top":"-15px"});
	$("#animation h2 .letter2").css({"margin-bottom":"-15px"});
	$("#animation h2 .bird").css({"top":"80px", "right":"-30px",});
	function animation () {
		$("#animation h2 .letter1").delay(100).animate({"margin-top":"0", "opacity":"1"},900);
		$("#animation h2 .letter2").delay(100).animate({"margin-bottom":"0", "opacity":"1"},900);
		$("#animation h2 .bird").delay(700).animate({"top":"114px", "right":"0", "opacity":"1"},1500);
	}

	function swing () {
		$(".bnr").animate({"top":"38px"},1000).animate({"top":"50px"},3500, swing);
	}
	swing();
});

function frmSubmit() {
	<% If IsUserLoginOK() Then %>
		<% If Now() > #04/28/2016 23:59:59# Then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% Else %>
			<% if subscriptcount < 1 then %>
				var frm = document.frmApply;

				// 내 이름
				if (frm.myArea1.value == '' || frm.myArea1.value == 'ex) 홍길동'){
					alert("본인 이름을 입력해 주세요.");
					frm.myArea1.value = '';
					frm.myArea1.focus();
					return;
				}

				//배우자 이름
				if (frm.myArea2.value == '' || frm.myArea2.value == 'ex) 홍길동'){
					alert("배우자 이름을 입력해 주세요.");
					frm.myArea2.value = '';
					frm.myArea2.focus();
					return;
				}

				//결혼 예정일
				if (frm.myArea3.value == ''){
					alert("결혼 예정일을 입력해 주세요");
					frm.myArea3.focus();
					return;
				}

				if (frm.myArea3.value == '' || GetByteLength(frm.myArea3.value) > 4 || frm.myArea3.value == '0000'){
					alert("결혼 예정일을 숫자로 4자리로 입력해 주세요.");
					frm.myArea3.focus();
					return;
				}

				// 체크 되어 있는지 확인
				var checkCnt = $("input[name=agreecheck]:checked").size();
				var checkval = $("input[name=agreecheck]:checked").val() ;
				if(checkCnt == 0) {
					alert("동의하지 않으면 응모하실 수 없습니다.");
					frm.agreecheck.focus();
					return;
				}else{
					if(checkval == '') {
						alert("개인정보 취급 방침에 동의 하셔야 응모 가능 합니다.");
						frm.agreecheck.focus();
						return;
					}
				}
				//* 파일 확장자 체크
				for(var ii=1; ii<2; ii++)
				{
					var frmname		 = eval("frm.imgfile"+ii+"");
			
					if(frmname.value != "")
					{
						var sarry        = frmname.value.split("\\");
						var maxlength    = sarry.length-1;
						var ext = sarry[maxlength].split(".");
			
						if(ext[1].toLowerCase() == "jpg" || ext[1].toLowerCase() == "png"){
							
						}else{
							alert('jpg나png파일만 가능 합니다.');
							return;
						}
					}
					else
					{
						alert('청첩장 이미지 파일을 등록해 주세요.');
						return;
					}
				}

				frm.optname.value = frm.myArea1.value+"/!/"+frm.myArea2.value+"/!/N";
				frm.mode.value = 'addreg';
				frm.submit();
		   <% else %>
				alert("이미 응모 하셨습니다.");
				return;
			<% end if %>
		<% End if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jsCheckLimit(textgb) {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}
	if (textgb =='ta1'){
		if (document.frmApply.myArea1.value == 'ex) 홍길동'){
			document.frmApply.myArea1.value = '';
		}
	}else if(textgb =='ta2'){
		if (document.frmApply.myArea2.value == 'ex) 홍길동'){
			document.frmApply.myArea2.value = '';
		}
	}else if(textgb =='ta3'){
		if (document.frmApply.myArea3.value == '0000'){
			document.frmApply.myArea3.value = '';
		}
	}else{
		alert('잠시 후 다시 시도해 주세요');
		return;
	}
}

function maxLengthCheck(object){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
	{
		return;
	}
	else
	{
		return false;
	}
}
function showKeyCode(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
	{
		return;
	}
	else
	{
		return false;
	}
}

function jsdailychk(){
<% If IsUserLoginOK() Then %>
	<% If Now() > #04/28/2016 23:59:59# Then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% else %>
		<% if totalbonuscouponcountusingy > 0 then %>
			var result;
			$.ajax({
				type:"GET",
				url:"/event/etc/doeventsubscript/doEventSubscript69768.asp",
				data: "mode=daily",
				dataType: "text",
				async:false,
				cache:false,
				success : function(Data){
					result = jQuery.parseJSON(Data);
					if (result.resultcode=="22")
					{
						alert('이미 응모 하셨습니다.');
						return;
					}
					else if (result.resultcode=="44")
					{
						alert('로그인이 필요한 서비스 입니다.');
						return;
					}
					else if (result.resultcode=="11")
					{
						alert('응모가 완료 됬습니다.');
						location.reload();
						return;
					}
					else if (result.resultcode=="88")
					{
						alert('이벤트 기간이 아닙니다.');
						return;
					}
					else if (result.resultcode=="66")
					{
						alert('잘못된 접속 입니다.');
						return;
					}
				}
			});
		<% else %>
			alert('청첩장 제출을 한 후\n발급된 쿠폰을 사용시\n응모 가능 합니다.');
			return;
		<% end if %>
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
		var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
		winLogin.focus();
		return false;
	}
	return false;
<% End IF %>
	
}
</script>
<div class="evt69768 weddingMembership">
	<div id="animation" class="topic">
		<h2>
			<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_my_story.png" alt="소중한 나의 웨딩 스토리" /></span>
			<span class="letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/tit_wedding_membership.png" alt="Wedding Membership" /></span>
			<span class="bird"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/img_bird.png" alt="" /></span>
		</h2>
		<p class="way"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_way_v1.png" alt="텐바이텐이 여러분의 소중한 시작을 응원합니다! 청첩장을 등록하고 특별한 혜택을 받으세요! 대상은 2016년 3월 1일부터 6월 30일까지 결혼일 예정일인 고객이며, 모집방법은 아이디와 고객명과 동일한 청첩장 업로드해주세요" /></p>
		<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_date.png" alt="이벤트 기간은 2016년 3월 28일부터 4월 24일까지 진행합니다." /></p>

		<div class="bnr"><a href="/event/eventmain.asp?eventid=69755"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/img_bnr_wedding.png" alt="2016 웨딩 이벤트 바로가기" /></a></div>
	</div>

	<div class="benefit">
		<div class="desc desc1">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_benefit_01_v1.png" width="604" height="698" alt="청접장을 등록하면 살림에 보탬이 되는 웨딩쿠폰 5종 세트를 자동으로 발급해 드립니다. 20만원 이상 구매 시 2만원, 50만원 이상 구매시 6만원, 100만원 이상 구매시 15만원 할인 쿠폰을 드리며, 텐바이텐 무료배송 쿠폰 2장을 드립니다. 발급 기간은 2016년 4월 24일 일요일까지며 텐바이텐 전 채널에서 사용가능하며, 사용기간은 발급일로부터 3개월입니다. 웨딩 5종 쿠폰은 청첩장 등록일 익일에 해당 아이디로 자동발급되며 금, 토, 일요일 등록자는 월요일에 일괄발급 됩니다." /></p>
			<a href="/my10x10/couponbook.asp"><button type="button" class="btnCoupon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/btn_coupon.png" alt="쿠폰 확인하기" /></button></a>
		</div>
		<div class="desc desc2">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_benefit_02_v1.png" width="602" height="698" alt="웨딩 쿠폰을 사용하여 구매하면 추첨을 통해 10명에게 5만원 권 기프트 카드를 드립니다. 응모기간은 2016년 4월 24일 일요일까지며, 당첨자 발표는 2016년 5월 2일 월요일입니다. 사용기간은 제한 없음" /></p>
			<button type="button" onclick="jsdailychk(); return false;" class="btnEnter"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/btn_enter.png" alt="응모하기" /></button>
		</div>
	</div>

	<div id="form" class="form">
		<h3 class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/tit_invitation_register.png" alt="청첨장 등록" /></h3>

		<form name="frmApply" method="POST" action="<%=staticImgUrl%>/linkweb/enjoy/69768_Contest_upload.asp" onsubmit="return false" enctype="multipart/form-data">
		<input type="hidden" name="mode" value="">
		<input type="hidden" name="userid" value="<%= userid %>">
		<input type="hidden" name="optname" value="">
		<input type="hidden" name="device" value="W">
			<!-- for dev msg : 청첩장 정보 등록 폼-->
			<div class="table">
				<fieldset>
				<legend>청첩장 정보 등록 폼</legend>
				<table style="width:470px;">
					<caption>나의 정보, 배우자 정보, 결혼 예정일, 청첩장 이미지 첨부</caption>
					<tbody>
					<tr>
						<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_th_my_info.png" alt="나의 정보" /></th>
						<td>
							<div>
								<label for="myId"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_id.png" alt="아이디" /></label>
								<input type="text" id="myId"  <% IF NOT(IsUserLoginOK) THEN %>value="로그인을 해주세요."<% else %>value="<%= userid %>"<% END IF %> readonly="readonly" class="itext" />
							</div>
							<div style="margin-top:10px;">
								<label for="myName"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_name.png" alt="이름" /></label>
								<input type="text" id="myName" name="myArea1" class="itext" onClick="jsCheckLimit('ta1');" onKeyUp="jsCheckLimit('ta1');" <% IF NOT(IsUserLoginOK) THEN %>value="로그인을 해주세요."<% else %>value="ex) 홍길동"<% END IF %> />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_th_spouse_info.png" alt="배우자 정보" /></th>
						<td>
							<label for="spouseName"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_name.png" alt="이름" /></label>
							<input type="text" id="spouseName" name="myArea2" class="itext" onClick="jsCheckLimit('ta2');" onKeyUp="jsCheckLimit('ta2');" <% IF NOT(IsUserLoginOK) THEN %>value="로그인을 해주세요."<% else %>value="ex) 홍길동"<% END IF %> />
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_need_info.png" alt=" 청첩장 정보와 일치여부 판단하기 위해 기입" /></p>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="weddingDate"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_th_date.png" alt="결혼 예정일" /></label>
						</th>
						<td>
							<b>2016년</b>
							<input type="number" id="weddingDate" placeholder="0000" onkeydown="return showKeyCode(event)" oninput="maxLengthCheck(this)" maxlength = "4" name="myArea3" class="itext" onClick="jsCheckLimit('ta3');" onKeyUp="jsCheckLimit('ta3');" style="width:50px;" <% IF NOT(IsUserLoginOK) THEN %>value="로그인을 해주세요."<% else %>value="0000"<% END IF %>/>
							<p class="ex"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_ex.png" alt="예시 3월 20일일 경우0320으로 기입" /></p>
						</td>
					</tr>
					<tr class="last">
						<th scope="row">
							<label for="weddingInvitation"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_th_attach.png" alt="청첩장 이미지 첨부" /></label>
						</th>
						<td>
							<input type="file" id="weddingInvitation" name="imgfile1" class="ifile txtInp" />
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_file_limited.png" alt="파일은 최대용량은 2메가 이며, JPG JPEG 파일로 올려주세요" /></p>
						</td>
					</tr>
					</tbody>
				</table>
				</fieldset>
			</div>

			<!-- for dev msg : 개인정보 취급방침 -->
			<div class="check">
				<fieldset>
				<legend>텐바이텐 Wedding Membership 개인정보 취급방침</legend>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_noti.png" alt="2016년 3월1일 ~ 6월30일까지 결혼(예정)일인 고객 모두 등록 가능합니다. 기입해주신 고객명, 배우자명이 청첩장과 동일해야 합니다. 평일 자정까지 업로드 한 고객에 한하여 익일 오후 2시 일괄 승인됩니다. (금/토/일 등록자는 월요일 일괄승인) 기입한 정보는 비공개이며, 이벤트 종료 후 파기 됩니다." /></p>

					<div class="scrollbarwrap">
						<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
						<div class="viewport">
							<div class="overview">
								<div class="policy">
									<h3>텐바이텐 Wedding Membership 개인정보 취급방침</h3>
									<h4>[수집하는 개인정보 항목 및 수집방법]</h4>
									<h5>1. 수집하는 개인정보의 항목</h5>
									<p>회사는 해당이벤트의 원활한 고객상담, 각종 서비스의 제공을 위해 아래와 같은 최소한의 개인정보를 필수항목을 수집하고 있습니다. - 아이디, 비밀번호, 이름, 성별, 생년월일, 이메일주소, 휴대폰번호, 가입인증정보</p>
									<h5>2. 개인정보 수집에 대한 동의</h5>
									<p>회사는 귀하께서 텐바이텐의 개인정보취급방침에 따른 이벤트 이용약관의 내용에 대해 「동의한다」버튼 또는 「동의하지 않는다」버튼을 클릭할 수 있는 절차를 마련하여, 「동의한다」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다.</p>

									<h4>[개인정보의 수집목적 및 이용 목적]</h4>
									<ul>
										<li>1. 이벤트 참여를 위한 관련 정보 수집 및 증빙 확인 목적</li>
										<li>2. 고지사항 전달, 본인 의사 확인, 불만 처리 등 원활한 의사소통 경로의 확보</li>
									</ul>

									<h4>[개인정보의 보유 및 파기 절차]</h4>
									<p>1. 설문조사, 이벤트 등 일시적 목적을 위하여 수집한 경우 : 당해 설문조사, 이벤트 등의 종료 시점</p>
									<p>2. 회사는 원칙적으로 개인정보 수집 및 이용목적이 달성되면 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.</p>
									<ul>
										<li>① 파기절차 : 귀하가 이벤트등록을 위해 입력하신 정보는 이벤트가 완료 된 후 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라 일정 기간 저장된 후 파기되어집니다.</li>
										<li>② 파기대상 : 배우자 정보, 결혼 예정일, 청첩장 이미지</li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					<ul class="agree">
						<li>
							<input type="radio" id="agree" value="Y" name="agreecheck" />
							<label for="agreeYes"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_agree_yes.png" alt="텐바이텐 개인정보취급방침에 따라, 본 이벤트 참여를 위한 개인정보 취급방침에 동의합니다." /></label>
						</li>
						<!--
						<li>
							<input type="radio" id="agree" value="N" name="agreecheck" />
							<label for="agreeNo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_agree_no.png" alt="동의하지 않습니다." /></label>
						</li>
						-->
					</ul>
				</fieldset>
			</div>

			<div class="btnarea">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/txt_check_noti.png" alt="* 공지사항을 꼭 확인 후 제출하세요!" /></p>
				<input type="image" onclick="frmSubmit(); return false;" src="http://webimage.10x10.co.kr/eventIMG/2016/69768/btn_submit.png" alt="청첨장 제출하기" />
			</div>
		</form>
	</div>

	<div class="noti">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69768/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span>2016년 3월1일 ~ 6월30일 까지 결혼일(예정일)인 고객은 모두 등록 가능합니다.</li>
				<li><span></span>청첩장의 내용이 기입한 정보와 일치할 경우, 웨딩쿠폰은 청첩장 등록일 익일 2시 해당ID로 자동 지급됩니다.<br /> (단,금/토/일 등록자는 월요일 오후2시 일괄 지급)</li>
				<li><span></span>해당 이벤트에 기입한 정보는 비공개이며, 이벤트 종료 후 파기 됩니다.</li>
			</ul>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->