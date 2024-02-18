﻿<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
'#############################################################
'	Description : 사람은 돌아오는거야 W
'	History		: 2015.01.20 유태욱 생성
'	History		: 2016.06.07 유태욱 수정,추가(쿠폰발급)
'#############################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->

<%
Dim chkid, eCode
dim subscriptcount, subscripttotalcount
dim currenttime
	currenttime =  now()

'															currenttime = #01/22/2016 09:00:00#

IF application("Svr_Info") = "Dev" THEN
	eCode   =  66005
Else
	eCode   =  68736
End If

chkid = GetEncLoginUserID()

If IsUserLoginOK() Then
	Dim oUserInfo
	Set oUserInfo = new CUserInfo
		oUserInfo.FRectUserID = chkid
	If (chkid<>"") then
	    oUserInfo.GetUserData
	End If
end if

'//본인 참여 여부
if chkid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, chkid, "", "", "201606")
end if

'//총 참여수
subscripttotalcount = getevent_subscripttotalcount(eCode, "", "", "201606")
%>
<style type="text/css">
img {vertical-align:top;}
.evt68736 {background:#fff;}
.catchBall {position:relative; height:622px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68736/bg_grass_v1.jpg) no-repeat 0 0;}
.catchBall .speedometer {position:absolute; right:0; top:210px; width:380px; height:115px;}
.catchBall .speedometer p {position:absolute; left:0; top:0; width:380px; height:115px;}
.catchBall .speedometer p.km01 {z-index:30;}
.catchBall .speedometer p.km02 {z-index:20;}
.catchBall .speedometer p.km03 {z-index:10;}
.catchBall .date {position:absolute; left:50%; top:477px; margin-left:-129px;}
.catchBall .ball {display:block; position:absolute; left:50%; top:50%; width:534px; height:534px; margin:-310px 0 0 -267px; z-index:50; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/68736/btn_ball.png) no-repeat 50% 50%; text-indent:-9999px;}
.catchBall .scene02 .ball {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68736/img_ball.png); background-size:20%;}
.catchBall .scene04 .ball {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68736/img_ball.png); background-size:20%;}
.catchBall .scene03 {position:absolute; left:60px; top:47px; width:970px; height:476px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68736/img_catch_v3.png) no-repeat 0 0; }
.catchBall .scene03 .enterAddr {padding:36px 0 0 495px; width:442px; text-align:center;}
.catchBall .scene03 .enterAddr table {text-align:left; margin-top:25px;}
.catchBall .scene03 .enterAddr td {padding-bottom:17px;}
.catchBall .scene03 .enterAddr th {vertical-align:top; padding-top:9px;}
.catchBall .scene03 .enterAddr .txtInp {height:20px; border-radius:3px;}
.catchBall .scene03 .tip {position:absolute; left:458px; top:485px;}
.catchBall .scene05 {position:absolute; top:-46px; left:302px; width:547px;}
.catchBall .scene05 button {margin-top:43px; background-color:transparent;}

