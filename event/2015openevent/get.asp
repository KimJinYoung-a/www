<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  2015오픈이벤트 - 쫄깃한 득템! 텐바이텐 핫 딜 - 이 기적 쇼핑!
' History : 2015.04.10 허진원 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 사월의 꿀 맛 - 이 기적 쇼핑!"		'페이지 타이틀 (필수)
	strPageDesc = "당신의 달콤한 쇼핑 라이프를 위해! 사월의 꿀 맛. 쫄깃한 득템! 텐바이텐 핫 딜 - 이 기적 쇼핑!"		'페이지 설명
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2015/60832/m/txt_get.png"		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/event/2015openevent/get.asp"			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* 2015 open event common style */
#eventDetailV15 .gnbWrapV15 {height:38px;}
#eventDetailV15 #contentWrap {padding-top:0; padding-bottom:127px;}
.eventContV15 .tMar15 {margin-top:0;}
.aprilHoney {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_wave.png) repeat-x 50% 0;}
.honeyHead {position:relative; width:1140px; margin:0 auto; text-align:left;}
.honeyHead .hgroup {position:absolute; top:22px; left:0;}
.honeyHead .hgroup p {visibility:hidden; width:0; height:0;}
.honeyHead ul {overflow:hidden; width:656px; margin-left:484px;}
.honeyHead ul li {float:left; width:131px;}
.honeyHead ul li.nav5 {width:132px;}
.honeyHead ul li a {overflow:hidden; display:block; position:relative; height:191px; font-size:11px; line-height:191px; text-align:center;}
.honeyHead ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_nav_12pm.png) no-repeat 0 0;}
.honeyHead ul li.nav1 a:hover span {background-position:0 -191px;}
.honeyHead ul li.nav2 a span {background-position:-131px 0;}
.honeyHead ul li.nav2 a:hover span {background-position:-131px -191px;}
.honeyHead ul li.nav2 a.on span {background-position:-131px 100%;}
.honeyHead ul li.nav3 a span {background-position:-262px 0;}
.honeyHead ul li.nav3 a:hover span {background-position:-262px -191px;}
.honeyHead ul li.nav3 a.on span {background-position:-262px 100%;}
.honeyHead ul li.nav4 a span {background-position:-393px 0;}
.honeyHead ul li.nav4 a:hover span {background-position:-393px -191px;}
.honeyHead ul li.nav4 a.on span {background-position:-393px 100%;}
.honeyHead ul li.nav5 {position:relative;}
.honeyHead ul li.nav5 a span {background-position:100% 0;}
.honeyHead ul li.nav5 a:hover span {background-position:100% -191px;}
.honeyHead ul li.nav5 a.on span {background-position:100% 100%;}
.honeyHead ul li.nav5 .hTag {position:absolute; top:9px; left:77px;}
.honeyHead ul li.nav5:hover .hTag {-webkit-animation-name: bounce; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name: bounce; -moz-animation-iteration-count: infinite; -moz-animation-duration:0.5s; -ms-animation-name: bounce; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function: ease-out;}
	50% {margin-top:8px; -webkit-animation-timing-function: ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function: ease-out;}
	50% {margin-top:8px; animation-timing-function: ease-in;}
}
.honeySection {padding-top:70px; background-color:#fff;}

/* 사은이벤트 */
#eventDetailV15 #contentWrap {padding-bottom:0;}
.honeyGet {background:url(http://webimage.10x10.co.kr/eventIMG/2015/60832/bg_pattern_01.png) repeat 50% 0;}
.honeyGet .topic {position:relative; width:1140px; margin:0 auto; padding-bottom:70px;}
.honeyGet .topic .time {position:relative; width:385px; margin:0 auto; padding-left:8px;}
.honeyGet .topic .time span {position:absolute; bottom:0; left:0;}
.honeyGet .topic .giftbox {position:absolute; top:50px; left:542px;}
.brandbox {width:1066px; margin:0 auto; padding-bottom:50px;}
.schedule {padding-top:62px; padding-bottom:88px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60832/bg_pattern_02.png) repeat 50% 0;}
.schedule .inner {width:1140px; margin:0 auto;}
.schedule .timetable {overflow:hidden; width:948px; height:464px; margin:45px auto 0; padding:36px 49px 0; background:#faf8f7 url(http://webimage.10x10.co.kr/eventIMG/2015/60832/bg_dashed_line.png) no-repeat 50% 251px;}
.schedule .timetable li {float:left; padding-bottom:49px; text-align:center;}
.schedule .timetable li span {display:block; margin-left:-2px;}

.noti {padding-top:58px; padding-bottom:80px; border-top:5px solid #ffc2b1; background-color:#fffaeb;}
.noti .inner {width:1140px; margin:0 auto; text-align:left;}
.noti ul {overflow:hidden; padding-top:33px;}
.noti ul li {float:left; width:544px; margin-top:4px; padding-left:26px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60832/blt_circle_pink.png) no-repeat 0 6px; color:#555; font-size:11px; line-height:1.75em;}
/* css3 animation */
.animated {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-fill-mode:both; animation-fill-mode:both;}
@-webkit-keyframes fadeIn {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes fadeIn {
	0% {opacity:0;}
	100% {opacity:1;}
}
.fadeIn {-webkit-animation-name:fadeIn; animation-name:fadeIn; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
/* Bounce animation */
@-webkit-keyframes updown {
	0%, 20%, 50%, 60%, 80%, 100% {-webkit-transform: translateY(0);}
	40% {-webkit-transform: translateY(-20px);}
	60% {-webkit-transform: translateY(-15px);}
}
@keyframes updown {
	0%, 20%, 50%, 60%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-20px);}
	60% {transform: translateY(-15px);}
}
.updown {-webkit-animation-duration:5s; animation-duration:5s; -webkit-animation-name:updown; animation-name:updown; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
</style>
<script type="text/javascript">
$(function(){
	function moveFlower () {
		$(".honeyHead .hgroup h2").animate({"margin-top":"0"},1000).animate({"margin-top":"3px"},1000, moveFlower);
	}
	//moveFlower();
	fnGetGetHoneyVeiw('','');
});

function fnGetGetHoneyVeiw(dd,sd) {
	$.ajax({
		type:"POST",
		url: "act_getHoneyView.asp",
		data: "tgd="+dd+"&sold="+sd,
		cache: false,
		success: function(message) {
			$("#lyrGetHoney").html(message);
			if(dd!="") {
				$('html,body').animate({scrollTop: $("#lyrGetHoney").offset().top},'fast');
			}
		}
		,error: function(err) {
			alert(err.responseText);
		}
	});
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW tMar15">
						<!-- 2015 RENEWAL 사월의 꿀 맛 -->
						<div class="aprilHoney">
							<!-- #include virtual="/event/2015openevent/inc_header.asp" --> 

							<!-- 쫄깃한 득템! -->
							<div class="honeySection honeyGet">
								<div class="topic">
									<p class="time">
										<!--<span class="animated fadeIn"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/txt_three.png" alt="매일 오후 3시" /></span>-->
										<span class="animated fadeIn"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/txt_12pm.png" alt="매일 정오 12시" /></span>
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/txt_time.png" alt="가장 착한 가격 &amp; 다신 없을 구성" />
									</p>
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/tit_get.png" alt="쫄깃한 득템" /></h3>
									<span class="giftbox animated updown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_box.png" alt="" /></span>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/txt_everyday.png" alt="매일, 최고의 브랜드를 가장 좋은 가격에 누구보다 빠르게 만나보세요!" /></p>
								</div>

								<div id="lyrGetHoney"></div>
								<!-- schedule -->
								<%
									'// 오늘 날짜 설정
									dim nowDay: nowDay = cStr(day(date))
									'if nowDay<13 then nowDay = "13"
									'if nowDay>24 then nowDay = "24"
									''nowDay = "26"

									'// 날짜별 브랜드명 설정
									dim arrMkNm
									arrMkNm = split("roomet,iriver,snurk,coleman,bomann,fashionbox,instax,playmobil,mybeans,lamy,method,iconic",",")

									'// 이벤트 상품 재고여부 확인 (날짜순서와 상품코드 순서가 같음※)
									dim sqlstr, arrIsSoldout(12), i, vRIcon
									sqlstr = "select itemid "
									sqlstr = sqlstr & "	, Case when sellyn='Y' and ((limityn='Y' and limitno>limitsold) or limityn='N') then 'N' else 'Y' end as soldyn "
									sqlstr = sqlstr & "from db_item.dbo.tbl_item "

									IF application("Svr_Info") = "Dev" THEN
										sqlstr = sqlstr & "where itemid in (1239205,1239115,1232978,1234671,1239177,1239176,1239175,1239174,1239173,1239172,1239171,1239170) "
									else
										sqlstr = sqlstr & "where itemid in (1250336,1250337,1250338,1250339,1250340,1250341,1250342,1250343,1250344,1250345,1250346,1250347) "
									end if

									sqlstr = sqlstr & "order by itemid asc"

									rsget.Open sqlstr,dbget
									IF not rsget.EOF THEN
										i = 0
										Do Until rsget.EOF
											arrIsSoldout(i) = rsget("soldyn")
											rsget.MoveNext
											i = i+1
										Loop
									end if
									rsget.Close
								%>
								<div class="schedule">
									<div class="inner">
										<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/tit_schedule.png" alt="쫄깃하게 득템할 스케줄" /></h4>
										<ul class="timetable">
										<%
											'// 일정 아이콘 출력
											' (tab_브랜드_속성.png : 오늘 today / 판매완료 soldout / 진행중 ing / 진행예정 coming (투데이 다음날) / 디폴트 off)
											for i=0 to 11
												vRIcon = "<li>"

												'# 일자
												if nowDay=cStr(i+13) then
													vRIcon = vRIcon & "<span><img src=""http://webimage.10x10.co.kr/eventIMG/2015/60832/tab_april_today.png"" alt=""4월 " & (i+13) & "일"" /></span>"
												else
													vRIcon = vRIcon & "<span><img src=""http://webimage.10x10.co.kr/eventIMG/2015/60832/tab_april_" & (i+13) & ".png"" alt=""4월 " & (i+13) & "일"" /></span>"
												end if

												'# 브랜드 이미지
												'vRIcon = vRIcon & "<em>"
												
												if cInt(nowDay)>=(i+12) then
													vRIcon = vRIcon & "<em><img src=""http://webimage.10x10.co.kr/eventIMG/2015/60832/tab_" & arrMkNm(i) & "_"

													if nowDay=cStr(i+13) then
														if hour(now)>=12 then		'12시 OPEN
															if arrIsSoldout(i)="Y" then
																vRIcon = vRIcon & "soldout"
															else
																vRIcon = vRIcon & "today"
															end if
														else
															vRIcon = vRIcon & "coming"
														end if
													elseif nowDay=cStr(i+12) then
														vRIcon = vRIcon & "coming"
													elseif arrIsSoldout(i)="Y" then
														vRIcon = vRIcon & "soldout"
													else
														vRIcon = vRIcon & "ing"
													end if

													vRIcon = vRIcon & ".png"" alt=""4월 " & (i+13) & "일"""
													if cInt(nowDay)>=(i+13) then
														vRIcon = vRIcon & " onclick=""fnGetGetHoneyVeiw(" & i+13 & ",'" & arrIsSoldout(i) & "')"" style=""cursor:pointer;"""
													end if

													vRIcon = vRIcon & " /></em>"
												else
													vRIcon = vRIcon & "<em><img src=""http://webimage.10x10.co.kr/eventIMG/2015/60832/tab_off.png"" alt=""준비중"" /></em>"
												end if

												vRIcon = vRIcon & "</li>" & vbCrLf

												Response.Write vRIcon
											next
										%>
										</ul>
									</div>
								</div>
								<!-- Notice -->
								<div class="noti">
									<div class="inner">
										<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/tit_noti.png" alt="이벤트 유의사항" /></h4>
										<ul>
											<li>텐바이텐 고객님을 위한 이벤트 입니다. (비회원 참여 불가)</li>
											<li>한정수량으로 실시간 결제로만 구매할 수 있습니다.</li>
											<li>상품은 결제순으로 판매/배송 처리 되며, 초과될 경우 결제순으로 환불처리 됩니다.</li>
											<li>상품 정보 및 교환/환불 정책은 상품의 상세 페이지를 반드시 확인해주시기 바랍니다.</li>
										</ul>
									</div>
								</div>

							</div>
						</div>
						

						<!--// 2015 RENEWAL 사월의 꿀 맛 -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->