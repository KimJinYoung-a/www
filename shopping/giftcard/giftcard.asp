<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardinfoCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardPrdCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardOptionCls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성

'// 아래에서 재설정(상품명 추가)
strPageTitle = "텐바이텐 10X10 : 기프트카드 구매하기"		'페이지 타이틀 (필수)

strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim cardid, itEvtImg, itEvtImgMap
cardid = requestCheckVar(request("cardid"),3)

if cardid="" or cardid="0" then
	Call Alert_Return("상품번호가 없습니다.")
	response.End
elseif Not(isNumeric(cardid)) then
	Call Alert_Return("잘못된 상품번호입니다.")
	response.End
end if

'######################### cardid 로 기본 내용 조회. #########################
dim oItem
set oItem = new GiftCardPrdCls
oItem.GetItemData cardid

if oItem.FResultCount=0 then
	Call Alert_Return("존재하지 않는 상품입니다.")
	response.End
end if

if oItem.Prd.Fisusing="N" then
	Call Alert_Return("판매가 종료되었거나 삭제된 상품입니다.")
	response.End
end if

'######################### cardid 상품의 옵션 html. #########################
'//옵션 HTML생성
dim ioptionBoxHtml
	ioptionBoxHtml = GetOptionBoxHTML(cardid, oitem.Prd.IsSoldOut)


dim LoginUserid
LoginUserid = getLoginUserid()


'타이틀 설정
strPageTitle = "텐바이텐 10X10 : " & oItem.Prd.FCardItemName

'' '페이지 설명 설정
'' strHeaderDesc = "생활감성채널 텐바이텐 - " & oItem.Prd.FCardItemName & ""
'' '추가 메타태그 설정
'' strHeaderAddMetaTag = "<meta name='title' content='" & "[텐바이텐] " & Replace(oItem.Prd.FCardItemName,"'","") & "' />" & vbCrLf


'// TODO : 세일 표시 없음
'// (참고 : /2012www/shopping/giftcard/giftcard.asp)

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">

$(function() {
	$('.pdtTabLink ul li').click(function(){
		$('.pdtTabLink ul li').removeClass('current');
		$(this).addClass('current');
	});
});

window.onload=function(){
	// 탑메뉴위치값 저장
	var menuTop = $(".pdtTabLinkV15").offset().top;

	$(window).scroll(function(){
		//탑메뉴 플로팅
		if( $(window).scrollTop()>=menuTop ) {
			//스크롤 위치가 탑메뉴의 위치 보다 크면 플로팅
			$(".pdtTabLinkV15").css("position","fixed");
			$(".pdtTabLinkV15").css("top",0);
		} else {
			//스크롤 위치가 탑메뉴의 위치 보다 작으면 원래위치
			$(".pdtTabLinkV15").css("position","absolute");
			$("#tab01").addClass("current");
		}

		//메뉴표시 (스크롤 위치가 해당메뉴 위치값을 지나면 탑메뉴 선택표시)
		if( $(window).scrollTop()>=($("#detail01").offset().top-$(".pdtTabLinkV15").outerHeight()-25) ) {
			$('.pdtTabLinkV15 ul li').removeClass('current');
			$("#tab01").addClass("current");
		}
		if( $(window).scrollTop()>=($("#detail02").offset().top-$(".pdtTabLinkV15").outerHeight()-25) ) {
			$('.pdtTabLinkV15 ul li').removeClass('current');
			$("#tab02").addClass("current");
		}
		if($(window).scrollTop()>=($(document).height()-$(window).height()-100)) {
			$('.pdtTabLinkV15 ul li').removeClass('current');
			$("#tab03").addClass("current");
		}
		if($(window).scrollTop()>=($(document).height()-$(window).height())) {
			$('.pdtTabLinkV15 ul li').removeClass('current');
			$("#tab04").addClass("current");
		}
	});
}

//앵커이동
function goToByScroll(id){
	// 해당메뉴 위치로 스크롤 변경 (스크롤 = 해당매뉴 위치 - 탑메뉴 높이)
	$('html,body').animate({scrollTop: $("#detail"+id).offset().top-$(".pdtTabLinkV15").outerHeight()-20},'slow');
}

