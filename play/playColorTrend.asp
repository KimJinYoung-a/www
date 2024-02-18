<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual ="/lib/classes/color/colortrend_cls.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
dim i, ocolor, colorcode, cColorT, vCurrPage, snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
Dim playcode : playcode = 3 '메뉴상단 번호를 지정 해주세요
	colorcode = getNumeric(requestcheckvar(request("colorcode"),2))
	vCurrPage = getNumeric(requestcheckvar(request("cpg"),10))
	If vCurrPage = "" Then
		vCurrPage = "1"
	End IF

	'/컬러칩 리스트
	set ocolor = new ccolortrend_list
		ocolor.frectcolorcode = colorcode
		ocolor.GetColorchips
	
		'/파라메타 체크
		if colorcode <> "" then
	
			'/존재하는 컬러인지 체크
			if ocolor.frectexists <> "Y" then
				response.write "<script type='text/javascript'>"
				response.write "	alert('존재하는 컬러코드가 아닙니다');"
				response.write "	history.go(-1);"
				response.write "</script>"
				dbget.close : response.end
			end if
		end if
		
	SET cColorT = New ccolortrend_list
	cColorT.frectcolorcode = colorcode
	cColorT.FPageSize = 3
	cColorT.FCurrPage = vCurrPage
	cColorT.frectuserid = GetLoginUserID()
	cColorT.GetColortrendlist

	strPageTitle = "텐바이텐 10X10 : 컬러트랜드"
	strPageDesc = "텐바이텐 PLAY - 컬러트랜드"
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/play/playColorTrend.asp?colorcode="&colorcode 	'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
$(function() {
	$('.colorchips li input').click(function(){
		$('.colorchips li').removeClass('selected');
		$(this).parent().addClass('selected');
	});
});
function jsGoPage(p){
	location.href = "/play/playColorTrend.asp?colorcode=<%=colorcode%>&cpg="+p+"";
}

function jsREgColorCode(cd){
	$(".favoriteAct").addClass("myFavor");
	TnAddFavoritecolor(cd);
}
</script>
</head>
<body>
<div class="wrap playWrapV15" id="playSub">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- #include virtual="/lib/inc/incPlayHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="playTit">
				<h2 class="ftLt"><a href="/play/playColorTrend.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/tit_color.gif" alt="COLOR TREND" /></a></h2>
			</div>

			<div class="colorTrend">
			<!-- #include virtual="/play/playColorTrand_colortab.asp" -->
			</div>
			<%
			if cColorT.fresultcount > 0 then
				For i=0 To (cColorT.fresultcount-1)
				
				snpTitle = Server.URLEncode(cColorT.FItemList(i).Fcolortitle)
				snpLink = Server.URLEncode("http://10x10.co.kr/play/playColorTrendView.asp?ctcode=" & cColorT.FItemList(i).fctcode)
				snpPre = Server.URLEncode("텐바이텐 컬러트랜드")
				snpTag = Server.URLEncode("텐바이텐 " & Replace(cColorT.FItemList(i).Fcolortitle," ",""))
				snpTag2 = Server.URLEncode("#10x10")
				snpImg = Server.URLEncode(cColorT.FItemList(i).FNmainimg)
			%>
				<div class="articleWrap">
					<div class="colorVisual">
						<span class="colorTag"><img src="http://fiximage.10x10.co.kr/web2013/play/ico_color_tag_<%=cColorT.FItemList(i).fcolorcode%>.png" alt="<%=UCase(fnColorTrendColorName(cColorT.FItemList(i).fcolorcode))%>" /></span>
						<p><img src="<%=cColorT.FItemList(i).FNmainimg%>" alt="<%=UCase(fnColorTrendColorName(cColorT.FItemList(i).fcolorcode))%> Image" usemap="#Mapmainimagenew<%=cColorT.FItemList(i).fctcode%>" /></p>
						<%=Replace(cColorT.FItemList(i).FImageMap,"<map name='Mapmainimagenew'>","<map name='Mapmainimagenew"&cColorT.FItemList(i).fctcode&"'>")%>
					</div>
					<div class="snsArea tPad13">
						<p class="colorTrTitle">No. <%=cColorT.FItemList(i).Fviewno%> / <a href="/play/playColorTrendView.asp?ctcode=<%=cColorT.FItemList(i).fctcode%>"><%=cColorT.FItemList(i).Fcolortitle%></a></p>
						<div class="sns">
							<ul>
								<!-- <li><a href="" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li> -->
								<li><a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
								<li><a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
								<li><a href="" onClick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
							</ul>
							<div id="mywish<%=cColorT.FItemList(i).fctcode%>" class="favoriteAct <%=CHKIIF(cColorT.FItemList(i).FExist="Y","myFavor","")%>" <% If GetLoginUserID <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%=cColorT.FItemList(i).fctcode%>','');"<% Else %>onclick="jsChklogin();"<% End If %>><strong><%=FormatNumber(cColorT.FItemList(i).Ftotregcnt,0)%></strong></div>
						</div>
					</div>
				</div>
			<%
				Next
			end if
			%>
			<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(vCurrPage,cColorT.FTotalCount,3,10,"jsGoPage") %></div>
			<div id="tempdiv" style="display:none" ></div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% SET cColorT = Nothing %>