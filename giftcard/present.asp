<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
	response.Charset="UTF-8"
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/inc/incForceSSL.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardinfoCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardPrdCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardImageCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardOptionCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_orderCls2016.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/inipay/iniWeb/INIWeb_Util.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 기프트카드"		'페이지 타이틀 (필수)
	strPageDesc = "무슨 선물을 할까 늘 고민인 당신, 간편한 텐바이텐 기프트 카드로 마음을 전해보세요. 실물 카드 없이 MMS로  전송받아 편리하고 안전하게 사용 가능합니다."		'페이지 설명

	Const CLimitElecInsureUnder = 0 ''현금 전주문 (5만원이상->전체;2013.11.28; 허진원) 전자보증서 발행 가능
	Const IsCyberAcctValid = TRUE  '' 가상계좌사용여부
	Const CLimitMonthlyBuy = 1000000 ''월 100만원 구매 제한

	dim userid, userlevel
	userid          = GetLoginUserID
	userlevel       = GetLoginUserLevel

	'// 파일서버 처리용 회원ID 암호화
	Dim encUsrId, tmpTx, tmpRn
	Randomize()
	tmpTx = split("A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z",",")
	tmpRn = tmpTx(int(Rnd*26))
	tmpRn = tmpRn & tmpTx(int(Rnd*26))
		encUsrId = tenEnc(tmpRn & userid)

	'// 고객 정보접수
	dim oUserInfo
	set oUserInfo = new CUserInfo
	oUserInfo.FRectUserID = userid
	oUserInfo.GetUserData

	if (oUserInfo.FresultCount<1) then
		set oUserInfo.FOneItem    = new CUserInfoItem
	end if

	'// 월간 고객 주문 총 금액 접수 및 제한 검사
	dim myorder, nTotalBuy
	set myorder = new cGiftcardOrder
		myorder.FUserID = userid
		nTotalBuy = myorder.getGiftcardOrderTotalPrice
	set myorder = Nothing

	''가상계좌 입금기한 마감일
	function getVbankValue()
		dim retVal
		retVal = Left(replace(dateAdd("d",7,Now()),"-",""),8)
		getVbankValue = retVal
	end function

	'######################### cardid 상품의 옵션 html. #########################
	'//옵션 HTML생성
	dim ioptionBoxHtml: ioptionBoxHtml = GetOptionBoxHTML2016(101)
%>
<%
'기프트카드 이미지 데이터
	dim giftCardImgList	

	set giftCardImgList = new GiftCardImageCls
	giftCardImgList.FPageSize			= 8
    giftCardImgList.FRectIsusing		= "1"
    giftCardImgList.GetImageList		
