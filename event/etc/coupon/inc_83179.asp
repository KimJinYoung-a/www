<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 연말정산쿠폰
' History : 2017-12-21 정태훈
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->

<%
dim eCode, getbonuscoupon1

IF application("Svr_Info") = "Dev" THEN
	eCode = 67495
	getbonuscoupon1 = 2865
Else
	eCode = 83179
	getbonuscoupon1 = 1020	'50,000/10,000
End If
%>
<style type="text/css">
img {vertical-align:top;}
.evt83179 {position:relative;}
.evt83179 .couponDownload {position:relative;}
.evt83179 .couponDownload .soldOutIcon {position:absolute; top:-35px; left:775px; animation:bounce 1s infinite;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
.evt83179 .couponDownload .soldOut {position:absolute; top:305px; left:380px;}
.evt83179 .eventNotice {height:200px; background:#3d3d3d;}
.evt83179 .eventNotice h3, .eventNotice ul {float:left;}
.evt83179 .eventNotice h3 {margin:95px 0 0 110px;}
.evt83179 .eventNotice ul {position:relative; margin:40px 0 0 70px; padding-left:60px; border-left:#646464 1px solid;}
.evt83179 .eventNotice ul li {color:#fff; font-size:12px; line-height:12px; text-align:left; padding:6.5px 0;}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #12/26/2017 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process_83179.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.\n12월 26일 자정까지 사용하세요.');
				return false;
			}else if (str1[0] == "12"){
				alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
				return false;
			}else if (str1[0] == "13"){
				alert('이미 다운로드 받으셨습니다.');
				return false;
			}else if (str1[0] == "02"){
				alert('로그인 후 쿠폰을 받을 수 있습니다!');
				return false;
			}else if (str1[0] == "01"){
				alert('잘못된 접속입니다.');
				return false;
			}else if (str1[0] == "00"){
				alert('정상적인 경로가 아닙니다.');
				return false;
			}else{
				alert(str1);
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
						<div class="evt83179">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/83179/tit_coupon.png" alt="연말정산쿠폰 - 오늘 단, 하루 제공" /></h2>
							<div class="couponDownload">
								<a href="" onclick="jsevtDownCoupon('evtsel','<%= getbonuscoupon1 %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/83179/img_coupon.png" alt="5만원 이상 구매 시 10,000원 사용 - 기간 : 12/26(오늘 하루)" /></a>
							</div>
							<div class="appJoin">
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/83179/btn_go.png" alt="" usemap="#Map"/>
								<map name="Map">
									<area shape="rect" coords="98,80,474,163" href="/event/appdown/" alt="텐바이텐 APP 다운받기" />
									<area shape="rect" coords="675,80,1040,163" href="/member/join.asp" alt="회원가입하러 가기" />
								</map>
							</div>
							<div class="eventNotice">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/83179/txt_noti.png" alt="이벤트 유의사항"/></h3>
								<ul>
									<li style="color:#f2ce7a;">- 본 쿠폰은 이벤트 기간 내 무제한 발급이 가능합니다.</li>
									<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
									<li>- 쿠폰은 12/26(화) 23시 59분 59초에 종료됩니다.</li>
									<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
									<li>- 이벤트는 조기 마감될 수 있습니다.</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->