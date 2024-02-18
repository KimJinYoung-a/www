<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2010.09.20 허진원 2013리뉴얼
'	Description : 마이텐바이텐 > 나의 관심 이벤트
'#######################################################

	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 관심 이벤트"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
	strPageDesc = "참여하고 싶은 이벤트가 있으시군요^^"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 관심 이벤트"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/myfavorite_event.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	Dim clsMFEvt, selOp, iDispCate
	Dim iCurrPage ,iPageSize, iTotCnt
	Dim arrList, intLoop, vEvtImg
	dim userid: userid = getEncLoginUserID ''GetLoginUserID
	iCurrPage	= NullFillWith(requestCheckVar(request("iCC"),10),1)
	selOp		= NullFillWith(requestCheckVar(request("selOp"),10),"0")
	iDispCate	= NullFillWith(requestCheckVar(request("disp"),3),"")
	iPageSize = 16
	set clsMFEvt = new CMyFavoriteEvent
		clsMFEvt.FUserID 			= getEncLoginUserID
 		clsMFEvt.FevtDispCate	= iDispCate		'전시카테고리
		clsMFEvt.FCurrPage 		= iCurrPage
		clsMFEvt.FPageSize 		= iPageSize
		clsMFEvt.FselOp	 		= selOp			'이벤트정렬
		clsMFEvt.FevtKind		= 0				'전체이벤트(데이앤드 제외)
		clsMFEvt.FevtStat		= "Y"			'진행중인 이벤트만
		arrList = clsMFEvt.fnGetMyFavoriteEventList2013
		iTotCnt = clsMFEvt.FTotalCount
	set clsMFEvt = nothing


'' 결과 배열 순서
''	[0~8] evt_code, evt_bannerimg, evt_name, evt_startdate, evt_enddate, evt_subcopyK, etc_itemid, etc_itemimg, icon1image
''	[9~17] issale, isgift,  isitemps, iscoupon, isOnlyTen, isoneplusone, isfreedelivery, isbookingsell, iscomment
%>
<style type="text/css">
.myFavorite {width:908px; padding:40px 0;}
.myFavorite .titleSection {margin:0;}

