<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
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
	
	Dim cPl, i, vStartDate, vState, vPage, vPageSize, vTotalCount, vCate, vLastDidx
	vStartDate = "getdate()"
	vState = "7"
	
	vCate = NullFillWith(RequestCheckVar(request("cate"),5),"")
	vPageSize = "19"
	'vPageSize = "7"
	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/playing/list.asp?cate=" & vCate
			REsponse.End
		end if
	end if
	
	SET cPl = New CPlay
	cPl.FRectIsMain		= False
	cPl.FCurrPage			= 1
	cPl.FRectTop			= 1*vPageSize
	cPl.FRectStartdate 	= vStartDate
	cPl.FRectState 		= vState
	cPl.FRectCate 		= vCate
	
	'### m.midx, m.volnum, m.title, m.mo_bgcolor
	cPl.fnPlayMainCornerList()
	vTotalCount = cPl.FTotalCount
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
var isloading=false;

$(function(){
	var menuTop = $("#headerPlayV16").offset().top;
	
	window.onload=function(){
		// 탑메뉴위치값 저장
		if( $(window).scrollTop()>=menuTop ) {
			$("#headerPlayV16").addClass("sticky");
		} else {
			$("#headerPlayV16").removeClass("sticky");
		}


	}

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
      
		//탑메뉴 플로팅
		if( $(window).scrollTop()>=menuTop ) {
			//스크롤 위치가 탑메뉴의 위치 보다 크면 플로팅
			$("#headerPlayV16").addClass("sticky");
		} else {
			//스크롤 위치가 탑메뉴의 위치 보다 작으면 원래위치
			$("#headerPlayV16").removeClass("sticky");
		}
	});
});

//톡리스트 아작스 호출
function getList() {
	var str = $.ajax({
			type: "GET",
	        url: "/playing/list_act.asp",
	        data: $("#playingfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;

	if(str!="") {
		
    	if($("#playingfrm input[name='cpg']").val()=="1") {
			isloading=false;
        } else {
       		$str = $(str)
       		$('#playingindexdiv').append($str);
        }
        isloading=false;
    } else {
    	isloading=true;
    	//$(window).unbind("scroll");
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
			<div class="article playListV15">
				<div class="listPlay">
					<div class="section">
						<div class="hgroup">
							<div class="inner">
								<h3 <%=CHKIIF(vCate="inspi","style=""font-size:26px;""","")%>><%=fnPlayingCateVer2("topname",vCate)%></h3>
								<p class="desc"><span></span><%=fnPlayingCateVer2("topcopy",vCate)%></p>
							</div>
						</div>
						<div class="listThumbnail">
							<%
							If (cPl.FResultCount < 1) Then
							Else
								For i = 0 To cPl.FResultCount-1
							%>
								<div class="<%=LCase(fnClassNameToCate(cPl.FItemList(i).Fcate))%>">
									<a href="view.asp?didx=<%=cPl.FItemList(i).Fdidx%>">
										<%
										'### 띵41,띵띵41,아지트3 이고 테그노출인경우. 노출기간, 발표일 기간 따로 정해져있음.
										If cPl.FItemList(i).Fcate = "1" OR cPl.FItemList(i).Fcate = "3" OR cPl.FItemList(i).Fcate = "41" OR cPl.FItemList(i).Fcate = "42" Then
											If cPl.FItemList(i).Fistagview Then
												If CDate(cPl.FItemList(i).Ftag_sdate) <= date() AND CDate(cPl.FItemList(i).Ftag_edate) => date() Then
													Response.Write "<span class=""label together""><em>참여</em></span>"
												End If
												If CDate(cPl.FItemList(i).Ftag_announcedate) <= date() Then
													Response.Write "<span class=""label done""><em>당첨<br />발표</em></span>"
												End If
											Else
												If DateDiff("d",cPl.FItemList(i).Fstartdate,Now()) < 4 Then	'### 오픈후 3일동안
													Response.Write "<span class=""label""><em>NEW</em></span>"
												End If
											End If
										Else
											If DateDiff("d",cPl.FItemList(i).Fstartdate,Now()) < 4 Then	'### 오픈후 3일동안
												Response.Write "<span class=""label""><em>NEW</em></span>"
											End If
										End IF
										
										Response.Write "<div class=""figure"">"
										Response.Write "	<img src=""" & cPl.FItemList(i).Fimgurl & """ width=""255"" height=""255"" alt="""" />"
										If cPl.FItemList(i).Fcate = "1" OR cPl.FItemList(i).Fcate = "3" OR cPl.FItemList(i).Fcate = "6" Then
											If cPl.FItemList(i).Fcate = "3" Then
												Response.Write "<span class=""ico""><img src="""&cPl.FItemList(i).Ficonimg&""" alt= """"/></span>"
											Else
												Response.Write "<span class=""ico""><img src=""http://fiximage.10x10.co.kr/m/2016/play/ico_pictogram_00"&cPl.FItemList(i).Fcate&".png"" alt= """"/></span>"
											End If
										End If
										If cPl.FItemList(i).Fcate = "5" Then
											Response.Write "<span class=""btnView""><i>보러가기</i></span>"
										End If
										Response.Write "</div>"
										%>
										<div class="desc">
											<p>
												<b><%=cPl.FItemList(i).Ftitle%></b>
												<span><%=fnPlayingCateVer2("topname",cPl.FItemList(i).Fcate)%></span>
												<%
												If cPl.FItemList(i).Fcate <> "5" Then
													Response.Write "<span class=""btnView""><i>보러가기</i></span>"
												End If
												%>
											</p>
										</div>
									</a>
								</div>
							<%
									vLastDidx = cPl.FItemList(i).Fdidx
								Next
							End If
							%>
							<div id="playingindexdiv"></div>
							<form id="playingfrm" name="playingfrm" method="get" style="margin:0px;">
								<input type="hidden" name="cpg" value="1" />
								<input type="hidden" name="cate" value="<%=vCate%>" />
								<input type="hidden" name="didx" value="<%=vLastDidx%>" />
							</form>
						</div>
					</div>

					<!-- more -->
					<!--
					<div class="btnMore">
						<a href=""><span>more</span></a>
					</div>
					//-->
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% SET cPl = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->