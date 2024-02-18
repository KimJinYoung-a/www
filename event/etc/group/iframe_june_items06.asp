<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2018-11-28"
	'response.write currentdate

	Dim vEventID, vStartNo, appevturl
	vEventID = Request("eventid")
	If vEventID = "111122" Then '// 2021-06-01
		vStartNo = "0"
	ElseIf vEventID = "111123" Then '// 2021-06-02
		vStartNo = "1"
	ElseIf vEventID = "111124" Then '// 2021-06-03
		vStartNo = "2"
	ElseIf vEventID = "111125" Then '// 2021-06-04
		vStartNo = "3"
	ElseIf vEventID = "111126" Then '// 2021-06-07
		vStartNo = "4"
	ElseIf vEventID = "111127" Then '// 2021-06-08
		vStartNo = "5"
    ElseIf vEventID = "111128" Then '// 2021-06-09
		vStartNo = "6"
    ElseIf vEventID = "111129" Then '// 2021-06-10
		vStartNo = "7"
    ElseIf vEventID = "111130" Then '// 2021-06-11
		vStartNo = "8"
    ElseIf vEventID = "111131" Then '// 2021-06-14
		vStartNo = "9"
    ElseIf vEventID = "111612" Then '// 2021-06-15
		vStartNo = "10"
    ElseIf vEventID = "111613" Then '// 2021-06-16
		vStartNo = "11"
    ElseIf vEventID = "111614" Then '// 2021-06-17
		vStartNo = "12"
    ElseIf vEventID = "111615" Then '// 2021-06-18
		vStartNo = "13"
    ElseIf vEventID = "111616" Then '// 2021-06-21
		vStartNo = "14"
    ElseIf vEventID = "111617" Then '// 2021-06-22
		vStartNo = "15"
    ElseIf vEventID = "111618" Then '// 2021-06-23
		vStartNo = "16"
    ElseIf vEventID = "111619" Then '// 2021-06-24
		vStartNo = "17"
    ElseIf vEventID = "111620" Then '// 2021-06-25
		vStartNo = "18" 
    ElseIf vEventID = "111621" Then '// 2021-06-28
		vStartNo = "19"
    ElseIf vEventID = "111622" Then '// 2021-06-29
		vStartNo = "20"
    ElseIf vEventID = "111623" Then '// 2021-06-30
		vStartNo = "21"                                
	else
		vStartNo = "0"
	End IF
		appevturl = "/event/eventmain.asp?"
