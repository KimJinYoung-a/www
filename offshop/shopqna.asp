<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/shopqna.asp
' Description : 오프라인샾 QnA
' History : 2009.07.14 강준구 생성
'           2009.08.13 허진원 탑배너 및 내용 크기 수정
'           2018.06.14 정태훈 리뉴얼
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/inc/offshopCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/offshop/inc/commonFunction.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim ClsOSQNA, uid
Dim arrQNA, intQ ,replyYN
Dim iTotCnt,iCurrentPage,iPageSize, iPerCnt
Dim iStartPage, iEndPage, iTotalPage
Dim idx, suserid, stitle, sitemid, scontents, sregdate, sreplyuser, sreplycontents, sreplydate
dim simg, sbrand, sitemname, scash
dim cookieuserid,cookieuseremail,cookieusername, searchdiv, searchtext

cookieuserid 	= GetLoginUserID
cookieuseremail = GetLoginUserEmail
cookieusername 	= GetLoginUserName

'매장 정보 가져오기
Dim offshopinfo, shopid, myqna
shopid = requestCheckVar(request("shopid"),16)
myqna = requestCheckVar(request("myqna"),1)

if myqna="Y" then
	uid=cookieuserid
end if

searchdiv = requestCheckVar(request("searchdiv"),10)
If searchdiv="" Then searchdiv="userid"
searchtext = requestCheckVar(request("searchtext"),16)
'Response.write searchdiv
'Response.end
Set  offshopinfo = New COffShop
offshopinfo.FRectShopID=shopid
offshopinfo.GetOneOffShopContents

	iCurrentPage	= requestCheckVar(Request("iCP"),10)
	iTotCnt			= requestCheckVar(Request("iTC"),10)
	idx 			= requestCheckVar(Request("idx"),10)
	IF iCurrentPage = "" THEN
		iCurrentPage = 1
	END IF

	iPageSize = 15
	iPerCnt	= 10

set ClsOSQNA = new COffShopQNA
	ClsOSQNA.FShopId = shopid
	ClsOSQNA.FCPage	= iCurrentPage
	ClsOSQNA.FPSize	= iPageSize
	ClsOSQNA.FUserID	= uid
	ClsOSQNA.FRectSearchDiv=searchdiv
	ClsOSQNA.FRectSearchText=searchtext
	arrQNA = ClsOSQNA.fnGetShopQNA
	iTotCnt = ClsOSQNA.FTotCnt
set ClsOSQNA = nothing

	iTotalPage 	=  Int(iTotCnt/iPageSize)
    IF (iTotCnt MOD iPageSize) > 0 THEN	iTotalPage = iTotalPage + 1
