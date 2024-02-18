<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
'#######################################################
'	History	:  2014.10.22 허진원 생성
'			   2022.11.14 한용민 수정(회원 체크해서 상황에 맞게 분기 시키는 로직 추가)
'	Description : 메일링 서비스 수신거부 간소화 페이지
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/base64_u.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<%
'// 이전페이지 내용 접수
Dim vRef, vMail, vEncMail
dim rdsite, utm_source, utm_medium, utm_campaign
	vRef = request.ServerVariables("HTTP_REFERER")
	vEncMail = requestcheckvar(request("vEncMail"),256)
	rdsite = requestcheckvar(request("rdsite"),32)
	utm_source = requestcheckvar(request("utm_source"),32)
	utm_medium = requestcheckvar(request("utm_medium"),32)
	utm_campaign = requestcheckvar(request("utm_campaign"),13)

if InStr(vRef,"10x10.co.kr")<1 then
	Response.redirect("/member/mailzine/reject_mailzineLogin.asp?M_ID="&vEncMail&"&rdsite="&rdsite&"&utm_source="&utm_source&"&utm_medium="&utm_medium&"&utm_campaign="&utm_campaign&"")
	dbget.Close: response.end
end if
if vEncMail="" then
	Response.redirect("/member/mailzine/reject_mailzineLogin.asp?M_ID="&vEncMail&"&rdsite="&rdsite&"&utm_source="&utm_source&"&utm_medium="&utm_medium&"&utm_campaign="&utm_campaign&"")
	dbget.Close: response.end
end if
if len(vEncMail)<6 then
	Response.redirect("/member/mailzine/reject_mailzineLogin.asp?M_ID="&vEncMail&"&rdsite="&rdsite&"&utm_source="&utm_source&"&utm_medium="&utm_medium&"&utm_campaign="&utm_campaign&"")
	dbget.Close: response.end
end if

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
$(function(){
	var currentPosition = parseInt($(".mailzineContV15 .prev").css("top"));
	$(window).scroll(function() {
		var position = $(window).scrollTop();
		windowCenterH = parseInt($(window).height()/2);
			$(".mailzineContV15 .prev, .mailzineContV15 .next").stop().animate({"top":position+currentPosition+"px"},400);
		if(position+currentPosition > document.body.scrollHeight-900){
			$(".mailzineContV15 .prev, .mailzineContV15 .next").stop().animate({"top":document.body.scrollHeight-900+"px"},400);
		}
	});
});

function fnRejectRequestEmailOk() {
	$.ajax({
		url: "/member/mailzine/reject_mailzine_proc.asp?vEncMail=<%=vEncMail%>&mode=RequestEmailOk&rdsite=<%=rdsite%>&utm_source=<%=utm_source%>&utm_medium=<%=utm_medium%>&utm_campaign=<%=utm_campaign%>",
		cache: false,
		success: function(message) {
			switch(message) {
				case "E01" :
					location.replace("/member/mailzine/reject_mailzineLogin.asp?vEncMail=<%=vEncMail%>&rdsite=<%=rdsite%>&utm_source=<%=utm_source%>&utm_medium=<%=utm_medium%>&utm_campaign=<%=utm_campaign%>")
					break;
				case "E02" :
					location.replace("/member/mailzine/reject_mailzineLogin.asp?vEncMail=<%=vEncMail%>&rdsite=<%=rdsite%>&utm_source=<%=utm_source%>&utm_medium=<%=utm_medium%>&utm_campaign=<%=utm_campaign%>")
					break;
				case "E03" :
					location.replace("/member/mailzine/reject_mailzineLogin.asp?vEncMail=<%=vEncMail%>&rdsite=<%=rdsite%>&utm_source=<%=utm_source%>&utm_medium=<%=utm_medium%>&utm_campaign=<%=utm_campaign%>")
					break;
				case "E04" :
					location.replace("/member/mailzine/reject_mailzineLogin.asp?vEncMail=<%=vEncMail%>&rdsite=<%=rdsite%>&utm_source=<%=utm_source%>&utm_medium=<%=utm_medium%>&utm_campaign=<%=utm_campaign%>")
					break;
				case "E06" :
					alert("이미 이메일 수신 동의가 되어 있습니다. 감사합니다.");
					break;
				case "E99" :
					alert("정상적인 경로가 아닙니다.");
					break;
				case "OK" :
					alert("텐바이텐 이메일 수신 동의가 완료되었습니다.\n다양한 쇼핑 소식을 빠르게 전달해 드릴게요 :)");
                    window.close();
					break;
			}
		}
		,error: function(err) {
			//alert(err.responseText);
		}
	});
}

</script>
<style>
	@charset "utf-8";
