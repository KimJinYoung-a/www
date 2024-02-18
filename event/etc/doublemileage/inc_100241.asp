<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  더블마일리지
' History : 2020-01-21 이종화 생성
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
	If Now() > #02/05/2020 00:00:00# AND Now() < #02/09/2020 23:59:59# Then
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
.double-mileage {position:relative; background:#b245eb;}
.my-mileage {position:absolute; top:1123px; left:0; right:0; margin:auto; width:910px; padding-top:63px;}
.my-mileage h3 {height:18px;}
.my-mileage .user-id {display:inline-block; position:relative; top:-2px; padding:0 3px; margin-right:10px; line-height:18px; font-size:15px; color:#393939; font-weight:600; border-bottom:1px solid #686868;}
.my-mileage .overHidden {width:760px; margin:0 auto; padding-top:50px;}
.my-mileage ul {float:left;}
.my-mileage ul li {position:relative; overflow:hidden; width:293px;}
.my-mileage ul li + li {margin-top:14px;}
.my-mileage ul li .tit {position:absolute; font-size:0; color:transparent;}
.my-mileage ul li .num {display:block; height:36px; line-height:38px; font-size:21px; font-weight:700; text-align:right; cursor:default;}
.my-mileage ul li.m01 .num {color:#686868}
.my-mileage ul li.m02 .num {color:#f6424a;}
.my-mileage .btn-group {float:right; width:342px;}
</style>
<script type="text/javascript">
function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}
</script>
<div class="evt100241 double-mileage">
    <h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/100241/tit_mileage.jpg" alt="더블 마일리지"></h2>
    <p><img src="//webimage.10x10.co.kr/fixevent/event/2020/100241/txt_mileage.jpg" alt="후기를 쓰면"></p>
    <p><img src="//webimage.10x10.co.kr/fixevent/event/2020/100241/bg_mileage.jpg" alt=""></p>
    <div class="my-mileage">
        <% If IsUserLoginOK Then %>
		<h3><span class="user-id"><%= vUserID %></span><img src="//webimage.10x10.co.kr/fixevent/event/2020/100241/txt_get.png" alt="고객님이 지금 후기를 쓰시면 얻게 될 혜택은"></h3>
		<% Else %>
		<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/100241/txt_check.png" alt="나의 예상 적립 마일리지를 확인하세요"></h3>
		<% End If %>
        <div class="overHidden">
            <ul>
				<li class="m01">
					<strong class="tit">작성 가능한 후기 개수</strong>
                    <span class="num"><% If IsUserLoginOK Then %><%=vMileArr(0,0)%><% End if %></span>
				</li>
				<li class="m02">
					<strong class="tit">예상 마일리지</strong>
                    <span class="num"><% If IsUserLoginOK Then %><%=FormatNumber(vMileArr(1,0),0)%><% End if %></span>
				</li>
			</ul>

            <div class="btn-group">
                <% If IsUserLoginOK Then %>
				<a href="/my10x10/goodsusing.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2020/100241/btn_review.png" alt="상품 후기 쓰러 가기"></a>
				<% Else %>
                <a href="" onclick="jsSubmitlogin(); return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2020/100241/btn_login.png" alt="로그인 하기"></a>
				<% End If %>
            </div>
        </div>
    </div>
    <p><img src="//webimage.10x10.co.kr/fixevent/event/2020/100241/txt_noti.jpg" alt="이벤트 유의사항"></p>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->