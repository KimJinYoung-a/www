<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2015-03-09"

	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "69891" Then
		vStartNo = "0"
	ElseIf vEventID = "70636" Then
		vStartNo = "0"
	ElseIf vEventID = "71204" Then
		vStartNo = "0"
	ElseIf vEventID = "72704" Then
		vStartNo = "0"
	ElseIf vEventID = "73055" Then
		vStartNo = "0"
	ElseIf vEventID = "73817" Then
		vStartNo = "5"
	ElseIf vEventID = "74394" Then
		vStartNo = "5"
	ElseIf vEventID = "75084" Then
		vStartNo = "5"
	ElseIf vEventID = "75944" Then
		vStartNo = "5"
	ElseIf vEventID = "76882" Then
		vStartNo = "5"
	ElseIf vEventID = "77321" Then
		vStartNo = "10"
	ElseIf vEventID = "78015" Then
		vStartNo = "10"
	ElseIf vEventID = "78538" Then
		vStartNo = "10"
	ElseIf vEventID = "79201" Then
		vStartNo = "10"
	ElseIf vEventID = "79824" Then
		vStartNo = "10"
	ElseIf vEventID = "80681" Then
		vStartNo = "15"
	ElseIf vEventID = "81121" Then
		vStartNo = "15"
	ElseIf vEventID = "82050" Then
		vStartNo = "15"
	ElseIf vEventID = "82797" Then
		vStartNo = "15"
	ElseIf vEventID = "000" Then
		vStartNo = "15"
	End If

%>
<%
'#######################################################################
'	작업자 전달 사항
'
'	* 어드민에 소스 넣을때 뭐뭐뭐.asp 뒤에 ?eventid=코드 꼭 넣으세요!!
'	* 이 페이지에 소스 수정시 몇 탄이벤트코드 에 해당 코드 넣어주면 됩니다.
'
'#######################################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.hidden {visibility:hidden; width:0; height:0; overflow:hidden; position:absolute; top:-1000%; line-height:0;}

