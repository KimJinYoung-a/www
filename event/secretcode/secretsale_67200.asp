<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<% 'response.end %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<%'쇼핑찬스 이벤트 내용보기

dim eCode : eCode   = getNumeric(requestCheckVar(Request("eventid"),8)) '이벤트 코드번호
Dim strSql,userid, mysum , chk
'//logparam
Dim logparam : logparam = "&pEtr="&eCode

userid = GetencLoginUserID
IF application("Svr_Info") = "Dev" THEN
	eCode   =  65945
Else
	eCode   =  67200
End If

chk=requestCheckVar(request.Form("chk"),4)
If chk="" Then chk = "x"

If chk="o" then
			strSql = ""
			strSql = strSql & "Insert into db_event.dbo.tbl_event_subscript (evt_code, userid) values " & vbcrlf
			strSql = strSql & "('" & eCode & "','" & UserID & "')"
			dbget.execute(strSql)
End If

	strSql = ""
	strSql = strSql &"select count(*) from db_event.dbo.tbl_event_subscript where evt_code='" & eCode & "' and userid='" & UserID & "'"

	rsget.Open strsql,dbget,1
	mysum = rsget(0)
	rsget.Close

	if mysum = 0 or userid=""  then
			response.write "<script>location.replace('/event/secretcode/');</script>"
			dbget.close()	:	response.End
	End If

dim cEvent, cEventItem, arrItem, arrGroup, intI, intG, rdmNo
dim arrRecent, intR
dim bidx
dim ekind, emanager, escope, ename, esdate, eedate, estate, eregdate, epdate
dim ecategory, ecateMid, blnsale, blngift, blncoupon, blncomment, blnbbs, blnitemps, blnapply
dim etemplate, emimg, ehtml, eitemsort, ebrand,gimg,blnFull,blnItemifno,blnBlogURL, bimg, edispcate, vDisp, vIsWide, j
dim itemid : itemid = ""
dim egCode, itemlimitcnt,iTotCnt, strBrandListURL
dim cdl, cdm, cds
dim com_egCode : com_egCode = 0
Dim blnitempriceyn, clsEvt, isMyFavEvent, favCnt

IF eCode = "" THEN
	response.redirect("/shoppingtoday/shoppingchance_allevent.asp")
	dbget.close()	:	response.End
elseif Not(isNumeric(eCode)) then
	Call Alert_Return("잘못된 이벤트번호입니다.")
	dbget.close()	:	response.End
END IF

egCode = getNumeric(requestCheckVar(Request("eGC"),8))	'이벤트 그룹코드

IF egCode = "" THEN
	egCode = 0
