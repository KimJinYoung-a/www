<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  더블마일리지
' History : 2018-08-27 최종원 
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
	
	If Now() > #08/29/2018 00:00:00# AND Now() < #09/04/2018 23:59:59# Then
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
.double-mileage {position:relative; background:#005cba;}
.my-mileage {width:1052px; margin:0 auto; padding:60px 0 70px; background-color:#fff; border-radius:20px;}
.my-mileage h3 strong {margin-right:7px; color:#686868; font:normal 17px/18px arial; border-bottom:1px solid #686868;}
.my-mileage .overHidden {width:760px; margin:0 auto; padding-top:40px;}
.my-mileage ul {float:left; padding-right:43px; text-align:left; border-right:1px dashed #bfbfbf;}
.my-mileage li {overflow:hidden; width:335px; padding:7px 0;}
.my-mileage li span {float:left;}
.my-mileage li strong {display:inline-block; float:right; width:113px; height:34px; padding-right:43px; text-align:right; font:normal 20px/34px verdana; letter-spacing:-0.05rem;}
.my-mileage li.m01 strong {color:#686868; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88837/txt_number_2.png);}
.my-mileage li.m02 strong {color:#f36df8; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88837/txt_mileage_2.png);}
.my-mileage .btn-group {float:right; width:326px;}
.noti {position:relative; padding:45px 0 45px 322px; margin-top:36px; background:#353535;}
.noti h3 {position:absolute; left:139px; top:50%; margin-top:-38px;}
.noti ul {padding-left:64px; border-left:1px solid #6d6d6d;}
.noti li {color:#fff; font-size:11px; line-height:23px; text-align:left;}
</style>
<script type="text/javascript">

function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}
</script>
<!-- 더블 마일리지 -->
						<div class="evt88837 double-mileage">
							<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88837/tit_double_mileage.png" alt="일주일간 진행되는 X2 마일리지 - 지금 상품후기 완성하면 마일리지 2배 적립!" /></h2>
							<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88837/txt_mileage.png" alt="상품후기를 쓰면 200마일리지, 포토후기 작성시 추가 200마일리지 포함 400마일리지 지급" /></p>
							<!-- 예상 마일리지 확인하기 -->
							<div class="my-mileage">
							<% If IsUserLoginOK Then %>								
								<h3><strong><%= vUserID %></strong><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88837/txt_get_mileage.png" alt="고객님이 지금 후기를 쓰시면 얻게 될 혜택은?" /></h3>
							<% Else %>								
								<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88837/txt_check_mileage.png" alt="나의 예상 적립 마일리지를 확인하세요!" /></h3>
							<% End If %>								
								<div class="overHidden">
									<ul>
										<li class="m01">
											<span><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88837/txt_number_1.png" alt="작성 가능한 후기 개수" /></span>
											<strong><% If IsUserLoginOK Then %><%=vMileArr(0,0)%><% End if %></strong>
										</li>
										<li class="m02">
											<span><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88837/txt_mileage_1.png" alt="예상 마일리지" /></span>
											<strong><% If IsUserLoginOK Then %><%=FormatNumber(vMileArr(1,0),0)%><% End if %></strong>
										</li>
									</ul>
									<div class="btn-group">
									<% If IsUserLoginOK Then %>
										<a href="/my10x10/goodsusing.asp"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88837/btn_review.png" alt="상품후기쓰러가기" /></a>
									<% Else %>	
										<a href="/login/loginpage.asp"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88837/btn_login.png" alt="로그인하기" /></a>										
									<% End If %>	
									</div>
								</div>
							</div>
							<!--// 예상 마일리지 확인하기 -->
							<div class="noti">
								<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88837/tit_noti.png" alt="이벤트 유의사항" /></h3>
								<ul>
									<li>- 이벤트 기간 내에 새롭게 작성하신 상품 후기에 한해서만 더블 마일리지가 적용됩니다.</li>
									<li>- 기존에 작성했던 상품후기 수정은 적용되지 않습니다.</li>
									<li style="color:#feff83;">- 상품 후기 및 포토후기가 작성된 이후에 삭제된 경우에는 마일리지 지급이 되지 않습니다.</li>
									<li>- 상품 후기는 배송정보 [출고완료] 이후부터 작성 하실 수 있습니다.</li>
									<li>- 상품과 관련 없는 내용이나 이미지를 올리거나, 직접 찍은 사진이 아닐 경우 삭제 및 마일리지 지급이 취소 될 수 있습니다.</li>
									<li>- 상품 후기 마일리지는 즉시 지급 됩니다.</li>
									<li>- 포토 후기의 추가지급 마일리지(200point)는 9월 10일(월) 일괄지급 될 예정입니다.</li>
								</ul>
							</div>
						</div>
						<!--// 더블 마일리지 -->						
<!-- #include virtual="/lib/db/dbclose.asp" -->