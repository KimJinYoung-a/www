<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 텐바이텐X인플루언서 비밀쿠폰
' History : 2020-03-31 조경애
'###########################################################
' UI 개발 가이드
'###########################################################
' <button onclick="jsDownCustomCoupon();"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97856/m/btn_tencpu.jpg" alt="쿠폰 등록"></button>
' ㄴ 버튼에 스크립트 추가
' <input id="couponname" type="text" placeholder="쿠폰명을 입력해주세요!">
' ㄴ 쿠폰명 입력 부분 input id="couponname" 네이밍 그대로 써주세요
' dim eCode : eCode = chkiif(application("Svr_Info") = "Dev","90412","100761")
' ㄴ 이벤트 코드 설정 ex) 90412 - 테스트이벤트코드 , 100761 - 실서버이벤트코드 (2가지 각각 이벤트 코드 생성후 변경)
'###########################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode : eCode = chkiif(application("Svr_Info") = "Dev","101599","101774")
%>
<style>
.evt101774 {position:relative;}
.evt101774 .topic {position:relative; height:948px; background:#ff61c5 url(//webimage.10x10.co.kr/fixevent/event/2020/101774/bg_topic.png?v=2) 50% 0 no-repeat;}
.evt101774 .topic h2 {font-size:0; color:transparent;}
.evt101774 .topic .btn-sale {position:absolute; left:50%; top:0; margin-left:160px;}
.evt101774 .inp {position:absolute; top:577px; left:50%; width:300px; margin-left:-150px;}
.evt101774 .inp input[type=text] {display:block; width:100%; height:68px; background:none; text-align:center; font-size:21px; letter-spacing:-1px;}
.evt101774 .btn-cpn {position:absolute; top:668px; left:50%; width:400px; height:90px; margin-left:-196px; font-size:0; color:transparent; background:none;}
.evt101774 .howto {background:url(//webimage.10x10.co.kr/fixevent/event/2020/101774/bg_howto.png) 50% 0 repeat;}
.evt101774 .noti {padding:65px 0 70px; background:#7c7c7c;}
.evt101774 .bnr-evt {font-size:0; margin-bottom:52px;}
</style>
<%'!-- MKT 비밀쿠폰 101774 --%>
<div class="evt101774">
	<div class="topic">
		<h2>텐바이텐과 인플루언서가 비밀쿠폰을 드려요</h2>
        <a href="/event/eventmain.asp?eventid=101722" class="btn-sale"><img src="//webimage.10x10.co.kr/fixevent/event/2020/101774/btn_sale.png" alt="정기세일 바로가기"></a>
		<div class="inp"><input type="text" id="couponname" placeholder="쿠폰코드를 입력해주세요!"></div>
		<button type="button" onclick="jsDownCustomCoupon();" class="btn-cpn">쿠폰 발급 받기</button>
	</div>
	<div class="howto"><img src="//webimage.10x10.co.kr/fixevent/event/2020/101774/txt_howto.png" alt="쿠폰 등록 방법"></div>
	<div class="noti">
		<% if date() <= "2020-04-18" then %>
		<div class="bnr-evt">
			<a href="/event/eventmain.asp?eventid=101391"><img src="//webimage.10x10.co.kr/fixevent/event/2020/101774/bnr_evt_1.png" alt="알림 신청만 하면 1,000P 무료 지급!"></a>
			<a href="/event/eventmain.asp?eventid=101305"><img src="//webimage.10x10.co.kr/fixevent/event/2020/101774/bnr_evt_2.png" alt="지금 토스로 6만원 이상 결제하면 5천원 추가 중복 할인!"></a>
		</div>
		<% end if %>
		<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/101774/txt_noti.png" alt="이벤트 유의사항"></p>
	</div>
</div>
<%'!--// MKT 텐X텐 쿠폰 100761 --%>

<script type="text/javascript">
function jsDownCustomCoupon(){
	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
	<% else %>	
	$.ajax({
		type: "post",
		url: "/event/etc/coupon/shopper/couponprocess.asp",				
		data: {
			couponname : $("#couponname").val(),
			eventid : <%=eCode%>
		},
		cache: false,
		success: function(resultData) {			
			var reStr = resultData.split("|");				
			if(reStr[0]=="OK"){		
				fnAmplitudeEventMultiPropertiesAction('click_custom_coupon_btn','evtcode|couponname','<%=eCode%>|'+$("#couponname").val());
				alert('3,000원 할인 쿠폰이 지급되었습니다!');
			}else if(reStr[0]=="ERR"){
				var errorMsg = reStr[1].replace(">?n", "/n");
				alert(errorMsg);										
			}			
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
	<% end if %>
	$('#couponname').val('');
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->