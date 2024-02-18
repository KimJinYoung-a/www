<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 텐바이텐 혜택가이드
' History : 2019-08-21 최종원 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/event/benefit/NewmemberAdvantageCls.asp" -->
<%
    dim themeClass : themeClass = "bg-white"
    if IsUserLoginOK then themeClass = "bg-pink"

    dim newmemberInfoObj, couponList, mileageEvtList, i, monthCoupon, couponMin


    set newmemberInfoObj = new NewmemberAdvantageCls
    couponList = newmemberInfoObj.getAutoCouponList()
    mileageEvtList = newmemberInfoObj.getMileageEvent()
	
    dim appDownCouponCode, alertMsg, currentDate, couponValue, couponType

    currentDate = date()
    'test
    'currentDate = Cdate("2020-12-07")

    IF application("Svr_Info") = "Dev" THEN
        appDownCouponCode = "2903"
    else
        appDownCouponCode = "1190"
    end if

	monthCoupon = getCouponInfo(appDownCouponCode)

	if IsArray(monthCoupon) then
		for i=0 to ubound(monthCoupon,2)
			couponValue = formatNumber(monthCoupon(1, i), 0)
			couponMin = formatNumber(monthCoupon(3, i), 0)
		next	
	end if

    couponType = "month"
	alertMsg = "쿠폰이 발급되었습니다!\nAPP에서 "& couponMin &"원 이상 구매 시 사용 가능합니다."
