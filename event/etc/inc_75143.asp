<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  2016년 VIP GIFT
' History : 2016-12-23 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
	Dim eCode, vQuery
	IF application("Svr_Info") = "Dev" THEN
		eCode		=  66256
	Else
		eCode		=  75143
	End If

	dim oUserInfo, vTotalCount2, allcnt
	set oUserInfo = new CUserInfo
		oUserInfo.FRectUserID = GetEncLoginUserID
	if (GetEncLoginUserID<>"") then
		oUserInfo.GetUserData
	end If
	
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_temp_event_addr] WHERE userid = '" & GetEncLoginUserID & "' And evt_code='"& eCode &"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		vTotalCount2 = rsget(0)
	End If
	rsget.close()

	'// 전체 인원수 확인
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_temp_event_addr] WHERE evt_code='"& eCode &"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		allcnt = rsget(0)
	End If
	rsget.close()

%>
<style type="text/css">
img {vertical-align:top;}

.hidden {visibility:hidden; width:0; height:0;}

.vipGift {padding-bottom:79px; background:#08453d url(http://webimage.10x10.co.kr/eventIMG/2016/75143/bg_btm.jpg) 50% 100% no-repeat;}
.vipGift .topic {height:234px; padding-top:82px; background:#08453d url(http://webimage.10x10.co.kr/eventIMG/2016/75143/bg_top.jpg) 50% 0 no-repeat;}
.vipGift .topic h2 {position:relative; width:427px; height:136px; margin:0 auto;}
.vipGift .topic h2 .year {position:absolute; top:11px; left:-58px; z-index:5;}
.vipGift .topic h2 .year {animation:bounce 10 1s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}
.vipGift .topic h2 .letter {display:block; position:absolute; width:106px; height:34px;}
.vipGift .topic h2 .letter span {display:block; position:absolute; width:100%; height:100%; background:#08453d url(http://webimage.10x10.co.kr/eventIMG/2016/75143/tit_vip_gift.png) -164px 0 no-repeat;}
.vipGift .topic h2 .letter1 {top:0; left:164px;}
.vipGift .topic h2 .letter2 {top:70px; left:0; width:174px; height:66px;}
.vipGift .topic h2 .letter2 span {background-position:0 -70px;}
.vipGift .topic h2 .letter3 {top:70px; right:0; width:231px; height:66px;}
.vipGift .topic h2 .letter3 span {background-position:100% -70px;}
.vipGift .topic p {position:relative; width:427px; height:15px; margin:28px auto 0; color:#fff;}
.vipGift .topic p span {display:block; position:absolute; width:100%; height:100%; background:#08453d url(http://webimage.10x10.co.kr/eventIMG/2016/75143/tit_vip_gift.png) 50% 100% no-repeat;}

.vipGift .contents {text-align:left;}
.vipGift .contents .article {position:relative;}
.vipGift .contents .article .btnEnter {position:absolute; top:7px; right:135px;}

.slideWrap {position:relative;}
.slide {position:relative;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:232px; width:100px; height:100px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/75143/btn_nav.png) 0 50% no-repeat; text-indent:-999em;}
.slide .slidesjs-previous {left:0;}
.slide .slidesjs-next {right:0; background-position:100% 50%;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:88px; left:50%; z-index:15; width:120px; margin-left:-60px; height:11px; text-align:center;}
.slidesjs-pagination li {float:left;}
.slidesjs-pagination li a {display:block; width:30px; height:11px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/75143/btn_pagination.png) no-repeat 0 0; text-indent:-999em; transition:all 0.5s;}
.slidesjs-pagination li a.active {background-position:0 100%;}
.slideWrap .btnBrand {position:absolute; right:80px; bottom:120px; z-index:15;}

.address {background:#08453d url(http://webimage.10x10.co.kr/eventIMG/2016/75143/bg_middle.jpg) 50% 0 no-repeat;}
.address .form {position:relative; width:871px; height:323px; margin:0 auto; padding:30px 55px 0;}
.address .selectOption {overflow:hidden; position:absolute; top:36px; left:260px; padding-top:1px;}
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

.noti {position:relative; width:980px; margin:30px auto 0; padding:48px 0 46px 0; background-color:#0c3a34; text-align:left;}
.noti h3 {position:absolute; top:50%; left:60px; margin-top:-12px;}
.noti ul {padding-left:278px;}
.noti ul li {position:relative; margin-top:8px; padding-left:16px; color:#9ac0bb; font-size:11px; font-family:'Dotum', 'Verdana'; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:4px; left:0; width:5px; height:6px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/75143/blt_dot.png) no-repeat 50% 0;}
.noti ul li.strong {color:#ed1c24;}
.noti ul li.strong span {background-position:50% 100%;}
.noti ul li strong {font-weight:normal;}
</style>
<script>

$(function(){
	/* slide js */
	$("#slide").slidesjs({
	width:"1140",
	height:"660",
	pagination:{effect:"fade"},
	navigation:{effect:"fade"},
	play:{interval:2200, effect:"fade", auto:true},
	effect:{fade: {speed:800, crossfade:true}}
	});

	/* address */
	$("#address").hide();


	/* Label Select */
	$("#address .selectOption label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	/* title animation */
	animation();
	$("#animation .letter").css({"opacity":"0"});
	$("#animation .letter1").css({"opacity":"1"});
	$("#animation .year").css({"margin-top":"5px", "opacity":"0"});
	$("#animation .letter2").css({"left":"-20px"});
	$("#animation .letter3").css({"right":"-20px"});
	function animation () {
		$("#animation .letter2").delay(100).animate({"left":"0", "opacity":"1"},800);
		$("#animation .letter3").delay(100).animate({"right":"0", "opacity":"1"},800);
		$("#animation .year").delay(800).animate({"margin-top":"0", "opacity":"1"},600);
	}
});

function jsvipgo(){

	<% if Not(Now() > #12/26/2016 00:00:00# And Now() < #12/31/2016 23:59:59#) then %>
		alert("이벤트 기간이 아닙니다.");
		return false;
	<% end if %>

	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% else %>
		<% if GetLoginUserLevel() = 3 or GetLoginUserLevel() = 4 or GetLoginUserLevel() = 6 then  %>
			<% if allcnt >= 4000 then %>
				alert("한정 수량으로 조기 소진되었습니다.");
				return false;
			<% else %>
				<% if vTotalCount2 > 0 then %>
					alert("이미 신청하셨습니다.");
					return false;
				<% else %>
					$("#address").show();
					$("#address").effect("slide", {direction:"up"}, "slow");
					return false;
				<% end if %>
			<% end if %>
		<% else %>
			alert('본 이벤트는\nVIP 등급만 참여하실 수 있습니다.');
			return false;
		<% end if %>
	<% end if %>
}

//'주소찾기
function searchzip(frmName){
	var popwin = window.open('/common/searchzip_new.asp?target=' + frmName, 'searchzip10', 'width=560,height=680,scrollbars=yes,resizable=yes');
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

	if(!frm.txZip.value){
		alert("우편번호를 입력 해주세요");
		frm.txZip.focus();
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
	frm.action = "/event/etc/doEventSubscript75143.asp";
	frm.submit();
	return;
}
</script>



<div class="evt75143 vipGift">
	<div class="topic">
		<h2 id="animation">
			<span class="year"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/tit_2016.png" alt="2016" /></span>
			<span class="letter letter1"><span></span></span>
			<span class="letter letter2"><span></span>VIP</span>
			<span class="letter letter3"><span></span>GIFT</span>
		</h2>
		<p><span></span>감사의 마음을 담아 VIP고객님만을 위한 특별한 선물을 드립니다</p>
	</div>

	<div class="slideWrap">
		<div id="slide" class="slide">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/img_slide_01_v1.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/img_slide_02_v1.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/img_slide_03.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/img_slide_04.jpg" alt="" /></div>
		</div>
		<a href="/street/street_brand_sub06.asp?makerid=soxxsyndrome" class="btnBrand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/btn_brand.png" alt="삭스신드롬 브랜드 더보기" /></a>
	</div>

	<div class="contents">
		<div class="article">
			<h3 class="hidden">신청방법</h3>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/txt_way_apply.png" alt="12월 현재 VIP 골드, VIP 실버 고객께서는 2016년 12월 26일 월요일부터 31일 토요일까지 VIP GIFT를 신청해주세요. 배송은 2017년 1월 9일 월요일부터 순차적으로 배송되며, 한정 수량으로 조기 종료될 수 있습니다." /></p>

			<%' for dev msg : VIP 입장하기 클릭시 <div id="address" class="address">...</div> 보입니다. %>
			<a href="" id="btnEnter" class="btnEnter" onclick="jsvipgo();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/btn_enter.gif" alt="VIP 입장하기" /></a>
			<div id="address" class="address">
				<div class="form">
					<%' form %>
					<%If oUserInfo.FresultCount >0 Then %>
					<form name="frmorder" method="post">
					<input type="hidden" name="reqphone1"/>
					<input type="hidden" name="reqphone2"/>
					<input type="hidden" name="reqphone3"/>
					<input type="hidden" name="mode"/>
						<fieldset>
						<legend>VIP GIFT 배송지 주소 입력</legend>
							<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/tit_address.png" alt="배송지 주소 확인하기" /></h4>

							<p class="note"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/txt_note.png" alt="기본 회원 정보 주소를 불러오며, 수정 가능합니다. 주소입력 후 VIP GIFT 신청완료를 클릭하셔야 신청이 완료 되며, 완료된 후에는 주소를 변경하실 수 없습니다." /></p>

							<div class="selectOption">
								<span>
									<input type="radio" id="address01" name="addr" value="1" checked />
									<label for="address01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/txt_label_01.png" alt="기본 주소" /></label>
								</span>
								<span>
									<input type="radio" id="address02" name="addr" value="2" onclick="PopOldAddress();"/>
									<label for="address02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/txt_label_02.png" alt="나의 주소록" /></label>
								</span>
							</div>

							<table style="width:342px;">
								<caption>배송지의 이름, 휴대폰, 주소 정보</caption>
								<tbody>
								<tr>
									<th scope="row" style="width:92px;">
										<label for="username"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/txt_th_name.png" alt="이름" /></label>
									</th>
									<td style="width:250px;">
										<input type="text" id="username" value="<%=oUserInfo.FOneItem.FUserName%>" name="reqname" />
									</td>
								</tr>
								<tr>
									<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/txt_th_mobile.png" alt="휴대폰" /></th>
									<td>
										<div class="group">
											<input type="text" title="휴대폰번호 앞자리" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" name="reqhp1" class="width70" /><span></span>
											<input type="text" title="휴대폰번호 가운데 자리" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" name="reqhp2" class="width70" /><span></span>
											<input type="text" title="휴대폰번호 뒷자리" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" name="reqhp3" class="width70" />
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/txt_th_address.png" alt="주소" /></th>
									<td>
										<div class="group">
											<!-- old version -->
											<!--input type="text" title="우편번호 앞자리" value="010" class="width70" /><span></span>
											<input type="text" title="우편번호 뒷자리" value="010" class="width70" /-->

											<input type="text" title="우편번호" value="<%= oUserInfo.FOneItem.FZipCode %>" name="txZip" ReadOnly style="width:130px;" />
											<a href="" class="btnFind" onclick="searchzip('frmorder');return false;" ><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/btn_find.png" alt="찾기" /></a>
										</div>
										<input type="text" title="기본주소" name="txAddr1" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress1) %>" />
										<input type="text" title="상세주소" name="txAddr2" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress2) %>" />
									</td>
								</tr>
								</tbody>
							</table>
							<div class="btnsubmit"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2016/75143/btn_submit.png" alt="VIP GIFT 신청완료" onclick="jsSubmitComment();return false;" /></div>
						</fieldset>
					</form>
					<% End If %>
				</div>
			</div>
		</div>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75143/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li><span></span>텐바이텐 VIP SILVER, VIP GOLD, VVIP 고객만 신청이 가능합니다.</li>
			<li><span></span>본 사은품은 한정 수량으로 조기 선착순 마감 될 수 있습니다.</li>
			<li><span></span>사은품은 현금 성 환불이 불가합니다.</li>
		</ul>
	</div>
</div>

<%
	Set oUserInfo = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
