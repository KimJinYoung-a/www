<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- <base href="//www.10x10.co.kr/"> -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2018-08-20"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "93409" Then '// vol.01
		vStartNo = "0"
	ElseIf vEventID = "93410" Then '// vol.02
		vStartNo = "0"
	ElseIf vEventID = "93411" Then '// vol.03
		vStartNo = "0"
	ElseIf vEventID = "93412" Then '// vol.04
		vStartNo = "0"
	ElseIf vEventID = "93413" Then '// vol.05
		vStartNo = "0"
	ElseIf vEventID = "93414" Then '// vol.06
		vStartNo = "0"
	ElseIf vEventID = "93415" Then '// vol.07
		vStartNo = "3"
	ElseIf vEventID = "93416" Then '// vol.08
		vStartNo = "3"
	ElseIf vEventID = "93417" Then '// vol.09
		vStartNo = "3"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigation {position:relative; overflow:hidden; padding:0 80px;}
.navigation li {position: relative; float:left; height:115px; line-height:115px; font-family:'Roboto','Noto Sans KR',sans-serif; font-size:16px; color:#a5a5a5; text-align:center;}
.navigation li.open a {color:#4a4a4a;}
.navigation li.current a {color:#ff6674;}
.navigation li a,
.navigation li p {display:block; position:relative; width:90%; height:40px; line-height: 40px; margin:27px auto 0; text-decoration:none;}
.navigation button {display:block; position:absolute; top:33px; width:19px; height:24px; padding:5px; font-size:0; background-color:transparent; outline:none;}
.navigation .btnPrev {left:30px;}
.navigation .btnNext {right:30px;}
/*.grp:before {content: ''; position: absolute; top: 14px; left: 15px; display: block; width: 466px; height: 1px; background-color: #a9a9a9;}
.grp:after {position: absolute; display: block; top: 0; left: 193px; width: 110px; height:30px; color: #acacac; text-align: center; line-height: 30px; background-color: #fafafa;}
.grp.open:before {content: ''; position: absolute; top: 14px; left: 25px; display: block; width: 446px; height: 1px; background-color: #656565;}
.grp.open:after {position: absolute; display: block; top: 0; left: 193px; width: 110px; height:30px; color: #656565; text-align: center; line-height: 30px; background-color: #fafafa;}
.grp-01:after {content: '4월1일(월)~'; }
.grp-02:after {content: '4월4일(목)~'; }
.grp-03:after {content: '4월8일(월)~'; }*/
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigation .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:6,
		slidesPerGroup:3,
		speed:200
	})
	$('.navigation .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.navigation .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
	$('.swiper-slide.next').on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다.");
	});
});
</script>
</head>
<body>
<div class="navigation">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<li class="grp grp-01 swiper-slide open <%=CHKIIF(vEventID="93409"," current","")%>"><a href="/event/eventmain.asp?eventid=93409" target="_top">#자취생활</a></li>
			<li class="swiper-slide open <%=CHKIIF(vEventID="93410"," current","")%>"><a href="/event/eventmain.asp?eventid=93410" target="_top">#데스크테리어</a></li>
			<li class="swiper-slide open <%=CHKIIF(vEventID="93411"," current","")%>"><a href="/event/eventmain.asp?eventid=93411" target="_top">#좋은냄새</a></li>

			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2019-04-04" then %>
			<li class="grp grp-02 swiper-slide next"><p>#정리왕</p></li>
			<li class="swiper-slide next"><p>#심야식당</p></li>
			<li class="swiper-slide next"><p>#부기빼는법</p></li>
			<% Else %>
			<li class="grp grp-02 swiper-slide open <%=CHKIIF(vEventID="93412"," current","")%>"><a href="/event/eventmain.asp?eventid=93412" target="_top">#정리왕</a></li>
			<li class="swiper-slide open <%=CHKIIF(vEventID="93413"," current","")%>"><a href="/event/eventmain.asp?eventid=93413" target="_top">#심야식당</a></li>
			<li class="swiper-slide open <%=CHKIIF(vEventID="93414"," current","")%>"><a href="/event/eventmain.asp?eventid=93414" target="_top">#부기빼는법</a></li>
			<% End If %>

			<% if currentdate < "2019-04-08" then %>
			<li class="grp grp-03 swiper-slide next"><p>#1+1</p></li>
			<li class="swiper-slide next"><p>#여백채우기</p></li>
			<li class="swiper-slide next"><p>#기분좋은하루</p></li>
			<% Else %>
			<li class="grp grp-03 swiper-slide open <%=CHKIIF(vEventID="93415"," current","")%>"><a href="/event/eventmain.asp?eventid=93415" target="_top">#1+1</a></li>
			<li class="swiper-slide open <%=CHKIIF(vEventID="93416"," current","")%>"><a href="/event/eventmain.asp?eventid=93416" target="_top">#여백채우기</a></li>
			<li class="swiper-slide open <%=CHKIIF(vEventID="93417"," current","")%>"><a href="/event/eventmain.asp?eventid=93417" target="_top">#기분좋은하루</a></li>
			<% End If %>
		</ul>
	</div>
	<button class="btnPrev"><svg  xmlns="http://www.w3.org/2000/svg"  xmlns:xlink="http://www.w3.org/1999/xlink"  width="10px" height="16px"> <path fill-rule="evenodd"  opacity="0.302" fill="rgb(0, 0, 0)"  d="M9.502,15.206 L8.719,16.012 L0.943,9.240 L0.777,9.387 L-0.009,8.563 L8.545,0.983 L9.332,1.807 L1.790,8.490 L9.502,15.206 Z"/> </svg></button>
	<button class="btnNext"><svg  xmlns="http://www.w3.org/2000/svg"  xmlns:xlink="http://www.w3.org/1999/xlink"  width="10px" height="16px"> <path fill-rule="evenodd"  opacity="0.302" fill="rgb(0, 0, 0)"  d="M9.210,9.387 L9.041,9.240 L1.114,16.012 L0.315,15.206 L8.178,8.490 L0.488,1.807 L1.290,0.983 L10.012,8.563 L9.210,9.387 Z"/> </svg></button>
</div>
</body>
</html>