%>
<style type="text/css">
@import url(https://cdn.jsdelivr.net/npm/typeface-nanum-square@1.1.0/nanumsquare.min.css);
.benefit-guide {position:relative; overflow:hidden; font-family:'Nanum Square'; background-color:#fff; cursor:default;}
.benefit-guide button {font:inherit; background:inherit; color:inherit;}
.benefit-guide h3, .benefit-guide h4 {font:inherit;}
.benefit-guide .topic {position:relative; background-image:linear-gradient(to left, #ed007c, #ed0049);}
.benefit-guide .topic h2 {width:1140px; margin:0 auto; height:296px; font-size:0; color:transparent; background:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/tit_benefit.png) no-repeat 152px 73px / 836px auto;}
.benefit-guide .topic:after {content:' '; display:block; position:absolute; bottom:0; left:50%; width:1120px; height:1px; margin-left:-560px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/img_line.png) no-repeat 50% 0 / auto 100%;}

.benefit-guide section {position:relative;}
.benefit-guide .topic + section {padding-top:55px; padding-bottom:70px;}
.benefit-guide .bnf-extra {padding-bottom:20px;}
.benefit-guide .bg-pink {background-image:linear-gradient(to left, #ed007c, #ed0049);}
.benefit-guide .bg-white {padding-top:80px; background-color:#fff;}
.benefit-guide .bg-white + .bg-white {padding-top:105px;}
.benefit-guide .bg-white + .bg-white:before {content:' '; display:block; position:absolute; top:52px; left:50%; width:1120px; height:1px; margin-left:-560px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/img_line.png) no-repeat 50% 0 / auto 100%;}

.benefit-guide .tit-area, .benefit-guide .dsc-area {width:835px; margin:auto;}
.benefit-guide .tit-area {display:flex; align-items:baseline; margin-bottom:40px;}
.benefit-guide .bnf-now .tit-area {margin-bottom:50px;}
.benefit-guide .tit-area h3 {display:inline-block; margin-right:20px; font-weight:700; font-size:38px; border-bottom:2px solid; letter-spacing:-0.4px; line-height:1; padding-bottom:10px;}
.benefit-guide .bg-pink .tit-area h3 {color:#fff;}
.benefit-guide .bg-white .tit-area h3 {color:#222;}
.benefit-guide .tit-area p {display:inline-block; font-size:16px; letter-spacing:-0.2px;}
.benefit-guide .bg-pink .tit-area p {color:#ffc1da;}
.benefit-guide .bg-white .tit-area p {color:#888;}

.benefit-guide .dsc-area h4 {position:relative; padding-left:13px; margin-bottom:8px; font-weight:700; font-size:20px; text-align:left;}
.benefit-guide .bg-pink .dsc-area h4 {color:#fff;}
.benefit-guide .bg-white .dsc-area h4 {color:#444;}
.benefit-guide .dsc-area h4:before {content:' '; display:inline-block; position:absolute; left:0px; top:15px; width:3px; height:3px; border-radius:3px;}
.benefit-guide .bg-pink .dsc-area h4:before {background-color:#fff;}
.benefit-guide .bg-white .dsc-area h4:before {background-color:#444;}

.benefit-guide .list {overflow:hidden; display:flex; flex-flow:row wrap; margin:-20px -10px 0;}
.benefit-guide .list li {width:265px; padding:0 10px; margin-top:20px;}
.benefit-guide .list li.surprise {width:835px; padding-top:30px;}

.benefit-guide .box {display:flex; flex-direction:column; align-items:center; justify-content:center; width:265px; height:147px; background-repeat:no-repeat; background-position:50%; background-size:contain;}
.benefit-guide .bnf-join .box {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/cpn_white.png);}
.benefit-guide .bnf-now.bg-pink .box {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/btn_white.png);}
.benefit-guide .bnf-now.bg-white .box {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/btn_pink.png);}
.benefit-guide .bnf-now.bg-pink .btn-cpn {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/cpn_white.png);}
.benefit-guide .bnf-now.bg-white .btn-cpn {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/cpn_pink.png);}
.benefit-guide .bnf-extra .box {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/cpn_line_pink.png);}
.benefit-guide .bg-pink .surprise .box {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/cpn_line_white.png);}
.benefit-guide .bg-white .surprise .box {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/cpn_line_pink.png);}

.benefit-guide .box > span {display:block;}
.benefit-guide .box .amt {font-family:'AvenirNext-DemiBold','Roboto'; font-weight:bold; font-size:50px; line-height:1.3;}
.benefit-guide .bg-pink .box .amt {color:#222;}
.benefit-guide .bg-pink .surprise .box .amt {color:#fff;}
.benefit-guide .bg-white .box .amt {color:#fff;}
.benefit-guide .bg-white .surprise .box .amt {color:#222;}
.benefit-guide .box .amt em {margin-left:2px;}
.benefit-guide .box .won {font-family:'Noto Sans KR'; font-weight:normal; font-size:25px; vertical-align:6px;}
.benefit-guide .box .point {font-size:31px;}
.benefit-guide .box .txt-book {font-family:'AvenirNext-DemiBold','Roboto'; font-weight:bold; font-size:36px; line-height:1.17;}
.benefit-guide .bg-pink .box .txt-book {color:#222;}
.benefit-guide .bg-white .box .txt-book {color:#fff;}

.benefit-guide .btn-arr {display:block; height:44px; margin:15px auto 0; font-size:15px; line-height:44px; background-color:#222; color:#fff; text-decoration:none;}
.benefit-guide .bnf-join .btn-arr {width:402px; height:79px; margin-top:30px; font-size:24px; font-weight:700; line-height:80px;}
.benefit-guide .bnf-extra .btn-arr {width:402px;}
.benefit-guide .bnf-now.bg-white .btn-arr {background-color:#fff; color:#888; border:2px solid #c2c2c2; -webkit-box-sizing:border-box; box-sizing:border-box;}
.benefit-guide .bnf-now .surprise .btn-arr {width:402px; background-color:#222; color:#fff; border:0;}
.benefit-guide .btn-arr span {position:relative; padding-right:6.5%;}
.benefit-guide .btn-arr span:after {content:' '; display:inline-block; position:absolute; right:0; top:50%; width:6px; height:6px; border-width:2px 2px 0 0; border-style:solid; transform:translateY(-60%) rotate(45deg);}
.benefit-guide .bnf-join .btn-arr span:after {width:10px; height:10px;}

.benefit-guide .bot-txt {padding-top:8px; font-size:13px;}
.benefit-guide .bg-pink .bot-txt {color:#ffc1da;}
.benefit-guide .bg-white .bot-txt {color:#c2c2c2;}
.benefit-guide .bot-txt-b {padding-top:12px; font-size:16px; font-weight:bold;}
.benefit-guide .bg-pink .bot-txt-b {color:#fff;}
.benefit-guide .bg-white .bot-txt-b {color:#444;}

.benefit-guide .bnf-extra .txt-extra {font-weight:700; font-size:32px; color:#222;}
.benefit-guide .txt-info {font-family:'Roboto','Noto Sans KR'; font-size:16px; color:#999;}
.benefit-guide .bnf-now.bg-white .txt-info {color:#fff;}
.benefit-guide .bnf-now.bg-pink .txt-info {color:#222;}
.benefit-guide .bnf-now.bg-white .surprise .txt-info {color:#999;}
.benefit-guide .bnf-now.bg-pink .surprise .txt-info {color:#3d0019;}

.benefit-guide .txt-down {padding:0 2px 0 5px; font-size:15px; border-bottom:1px solid;}
.benefit-guide .bg-pink .txt-down {color:#888;}
.benefit-guide .bg-white .txt-down {color:#3d0019;}
.benefit-guide .txt-down:after {content:' '; display:inline-block; width:16px; height:16px; margin-left:5px; vertical-align:text-top; background:url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/ico_down.png) no-repeat 50% 0 / 100% auto;}
.benefit-guide .bg-pink .txt-down:after {background-position-y:100%;}
</style>
<script>
    function jsEvtCouponDown(stype,idx) {
        <% If IsUserLoginOK() Then %>
            fnAmplitudeEventMultiPropertiesAction("click_advtg_appcoupondown","","");
            $.ajax({
                type: "POST",
                url: "/event/etc/coupon/couponshop_process.asp",
                data: "mode=cpok&stype="+stype+"&idx="+idx,
                dataType: "text",
                success: function(message) {
                    if(message) {
                        var str1 = message.split("||")                        
                        if (str1[0] == "11"){
                            alert('<%=alertMsg%>');
                            return false;
                        }else if (str1[0] == "12"){
                            alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
                            return false;
                        }else if (str1[0] == "13"){
                            alert('이미 다운로드 받으셨습니다.');
                            return false;
                        }else if (str1[0] == "02"){
                            alert('로그인 후 쿠폰을 받을 수 있습니다!');
                            return false;
                        }else if (str1[0] == "01"){
                            alert('잘못된 접속입니다.');
                            return false;
                        }else if (str1[0] == "00"){
                            alert('정상적인 경로가 아닙니다.');
                            return false;
                        }else{
                            alert('오류가 발생했습니다.');
                            return false;
                        }
                    }
                }
            })
        <% Else %>
		if(confirm("로그인을 하셔야 쿠폰발급이 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G&backpath=<%=Server.URLencode("/event/benefit/")%>";
			return false;
		}
		return false;
        <% End IF %>
    }
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt"><!-- for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt -->
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">

						<!-- 텐바이텐 혜택 가이드 -->
						<div class="benefit-guide">
							<div class="topic"><h2>텐바이텐 혜택 가이드</h2></div>

							<!-- for dev msg : 로그인 시, 가입혜택 은 노출되지 않고 지금혜택 부터 노출 (지금혜택 에 클래스 bg-white 대신 bg-pink) -->
							<!-- 가입혜택 -->
                            <% if Not(IsUserLoginOK) Then %>
							<section class="bnf-join bg-pink">
								<div class="tit-area">
									<h3>#가입혜택</h3>
									<p>새로 가입한 고객님을 위해 웰컴 쿠폰세트를 준비했어요</p>
								</div>
								<div class="dsc-area">
									<ul class="list">
										<li>
											<div class="box">
												<span class="amt">5,000<em class="won">원</em></span>
												<span class="txt-info">70,000원 이상 구매 시</span>
											</div>
										</li>
										<li>
											<div class="box">
												<span class="amt">10,000<em class="won">원</em></span>
												<span class="txt-info">150,000원 이상 구매 시</span>
											</div>
										</li>
										<li>
											<div class="box">
												<span class="amt">30,000<em class="won">원</em></span>
												<span class="txt-info">300,000원 이상 구매 시</span>
											</div>
										</li>
									</ul>
									<!-- <a href="https://tenten.app.link/getQqS6CSX" onclick="fnAmplitudeEventMultiPropertiesAction('click_advtg_signup_btn','','');" class="btn-arr"><span>회원가입 하러 가기</span></a> -->
                                    <a href="/member/join.asp" class="btn-arr"><span>회원가입 하러 가기</span></a>
                                </div>
							</section>
                            <% end if %>
							<!--// 가입혜택 -->

							<%'<!-- for dev msg : 로그인 시, 가입혜택 은 노출되지 않고 지금혜택 부터 노출 (지금혜택 에 클래스 bg-white 대신 bg-pink) -->%>
							<!-- 지금혜택 -->
							<section class="bnf-now <%=themeClass%>">
								<div class="tit-area">
									<h3>#지금혜택</h3>
									<p>지금 사용 가능한 모든 혜택, 여기서 확인해 보세요!</p>
								</div>
								<div class="dsc-area">
									<ul class="list">
                                        <!-- 혜택가이드 기간 내 배너 노출 -->
                                        <!-- 2020-11-29 23:59:59 까지 -->
                                        <% If currentDate <= #11/29/2020 23:59:59# Then %>
                                            <%' 마케팅 마일리지 예산 이슈로 2020년 2월 / 3월 app 전용 쿠폰 숨김처리 이후 주석만 풀어주면 됨 2020-03-16 마케팅 요청 주석품%>
                                            <li>
                                                <%'<!-- for dev msg : '8' 텍스트 매월 1일 00:00 자동 변경 (쿠폰명에도 자동 추가) -->%>
                                                <h4><%=Month(Date())%>월 APP 전용 쿠폰</h4>
                                                <%'<!-- for dev msg : 쿠폰 다운받기 버튼 (비로그인 시 로그인페이지) -->%>
                                                <button type="button" class="box btn-cpn" onclick="jsEvtCouponDown('<%=couponType%>','<%= appDownCouponCode %>')">
                                                    <span class="amt"><%=couponValue%><em class="won">원</em></span>
                                                    <span class="txt-down">쿠폰 다운받기</span>
                                                </button>
                                                <a href="/event/appdown/" onclick="fnAmplitudeEventMultiPropertiesAction('click_advtg_install_btn','','');" class="btn-arr"><span>APP 설치하러 가기</span></a>
                                            </li>
                                            <li>
                                                <h4>상품 쿠폰북</h4>
                                                <!-- for dev msg : 쿠폰북 링크 -->
                                                <div class="box">
                                                    <span class="txt-book">COUPON<br>BOOK</span>
                                                </div>
                                                <a href="/shoppingtoday/couponshop.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_advtg_couponbook_btn', '', '')" class="btn-arr"><span>쿠폰북 확인하기</span></a>
                                            </li>
                                            <li>
                                                <h4>차이 생애 첫 결제할인</h4>
                                                <div class="box">
                                                    <span class="txt-info">6천 원 이상 생애 첫 결제 시</span>
                                                    <span class="amt">50<em>%</em></span>
                                                    <span class="txt-info">(최대 3천 원)</span>
                                                </div>
                                                <p class="bot-txt-b">결제 시 2.5% 적립</p>
                                            </li>
                                            <li>
                                                <h4>신한카드x텐바이텐 혜택</h4>
                                                <div class="box">
                                                    <span class="txt-info">신한 체크카드 발급 시</span>
                                                    <span class="txt-info fs12">(신규 고객 대상)</span>
                                                    <span class="amt" style="line-height:1.2;">10,000<em class="point">P</em></span>
                                                    <span class="txt-info fs12">* 신한카드 Deep Dream 체크(미니언즈)</span>
                                                </div>
                                                <a href="/event/eventmain.asp?eventid=106761" target="_blank" class="btn-arr">
                                                    <span>자세히 보러 가기</span>
                                                </a>
                                            </li>
                                        <% End If %>
                                        <!-- 2020-11-30 00:00:00 부터 2020-12-06 23:59:59 까지 -->
                                        <% If currentDate >= #11/30/2020 00:00:00# and currentDate <= #12/06/2020 23:59:59# Then %>
                                            <li>
                                                <h4>텐바이텐x포커스미디어 혜택</h4>
                                                <button type="button" class="box btn-cpn" onclick="fnNewCouponIssued('107973','1507'); return false;">
                                                    <span class="amt">3,000<em class="won">원</em></span>
                                                    <span class="txt-down">쿠폰 다운받기</span>
                                                </button>
                                            </li>
                                        <% End If %>
                                        <!-- 2020-12-07 00:00:00 부터 -->
                                        <% If currentDate >= #12/07/2020 00:00:00# Then %>
                                            <li>
                                                <%'<!-- for dev msg : '8' 텍스트 매월 1일 00:00 자동 변경 (쿠폰명에도 자동 추가) -->%>
                                                <h4><%=Month(Date())%>월 APP 전용 쿠폰</h4>
                                                <%'<!-- for dev msg : 쿠폰 다운받기 버튼 (비로그인 시 로그인페이지) -->%>
                                                <button type="button" class="box btn-cpn" onclick="jsEvtCouponDown('<%=couponType%>','<%= appDownCouponCode %>')">
                                                    <span class="amt"><%=couponValue%><em class="won">원</em></span>
                                                    <span class="txt-down">쿠폰 다운받기</span>
                                                </button>
                                                <a href="/event/appdown/" onclick="fnAmplitudeEventMultiPropertiesAction('click_advtg_install_btn','','');" class="btn-arr"><span>APP 설치하러 가기</span></a>
                                            </li>
                                            <li>
                                                <h4>상품 쿠폰북</h4>
                                                <!-- for dev msg : 쿠폰북 링크 -->
                                                <div class="box">
                                                    <span class="txt-book">COUPON<br>BOOK</span>
                                                </div>
                                                <a href="/shoppingtoday/couponshop.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_advtg_couponbook_btn', '', '')" class="btn-arr"><span>쿠폰북 확인하기</span></a>
                                            </li>
                                            <li>
                                                <h4>차이 생애 첫 결제할인</h4>
                                                <div class="box">
                                                    <span class="txt-info">6천 원 이상 생애 첫 결제 시</span>
                                                    <span class="amt">50<em>%</em></span>
                                                    <span class="txt-info">(최대 3천 원)</span>
                                                </div>
                                                <p class="bot-txt-b">결제 시 2.5% 적립</p>
                                            </li>
                                            <!-- <li>
                                                <h4>신한카드x텐바이텐 혜택</h4>
                                                <div class="box">
                                                    <span class="txt-info">신한 체크카드 발급 시</span>
                                                    <span class="txt-info fs12">(신규 고객 대상)</span>
                                                    <span class="amt" style="line-height:1.2;">10,000<em class="point">P</em></span>
                                                    <span class="txt-info fs12">* 신한카드 Deep Dream 체크(미니언즈)</span>
                                                </div>
                                                <a href="/event/eventmain.asp?eventid=106761" target="_blank" class="btn-arr">
                                                    <span>자세히 보러 가기</span>
                                                </a>
                                            </li> -->
                                            <!-- <li>
                                                <h4>텐바이텐x포커스미디어 혜택</h4>
                                                <button type="button" class="box btn-cpn" onclick="fnNewCouponIssued('107973','1507'); return false;">
                                                    <span class="amt">3,000<em class="won">원</em></span>
                                                    <span class="txt-down">쿠폰 다운받기</span>
                                                </button>
                                            </li> -->
                                        <% End If %>
                                        <!-- // -->
										
<%
    if isArray(mileageEvtList) then
        for i=0 to uBound(mileageEvtList,2)
%>
										<li>
											<h4>마일리지</h4>
											<%'<!-- for dev msg : '3,333' 텍스트, 사용기한, 링크 시스템 자동 변경 -->%>
											<div class="box">
												<span class="amt"><%=FormatNumber(mileageEvtList(3,i), 0)%><em class="point">M</em></span>
											</div>
                                            <a href="/event/eventmain.asp?eventid=<%=mileageEvtList(0,i)%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_advtg_mileage_evt','','')" target="_blank" class="btn-arr">
											    <span>마일리지 확인하기</span>
                                            </a>
                                            <p class="bot-txt">* 사용기한 : <%=formatDate(mileageEvtList(1,i),"00.00")%> - <%=formatDate(mileageEvtList(2,i),"00.00")%> (<%=mileageEvtList(4,i)%>일간)</p>
										</li>
<%
        next
    end if
%>
									

<% If currentDate >= #09/01/2020 00:00:00# and currentDate <= #09/30/2020 23:59:59# Then %>
										<li>
											<h4>토스 즉시 할인</h4>
											<div class="box">
												<span class="txt-info">7만 원 이상 결제 시</span>
												<span class="amt">5,000<em class="won">원</em></span>
											</div>
										</li>
<% End If %>

<% If currentDate >= #10/05/2020 00:00:00# and currentDate <= #10/07/2020 23:59:59# Then %>
										<li>
											<h4>신한카드 즉시 할인</h4>
											<div class="box">
												<span class="txt-info">4만 원 이상 결제 시</span>
												<span class="amt">3,000<em class="won">원</em></span>
											</div>
										</li>
<% End If %>

<% If currentDate >= #10/12/2020 00:00:00# and currentDate <= #10/18/2020 23:59:59# Then %>
										<li>
											<h4>카카오페이 즉시 할인</h4>
											<div class="box">
												<span class="txt-info">5만 원 이상 결제 시</span>
												<span class="amt">3,000<em class="won">원</em></span>
											</div>
										</li>
<% End If %>

<% If currentDate >= #10/19/2020 00:00:00# and currentDate <= #10/25/2020 23:59:59# Then %>
										<li>
											<h4>차이 즉시 할인</h4>
											<div class="box">
												<span class="txt-info">4만 원 이상 결제 시</span>
												<span class="amt">3,000<em class="won">원</em></span>
											</div>
										</li>
<% End If %>

										<!--li>
											<h4>BC카드 즉시 할인</h4>
											<div class="box">
												<span class="txt-info">5만 원 이상 결제 시</span>
												<span class="amt">5,000<em class="won">원</em></span>
											</div>
										</li-->

										<%'<!-- for dev msg : 쿠폰 기간내 자동 노출 (쿠폰 이벤트를 진행하지 않는 기간엔 ‘서프라이즈 쿠폰’ 영역 자체가 노출되지 않음 -->%>
										<!-- 서프라이즈 쿠폰 -->
<%
    if isArray(couponList) then
    dim sdt : sdt = formatDate(couponList(3,0),"00.00")
    dim edt : edt = formatDate(couponList(4,0),"00.00")
    dim restDt : restDt = couponList(5,0)
%>
										<li class="surprise">
											<h4>서프라이즈 쿠폰</h4>
											<ul class="list">
<%
        for i=0 to uBound(couponList,2)
%>
												<li>
													<div class="box">
														<span class="amt"><%=FormatNumber(couponList(1,i), 0)%><em class="won"><%=chkiif(couponList(6,i) = 1,"%","원")%></em></span>
														<span class="txt-info"><%=FormatNumber(couponList(2,i), 0)%>원 이상 구매 시</span>
													</div>
												</li>
<%
        next
%>
											</ul>
											<!-- for dev msg : 내 쿠폰함 링크 (기획서에 쿠폰북으로 잘못 기재) (비로그인 시 로그인페이지) -->
											<a href="/my10x10/couponbook.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_advtg_mycoupon_btn', '', '')" class="btn-arr"><span>쿠폰 확인하기</span></a>
                                            <p class="bot-txt">* 사용 기간 : <%=sdt%> - <%=edt%> (<%=restDt%>일간)<br>* 로그인 시 자동 발급되는 쿠폰입니다.</p>
										</li>
<%
    end if
%>                                        
										<!--// 서프라이즈 쿠폰 -->
									</ul>
								</div>
							</section>
							<!--// 지금혜택 -->
							<!-- 추가혜택 -->
							<section class="bnf-extra bg-white">
								<div class="tit-area">
									<h3>#추가혜택</h3>
									<p>텐바이텐에서 누릴 수 있는 또 다른 혜택, 놓치지 마세요</p>
								</div>
								<div class="dsc-area">
									<ul class="list">
										<li>
											<div class="box">
												<span class="txt-extra">마일리지 적립</span>
												<span class="txt-info">주문금액의 최대 1.3%</span>
											</div>
										</li>
										<li>
											<div class="box">
												<span class="txt-extra">무료 배송</span>
												<span class="txt-info">30,000원 이상 구매 시</span>
											</div>
										</li>
										<li>
											<div class="box">
												<span class="txt-extra">생일 쿠폰</span>
												<span class="txt-info">1주일 전에 자동 발행</span>
											</div>
										</li>
									</ul>
									<!-- for dev msg : 등급별 혜택 링크 (비로그인 시 로그인페이지) -->
									<a href="/cscenter/membershipGuide/" class="btn-arr"><span>등급별 혜택 확인하기</span></a>
								</div>
							</section>
							<!--// 추가혜택 -->
						</div>
						<!--// 텐바이텐 혜택 가이드 -->

					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->