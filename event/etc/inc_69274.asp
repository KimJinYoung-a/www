<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  2016년 VIP GIFT
' History : 2016-02-18 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
	dim oUserInfo
	set oUserInfo = new CUserInfo
		oUserInfo.FRectUserID = GetEncLoginUserID
	if (GetEncLoginUserID<>"") then
		oUserInfo.GetUserData
	end if
%>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

img {vertical-align:top;}

#contentWrap {padding-bottom:0;}

.hidden {visibility:hidden; width:0; height:0;}

.evt69274 {background-color:#efefef;}
.topic {position:relative; height:915px; background:#feefb5 url(http://webimage.10x10.co.kr/eventIMG/2016/69274/bg_pattern_color.png) repeat-x 0 0;}
.topic .inner {height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69274/bg_pattern_deco.png) no-repeat 50% 0;}
.topic .hgroup {position:absolute; top:88px; left:50%; width:427px; height:347px; margin-left:-213px;}
.topic .hgroup .sprout {position:absolute; top:0; left:50%; width:29px; height:15px; margin-left:-15px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69274/tit_vip_gift.png) no-repeat 50% 0;}
.topic .hgroup h2 span {overflow:hidden; display:block; position:absolute;}
.topic .hgroup h2 span i {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:#feefb5 url(http://webimage.10x10.co.kr/eventIMG/2016/69274/tit_vip_gift.png) no-repeat 50% 0;}
.topic .hgroup h2 .letter1 {top:20px; left:50%; width:427px; height:121px; margin-left:-213px;}
.topic .hgroup h2 .letter1 i {background-position:50% -20px;}
.topic .hgroup h2 .letter2 {top:169px; left:0; width:232px; height:96px;}
.topic .hgroup h2 .letter2 i {background-position:0 -169px;}
.topic .hgroup h2 .letter3 {top:169px; right:0; width:179px; height:96px;}
.topic .hgroup h2 .letter3 i {background-position:100% -169px;}
.topic .hgroup p {position:absolute; top:301px; left:50%; width:427px; height:61px; margin-left:-213px;}
.topic .hgroup p i {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:#feefb5 url(http://webimage.10x10.co.kr/eventIMG/2016/69274/tit_vip_gift.png) no-repeat 50% 100%;}

.topic .gift {position:absolute; top:435px; left:50%; margin-left:-774px;}

.contents {padding-bottom:47px; background-color:#d2e9f0; text-align:left;}
.contents .article {width:981px; margin:0 auto;}
.contents .article .row {position:relative; padding-left:33px;}
.contents .article .row1 h3 + p {padding-bottom:30px;}
.contents .article .row .btnEnter {position:absolute; top:14px; right:55px;}
.contents .article .row2 {margin-top:65px;}

.address {position:relative; margin-left:161px; padding:30px 55px 30px 37px; background-color:#fff;}
.address .selectOption {overflow:hidden; position:absolute; top:36px; left:240px; padding-top:1px;}
.address .selectOption span {float:left; margin-right:25px;}
.address .selectOption input {margin-top:-1px; vertical-align:top;}
.address .note {position:absolute; top:104px; right:65px;}
.address table {margin-top:25px;}
.address table th img {margin-top:10px;}
.address table th, .address table td {padding-bottom:10px;}
.address table td input {width:220px; margin-top:10px; padding:0 14px; height:30px; border:1px solid #ddd; color:#ff6b48; font-family:'Dotum', sans-serif; font-size:12px; line-height:32px;}
.address table td input.width70 {width:40px;}
.address .group {overflow:hidden; position:relative;}
.address .group input, .address .group span {float:left;}
.address .group span {width:20px; height:32px; margin-top:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69274/blt_hypen.png) no-repeat 50% 50%;}
.address .group .btnFind {position:absolute; top:10px; right:0;}
.address .btnsubmit {position:absolute; bottom:60px; right:55px;}

.slide {position:relative; width:981px; min-height:592px; margin:77px auto 0;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:243px; width:39px; height:78px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69274/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:0;}
.slide .slidesjs-next {right:0; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:0; left:50%; z-index:50; width:120px; margin-left:-60px;}
.slidesjs-pagination li {float:left;}
.slidesjs-pagination li a {display:block; width:30px; height:11px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69274/btn_pagination.png) no-repeat 0 0; text-indent:-999em; transition:all 0.7s;}
.slidesjs-pagination li a.active {background-position:0 100%;}

.noti {position:relative; width:1140px; margin:0 auto; padding:35px 0 40px; text-align:left;}
.noti h3 {position:absolute; top:59px; left:86px;}
.noti ul {padding-left:338px;}
.noti ul li {position:relative; margin-bottom:8px; padding-left:16px; color:#8e8e8e; font-size:11px; font-family:'Dotum', 'Verdana'; line-height:1.5em;}
.noti ul li span {position:absolute; top:4px; left:0; width:5px; height:6px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68950/blt_dot.png) no-repeat 50% 0;}
.noti ul li.strong {color:#ed1c24;}
.noti ul li.strong span {background-position:50% 100%;}
.noti ul li strong {font-weight:normal;}

/* css3 animation */
.animated {animation-duration:2.5s; animation-fill-mode:both; animation-iteration-count:1;}

.bounce {animation-name:bounce; animation-iteration-count:infinite;}
@keyframes bounce {
	0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-10px);}
	60% {transform: translateY(-5px);}
}

@keyframes wobble {
	0% {transform: translateX(0%);}
	15% {transform: translateX(-25%) rotate(-5deg);}
	30% {transform: translateX(20%) rotate(3deg);}
	45% {transform: translateX(-15%) rotate(-3deg);}
	60% {transform: translateX(10%) rotate(2deg);}
	75% {transform: translateX(-5%) rotate(-1deg);}
	100% {transform: translateX(0%);}
}
.wobble {animation-name:wobble;}
</style>
<script>
$(function(){
	/* slide js */
	$("#slide").slidesjs({
	width:"981",
	height:"560",
	pagination:{effect:"fade"},
	navigation:{effect:"fade"},
	play:{interval:3500, effect:"fade", auto:true},
	effect:{fade: {speed:1000, crossfade:true}},
	callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$("#address").hide();

	/* Label Select */
	$("#address .selectOption label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	/* animation */
	effect();
	$(".topic .gift").css({"top":"455px", "opacity":"0"});
	function effect() {
		$(".topic .gift").delay(800).animate({"top":"435px", "opacity":"1"},1000);
	}
});

function jsvipgo(){
	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% else %>
		<% if GetLoginUserLevel() = 3 or GetLoginUserLevel() = 4 then  %>
			$("#address").show();
			$("#address").effect("slide", {direction:"up"}, "slow");
			return false;
		<% else %>
			alert('VIP 등급만 참여 하실 수 있습니다.');
		<% end if %>
	<% end if %>
}

//'주소찾기
function searchzip(frmName){
	var popwin = window.open('/common/searchzip.asp?target=' + frmName, 'searchzip10', 'width=560,height=680,scrollbars=yes,resizable=yes');
	popwin.focus();
}

//'나의 주소록
function PopOldAddress(){
	var popwin = window.open('/my10x10/MyAddress/popMyAddressList.asp','popMyAddressList','width=600,height=300,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function jsSubmitComment(){
	var frm = document.frmorder
	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% end if %>

	if(!frm.reqname.value){
		alert("이름을 입력 해 주세요");
		frm.reqname.focus();
		return false;
	}

	if(!frm.reqhp1.value){
		alert("휴대폰번호를 입력 해주세요");
		frm.reqhp1.focus();
		return false;
	}

	if(!frm.reqhp2.value){
		alert("휴대폰번호를 입력 해주세요");
		frm.reqhp2.focus();
		return false;
	}

	if(!frm.reqhp3.value){
		alert("휴대폰번호를 입력 해주세요");
		frm.reqhp3.focus();
		return false;
	}

	if(!frm.txZip1.value){
		alert("우편번호를 입력 해주세요");
		frm.txZip1.focus();
		return false;
	}

	if(!frm.txZip2.value){
		alert("우편번호를 입력 해주세요");
		frm.txZip2.focus();
		return false;
	}

	if (frm.txAddr1.value.length<1){
        alert('수령지 도시 및 주를  입력하세요.');
        frm.txAddr1.focus();
        return false;
    }

    if (frm.txAddr2.value.length<1){
        alert('수령지 상세 주소를  입력하세요.');
        frm.txAddr2.focus();
        return false;
    }

	frm.mode.value = "inst";
	frm.action = "/event/etc/doeventsubscript/doEventSubscript69274.asp";
	frm.submit();
	return;
}
</script>
<div class="evt69274">
	<div class="topic">
		<div class="inner">
			<div class="hgroup">
				<span class="sprout animated bounce"></span>
				<h2>
					<span class="letter1"><i></i>2016 첫번째 VIP GIFT</span>
					<span class="letter2 animated wobble"><i></i>파릇</span>
					<span class="letter3 animated wobble"><i></i>파릇</span>
				</h2>
				<p><i></i>특별한 당신을 위한 특별한 선물 VIP고객님을 위한 VIP GIFT를 신청하세요!</p>
			</div>
			<p class="gift"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/img_gift.png" width="1549" height="466" alt="VIP GIFT 스위트 바질 화분세트" /></p>
		</div>
	</div>

	<div class="contents">
		<div class="article">
			<div class="row row1">
				<h3 class="hidden">신청방법</h3>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/txt_way_apply.png" alt="2월 현재 VIP 골드, VIP 실버 고객께서는 2016년 2월 22일 월요일부터 29일 월요일까지 VIP GIFT를 신청해주세요. 배송은 3월 2일 수요일부터 순차적으로 배송되며, 한정 수량으로 조기 종료될 수 있습니다." /></p>

				<a href="" onclick="jsvipgo();return false;" id="btnEnter" class="btnEnter"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/btn_enter.gif" alt="VIP 입장하기" /></a>
				<div id="address" class="address" style="display:none;">
					
					<%If oUserInfo.FresultCount >0 Then %>
					<form name="frmorder" method="post">
					<input type="hidden" name="reqphone1"/>
					<input type="hidden" name="reqphone2"/>
					<input type="hidden" name="reqphone3"/>
					<input type="hidden" name="mode"/>
						<fieldset>
						<legend>VIP GIFT 배송지 주소 입력</legend>
							<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/tit_address.png" alt="배송지 주소 확인하기" /></h4>

							<p class="note"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/txt_note.png" alt="기본 회원 정보 주소를 불러오며, 수정 가능합니다. 주소입력 후 VIP GIFT 신청완료를 클릭하셔야 신청이 완료 되며, 완료된 후에는 주소를 변경하실 수 없습니다." /></p>

							<div class="selectOption">
								<span>
									<input type="radio" id="address01" name="addr" value="1" checked/>
									<label for="address01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/txt_label_01.png" alt="기본 주소" /></label>
								</span>
								<span>
									<input type="radio" id="address02" name="addr" value="2" onclick="PopOldAddress();"/>
									<label for="address02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/txt_label_02.png" alt="나의 주소록" /></label>
								</span>
							</div>

							<table style="width:342px;">
								<caption>배송지의 이름, 휴대폰, 주소 정보</caption>
								<tbody>
								<tr>
									<th scope="row" style="width:92px;">
										<label for="username"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/txt_th_name.png" alt="이름" /></label>
									</th>
									<td style="width:250px;">
										<input type="text" id="username" value="<%=oUserInfo.FOneItem.FUserName%>" name="reqname" />
									</td>
								</tr>
								<tr>
									<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/txt_th_mobile.png" alt="휴대폰" /></th>
									<td>
										<div class="group">
											<input type="text" title="휴대폰번호 앞자리" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" name="reqhp1" class="width70" /><span></span>
											<input type="text" title="휴대폰번호 가운데 자리" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" name="reqhp2" class="width70" /><span></span>
											<input type="text" title="휴대폰번호 뒷자리" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" name="reqhp3" class="width70" />
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/txt_th_address.png" alt="주소" /></th>
									<td>
										<div class="group">
											<input type="text" title="우편번호 앞자리" value="<%= Splitvalue(oUserInfo.FOneItem.FZipCode,"-",0) %>" name="txZip1" ReadOnly class="width70" /><span></span>
											<input type="text" title="우편번호 뒷자리" value="010" class="width70" value="<%= Splitvalue(oUserInfo.FOneItem.FZipCode,"-",1) %>" name="txZip2" ReadOnly/>
											<a href="" onclick="searchzip('frmorder');return false;" class="btnFind"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/btn_find.png" alt="찾기" /></a>
										</div>
										<input type="text" title="기본주소" value="서울" name="txAddr1" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress1) %>"/>
										<input type="text" title="상세주소" value="서울" name="txAddr2" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress2) %>"/>
									</td>
								</tr>
								</tbody>
							</table>
							<div class="btnsubmit"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2016/69274/btn_submit.gif" alt="VIP GIFT 신청완료" onclick="jsSubmitComment();return false;"/></div>
						</fieldset>
					</form>
					<% End If %>
				</div>
			</div>

			<div class="row row2">
				<h3 class="hidden">재배방법</h3>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/txt_way_grow.png" alt="스위트 바질 재배 방법은 배양토를 담은 후 씨앗을 심고, 물을 뿌립니다. 이름표를 꽂고 새싹을 키웁니다." /></p>
			</div>
		</div>

		<div id="slide" class="slide">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/img_slide_01.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/img_slide_02.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/img_slide_03.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/img_slide_04.jpg" alt="" /></div>
		</div>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69274/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li><span></span>텐바이텐 VIP SILVER, VIP GOLD 고객만 신청이 가능합니다.</li>
			<li><span></span>본 사은품은 한정 수량으로 조기 선착순 마감 될 수 있습니다.</li>
			<li><span></span>사은품은 현금 성 환불이 불가합니다.</li>
		</ul>
	</div>
</div>
<%
	Set oUserInfo = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
