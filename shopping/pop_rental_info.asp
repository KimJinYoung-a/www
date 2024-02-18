<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 상품상세 - 렌탈상품 안내 팝업
' History : 2020-11-02 원승현
'####################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 렌탈 상품 안내"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/content.css">
</head>
<body>
	<div class="pop-rental-wrap">
		<div class="title"><img src="http://fiximage.10x10.co.kr/web2020/common/img_tit_rental.jpg?v=2" alt="tenbyten x KG이니시스 빌린 다음 갚자..갖자! 이니렌탈"></div>
		<div class="step-area">
			<div>
				<p>STEP 1</p>
				<p class="sub-txt">사고싶은 상품이 이니렌탈을<br/>지원하는지 확인하기</p>
			</div>
			<div>
				<p>STEP 2</p>
				<p class="sub-txt">12개월부터 최대 60개월까지<br/>렌탈/납부 기간을 선택한 뒤 결제하기</p>
                <p class="txt-noti">( 48개월은 101만원 이상 결제 시 선택 가능 )</p>
			</div>
			<div>
				<p>STEP 3</p>
				<p class="sub-txt">약정한 기간동안 월 납부 금액을<br/>완납하면 상품의 소유권은 내게로!</p>
			</div>
		</div>
		<div class="notice-area">
			<div class="tel">
				<p>1800-1739</p>
				<p>서비스 문의 KG 이니시스 렌탈 고객센터</p>
			</div>
			<div class="notice">
				<ul>
					<li>렌탈료 완납 시 소유권은 구매자에게 이전됩니다</li>
					<li>선택하신 약정 기간에 따라 렌탈료가 가감됩니다</li>
                    <li>프로모션 및 기타 조건에 의해 렌탈 약정 기간이 상품별로<br/>상이할 수 있습니다.</li>
					<li>렌탈에 관련된 문의(약정기간, 중도납부 등)는 KG이니시스<br/> 렌탈 고객센터를 이용해주세요</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->