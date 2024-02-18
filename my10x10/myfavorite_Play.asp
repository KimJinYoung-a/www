<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2010.10.02 이종화 2013리뉴얼
'	Description : 마이텐바이텐 > 나의 관심 play
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 관심 Day&"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritePlayCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	Dim clsMFPlay,iCate, selOp, tmpImg, tmpArr
	Dim iCurrPage ,iPageSize, iTotCnt
	Dim arrList, intLoop
	dim userid: userid = getEncLoginUserID ''GetLoginUserID
	iCurrPage	= NullFillWith(requestCheckVar(request("iCC"),10),1)
	iCate		= NullFillWith(requestCheckVar(request("cdl"),10),"")
	selOp		= NullFillWith(requestCheckVar(request("selOp"),10),"0")
	iPageSize = 12

	set clsMFPlay = new CMyFavoriteEvent
		clsMFPlay.FUserID 			= getEncLoginUserID
		clsMFPlay.FCurrPage 		= iCurrPage
		clsMFPlay.FPageSize 			= iPageSize
		clsMFPlay.FselOp	 			= selOp			'이벤트정렬
		arrList = clsMFPlay.fnGetMyFavoritePlayList
		iTotCnt = clsMFPlay.FTotalCount
	set clsMFPlay = nothing
%>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('img').load(function(){
			$(".playContList").masonry({
				itemSelector: '.box'
			});
		});
		$(".playContList").masonry({
			itemSelector: '.box'
		});
	});
	$(function(){
		$("#selectAll,#selectAll2").click(function(){
			$("input[name='chkevt']").prop("checked",$(this).prop("checked"));
			$("#selectAll").prop("checked",$(this).prop("checked"));
			$("#selectAll2").prop("checked",$(this).prop("checked"));
		});
	});
	//검색 및 정렬
	function goSort() {
		document.frmList.target="_self";
		document.frmList.action="/my10x10/myfavorite_play.asp";
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
		//document.frmList.target = "_blank";
		document.frmList.hidM.value ="D";
		document.frmList.action ="/my10x10/myfavorite_playProc.asp";
		document.frmList.submit();
	}
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_favorite_play.gif" alt="관심 PLAY" /></h3>
						<ul class="list">
							<li>PLAY에서 등록하신 관심있는 컨텐츠 리스트입니다.</li>
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
									<option value="1" <%=chkIIF(selOp="1","selected","")%>>이름순</option>
								</select>
							</div>
						</div>
						<% IF isArray(arrList) THEN %>
						<div class="playContList">
							<%
								Function returnname(playcode)
									Select Case CStr(playcode)
										Case "1"
											returnname = "Ground"
										Case "2"
											returnname = "Style+"
										Case "3"
											returnname = "Color trend"
										Case "4"
											returnname = "Design fingers"
										Case "5"
											returnname = "그림일기"
										Case "6"
											returnname = "Video clip"
										Case Else
											returnname = "Ground"
									End Select
								End Function

								For intLoop = 0 To UBOund(arrList,2)

							%>
							<div class="box">
								<input name="chkevt" type="checkbox" class="check" value="<%=arrList(0,intLoop)%>" />
								<dl>
									<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title0<%=arrList(1,intLoop)%>.gif" alt="<%=returnname(arrList(1,intLoop))%>" /></dt>
									<dd <%=chkIIF(inStr(arrList(5,intLoop),"||")>0,"class='old'","")%>>
										<% If arrList(1,intLoop) = "1" Then %>
										<a href="/play/playGround.asp?gidx=<%=arrList(2,intLoop)%>&gcidx=<%=arrList(3,intLoop)%>">
										<% ElseIf arrList(1,intLoop) = "2" Then %>
										<a href="/play/playStylePlusView.asp?idx=<%=arrList(2,intLoop)%>">
										<% ElseIf arrList(1,intLoop) = "3" Then %>
										<a href="/play/playColorTrendView.asp?ctcode=<%=arrList(2,intLoop)%>">
										<% ElseIf arrList(1,intLoop) = "4" Then %>
										<a href="/play/playdesignfingers.asp?fingerid=<%=arrList(2,intLoop)%>">
										<% ElseIf arrList(1,intLoop) = "5" Then %>
										<a href="/play/playPicDiary.asp?idx=<%=arrList(2,intLoop)%>&viewno=<%=arrList(3,intLoop)%>">
										<% ElseIf arrList(1,intLoop) = "6" Then %>
										<a href="/play/playVideoClip.asp?idx=<%=arrList(2,intLoop)%>">
										<% End If %>
										<%
											if inStr(arrList(5,intLoop),"||")>0 then
												tmpArr = split(arrList(5,intLoop),"||")
												tmpImg = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(tmpArr(0)) + "/" + tmpArr(1)
												response.Write "<img src=""" & getThumbImgFromURL(tmpImg,240,240,"true","false") & """ alt=""" & arrList(6,intLoop) & """ /></a>"
											else
												response.Write "<img src=""" & arrList(5,intLoop) & """ alt=""" & arrList(6,intLoop) & """ /></a>"
											end if
										%>
									</dd>
								</dl>
							</div>
							<% Next %>
						</div>
						<% Else %>
						<div class="noData playNoData">
							<p><strong>등록된 관심 PALY가 없습니다.</strong></p>
							<a href="/play" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/btn_view_play.gif" alt="PALY 보러가기" /></a>
						</div>
						<% End If %>
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
