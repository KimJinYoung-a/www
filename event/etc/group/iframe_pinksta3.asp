<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 핑크스타그램3
' History : 2018-01-22 김송이 생성
'####################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2017-08-14"

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "91577" Then '// 1
		vStartNo = "0"
	ElseIf vEventID = "91599" Then '// 2
		vStartNo = "0"
	ElseIf vEventID = "92119" Then '// 3
		vStartNo = "0"
	ElseIf vEventID = "92264" Then '// 4
		vStartNo = "0"
	ElseIf vEventID = "92278" Then '// 5
		vStartNo = "1"
	ElseIf vEventID = "93294" Then '// 6
		vStartNo = "2"
	ElseIf vEventID = "93859" Then '// 7
		vStartNo = "3"
	ElseIf vEventID = "94060" Then '// 8
		vStartNo = "4"
	ElseIf vEventID = "94242" Then '// 9
		vStartNo = "4"
	ElseIf vEventID = "94257" Then '// 10
		vStartNo = "6"
	ElseIf vEventID = "94260" Then '// 11
		vStartNo = "7"
	ElseIf vEventID = "97760" Then '// 12
		vStartNo = "8"
	ElseIf vEventID = "98582" Then '// 13
		vStartNo = "9"
	ElseIf vEventID = "99547" Then '// 14
		vStartNo = "10"
	ElseIf vEventID = "99548" Then '// 15
		vStartNo = "11"
	ElseIf vEventID = "100079" Then '// 16
		vStartNo = "12"
	ElseIf vEventID = "101003" Then '// 17
		vStartNo = "13"
	ElseIf vEventID = "101457" Then '// 18
		vStartNo = "14"
	ElseIf vEventID = "101459" Then '// 19
		vStartNo = "15"
	ElseIf vEventID = "101776" Then '// 20
		vStartNo = "16"
	ElseIf vEventID = "105766" Then '// 21
		vStartNo = "17"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.pink-series {height:84px; background-color:#e13874;}
.pink-series .swiper {overflow:hidden; position:relative; width:920px; height:84px; padding:0 50px; margin:0 auto;}
.pink-series .swiper .swiper-wrapper {overflow:hidden;}
.pink-series .swiper .swiper-slide {float:left; position:relative; padding:24px 0 23px; text-align:center;}
.pink-series .swiper .swiper-slide a {position:relative; display:inline-block; min-width:90px; height:37px; color:#fff; font-size:19px; line-height:36px; font-weight:700; text-decoration:none;}
.pink-series .swiper .swiper-slide a span {display:none; font-size:16px;}
.pink-series .swiper .swiper-slide a:after {display:inline-block; position:absolute; top:0; right:0; width:2px; height:36px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/92119/bg_line.png); background-size:100%; content:'';}
.pink-series .swiper .swiper-slide.on a span {display:inline-block;}
.pink-series .swiper .swiper-slide.on a {padding:0 20px; color:#e13874; background-color:#fff; border-radius:18px;}
.pink-series .swiper .swiper-slide.on a:after,
.pink-series .swiper .swiper-slide.prev a:after {display:none;}
.pink-series .btn-nav {position:absolute; top:0; width:30px; height:84px; background:url(//webimage.10x10.co.kr/eventIMG/2017/79789/btn_nav.png) no-repeat 0 50%; text-indent:-9999em;}
.pink-series .btn-prev {left:78px;}
.pink-series .btn-next {right:78px; background-position:100% 50%;}
</style>
<script type="text/javascript">
	$(function(){
		var swiper1 = new Swiper('.pink-series .swiper-container',{
			initialSlide:<%=vStartNo%>,
			slidesPerView: 'auto',
			loop:false,
			speed:800,
			simulateTouch:false,
			slidesPerView:'auto'
		});
		$(".btn-prev").on("click", function(e){
			e.preventDefault()
			swiper1.swipePrev()
		})
		$(".btn-next").on("click", function(e){
			e.preventDefault()
			swiper1.swipeNext()
		});
		$('.pink-series .coming').on('click', function(e){
			e.preventDefault();
			alert("오픈 예정 기획전 입니다.");
		});
		$('.pink-series .swiper .swiper-slide.on').prev('.swiper-slide').addClass('prev');
	});
</script>
</head>
<body>
	<!-- pinkStagram -->
	<div class="pink-series rolling">
		<div class="swiper">
			<div class="swiper-container">
				<ul class="swiper-wrapper">
					<!-- for dev msg // 오픈된 탭 :open // 현재탭 :on -->

					<li class="swiper-slide <% if vEventID = "91577" then %> on <% elseif currentdate >= "2019-01-22" Then %> open<% end if %>">
						<a href="/event/eventmain.asp?eventid=91577" target="_top">01 <span>로즈쿼츠 마사지기</span></a>
					</li>
					<li class="swiper-slide <% if vEventID = "91599" then %> on <% elseif currentdate >= "2019-01-22" Then %> open<% end if %>">
						<% If currentdate >= "2019-01-22" Then %>
							<a href="/event/eventmain.asp?eventid=91599" target="_top">02 <span>핑크펜 시즌 2</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">02</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "92119" then %> on <% elseif currentdate >= "2019-01-23" Then %> open<% end if %>">
						<% If currentdate >= "2019-01-23" Then %>
							<a href="/event/eventmain.asp?eventid=92119" target="_top">03 <span>마법진 충전기</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">03</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "92264" then %> on <% elseif currentdate >= "2019-01-28" Then %> open<% end if %>">
						<% If currentdate >= "2019-01-28" Then %>
							<a href="/event/eventmain.asp?eventid=92264" target="_top">04 <span>메이드 인 노스코리아 조선</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">04</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "92278" then %> on <% elseif currentdate >= "2019-12-01" Then %> open<% end if %>">
						<% If currentdate >= "2019-01-31" Then %>
							<a href="/event/eventmain.asp?eventid=92278" target="_top">05 <span>핑크골드 쥬얼리보관함</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">05</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "93294" then %> on <% elseif currentdate >= "2019-04-10" Then %> open<% end if %>">
						<% If currentdate >= "2019-04-10" Then %>
							<a href="/event/eventmain.asp?eventid=93294" target="_top">06 <span>핑크 티컵</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">06</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "93859" then %> on <% elseif currentdate >= "2019-04-12" Then %> open<% end if %>">
						<% If currentdate >= "2019-04-12" Then %>
							<a href="/event/eventmain.asp?eventid=93859" target="_top">07 <span>핑크 박스파우치</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">07</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "94060" then %> on <% elseif currentdate >= "2019-04-25" Then %> open<% end if %>">
						<% If currentdate >= "2019-04-25" Then %>
							<a href="/event/eventmain.asp?eventid=94060" target="_top">08 <span>핑크 커터</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">08</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "94242" then %> on <% elseif currentdate >= "2019-05-02" Then %> open<% end if %>">
						<% If currentdate >= "2019-05-02" Then %>
							<a href="/event/eventmain.asp?eventid=94242" target="_top">09 <span>핑크 몰랑 미니램프 방향제</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">09</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "94257" then %> on <% elseif currentdate >= "2019-05-17" Then %> open<% end if %>">
						<% If currentdate >= "2019-05-17" Then %>
							<a href="/event/eventmain.asp?eventid=94257" target="_top">10 <span>Pink drink &amp; tea</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">10</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "94260" then %> on <% elseif currentdate >= "2019-06-16" Then %> open<% end if %>">
						<% If currentdate >= "2019-06-16" Then %>
							<a href="/event/eventmain.asp?eventid=94260" target="_top">11 <span>핑크 조각 스티커</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">11</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "97760" then %> on <% elseif currentdate >= "2019-10-30" Then %> open<% end if %>">
						<% If currentdate >= "2019-10-30" Then %>
							<a href="/event/eventmain.asp?eventid=97760" target="_top">12 <span>핑크파레트</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">12</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "98582" then %> on <% elseif currentdate >= "2019-11-21" Then %> open<% end if %>">
						<% If currentdate >= "2019-11-21" Then %>
							<a href="/event/eventmain.asp?eventid=98582" target="_top">13 <span>핑크 수납 달력</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">13</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "99547" then %> on <% elseif currentdate >= "2019-12-18" Then %> open<% end if %>">
						<% If currentdate >= "2019-12-18" Then %>
							<a href="/event/eventmain.asp?eventid=99547" target="_top">14 <span>핑크 양모 슬리퍼</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">14</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "99548" then %> on <% elseif currentdate >= "2020-01-07" Then %> open<% end if %>">
						<% If currentdate >= "2020-01-07" Then %>
							<a href="/event/eventmain.asp?eventid=99548" target="_top">15 <span>핑크 씰</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">15</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "100079" then %> on <% elseif currentdate >= "2020-01-20" Then %> open<% end if %>">
						<% If currentdate >= "2020-01-20" Then %>
							<a href="/event/eventmain.asp?eventid=100079" target="_top">16 <span>디붐 DITOO 핑크</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">16</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "101003" then %> on <% elseif currentdate >= "2020-03-02" Then %> open<% end if %>">
						<% If currentdate >= "2020-03-02" Then %>
							<a href="/event/eventmain.asp?eventid=101003" target="_top">17 <span>핑크 클린 베어</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">17</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "101457" then %> on <% elseif currentdate >= "2020-03-19" Then %> open<% end if %>">
						<% If currentdate >= "2020-03-19" Then %>
							<a href="/event/eventmain.asp?eventid=101457" target="_top">18 <span>수련 무릎마사지기</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">18</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "101459" then %> on <% elseif currentdate >= "2020-04-03" Then %> open<% end if %>">
						<% If currentdate >= "2020-04-03" Then %>
							<a href="/event/eventmain.asp?eventid=101459" target="_top">19 <span>핑크 핀셋</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">19</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "101776" then %> on <% elseif currentdate >= "2020-04-09" Then %> open<% end if %>">
						<% If currentdate >= "2020-04-09" Then %>
							<a href="/event/eventmain.asp?eventid=101776" target="_top">20 <span>에어팟 충전기</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">20</a>
						<% end if %>
					</li>
					<li class="swiper-slide <% if vEventID = "105766" then %> on <% elseif currentdate >= "2020-09-18" Then %> open<% end if %>">
						<% If currentdate >= "2020-09-18" Then %>
							<a href="/event/eventmain.asp?eventid=105766" target="_top">21 <span>슬라이드 지우개</span></a>
						<% else %>
							<a href="" onclick="return false;" class="coming">21</a>
						<% end if %>
					</li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn-nav btn-prev">Previous</button>
		<button type="button" class="btn-nav btn-next">Next</button>
	</div>
</body>
</html>