// function popGiftcardDesign(cid,did) {
// 	popShowImg("<%=webImgUrl%>/giftcard/eMail/10/E000"+cid+did+".jpg");
// }

function popGiftcardDesign(cid, did) {
	var url = "";
	window.open(url, target, "width=875, height=900, resizable=0,scrollbars=yes,location=0");
}

// 이메일 미리보기 팝업
function popPreviewEmailCard(designid) {
	var url = "<%=wwwURL%>/inipay/giftcard/popPreviewEmailCard.asp?designid=" + designid;
	var cardPop = window.open(url,"cardPreview","width=875, height=900, scrollbars=yes");
}

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap" class="categoryPrd">
			<div class="giftcardDetailV15">
				<p class="tPad10"><a href="/" title="메인 페이지로 이동하기">HOME</a> &gt; <strong>텐바이텐 Gift 카드</strong></p>
				<div class="pdtInfoWrapV15">
					<div class="pdtPhotoWrap">
						<p class="pdtPhotoBox"><img src="<%=webImgUrl%><%=oItem.Prd.FImageBasic%>" alt="기프트 카드" width="400px" height="400px" /></p>
					</div>
					<div class="pdtDetailWrap">
						<form name="sbagfrm" method="post" action="/inipay/giftcard/giftcard_orderInfo.asp" style="margin:0px;">
						<input type="hidden" name="cardid" value="<% = oitem.Prd.FCardItemID %>">

						<div class="pdtInfoV15">
							<div class="pdtSaleInfoV15">
								<div class="pdtBasicV15">
									<p class="pdtBrand"></p>
									<h2><p class="pdtName"><%=oItem.Prd.FCardItemName%></h2>
									<p class="pdtDesp"><%=oItem.Prd.FCardInfo%></p>
								</div>

								<div class="detailInfoV15">
									<dl class="saleInfo">
										<dt>권면금액</dt>
										<dd><%= ioptionBoxHtml %></dd>
									</dl>
									<dl class="saleInfo">
										<dt>유의사항</dt>
										<dd>- 카드 실물 없이 모바일로 인증번호를 받아 사용<br />- 텐바이텐 온라인 사이트와 텐바이텐 오프라인 매장에서 사용</dd>
									</dl>
									<dl class="saleInfo">
										<dt>주문수량</dt>
										<dd><strong>1EA</strong> (한번에 하나씩만 구매가 가능합니다.)</dd>
									</dl>
									<dl class="saleInfo">
										<dt>사용방법</dt>
										<dd>
											1. 인증번호 수신<br />
											2. 로그인 후 인증번호 등록 <a href="/my10x10/giftcard/giftcardRegist.asp" class="btn btnS3 btnRed lMar10"><em class="whiteArr01 fn">Gift카드 등록 하러가기</em></a><br />
											3. 원하는 상품 주문시 사용<br />
											&nbsp;&nbsp;&nbsp;(결제 시, 할인정보 &gt; Gift 카드에서 사용 가능)
										</dd>
									</dl>
								</div>
							</div>
							<div class="pdtAddInfoV15">
							</div>
						</div>
						</form>
						<div class="btnArea">
							<% if oItem.Prd.IsSoldOut then %>
							<span style="width:390px;"><a href="javascript:alert('품절입니다.');" class="btn btnB1 btnGry">SOLD OUT</a></span>
							<% else %>
							<span style="width:390px;"><a href="javascript:TnBuyGiftCard(true);" class="btn btnB1 btnRed">바로 구매</a></span>
							<% end if %>
						</div>
						<div class="evtSnsV15">
							<ul class="pdtSnsV15">
								<% '// 쇼셜서비스로 글보내기
								dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
								snpTitle = Server.URLEncode(oItem.Prd.FCardItemName)
								snpLink = Server.URLEncode("http://10x10.co.kr/shopping/giftcard/giftcard.asp?cardid=" & cardid)

								'기본 태그
								snpPre = Server.URLEncode("텐바이텐 Gift 카드")
								snpTag = Server.URLEncode("텐바이텐 " & Replace(oItem.Prd.FCardItemName," ",""))
								snpTag2 = Server.URLEncode("#10x10")
								snpImg = Server.URLEncode(webImgUrl & oItem.Prd.FImageBasic)
								%>
								<!--<li><a href="" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li>-->
								<li class="twShareV15"><a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;">Twitter</a></li>
								<li class="fbShareV15"><a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;">Facebook</a></li>
								<li class="ptShareV15"><a href="" onClick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;">Pinterest</a></li>
							</ul>
						</div>
					</div>
				</div>

				<div class="pdtDetailV15 tMar10">
					<!-- 상품 TAB -->
					<div class="pdtTabLinkV15">
						<ul>
							<li id="tab01" onclick="goToByScroll('01');" class="current"><p>카드안내</p></li>
							<li id="tab02" onclick="goToByScroll('02');"><p>사용방법</p></li>
							<li id="tab03" onclick="goToByScroll('03');"><p>유의사항</p></li>
							<li id="tab04" onclick="goToByScroll('04');"><p>구매취소 및 환불규정</p></li>
						</ul>
					</div>

					<div class="pdtSection">
						<!-- 카드안내 -->
						<div class="giftcard" id="detail01">
							<h3>카드안내</h3>
							<div class="pdtInforBox">
								<div class="pdtInforList">
									<span><em>발행자</em> : 텐바이텐</span>
									<span><em>유효기간</em> : 구매일로부터 5년</span>
									<span><em>전송방법</em> : 모바일로 인증번호 전송(이메일 전송 선택 가능)</span>
									<span><em>이용가능매장</em> : 텐바이텐 온라인 쇼핑몰, 텐바이텐 LIFE STYLE SHOP (대학로점, 김포롯데점, 일산점, 제주점) <a href="http://www.10x10.co.kr/offshop/shopinfo.asp?shopid=streetshop011" target="_blank"><dfn class="addInfo">오프라인 매장 정보</dfn></a></span>
									<span><em>잔액환급조건</em> : Gift 카드 금액이 1만원 초과일 경우 100분의 60 이상, 1만원 이하일 경우 100분의 80 이상 사용한 경우, 잔액 환급 가능</span>
								</div>
							</div>
							<ul class="tMar50">
								<li>- Gift 카드는 다른 일반 상품과 함께 구매가 되지 않는 단독 구매 상품으로, 한 주문에 하나의 Gift 카드만 구매 가능합니다.</li>
								<li>- Gift 카드 구매는 무기명 선불카드를 구매하는 것이므로 모든 결제수단이 비과세로 구분됩니다. 현금영수증, 세금계산서 증빙서류는 발급이 불가하며, 선물 받은 사람이 카드를 <br />&nbsp;&nbsp;사용할 때 현금영수증 발행이 가능 합니다.</li>
								<li>- Gift 카드는 신용카드, 무통장입금, 실시간 계좌이체와 같은 기존의 결제 수단으로 구매가 가능하나 쿠폰, 마일리지, 예치금 등의 사용은 제한되어 있습니다.</li>
								<li>- 인(人)당 월 구매한도는 100만원입니다.</li>
							</ul>

							<h4 class="tMar50">이메일 전송(Gift 카드 디자인 선택 가능)</h4>
							<ul class="tMar25">
								<li>- 모바일과 함께 이메일로 해당내용이 전송되는 서비스로 생일, 감사, 축하 등 용도에 맞춰 이메일 디자인을 선택할 수 있어 선물하시기에 좋습니다.</li>
								<li>- 이메일 전송은 다음 단계인 결제 단계에서 선택하실 수 있습니다.</li>
								<li>- 카드 이미지를 클릭하시면 이메일 전송된 예시를 보실 수 있습니다.</li>
							</ul>
							<div class="section tMar30">
								<div class="box giftcardDesign">
									<div class="giftcardList">
										<div class="kind">
											<h5><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_giftcard_design_basic.gif" alt="BASIC" /></h5>
											<ul>
												<li>
													<a href="javascript:popPreviewEmailCard(101);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_basic_01.png" width="92" height="56" alt="텐바이텐 기프트카드 BASIC 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(103);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_basic_02.png" width="92" height="56" alt="텐바이텐 기프트카드 BASIC 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(102);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_basic_03.png" width="92" height="56" alt="텐바이텐 기프트카드 BASIC 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
											</ul>
										</div>
										<div class="kind">
											<h5><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_giftcard_design_love.gif" alt="LOVE" /></h5>
											<ul>
												<li>
													<a href="javascript:popPreviewEmailCard(501);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_love_01.png" width="92" height="56" alt="텐바이텐 기프트카드 LOVE 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(502);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_love_02.png" width="92" height="56" alt="텐바이텐 기프트카드 LOVE 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(503);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_love_03.png" width="92" height="56" alt="텐바이텐 기프트카드 LOVE 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
											</ul>
										</div>
										<div class="kind">
											<h5><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_giftcard_design_birthday.gif" alt="BIRTHDAY" /></h5>
											<ul>
												<li>
													<a href="javascript:popPreviewEmailCard(201);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_birthday_01.png" width="92" height="56" alt="텐바이텐 기프트카드 BIRTHDAY 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(202);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_birthday_02.png" width="92" height="56" alt="텐바이텐 기프트카드 BIRTHDAY 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(203);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_birthday_03.png" width="92" height="56" alt="텐바이텐 기프트카드 BIRTHDAY 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
											</ul>
										</div>
										<div class="kind">
											<h5><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_giftcard_design_thanks.gif" alt="THANKS" /></h5>
											<ul>
												<li>
													<a href="javascript:popPreviewEmailCard(301);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_thanks_01.png" width="92" height="56" alt="텐바이텐 기프트카드 THANKS 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(302);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_thanks_02.png" width="92" height="56" alt="텐바이텐 기프트카드 THANKS 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(303);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_thanks_03.png" width="92" height="56" alt="텐바이텐 기프트카드 THANKS 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
											</ul>
										</div>
										<div class="kind">
											<h5><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_giftcard_design_congratulations.gif" alt="CONGRATULATIONS" /></h5>
											<ul>
												<li>
													<a href="javascript:popPreviewEmailCard(401);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_congratulations_01.png" width="92" height="56" alt="텐바이텐 기프트카드 CONGRATULATIONS 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(402);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_congratulations_02.png" width="92" height="56" alt="텐바이텐 기프트카드 CONGRATULATIONS 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
												<li>
													<a href="javascript:popPreviewEmailCard(403);">
														<span class="design">
															<img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_giftcard_congratulations_03.png" width="92" height="56" alt="텐바이텐 기프트카드 CONGRATULATIONS 디자인" />
														</span>
														<span class="selectBtn"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_giftcard_select.png" alt="" /></span>
													</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //카드안내 -->

						<!-- 사용방법 -->
						<div class="giftcard tMar60" id="detail02">
							<h3>사용방법</h3>
							<div class="section">
								<div class="process">
									<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_gift_card_online.gif" alt="온라인 사용방법" /></h4>
									<ol>
										<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_process_use_online_01.gif" alt="인증번호 수신" /></li>
										<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_process_use_online_02.gif" alt="인증번호 등록 : 마이텐바이텐&gt;GIFT 카드&gt; 카드 등록 및 내역에서 인증번호 등록" /></li>
										<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_process_use_online_03.gif" alt="원하는 상품 주문하기" /></li>
										<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_process_use_online_04.gif" alt="상품 결제 하기 : 결제시, 할인 정보&gt;GIFT 카드에서 사용 가능" /></li>
									</ol>
								</div>
								<ul class="box tMar10">
									<li>- 전송 받으신 인증번호를 텐바이텐 온라인 로그인 후 <a href="/my10x10/giftcard/giftcardRegist.asp" class="crRed"><strong>마이텐바이텐&gt;Gift 카드&gt;온라인 사용 등록 및 내역</strong></a>에서 인증번호를 등록합니다.</li>
									<li>- 인증번호 등록 후 상품 구매시 결제 페이지에서 Gift 카드 금액을 현금처럼 사용할 수 있으며, 다른 결제 수단과 중복으로 사용 가능합니다.</li>
									<li>- 횟수에 관계없이 금액을 여러번 나누어서 사용할 수 있으며, 여러 개의 Gift카드를 등록하신 경우, 등록 순서에 따라 순차적으로 사용됩니다.</li>
								</ul>

								<div class="process tPad30 tMar20">
									<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_gift_card_offline.gif" alt="오프라인 사용방법" /></h4>
									<ol>
										<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_process_use_offline_01.gif" alt="인증번호 수신" /></li>
										<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_process_use_offline_02.gif" alt="인증번호 등록 : 마이텐바이텐 &gt; GIFT 카드 &gt; 카드 등록 및 내역에서 인증번호 등록" /></li>
										<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_process_use_offline_03.gif" alt="간단한 본인 확인 후 상품 결제" /></li>
									</ol>
								</div>
								<ul class="box tMar10">
									<li>- 전송 받은 인증번호를 텐바이텐 온라인 로그인 후 <a href="/my10x10/giftcard/giftcardRegist.asp" class="crRed"><strong>마이텐바이텐&gt;Gift 카드&gt;온라인 사용 등록 및 내역</strong></a>에서 인증번호를 등록합니다.</li>
									<li>- 온라인에서 인증번호를 등록 후 오프라인 매장에서 결제 시, 인증번호를 제시 하시면 간단한 본인확인 절차를 거친 후 사용 가능합니다.</li>
									<li>- 횟수에 관계없이 금액을 여러 번 나누어서 사용할 수 있으며 다른 결제수단과 중복으로 사용 가능합니다.</li>
								</ul>
							</div>
						</div>
						<!-- //사용방법 -->

						<!-- 유의사항 -->
						<div class="tMar60" id="detail03">
							<h3>유의사항</h3>
							<ul>
								<li>- 받는 분의 정보를 잘못 입력한 경우 또는 받는 분이 인증번호를 잊어버렸을 경우, 카드 사용 등록 전이면 <a href="/my10x10/giftcard/giftcardOrderlist.asp" class="crRed"><strong>마이텐바이텐&gt;Gift 카드&gt;카드 주문내역</strong></a>에서 2회까지 재전송이 가능합니다.</li>
								<li>- 새로운 인증번호 받기로 재전송을 하신 경우 이전에 전송된 인증번호는 무효처리 됩니다.</li>
								<li>- 온라인 쇼핑몰 사용 후 남은 금액을 오프라인 매장에서 사용 가능하며, 오프라인 매장에서 사용 후 남은 금액을 온라인 쇼핑몰에서도 사용 가능합니다.</li>
							</ul>
						</div>
						<!-- //유의사항 -->

						<!-- 구매취소 및 환불규정 -->
						<div class="tMar60" id="detail04">
							<h3>구매취소 및 환불규정</h3>
							<ul>
								<li>- <span class="crRed">사용 유효기간이 지난 경우 환불 처리가 불가 합니다. (유효기간 : 구매일로부터 5년)</span></li>
								<li>- 구매 취소는 구매일로부터 7일 이내에 가능하나,  카드 사용 등록이 완료되었거나 오프라인 매장에서 일부 금액을 사용한 경우에는 구매취소가 불가합니다.</li>
								<li>- 받는 분의 정보를 잘못 입력하여 타 사용자가 카드 사용 등록을 하였거나 오프라인 매장에서 사용한 경우 환불이 불가하며 텐바이텐은 책임을 지지 않습니다.</li>
								<li>- Gift 카드 금액이 1만원 초과일 경우 100분의 60 이상, 1만원 이하일 경우 100분의 80 이상 사용을 하면 남은 금액은 온라인 예치금으로 전환이 가능합니다.</li>
							</ul>
						</div>
						<!-- //구매취소 및 환불규정 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
Set oItem = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
