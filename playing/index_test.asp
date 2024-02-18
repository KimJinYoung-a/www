<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/playing/playingCls.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : PLAYing"		'페이지 타이틀 (필수)
	strPageDesc = "당신의 감성을 플레이하다"		'페이지 설명
	strPageImage = ""
	strPageKeyword = "PLAYing, 플레이"

	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/playing/"
			REsponse.End
		end if
	end if
	
	Dim cPl, i, intLoop, vVolArr, vCoArr, vStartDate, vState, vCate
	vStartDate = "getdate()"
	vState = "7"
	
	SET cPl = New CPlay
	cPl.FPageSize 		= 5
	cPl.FCurrPage			= 1
	cPl.FRectStartdate 	= vStartDate
	cPl.FRectState 		= vState
	
	'### m.midx, m.volnum, m.title, m.mo_bgcolor
	vVolArr = cPl.fnPlayMainVolList()
%>
<meta name="format-detection" content="telephone=no" />
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
var isloading=false;

$(function(){
	/* slide js */
	if ($("#slide > div").length > 1) {
		$("#slide").slidesjs({
			width:"1100",
			height:"540",
			pagination:{effect:"fade"},
			navigation:{effect:"fade"},
			play:{interval:2500, effect:"fade", auto:true},
			effect:{fade: {speed:1200, crossfade:true}}
		});
	}

	//스크롤 이벤트 시작
	$(window).unbind("scroll");
	$(window).scroll(function() {
      if ($(window).scrollTop() >= $(document).height() - $(window).height() - 50){
          if (isloading==false){
            isloading=true;
			var pg = $("#playingfrm input[name='cpg']").val();
			
			pg++;
			$("#playingfrm input[name='cpg']").val(pg);
			
            setTimeout("getList()",250);
          }
      }
	});
});

