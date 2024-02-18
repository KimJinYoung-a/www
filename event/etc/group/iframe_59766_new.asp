<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################################
'	작업자 전달 사항
'
'	* 어드민에 소스 넣을때 뭐뭐뭐.asp 뒤에 ?eventid=코드 꼭 넣으세요!!
'	* 이 페이지에 소스 수정시 몇 탄이벤트코드 에 해당 코드 넣어주면 됩니다.
'	* 5월 19일 화 오픈까지 작업되어있습니다. 딱 1페이지.
'	* 2페이지가 작업되어야 하면 미리 알려주세요.
'
'#######################################################################
	Dim vEventID
	vEventID = requestCheckVar(Request("eventid"),8)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* iframe */
.series {overflow:hidden; position:relative; width:1140px; margin:0 auto;}
.series .swiper {padding:50px 0; width:1110px; margin-left:30px;}
.series .swiper-container {overflow:hidden;}
.series .swiper-wrapper {position:relative;}
.series .swiper .swiper-slide {float:left; width:185px;}
.series .swiper-slide a {display:block; width:185px; margin:0 auto;}
.series .swiper-slide .figure {display:block; width:150px; height:150px;}
.series .swiper-slide em {display:block; margin-top:7px; color:#555; font-size:11px; text-align:left;}
.series .on .figure {display:block; width:144px; height:144px; border:3px solid #ff8019;}
.series .on .figure img {width:142px !important; height:142px !important; border:1px solid #fff;}
.series .btn-nav {position:absolute; top:50px; width:20px; height:150px; background-color:transparent; background-repeat:no-repeat; background-position:0 50%; text-indent:-999em;}
.series .prev {left:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/61410/btn_nav_prev.png);}
.series .next {right:0; background-position:100% 50%; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/61410/btn_nav_next.png);}
</style>
</head>
<body style="background-color:#fff;">
	<div class="series">
		<div class="swiper">
			<div class="swiper-container swiper1">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=59766" target="_top" <%=CHKIIF(vEventID="59766"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59766/img_figure_01.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 1탄</em>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=59767" target="_top" <%=CHKIIF(vEventID="59767"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59766/img_figure_02.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 2탄</em>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=59798" target="_top" <%=CHKIIF(vEventID="59798"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59798/img_figure_03.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 3탄</em>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=60646" target="_top" <%=CHKIIF(vEventID="60646"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60646/img_figure_04.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 4탄</em>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=60882" target="_top" <%=CHKIIF(vEventID="60882"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60882/img_figure_05.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 5탄</em>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=61241" target="_top" <%=CHKIIF(vEventID="61241"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61241/img_figure_06.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 6탄</em>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=61410" target="_top" <%=CHKIIF(vEventID="61410"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61410/img_figure_07.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 7탄</em>
						</a>
					</div>
					<div class="swiper-slide">
						<% If Now() > #04/21/2015 00:00:00# Then %>
							<a href="/event/eventmain.asp?eventid=61635" target="_top" <%=CHKIIF(vEventID="61635"," class='on'","")%>>
								<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61635/img_figure_08.jpg" width="150" height="150" alt="" /></span>
								<em>간식을 드립니다 8탄</em>
							</a>
						<% Else %>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 8탄</em>
						<% End If %>
					</div>
					<% If Now() > #04/28/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=61916" target="_top" <%=CHKIIF(vEventID="61916"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61916/img_figure_09.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 9탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #05/05/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=62207" target="_top" <%=CHKIIF(vEventID="62207"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62207/img_figure_10.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 10탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #05/12/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=62365" target="_top" <%=CHKIIF(vEventID="62365"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62365/img_figure_11.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 11탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #05/19/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=62601" target="_top" <%=CHKIIF(vEventID="62601"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62601/img_figure_12.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 12탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #05/26/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=62832" target="_top" <%=CHKIIF(vEventID="62832"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62832/img_figure_13.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 13탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #06/02/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=63056" target="_top" <%=CHKIIF(vEventID="63056"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/63056/img_figure_14.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 14탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #06/09/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=63491" target="_top" <%=CHKIIF(vEventID="63491"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/63491/img_figure_15.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 15탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #06/16/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=63763" target="_top" <%=CHKIIF(vEventID="63763"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/63763/img_figure_16.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 16탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #06/23/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=64032" target="_top" <%=CHKIIF(vEventID="64032"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/64032/img_figure_17.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 17탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #06/30/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=64348" target="_top" <%=CHKIIF(vEventID="64348"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/64348/img_figure_18_v1.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 18탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #07/07/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=64649" target="_top" <%=CHKIIF(vEventID="64649"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/64649/img_figure_19.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 19탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #07/14/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=64862" target="_top" <%=CHKIIF(vEventID="64862"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/64862/img_figure_20.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 20탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #07/21/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=65027" target="_top" <%=CHKIIF(vEventID="65027"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65027/img_figure_21.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 21탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #07/28/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=65156" target="_top" <%=CHKIIF(vEventID="65156"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65156/img_figure_22.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 22탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #08/04/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=65306" target="_top" <%=CHKIIF(vEventID="65306"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65306/img_figure_23.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 23탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #08/11/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=65475" target="_top" <%=CHKIIF(vEventID="65475"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65475/img_figure_24.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 24탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #08/18/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=65630" target="_top" <%=CHKIIF(vEventID="65630"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65630/img_figure_25.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 25탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #08/25/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=65776" target="_top" <%=CHKIIF(vEventID="65776"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65776/img_figure_26.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 26탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #09/01/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=65906" target="_top" <%=CHKIIF(vEventID="65906"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65906/img_figure_27.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 27탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #09/08/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=66056" target="_top" <%=CHKIIF(vEventID="66056"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66056/img_figure_28.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 28탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #09/15/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=66218" target="_top" <%=CHKIIF(vEventID="66218"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66080/img_figure_29.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 29탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #09/22/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=66362" target="_top" <%=CHKIIF(vEventID="66362"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66362/img_figure_30.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 30탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #10/06/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=66590" target="_top" <%=CHKIIF(vEventID="66590"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66590/img_figure_31.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 31탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #10/13/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=66755" target="_top" <%=CHKIIF(vEventID="66755"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66755/img_figure_32.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 32탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #10/20/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=66837" target="_top" <%=CHKIIF(vEventID="66837"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66837/img_figure_33.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 33탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #10/27/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=66905" target="_top" <%=CHKIIF(vEventID="66905"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66905/img_figure_34.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 34탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #11/04/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=67213" target="_top" <%=CHKIIF(vEventID="67213"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67213/img_figure_35.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 35탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #11/11/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=67380" target="_top" <%=CHKIIF(vEventID="67380"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67380/img_figure_36.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 36탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #11/17/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=67525" target="_top" <%=CHKIIF(vEventID="67525"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67525/img_figure_37.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 37탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #11/24/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=67677" target="_top" <%=CHKIIF(vEventID="67677"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67677/img_figure_38.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 38탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #12/01/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=67760" target="_top" <%=CHKIIF(vEventID="67760"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67760/img_figure_39.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 39탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #12/08/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=67919" target="_top" <%=CHKIIF(vEventID="67919"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67919/img_figure_40.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 40탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #12/15/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=68093" target="_top" <%=CHKIIF(vEventID="68093"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68093/img_figure_41.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 41탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #12/22/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=68264" target="_top" <%=CHKIIF(vEventID="68264"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68264/img_figure_42.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 42탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #12/29/2015 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=68392" target="_top" <%=CHKIIF(vEventID="68392"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68392/img_figure_43.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 43탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #01/05/2016 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=68481" target="_top" <%=CHKIIF(vEventID="68481"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68481/img_figure_44.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 44탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #01/12/2016 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=68634" target="_top" <%=CHKIIF(vEventID="68634"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68634/img_figure_45.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 45탄</em>
						</a>
					</div>
					<% End If %>
					<% If Now() > #01/19/2016 00:00:00# Then %>
					<div class="swiper-slide">
						<a href="/event/eventmain.asp?eventid=68720" target="_top" <%=CHKIIF(vEventID="68720"," class='on'","")%>>
							<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68720/img_figure_46.jpg" width="150" height="150" alt="" /></span>
							<em>간식을 드립니다 46탄</em>
						</a>
					</div>
					<% End If %>
				</div>
			</div>
		</div>
		<button type="button" class="btn-nav prev">이전</button>
		<button type="button" class="btn-nav next">다음</button>
		<div class="pagination pagination1"></div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	/* swipe */
	mySwiper = new Swiper('.swiper1',{
		slidesPerView:6,
		loop:false,
		resizeReInit:true,
		calculateHeight:true,
		pagination:false,
		paginationClickable:true,
		speed:1000,
		autoplay:false,
		autoplayDisableOnInteraction: true,
		allowSwipeToPrev:true,
		<% If Now() > #01/19/2016 00:00:00# Then %>
			initialSlide:43
		<% Else %>
			initialSlide:42
		<% End If %>
	});

	$('.prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});
	$('.next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
});
</script>
</html>