%>
<!-- #include virtual="/lib/inc/head_ssl.asp" -->
<style type="text/css">
.loadingContainer .loading {transition:all 0.5s ease-in-out;}
.loading {
	position:absolute; top:50%; left:50%; width:80px; height:80px; margin-top:-40px; margin-left:-40px;
	border-radius:100%; border:2px solid transparent; border-color:transparent #fff transparent #fff;
	animation: rotate-loading 1.5s linear 0s infinite normal; transform-origin: 50% 50%;
}
@keyframes rotate-loading {
	0% {transform: rotate(0deg);}
	100% {transform: rotate(360deg);}
}
.loadingText {position:absolute; top:50%; left:50%; width:50px; margin-top:-5px; margin-left:-25px; color: #fff; font-family:'arial', 'helvetica', 'sans-serif'; font-size:11px; font-weight:bold; text-align:center; text-transform:uppercase;}
.loadingText {animation:loading-text-opacity 2s linear 0s infinite normal;}
.loadingText span {display:none;}

@keyframes loading-text-opacity {
	0%  {opacity:0}
	20% {opacity:0}
	50% {opacity:1}
	100%{opacity:0}
}

@media \0screen {
	.loading {border:0;}
	.loadingText {margin-top:-20px;}
	.loadingText span {display:block;}
}
.loading {*border:0;}
.loadingText {*margin-top:-20px;}
.loadingText span {*display:block;}

@media all and (min-width:0\0) and (min-resolution:.001dpcm) {.loading {border:0;}}
@media all and (min-width:0\0) and (min-resolution:.001dpcm) {.loadingText {margin-top:-20px;}}
@media all and (min-width:0\0) and (min-resolution:.001dpcm) {.loadingText span {display:block;}}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script src="/lib/js/jquery.form.min.js"></script>
<script type="text/javascript">
$(function(){
	$(document).unbind("dblclick");		//Kill Dbl Click

	/* tiny scroll bar */
	$('.scrollbarwrap').tinyscrollbar();

	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		slidesPerView:1,
		loop: false,
		speed:500,
		autoplay:false,
		slidesPerGroup: 1,
		pagination:'.rolling .pagination',
		paginationClickable:true,
		onImagesReady: function(Swiper){
			// 이미지 선택
			$(".swiper1 .swiper-slide button").unbind("click").click(function(){
				if($(this).attr("bno")=="photo") {
					$("#lyrSelPhoto").show();
					$("#lyrSelDesign").hide();
					document.frmorder.designid.value="900";
				} else if ($(this).attr("bno")) {					
					$("#DsnImg").attr("src",$(this).find("img").attr("src"));
					$("#lyrSelPhoto").hide();
					$("#lyrSelDesign").show();
					document.frmorder.designid.value=$(this).attr("bno");
				}
				$(".rolling ul li button").removeClass("current");
				if ( $(this).hasClass("current")) {
					$(this).removeClass("current");
				}else {
					$(this).addClass("current");
				}
			});
		}
	})	
	$('.btn-prev').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	})
	$('.btn-next').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$(".rolling .swiper-wrapper div:nth-child(1) li:nth-child(2) button").addClass("current");
	$("#DsnImg").attr("src",$(".rolling .swiper-wrapper div:nth-child(1) li:nth-child(2) button").find("img").attr("src"));
	document.frmorder.designid.value = $(".swiper-slide button")[1].getAttribute("bno");

	// gifcard pagination
	var cardNum = $(".rolling .swiper-slide").length;
	for (var i=0; i < cardNum; i++){
		var btnPrevX = 185 - (i * 14)
		var btnNextX = 185 - (i * 14)
		$(".giftcardSwiperV15a .btn-prev").css('left',btnPrevX);
		$(".giftcardSwiperV15a .btn-next").css('right',btnNextX);
	}
<%
if giftCardImgList.FPageSize > 0 then
 	dim pageIdx
 	for pageIdx = 1 to giftCardImgList.FPageSize
 %>
	$('.pagination span:nth-child(<%=pageIdx%>)').append('<%=pageIdx%>');
<%
	next
