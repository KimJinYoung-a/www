<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  X2 마일리지! 
' History : 2017-10-31 정태훈 생성
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
	If Now() > #11/08/2017 00:00:00# AND Now() < #11/13/2017 23:59:59# Then
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
.double-mileage {position:relative; background:#f96e54;}
.my-mileage {width:1020px; margin:0 auto; padding:60px 0 90px; background-color:#fff; border-radius:20px 20px 0 0;}
.my-mileage h3 strong {margin-right:7px; color:#ff6b4f; font:bold 17px/18px arial; border-bottom:1px solid #ff6b4f;}
.my-mileage .overHidden {width:734px; margin:0 auto; padding-top:40px;}
.my-mileage ul {float:left; padding-right:43px; text-align:left; border-right:1px dashed #bfbfbf;}
.my-mileage li {overflow:hidden; width:324px; padding:7px 0;}
.my-mileage li span {float:left;}
.my-mileage li strong {display:inline-block; float:right; width:108px; height:34px; padding-right:42px; color:#ff6b4f; text-align:right; font:normal 20px/34px verdana; letter-spacing:-0.05rem;}
.my-mileage li.m01 strong {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81360/txt_number_2.png);}
.my-mileage li.m02 strong {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81360/txt_mileage_2.png);}
.my-mileage .btn-group {float:right; width:315px;}
.noti {position:relative; padding:43px 0 43px 280px; background:#4f4f4f;}
.noti h3 {position:absolute; left:100px; top:50%; margin-top:-36px;}
.noti ul {padding-left:64px; border-left:1px solid #a0a0a0;}
.noti li {color:#fff; font-size:11px; line-height:23px; text-align:left;}
</style>
<script type="text/javascript">

function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}

</script>
						<div class="evt81360 double-mileage">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/81360/tit_double_mileage_v2.png" alt="x2 마일리지 - 이벤트 기간 동안 상품후기를 완성하면 마일리지가 2배로!" /></h2>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81360/txt_mileage.png" alt="상품후기를 쓰면 200마일리지, 첫 상품후기를 쓰면 400마일리지 적립" /></p>
							<!-- 예상 마일리지 확인하기 -->
							<div class="my-mileage">
								<% If IsUserLoginOK Then %>
								<h3><strong><%= vUserID %></strong><img src="http://webimage.10x10.co.kr/eventIMG/2017/81360/txt_get_mileage.png" alt="고객님의 예상 마일리지는?" /></h3>
								<% Else %>
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81360/txt_check_mileage.png" alt="나의 예상 적립 마일리지를 확인하세요!" /></h3>
								<% End If %>
								<div class="overHidden">
									<ul>
										<li class="m01">
											<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/81360/txt_number_1.png" alt="작성 가능한 후기 개수" /></span>
											<strong><% If IsUserLoginOK Then %><%=vMileArr(0,0)%><% End if %></strong>
										</li>
										<li class="m02">
											<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/81360/txt_mileage_1.png" alt="예상 마일리지" /></span>
											<strong><% If IsUserLoginOK Then %><%=FormatNumber(vMileArr(1,0),0)%><% End if %></strong>
										</li>
									</ul>
									<div class="btn-group">
										<% If IsUserLoginOK Then %>
										<a href="/my10x10/goodsusing.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81360/btn_review.png" alt="상품후기쓰고 더블 마일리지 받기" /></a>
										<% Else %>
										<a href="" onclick="jsSubmitlogin(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81360/btn_login.png" alt="로그인하기" /></a>
										<% End If %>
									</div>
								</div>
							</div>
							<!--// 예상 마일리지 확인하기 -->
							<div class="noti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81360/tit_noti.png" alt="이벤트 유의사항" /></h3>
								<ul>
									<li>- 이벤트 기간 내에 새롭게 작성하신 상품후기에 한해서만 더블 마일리지가 적용됩니다.</li>
									<li>- 기존에 작성했던 상품후기 수정은 적용되지 않습니다.</li>
									<li>- 상품후기가 삭제된 경우에는 마일리지 지급이 되지 않습니다.</li>
									<li>- 상품후기는 배송정보 [출고완료] 이후부터 작성하실 수 있습니다.</li>
									<li>- 상품과 관련 없는 내용이나 이미지를 올리거나, 직접 찍은 사진이 아닐 경우 삭제 및 마일리지 지급이 취소될 수 있습니다.</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->