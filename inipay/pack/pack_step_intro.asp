<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'#######################################################
'	History	:  2015.11.09 한용민 생성
'	Description : 포장 서비스
'#######################################################
%>
<!-- #include virtual="/login/checkBaguniLogin.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->

<!-- #include virtual="/lib/inc/head_SSL.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<style type="text/css">html {overflow:hidden;}</style>
<script type="text/javascript">

function gostep1(){
	pojangfrm.action = "<%= SSLURL %>/inipay/pack/pack_step1.asp";
	pojangfrm.submit();
	return;
}

//마우스 오른쪽 클릭 막음		//2015.12.15 한용민 생성
window.document.oncontextmenu = new Function("return false");
//새창 띄우기 막음		//2015.12.15 한용민 생성
window.document.onkeydown = function(e){    	//Crtl + n 막음
    if(typeof(e) != "undefined"){
        if((e.ctrlKey) && (e.keyCode == 78)) return false;
    }else{
        if((event.ctrlKey) && (event.keyCode == 78)) return false;
    }
}
//드레그 막음		//2015.12.15 한용민 생성
window.document.ondragstart = new Function("return false");

</script>
</head>
<body>
<% '<!-- for dev msg : 팝업 창 사이즈 width=800, height=800 --> %>
<div class="heightgird">
	<div class="popWrap pkgProcessV15a">
		<div class="popContent introPkgWrap15a">
			<div class="introPkg15a">
				<p><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_intro_img.jpg" alt="" /></p>
				<h2><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_intro_tit.png" alt="텐바이텐 선물포장 서비스" /></h2>
				<div class="introInfoV15a">
					<ul class="introTxtV15a">
						<li>선물포장은 포장 1건당 <strong class="cRd0V15">2,000원</strong>의 비용이 책정되는 유료 서비스 입니다.</li>
						<li>상품의 특성에 따라 <strong class="cRd0V15">크기나 포장 재질이 변경</strong>될 수 있습니다.</li>
						<li>동일 상품을 개별 포장시 <strong class="cRd0V15">포장 재질은 하나로 통일</strong>됩니다.</li>
						<li>불가피한 사정으로 인해 포장 협의가 필요할 경우 <br />회원님께 <strong class="cRd0V15">직접 연락</strong>을 드린 후 선물포장을 진행합니다.</li>
					</ul>
					<span class="pkgStartBtnV15a"><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_intro_btn.png" onclick="gostep1(); return false;" alt="선물포장 시작하기" /></span>
				</div>
			</div>
		</div>
	</div>
</div>
<form name="pojangfrm" method="post" action="" style="margin:0px;">
<input type="hidden" name="mode">
</form>
</body>
</html>