.rolling {position:relative; width:225px; padding:0 36px;}
.rolling .swiper {overflow:hidden;}
.rolling .swiper-container {overflow:hidden; height:26px;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {overflow:hidden; float:left; width:38px !important; margin-right:7px; height:26px;}
.rolling .swiper-wrapper .swiper-slide a,
.rolling .swiper-wrapper .swiper-slide span {overflow:hidden; display:block; position:relative; width:100%; height:100%; color:#fff; font-size:12px; line-height:26px; text-align:center; cursor:pointer;}
.rolling .swiper-wrapper .swiper-slide span i,
.rolling .swiper-wrapper .swiper-slide a i {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:#333 url(http://webimage.10x10.co.kr/eventIMG/2017/77321/img_navigator_v6.png) no-repeat 0 -26px;}
.rolling .swiper-wrapper .swiper-slide span i {background-position:0 0;}
.rolling .swiper-wrapper .swiper-slide a:hover i, .rolling .swiper-wrapper .swiper-slide a.on i {background-position:0 100%;}
.rolling .swiper-wrapper .swiper-slide.serise02 a i {background-position:-45px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise02 span i {background-position:-45px 0;}
.rolling .swiper-wrapper .swiper-slide.serise02 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise02 a.on i {background-position:-45px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise03 a i {background-position:-90px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise03 span i {background-position:-90px 0;}
.rolling .swiper-wrapper .swiper-slide.serise03 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise03 a.on i {background-position:-90px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise04 a i {background-position:-135px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise04 span i {background-position:-135px 0;}
.rolling .swiper-wrapper .swiper-slide.serise04 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise04 a.on i {background-position:-135px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise05 a i {background-position:-180px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise05 span i {background-position:-180px 0;}
.rolling .swiper-wrapper .swiper-slide.serise05 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise05 a.on i {background-position:-180px 100%;}
s
.rolling .swiper-wrapper .swiper-slide.serise06 a i {background-position:-225px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise06 span i {background-position:-225px 0;}
.rolling .swiper-wrapper .swiper-slide.serise06 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise06 a.on i {background-position:-225px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise07 a i {background-position:-270px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise07 span i {background-position:-270px 0;}
.rolling .swiper-wrapper .swiper-slide.serise07 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise07 a.on i {background-position:-270px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise08 a i {background-position:-315px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise08 span i {background-position:-315px 0;}
.rolling .swiper-wrapper .swiper-slide.serise08 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise08 a.on i {background-position:-315px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise09 a i {background-position:-360px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise09 span i {background-position:-360px 0;}
.rolling .swiper-wrapper .swiper-slide.serise09 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise09 a.on i {background-position:-360px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise10 a i {background-position:-405px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise10 span i {background-position:-405px 0;}
.rolling .swiper-wrapper .swiper-slide.serise10 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise10 a.on i {background-position:-405px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise11 a i {background-position:-449px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise11 span i {background-position:-449px 0;}
.rolling .swiper-wrapper .swiper-slide.serise11 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise11 a.on i {background-position:-449px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise12 a i {background-position:-495px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise12 span i {background-position:-495px 0;}
.rolling .swiper-wrapper .swiper-slide.serise12 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise12 a.on i {background-position:-495px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise13 a i {background-position:-540px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise13 span i {background-position:-540px 0;}
.rolling .swiper-wrapper .swiper-slide.serise13 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise13 a.on i {background-position:-540px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise14 a i {background-position:-585px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise14 span i {background-position:-585px 0;}
.rolling .swiper-wrapper .swiper-slide.serise14 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise14 a.on i {background-position:-585px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise15 a i {background-position:-629px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise15 span i {background-position:-629px 0;}
.rolling .swiper-wrapper .swiper-slide.serise15 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise15 a.on i {background-position:-629px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise16 a i {background-position:-672px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise16 span i {background-position:-672px 0;}
.rolling .swiper-wrapper .swiper-slide.serise16 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise16 a.on i {background-position:-672px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise17 a i {background-position:-717px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise17 span i {background-position:-717px 0;}
.rolling .swiper-wrapper .swiper-slide.serise17 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise17 a.on i {background-position:-717px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise18 a i {background-position:-762px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise18 span i {background-position:-762px 0;}
.rolling .swiper-wrapper .swiper-slide.serise18 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise18 a.on i {background-position:-762px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise19 a i {background-position:-806px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise19 span i {background-position:-806px 0;}
.rolling .swiper-wrapper .swiper-slide.serise19 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise19 a.on i {background-position:-806px 100%;}

.rolling .swiper-wrapper .swiper-slide.serise20 a i {background-position:-851px -26px;}
.rolling .swiper-wrapper .swiper-slide.serise20 span i {background-position:-851px 0;}
.rolling .swiper-wrapper .swiper-slide.serise20 a:hover i, .rolling .swiper-wrapper .swiper-slide.serise20 a.on i {background-position:-851px 100%;}

.rolling button {position:absolute; top:0; width:30px; height:26px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69891/btn_nav_serise_v1.png) no-repeat 0 0; text-indent:-9999em;}
.rolling .btn-prev {left:0;}
.rolling .btn-next {right:21px; background-position:100% 0;}
</style>
</head>
<body>
	<div id="rolling" class="rolling">
		<div class="swiper">
			<div class="swiper-container swiper1">
				<ul class="swiper-wrapper">
					<li class="swiper-slide serise01">
						<a href="/event/eventmain.asp?eventid=69891" target="_top" <%=CHKIIF(vEventID="69891"," class='on'","")%>><i></i>첫번째 이야기</a>
					</li>
					<% if currentdate < "2016-05-16" then %>
					<li class="swiper-slide serise02">
						<span><i></i>두번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise02">
						<a href="/event/eventmain.asp?eventid=70636" target="_top" <%=CHKIIF(vEventID="70636"," class='on'","")%>><i></i>두번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-06-20" then %>
					<li class="swiper-slide serise03">
						<span><i></i>세번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise03">
						<a href="/event/eventmain.asp?eventid=71204" target="_top" <%=CHKIIF(vEventID="71204"," class='on'","")%>><i></i>세번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-08-29" then %>
					<li class="swiper-slide serise04">
						<span><i></i>잇치킨 네번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise04">
						<a href="/event/eventmain.asp?eventid=72704" target="_top" <%=CHKIIF(vEventID="72704"," class='on'","")%>><i></i>네번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-09-21" then %>
					<li class="swiper-slide serise05">
						<span><i></i>다섯번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise05">
						<a href="/event/eventmain.asp?eventid=73055" target="_top" <%=CHKIIF(vEventID="73055"," class='on'","")%>><i></i>다섯번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-10-26" then %>
					<li class="swiper-slide serise06">
						<span><i></i>여섯번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise06">
						<a href="/event/eventmain.asp?eventid=73817" target="_top" <%=CHKIIF(vEventID="73817"," class='on'","")%>><i></i>여섯번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-11-23" then %>
					<li class="swiper-slide serise07">
						<span><i></i>일곱번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise07">
						<a href="/event/eventmain.asp?eventid=74394" target="_top" <%=CHKIIF(vEventID="74394"," class='on'","")%> title="Classic TEAPOT makes Perfect TEA"><i></i>일곱번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-12-21" then %>
					<li class="swiper-slide serise08">
						<span><i></i>여덟번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise08">
						<a href="/event/eventmain.asp?eventid=75084" target="_top" <%=CHKIIF(vEventID="75084"," class='on'","")%> title="음식을 담는 가장 아름다운 방법"><i></i>여덟번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-02-06" then %>
					<li class="swiper-slide serise09">
						<span><i></i>아홉번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise09">
						<a href="/event/eventmain.asp?eventid=75944" target="_top" <%=CHKIIF(vEventID="75944"," class='on'","")%> title="접시와 작품 그 사이"><i></i>아홈번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-03-22" then %>
					<li class="swiper-slide serise10">
						<span><i></i>열번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise10">
						<a href="/event/eventmain.asp?eventid=76882" target="_top" <%=CHKIIF(vEventID="76882"," class='on'","")%> title="접시와 작품 그 사이"><i></i>열번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-04-26" then %>
					<li class="swiper-slide serise11">
						<span><i></i>열한번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise11">
						<a href="/event/eventmain.asp?eventid=77321" target="_top" <%=CHKIIF(vEventID="77321"," class='on'","")%> title="DRESS UP YOUR TABL"><i></i>열한번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-05-23" then %>
					<li class="swiper-slide serise12">
						<span><i></i>열두번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise12">
						<a href="/event/eventmain.asp?eventid=78015" target="_top" <%=CHKIIF(vEventID="78015"," class='on'","")%> title=""><i></i>열두번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-06-19" then %>
					<li class="swiper-slide serise13">
						<span><i></i>열세번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise13">
						<a href="/event/eventmain.asp?eventid=78538" target="_top" <%=CHKIIF(vEventID="78538"," class='on'","")%> title=""><i></i>열세번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-07-18" then %>
					<li class="swiper-slide serise14">
						<span><i></i>열네번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise14">
						<a href="/event/eventmain.asp?eventid=79201" target="_top" <%=CHKIIF(vEventID="79201"," class='on'","")%> title=""><i></i>열네번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-08-22" then %>
					<li class="swiper-slide serise15">
						<span><i></i>열다섯번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise15">
						<a href="/event/eventmain.asp?eventid=79824" target="_top" <%=CHKIIF(vEventID="79824"," class='on'","")%> title=""><i></i>열다섯번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-09-26" then %>
					<li class="swiper-slide serise16">
						<span><i></i>열여섯번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise16">
						<a href="/event/eventmain.asp?eventid=80681" target="_top" <%=CHKIIF(vEventID="80681"," class='on'","")%> title=""><i></i>열여섯번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-10-18" then %>
					<li class="swiper-slide serise17">
						<span><i></i>열일곱번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise17">
						<a href="/event/eventmain.asp?eventid=81121" target="_top" <%=CHKIIF(vEventID="81121"," class='on'","")%> title=""><i></i>열일곱번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-11-21" then %>
					<li class="swiper-slide serise18">
						<span><i></i>열여덟번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise18">
						<a href="/event/eventmain.asp?eventid=82050" target="_top" <%=CHKIIF(vEventID="82050"," class='on'","")%> title=""><i></i>열여덟번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-12-19" then %>
					<li class="swiper-slide serise19">
						<span><i></i>열아홉번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise19">
						<a href="/event/eventmain.asp?eventid=82797" target="_top" <%=CHKIIF(vEventID="82797"," class='on'","")%> title=""><i></i>열아홉번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2018-01-26" then %>
					<li class="swiper-slide serise20">
						<span><i></i>스물번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise20">
						<a href="/event/eventmain.asp?eventid=000" target="_top" <%=CHKIIF(vEventID="000"," class='on'","")%> title=""><i></i>스물번째 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2018-02-26" then %>
					<li class="swiper-slide serise21">
						<span><i></i>스물한번번째 이야기</span>
					</li>
					<% Else %>
					<li class="swiper-slide serise21">
						<a href="/event/eventmain.asp?eventid=000" target="_top" <%=CHKIIF(vEventID="000"," class='on'","")%> title=""><i></i>스물한번번째 이야기</a>
					</li>
					<% End If %>

				</ul>
			</div>
			<button type="button" class="btn-nav btn-prev">Previous</button>
			<button type="button" class="btn-nav btn-next">Next</button>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	/* swipe */
	if ($("#rolling .swiper .swiper-container .swiper-slide").length > 5) {
		var swiper1 = new Swiper("#rolling .swiper1",{
			initialSlide:<%=vStartNo%>,
			loop:false,
			speed:1000,
			autoplay:false,
			slidesPerView:5,
			slidesPerGroup:5,
			simulateTouch:false,
			onSlideChangeStart: function () {
				$('.btn-prev').show()
				$('.btn-next').show()
				if(mySwiper.activeIndex==0){
					$('.btn-prev').hide()
				}
				if(mySwiper.activeIndex==mySwiper.slides.length-1){
					$('.btn-next').hide()
				}
			}
		});
	} else {
		$("#rolling .btn-prev").hide();
		$("#rolling .btn-next").hide();
	}

	$("#rolling .btn-prev").on("click", function(e){
		e.preventDefault()
		swiper1.swipePrev()
	})
	$("#rolling .btn-next").on("click", function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$("#rolling .swiper .swiper-slide span").click(function(){
		alert("오픈 예정입니다.");
	});
});
</script>
</html>