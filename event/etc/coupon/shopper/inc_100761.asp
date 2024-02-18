<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 텐x텐 쿠폰 이벤트
' History : 2020-02-17 이종화
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
dim eCode : eCode = chkiif(application("Svr_Info") = "Dev","90470","100761")
%>
<style>
.evt100761 {position:relative;}
.evt100761 .topic {position:relative; height:948px; background:#fff558 url(//webimage.10x10.co.kr/fixevent/event/2020/100761/bg_top.png) 50% 0 no-repeat;}
.evt100761 .topic h2 {font-size:0; color:transparent;}
.evt100761 .inp {position:absolute; top:577px; left:50%; margin-left:-167px;}
.evt100761 .inp input[type=text] {width:342px; height:70px; background:none; text-align:center; font-size:21px; letter-spacing:-1px;}
.evt100761 .btn-cpn {position:absolute; top:668px; left:50%; width:400px; height:90px; margin-left:-196px; font-size:0; color:transparent; background:none;}
.evt100761 .howto {background:url(//webimage.10x10.co.kr/fixevent/event/2020/100761/bg_howto.jpg) 50% 0 repeat;}
.evt100761 .noti {padding:65px 0 70px; background:#2c4c80;}
.evt100761 .bnr-evt {font-size:0; margin-bottom:52px;}
</style>
<%'!-- MKT 텐X텐 쿠폰 100761 --%>
<div class="evt100761">
	<div class="topic">
		<h2>텐X텐 쿠폰</h2>
		<div class="inp"><input type="text" id="couponname" placeholder="쿠폰코드를 입력해주세요!"></div>
		<button type="button" onclick="jsDownCustomCoupon();" class="btn-cpn">쿠폰 발급 받기</button>
	</div>
	<div class="howto"><img src="//webimage.10x10.co.kr/fixevent/event/2020/100761/txt_howto.png" alt="쿠폰 등록 방법"></div>
	<div class="noti">
		<div class="bnr-evt">
			<!-- 마케팅이벤트 띠배너 -->
			<!-- FLEX 유입이벤트 2020-02-24 ~ 2020-03-05 동안에만 노출 -->
			<% If Date() <= "2020-03-05" Then %>
			<a href="/event/eventmain.asp?eventid=100730"><img src="//webimage.10x10.co.kr/fixevent/event/2020/100761/bnr_evt_1.jpg" alt="샤넬 지갑"></a>
			<% End If %>
			<a href="/event/eventmain.asp?eventid=96333"><img src="//webimage.10x10.co.kr/fixevent/event/2020/100761/bnr_evt_2.jpg" alt="텐바이텐 메일 구독"></a>
		</div>
		<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/100761/txt_noti.png" alt="이벤트 유의사항"></p>
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
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->