end if


	itemlimitcnt = 105	'상품최대갯수
	'이벤트 개요 가져오기
	set cEvent = new ClsEvtCont
		cEvent.FECode = eCode

		cEvent.fnGetEvent

		eCode		= cEvent.FECode
		ekind		= cEvent.FEKind
		emanager	= cEvent.FEManager
		escope		= cEvent.FEScope
		ename		= cEvent.FEName
		esdate		= cEvent.FESDate
		eedate		= cEvent.FEEDate
		estate		= cEvent.FEState
		eregdate	= cEvent.FERegdate
		epdate		= cEvent.FEPDate
		ecategory	= cEvent.FECategory
		ecateMid	= cEvent.FECateMid
		blnsale		= cEvent.FSale
		blngift		= cEvent.FGift
		blncoupon	= cEvent.FCoupon
		blncomment	= cEvent.FComment
		blnBlogURL	= cEvent.FBlogURL
		blnbbs		= cEvent.FBBS
		blnitemps	= cEvent.FItemeps
		blnapply	= cEvent.FApply
		etemplate	= cEvent.FTemplate
		emimg		= cEvent.FEMimg
		ehtml		= cEvent.FEHtml
		eitemsort	= cEvent.FItemsort
		ebrand		= cEvent.FBrand
		gimg		= cEvent.FGimg
		blnFull		= cEvent.FFullYN
		blnItemifno = cEvent.FIteminfoYN

		If cEvent.FEItemID <> "0" OR cEvent.FEItemImg <> "" Then
			If cEvent.Fbasicimg600 <> "" Then
				bimg		= "http://webimage.10x10.co.kr/image/basic600/" & GetImageSubFolderByItemid(cEvent.FEItemID) & "/" & cEvent.Fbasicimg600 & ""
			Else
				bimg		= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(cEvent.FEItemID) & "/" & cEvent.Fbasicimg & ""
			End IF
		Else
			bimg		= ""
		End IF
		blnitempriceyn = cEvent.FItempriceYN
		favCnt		= cEvent.FfavCnt
		edispcate	= cEvent.FEDispCate
		vDisp		= edispcate
		vIsWide		= cEvent.FEWideYN

		IF etemplate = "3" OR etemplate = "7" THEN	'그룹형(etemplate = "3" or "7")일때만 그룹내용 가져오기
		cEvent.FEGCode = 	egCode
		arrGroup =  cEvent.fnGetEventGroup
		END IF

		cEvent.FECategory  = ecategory
		arrRecent = cEvent.fnGetRecentEvt
	set cEvent = nothing
		cdl = ecategory
		cdm = ecateMid

		IF vDisp = "" THEN blnFull= True	'카테고리가 없을경우 전체페이지로
		IF eCode = "" THEN
		Alert_return("유효하지 않은 이벤트 입니다.")
		dbget.close()	:	response.End
		END IF

	'// 내 관심 이벤트 확인
	if IsUserLoginOK then
		set clsEvt = new CMyFavoriteEvent
			clsEvt.FUserId = getEncLoginUserID
			clsEvt.FevtCode = eCode
			isMyFavEvent = clsEvt.fnIsMyFavEvent
		set clsEvt = nothing
	end if

	'// Facebook 오픈그래프 메타태그 작성
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] " & replace(ename,"""","") & """ />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & """ />" & vbCrLf
	if Not(bimg="" or isNull(bimg)) then
		strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""" & bimg & """ />" & vbCrLf &_
													"<link rel=""image_src"" href=""" & bimg & """ />" & vbCrLf
	end if
	
	strPageTitle = "텐바이텐 10X10 : " & ename
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/css/numSpinner.css" />
<script type="text/javascript">
$(function(){
	$(".evtSelect dt").click(function(){
		if($(".evtSelect dd").is(":hidden")){
			$(this).parent().children('dd').show("slide", { direction: "up" }, 300);
			$(this).addClass("over");
		}else{
			$(this).parent().children('dd').hide("slide", { direction: "up" }, 200);
		};
	});
	$(".evtSelect dd li").click(function(){
		var evtName = $(this).text();
		$(".evtSelect dt").removeClass("over");
		$(".evtSelect dd li").removeClass("on");
		$(this).addClass("on");
		$(this).parent().parent().parent().children('dt').children('span').text(evtName);
		$(this).parent().parent().hide("slide", { direction: "up" }, 200);
	});
	$(".evtSelect dd").mouseleave(function(){
		$(this).hide();
		$(".evtSelect dt").removeClass("over");
	});
	
	$(".evtFullZigZag div.evtPdtList:first").css("margin-top", "0");
	$(".evtFullZigZag div.evtPdtList:odd").addClass("evenWrap");
	$(".evtFullZigZag div.evtPdtList:even").addClass("oddWrap");

	//상품 후기
	$(".talkList .talkMore").hide();
	$(".talkList .talkShort").click(function(){
		$(".talkList .talkMore").hide();
		$(this).parent().parent().next('.talkMore').show();
	});
});

function fnMyEvent() {
<% If IsUserLoginOK Then %> 
	//AJAX처리 후 레이어처리
	$.ajax({
		url: "/my10x10/myfavorite_eventProc.asp?hidM=I&eventid=<%=eCode%>&pop=L",
		cache: false,
		async: false,
		success: function(message) {
			if(message!="0") {
				//확인 창 Open
				var vPopLayer = '<div class="window putPlayLyr" style="width:400px; height:315px;">';
				vPopLayer += '	<div class="popTop pngFix"><div class="pngFix"></div></div>';
				vPopLayer += '	<div class="popContWrap pngFix">';
				vPopLayer += '		<div class="popCont pngFix">';
				vPopLayer += '			<div class="popBody">';
				vPopLayer += '				<div class="popAlert">';
				if(message=="1") {
					vPopLayer += '					<p class="msg"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_event_message.gif" alt="관심 이벤트로 등록되었습니다." /></p>';
				} else {
					vPopLayer += '					<p class="msg"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_event_message_reput.gif" alt="이미 관심 이벤트로 등록되었습니다." /></p>';
				}
				vPopLayer += '					<div class="btnArea">';
				vPopLayer += '						<a href="/my10x10/myfavorite_event.asp" class="btn btnRed btnW150">관심 이벤트 확인하기</a>';
				vPopLayer += '						<a href="" onclick="ClosePopLayer();return false;" class="btn btnWhite btnW150">이벤트 계속보기</a>';
				vPopLayer += '					</div>';
				vPopLayer += '				</div>';
				vPopLayer += '			</div>';
				vPopLayer += '		</div>';
				vPopLayer += '	</div>';
				vPopLayer += '</div>';
				viewPoupLayer('modal',vPopLayer);

				//관심 체크표시
				if(!$("#evtFavCnt").hasClass("myFavor")) {
					var $opObj = $("#evtFavCnt");
					var fcnt = $opObj.find("strong").text().replace(/,/g,"");
					fcnt++;
					wfnt = setComma(fcnt);
					$opObj.find("strong").text(fcnt);
					$opObj.addClass('myFavor');
				}
			} else {
				alert("처리중 오류가 발생했습니다.");
			}
		}
	});
<% Else %>
	if(confirm("로그인 하시겠습니까?") == true) {
		top.location.href = "/login/loginpage.asp?backpath=<%=server.URLEncode(request.ServerVariables("URL"))%>&strGD=<%=server.URLEncode(request.ServerVariables("QUERY_STRING"))%>&strPD=<%=server.URLEncode(fnMakePostData)%>";
	 }
		return  ; 
<% End If %>
}
</script>
</head>
<body>
<div class="wrap">

	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container <%=chkIIF(Not(blnFull),"partEvt","fullEvt") %>">
	<%IF (datediff("d",eedate,date()) >0) OR (estate =9) THEN %>
		<div id="apDiv1" style="position:absolute;opacity:0.7;FILTER:alpha(opacity=70); z-index:5;<%=chkIIF(Not(blnFull),"width:760px;padding-left:200px;","width:960px;") %>padding-top:40px;height:250px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="500" align="center" bgcolor="#dddddd" class="prodtitle"><img src="http://fiximage.10x10.co.kr/web2008/enjoyevent/sorry.jpg" width="280" height="90" <% if GetLoginUserLevel()=7 then %>onclick="document.all.apDiv1.style.display='none';" style="cursor:pointer"<% end if %>></td>
		</tr>
		</table>
		</div>
	<%END IF%>
		<div id="contentWrap">

			<div class="eventWrap">
				<div class="evtHead snsArea">
					<dl class="evtSelect ftLt">
						<dt><span>이벤트 더보기</span></dt>
						<dd>
							<ul>
								<li><strong><a href="/shoppingtoday/shoppingchance_allevent.asp">엔조이 이벤트 전체 보기</a></strong></li>
								<%
								IF isArray(arrRecent) THEN
									For intR = 0 To UBound(arrRecent,2)
										if arrRecent(0,intR)<>eCode then
											Response.Write "<li><a href=""/event/eventmain.asp?eventid=" & arrRecent(0,intR) & """>" & db2html(arrRecent(1,intR)) & "</a></li>" & vbCrLf
										end if
									Next
								End If
								%>
							</ul>
						</dd>
					</dl>
					<div class="ftRt">
						<%IF ebrand<>"" THEN%><a href="javascript:GoToBrandShop('<%=ebrand%>');" class="ftLt btn btnS2 btnGrylight"><em class="gryArr01">브랜드 전상품 보기</em></a><% end if %>
						<div class="sns lMar10">
						<ul>
						<%
							'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
							dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
							snpTitle = URLEncodeUTF8(ename)
							snpLink = URLEncodeUTF8("http://10x10.co.kr/event/" & ecode)
							snpPre = URLEncodeUTF8("텐바이텐 이벤트")
							snpTag = URLEncodeUTF8("텐바이텐 " & Replace(ename," ",""))
							snpTag2 = URLEncodeUTF8("#10x10")
							snpImg = URLEncodeUTF8(emimg)
						%>
							<li><a href="" onclick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li>
							<li><a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
							<li><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
							<li><a href="" onclick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
						</ul>
						<% If bimg <> "" Then %><div id="evtFavCnt" class="favoriteAct <%=chkIIF(isMyFavEvent,"myFavor","")%>" onclick="fnMyEvent()"><strong><%=formatNumber(favCnt,0)%></strong></div><% End If %>
						</div>
					</div>
				</div>
				<%
				j = 0
				SELECT CASE etemplate
					CASE "3"	'그룹형(그룹기본:3)
						IF isArray(arrGroup) THEN
				%>
							<% If arrGroup(0,0) <> "" Then %>
							<div class="eventContV15 tMar15">
								<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>">
								<% if arrGroup(3,0) <> "" then %>
									<a name="event_namelink0"></a>
									<img src="<%=arrGroup(3,0)%>" alt="<%=egCode%>" usemap="#mapGroup<%=egCode%>" />
								<% end if %>
								<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,0))%></map>
								<div class="evtTermWrap"><div class="evtTerm"><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></div></div>
								</div>

				<%
							Response.Write "<div class=""evtPdtListWrapV15"">"
								egCode = arrGroup(0,0)
				%>
								<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
				<%
							Response.Write "</div>"
				%>
							</div>
							
							<%
							j = 1
							End If %>
				<%
							Response.Write "<div class=""evtPdtListWrapV15"">"
							For intG = j To UBound(arrGroup,2)
								egCode = arrGroup(0,intG)
				%>
								<% if arrGroup(3,intG) <> "" then %>
								<div class="pdtGroupBar" id="groupBar<%=intG%>" name="groupBar<%=intG%>">
									<a name="event_namelink<%=intG%>"></a>
									<img src="<%=arrGroup(3,intG)%>"  usemap="#mapGroup<%=egCode%>" alt="" />
								</div>
								<% end if %>
								<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,intG))%></map>
								<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
				<%
							Next
							Response.Write "</div>"
						END IF
					CASE "7" '그룹형(지그재그:7)
				%>
				<%
					CASE "5" '수작업
				%>
						<div class="eventCont tMar15" align="center">
							<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>">
							<%=ehtml%>
							<div class="evtTermWrap"><div class="evtTerm"><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></div></div>
							</div>
						</div>
				<%	CASE "6" '수작업+상품목록 %>
						<div class="eventCont tMar15" align="center">
							<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>">
							<%=ehtml%>
							<div class="evtTermWrap"><div class="evtTerm"><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></div></div>
							</div>
						</div>
					<div class="evtPdtListWrap <% IF Not blnItemifno THEN %>nonePdtInfo<% End If %>"><% sbEvtItemView %></div>
				<%	CASE ELSE '기본:메인이미지+상품목록 %>
					<div class="eventCont tMar15">
						<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>">
							<img src="<%=emimg%>" border="0" usemap="#Mainmap" />
							<%=ehtml%>
							<div class="evtTermWrap"><div class="evtTerm"><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></div></div>
						</div>
					</div>
					<div class="evtPdtListWrap <% IF Not blnItemifno THEN %>nonePdtInfo<% End If %>"><% sbEvtItemView %></div>
				<%	END SELECT %>

				<%IF blnbbs THEN %><!--게시판-->
				<div class="photoCmtWrap tMar40">
					<iframe id="evt_bbs" name="ptCmtView" src="/event/lib/bbs_list.asp?eventid=<%=eCode%>&blnF=<%=blnFull%>" width="100%" class="autoheight" frameborder="0" scrolling="no"></iframe>
				</div>
				<%END IF%>
				
				<%IF (blnitemps) THEN %><!--상품후기-->
				<div class="basicReviewWrap tMar40">
					<!-- #include virtual="/event/lib/evaluate_lib.asp" -->
				</div>
				<%END IF%>
	
				<%IF blncomment THEN %><!--코멘트-->
				<div class="basicCmtWrap tMar40">
					<iframe id="evt_cmt" src="/event/lib/iframe_comment.asp?eventid=<%=eCode%>&blnF=<%=blnFull%>&blnB=<%=blnBlogURL%>" width="100%" class="autoheight"  frameborder="0" scrolling="no"></iframe>
				</div>
				<% end if %>

			</div>
	

		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="frmEvt" method="post">
	<input type="hidden" name="hidM" value="I">
	<input type="hidden" name="eventid" value="<%=eCode%>">
</form>
<iframe id="wishProc1" name="wishProc1" src="about:blank" frameborder="0" width="0" height="0"></iframe>
<script type="text/javascript" src="/lib/js/jquery.iframe-auto-height.js"></script>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->