%>
<style type="text/css">
    .evt108730 {background:#fff;}
    .evt108730 .txt-hidden {text-indent: -9999px; font-size:0;}
    .evt108730 .topic {position:relative; width:100%; height:93px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111073/bg_top02.jpg) no-repeat 50% 0; background-size:100%;}
    .evt108730 .topic .navi-wrap {display:flex; align-items:center; justify-content:space-between; width:890px; margin:0 auto;}
    .evt108730 .topic .navi-container {width:435px; height:93px;}
    .evt108730 .topic .swiper-container {position:relative; width:335px; padding:0 50px;}
    .evt108730 .topic .swiper-wrapper {height:93px; display:flex; align-items:center; justify-content:flex-start;}
    .evt108730 .topic .swiper-wrapper .swiper-slide {width:120px; text-align:center;}
    .evt108730 .topic .swiper-wrapper .swiper-slide a {display:block; height:93px; line-height:93px; color:#dbfcdf; font-size:25px; text-decoration:none;}
    .evt108730 .topic .swiper-wrapper .swiper-slide:nth-child(1) {width:100px;}
    .evt108730 .topic .swiper-wrapper .swiper-slide:last-child {width:100px;}
    .evt108730 .topic .swiper-wrapper .swiper-slide a.current {position:relative; color:#249e53;}
    .evt108730 .topic .swiper-wrapper .swiper-slide a.current span {display:inline-block; position:absolute; left:50%; top:50%; transform: translate(-50%,-50%);}
    .evt108730 .topic .swiper-wrapper .swiper-slide a.current::before {content:""; position:absolute; left:50%; top:50%; transform:translate(-50%,-50%); z-index:0; display:inline-block; width:40px; height:40px; border-radius:100%; background:#dbfcdf;}
    .evt108730 .navi-wrap .swiper-button-prev {position:absolute; left:0; top:10px; width:50px; height:82px; background: url(//webimage.10x10.co.kr/fixevent/event/2021/111073/bg_line02.jpg) repeat; opacity:1; z-index:10; cursor: pointer; text-align:right;}
    .evt108730 .navi-wrap .swiper-button-next {position:absolute; right:0; top:10px; width:50px; height:82px; background: url(//webimage.10x10.co.kr/fixevent/event/2021/111073/bg_line02.jpg) repeat; opacity:1; z-index:10; cursor: pointer; text-align:left;}
    .evt108730 .navi-wrap .swiper-button-prev img {padding:27px 20px 0 0;}
    .evt108730 .navi-wrap .swiper-button-next img {padding:25px 0 0 15px;}
</style>
<script type="text/javascript">
    $(function() {
        /* slide */
        var mySwiper = new Swiper(".navi-wrap .swiper-container", {
            centeredSlides: false, //활성화된것이 중앙으로
            initialSlide:<%=vStartNo%>, //활성화될 슬라이드 번호 입력
            slidesPerView:5,
        });
        $('.swiper-button-prev').on('click', function(e){ //왼쪽 네비게이션 버튼 클릭
            e.preventDefault()
            mySwiper.swipePrev()
        });
        $('.swiper-button-next').on('click', function(e){ //오른쪽 네비게이션 버튼 클릭
            e.preventDefault() 
            mySwiper.swipeNext()
        });
    });
    function goEventLink(evt) {
	parent.location.href='/event/eventmain.asp?eventid='+evt;
    }
</script>
</head>
<body>
<div class="evt108730">
    <div class="topic">
        <div class="navi-wrap">
            <div style="padding-top:15px;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111073/tit_txt02.png" alt="매일문구 june"></div>
            <div class="navi-container">
                <div class="slide-area">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
                            <!-- 활성화될 슬라이더에 class current 추가 및 span 추가-->
                            <!-- 2021-06-01 -->
                            <% if currentdate >= "2021-06-01" then %>
                                <% if vEventID="111122" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111122);return false;" class="current"><span>01</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111122);return false;">01</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-02 -->
                            <% if currentdate >= "2021-06-02" then %>
                                <% if vEventID="111123" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111123);return false;" class="current"><span>02</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111123);return false;">02</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-03 -->
                            <% if currentdate >= "2021-06-03" then %>
                                <% if vEventID="111124" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111124);return false;" class="current"><span>03</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111124);return false;">03</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-04 -->
                            <% if currentdate >= "2021-06-04" then %>
                                <% if vEventID="111125" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111125);return false;" class="current"><span>04</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111125);return false;">04</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-07 -->
                            <% if currentdate >= "2021-06-07" then %>
                                <% if vEventID="111126" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111126);return false;" class="current"><span>07</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111126);return false;">07</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-08 -->
                            <% if currentdate >= "2021-06-08" then %>
                                <% if vEventID="111127" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111127);return false;" class="current"><span>08</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111127);return false;">08</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-09 -->
                            <% if currentdate >= "2021-06-09" then %>
                                <% if vEventID="111128" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111128);return false;" class="current"><span>09</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111128);return false;">09</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-10 -->
                            <% if currentdate >= "2021-06-10" then %>
                                <% if vEventID="111129" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111129);return false;" class="current"><span>10</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111129);return false;">10</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-11 -->
                            <% if currentdate >= "2021-06-11" then %>
                                <% if vEventID="111130" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111130);return false;" class="current"><span>11</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111130);return false;">11</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-14 -->
                            <% if currentdate >= "2021-06-14" then %>
                                <% if vEventID="111131" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111131);return false;" class="current"><span>14</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111131);return false;">14</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-15 -->
                            <% if currentdate >= "2021-06-15" then %>
                                <% if vEventID="111612" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111612);return false;" class="current"><span>15</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111612);return false;">15</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-16 -->
                            <% if currentdate >= "2021-06-16" then %>
                                <% if vEventID="111613" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111613);return false;" class="current"><span>16</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111613);return false;">16</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-17 -->
                            <% if currentdate >= "2021-06-17" then %>
                                <% if vEventID="111614" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111614);return false;" class="current"><span>17</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111614);return false;">17</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-18 -->
                            <% if currentdate >= "2021-06-18" then %>
                                <% if vEventID="111615" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111615);return false;" class="current"><span>18</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111615);return false;">18</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-21 -->
                            <% if currentdate >= "2021-06-21" then %>
                                <% if vEventID="111616" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111616);return false;" class="current"><span>21</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111616);return false;">21</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-22 -->
                            <% if currentdate >= "2021-06-22" then %>
                                <% if vEventID="111617" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111617);return false;" class="current"><span>22</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111617);return false;">22</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-23 -->
                            <% if currentdate >= "2021-06-23" then %>
                                <% if vEventID="111618" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111618);return false;" class="current"><span>23</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111618);return false;">23</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-24 -->
                            <% if currentdate >= "2021-06-24" then %>
                                <% if vEventID="111619" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111619);return false;" class="current"><span>24</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111619);return false;">24</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-25 -->
                            <% if currentdate >= "2021-06-25" then %>
                                <% if vEventID="111620" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111620);return false;" class="current"><span>25</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111620);return false;">25</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-28 -->
                            <% if currentdate >= "2021-06-28" then %>
                                <% if vEventID="111621" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111621);return false;" class="current"><span>28</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111621);return false;">28</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-29 -->
                            <% if currentdate >= "2021-06-29" then %>
                                <% if vEventID="111622" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111622);return false;" class="current"><span>29</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111622);return false;">29</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-06-30 -->
                            <% if currentdate >= "2021-06-30" then %>
                                <% if vEventID="111623" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111623);return false;" class="current"><span>30</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111623);return false;">30</a>
                                </div>
                                <% End If %>
                            <% End If %>
                        </div>         
                        <div class="swiper-button-prev"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111073/icon_arr_left.png?v=2.1" alt=""></div>
                        <div class="swiper-button-next"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111073/icon_arr_right.png?v=2.1" alt=""></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>