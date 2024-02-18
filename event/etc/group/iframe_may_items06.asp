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
	If vEventID = "111073" Then '// 2021-05-03
		vStartNo = "0"
	ElseIf vEventID = "111082" Then '// 2021-05-04
		vStartNo = "1"
	ElseIf vEventID = "111104" Then '// 2021-05-06
		vStartNo = "2"
	ElseIf vEventID = "111105" Then '// 2021-05-07
		vStartNo = "3"
	ElseIf vEventID = "111106" Then '// 2021-05-10
		vStartNo = "4"
	ElseIf vEventID = "111107" Then '// 2021-05-11
		vStartNo = "5"
    ElseIf vEventID = "111108" Then '// 2021-05-12
		vStartNo = "6"
    ElseIf vEventID = "111109" Then '// 2021-05-13
		vStartNo = "7"
    ElseIf vEventID = "111110" Then '// 2021-05-14
		vStartNo = "8"
    ElseIf vEventID = "111111" Then '// 2021-05-17
		vStartNo = "9"
    ElseIf vEventID = "111112" Then '// 2021-05-18
		vStartNo = "10"
    ElseIf vEventID = "111114" Then '// 2021-05-20
		vStartNo = "11"
    ElseIf vEventID = "111115" Then '// 2021-05-21
		vStartNo = "12"
    ElseIf vEventID = "111116" Then '// 2021-05-24
		vStartNo = "13"
    ElseIf vEventID = "111117" Then '// 2021-05-25
		vStartNo = "14"
    ElseIf vEventID = "111118" Then '// 2021-05-26
		vStartNo = "15"
    ElseIf vEventID = "111119" Then '// 2021-05-27
		vStartNo = "16"
    ElseIf vEventID = "111120" Then '// 2021-05-28
		vStartNo = "17"
    ElseIf vEventID = "111121" Then '// 2021-05-31
		vStartNo = "18"                           
	else
		vStartNo = "0"
	End IF
		appevturl = "/event/eventmain.asp?"