end if
%>



	/* 글자수 카운팅 */
	$("#giftcardMsg textarea").each(function() {
		var defaultVal = this.value;
		$(this).focus(function() {
			if(this.value == defaultVal){
				this.value = '';
			}
		});
		$(this).blur(function(){
			if(this.value == ''){
				this.value = defaultVal;
			}
		});
	});
	function frmCount(val) {
		var len = GetByteLength(val.value);		// 2byte계산
		if (len >= 201) {
			$("#giftcardMsg .limited b").addClass("cRd0V15").text(len);
		} else {
			$("#giftcardMsg .limited b").removeClass("cRd0V15").text(len);
		}
	}
	$("#giftcardMsg textarea").keyup(function() {
		frmCount(this);
	});

	//휴대폰 번호 입력
	$("#recipient, #sender").blur(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,"").replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3"));
	});

	/* payment type tab */
	$("#paymentType #tabcontainer .tabcont").hide();
	$("#paymentType #tabcontainer .tabcont:first").show();
	$("#paymentType .navigator li:first a").addClass("on");
	$("#paymentType .navigator li a").click(function(){
		$("#paymentType .navigator li a").removeClass("on");
		$(this).addClass("on");
		document.frmorder.Tn_paymethod.value=$(this).attr("data");
		var thisCont = $(this).attr("href");
		$("#paymentType #tabcontainer").find(".tabcont").hide();
		$("#paymentType #tabcontainer").find(thisCont).show();
		return false;
	});

	// Check Browser Ver
	if(parseInt(getIEVersion())<=9 && getIEVersion()!="N/A") {
		$("#lyrSelPhoto label").click(function(){
			alert("사진 등록은 크롬 또는 IE 10 이상의 브라우저에서만 지원 가능합니다.");
			return false;
		});
	}

	// 초기값 세팅
	document.frmpay.price.value=$("#cardopt option:selected").attr("price");
	document.frmorder.cardPrice.value=$("#cardopt option:selected").attr("price");
});
var vImgDomain = '<%=staticImgUrl%>';
//var vImgDomain = '/imgstatic';
</script>
<script src="present.js?v=1.0"></script>
</head>
<body>
<div id="giftcardWrapV15a" class="wrap skinBlueV15a">
	<!-- #include virtual="/lib/inc/incHeader_ssl.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="giftcardPresentV15a">
				<!-- breadcrumb -->
				<div class="breadcrumbV15a">
					<a href="" class="underlineLink">HOME</a> &gt; <b>텐바이텐 기프트카드</b>
				</div>

				<!-- sns -->
				<%
					'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
					dim snpTitle, snpLink, snpPre, snpTag, snpImg
					snpTitle = Server.URLEncode("기프트카드")
					snpLink = Server.URLEncode("http://10x10.co.kr/giftcard/")
					snpPre = Server.URLEncode("텐바이텐")
					snpTag = Server.URLEncode("#10x10")
					snpImg = Server.URLEncode("http://fiximage.10x10.co.kr/web2015/giftcard/img_giftcard_type_05.png")
				%>
				<div class="snsV15a">
					<a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>');return false;" class="twitter"><span></span>트위터</a>
					<a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;" class="facebook"><span></span>페이스북</a>
					<a href="" onclick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>');return false;" class="pinterset"><span></span>핀터레스트</a>
				</div>

				<div class="sectionContainer">
				<!-- ### 결제요청서 ### -->
				<form name="frmpay" id="frmpay" method="post" style="margin:0px;">
				<!-- 상점아이디 -->
				<input type="hidden" name="mid" value="<%=chkIIF(application("Svr_Info")="Dev","INIpayTest","teenxteen8")%>">
				<!-- 화폐단위 -->
				<input type="hidden" name="currency" value="WON">
				<!-- 무이자 할부 -->
				<input type="hidden" name="nointerest" value="">
				<input type="hidden" name="quotabase" value="2:3:4:5:6:7:8:9:10:11:12">
				<input type="hidden" name="acceptmethod" value="VERIFY:NOSELF:no_receipt:Vbank(<%=getVbankValue()%>)">

				<input type="hidden" name="quotainterest" value="">
				<input type="hidden" name="paymethod" value="">
				<input type="hidden" name="cardcode" value="">
				<input type="hidden" name="cardquota" value="">
				<input type="hidden" name="rbankcode" value="">
				<input type="hidden" name="reqsign" value="DONE">
				<input type="hidden" name="encrypted" value="">
				<input type="hidden" name="sessionkey" value="">
				<input type="hidden" name="uid" value="">
				<input type="hidden" name="sid" value="">

				<!-- //Strd Form -->
				<input type="hidden" name="returnUrl" value="<%=SSLUrl%>/giftcard/iniWeb/INIWeb_return.asp">
				<input type="hidden" name="version" value="<%=INIWEB_ver%>">
				<input type="hidden" name="mKey" value="<%=INIWEB_mKey8%>">
				<input type="hidden" name="popupUrl" value="<%=INIWEB_popupUrl%>">
				<input type="hidden" name="closeUrl" value="<%=INIWEB_closeUrl%>">
				<input type="hidden" name="payViewType" value="overlay">
				<input type="hidden" name="authToken" value="">
				<input type="hidden" name="authUrl" value="">
				<div id="INIWEB_SIG"></div>
				<!-- Strd Form// -->

				<input type="hidden" name="clickcontrol" value="enable">
				<input type="hidden" name="price" value="0">
				<input type="hidden" name="goodname" value='텐바이텐 기프트카드'>

				<input type="hidden" name="buyername" value="<%= doubleQuote(oUserInfo.FOneItem.FUserName) %>">
				<input type="hidden" name="buyeremail" value="<%= oUserInfo.FOneItem.Fusermail %>">
				<input type="hidden" name="buyertel" value="<%= oUserInfo.FOneItem.Fusercell %>">

				<input type="hidden" name="gopaymethod" value="Card"> <!-- or DirectBank -->
				<input type="hidden" name="ini_logoimage_url" value="/fiximage/web2008/shoppingbag/logo2004.gif">
				</form>

				<!-- ### 주문서 ### -->
				<form name="frmorder" id="frmorder" method="post" style="margin:0px;">
				<!-- // 구매 고객 정보 -->
				<input type="hidden" name="buyname" value="<%= doubleQuote(oUserInfo.FOneItem.FUserName) %>">
				<input type="hidden" name="buyemail" value="<%= oUserInfo.FOneItem.Fusermail %>">
				<input type="hidden" name="buyhp" value="<%= oUserInfo.FOneItem.Fusercell %>">
				<input type="hidden" name="buyphone" value="<%=oUserInfo.FOneItem.Fuserphone%>">

				<!-- // 기프트카드 정보 -->
				<input type="hidden" name="cardid" value="101">		<!-- 기프트카드 상품번호 -->
				<input type="hidden" name="cardPrice" value="0">	<!-- 기프트카드 금액 -->
				<input type="hidden" name="designid" value="">	<!-- 기프트카드 디자인 -->
				<input type="hidden" name="userImg" value="">		<!-- 기프트카드 사용자이미지 -->

				<!-- // 수신자 정보 -->
				<input type="hidden" name="sendemail" value="<%= oUserInfo.FOneItem.Fusermail %>">
				<input type="hidden" name="reqemail" value="">
				<input type="hidden" name="emailTitle" value="">
				<input type="hidden" name="emailContent" value="">

				<input type="hidden" name="bookingDate" value="">
				<input type="hidden" name="Tn_paymethod" value="100">
				<input type="hidden" name="rdsite" value="pc_web">

					<div class="sectionContent giftcardChoiceV15a">
						<div class="hGroup">
							<h2>텐바이텐 <strong>기프트카드</strong></h2>
							<p>텐바이텐 기프트카드는 실물 카드 없이 MMS로 전송받아 편리하고 안전하게 사용 가능합니다.</p>
						</div>
						<div class="btnGroupV15a">
							<a href="<%=wwwUrl%>/my10x10/giftcard/giftcardOrderlist.asp" class="underlineLink"><b>주문/등록내역 확인<span>&gt;</span></b></a>
							<a href="<%=wwwUrl%>/giftcard/" class="cRd0V15 underlineLink"><b>이용안내 및 유의사항<span>&gt;</span></b></a>
						</div>						
						<!-- swipe -->
						<div class="giftcardSwiperV15a">
							<div class="rolling">
								<div class="swiper-container swiper1">
									<div class="swiper-wrapper">
										<%	
											dim lastContainerFlag, i
											lastContainerFlag = 0
											for i = 0 to giftCardImgList.FResultCount - 1
												if i mod giftCardImgList.FPageSize = 0 then
													response.write "<div class=""swiper-slide""><ul>"																										
													lastContainerFlag = lastContainerFlag + 1
												end if											
										%>										
										<% if i = 0 then %>
											<li>
												<button type="button" class="btnPhoto" bno="photo"><span></span><p>사진등록</p></button>
											</li>
										<% else %>	
											<li>
												<% if i = 1 then %>												
													<span class="new">NEW</span>												
												<% end if %>
												<button type="button" bno="<%=giftCardImgList.FItemList(i).FdesignId%>">
													<span></span>
													<img src="<%=giftCardImgList.FItemList(i).FGiftCardImage%>" alt="<%=giftCardImgList.FItemList(i).FGiftCardAlt%>" />
												</button>
											</li>										
										<% end if %>											
										<%		
												if i mod giftCardImgList.FPageSize = 7 then
													response.write "</ul></div>"													
												end if																																		
											next																												
										%>		
										<%
											if i mod giftCardImgList.FPageSize <> 0 and Cint(lastContainerFlag) = Cint(giftCardImgList.FtotalPage) then
												response.write "</ul></div>"																				
											end if
										%>																			
									</div>
								</div>
								<div class="pagination"></div>									
							</div>							
							<button type="button" class="btn-nav btn-prev">Previous</button>
							<button type="button" class="btn-nav btn-next">Next</button>
							<!-- 사진등록 -->
							<div id="lyrSelPhoto" class="design designTypeA" style="display:none;">
								<div class="file">
									<label for="fileupload" class="btn btnS1 btnRed">사진 등록</label>
								</div>
								<div id="lyrUsrImg" class="cropbox" style="display:none;">
									<img id="UsrImg" src="" width="455" height="275" alt="사용자이미지" />
									<div class="frame"></div>
									<button type="button" class="btnDel" onclick="fnDelUsrImg()"><img src="/fiximage/web2015/giftcard/btn_delete.png" alt="삭제" /></button>
								</div>
								<div id="lyrPrgs" class="loadingContainer" style="display:none;">
									<div class="loading"></div>
									<div class="loadingText"><span><img src="/fiximage/web2015/giftcard/ajax_loader.gif" alt="" /></span>loading</div>
								</div>
							</div>
							<!-- 디자인 -->
							<div id="lyrSelDesign" class="design designTypeB" >
								<img id="DsnImg" src="http://fiximage.10x10.co.kr/web2018/giftcard/img_giftcard_type_51.png" width="455" height="275" alt="카드디자인" />
								<div class="frame"></div>
							</div>
						</div>
						<div id="giftcardMsg" class="giftcardMsgV15a">
							<fieldset>
								<legend>기프트 카드 메시지 입력</legend>
								<input type="hidden" name="MMSTitle" value="<%=oUserInfo.FOneItem.Fusername%>님이 텐바이텐 기프트카드를 보내셨습니다.">
								<textarea name="MMSContent" title="기프트 카드 메시지 입력" cols="60" rows="5" placeholder="기프트카드와 함께 보낼실 메시지를 입력해주세요."></textarea>
								<div class="limited"><b>0</b>/200</div>
							</fieldset>
						</div>
					</div>

					<!-- price -->
					<div class="sectionContent giftcardOrderV15a">
						<div class="column giftcardPriceV15a">
							<fieldset>
							<legend>선물할 기프트 카드 금액선택</legend>
								<h3>금액선택</h3>
								<div class="selectwrap"><%= ioptionBoxHtml %></div>
							</fieldset>
						</div>

						<!-- 받는사람/보내는사람 -->
						<div class="column giftcardInfoV15a">
							<h3 class="hidden">받는사람/보내는사람</h3>
							<fieldset>
							<legend>기프트 카드 받는 사람 입력</legend>
								<table>
									<caption>받는 사람 및 보내는 사람 휴대폰 정보</caption>
									<tbody>
									<tr>
										<th scope="row"><label for="recipient">받는사람</label></th>
										<td><input type="text" id="recipient" name="reqhp" title="받는사람 휴대폰 번호를 입력" placeholder="휴대폰 번호를 입력해주세요" /></td>
									</tr>
									<tr>
										<th scope="row"><label for="sender">보내는사람</label></th>
										<td><input type="text" id="sender" name="sendhp" value="<%= oUserInfo.FOneItem.Fusercell %>" placeholder="휴대폰 번호를 입력해주세요" /></td>
									</tr>
									</tbody>
								</table>
								<ul class="listTypeHypen">
									<li>- 발신번호 사전등록제 시행으로 인해 메시지 발신번호가 1644-6030(고객센터)로 표시됩니다.</li>
									<li>- 휴대폰 번호를 잘못 입력하실 경우 타사용자가 인증번호를 등록할 수 있으며, 이 경우 환불이 불가하오니 유의 바랍니다.</li>
								</ul>
							</fieldset>
						</div>

						<!-- payment -->
						<div class="column giftcardPayV15a">
							<h3>결제수단</h3>
							<ul class="listTypeHypen">
								<li>- 기프트카드 구매는 상품을 구매하는 것이 아니라 무기명 선불카드를 구매하는 것 이므로 비과세로 구분됩니다.</li>
								<li>- 신용카드로 기프트카드 구매 시 매출전표는 부과세 표시 없이 발행되며, 거래내역서 용도로 사용 가능합니다.</li>
								<li>- 실시간계좌이체 및 무통장 입금으로 구매 시 현금영수증, 세금계산서 증빙서류는 발급이 불가하며, GIFT 카드로 상품을 구매할 때 현금영수증 발행이 가능합니다.</li>
							</ul>

							<div id="paymentType" class="paymentType">
								<ul class="navigator">
									<li class="nav1"><a href="#tabcont1" data="100"><span>신용카드</span></a></li>
									<li class="nav2"><a href="#tabcont2" data="20"><span>실시간 계좌이체</span></a></li>
									<li class="nav3"><a href="#tabcont3" data="7"><span>무통장입금<br /><%= CHKIIF(IsCyberAcctValid,"(가상계좌)","(일반계좌)") %></span></a></li>
								</ul>

								<div id="tabcontainer" class="tabcontainer">
									<div id="tabcont1" class="tabcont">
										<div class="guide">
											<a href="/giftcard/popCreditcard.asp" onclick="window.open(this.href, 'popAccountTransfer', 'width=500, height=500, scrollbars=no'); return false;" target="_blank" title="팝업 새창" class="underlineLink">신용카드 결제 안내&gt;</a>
											<a href="http://www.inicis.com/popup/C_popup/popup_C_01.html" onclick="window.open(this.href, 'popAccountTransfer', 'width=620, height=600, scrollbars=yes'); return false;" target="_blank" title="팝업 새창" class="underlineLink">공인인증서 안내&gt;</a>
											<a href="http://www.inicis.com/popup/C_popup/popup_C_02.html" onclick="window.open(this.href, 'popAccountTransfer', 'width=620, height=600, scrollbars=yes'); return false;" target="_blank" title="팝업 새창" class="underlineLink">안심클릭 안내&gt;</a>
											<a href="http://www.inicis.com/popup/C_popup/popup_C_03.html" onclick="window.open(this.href, 'popAccountTransfer', 'width=620, height=600, scrollbars=yes'); return false;" target="_blank" title="팝업 새창" class="underlineLink">안전결제(ISP) 안내&gt;</a>
										</div>
									</div>
									<div id="tabcont2" class="tabcont">
										<div class="guide">
											<a href="/giftcard/popAccountTransfer.asp" onclick="window.open(this.href, 'popAccountTransfer', 'width=500, height=550, scrollbars=no'); return false;" target="_blank" title="팝업 새창" class="underlineLink">실시간 계좌이체 안내&gt;</a>
										</div>
									</div>
									<div id="tabcont3" class="tabcont">
										<input type="hidden" name="isCyberAcct" value="<%= CHKIIF(IsCyberAcctValid,"Y","") %>">
										<input type="hidden" name="CST_PLATFORM" value="<%= CHKIIF(application("Svr_Info")= "Dev","test","") %>">
										<div class="guide">
											<% if Not(IsCyberAcctValid) then %>
											<span>
												<b>입금계좌번호</b>: <% Call DrawTenBankAccount("acctno","") %> &nbsp;&nbsp;예금주 : (주)텐바이텐<br />
												<b>입금자 명</b> : <input type="text" name="acctname" maxlength="16" style="width:120px; font-size:11px; border:1px solid #dfdede; padding:2px;">
											</span><br/ ><br />
											<% end if %>
											<a href="/giftcard/popDeposit.asp?bCb=<%= CHKIIF(IsCyberAcctValid,"Y","") %>" onclick="window.open(this.href, 'popDeposit', 'width=500, height=335, scrollbars=no'); return false;" target="_blank" title="팝업 새창" class="underlineLink">무통장입금 <%= CHKIIF(IsCyberAcctValid,"(가상계좌)","(일반계좌)") %>&gt;</a>
										</div>
									</div>
								</div>
							</div>

							<!-- policy -->
							<div class="giftcardPolicyV15a">
								<fieldset>
								<legend>텐바이텐 기프트카드 약관동의</legend>
									<div class="scrollbarwrap">
										<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
										<div class="viewport">
											<div class="overview">
												<!-- 텐바이텐 기프트카드 약관 -->
												<!-- #include virtual="/giftcard/policy.asp" -->
											</div>
										</div>
									</div>

									<p class="agree"><input type="checkbox" id="agreeYes" class="check" name="areement" value="ok" /> <label for="agreeYes"><b>이용약관</b>을 확인하였으며 이에 <b>동의</b>합니다.</label></p>
								</fieldset>
							</div>
						</div>

						<div class="btnGroupV15a">
							<button type="button" onclick="OrderProc(document.frmorder, document.frmpay);" class="btn btnB1 btnRed">결제하기</button>
						</div>
					</div>
				</form>
				<!-- ### 유저이미지 ### -->
				<form name="frmUpload" id="ajaxform" action="<%=chkIIF(application("Svr_Info")="Dev",uploadImgUrl,Replace(uploadImgUrl,"http://","https://"))%>/linkweb/giftcard/doUserGiftCardImgReg.asp" method="post" enctype="multipart/form-data" style="opacity:0; filter: alpha(opacity=0); height:0px;width:0px;">
				<input type="file" name="UsrPhoto" id="fileupload" onchange="fnCheckPreUpload();" accept="image/*" />
				<input type="hidden" name="mode" id="fileupmode" value="preImg">
				<input type="hidden" name="tuid" value="<%=encUsrId%>">
				<input type="hidden" name="preimg" id="filePreImg" value="">
				<input type="hidden" name="crpX" id="fileCrpX" value="">
				<input type="hidden" name="crpY" id="fileCrpY" value="">
				<input type="hidden" name="crpW" id="fileCrpW" value="">
				<input type="hidden" name="crpH" id="fileCrpH" value="">
				<input type="hidden" name="mtd" id="fileMtd" value="">
				</form>
				</div>

			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter_SSL.asp" -->
</div>
<script type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
</body>
</html>
<%
	set oUserInfo = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->