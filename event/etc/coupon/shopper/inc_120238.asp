<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 텐x텐 힘내쿠폰 이벤트
' History : 2022.10.04 정태훈
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
dim eCode : eCode = chkiif(application("Svr_Info") = "Dev","119222","120238")
%>
<style>
.evt120238{position:relative; max-width:1920px; margin:0 auto;}
.evt120238 section{position:relative;}
.evt120238 a{display:block; width:100%; height:100%;}

/* section01 */
.evt120238 .section01{height:1206px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/120238/section01.jpg) 50% 0;}
.evt120238 .section01 .input-cpn{position:absolute; width:398px; height:67px; left:50%; margin-left:-199px; top:547px; font-size:21px; color:#a7a7a7; text-align:center;}
.evt120238 .section01 .btn-cpn{position:absolute; width:524px; height:76px; left:50%; margin-left:-262px; top:639px;}

/* section02 */
.evt120238 .section02{padding:45px 0 82px 0;}
.evt120238 .section02 .section02_bnr{width:787px; height:205px; left:50%; margin:auto; margin-left:-7px;}

/* section03 */
.evt120238 .section03{height:295px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/120238/section03.jpg) 50% 0;}

/* 주년 랜딩 배너 */
.evt120238 .banner_21th{width:165px; height:147px; position:absolute; top:30px; left:50%; margin-left:407px; z-index:20;}
.evt120238 .banner_21th img{width:100%; height:100%;}
</style>
						<div class="evt120238">
							<section class="section01">
								<input type="text" id="couponname" class="input-cpn" placeholder="쿠폰코드를 입력해주세요!">
								<a href="" class="btn-cpn" onclick="jsDownCustomCoupon();return false;"></a>
							</section>
							<section class="section02">
								<!-- 주년 랜딩 배너 -->
								<a href="/event/21th/index.asp?tabType=benefit"><img src="//webimage.10x10.co.kr/fixevent/event/2022/120238/section02_bnr.png?v=2" alt="" class="section02_bnr"></a>
							</section>
							<section class="section03"></section>
							<!-- 주년 랜딩 배너 -->
							<div class="banner_21th">
								<a href="/event/21th/index.asp?tabType=benefit"><img src="//webimage.10x10.co.kr/fixevent/event/2022/120238/tenbyten_2022-sale_emblem_02.png?v=2" alt=""></a>
							</div>
						</div>
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