<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	strPageTitle = "텐바이텐 10X10 : 기프티콘 교환하기"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_infomation_v1.jpg"
	strPageDesc = "선물 받은 기프티콘을 사용해보세요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 기프티콘 교환하기"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/gift/gifticon/"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf

	Dim vCouponNO
	vCouponNO = requestCheckVar(request("pin_no"),12)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
<script>
function checkchk()
{
    if(document.frm1.pin_no.value == "")
    {
		alert("인증번호를 입력하세요!");
		document.frm1.pin_no.focus();
		return false;
    }
    
    var chr1;
    for (var i=0; i<document.frm1.pin_no.value.length; i++){
        chr1 = document.frm1.pin_no.value.charAt(i);
        if(!(chr1 >= '0' && chr1 <= '9')) {
            alert("인증번호를 숫자만 입력하세요.");
            document.frm1.pin_no.value = "";
            document.frm1.pin_no.focus();
            return false;
        }
    }
    return true;
}

function goNext()
{
    if (!checkchk()){
        return;
    }

	<% If IsUserLoginOK() = True Then %>
	document.frm1.tmp.value = "o";
	<% End If %>
	document.frm1.submit();
}

function goNoUserID()
{
    if (!checkchk()){
        return;
    }
    
    popNonmember();
}

function goNoUserIDsendfrm()
{
    if (!checkchk()){
        return;
    }
    
    document.frm1.tmp.value = "o";
    document.frm1.submit();
}

function popNonmember() {
	var popNM = window.open("pop_nonmember.asp","popNonMem","width=500,height=640");
	popNM.focus();
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
	<form name="frm1" method="post" action="iframe_chkeck.asp" target="iframechk" style="margin:0px;">
	<input type="hidden" name="tmp" value="x">
		<div id="contentWrap">
			<div class="gifticonCardWrap">
				<h2>
					<img src="http://fiximage.10x10.co.kr/web2013/cart/tit_gifticon_change.gif" alt="기프티콘 교환하기" />
					<span class="fn fs11 cr777 lPad10">휴대폰으로 받으신 <strong>기프티콘 인증번호</strong>를 입력해주세요.</span>
				</h2>
				<div class="box1 tMar10 gifticonWrap">
					<div class="ct box5 pad15 tMar30">
						<dl class="overHidden pad15">
							<dt class="ftLt tPad10 rt fs11" style="width:90px;"><strong>인증번호</strong></dt>
							<dd class="ftLt lPad20"><input type="text" name="pin_no" value="<%=vCouponNO%>" maxlength="12" class="txtInp" style="width:330px" /></dd>
						</dl>
					</div>

					<p class="ct tPad20">
					<% If IsUserLoginOK() = False Then %>
						<a href="javascript:goNext();" class="btn btnM2 btnRed btnW100">등록</a>
						<a href="javascript:goNoUserID();" class="lMar10 btn btnM2 btnGry btnW100">비회원 등록</a>
					<% Else %>
						<a href="javascript:goNext();" class="btn btnM2 btnRed btnW100">등록</a>
					<% End If %>
					</p>
					
					<% If IsUserLoginOK() = False Then %>
					<p class="tPad20 ct fs11 cr888 lh19">
						- 비회원일 경우 정보수집동의를 하셔야 합니다.<br />
						- Gift 카드 사용 및 등록을 위해서는 <a href="#loginLyr" name="modal"><strong class="cr777">[로그인]</strong></a>이 필요 합니다.
						<span class="addInfo" onClick="location.href='/member/join.asp';" style="cursor:pointer;"><em>회원가입 하러가기</em></span>
					</p>
					<% End If %>

					<div class="note01 tMar55 tPad20 tBdr2 lPad20">
						<ul class="list01">
							<li>기프티콘은 상품교환권과 Gift 카드 교환권 2가지로 구분됩니다.</li>
							<li>Gift 카드 기프티콘을 사용하시려면 텐바이텐 로그인이 필요합니다.</li>
							<li>옵션이 있는 상품의 경우 텐바이텐에서 기프티콘을 상품으로 교환할 때 원하시는 옵션을 선택해주셔야 합니다.</li>
							<li>기프티콘으로 받은 상품이 품절일 경우 동일 금액의 텐바이텐 예치금(텐바이텐 온라인 및 모바일에서 사용가능)으로 교환해드립니다.</li>
							<li>기프티콘을 텐바이텐의 상품으로 교환하시는 경우 단독구매만 가능하시며 텐바이텐의 다른 상품들과 같이 구매 및 결제할 수 없습니다.</li>
							<li>기프티콘을 텐바이텐 상품 또는 텐바이텐 Gift 카드로 교환한 경우, 취소 및 반품이 불가합니다.</li>
							<li>기프티콘 이용 시 할인 및 기타 제휴 할인 및 마일리지 적립 불가합니다.</li>
							<li>인증번호 오류 시 기프티콘 고객센터로 문의 바랍니다.</li>
						</ul>
					</div>
				</div>
				<p class="rt pad15 bBdr2"><img src="http://fiximage.10x10.co.kr/web2013/cart/txt_gifticon_cscenter.gif" alt="기프티콘 고객센터" /></p>
			</div>
		</div>
	</form>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<iframe name="iframechk" src="" width="0" height="0"></iframe>
</body>
</html>