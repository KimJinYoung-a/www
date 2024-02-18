<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
<style type="text/css">
	.kakaoSvc {width:960px;}
	.kakaoSvc * {padding:0; margin:0; border:0; line-height:100%; font-size:12px;}
	.kakaoSvc img {vertical-align:top; display:inline;}
	.kakaoSvc .ct {text-align:center;}
	.kakaoSvc .ftLt {float:left;}
	.kakaoSvc .ftRt {float:right;}
</style>
<div class="kakaoSvc">
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2012/35583/w_01.jpg" border="0" usemap="#kakaoMap" /></p>
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2012/35583/w_02.jpg"></p>
	<map name="kakaoMap" id="kakaoMap">
		<area shape="circle" coords="829,1489,70" href="/my10x10/userinfo/membermodify.asp" />
	</map>
</div>
<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->