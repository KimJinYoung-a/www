<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2013.09.05 - 허진원 생성
'	Description : e기프트카드 등록/내역 정보
'#######################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 텐바이텐 Gift카드 동록"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	dim userid: userid = getEncLoginUserID ''GetLoginUserID
%>
<script type="text/javascript">
function chkRegForm(frm) {
	if(!frm.agreement.checked) {
		alert("기프트카드 이용약관에 동의를 해주세요.");
		return false;
	}
	if(frm.masterCardCd1.value.length<4) {
		alert("기프트카드 번호를 정확히 입력해주세요.");
		frm.masterCardCd1.focus();
		return false;
	}
	if(frm.masterCardCd2.value.length<4) {
		alert("기프트카드 번호를 정확히 입력해주세요.");
		frm.masterCardCd2.focus();
		return false;
	}
	if(frm.masterCardCd3.value.length<4) {
		alert("기프트카드 번호를 정확히 입력해주세요.");
		frm.masterCardCd3.focus();
		return false;
	}
	if(frm.masterCardCd4.value.length<4) {
		alert("기프트카드 번호를 정확히 입력해주세요.");
		frm.masterCardCd4.focus();
		return false;
	}
	frm.masterCardCd.value = frm.masterCardCd1.value + frm.masterCardCd2.value + frm.masterCardCd3.value + frm.masterCardCd4.value;
}

function jsGoNextText(a){
	var b = parseInt(a) + 1;
	if($("#masterCardCd"+a+"").val().length > 3){
		$("#masterCardCd"+b+"").focus();
	}
}
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap skinBlue">
		<div id="contentWrap">
			<div class="myHeader">
				<h2><a href="/my10x10/"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_my10x10.png" alt="MY 10X10" /></a></h2>
				<div class="breadcrumb">
					<a href="/">HOME</a> &gt;
					<a href="/my10x10/">MY TENBYTEN</a> &gt;
					<a href="" onclick="return false;">MY 쇼핑활동</a> &gt;
					<strong>GIFT 카드</strong>
				</div>
			</div>
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<div class="myContent">
					<div class="giftcard giftcardV15a">
						<div class="subHeader">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_giftcard.png" alt="텐바이텐 기프트카드" /></h3>
							<p>무슨 선물을 할까 늘 고민인 당신, 간편한 기프트 카드로 마음을 전해보세요.</p>
							<div class="btnGroupV15a">
								<a href="<%=SSLUrl%>/giftcard/present.asp" class="btn btnS1 btnRed">선물하기</a>
								<a href="/giftcard/" class="btn btnS1 btnWhite">안내 및 유의사항</a>
							</div>
							<div class="ico"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/img_gift_card_visual.png" alt=""></div>
						</div>
						<ul class="tabMenu addArrow tabReview">
							<li><a href="/my10x10/giftcard/giftcardOrderlist.asp"><span>주문내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardUselist.asp"><span>사용내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegistlist.asp"><span>등록내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegist.asp" class="on"><span>카드등록</span></a></li>
						</ul>
						<div class="giftcardRegiFormV15a">
							<form name="frmReg" method="POST" action="do_giftcardReg.asp" target="iframeProc" onsubmit="return chkRegForm(this)" style="margin:0px;">
							<input type="hidden" name="masterCardCd" value="" />
								<fieldset>
								<legend>기프트카드 등록</legend>
									<p class="cBk0V15 fs12 fb ct">인증번호를 등록해주세요.</p>
									<div class="field">
										<input type="text" name="masterCardCd1" id="masterCardCd1" autocomplete="off" class="txtInp" onKeyUp="jsGoNextText('1');" maxlength="4" /> -
										<input type="text" name="masterCardCd2" id="masterCardCd2" autocomplete="off" class="txtInp" onKeyUp="jsGoNextText('2');" maxlength="4" /> -
										<input type="text" name="masterCardCd3" id="masterCardCd3" autocomplete="off" class="txtInp" onKeyUp="jsGoNextText('3');" maxlength="4" /> -
										<input type="text" name="masterCardCd4" id="masterCardCd4" autocomplete="off" class="txtInp" maxlength="4" />
									</div>
									<div class="giftCardGuide">
										<ul class="list">
											<li>기프트카드의 유효기간은 구매일로부터 5년입니다.</li>
											<li>인증번호 등록 후 기프트카드 금액을 현금처럼 사용할 수 있으며, 다른 결제 수단과 중복으로 사용 가능합니다.</li>
											<li>온라인 카드사용등록 전 기프트카드 메시지 또는 인증번호를 분실하신 경우 보내는 사람에게 재전송을 요청하실 수 있으며 재전송은 2회까지 가능합니다.</li>
										</ul>
									</div>
								</fieldset>

								<!-- policy -->
								<div class="giftcardPolicyV15a">
									<fieldset>
									<legend>텐바이텐 Gift카드 약관동의</legend>
										<div class="scrollbarwrap">
											<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
											<div class="viewport">
												<div class="overview">
													<!-- for dev msg : 텐바이텐 Gift카드 약관 -->
													<!-- #include virtual="/giftcard/policy.asp" -->
												</div>
											</div>
										</div>

										<p class="agree"><input type="checkbox" name="agreement" id="agreeYes" class="check" /> <label for="agreeYes">&apos;<b>이용약관</b>&apos;을 확인하였으며 이에 &apos;<b>동의</b>&apos;합니다.</label></p>
									</fieldset>
								</div>

								<div class="btnGroupV15a">
									<button type="submit" class="btn btnB1 btnRed">등록하기</button>
								</div>
							</form>
							<iframe src="about:blank" name="iframeProc" width="0" height="0" frameborder="0" ></iframe>
						</div>
					</div>

				</div>
				<!--// content -->
			</div>

		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	/* tiny scroll bar */
	$('.scrollbarwrap').tinyscrollbar();
});
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->