.favorOption {overflow:hidden; padding:9px 15px; vertical-align:middle; border-bottom:1px solid #e5e5e5;}
.favorOption .ftLt span {display:inline-block; line-height:12px; padding-right:8px; margin-right:8px; background:url(http://fiximage.10x10.co.kr/web2013/common/blt_gray_bar.gif) right center no-repeat;}
.favorOption .ftLt span label  {vertical-align:middle;}
.favorOption .ftLt span .check {margin-top:0px;}
</style>
<script type="text/javascript">
//검색 및 정렬
function goCategory() {
	document.frmList.target="_self";
	document.frmList.action="/my10x10/myfavorite_event.asp";
	document.frmList.submit();
}

// 리스트 페이지이동
function jsGoListPage(iP){
	location.href = "<%=CurrURL()%>?iCC="+iP+"&disp=<%=iDispCate%>&sort=<%=selOp%>";
}

function deleteWish() {
	var ret = 0;
    for (i=0; i< document.getElementsByName("chkevt").length; i++)
    {
        if (document.getElementsByName("chkevt")[i].checked == true)
        {
            ret = ret + 1;
        }
    }
	if (ret == 0)
	{
		alert("한개 이상의 이벤트를 선택해주세요");
		return;
	}
	document.frmList.target = "wishProc";
	document.frmList.hidM.value ="D";
	document.frmList.action ="/my10x10/myfavorite_eventProc.asp";
	document.frmList.submit();
}

$(function(){
	$("#selectAll,#selectAll2").click(function(){
		$("input[name='chkevt']").prop("checked",$(this).prop("checked"));
		$("#selectAll").prop("checked",$(this).prop("checked"));
		$("#selectAll2").prop("checked",$(this).prop("checked"));
	});
});
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent myFavorite">
				<form name="frmList" method="post" style="margin:0px;">
				<input type="hidden" name="hidM" value="">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_favorite_event.gif" alt="관심 이벤트" /></h3>
						<ul class="list">
							<li>고객님께서 관심등록하신 이벤트입니다.</li>
							<li>이벤트 기간이 종료된 이벤트는 자동 삭제됩니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<div class="favorOption">
							<div class="ftLt">
								<span>
									<input type="checkbox" class="check" id="selectAll" />
									<label for="selectAll">전체선택</label>
								</span>
								<a href="" class="btn btnS2 btnGrylight fn" onclick="deleteWish(); return false;">삭제</a>
							</div>
							<div class="ftRt">
								<select name="disp" title="카테고리 선택" class="optSelect2" onChange="goCategory();">
									<%=CategorySelectBoxOption(iDispCate)%>
								</select>
								<select name="selOP" title="정렬방식 선택" class="optSelect2 lMar05" onchange="goCategory();">
									<option value="0" <%=chkIIF(selOp="0","selected","")%>>최근이벤트순</option>
									<option value="1" <%=chkIIF(selOp="1","selected","")%>>마감임박순</option>
									<option value="2" <%=chkIIF(selOp="2","selected","")%>>판매순</option>
								</select>
							</div>
						</div>

						<div class="enjoyEventWrap">
							<div class="enjoyEvent">
							<% IF isArray(arrList) THEN %>
								<ul>
								<%
									For intLoop = 0 To UBOund(arrList,2)
										'이벤트 이미지(200x200px)
										If arrList(7,intLoop) = "" Then
											If arrList(8,intLoop) <> "" Then
												vEvtImg = "http://webimage.10x10.co.kr/image/icon1/" & GetImageSubFolderByItemid(arrList(6,intLoop)) & "/" & arrList(8,intLoop)
											else
												vEvtImg = ""
											End IF
										Else
											'// 포토서버 사용
											vEvtImg = arrList(7,intLoop)
											vEvtImg = chkIIF(application("Svr_Info")<>"Dev",getThumbImgFromURL(vEvtImg,200,200,"true","false"),vEvtImg)
										End If
								%>
									<li class="box" onclick="self.location='/event/eventmain.asp?eventid=<%=arrList(0,intLoop)%>'">
										<input name="chkevt" type="checkbox" class="check" value="<%=arrList(0,intLoop)%>" />
										<p class="pic"><img src="<%=vEvtImg%>" alt="<%=Replace(arrList(2,intLoop),"""","")%>" /></p>
										<div class="evtProd">
											<p class="pdtStTag">
												<%IF arrList(13,intLoop) = 1 THEN%><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /><%END IF%>
												<%IF datediff("d",arrList(3,intLoop),date)<=3 THEN%><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /><%END IF%>
												<%IF arrList(9,intLoop) = 1 THEN%><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><%END IF%>
												<%IF arrList(12,intLoop) = 1 THEN%><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /><%END IF%>
												<%IF arrList(10,intLoop) = 1 THEN%><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_gift.gif" alt="GIFT" /><%END IF%>
												<%IF arrList(14,intLoop) = 1 THEN%><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_oneplus.gif" alt="1+1" /><%END IF%>
												<%IF arrList(11,intLoop)=1 or arrList(17,intLoop)=1 THEN%><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_involve.gif" alt="참여" /><%END IF%>
											</p>
											<p class="evtTit"><%=chrbyte(arrList(2,intLoop),52,"Y")%></p>
											<p class="evtExp"><%=arrList(5,intLoop)%></p>
											<p class="evtDate">~<%=formatdate(arrList(4,intLoop),"0000.00.00")%></p>
										</div>
									</li>
								<%	Next %>
								</ul>
							<%
								Else
									'등록된 관심 이벤트가 없을 때
							%>
								<div class="noData">
									<p><strong>등록된 이벤트가 없습니다.</strong></p>
									<a href="/shoppingtoday/shoppingchance_allevent.asp" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/btn_view_enjoy_event.gif" alt="ENJOY EVENT 보러가기" /></a>
								</div>
							<%	End if %>
							</div>
						</div>

						<div class="favorOption">
							<div class="ftLt">
								<span>
									<input type="checkbox" class="check" id="selectAll2" />
									<label for="selectAll2">전체선택</label>
								</span>
								<a href="" class="btn btnS2 btnGrylight fn" onclick="deleteWish(); return false;">삭제</a>
							</div>
						</div>

						<div class="pageWrapV15 tMar20 rMar15"><%= fnDisplayPaging_New_nottextboxdirect(iCurrPage, iTotCnt, iPageSize, 10, "jsGoListPage") %></div>
					</div>

				</form>
				</div>
				<!--// content -->
			</div>
		</div>
		<iframe id="wishProc" name="wishProc" src="about:blank" frameborder="0" width="0" height="0"></iframe>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
