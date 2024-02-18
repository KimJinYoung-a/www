<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#############################################
' 그라운드 - 이종화
' 2013-09-30 
'#############################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Response.Redirect "/playing/"
	dbget.close
	Response.End
	
	Dim CurrPage , oGround ,  oGroundsub , oGroundsubcnt , i , oGroundTag , oGroundItem , ii , iii , tempi, oGroundOgImg
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	Dim playcode : playcode = 1 '메뉴상단 번호를 지정 해주세요
	Dim pagesize
	Dim gidx , subidx

	gidx = getNumeric(requestCheckVar(request("gidx"),8))
	subidx = getNumeric(requestCheckVar(request("gcidx"),8))
	
	If gidx = "" Then
		Set oGround = new CPlayContents
		oGround.GetRecentPG()
		gidx = oGround.FRecentGIdx
		subidx = oGround.FRecentGCIdx
		Set oGround = Nothing
	End IF
	
	If gidx = "" Then gidx = 0

	pagesize = 100 '과연 100개 이상?
	CurrPage = 1
	'//그라운드
	set oGround = new CPlayContents
		oGround.FPageSize = pagesize
		oGround.FCurrPage = CurrPage
		oGround.Fplaycode = playcode
		oGround.FRectIdx = gidx
		oGround.FRectsubIdx = subidx
		oGround.fnGetGroundMainList() '리스트들
		oGround.GetRowGroundMain() 'one view

	set oGroundsub = new CPlayContents
		If gidx = 0 then
		oGroundsub.FRectIdx = oGround.FItemList(0).Fidx
		Else 
		oGroundsub.FRectIdx = gidx
		End If 
		oGroundsub.fnGetGroundSubList() 'sublist

	set oGroundsubcnt = new CPlayContents
		If gidx = 0 Then 
		oGroundsubcnt.FRectIdx = oGround.FItemList(0).Fidx
		Else 
		oGroundsubcnt.FRectIdx = gidx
		End If 
		oGroundsubcnt.FRectsubIdx = subidx
		oGroundsubcnt.Fplaycode = playcode
		oGroundsubcnt.Fuserid = GetLoginUserID
		oGroundsubcnt.GetRowGroundSub() 'oneview

		If oGroundsubcnt.FOneItem.Fexec_check = "" Then
			oGroundsubcnt.FOneItem.Fexec_check = "1"
		End If 

	Set oGroundTag = new CPlayContents
		oGroundTag.FRectsubIdx = oGroundsubcnt.FOneItem.Fidx
		oGroundTag.GetRowTagContent() ' taglist

	Set oGroundOgImg = New CPlayContents
		If gidx = 0 Then 
			oGroundOgImg.FRectIdx = oGround.FItemList(0).Fidx
		Else 
			oGroundOgImg.FRectIdx = gidx
		End If 
		If subidx=0 Then
			oGroundOgImg.FRectsubIdx = oGroundsub.FItemList(0).Fidxsub
		Else 
			oGroundOgImg.FRectsubIdx = subidx
		End If 
		oGroundOgImg.GetGroundMainOgImg() '이미지

		snpTitle = Server.URLEncode("No."&oGround.FOneItem.Fviewno&" "&oGround.FOneItem.Fviewtitle)
		snpLink = Server.URLEncode("http://10x10.co.kr/play/playGround.asp?gidx=" & oGroundsubcnt.FOneItem.Fidxsub &"&gcidx="& oGroundsubcnt.FOneItem.Fidx &"")
		snpPre = Server.URLEncode("텐바이텐 그라운드")
		snpTag = Server.URLEncode("텐바이텐 " & Replace("#"&oGround.FOneItem.Fviewno&" "&oGround.FOneItem.Fviewtitle," ",""))
		snpTag2 = Server.URLEncode("#10x10")
		snpImg = Server.URLEncode(oGroundOgImg.FOneItem.Fplaymainimg)

	'// 페이지 타이틀 및 페이지 설명 작성
	If Left(now(), 10)>="2016-05-23" And Left(now(), 10) < "2016-05-27" Then
		'// 위에 일자 이후론 지워도됨(원승현 2016-05-23)
		strPageTitle = "Jazz UP Your Soul"		'페이지 타이틀 (필수)
		strPageDesc = "#서울재즈페스티벌 공식굿즈 둘러보고, 초대권도 받아야지! #텐바이텐 #서재페 #SJF2016"		'페이지 설명
		strPageImage = oGroundOgImg.FOneItem.Fplaymainimg		'페이지 요약 이미지(SNS 퍼가기용)
		strPageUrl = "http://bit.ly/10x10sjf2016"			'페이지 URL(SNS 퍼가기용)
	Else
		strPageTitle = "텐바이텐 10X10 : 그라운드 "& oGround.FOneItem.Fviewtitle		'페이지 타이틀 (필수)
		strPageDesc = "텐바이텐 PLAY - GROUND" & oGround.FOneItem.Fviewtitle		'페이지 설명
		strPageImage = oGroundOgImg.FOneItem.Fplaymainimg		'페이지 요약 이미지(SNS 퍼가기용)
		strPageUrl = "http://10x10.co.kr/play/playGround.asp?gidx=" & oGroundsubcnt.FOneItem.Fidxsub &"&gcidx="& oGroundsubcnt.FOneItem.Fidx &""			'페이지 URL(SNS 퍼가기용)
	End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
	$(function(){
		$(".grSubNav li > div.inner").mouseover(function(){
			if($(this).parent().hasClass("current")) {
				$(".grSubNav li .naviTxt").hide();
			} else {
				$(".grSubNav li .naviTxt").hide();
				$(this).children(".naviTxt").show();
			}
		});

		$(".grSubNav li > div.inner").mouseleave(function(){
			$(".grSubNav li .naviTxt").hide();
		});

		$(".grSubNav li > div.inner").click(function(){
			$(".grSubNav li p .onImg").hide();
			$(this).children("p").children(".onImg").show();
			$(".grSubNav li").removeClass("current");
			$(this).parent().addClass("current");
		});
	});

	function chgground(val)
	{
		var frm = document.frm;
		frm.gidx.value = val;
		frm.submit();
	}

	function chgsubground(val)
	{
		location.href="?gidx=<%=oGround.FOneItem.Fidx%>&gcidx="+val;
	}
