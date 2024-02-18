<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'###########################################################
' Description : 17주년 잘사고 잘받자
' History : 2018-10-02 최종원 생성
'###########################################################

'// 쇼셜서비스로 글보내기 
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐 17주년] 잘 사고 잘 받자")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/17th/gift.asp")
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2018/88942/etcitemban20180921085050.JPEG")


'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[텐바이텐 17주년] 잘 사고 잘 받자"
strPageKeyword = "[텐바이텐 17주년] 잘 사고 잘 받자"
strPageDesc = "텐바이텐에서 즐겁게 쇼핑하고 슬기로운 사은품 받으세요!"
strPageUrl = "http://www.10x10.co.kr/event/17th/gift.asp"
strPageImage = "http://webimage.10x10.co.kr/eventIMG/2018/88942/etcitemban20180921085050.JPEG"

	'=============================== 품절 여부
dim isGiftSoldOutArr(), strSql, i	
redim preserve isGiftSoldOutArr(2)	
	isGiftSoldOutArr(0) = 0
	isGiftSoldOutArr(1) = 0
	
	'17451 : 마켓비 사이트 테이블 	  index-0
	'17448 : 모즈 에스프레소 커피머신 index-1

	strSql = " SELECT CASE 													"	
	strSql = strSql & "		WHEN GIFTKIND_LIMIT = GIFTKIND_GIVECNT THEN 1	"
	strSql = strSql & "		ELSE 0											"		
	strSql = strSql & "		END AS RESULT									"	
	strSql = strSql & "  FROM DB_EVENT.DBO.TBL_GIFT							"		
	strSql = strSql & " WHERE 1 = 1								"				
	strSql = strSql & " and EVT_CODE = 88942								"			
	'strSql = strSql & "   AND GIFT_CODE IN (17412, 17409)					"		'테스트
	strSql = strSql & "   AND GIFT_CODE IN (17451, 17448)					"		
	strSql = strSql & " ORDER BY GIFT_CODE DESC								"				
	
	rsget.CursorLocation = adUseClient
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
	
	if Not rsget.Eof Then
		    i = 0			
			do until rsget.eof
				isGiftSoldOutArr(i)	= rsget("result")
				i=i+1
				rsget.moveNext
			loop
	End If
	rsget.close

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.share {position:absolute; top:400px; left:50%; z-index:30; margin-left:410px; animation:bounce2 1s 100 ease-in-out;}
.share:before {display:inline-block; position:absolute; top:103px; left:0; z-index:5; width:160px; height:53px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_share_hand.png); content:' ';}
.share ul {overflow:hidden; position:absolute; top:90px; left:0; width:110px; padding:0 25px;}
.share ul li {float:left; width:50%;}
.share a {display:inline-block; position:absolute; top:90px; left:25px; z-index:7; width:53px; height:53px; text-indent:-999em;}
.share .twitter {left:80px;}
.evt88942 .inner-wrap{background:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/bg_jal.png') center top /cover no-repeat;position:relative;}
.evt88942 .inner-wrap:before,.evt88942 .inner-wrap:after{position:absolute;top:60px;left:calc(50% - 570px);content:'';display:block;width:1140px;height:289px;animation: twinkle 4s both ease-in-out infinite;}
@keyframes twinkle{
    0%{opacity:1}
    50%{opacity:0}
    80%{opacity:1}
}

.evt88942 {background-color:#7F2BCF;}
.evt88942 .inner-wrap:before{background-image:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/bg_star_02.png')}
.evt88942 .inner-wrap:after{background-image:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/bg_star_03.png');animation-delay: 2s;}
.evt88942 h2{padding-top:85px;position:relative;width:566px;height:339px;margin:0 auto 45px;}
.evt88942 h2:before,.evt88942 h2:after{position:absolute;content:'';display:block;width:21px;height:21px;background-image:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/bg_star_01.png');animation: twinkle 3s both cubic-bezier(0.79, -0.15, 0.1, 1.07) infinite;}
.evt88942 h2:before{top:180px;left:-180px}
.evt88942 h2:after{top:160px;right:-60px;animation-delay: 1.5s;}
.evt88942 .slide,.evt88942 .slidesjs-container{position:relative;margin:0 auto;height:602px !important;}
.evt88942 .slide{margin-bottom:25px}
.evt88942 .slidesjs-container{z-index:87}
.evt88942 .slide .slidesjs-previous,.evt88942 .slide .slidesjs-next{background:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_slide_prev.png') no-repeat 50% 0; width:49px; height:121px; text-indent:-999em;top:calc(50% - 25px);position:absolute;z-index:89 }
.evt88942 .slide .slidesjs-previous {left:calc(50% - 507px);}
.evt88942 .slide .slidesjs-next {right:calc(50% - 507px);transform:rotateY(180deg);}
.evt88942 .slide .slidesjs-pagination{display:none}
.evt88942 .prd{margin:55px auto 0;width:789px;padding-bottom:30px}
.evt88942 .prd img{margin:0 21px 80px}
.evt88942 .noti {padding:80px 0; background:#1f0d4d}
.evt88942 .noti .inner{width:1140px;margin:0 auto;}
.evt88942 .noti h3{display:table-cell;width:250px;vertical-align:middle;	}
.evt88942 .noti ul{display:table-cell;}
.evt88942 .noti ul li{color:#fff;text-align:left;line-height: 2em;font-size: 15px;font-family: 'malgunGothic', '맑은고딕', sans-serif;letter-spacing: -1px;position:relative}
.evt88942 .noti ul li:before{content:'-';display:inline-block;width:10px;position:absolute;left:-10px}
.evt88942 .noti ul li b{font-weight:bold}
.evt88942 .noti ul li a{background-color:#b124c2;display:inline-block;line-height: 22px;color: #fff;padding: 0 7px;margin-left: 10px;}
.evt88942 .noti ul li a:hover{text-decoration:none}
</style>
<script type="text/javascript">
$(function(){
	fnAmplitudeEventMultiPropertiesAction('view_17th_gift','','');
	/* slide js */
	$("#slide").slidesjs({
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000}}
	});
	
	});

	function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');		
		fnAmplitudeEventMultiPropertiesAction('click_17th_gift_sns','snstype','tw');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');		
		fnAmplitudeEventMultiPropertiesAction('click_17th_gift_sns','snstype','fb');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt"><!-- for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt -->
		<div id="contentWrap" style="padding-top:0;">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">

						<!-- 17주년 : 잘사고잘받자 -->
						<div class="evt88942 ten-life evt88942">
						
							<!-- #include virtual="/event/17th/nav.asp" -->							
							<div class="inner-wrap">
								<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/tit_evt88942.png" alt="잘 사고 잘 받자" /></h2>
								<div id="slide" class="slide">
                                    <div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_slide_01.png" alt="" /></div>
                                    <div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_slide_02.png" alt="" /></div>
                                    <div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_slide_03.png" alt="" /></div>
                                    <div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_slide_04.png" alt="" /></div>
                                </div>
                                <span><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/txt_01.png" alt="텐바이텐 배송상품을 포함하셔야 사은품 선택이 가능합니다!" /></span>
                                <div class="prd">
                                    <img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_prd_01.png" alt="5만원 이상 구매 시" />
									<% if isGiftSoldOutArr(0) = 0 then %>
										<a href="http://10x10.co.kr/shopping/category_prd.asp?itemid=1730435 "><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_prd_02.png" alt="20만원 이상 구매 시" /></a>						
									<% else %>						
										<img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_prd_02_soldout.png" alt="20만원 이상 구매 시" />						
									<% end if %>
									<% if isGiftSoldOutArr(1) = 0 then %>
										<a href="http://10x10.co.kr/shopping/category_prd.asp?itemid=2051029 "><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_prd_03.png" alt="100만원 이상 구매 시" /></a>						
									<% else %>					
										<img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/img_prd_03_soldout.png" alt="100만원 이상 구매 시" />	
									<% end if %>
                                </div>
							</div>
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88942/tit_notice.png" alt="유의사항" /></h3>
									<ul>
										<li>본 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 시, 증정 불가)</li>
                                        <li><b>텐바이텐 배송상품을 포함하여야 사은품 선택이 가능합니다.</b> <a href="http://www.10x10.co.kr/event/eventmain.asp?eventid=89269">텐바이텐 배송상품 보러가기 ></a></li>
                                        <li>쿠폰, 할인카드 등을 적용한 후 구매확정 금액이 5 / 20 / 100만원 이상이어야 합니다. (단일주문건 구매 확정액)</li>
                                        <li>마일리지, 예치금, 기프트카드를 사용하신 경우는 구매확정 금액에 포함되어 사은품을 받으실 수 있습니다.</li>
                                        <li>텐바이텐 기프트카드를 구매하신 경우는 사은품 증정이 되지 않습니다.</li>
                                        <li>마일리지는 차후 일괄 지급입니다. <br />( 1차 : 10월 24일 (~17일까지 주문내역 기준) / 2차 : 10월 31일 (~24일까지 주문내역 기준) / 3차 : 11월 7일 (~31까지 주문내역 기준) )</li>
                                        <li>환불이나 교환 시 최종 구매 가격이 사은품 수량 가능금액 미만이 될 경우, 사은품과 함께 반품해야 합니다.</li>
                                        <li>각 상품별 한정 수량이므로 조기에 소진될 수 있습니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- 17주년 : 잘사고잘받자 -->
					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
			<div class="share">
				<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_share.png" alt="" /></p>
				<ul>
					<li><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_fb.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_twitter.png" alt="" /></li>
				</ul>                                
				<a href="" class="fb" onclick="snschk('fb');return false;" >페이스북 공유</a>
				<a href="" class="twitter" onclick="snschk('tw');return false;" >트위터 공유</a>                                
			</div>  			
		</div>
	</div>

    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->