//톡리스트 아작스 호출
function getList() {
	var str = $.ajax({
			type: "GET",
	        url: "/playing/index_act.asp",
	        data: $("#playingfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;

	if(str!="") {
		
    	if($("#playingfrm input[name='cpg']").val()=="1") {
			isloading=false;
        } else {
       		$str = $(str)
       		$('#playingindexdiv').append($str).masonry('appended',$str);
        }
        isloading=false;
    } else {
    	$(window).unbind("scroll");
    }
}
</script>
</head>
<body>
<div id="playV16" class="wrap playV16">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<!-- #include file="./headerPlay.asp" -->
			<div class="article playMainV16">
				<div class="listPlay">
					<% IF isArray(vVolArr) THEN %>
					<div class="bg" style="background-color:#<%=vVolArr(3,0)%>;"></div>
					<div class="section typeA">
						<div class="hgroup">
							<h3>Vol.<%=Format00(3,vVolArr(1,0))%></h3>
							<p class="date"><%=vVolArr(2,0)%></p>
						</div>
						<div id="slide" class="slide">
						<%
						cPl.FRectIsMain = True
						cPl.FRectTop	= "100"
						cPl.FRectDevice = "1"
						cPl.FRectMIdx = vVolArr(0,0)
						vCoArr = cPl.fnPlayMainCornerList()
						'### d.didx, d.title, d.cate, ca.catename, d.startdate, imgurl, d.mo_bgcolor, d.titlestyle
						
						IF isArray(vCoArr) THEN
							For i=0 To UBound(vCoArr,2)
						%>
							<div class="<%=LCase(fnClassNameToCate(vCoArr(2,i)))%>">
								<a href="view.asp?didx=<%=vCoArr(0,i)%>" target="_blank">
									<%
									If DateDiff("d",vCoArr(4,i),Now()) < 4 Then	'### 오픈후 3일동안
										Response.Write "<span class=""label""><em></em>NEW</span>"
									End If
									
									Response.Write "<div class=""figure"">"
									Response.Write "<img src=""" & vCoArr(5,i) & """ alt="""" />"
									Response.Write "</div>"
									%>
									<div class="desc">
										<p>
											<b><%=db2html(vCoArr(8,i))%></b>
											<span><%=fnPlayingCateVer2("topname",vCoArr(2,i))%></span>
										</p>
									</div>
								</a>
							</div>
						<%
							Next
						End IF
						%>
						</div>
					</div>
					<% End If %>
					<%
					IF isArray(vVolArr) THEN
						For intLoop=1 To UBound(vVolArr,2)
					%>
						<div class="section <%=CHKIIF(intLoop=1,"typeB","")%>">
							<div class="hgroup">
								<h3>Vol.<%=Format00(3,vVolArr(1,intLoop))%></h3>
								<p class="date"><%=vVolArr(2,intLoop)%></p>
							</div>
							<ul>
							<%
							cPl.FRectIsMain = True
							cPl.FRectTop = "100"
							cPl.FRectDevice = "p"
							cPl.FRectMIdx = vVolArr(0,intLoop)
							vCoArr = cPl.fnPlayMainCornerList()
							'### d.didx, d.title, d.cate, ca.catename, d.startdate, imgurl, d.mo_bgcolor, d.iconimg
							
							IF isArray(vCoArr) THEN
								For i=0 To UBound(vCoArr,2)
							%>
								<li class="<%=LCase(fnClassNameToCate(vCoArr(2,i)))%>" <%=CHKIIF(vCoArr(2,i)=5,"style=""background-color:#"&vCoArr(6,i)&";""","")%>>
									<a href="view.asp?didx=<%=vCoArr(0,i)%>" target="_blank">
										<%
										'### 띵41,띵띵41,아지트3 이고 테그노출인경우. 노출기간, 발표일 기간 따로 정해져있음.
										If vCoArr(2,i) = "3" OR vCoArr(2,i) = "41" OR vCoArr(2,i) = "42" Then
											If vCoArr(9,i) Then
												If CDate(vCoArr(10,i)) <= date() AND CDate(vCoArr(11,i)) => date() Then
													Response.Write "<span class=""label together""><em>참여</em></span>"
												End If
												If CDate(vCoArr(12,i)) <= date() Then
													Response.Write "<span class=""label done""><em>당첨<br />발표</em></span>"
												End If
											Else
												If DateDiff("d",vCoArr(4,i),Now()) < 4 Then	'### 오픈후 3일동안
													Response.Write "<span class=""label""><em>NEW</em></span>"
												End If
											End If
										Else
											If DateDiff("d",vCoArr(4,i),Now()) < 4 Then	'### 오픈후 3일동안
												Response.Write "<span class=""label""><em>NEW</em></span>"
											End If
										End IF
										
										Response.Write "<div class=""figure"">"
										Response.Write "<img src=""" & vCoArr(5,i) & """ alt="""" />"
										If vCoArr(2,i) = "1" OR vCoArr(2,i) = "3" OR vCoArr(2,i) = "6" Then
											If vCoArr(2,i) = "3" Then
												Response.Write "<span class=""ico""><img src="""&fnPlayIconImgPCName(vCoArr(7,i))&""" alt= """"/></span>"
											Else
												Response.Write "<span class=""ico""><img src=""http://fiximage.10x10.co.kr/m/2016/play/ico_pictogram_00"&vCoArr(2,i)&"_pc.png"" alt= """"/></span>"
											End If
										End If
										If vCoArr(2,i) = "5" Then
											Response.Write "<span class=""btnView""><i>보러가기</i></span>"
										End If
										Response.Write "</div>"
										%>
										<div class="desc">
											<p>
												<b><%=db2html(vCoArr(1,i))%></b>
												<span><%=fnPlayingCateVer2("topname",vCoArr(2,i))%></span>
												<%
												If vCoArr(2,i) <> "5" Then
													Response.Write "<span class=""btnView""><i>보러가기</i></span>"
												End If
												%>
											</p>
										</div>
									</a>
								</li>
							<%
								Next
							End IF
							%>
							</ul>
						</div>
					<%
						Next
					End IF
					%>

					<div id="playingindexdiv"></div>
					<form id="playingfrm" name="playingfrm" method="get" style="margin:0px;">
						<input type="hidden" name="cpg" value="1" />
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->