<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 해외배송안내"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_infomation_v1.jpg"
	strPageDesc = "지구 반대편에서도 텐바이텐 상품을 만나는 방법!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 해외배송안내"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/cscenter/oversea/emsIntro.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/ordercls/emscls.asp" -->
<%
''EMS 관련
Dim oems, i

SET oems = New CEms
oems.FRectCurrPage = 1
oems.FRectPageSize = 200
oems.FRectisUsing  = "Y"
oems.GetServiceAreaList
%>
<script type="text/javascript">
var pareacode="";
function emsBoxChange(comp) {
	if (!comp) {
		var nationCode = $("#emsCountry").val();
		if (nationCode) {
			var url = "http://ems.epost.go.kr:8080/front.EmsApplyGoCondition.postal?nation="+nationCode;
			window.open(url,'popEmsServiceArea','width=650,height=600,scrollbars=yes,resizable=yes');
		}
		else
			alert("국가를 선택하세요.");
		return;
	}

    if (comp.value==''){
		$("#divAreaCode").html("1");
		$("#divMaxWeight").html("");
		
    }else{
        
        var replaceAreaCode = $(comp).find("option:selected").attr("id").substr(0,2);
		var areacode = replaceAreaCode.replace("|","");

        $("#divAreaCode").html(areacode);
        $("#divMaxWeight").html((Number($(comp).find("option:selected").attr("id").substr(2,255)) / 1000) + " Kg");

		$.ajax({
			url: "emsWeightReponse.asp?areacode="+areacode,
			cache: false,
			success: function(message) {
				$("#iWeightList").empty().append(message);
				pareacode = areacode;
			}
			,error: function(err) {
				alert(err.responseText);
			}
		});
	}
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="csHeader">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_cs_center.gif" alt="고객행복센터" /></h2>
				<p><img src="http://fiximage.10x10.co.kr/web2013/cscenter/txt_cs_center.gif" alt="기분 좋은 쇼핑이 될 수 있도록 정성을 다하겠습니다." /></p>
			</div>

			<div class="csContent">
				<!-- #include virtual="/lib/inc/incCsLnb.asp" -->

				<!-- content -->
				<div class="content">
					<div class="emsDelivery">
						<div class="subHeader">
							<h3><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_ems.gif" alt="텐바이텐 해외배송" /></h3>
							<p>지구 반대편에서도 텐바이텐을 만나는 방법!<br /> 언제 어디서나! YOU'RE TENTENER!</p>
							<div class="ico"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_ems.gif" alt="" /></div>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_ems_define.gif" alt="텐바이텐 해외배송 서비스란?" /></h4>
							<div class="account">
								<p>해외에 거주하고 계시거나, 해외 친구나 친지들에게 선물을 보내고 싶으신 고객님들의 편의를 위해<br /> 해외배송 서비스(항공편 이용)를 운영하고 있습니다.</p>
								<p>해외배송을 대행해줄 곳은 국가기관인 우정사업본부이며 개인적으로 우체국을 통하여 해외배송 서비스를 받을 때<br />
								보다 편리하게 이용하실 수 있습니다. EMS(Express Mail Service)는 전세계 143개국(계속 확대 중)으로 배송하며<br />
								외국 우편당국과 체결한 특별협정에 따라 취급합니다.</p> 
								<!--
								<p>중화권 고객께서는 텐바이텐 중문사이트를 이용하시면 더 편리하게 쇼핑 하실 수 있습니다.<br />
									<strong class="rPad05">10x10 CHINA</strong>
									<a href="http://10x10shop.com" title="새창에서 열림" target="_blank" class="linkBtn highlight"><strong>http://10x10shop.com</strong></a>
								</p>
								-->
							</div>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_ems_use.gif" alt="텐바이텐 해외배송 서비스 이용방법" /></h4>
							<div class="emsUse">
								<div class="step">
									<h5><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_ems_use_step01.gif" alt="STEP.1 해외배송 가능한 상품 선택" /></h5>
									<div class="account">
										<p><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_ems_use_step01.gif" alt="상품 페이지 화면" /></p>
										<p class="bulletArrow">상품 페이지의 <strong>배송구분</strong>란에서 해외배송 가능여부 확인하세요.</p>
									</div>
								</div>
								<div class="step">
									<h5><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_ems_use_step02.gif" alt="STEP.2 장바구니에서 해외배송탭 선택" /></h5>
									<div class="account">
										<p><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_ems_use_step02.gif" alt="장바구니의 해외배송탭 화면" /></p>
										<p class="bulletArrow">해외배송이 가능한 상품들을 확인 하실 수 있습니다.</p>
									</div>
								</div>
								<div class="step">
									<h5><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_ems_use_step03.gif" alt="STEP.3 배송국가 확인 및 주소 작성" /></h5>
									<div class="account">
										<p><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_ems_use_step03.gif" alt="배송지 정보 입력화며ㅕㄴ" /></p>
										<p class="bulletArrow">배송국가 및 해외배송료를 확인 하시고,  받으실 주소를 <strong>영문으로 입력</strong>해 주세요.</p>
									</div>
								</div>
							</div>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_ems_cancel_etc.gif" alt="취소/반품/교환" /></h4>
							<div class="account">
								<p>
									<strong>1. 주문취소가 가능한 시간</strong><br />
									텐바이텐에서는 매일 오전 9시에 해외배송을 시작하기 때문에 오전 9시 이전까지만 취소하실 수 있습니다.
								</p>
								<p>
									<strong>2. 주문취소 방법</strong><br />
									<a href="/my10x10/order/order_cancel_detail.asp"><strong class="crRed">마이텐마이텐 &gt; 주문취소</strong></a> 또는 고객센터를 통해 주문을 취소하실 수 있습니다.
								</p>
								<p>
									<strong>3. 반품/교환</strong><br />
									해외에서 상품을 수령한 이후에 국내로 반송하는 해외배송비를 계산하여 본 후 경제적으로 판단하여 선택하는 것이 좋습니다.
								</p>
							</div>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_ems_tax.gif" alt="관세 및 세금" /></h4>
							<div class="account">
								<p>우리나라에서도 해외에서 배송한 상품을 받을 때에는 일부 상품에 대해 관세법의 기준에 따라 관세와 부가세 및 특별세 등의 세금을 징수합니다. 
								해외의 각국들 역시 도착지의 세법에 따라 세금을 징수할 수도 있으며, 그 부담은 상품을 받는 사람의 지게 됩니다.<br />
								하지만 특별한 경우를 제외한다면, 선물용으로 보내는 상품에 대해서는 세금이 없습니다.</p>
								<div class="tMar10"><a href="/my10x10/qna/myqnawrite.asp" onclick="window.open(this.href, 'popDepositor', 'width=925, height=800, scrollbars=yes'); return false;" class="linkBtn highlight"><strong>1:1상담 신청하기</strong></a></div>
							</div>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_ems_country.gif" alt="EMS 국가별 발송 조건 검색" /></h4>
							<div class="emsWrap">
								<form action="">
								<fieldset>
								<legend>EMS 배송 국가 선택</legend>
									<div class="box5 ct tPad20 bPad20">
										<label for="emsCountry">배송 국가선택</label>
										<select name="emsCountry" id="emsCountry" class="optSelect" onChange="emsBoxChange(this);" style="width:338px; height:20px;">
											<option value="">국가 선택</option>
										<% for i=0 to oems.FREsultCount-1 %>
											<option value="<%= oems.FItemList(i).FcountryCode %>" id="<%= oems.FItemList(i).FemsAreaCode %>|<%= oems.FItemList(i).FemsMaxWeight %>" iAreaCode="<%= oems.FItemList(i).FemsAreaCode %>" emsMaxWeight="<%= oems.FItemList(i).FemsMaxWeight %>"><%= oems.FItemList(i).FcountryNameKr %>(<%= oems.FItemList(i).FcountryNameEn %>)</option>
										<% next %>
										</select>
										<input type="button" value="국가별 발송조건 보기" onclick="emsBoxChange();" class="btn btnS2 btnGry" />
									</div>

									<table class="baseTable orderForm tMar10">
									<caption>요금적용지역 및 제한중량</caption>
									<colgroup>
										<col width="25%" /> <col width="25%" /> <col width="25%" /> <col width="*" />
									</colgroup>
									<tbody>
									<tr>
										<th scope="row">요금적용지역</th>
										<td class="lt removeLine"><span id="divAreaCode">1</span> 지역</td>
										<th scope="row">제한중량</th>
										<td class="lt removeLine"><span id="divMaxWeight"></span></td>
									</tr>
									</tbody>
									</table>
								</fieldset>
								</form>
							</div>

							<div id="iWeightList" class="orderWrap emsWrap"></div>
						</div>

					</div>
				</div> 
				<!-- //content -->

				<!-- #include virtual="/lib/inc/incCsQuickmenu.asp" -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% SET oems = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->