:root {
	--ten:#ff214f;
	--aqua:#00c4be;
	--lime:#d1ff59;
	--pink:#ffa6b8;
	--white:#fff;
	--grey:#f5f6f7;
	--c_111:#111;
	--c_666:#666;
	--c_999:#999;
	--c_ccc:#ccc;
	--c_eee:#eee;
	--dim90:rgba(0,0,0,.9);
	--dim80:rgba(0,0,0,.8);
	--dim20:rgba(0,0,0,.2);
	--rg:'CoreSansCLight', 'AppleSDGothicNeo-Regular', 'NotoSansKRLight', sans-serif;
	--md:'CoreSansCRegular', 'AppleSDGothicNeo-Medium', 'NotoSansKRRegular';
	--sb:'CoreSansCMedium', 'AppleSDGothicNeo-SemiBold', 'NotoSansKRMedium';
	--bd:'CoreSansCBold', 'AppleSDGothicNeo-Bold', 'NotoSansKRBold';
}
/************************* FONT *************************/
/* Core Sans C
https://www.myfonts.com/fonts/s-core/core-sans-c */
@font-face {
    font-family:'CoreSansCLight';
    font-style:normal;
    src:local('Core Sans C 35 Light'), url('//fiximage.10x10.co.kr/webfont/CoreSansC35Light.woff') format('woff'),url('//fiximage.10x10.co.kr/webfont/CoreSansC35Light.ttf') format('truetype');
}
@font-face {
    font-family:'CoreSansCRegular';
    font-style:normal;
    src:local('Core Sans C 45 Regular'), url('//fiximage.10x10.co.kr/webfont/CoreSansC45Regular.woff') format('woff'),url('//fiximage.10x10.co.kr/webfont/CoreSansC45Regular.ttf') format('truetype');
}
@font-face {
    font-family:'CoreSansCMedium';
    font-style:normal;
    src:local('Core Sans C 55 Medium'), url('//fiximage.10x10.co.kr/webfont/CoreSansC55Medium.woff') format('woff'),url('//fiximage.10x10.co.kr/webfont/CoreSansC55Medium.ttf') format('truetype');
}
@font-face {
    font-family:'CoreSansCBold';
    font-style:normal;
    src:local('Core Sans C 65 Bold'), url('//fiximage.10x10.co.kr/webfont/CoreSansC65Bold.woff') format('woff'),url('//fiximage.10x10.co.kr/webfont/CoreSansC65Bold.ttf') format('truetype');
}

/* Noto Sans KR */
@font-face{
    font-family:'NotoSansKRLight';
    font-style:normal;
    src:local('Noto Sans Light'), local('NotoSans-Light'), url("//fiximage.10x10.co.kr/webfont/NotoSansKR-Light.woff") format('woff'), url('//fiximage.10x10.co.kr/webfont/NotoSansKR-Light.ttf') format('truetype');
}
@font-face{
    font-family:'NotoSansKRRegular';
    font-style:normal;
    src:local('Noto Sans Regular'), local('NotoSans-Regular'), url("//fiximage.10x10.co.kr/webfont/NotoSansKR-Regular.woff") format('woff'), url('//fiximage.10x10.co.kr/webfont/NotoSansKR-Regular.ttf') format('truetype');
}
@font-face{
    font-family:'NotoSansKRMedium'; 
    font-style:normal;
    src:local('Noto Sans Medium'), local('NotoSans-Medium'), url("//fiximage.10x10.co.kr/webfont/NotoSansKR-Medium.woff") format('woff'), url('//fiximage.10x10.co.kr/webfont/NotoSansKR-Medium.ttf') format('truetype');
}
@font-face{
    font-family:'NotoSansKRBold'; 
    font-style:normal;
    src:local('Noto Sans Bold'), local('NotoSans-Bold'), url("//fiximage.10x10.co.kr/webfont/NotoSansKR-Bold.woff") format('woff'), url('//fiximage.10x10.co.kr/webfont/NotoSansKR-Bold.ttf') format('truetype');
}

#contentWrap {background:#F4F5F6;}
.mailReject a:hover{text-decoration: none;}
.mailReject .btn_ten{font-size:16px;line-height:19.2px;font-family:var(--bd);color:#FF214F;padding:8px 16px;border:1px solid #FF214F;border-radius: 50px;}
.mailReject .main_copy{font-size:24px;line-height:28.8px;text-align:center;font-family:var(--sb);margin-bottom:8px;color:#000;}
.mailReject .sub_copy{font-size:18px;line-height:23.6px;text-align:center;color:#666;font-family:var(--rg);margin-bottom:30px;}
.mailReject .btnArea{margin-bottom:196px;}
.mailReject .img img{width:100%;}

.mailReject .case01 .img{width:120px;height:114px;margin:90px auto 32px;}
.mailReject .case02 .img,.mailReject .case03 .img,.mailReject .case04 .img{width:89px;height:104px;margin:90px auto 32px;}
.mailReject .case04 .sub_copy span{font-family:var(--sb);}
.mailReject .case04 .sub_copy i img{width:12px;height:12px;padding-top:3.5px;}
@media screen and (min-device-width:320px) and (max-device-width:480px)  {
	.mailReject .main_copy {font-size:1.71rem;}
	.mailReject .sub_copy {display:inline-block; font-size:1.11rem;}
}
</style>
</head>
<body>
<div id="mailzineV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap">
			<div id="lyrForm" class="mailReject">
				<div class="case02">
					<p class="img"><img src="http://fiximage.10x10.co.kr/web2022/common/mail_reject.png" alt="종이비행기 이미지"></p>
					<p class="main_copy">수신 거부가 완료되었어요.</p>
					<p class="sub_copy">우리 다시 만날 수 있겠죠?<br/>즐거운 쇼핑 소식과 혜택을 가득 들고 기다릴게요 👋</p>
					<div class="btnArea">
						<a href="#" onclick="fnRejectRequestEmailOk(); return false;" class="btn_ten">다시 받아볼게요</a>
					</div>
				</div>
			</div>
		</div>
	</div>

    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->