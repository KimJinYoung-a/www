<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2010.09.20 허진원 2013리뉴얼
'	Description : 마이텐바이텐 > 나의 관심 데이앤드
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 관심 Day&"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	Dim clsMFEvt, iCate, selOp
	Dim iCurrPage ,iPageSize, iTotCnt
	Dim arrList, intLoop
	dim userid: userid = getEncLoginUserID ''GetLoginUserID
	iCurrPage	= NullFillWith(requestCheckVar(request("iCC"),10),1)
	iCate		= NullFillWith(requestCheckVar(request("cdl"),10),"")
	selOp		= NullFillWith(requestCheckVar(request("selOp"),10),"0")
	iPageSize = 16
	set clsMFEvt = new CMyFavoriteEvent
		clsMFEvt.FUserID 			= getEncLoginUserID
 		clsMFEvt.FevtCategory = iCate
		clsMFEvt.FCurrPage 		= iCurrPage
		clsMFEvt.FPageSize 		= iPageSize
		clsMFEvt.FselOp	 		= selOp			'이벤트정렬
		clsMFEvt.FevtKind		= 22			'데이앤드
		clsMFEvt.FevtStat		= "N"			'기간 상관없음
		arrList = clsMFEvt.fnGetMyFavoriteEventList
		iTotCnt = clsMFEvt.FTotalCount
	set clsMFEvt = nothing
%>
<script type="text/javascript">
//검색 및 정렬
function goSort() {
	document.frmList.target="_self";
	document.frmList.action="/my10x10/myfavorite_event.asp";
	document.frmList.submit();
}

// 리스트 페이지이동
function jsGoListPage(iP){
	location.href = "<%=CurrURL()%>?iCC="+iP+"&cdl=<%=iCate%>&sort=<%=selOp%>";
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_favorite_dayand.gif" alt="관심 Day&amp;" /></h3>
						<ul class="list">
							<li>DAY&amp;에서 등록하신 관심있는 컨텐츠 리스트입니다.</li>
							<li>이미지를 클릭하시면 해당 페이지로 이동하여 상세한 정보를 보실 수 있습니다.</li>
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
								<select name="selOP" title="정렬방식 선택" class="optSelect2 lMar05" onchange="goSort();">
									<option value="0" <%=chkIIF(selOp="0","selected","")%>>최근 등록순</option>
									<option value="3" <%=chkIIF(selOp="3","selected","")%>>이름순</option>
								</select>
							</div>
						</div>

						<div class="dayAndList">
						<% IF isArray(arrList) THEN %>
							<ul>
							<%	For intLoop = 0 To UBOund(arrList,2) %>
								<li>
									<input name="chkevt" type="checkbox" class="check" value="<%=arrList(0,intLoop)%>" />
									<div class="pdtBox">
										<div class="thumbnail">
											<a href="/guidebook/dayand.asp?eventid=<%=arrList(0,intLoop)%>"><img src="<%=arrList(1,intLoop)%>" width="176" height="120" alt="<%=Replace(arrList(2,intLoop),"""","")%>" /></a>
										</div>
										<p class="title"><%=arrList(2,intLoop)%></p>
									</div>
								</li>
							<%	Next %>
							</ul>
						<%
							Else
								'관심 데이앤드가 없을 때
						%>
							<div class="noData">
								<p><strong>등록된 관심 DAY&amp;가 없습니다.</strong></p>
								<a href="/guidebook/dayand.asp" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/btn_view_day_and.gif" alt="DAY&amp; 보러가기" /></a>
							</div>
						<%	End if %>
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

						<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(iCurrPage, iTotCnt, iPageSize, 10, "jsGoListPage") %></div>
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
