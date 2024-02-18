<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  텐텐 크리에이터
' History : 2018-12-12 이종화
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'// 쇼셜서비스로 글보내기 
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 텐텐 크리에이터를 찾습니다!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=91224")
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2018/91224/banMoList20181211164959.JPEG")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[텐바이텐] 텐텐 크리에이터를 찾습니다!"
strPageKeyword = "[텐바이텐] 텐텐 크리에이터를 찾습니다!"
strPageDesc = "총 200만원의 상금을 지원하는 텐텐 크리에이터에 도전하세요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=91224"
strPageImage = "http://webimage.10x10.co.kr/eventIMG/2018/91224/banMoList20181211164959.JPEG"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.evt91224 area {outline:0;}
.evt91224 .bnr-sns {position:relative;}
.evt91224 .bnr-sns a {position:absolute; width:53px; height:34px; top:33px; font-size:0; color:transparent;}
.evt91224 .bnr-sns .btn-fb {right:362px;}
.evt91224 .bnr-sns .btn-tw {right:304px;}
</style>
<script type="text/javascript">
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}
}
</script>
</head>
<div class="evt91224">
    <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91224/img_creator.jpg?v=1.01" alt="텐텐크리에이터를 찾습니다!" usemap="#img_creator.jpg"></p>
    <map name="img_creator.jpg">
        <area shape="rect" coords="490,860,685,900" href="mailto:your10x10@naver.com" target="_self" alt="your10x10@naver.com">
        <area shape="rect" coords="427,1546,712,1626" href="mailto:your10x10@naver.com" target="_self" alt="응모하기">
    </map>
    <div class="bnr-sns">
        <img src="http://webimage.10x10.co.kr/fixevent/event/2018/91224/bnr_sns.jpg" alt="텐텐 크리에이터 이벤트를 친구에게 공유해주세요!">
        <a href="" onclick="snschk('fb');return false;" title="페이스북 공유하기" class="btn-fb">facebook</a>
        <a href="" onclick="snschk('tw');return false;" title="트위터 공유하기" class="btn-tw">twitter</a>
    </div>
</div>
</html>