%>
<style type="text/css">
    .evt108730 {background:#fff;}
    .evt108730 .txt-hidden {text-indent: -9999px; font-size:0;}
    .evt108730 .topic {position:relative; width:100%; height:93px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111073/bg_top.jpg?v=2) no-repeat 50% 0; background-size:100%;}
    .evt108730 .topic .navi-wrap {display:flex; align-items:center; justify-content:space-between; width:890px; margin:0 auto;}
    .evt108730 .topic .navi-container {width:435px; height:93px;}
    .evt108730 .topic .swiper-container {position:relative; width:335px; padding:0 50px;}
    .evt108730 .topic .swiper-wrapper {height:93px; display:flex; align-items:center; justify-content:flex-start;}
    .evt108730 .topic .swiper-wrapper .swiper-slide {width:120px; text-align:center;}
    .evt108730 .topic .swiper-wrapper .swiper-slide a {display:block; height:93px; line-height:93px; color:#ffd2a1; font-size:25px; text-decoration:none;}
    .evt108730 .topic .swiper-wrapper .swiper-slide:nth-child(1) {width:100px;}
    .evt108730 .topic .swiper-wrapper .swiper-slide:last-child {width:100px;}
    .evt108730 .topic .swiper-wrapper .swiper-slide a.current {position:relative; color:#ff8400;}
    .evt108730 .topic .swiper-wrapper .swiper-slide a.current span {display:inline-block; position:absolute; left:50%; top:50%; transform: translate(-50%,-50%);}
    .evt108730 .topic .swiper-wrapper .swiper-slide a.current::before {content:""; position:absolute; left:50%; top:50%; transform:translate(-50%,-50%); z-index:0; display:inline-block; width:40px; height:40px; border-radius:100%; background:#fff9c5;}
    .evt108730 .navi-wrap .swiper-button-prev {position:absolute; left:0; top:10px; width:50px; height:82px; background: url(//webimage.10x10.co.kr/fixevent/event/2021/111073/bg_line.jpg?v=2.1) repeat; opacity:1; z-index:10; cursor: pointer; text-align:right;}
    .evt108730 .navi-wrap .swiper-button-next {position:absolute; right:0; top:10px; width:50px; height:82px; background: url(//webimage.10x10.co.kr/fixevent/event/2021/111073/bg_line.jpg?v=2.1) repeat; opacity:1; z-index:10; cursor: pointer; text-align:left;}
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
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111073/tit_txt.png" alt="매일문구 MAY"></div>
            <div class="navi-container">
                <div class="slide-area">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
                            <!-- 활성화될 슬라이더에 class current 추가 및 span 추가-->
                            <!-- 2021-05-03 -->
                            <% if currentdate >= "2021-05-03" then %>
                                <% if vEventID="111073" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111073);return false;" class="current"><span>03</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111073);return false;">03</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-04 -->
                            <% if currentdate >= "2021-05-04" then %>
                                <% if vEventID="111082" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111082);return false;" class="current"><span>04</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111082);return false;">04</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-06 -->
                            <% if currentdate >= "2021-05-06" then %>
                                <% if vEventID="111104" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111104);return false;" class="current"><span>06</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111104);return false;">06</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-07 -->
                            <% if currentdate >= "2021-05-07" then %>
                                <% if vEventID="111105" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111105);return false;" class="current"><span>07</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111105);return false;">07</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-10 -->
                            <% if currentdate >= "2021-05-10" then %>
                                <% if vEventID="111106" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111106);return false;" class="current"><span>10</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111106);return false;">10</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-11 -->
                            <% if currentdate >= "2021-05-11" then %>
                                <% if vEventID="111107" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111107);return false;" class="current"><span>11</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111107);return false;">11</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-12 -->
                            <% if currentdate >= "2021-05-12" then %>
                                <% if vEventID="111108" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111108);return false;" class="current"><span>12</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111108);return false;">12</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-13 -->
                            <% if currentdate >= "2021-05-13" then %>
                                <% if vEventID="111109" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111109);return false;" class="current"><span>13</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111109);return false;">13</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-14 -->
                            <% if currentdate >= "2021-05-14" then %>
                                <% if vEventID="111110" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111110);return false;" class="current"><span>14</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111110);return false;">14</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-17 -->
                            <% if currentdate >= "2021-05-17" then %>
                                <% if vEventID="111111" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111111);return false;" class="current"><span>17</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111111);return false;">17</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-18 -->
                            <% if currentdate >= "2021-05-18" then %>
                                <% if vEventID="111112" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111112);return false;" class="current"><span>18</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111112);return false;">18</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-20 -->
                            <% if currentdate >= "2021-05-20" then %>
                                <% if vEventID="111114" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111114);return false;" class="current"><span>20</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111114);return false;">20</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-21 -->
                            <% if currentdate >= "2021-05-21" then %>
                                <% if vEventID="111115" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111115);return false;" class="current"><span>21</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111115);return false;">21</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-24 -->
                            <% if currentdate >= "2021-05-24" then %>
                                <% if vEventID="111116" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111116);return false;" class="current"><span>24</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111116);return false;">24</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-25 -->
                            <% if currentdate >= "2021-05-25" then %>
                                <% if vEventID="111117" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111117);return false;" class="current"><span>25</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111117);return false;">25</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-26 -->
                            <% if currentdate >= "2021-05-26" then %>
                                <% if vEventID="111118" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111118);return false;" class="current"><span>25</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111118);return false;">26</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-27 -->
                            <% if currentdate >= "2021-05-27" then %>
                                <% if vEventID="111119" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111119);return false;" class="current"><span>27</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111119);return false;">27</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-28 -->
                            <% if currentdate >= "2021-05-28" then %>
                                <% if vEventID="111120" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111120);return false;" class="current"><span>28</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111120);return false;">28</a>
                                </div>
                                <% End If %>
                            <% End If %>
                            <!-- 2021-05-31 -->
                            <% if currentdate >= "2021-05-31" then %>
                                <% if vEventID="111121" then %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111121);return false;" class="current"><span>31</span></a>
                                </div>
                                <% else %>
                                <div class="swiper-slide">
                                    <a href="" onclick="goEventLink(111121);return false;">31</a>
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