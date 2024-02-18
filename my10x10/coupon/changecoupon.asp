<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 상품권 및 보너스 쿠폰 발급받기"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim uid
uid = getEncLoginUserID

if uid="" then
	response.write "<script>alert('로그인 후 사용하실 수 있습니다.');</script>"
	response.write "<script>window.close();</script>"
	response.end
end if

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>

function nextfocus(txt1,txt2) {
	var t_len = eval("multifrm."+txt1+".value.length");
	if (t_len == 4 )
	{
		eval("multifrm."+txt2+".focus()");
	}
}

function MakeCoupon(frm){
	if (frm.cardno1.value.length<4){
		alert('상품권 번호를 정확히 입력하세요..');
		frm.cardno1.focus();
		return;
	}

	if (frm.cardno2.value.length<4){
		alert('상품권 번호를 정확히 입력하세요..');
		frm.cardno2.focus();
		return;
	}

	if (frm.cardno3.value.length<4){
		alert('상품권 번호를 정확히 입력하세요..');
		frm.cardno3.focus();
		return;
	}

	if (frm.cardno4.value.length<4){
		alert('상품권 번호를 정확히 입력하세요..');
		frm.cardno4.focus();
		return;
	}

	var ret = confirm('쿠폰을 발급 받으시겠습니까?');
	if (ret){
		frm.submit();
	}
}

function IsDigit(v){
	for (var j=0; j < v.length; j++){
		if ((v.charAt(j) * 0 == 0) == false){
			return false;
		}
	}
	return true;
}

</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_coupon_issue.gif" alt="상품권 및 보너스 쿠폰 발급받기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="multifrm" method="post" action="actchangecoupon.asp">
				<div class="mySection">
					<div class="couponIssue">
						<h2>텐바이텐 상품권 및 보너스쿠폰 번호를 입력하세요.</h2>
						<fieldset>
							<legend>상품권 및 보너스쿠폰 번호 입력</legend>
							<div class="ct">
								<input type="text" name="cardno1" title="쿠폰번호 첫번째자리 네자리 입력" class="txtInp focusOn" style="width:58px;" maxlength=4 OnKeyUp="nextfocus('cardno1','cardno2')" />
								<span class="symbol">-</span>
								<input type="text" name="cardno2" title="쿠폰번호 두번째자리 네자리 입력" class="txtInp focusOn" style="width:58px;" maxlength=4 OnKeyUp="nextfocus('cardno2','cardno3')" />
								<span class="symbol">-</span>
								<input type="text" name="cardno3" title="쿠폰번호 세번째자리 네자리 입력" class="txtInp focusOn" style="width:58px;" maxlength=4 OnKeyUp="nextfocus('cardno3','cardno4')" />
								<span class="symbol">-</span>
								<input type="text" name="cardno4" title="쿠폰번호 네번째자리 네자리 입력" class="txtInp focusOn" style="width:58px;" />
							</div>
							<ul class="list">
								<li>텐바이텐 회원이어야 발급받을 수 있습니다.</li>
								<li>상품권 및 쿠폰은 유효기간이 있으며, 온라인 쇼핑몰에서만 사용 가능합니다.</li>
								<li>쿠폰 사용시 최소구매금액이 있으며, 상품권은 1인 1매만 사용 가능합니다.</li>
								<li>일부 상품은 사용에 제한이 있을 수 있습니다.</li>
							</ul>

							<div class="btnArea ct tPad20">
								<input type="button" class="btn btnS1 btnRed btnW100" value="발급받기" onClick="MakeCoupon(multifrm);" />
							</div>
						</fieldset>
					</div>
				</div>
				</form>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
