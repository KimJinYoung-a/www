<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  더블 마일리지! 
' History : 2016.10.31 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
dim eCode, vUserID, cMil, vMileValue, vMileArr
	vUserID = GetEncLoginUserID()
	'vUserID = "10x10yellow"
	If Now() > #11/01/2016 00:00:00# AND Now() < #11/06/2016 23:59:59# Then
		vMileValue = 200
	Else
		vMileValue = 100
	End If

	Set cMil = New CEvaluateSearcher
	cMil.FRectUserID = vUserID
	cMil.FRectMileage = vMileValue
	
	If vUserID <> "" Then
		vMileArr = cMil.getEvaluatedTotalMileCnt
	End If
	Set cMil = Nothing
%>
<style>
img {vertical-align:top;}
.evt73157 {position:relative; background:#fff;}
.evt73157 .deco {position:absolute; left:50px; top:243px;}
.myMileage {height:228px; padding:50px 130px 68px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73157/bg_box.png) 0 0 no-repeat;}
.myMileage .mgBox {position:relative;}
.myMileage .mgBox ul {position:absolute; left:73px; top:107px; width:325px;}
.myMileage .mgBox li {position:relative; margin-bottom:5px; line-height:34px; text-align:left;}
.myMileage .mgBox li strong {display:inline-block; position:absolute; right:0; top:0; width:110px; height:34px; padding-right:40px; font:bold 20px/34px arial; color:#eb3b34; text-align:right; background-position:0 0; background-repeat:no-repeat;}
.myMileage .mgBox li.m01 strong {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73157/txt_number_02.png);}
.myMileage .mgBox li.m02 strong {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73157/txt_expect_02.png);}
.myMileage .checkLogin p {position:absolute; left:0; top:40px; width:100%; text-align:center;}
.myMileage .checkLogin p strong {display:inline-block; margin-right:7px; color:#eb3b34; font:bold 17px/19px arial; border-bottom:1px solid #eb3b34;}
.myMileage .checkLogin a {position:absolute; right:68px; top:95px; animation:bounce 50 1s 1s;}
.evtNoti {position:relative; padding:45px 0 45px 271px; background:#eee;}
.evtNoti h3 {position:absolute; left:100px; top:50%; margin-top:-36px;}
.evtNoti ul {padding-left:44px; border-left:1px solid #fff;}
.evtNoti li {color:#656f7d; line-height:22px; text-align:left;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-in;}
	50% {margin-top:4px; animation-timing-function:ease-out;}
}
</style>
<script type="text/javascript">

function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}

</script>
<div class="contF">
	<!-- 더블 마일리지 -->
	<div class="evt73157">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/tit_double_mileage.png" alt="생일이 끝났지만 우린 x2 마일리지 - 지금 후기를 완성하면 마일리지를 2배로 적립해드립니다!" /></h2>
		<div class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/img_balloon.png" alt="" /></div>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/txt_mileage.png" alt="구매후기를 쓰면 200마일리지, 첫 구매후기를 쓰면 400마일리지 적립" /></p>
		<!-- 예상 마일리지 확인하기 -->
		<div class="myMileage">
			<div class="mgBox">

			<% If IsUserLoginOK Then %>
				<%' for dev msg : 로그인 후 %>
				<div class="checkLogin">
					<p><strong><%= vUserID %></strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/txt_get_mileage.png" alt="고객님! 후기 남기고 더블 마일리지 받아가세요!" /></p>
					<a href="/my10x10/goodsusing.asp"  target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/btn_review.png" alt="상품후기쓰고 더블마일리지 받기" /></a>
				</div>
				<ul>
					<li class="m01">
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/txt_number_01.png" alt="작성 가능한 후기 개수" /></span>
						<strong><%=vMileArr(0,0)%></strong>
					</li>
					<li class="m02">
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/txt_expect_01.png" alt="예상 마일리지" /></span>
						<strong><%=FormatNumber(vMileArr(1,0),0)%></strong>
					</li>
				</ul>
			<% Else %>
				<%' 로그인 전 %>
				<div class="checkLogin">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/txt_check_mileage.png" alt="나의 예상 적립 마일리지를 확인하세요!" /></p>
					<a href="" onClick="jsSubmitlogin(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/btn_login.png" alt="로그인하기" /></a>
				</div>
				<ul>
					<li class="m01">
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/txt_number_01.png" alt="작성 가능한 후기 개수" /></span>
						<strong></strong>
					</li>
					<li class="m02">
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/txt_expect_01.png" alt="예상 마일리지" /></span>
						<strong></strong>
					</li>
				</ul>
			<% End If %>
			</div>
		</div>
		<!--// 예상 마일리지 확인하기 -->
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/73157/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>- 이벤트 기간 내에 새롭게 작성하신 상품후기에 한해서만 더블 마일리지가 적용됩니다.</li>
				<li>- 기존에 작성했던 상품후기 수정은 적용되지 않습니다.</li>
				<li>- 상품후기가 삭제된 경우에는 마일리지 지급이 되지 않습니다.</li>
				<li>- 상품후기는 배송정보 [출고완료] 이후부터 작성하실 수 있습니다.</li>
				<li>- 상품과 관련 없는 내용이나 이미지를 올리거나, 직접 찍은 사진이 아닐 경우 삭제 및 마일리지 지급이 취소될 수 있습니다.</li>
			</ul>
		</div>
	</div>
	<!--// 더블 마일리지 -->
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->