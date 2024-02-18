<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  17주년 md's pick
' History : 2018-10-12 최종원 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
dim eCode

IF application("Svr_Info") = "Dev" THEN
	eCode = "89178"
Else
	eCode = "89541"
End If

dim specialItemCode, landingUrl
dim brandName, brandCopy, brandItemCode, brandUrl

Dim baseDt: baseDt = date & " " & Num2Str(Hour(now),2,"0","R") & ":" & Num2Str(Minute(now),2,"0","R") & ":" & Num2Str(Second(now),2,"0","R")
%>
<style type="text/css">
.evt89541{background-color:#e13ea9;}
.evt89541 *{box-sizing: border-box;text-align:center;}
.evt89541 .blind{opacity:0;}
.evt89541 .today{background:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/tit_today_v01.png') top center; height:1320px; position:relative;}
.evt89541 .today h2{width:100%; height:300px; padding-top:100px; margin:0 auto 30px;}
.evt89541 .today .rate{font-family:'roboto','AppleSDGothicNeo-Bold','malgun gothic'; font-weight:bold; font-size:54px; color:#fff; text-shadow: -2px 0 #000, 0 2px #000, 2px 0 #000, 0 -2px #000, 4px 4px #000; position:absolute;left:calc(50% + 226px); top:393px; width: 130px; text-align: center; display: block; height: 66px; line-height: 66px; letter-spacing: -2px;}
.evt89541 .today .today-main{width:100%; height:520px; text-align:center; display:block;margin: 32px -2px 0;}
.evt89541 .today ul li{font-family: 'appleSDGothicBold','malgun gothic',sans-serif;font-weight:bold;color:#000;line-height: 1.7em;}
.evt89541 .today ul li.day {letter-spacing:2px;font-size:20px; margin-top: -4px;}
.evt89541 .today ul li.name {font-size:23px; margin-top:1em; letter-spacing: -1px;}
.evt89541 .today ul li.ex-price {font-size:18px; font-weight:normal; display:inline-block; position:relative; padding:0 5px; margin-right:10px;}
.evt89541 .today ul li.ex-price:after{content:'';position:absolute;width:100%;background-color:#000;height:1px; top:50%; left:0;}
.evt89541 .today ul li.price {font-size:22px; display:inline-block;}
.evt89541 .today ol{position:absolute; top:1047px; width:100%;}
.evt89541 .brand{background:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/bg_brand_v01.png') top center; height:703px; position:relative; padding-top:107px;}
.evt89541 .brand span img{margin: -12px 20px 0 0}
.evt89541 .brand ul{position: absolute; width: 1015px; height: 512px; left: calc(50% - 508px); top: 96px;}
.evt89541 .brand li{width:300px; display:inline-block; margin:357px 33px 0  12px; float: left;}
.evt89541 .brand li:last-child{margin-right: 0;}
.evt89541 .brand li p,
.evt89541 .brand li span {font-family:'roboto','malgun gothic',sans-serif; font-weight:bold;}
.evt89541 .brand li p {font-size:20px; line-height:50px; margin-top:10px;}
.evt89541 .brand li span {color:#f836b7;font-size:53px; line-height:0.7em;}
.evt89541 .brand li span i {font-style:normal; font-size:30px; margin-left:-10px;}
.evt89541 .brand li a {width:185px; height:40px; display:block; margin:17px auto 0; opacity:0;}
.layer {position:fixed; left:50% !important; top:50% !important; z-index:99999; background-color:#f4f5fb; border-radius:20px; box-shadow:0 0 50px 50px rgba(0,0,0,.1);}
.layer .btn-close {position:absolute; right:24px; top:27px; background-color:transparent;}
.layer-schedule {width:930px; height:834px; margin:-417px 0 0 -465px;}
.layer-schedule h3{padding:65px 0; text-align:center;}
.layer-schedule .calendar .week{display: block; text-align: center;}
.layer-schedule .calendar ul{text-align:left; margin:15px 0 0 56px;}
.layer-schedule .calendar li{display: inline-block; position:relative; margin:5px;}
.layer-schedule .calendar li p{color:#000; font-family:'roboto','malgun gothic',sans-serif; font-size:16px; border-bottom:1px solid #000; display: inline-block; font-weight:bold; position:absolute; top:10px; left:10px; line-height:1.4em;}
.layer-schedule .calendar li.soldout:after {content:''; background-image:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_end.png'); width:150px; height:167px; top:0; left:0; position:absolute; }
.layer-schedule .calendar li.now:after {content:''; background-image:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_today.png'); width:176px; height:193px; top:-8px; left:-13px; position:absolute; }
.layer-schedule .calendar li.comming {width:150px; height:167px; background-image:url('http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_soon.png');}
.layer-schedule .calendar li img{display:block;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script style="text/javascript">
$(function(){	
	// 일정보기 스크롤
	$('.btn-schedule').click(function(){
		$('.scrollbarwrap').tinyscrollbar();
	});
});
</script>
<script type="text/javascript" src="/event/etc/json/js_89541.js"></script>
						<!-- 17주년 MD 이벤트 : 오늘의 특가 -->
						<div class="evt89541">
						<!-- #include virtual="/event/17th/nav.asp" -->	
							<div class="today" id="today">
								<h2 class="blind">할인 이벤트 오늘의 특가</h2>
								<p class="blind">매일 달라지는 화제의 상품을 최저가로 만나보세요</p>
								<span class="today-main"><!-- 투데이 상품 이미지 : 파일명 날짜만 변경--><img src="" alt="투데이 상품" /></span>
								<span class="rate"></span>
								<ul>
									<li class="day">
										<span id="todayImg"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_main_date_today.png?v=0.01" alt="today"></span>
									</li>
									<li class="name"></li>
									<li class="ex-price"><!-- 원 가격 --></li>
									<li class="price"><!-- 가격 --></li>
								</ul>
								<ol>
									<li>
									<!--주말에
										<a href="#"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/btn_soon.png" alt="comming soon" /></a>
										-->										
										<a href="" id="todayLink"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/btn_buy.png" alt="구매하러 가기" /></a>										 
									 </li>
									 <li><a href="#" onclick="viewPoupLayer('modal',$('#lyrSch').html());return false;"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/btn_taday.png" alt="특가 일정 확인하기" /></a></li>
								</ol>
							</div>
							<!-- for dev msg : 주말엔 brand 비노출 --->
							<div class="brand" id="brand">
								<span class="bg-img"><img src="" alt="브랜드" /></span>
								<ul id="brandList">
									<li>
										<span alt="할인률">
										</span>
										<a href="#">확인하러 가기</a>
									</li>
									<li>
										<span alt="할인률">
										</span>
										<a href="#">확인하러 가기</a>
									</li>
									<li>
										<span alt="할인률">
										</span>
										<a href="#">확인하러 가기</a>
									</li>
								</ul>
							</div>

							<!-- 일정 보기 레이어 -->
							<div id="lyrSch" style="display:none;">
								<div class="layer layer-schedule">
									<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/tit_pop.png" alt="오늘의 특가 일정표" /></h3>
									<button type="button" class="btn-close" onclick="ClosePopLayer()"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/btn_close.png" alt="닫기" /></button>
									<div class="calendar">
										<span class="week"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_week.png" alt="" /></span>
										<ul id="itemImgList">
											<!-- for dev msg : 판매종료 일때는 클래스 soldout 클래스만 변경 --->
											<li class="comming">
												<img src="" alt="" />
												<p>15</p>
											</li>
											<!-- for dev msg : 진행중 일때는 클래스 now 클래스만 변경 --->
											<li class="comming">
												<img src="" alt="" />
												<p>16</p>											
											</li>
											<!-- for dev msg : 판매예정 일때는 클래스 comming 클래스만 변경 --->
											<li class="comming">
												<img src="" alt="" />
												<p>17</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>18</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>19</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>22</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>23</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>24</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>25</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>26</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>29</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>30</p>
											</li>
											<li class="comming">
												<img src="" alt="" />
												<p>31</p>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<!-- 17주년 MD 이벤트 : 오늘의 특가 -->						
<!-- #include virtual="/lib/db/dbclose.asp" -->