%>
<script language="javascript">
<!--
	// 문의하기
	function jsQNAWrite(){
		location.href = "shopqna_write.asp?iCP=<%=iCurrentPage%>&shopid=<%=shopid%>&menuid=3";
	}

	function jsMyQNA(sid){
		if (sid == "")
		{
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		if($("#myqna").val()=="Y")
		{
			location.href = "shopqna.asp?shopid=<%=shopid%>&menuid=3&myqna=N";
			$("#myqna").val("N");
		}
		else
		{
			location.href = "shopqna.asp?shopid=<%=shopid%>&menuid=3&myqna=Y";
			$("#myqna").val("Y");
		}
	}

	//페이지이동
	function jsGoPage(iP){
		document.frmN.iCP.value = iP;
		document.frmN.action = "shopqna.asp";
		document.frmN.submit();
	}
	function jsDel(idx){
		if(confirm("작성된 질문글을 삭제하시겠습니까?")){
			document.frmN.idx.value = idx;
			document.frmN.sMode.value = "D";
			document.frmN.action = "processqna.asp";
			document.frmN.submit();
		}
	}

	function showhideQNA(num, p_totcount)	{
	  for (i=0; i<=p_totcount; i++)   {
		  menu=eval("document.all.QNAblock"+i+".style");

		  if (num==i ){
			if (menu.display=="table-row"){
				menu.display="none";
			}else{
			  menu.display="table-row";
	//		  CheckHit(faqId);	// 메인에서는 카운트 올리지 않음
			}
		  }else{
			 menu.display="none";
		  }
		}
	}

	function fnSearchOffshopQnA(){
		document.frmN.action = "shopqna.asp";
		document.frmN.submit();
	}
//-->
</script>
<script type="text/javascript">
$(function() {
	// control board list
	$(".board-list .specific-conts").hide();

	// my-qna
	$(".my-question").click(function () {
		$(".offshop-qna").toggleClass('my-qna');
	});

	// customized-select
	$(".sorting-select dt").click(function(){
		$(this).toggleClass("over");
		if($(".sorting-select dd").is(":hidden")){
			$(this).parent().children('dd').show("slide", { direction: "up" }, 300);
		}else{
			$(this).parent().children('dd').hide("slide", { direction: "up" }, 200);
		};
	});
	$(".sorting-select dd li").click(function(){
		var sorting = $(this).text();
		var selectStr="";
		var currentSorting=$(this).parent().parent().parent().children('dt').children('span').text();
		$(".sorting-select dt").removeClass("over");
		$(".sorting-select dd li").removeClass("on");
		$(this).addClass("on");
		$(this).parent().parent().parent().children('dt').children('span').text(sorting);
		$(this).append("<li></li>").text(currentSorting);
		$(this).parent().parent().hide("slide", { direction: "up" }, 200);
		if(sorting=="제목")
		{
			selectStr="title";
		}
		else
		{
			selectStr="userid";
		}
		$("#searchdiv").val(selectStr);
	});
	$(".sorting-select dd").mouseleave(function(){
		$(this).hide();
		$(".sorting-select dt").removeClass("over");
	});
});
function jsGuestDel(idx){
	document.dfrm.idx.value=idx;
	$('.ly-offshop').show();
	stoppedScroll();
}
function jsGuestDelete(){
	if(confirm("작성된 질문글을 삭제하시겠습니까?")){
		document.dfrm.action = "processqna.asp";
		document.dfrm.submit();
	}
}
</script>
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container offshopV18">
		<div id="contentWrap">
			<!-- #include virtual="/offshop/inc/incHeader.asp" -->
			<div class="offshop-conts offshop-qna<% If uid<>"" Then Response.write " my-qna" %>">

				<!-- 질문과 답변 리스트 -->
				<div class="board-list">
					<form name="frmN" method="post">
					<h3>질문과 답변</h3>

					<!-- (비회원) 작성글 검색 -->
					<div class="search-form">
						<dl class="sorting-select ftLt">
							<dt><span><% If searchdiv="userid" Then %>작성자<% Else %>제목<% End If %></span></dt>
							<dd>
								<ul>
									<li><% If searchdiv="userid" Then %>제목<% Else %>작성자<% End If %></li>
								</ul>
							</dd>
						</dl>
						<p><input type="text" name="searchtext" value="<%=searchtext%>"></p>
						<button type="submit" class="btn-search" onfocus="this.blur();" onClick="fnSearchOffshopQnA('<%=cookieuserid%>');"><span>검색</span></button>
					</div>
					<!--// (비회원)작성글 검색 -->

					<div class="btn-group">
						<% If cookieuserid<>"" Then %><button class="btnV18 btn-line-grey my-question" onfocus="this.blur();" onClick="jsMyQNA('<%=cookieuserid%>');"><span class="icoV18"></span>내 질문글 보기</button><% End If %>
						<button class="btnV18 btn-red lMar20 " onfocus="this.blur();" onClick="jsQNAWrite();return false;">질문하기</button>
					</div>

					<table>
					<input type="hidden" name="searchdiv" id="searchdiv" value="userid">
					<input type="hidden" name="iCP" value="">
					<input type="hidden" name="shopid" value="<%=shopid%>">
					<input type="hidden" name="menuid" value="<%=menuid%>">
					<input type="hidden" name="idx" value="">
					<input type="hidden" name="sMode" value="">
					<input type="hidden" name="userid" value="<%=cookieuserid%>">
					<input type="hidden" name="myqna" id="myqna" value="<%=myqna%>">
						<colgroup>
							<col width="160" /> <col width="*" /> <col width="120" /><col width="140" />
						</colgroup>
						<tbody>
							<%
								If isArray(arrQNA) Then
									For intQ = 0 To UBound(arrQNA,2) 'idx, shopid, userid, title, regdate, replyuser, replydate
										If arrQNA(5,intQ) = "" Or isnull(arrQNA(5,intQ) ) Then
											replyYN = ""
										Else
											replyYN = "답변완료"
										End If
							%>
							<tr onclick="javascript:showhideQNA('<%= intQ %>','<%= UBound(arrQNA,2) %>')">
								<td class="fs13 color-grey2"><% If arrQNA(2,intQ) <> "" Then %><%=printUserId(arrQNA(2,intQ),2,"*")%><% Else %><%=printUserId(arrQNA(13,intQ),2,"*")%><% End If %></td>
								<td class="tit lt"><%=db2html(arrQNA(3,intQ))%></td>
								<td class="rPad20 color-grey3 fs12"><%=replyYN%></td>
								<td class="fs13"><%=FormatDate(arrQNA(4,intQ),"0000.00.00")%></td>
							</tr>
							<tr class="specific-conts lt"  id="QNAblock<%= intQ %>">
								<td class="prd-thumb"><% If arrQNA(7,intQ) > "0" Then %><a href="/shopping/category_prd.asp?itemid=<%=arrQNA(7,intQ)%>"><img src="http://webimage.10x10.co.kr/image/icon1/<%=GetImageFolerName(arrQNA(7,intQ))%>/<%=arrQNA(10,intQ)%>" alt="" style="height:120px; width:120px;"></a><% End If %></td>
								<td colspan="2">
									
									<div class="inquiry">
										<% If arrQNA(7,intQ) > "0" Then %>
										<p class="brand"><%=db2html(arrQNA(11,intQ))%></p>
										<p class="prd-name"><%=db2html(arrQNA(12,intQ))%></p>
										<% End If %>
										<div class="detail"><%=nl2br(db2html(arrQNA(8,intQ)))%></div>
									</div>
									
									<% If arrQNA(9,intQ)<>"" Then %>
									<div class="reply">
										<span class="icoV18"></span>
										<div class="detail"><%=nl2br(db2html(arrQNA(9,intQ)))%></div>
									</div>
									<% End If %>
								</td>
								<td class="ct delete"><% If arrQNA(2,intQ) <> "" Then %><% If cookieuserid = arrQNA(2,intQ) Then %><button class="btnV18 btn-grey" onfocus="this.blur();" onClick="jsDel(<%=arrQNA(0,intQ)%>);"><% End If %><% Else %><button class="btnV18 btn-grey" onfocus="this.blur();" onClick="jsGuestDel(<%=arrQNA(0,intQ)%>);return false;"><% End If %>삭제</button></td>
							</tr>
							<%
									Next
								Else
							%>
							<tr class="no-data">
								<td colspan="4">등록된 질문글이 없습니다</td>
							</tr>
							<% End If %>
						</tbody>
					</table>
					</form>
					<%
						iStartPage = (Int((iCurrentPage-1)/iPerCnt)*iPerCnt) + 1
						If (iCurrentPage mod iPerCnt) = 0 Then
						iEndPage = iCurrentPage
						Else
						iEndPage = iStartPage + (iPerCnt-1)
						End If
					%>
					<div class="pagingV18 tMar30">
					<%
						If (iStartPage-1 )> 0 Then
							Response.Write "<a href='javascript:jsGoPage(" & iStartPage-1 & ")' class='first arrow' onFocus='this.blur();'></a>"
						Else
							Response.Write "<a class='first arrow'></a>"
						End If
					%>
					<%
						If iTotalPage = 0 Then
							Response.Write "<a href='' class='current'><span>1</span></a>"
						End If
						For ix = iStartPage To iEndPage
							If (ix > iTotalPage) Then Exit For
							If Cint(ix) = Cint(iCurrentPage) Then
								Response.Write "<a href='javascript:jsGoPage(" & ix & ")' class='current' onFocus='this.blur();'><span>" & ix & "</span></a>"
							Else
								Response.Write "<a href='javascript:jsGoPage(" & ix & ")' onFocus='this.blur();'><span>" & ix & "</span></a>"
							End If
						Next
					%>
					<%
						If Cint(iTotalPage) > Cint(iEndPage)  Then
							Response.Write "<a href='javascript:jsGoPage(" & ix & ")' class='end arrow' onFocus='this.blur();'></a>"
						Else
							Response.Write "<a class='end arrow'></a>"
						End If
					%>
					</div>
				</div>
				<!--// 질문과 답변 리스트 -->
				<!-- for dev msg 매장별 썸네일 최신 3장-->
				<svg width="100%" height="280" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 1140 540" preserveAspectRatio="xMidYMid slice" class="svgBlur">
					<filter id="svgBlurFilter">
						<feGaussianBlur in="SourceGraphic" stdDeviation="1.6" />
					</filter>
					<% If isArray(arrMainGallery) Then %>
					<image xlink:href="<%=arrMainGallery(0,0)%>" x="0" y="0" filter="url(#svgBlurFilter)" />
					<% End If %>
				</svg>
				<!--// for dev msg 매장별 썸네일 최신 3장-->
			</div>
			<!-- 비밀번호 팝업 -->
			<div class="ly-offshop">
			<form method="post" name="dfrm">
			<input type="hidden" name="sMode" value="D2">
			<input type="hidden" name="iCP" value="">
			<input type="hidden" name="shopid" value="<%=shopid%>">
			<input type="hidden" name="menuid" value="<%=menuid%>">
			<input type="hidden" name="idx" value="">
				<div class="ly-pw">
					<p>게시물 작성 시 설정한 <br>비밀번호를 입력해주세요.</p>
					<div class="pw-form"><input type="password" name="password"><button type="submit" class="color-red" onfocus="this.blur();" onClick="jsGuestDelete()">삭제</button></div>
				</div>
				<div class="ly-bg-offshop" onClick="closeLy()"></div>
			</form>
			</div>
			<!--// 비밀번호 팝업 -->
		</div>
	</div>
</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

</body>
</html>
<% Set  offshopinfo = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->