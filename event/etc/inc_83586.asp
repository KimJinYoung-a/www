<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : [valentine’s day] HOW TO SAY LOVE
' History : 2018-01-29 정태훈
'####################################################
Dim eCode, userid, gmid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67503
Else
	eCode   =  83586
End If

gmid=request("mid")
If gmid="" Then gmid="1"
userid = GetEncLoginUserID()

Dim vQuery, UserAppearChk
vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"'"
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	UserAppearChk = rsget(0)
End IF
rsget.close
%>
<style type="text/css">
.evt83586 {background:#ffd4c8 url(http://webimage.10x10.co.kr/eventIMG/2018/83586/bg_valen_v3.jpg) no-repeat 50% 0;}
.evt83586 a {text-decoration:none; color:#000;}

.top-cont {position:relative; height:385px;}
.top-cont .btn-go-evnt,
.top-cont .date,
.top-cont .valen-day {position:absolute; top:25px; left:50%; margin-left:385px;}
.top-cont .valen-day {top:100px; margin-left:-177px; animation:move-right .8s .3s forwards; opacity:0;}
.top-cont h2 {padding:175px 0 0; animation:move-left 1s .5s forwards; opacity:0;}
.top-cont .sub {margin-top:-38px; animation:move-right 1s .7s forwards; opacity:0;}
.top-cont .btn-go-evnt {top:80px; margin-left:380px;}

.item-image {position:relative; width:1140px; height:650px; margin:0 auto;}
.item-image .list {position:absolute; left:0; top:0; width:1140px; height:620px;}
.item-image .list li {position:absolute;}
.item-image .list li a {position:relative; display:block; height:100%;}
.item-image .list li p {overflow:hidden; position:absolute; width:33px; height:33px; font-size:13px; font-weight:bold; color:#fff; text-align:left; border-radius:16px; transition:width .4s;}
.item-image .list li i {display:inline-block; position:absolute; left:0; top:0; z-index:10; width:33px; height:33px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/80294/ico_plus_v2.png) no-repeat 50% 50%; transform:rotate(0); text-indent:-999em;transition:all .4s; animation:bounce .8s .5s 100;}
.item-image .list li:nth-child(1) i,
.item-image .list li:nth-child(4) i,
.item-image .list li:nth-child(6) i{animation:bounce .8s .3s 100;}
.item-image .list li span {display:inline-block; height:33px;   line-height:32px; white-space:nowrap; transition:all .4s; opacity:0; filter:alpha(opacity=0);}
.item-image .list li a:hover p {overflow:visible;}
.item-image .list li a:hover i {overflow:visible; transform:rotate(180deg);}
.item-image .list li a:hover span {padding:0 15px 0 28px; background-color:#000; border-radius:16px; opacity:1; filter:alpha(opacity=100);}
.item-image li.item1 {right:102px; top:0; z-index:20; width:250px; height:300px;}
.item-image li.item1 p {left:20px; top:55px;}
.item-image li.item2 {left:70px; top:80px; z-index:20; width:195px; height:220px;}
.item-image li.item2 p {left:162px; top:56px;}
.item-image li.item3 {right:0px; top:130px; z-index:30; width:162px; height:165px;}
.item-image li.item3 p {left:0; top:50px;}
.item-image li.item4 {left:0; top:195px; z-index:30; width:150px; height:210px;}
.item-image li.item4 p {left:110px; top:20px;}
.item-image li.item5 {left:165px; top:300px; width:175px; height:160px;}
.item-image li.item5 p {left:130px; top:16px;}
.item-image li.item6 {left:430px; top:302px; width:145px; height:250px;}
.item-image li.item6 p {left:80px; top:90px;}

.gift-evt {position:relative; padding:62px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2018/83586/bg_evnt.jpg) repeat-x 50% 50%;}
.gift-evt button,
.gift-evt p,
.gift-evt span {position:absolute; top:107px; left:50%; margin-left:180px; background-color:transparent;}
.gift-evt span {top:33px; margin-left:250px; z-index:50;}

.valen-nav {width:100%; height:172px; padding:50px 0 65px; background-color:#fff; text-align:center;}
.valen-nav .inner {width:1140px; height:100%; margin:0 auto; }
.valen-nav .inner > div {position:relative; float:left; height:100%;}
.valen-nav .inner > div h3 {overflow:hidden; height:24px; margin-bottom:30px;}
.valen-nav .inner > div.on h3 > img{margin-top:-28px;}
.valen-nav .inner > div ul{position:relative; height:130px; padding-top:12px; padding:0 20px;}
.valen-nav .inner > div ul:after {content:' '; position:absolute; top:0; left:0; width:1px; height:122px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/83586/img_dashed.gif) repeat-y;}
.valen-nav .inner > .nav-1 ul{padding-left:0;}
.valen-nav .inner > .nav-1 ul:after {display:none;}
.valen-nav .inner > .nav-3 ul{padding-right:0; }
.valen-nav .inner:after,
.valen-nav .inner > div ul:after {content:' '; display:inline-block; overflow:hidden;}
.valen-nav .inner > div ul li {position:relative; float:left; width:95px; height:100%; margin:0 5px; cursor:pointer;}
.valen-nav .inner > div ul li a {position:relative; z-index:100; display:inline-block;}
.valen-nav .inner > div ul li.on a:before,
.valen-nav .inner > div ul li:hover a:before {content:' '; position:absolute; 0 left:0; width:100%; height:95px; background-color:rgba(190, 45, 0, .6); border-radius:50%;}
.valen-nav .inner > div ul li.on a:after {content:' '; position:absolute; top:-6px; left:-6px; width:105px; height:105px; border:solid 1px #c23b11; border-radius:50%;}
.valen-nav .inner > .nav-2 ul li.on a:before,
.valen-nav .inner > .nav-2 ul li:hover a:before {background-color:rgba(7, 100, 135, .6);}
.valen-nav .inner > .nav-2 ul li.on a:after{border:solid 1px #1484ad;}
.valen-nav .inner > .nav-3 ul li.on a:before,
.valen-nav .inner > .nav-3 ul li:hover a:before {background-color:rgba(215, 65, 104, .6);}
.valen-nav .inner > .nav-3 ul li.on a:after{border:solid 1px #e93c69;}
.valen-nav .inner > div ul li a > img{width:100%;}
.valen-nav .inner > div ul li p {overflow:hidden; height:14px; margin-top:20px;}
.valen-nav .inner > div ul li.on p:after {content:' '; display:block; position:absolute; bottom:-28px; left:0; width:100%; height:10px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/83586/img_arrow_1.png);}
.valen-nav .inner > .nav-2 ul li.on p:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/83586/img_arrow_2.png);}
.valen-nav .inner > .nav-3 ul li.on p:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/83586/img_arrow_3.png);}
.valen-nav .inner > div ul li.on p img {margin-top:-34px;}

