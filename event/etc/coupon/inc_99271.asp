<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2019 브랜드쿠폰 - 달콤한 향으로 기억될 12월
' History : 2019-12-10 이종화
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, getbonuscoupon1

IF application("Svr_Info") = "Dev" THEN
	eCode = 90443
	getbonuscoupon1 = 2943
Else
	eCode = 99271
	getbonuscoupon1 = 1262	
End If

userid = getencloginuserid()

%>
<style>
.evt99271 {position: relative; width: 100%; height: 2112px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/99271/tit.jpg) #6d1111 center 0 ;}
.evt99271 area {outline: none;}
.img-bg {position: relative; display: block; left: 50%; width: 1920px; margin-left: -960px;}
.coupon {position: absolute; top: 630px; left: 50%; margin-left: 180px;}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
    <% If IsUserLoginOK() Then %>
        fnAmplitudeEventMultiPropertiesAction('click_couponevent','eventcode|platform','99271|PCWEB');
		<% If not(now() >= #12/10/2019 00:00:00# And now() < #12/31/2019 23:59:59#) then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.\n12월 31일까지 사용하세요 :)');
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
				alert('오류가 발생했습니다.');
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
<div class="evt99271">
    <span class="img-bg"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99271/tit.jpg" alt="달콤한 향으로 기억될 12월" usemap="#Map"></span>
    <map name="Map" id="Map">
        <area shape="rect" coords="490,940,1395,1025" href="#mapGroup308726"/>
        <area shape="rect" coords="610,1050,1320,1390" href="/shopping/category_prd.asp?itemid=2593945&pEtr=99271" />
        <area shape="rect" coords="490,1405,1395,1490" href="#mapGroup308727"/>
        <area shape="rect" coords="610,1510,1320,1845" href="/shopping/category_prd.asp?itemid=2599688&pEtr=99271" />
    </map>
    <a href="" onclick="jsevtDownCoupon('evtsel','<%= getbonuscoupon1 %>'); return false;" class="coupon"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99271/img_coupon.png" alt="쿠폰 다운받기"></a>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->