</script>
</head>
<body>
<div class="wrap playWrapV15" id="playSub">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- #include virtual="/lib/inc/incPlayHeader.asp" -->
	<div class="container">
		<div class="groundWrap">
			<div id="contentWrap">
				<div class="groundHeadWrap" style="background-color:<%=oGroundsubcnt.FOneItem.FsubBGColor%>; background-image:url(<%=oGroundsubcnt.FOneItem.Ftopbgimg%>);">
					<form name="frm" method="get">
					<input type="hidden" name="gidx" value="<%=oGround.FOneItem.Fidx%>"/>
					<input type="hidden" name="gcidx" value=""/>
					</form>
					<div class="groundHead">
						<p class="rt">
							<% If oGround.FresultCount > 1 Then %>
							<select class="optSelect2" onchange="chgground(this.value);" style="width:250px;">
								<option>다른 그라운드 리스트 보기</option>
								<% For  i=0 to oGround.FresultCount-1%>
								<option value="<%=oGround.FItemList(i).Fidx%>" <%=chkiif(CStr(gidx) = CStr(oGround.FItemList(i).Fidx),"selected","" )%>><%=oGround.FItemList(i).Fviewtitle%></option>
								<% Next %>
							</select>
							<% End If %>
						</p>
						<div class="overHidden tPad20 bPad30">
							<div class="snsArea ftLt">
								<h2><img src="<%=oGround.FOneItem.Flistimg%>" alt="#<%=oGround.FOneItem.Fviewno%> <%=oGround.FOneItem.Fviewtitle%>" /></h2>
								<div class="sns">
									<ul>
										<!-- <li><a href="" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li> -->
										<li><a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
										<li><a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
										<li><a href="" onClick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
									</ul>
									<div id="mywish<%=oGroundsubcnt.FOneItem.Fidxsub%>" class="favoriteAct <%=chkiif(oGroundsubcnt.FOneItem.Fchkfav > 0 ,"myFavor","")%>" <% If GetLoginUserID <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%= oGroundsubcnt.FOneItem.Fidxsub %>','<%=oGroundsubcnt.FOneItem.Fidx%>');"<% Else %>onclick="jsChklogin();"<% End If %>><strong><%= FormatNumber(oGroundsubcnt.FOneItem.Ffavcnt,0) %></strong></div>
								</div>
							</div>
							<ul class="grSubNav">
								<% If oGroundsub.FresultCount > 0 Then %>
								<% For ii = 0 To oGroundsub.FresultCount-1 %>
								<li class="navi0<%=ii+1%> <%=chkiif(ii = 0 And subidx = "" Or( oGroundsubcnt.FOneItem.Fidx = oGroundsub.FItemList(ii).Fidxsub )," current","")%>  " onclick="chgsubground('<%=oGroundsub.FItemList(ii).Fidxsub%>'); return false;">
									<div class="inner">
										<div class="naviTxt"><p><%=oGroundsub.FItemList(ii).Fviewtitle%></p></div>
										<p><img src="<%=oGroundsub.FItemList(ii).Fviewthumbimg2%>" alt="<%=oGroundsub.FItemList(ii).Fviewtitle%>" class="offImg" /><img src="<%=oGroundsub.FItemList(ii).Fviewthumbimg1%>" alt="<%=oGroundsub.FItemList(ii).Fviewtitle%>" class="onImg" /></p>
									</div>
								</li>
								<% Next %>
								<% if ii Mod 4 > 0  then%>
									<% For iii = 1 To 4-(ii Mod 4)%>
										<li class="navi0<%=ii+iii%>" onclick=""></li>
									<% Next %>
								<% End If %>
								<% End If %>
							</ul>
						</div>
					</div>
				</div>
				<!-- 수작업 영역 시작 -->
				<% If oGroundsubcnt.FOneItem.Fexec_check = "1" Then %>
					<%=oGroundsubcnt.FOneItem.Fviewcontents%>
				<% else %>
					<% If checkFilePath(server.mappath(oGroundsubcnt.FOneItem.Fexec_filepath)) Then %>
						<%=oGroundsubcnt.FOneItem.Fviewcontents%>
						<% server.execute(oGroundsubcnt.FOneItem.Fexec_filepath)%>
					<% Else %>
					<%=oGroundsubcnt.FOneItem.Fviewcontents%>
					<% End If %>
				<% End If %>
				<!-- 수작업 영역 끝 -->
						<dl class="tagView tMar60">
							<% If oGroundTag.FTotalCount > 0 Then %>
							<dt class="ftLt">Tag</dt>
							<dd class="ftLt">
								<ul>
									<% For i = 0 To oGroundTag.FTotalCount -1 %>
									<li><span><a href="<%=chkiif(oGroundTag.FItemList(i).Ftagurl="","/search/search_result.asp?rect="&oGroundTag.FItemList(i).Ftagname&"",oGroundTag.FItemList(i).Ftagurl)%>"><%=oGroundTag.FItemList(i).Ftagname%></a></span></li>
									<% Next %>
								</ul>
							</dd>
							<% End If %>
						</dl>
					</div>
				</div>
			</div>
		</div>
		<div id="tempdiv" style="display:none" ></div>
		</div>
	</div>
	<script type="text/javascript" src="/lib/js/jquery.iframe-auto-height.js"></script>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
	Set oGroundTag = Nothing 
	Set oGroundsubcnt = Nothing 
	Set oGroundsub = Nothing 
	Set oGround = Nothing 
	Set oGroundOgImg = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->