/* fixed-nav */
.valen-nav.fixed-nav {position:fixed; top:0; left:50%; z-index:100; margin-left:-50%; background-color:rgba(255,255,255, .95); animation:slide 1 .5s;}
.valen-nav.fixed-nav {height:80px; padding:13px 0; -webkit-box-shadow: 0px 7px 11px -1px rgba(0,0,0,0.25); -moz-box-shadow: 0px 7px 11px -1px rgba(0,0,0,0.25); box-shadow: 0px 7px 11px -1px rgba(0,0,0,0.25);}
.valen-nav.fixed-nav .inner > div h3 {height:auto; margin-bottom:0;}
.valen-nav.fixed-nav .inner > div h3 span{display:inline-block; position:absolute; top:18px; left:0;}
.valen-nav.fixed-nav .inner > div ul {height:100%; padding-right:65px; padding-left:80px !important;}
.valen-nav.fixed-nav .inner > .nav-3 ul {padding-right:0;}
.valen-nav.fixed-nav .inner > div ul li {width:57px; height:80px; margin:0 10px; color:#000;}
.valen-nav.fixed-nav .inner > div ul li span {display:block; padding-top:11px; font-size:11px; line-height:1;}
.valen-nav.fixed-nav .inner > div ul li.on span {font-weight:bold;}
.valen-nav.fixed-nav .inner > div ul li a:before {top:0; height:57px;}
.valen-nav.fixed-nav .inner > div ul li:first-child + li + li a:before {width:57px;}
.valen-nav.fixed-nav .inner > div ul li a:after,
.valen-nav.fixed-nav .inner > div ul li a:hover:after,
.valen-nav.fixed-nav .inner > div ul li.on a:after {top:15px; left:9px; width:39px; height:31px; border:none; background:url(http://webimage.10x10.co.kr/eventIMG/2018/83586/ico_check.png); background-size:100%;}
.valen-nav .inner > div h3 span,
.valen-nav .inner > div ul li span,
.valen-nav.fixed-nav .inner > div h3 > img,
.valen-nav.fixed-nav .inner > div ul:after,
.valen-nav.fixed-nav .inner > div ul li p {display:none;}

@keyframes bounce {
	from, to {transform:translateY(0);}
	50% {transform:translateY(3px);}
}
@keyframes slide {
	from {margin-top:-50px;}
	to {margin-top:0;}
}
@keyframes move-right {
	from {transform:translateX(-20px); opacity:0;}
	to {transform:translateX(0);opacity:1;}
}
@keyframes move-left {
	from {transform:translateX(20px); opacity:0;}
	to {transform:translateX(0);opacity:1;}
}
</style>
<script type="text/javascript">
$(function(){
<% If request("mid")<>"" Then %>
	var position = $('.valen-nav').offset(); // 위치값
	$('html,body').animate({ scrollTop : position.top },0); // 이동
<% end if %>

	$('.top-cont .btn-go-evnt').click(function(){
		$( ".gift-evt" ).scroll();
		$('html, body').animate({scrollTop: $(".gift-evt").offset().top}, 1000);
	});

	// fixed nav
	var nav1 = $(".valen-nav").offset().top+100;
	$(window).scroll(function() {
			var y = $(window).scrollTop();
			if (nav1 < y ) {
					$(".valen-nav").addClass("fixed-nav");
			}
			else {
					$(".valen-nav").removeClass("fixed-nav");
			}
	});
});

function fnGoEnter(){
<% If now() > #01/29/2018 00:00:00# and now() < #02/14/2018 23:59:59# then %>
	var str = $.ajax({
		type: "POST",
		url: "/event/etc/doEventSubscript83586.asp",
		data: "mode=add&eCode=<%=eCode%>",
		dataType: "text",
		async: false
	}).responseText;
	var str1 = str.split("|")
	if (str1[0] == "11"){
		$("#btn1").css("display","none");
		$("#btn2").css("display","");
		alert('응모가 완료되었습니다.');
		return false;
	}else if (str1[0] == "12"){
		alert('이벤트 기간이 아닙니다.');
		return false;
	}else if (str1[0] == "13"){
		alert('이미 응모하셨습니다.');
		return false;
	}else if (str1[0] == "02"){
		alert('로그인 후 참여 가능합니다.');
		return false;
	}else if (str1[0] == "03"){
		alert('이벤트 대상 카테고리 구매 내역이 없습니다.');
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
<% Else %>
	alert("이벤트 기간이 아닙니다.");
	return;
<% End If %>
}
</script>
						<div class="evt83586">
							<div class="top-cont">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/tit_love_v3.png" alt="how to say love" /></h2>
								<p class="valen-day"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_valen_v2.png" alt="2018 Valentine’s Day" /></p>
								<p class="sub"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_sub_v2.png" alt="2월 14일 발렌타인데이를 위한 달콤한 고백 레시피 " /></p>
								<span class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_date_v2.png" alt="2018.01.17 ~ 02.14" /></span>
								<a href="#" class="btn-go-evnt"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/btn_go_evt_v2.png" alt="추첨을 통해 닌텐도 스위치 증정! 으로 이동" /></a>
							</div>

							<!-- 상품목록 -->
							<div class="item-image">
								<ul class="list">
									<li class="item1"><a href="/shopping/category_prd.asp?itemid=1751337&pEtr=83633"><p><i>+</i><span>몽슈크레 수제 마카롱 </span></p></a></li>
									<li class="item2"><a href="/shopping/category_prd.asp?itemid=1887286&pEtr=83633"><p><i>+</i><span>위니비니X텐바이텐 핑크에디션</span></p></a></li>
									<li class="item3"><a href="/shopping/category_prd.asp?itemid=1855645&pEtr=83633"><p><i>+</i><span>미나티 수제 쿠키 SET  </span></p></a></li>
									<li class="item4"><a href="/shopping/category_prd.asp?itemid=1876029&pEtr=83633"><p><i>+</i><span>스윗바크 초콜릿 DIY SET  </span></p></a></li>
									<li class="item5"><a href="/shopping/category_prd.asp?itemid=1855645&pEtr=83633"><p><i>+</i><span>미나티 수제 쿠키 SET  </span></p></a></li>
									<li class="item6"><a href="/shopping/category_prd.asp?itemid=1646438&pEtr=83633"><p><i>+</i><span>글라소디 스틱믹스 초콜릿  </span></p></a></li>
								</ul>
							</div>

							<!-- 참여이벤트 -->
							<div class="gift-evt">
								<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_evt_v2.png" alt="참여 이벤트 스낵/견과 & 베이커리/베이킹 카테고리 상품을 구매하신 분 중 2분께 닌텐도 스위치를 드립니다! 응모기간 01.17 (수) ~ 02.14 (수) 당첨발표  02.22 (목) 고객에 한해, ID당 한번만 응모가능  ※ 제세공과금은 텐바이텐 부담이며 세무신고를 위해 개인정보를 취합 후 경품 증정" />
								<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_gift.png" alt="" /></span>
								<% If userid<>"" Then %>
								<div id="btn1" style="display:<% If UserAppearChk>"0" Then %>none<% Else %><% End if %>"><button onclick="fnGoEnter();"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/btn_submit.png" alt="응모하기" /></button></div>
								<% Else %>
								<button onclick="top.location.href='/login/loginpage.asp?vType=G';"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/btn_submit.png" alt="응모하기" /></button>
								<% End If %>
								<p id="btn1" style="display:<% If UserAppearChk>"0" Then %><% Else %>none<% End if %>"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_submit_comp.png" alt="응모완료" /></p>
							</div>

							<!-- fixed-nav -->
							<div class="valen-nav">
								<div class="inner">
									<!-- 해당 section에 class="on" -->
									<!-- SWEET THINGS -->
									<div class="nav-1<% If gmid="1" Or gmid="2" Or gmid="3" Or gmid="4" Then Response.write " on"%>">
										<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/tit_nav_1_1.gif" alt="sweet things" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/tit_nav_2_1.gif" alt="" /></span></h3>
										<ul>
											<!-- 해당 tab 에 class="on" -->
											<li class="<% If gmid="1" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232018&mid=1">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_1.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_1.gif" alt="" /></p>
													<span>DIY</span>
												</a>
											</li>
											<li class="<% If gmid="2" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232019&mid=2">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_2.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_2.gif" alt="" /><span></span></p>
													<span>초콜릿</span>
												</a>
											</li>
											<li class="<% If gmid="3" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232020&mid=3">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_3.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_3.gif" alt="" /><span></span></p>
													<span style="letter-spacing:-1.2px;">견과류/스낵</span>
												</a>
											</li>
											<li class="<% If gmid="4" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232021&mid=4">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_4.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_4.gif" alt="" /><span></span></p>
													<span>클래스</span>
												</a>
											</li>
										</ul>
									</div>

									<!-- GIFT FOR HIM -->
									<div class="nav-2<% If gmid="5" Or gmid="6" Or gmid="7" Then Response.write " on"%>">
										<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/tit_nav_1_2.gif" alt="gift for him" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/tit_nav_2_2.gif" alt="GIFT FOR HIM" /></span></h3>
										<ul>
											<li class="<% If gmid="5" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232698&mid=5">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_5.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_5.gif" alt="" /><span></span></p>
													<span>패션</span>
												</a>
											</li>
											<li class="<% If gmid="6" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232702&mid=6">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_6.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_6.gif" alt="" /><span></span></p>
													<span>뷰티</span>
												</a>
											</li>
											<li class="<% If gmid="7" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232706&mid=7">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_7.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_7.gif" alt="" /><span></span></p>
													<span>디지털</span>
												</a>
											</li>
										</ul>
									</div>

									<!-- GIFT FOR HER -->
									<div class="nav-3<% If gmid="8" Or gmid="9" Or gmid="10" Then Response.write " on"%>">
										<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/tit_nav_1_3.gif" alt="gift for her" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/tit_nav_3_2.gif" alt="GIFT FOR HER" /></span></h3>
										<ul>
											<li class="<% If gmid="8" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232710&mid=8">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_8.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_8.gif" alt="" /><span></span></p>
													<span>패션</span>
												</a>
											</li>
											<li class="<% If gmid="9" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232715&mid=9">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_9.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_9.gif" alt="" /><span></span></p>
													<span>취미</span>
												</a>
											</li>
											<li class="<% If gmid="10" Then Response.write "on"%>">
												<a href="/event/eventmain.asp?eventid=83586&eGc=232720&mid=10">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/img_nav_1_10.png" alt="" />
													<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83586/txt_nav_1_10.gif" alt="" /><span></span></p>
													<span>디지털</span>
												</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->