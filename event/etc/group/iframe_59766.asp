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
.section5 {padding-bottom:50px;}
.evtList {overflow:hidden; margin-top:25px; }
.evtList li {float:left; position:relative; width:150px; height:190px; margin-top:25px; padding:0 20px; border-bottom:1px solid #ddd; text-align:left;}
.evtList li .effect {display:none; width:150px; height:150px; position:absolute; left:20px; top:0; background:url(http://fiximage.10x10.co.kr/web2013/play/fingers_evt_overon.png) left top no-repeat;}
.evtList li a {display:block;}
.evtList li a img {vertical-align:top;}
.evtList li a.on .figure {display:block; border:3px solid #ff8019;}
.evtList li a.on:hover .effect {display:none;}
.evtList li a.on .figure img {width:142px !important; height:142px !important; border:1px solid #fff;}
.evtList em {display:block; margin-top:7px; color:#555; font-size:11px;}
</style>
</head>
<body style="background-color:#fff;">
<div class="section5">
	<ul class="evtList">
		<li>
			<a href="/event/eventmain.asp?eventid=59766" target="_top" <%=CHKIIF(vEventID="59766"," class='on'","")%>>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59766/img_figure_01.jpg" width="150" height="150" alt="억의 쌍팔년도 덕복희여사 떡볶이" /></span>
				<em>간식을 드립니다 1탄</em>
			</a>
		</li>
		<li><!-- 3월 10일 화 오픈 //-->
			<% If Now() > #03/10/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=59767" target="_top" <%=CHKIIF(vEventID="59767"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59766/img_figure_02.jpg" width="150" height="150" alt="" /></span>
					<em>간식을 드립니다 2탄</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<li><!-- 3월 17일 화 오픈 //-->
			<% If Now() > #03/17/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=59798" target="_top" <%=CHKIIF(vEventID="59798"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59798/img_figure_03.jpg" width="150" height="150" alt="" /></span>
					<em>간식을 드립니다 3탄</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<li><!-- 3월 24일 화 오픈 //-->
			<% If Now() > #03/24/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=60646" target="_top" <%=CHKIIF(vEventID="60646"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60646/img_figure_04.jpg" width="150" height="150" alt="" /></span>
					<em>간식을 드립니다 4탄</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<li><!-- 3월 31일 화 오픈 //-->
			<% If Now() > #03/31/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=60882" target="_top" <%=CHKIIF(vEventID="60882"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60882/img_figure_05.jpg" width="150" height="150" alt="" /></span>
					<em>간식을 드립니다 5탄</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<li><!-- 4월 07일 화 오픈 //-->
			<% If Now() > #04/07/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=61241" target="_top" <%=CHKIIF(vEventID="61241"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61241/img_figure_06.jpg" width="150" height="150" alt="" /></span>
					<em>간식을 드립니다 6탄</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<% If Now() > #04/14/2015 00:00:00# Then %>
		<li><!-- 4월 14일 화 오픈 //-->
			<% If Now() > #04/14/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=61410" target="_top" <%=CHKIIF(vEventID="61410"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61410/img_figure_07.jpg" width="150" height="150" alt="" /></span>
					<em>간식을 드립니다 7탄</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<li><!-- 4월 21일 화 오픈 //-->
			<% If Now() > #04/21/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=8탄이벤트코드" target="_top" <%=CHKIIF(vEventID="8탄이벤트코드"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
					<em>준비 중입니다</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<li><!-- 4월 28일 화 오픈 //-->
			<% If Now() > #04/28/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=9탄이벤트코드" target="_top" <%=CHKIIF(vEventID="9탄이벤트코드"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
					<em>준비 중입니다</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<li><!-- 5월 05일 화 오픈 //-->
			<% If Now() > #05/05/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=10탄이벤트코드" target="_top" <%=CHKIIF(vEventID="10탄이벤트코드"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
					<em>준비 중입니다</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<li><!-- 5월 12일 화 오픈 //-->
			<% If Now() > #05/12/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=11탄이벤트코드" target="_top" <%=CHKIIF(vEventID="11탄이벤트코드"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
					<em>준비 중입니다</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<li><!-- 5월 19일 화 오픈 //-->
			<% If Now() > #05/19/2015 00:00:00# Then %>
				<a href="/event/eventmain.asp?eventid=12탄이벤트코드" target="_top" <%=CHKIIF(vEventID="12탄이벤트코드"," class='on'","")%>>
					<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
					<em>준비 중입니다</em>
				</a>
			<% Else %>
				<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2015/59767/img_coming_soon.png" width="150" height="150" alt="" /></span>
				<em>준비 중입니다</em>
			<% End If %>
		</li>
		<% End If %>
	</ul>

	<div class="paging tMar30">
		<a href="" onClick="return false;" class="first arrow"><span>맨 처음 페이지로 이동</span></a>
		<a href="" onClick="return false;" class="prev arrow"><span>이전페이지로 이동</span></a>
		<a href="" onClick="return false;" class="current"><span>1</span></a>
		<% If Now() > #05/26/2015 00:00:00# Then %>
		<a href="" onClick="return false;"><span>2</span></a>
		<% End If %>
		<a href="" onClick="return false;" class="next arrow"><span>다음 페이지로 이동</span></a>
		<a href="" onClick="return false;" class="end arrow"><span>맨 마지막 페이지로 이동</span></a>
	</div>
</div>
</body>
</html>