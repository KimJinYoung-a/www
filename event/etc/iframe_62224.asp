<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description :  2015오픈이벤트 - vipGift 재오픈
' History : 2015-05-06 이종화생성
'####################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
	dim oUserInfo
	set oUserInfo = new CUserInfo
		oUserInfo.FRectUserID = GetLoginUserID
	if (GetLoginUserid<>"") then
		oUserInfo.GetUserData
	end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
.vipGift {margin-bottom:-80px !important; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60833/bg_honey.gif) repeat-x left bottom #fff6d1;}
.vipGift img {vertical-align:top;}
.vipGiftContainer {padding-bottom:75px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60833/bg_cont.gif) no-repeat center top; text-align:center;}
.vipHead {position:relative; padding-top:75px; margin-top:-15px; z-index:20;}
.vipCont {overflow:hidden; width:1068px; margin:0 auto; padding-top:57px;}
.vipCont .slideWrap {position:relative; float:left; width:742px; height:641px; padding:23px 0 0 22px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60833/bg_slide.png) left top no-repeat;}
.vipCont .slideWrap .desc {position:absolute; right:45px; bottom:45px; z-index:35}
.vipCont .slide {position:relative; overflow:visible !important; width:720px; height:620px;}
.vipCont .slide .slidesjs-navigation {display:block; position:absolute; top:50%; width:54px; height:70px; margin-top:-35px; z-index:30; text-indent:-9999px; background-position:left top; background-repeat:no-repeat;}
.vipCont .slide .slidesjs-previous {left:-20px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60833/btn_prev.png);}
.vipCont .slide .slidesjs-next {right:-20px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60833/btn_next.png);}
.vipCont .slide .slidesjs-pagination {position:absolute; left:50%; bottom:24px; width:122px; margin-left:-61px; z-index:30;}
.vipCont .slide .slidesjs-pagination li {float:left; padding:0 6px;}
.vipCont .slide .slidesjs-pagination li a {display:block; width:12px; height:12px; text-indent:-9999px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60833/btn_pagination.png) left top no-repeat;}
.vipCont .slide .slidesjs-pagination li a.active {background-position:-12px top;}
.vipCont .vipArea {position:relative; float:left; width:266px; height:596px; margin-left:-4px; padding:68px 0 0 38px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60833/bg_vip_area.png) left top no-repeat;}
.vipCont .vipArea .goBtn {position:absolute; right:28px; bottom:27px;}
.vipCont .vipArea .goBtn span {cursor:pointer;}
.vipCont .checkAddr {padding-top:25px; font-size:11px;}
.vipCont .checkAddr label,
.vipCont .checkAddr input {vertical-align:middle;}
.vipCont .checkAddr ul {padding-top:15px;}
.vipCont .checkAddr li {overflow:hidden; width:230px; padding-bottom:16px;}
.vipCont .checkAddr li strong {display:block; float:left; width:50px; line-height:30px;}
.vipCont .checkAddr li div {float:left; width:180px;}
.vipCont .checkAddr li input {width:157px; height:25px; color:#666; border:1px solid #ccc; line-height:12px; padding:3px 8px 0; vertical-align:middle;}
.vipCont .checkAddr li input.ct {padding-left:0; padding-right:0;}
.noti {padding-top:95px;}
.noti .inner {width:940px; margin:0 auto; text-align:left;}
.noti ul {overflow:hidden; padding-top:33px;}
.noti ul li {margin-top:4px; padding-left:24px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60833/blt_circle_brown.gif) no-repeat 0 6px; color:#555; font-size:11px; line-height:1.75em;}
</style>
<script type="text/javascript">
$(function(){
	$(".slide").slidesjs({
		width:"720",
		height:"620",
		navigation:{effect:"fade"},
		pagination:{effect:"fade"},
		play: {interval:3700, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}
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
});

function jsvipgo(){
	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% else %>
		<% if GetLoginUserLevel() = 3 or GetLoginUserLevel() = 4 then  %>
			$(".sectionA").css("display","none");
			$(".sectionB").css("display","block");
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
	frm.action = "/event/etc/doeventsubscript/doEventSubscript62224.asp";
	frm.submit();
	return;
}
</script>
</head>
<body>
<div class="vipGift">
	<div class="vipGiftContainer">
		<div class="vipHead">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/62224/tit_vip_honey.png" alt="VIP 고객님을 위한 달콤한 정성 - 단지 널 사랑해" /></h2>
			<p class="tPad20"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62224/txt_gift.png" alt="VIP GIFT를 놓치셨다면, 지금 바로 확인하세요!" /></p>
			<p class="tPad20"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62224/txt_date.png" alt="한정수량으로 조기 소진될 수 있습니다!" /></p>
		</div>
		<div class="vipCont">
			<div class="slideWrap">
				<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/txt_dangsantree.png" alt="dangsantree 국내산 토종꿀 100% 30gX2개" /></p>
				<div class="slide">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/img_slide01.jpg" alt="사은품 꿀 이미지" />
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/img_slide02.jpg" alt="사은품 꿀 이미지" />
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/img_slide03.jpg" alt="사은품 꿀 이미지" />
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/img_slide04.jpg" alt="사은품 꿀 이미지" />
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/img_slide05.jpg" alt="사은품 꿀 이미지" />
				</div>
			</div>
			<!-- VIP 주소입력 -->
			<div class="vipArea">
				<!-- 입장 전 -->
				<div class="sectionA">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/txt_greeting.gif" alt="VIP 고객님 안녕하세요!" /></p>
					<p class="goBtn" onclick="jsvipgo();"><span><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/btn_enter.png" alt="VIP고객 입장하기" /></span></p>
				</div>
				<!--// 입장 전 -->

				<!-- 주소입력 -->
				<div class="sectionB" style="display:none;">
					<%If oUserInfo.FresultCount >0 Then %>
					<form name="frmorder" method="post">
					<input type="hidden" name="reqphone1"/>
					<input type="hidden" name="reqphone2"/>
					<input type="hidden" name="reqphone3"/>
					<input type="hidden" name="mode"/>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/txt_check_address.gif" alt="배송지 주소 확인" /></p>
					<div class="checkAddr">
						<p>
							<span><input type="radio" id="addr01" name="addr" value="1" checked/> <label for="addr01">기본 주소</label></span>
							<span class="lPad10"><input type="radio" id="addr02" name="addr" value="2" onclick="PopOldAddress();" /> <label for="addr02"> 나의 주소록</label></span>
						</p>
						<ul>
							<li>
								<strong>이름</strong>
								<div><input type="text" value="<%=oUserInfo.FOneItem.FUserName%>" name="reqname" /></div>
							</li>
							<li>
								<strong>휴대폰</strong>
								<div>
									<input type="text" style="width:46px;" class="ct" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" name="reqhp1"/> -
									<input type="text" style="width:48px;" class="ct" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" name="reqhp2"/> -
									<input type="text" style="width:46px;" class="ct" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" name="reqhp3"/>
								</div>
							</li>
							<li>
								<strong>주소</strong>
								<div>
									<input type="text" style="width:47px;" class="ct" value="<%= Splitvalue(oUserInfo.FOneItem.FZipCode,"-",0) %>" name="txZip1" ReadOnly/> - <input type="text" style="width:47px;" class="ct" value="<%= Splitvalue(oUserInfo.FOneItem.FZipCode,"-",1) %>" name="txZip2" ReadOnly/> <a href="" onclick="searchzip('frmorder');return false;" class="lMar05"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/btn_find.gif" alt="찾기" /></a>
									<p class="tMar07"><input type="text" name="txAddr1" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress1) %>"/></p>
									<p class="tMar07"><input type="text" name="txAddr2" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress2) %>"/></p>
								</div>
							</li>
						</ul>
					</div>
					<p class="tPad05" style="margin-left:-10px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/txt_tip.gif" alt="위 주소는 기본 회원 정보 주소이며, 수정가능합니다./[VIP GIFT 받기]를 클릭하셔야 신청이 오안료되며, 완료된 후에는 주소를 변경하실 수 없습니다." /></p>
					<p class="goBtn" onclick="jsSubmitComment();return false;"><span><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/btn_submit.png" alt="VIP GIFT 받기" /></span></p>
					</form>
					<% End If %>
				</div>
				<!--// 주소입력 -->

				<!-- 사은품 소진 시 -->
				<div class="sectionC" style="display:none;">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/txt_greeting.gif" alt="VIP 고객님 안녕하세요!" /></p>
					<p style="padding-top:103px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/txt_soldout.gif" alt="사은품이 모두 소진되었습니다. 감사합니다." /></p>
				</div>
				<!--// 사은품 소진 시 -->
			</div>
			<!--// VIP주소입력 -->
		</div>
		<div class="noti">
			<div class="inner">
				<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60833/tit_noti.gif" alt="이벤트 유의사항" /></h4>
				<ul>
					<li>텐바이텐 VIP SILVER, VIP GOLD 고객만 신청이 가능합니다.</li>
					<li>본 사은품은 한정수량으로 조기에 선착순 마감 될 수 있으며, 1차 : 5월 14일(목) 2차 : 5월 21(목) 배송 될 예정입니다.</li>
					<li>경품은 현금성 환불 및 옵션 선택이 불가합니다.</li>
				</ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<%
	Set oUserInfo = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->