.evtNoti {overflow:hidden; height:146px; padding-top:37px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68736/bg_notice.png) no-repeat 0 0;}
.evtNoti h3 {float:left; padding:0 45px 0 100px;}
.evtNoti ul {float:left; padding-top:5px;}
.evtNoti ul li {line-height:13px; padding-bottom:10px; color:#fff;}
</style>

	<!-- [W] 68736 사람은 돌아오는거야 -->
	<div class="evt68736">
		<!-- for dev msg : 20160607 이미지 변경 -->
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/tit_comeback_v1.png" alt="사람은~ 돌아오는거야아래 공을 한번 눌러보세요! 놀라운 선물이 당신을 찾아갑니다!" /></h2>
		<div class="catchBall">
			<div class="scene01">
				<button class="ball">공을 눌러서 던져보세요</button>
				<div class="speedometer"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/img_speedometer_01.gif" alt="" /></div>
			</div>

			<% if subscripttotalcount < 280 then %>
				<div class="scene02">
					<div class="ball"></div>
					<div class="speedometer">
						<p class="km01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/img_speedometer_02.gif" alt="" /></p>
						<p class="km02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/img_speedometer_03.gif" alt="" /></p>
					</div>
				</div>
	
				<form name="frmorder" id="frmorder" onSubmit="return false;" method="post">
				<input type="hidden" name="mode" value="balladd">
				<div class="scene03">
					<div class="enterAddr">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/tit_info.png" alt="배송지 정보" /></h3>
						<table>
							<colgroup>
								<col style="width:75px;"><col style="width:*;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row"><label for="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/txt_name.png" alt="이름" /></label></th>
								<td><input type="text" class="txtInp" name="reqname" id="name" disabled maxlength="10" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" value="<%=GetLoginUserName%>" /></td>
							</tr>
							<tr>
								<th scope="row"><label for="tel01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/txt_tel.png" alt="전화번호" /></label></th>
								<td>
									<input type="text" name="userphone1" class="txtInp" style="width:50px;" id="up01" maxlength="3" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" value="<% If IsUserLoginOK() Then response.write Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",0) end if %>" title="전화번호 국번 입력" /> - 
									<input type="text" name="userphone2" class="txtInp" style="width:60px;" id="up02" maxlength="4" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" value="<% If IsUserLoginOK() Then response.write Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",1) end if %>" title="전화번호 가운데자리 입력" /> - 
									<input type="text" name="userphone3" class="txtInp" style="width:60px;" id="up03" maxlength="4" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" value="<% If IsUserLoginOK() Then response.write Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",2) end if %>" title="전화번호 뒷자리 입력" />
								</td>
							</tr>
							<tr>
								<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/txt_address.png" alt="주소" /></th>
								<td>
									<input type="text" name="txZip1" class="txtInp" readOnly style="width:50px;" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" value="<% If IsUserLoginOK() Then response.write Splitvalue(oUserInfo.FOneItem.FZipCode,"-",0) end if %>" title="우편번호 앞자리" /> - 
									<input type="text" name="txZip2" class="txtInp" readOnly style="width:50px;" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" value="<% If IsUserLoginOK() Then response.write Splitvalue(oUserInfo.FOneItem.FZipCode,"-",1) end if %>" title="우편번호 뒷자리" /> 
									<% If IsUserLoginOK() Then %>
										<a href="javascript:TnFindZip('frmorder');"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/btn_zipcode.png" alt="우편번호 찾기" /></a>
									<% end if %>
									<p class="tPad15"><input type="text" name="txAddr1" readOnly class="txtInp" style="width:340px;" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" value="<% If IsUserLoginOK() Then response.write doubleQuote(oUserInfo.FOneItem.FAddress1) end if %>" /></p>
									<p class="tPad15"><input type="text" name="txAddr2" class="txtInp" style="width:340px;" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" value="<% If IsUserLoginOK() Then response.write doubleQuote(oUserInfo.FOneItem.FAddress2) end if %>" title="상세주소 입력" /></p>
								</td>
							</tr>
							</tbody>
						</table>
						<input type="image" src="http://webimage.10x10.co.kr/eventIMG/2016/68736/btn_apply.png" onclick="jsSubmit(); return false;" alt="사은품 신청하기" class="btnApply" />
					</div>
					<p class="tip"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/txt_tip.png" alt="입력해주신 주소는 마이텐바이텐&gt;개인정보에 반영됩니다" /></p>
				</div>
				</form>
			<% else %>
				<div class="scene04">
					<div class="ball"></div>
					<div class="speedometer">
						<p class="km01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/img_speedometer_02.gif" alt="" /></p>
						<p class="km02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/img_speedometer_04.gif" alt="" /></p>
					</div>
				</div>
				<div class="scene05">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/img_coupon.png" alt="와우! 만원 이상 구매시 오천원 쿠폰이에요 발급 후 24시간 이내에 꼭 사용하세요!" /></p>
					<button type="button" onclick="jscpSubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/btn_coupon.png"  alt="쿠폰 발급받기" /></button>
				</div>
			<% end if %>
		</div>
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/68736/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>- 본 이벤트는 텐바이텐 휴면 정책에 따라 1년간 로그인하지 않은 고객 대상으로 진행되는 이벤트입니다.</li>
				<li>- 사은품은 한정수량으로 조기 마감될 수 있습니다.</li>
				<li>- 사은품 신청 후에는 주소 변경이 불가하며, 6월 13일부터 배송될 예정입니다.</li>
				<li>- 지급된 쿠폰은 발급 후 24시간까지 사용할 수 있습니다.</li>
			</ul>
		</div>
	</div>
<script type="text/javascript">
$(function(){
	/* catch ball */
	$(".scene01 .ball").click(function(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-01-22" and left(currenttime,10)<"2017-01-01" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if subscriptcount <> 0 then %>
				alert("이미 참여하셨습니다.");
				return false;
			<% else %>
				var result;
				$.ajax({
					type:"GET",
					url:"/event/etc/doeventsubscript/doEventSubscript68736.asp",
					data: "mode=ballstart",
					dataType: "text",
					async:false,
					cache:true,
					success : function(Data){
						result = jQuery.parseJSON(Data);
						if (result.chcode=="55")
						{
							alert("잘못된 접속 입니다.");
							return;
						}
						else if (result.chcode=="77")
						{
							alert("신청하려면 로그인을 해야합니다.");
							return;
						}
						else if (result.chcode=="88")
						{
							alert("이벤트 기간이 아닙니다.");
							return;
						}
						else if (result.chcode=="99")
						{
							alert("이벤트 대상자가 아닙니다.");
							return;
						}
						else if (result.chcode=="44")
						{
							$(".scene01").hide();
							<% if subscripttotalcount < 280 then %>
								$(".scene02").show();
								playBall1();
							<% else %>
								$(".scene04").show();
								playBall2();
							<% end if %>
						}
					}
				});
			<% end if %>
		<% end if %>
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% end if %>
	});

	function playBall1() {
		$(".scene02 .ball").delay(100).animate({backgroundSize:"100%"},700);
		$(".scene02 .km01").delay(700).hide(100);
		$(".scene02").delay(1300).fadeOut(50);
		$(".scene03").delay(1300).fadeIn(50);
	}

	function playBall2() {
		$(".scene04 .ball").delay(100).animate({backgroundSize:"100%"},700);
		$(".scene04 .km01").delay(700).hide(100);
		$(".scene04").delay(1300).fadeOut(50);
		$(".scene05").delay(1300).fadeIn(50);
	}

	/* animation */
	$(".scene02").hide();
	$(".scene03").hide();
	$(".scene04").hide();
	$(".scene05").hide();
	function moveBall () {
		$(".scene01 .ball").animate({"margin-top":"-325px"},700).animate({"margin-top":"-310px"},700, moveBall);
	}
	moveBall();
});

function jsSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-01-22" and left(currenttime,10)<"2017-01-01" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>

			if (document.frmorder.txZip2.value.length<3){
				alert('우편번호를 입력해 주세요.');
				document.frmorder.txZip2.focus();
				return;
			}

			if (document.frmorder.txAddr2.value.length<1){
				alert('나머지 주소를 입력해 주세요.');
				document.frmorder.txAddr2.focus();
				return;
			}

			if (GetByteLength(document.frmorder.txAddr2.value)>80){
				alert('나머지 주소가 너무 깁니다. 80byte이내로 작성해주세요.\n※한글 1글자는 2byte입니다.');
				document.frmorder.txAddr2.focus();
				return;
			}

			if (jsChkBlank(document.frmorder.userphone1.value)||document.frmorder.userphone1.value.length<3){
			    alert("전화번호를 입력해주세요");
				document.frmorder.userphone1.focus();
				return ;
			}

			if (jsChkBlank(document.frmorder.userphone2.value)||document.frmorder.userphone2.value.length<3){
			    alert("전화번호를 입력해주세요");
				document.frmorder.userphone2.focus();
				return ;
			}
		
			if (jsChkBlank(document.frmorder.userphone3.value)||document.frmorder.userphone3.value.length<4){
			    alert("전화번호를 입력해주세요");
				document.frmorder.userphone3.focus();
				return ;
			}
		
			if (!jsChkNumber(document.frmorder.userphone1.value) || !jsChkNumber(document.frmorder.userphone2.value) || !jsChkNumber(document.frmorder.userphone3.value)){
			    alert("전화번호는 공백없는 숫자로 입력해주세요.");
				document.frmorder.userphone1.focus();
				return ;
			}

			var result;
			$.ajax({
				type:"GET",
				url:"/event/etc/doeventsubscript/doEventSubscript68736.asp",
				data: $("#frmorder").serialize(),
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data){
					result = jQuery.parseJSON(Data);
					if (result.chcode=="55")
					{
						alert("잘못된 접속 입니다.");
						return;
					}
					else if (result.chcode=="77")
					{
						alert("신청하려면 로그인을 해야합니다.");
						return;
					}
					else if (result.chcode=="88")
					{
						alert("이벤트 기간이 아닙니다.");
						return;
					}
					else if (result.chcode=="22")
					{
						alert("이미 신청하셨습니다.");
						return;
					}
					else if (result.chcode=="99")
					{
						alert("이벤트 대상자가 아닙니다.");
						return;
					}
					else if (result.chcode=="66")
					{
						alert("주소 입력이 잘못되었습니다.");
						return;
					}
					else if (result.chcode=="33")
					{
						alert("신청이 완료 되었습니다.");
						return;
					}
					else if (result.chcode=="999")
					{
						alert("오류 입니다.");
						return;
					}
				}
			});
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

function jscpSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-01-22" and left(currenttime,10)<"2017-01-01" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			var result;
			$.ajax({
				type:"GET",
				url:"/event/etc/doeventsubscript/doEventSubscript68736.asp",
				data: "mode=cp",
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data){
					result = jQuery.parseJSON(Data);
					if (result.chcode=="55")
					{
						alert("잘못된 접속 입니다.");
						return;
					}
					else if (result.chcode=="77")
					{
						alert("로그인을 해야합니다.");
						return;
					}
					else if (result.chcode=="88")
					{
						alert("이벤트 기간이 아닙니다.");
						return;
					}
					else if (result.chcode=="22")
					{
						alert("이미 발급 받으셨습니다.");
						return;
					}
					else if (result.chcode=="99")
					{
						alert("이벤트 대상자가 아닙니다.");
						return;
					}
					else if (result.chcode=="11")
					{
						alert("발급이 완료 되었습니다.");
						return;
					}
					else if (result.chcode=="999")
					{
						alert("오류 입니다.");
						return;
					}
				}
			});
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

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}
}
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->