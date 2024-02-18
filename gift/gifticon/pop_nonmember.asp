<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
strPageTitle = "텐바이텐 10X10 : 기프티콘"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<script language="javascript">
<!--
	function chkAgreement() {
		var fag = document.frm.chkAgree;
		if(!(fag[0].checked||fag[1].checked)) {
			alert("비회원 정보수집 동의사항을 선택해주세요.")
		}
		if(fag[1].checked) {
			self.close();
		} else if(fag[0].checked) {
			opener.goNoUserIDsendfrm();
			self.close();
		}
	}
//-->
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/inipay/tit_nonmember_agree.gif" alt="비회원 정보 수집 동의" /></h1>
			</div>
			<div class="popContent">
			<form name="frm" style="margin:0px;">
				<!-- content -->
				<div class="mySection">
					<p class="ct fs12"><strong>비회원이신 경우, 다음 개인정보 수집 항목을 확인 후 동의하셔야합니다.</strong></p>
					<div class="nonMemAgree">
						<ol>
							<li>1. 수집하는 개인정보 항목<br />- e-mail, 전화번호, 성명, 주소, 은행계좌번호</li>
							<li>
								2. 수집목적
								<ol>
									<li>① e-mail, 전화번호: 고지의 전달. 불만처리나 주문/배송정보 안내 등 원활한 의사소통 경로의 확보.</li>
									<li>② 성명, 주소: 고지의 전달, 청구서, 정확한 상품 배송지의 확보.</li>
									<li>③ 은행계좌번호: 구매상품에 대한 환불시 확보.</li>
								</ol>
							</li>
							<li>
								3. 개인정보 보유기간
								<ol>
									<li>① 계약 또는 청약철회 등에 관한 기록 : 5년</li>
									<li>② 대금결제 및 재화 등의 공급에 관한 기록 : 5년</li>
									<li>③ 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년</li>
								</ol>
							</li>
							<li>4. 비회원 주문 시 제공하신 모든 정보는 상기 목적에 필요한 용도 이외로는 사용되지 않습니다. 기타 자세한 사항은 '개인정보취급방침'을 참고하여주시기 바랍니다. 
							</li>
						</ol>
					</div>
					<p class="ct">
						위 내용에 동의 하십니까? 
						<span class="lPad20">
							<input type="radio" class="radio" name="chkAgree" id="chkAgree" value="Y" />
							<label for="agreeY" /><strong>동의함</strong></label>
						</span>
						<span class="lPad20">
							<input type="radio" class="radio" name="chkAgree" id="chkAgree" value="N" />
							<label for="agreeN" /><strong>동의안함</strong></label>
						</span>
					</p>
					<p class="ct tPad20">
						<a href="javascript:chkAgreement();" class="btn btnM2 btnRed btnW150">비회원 등록하기</a>
					</p>
				</div>
				<!-- //content -->
			</form>
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>