<%
	Dim 	iListCurrentPage
	iListCurrentPage	= getNumeric(requestCheckVar(request("iLC"),8))
	IF iListCurrentPage = "" THEN iListCurrentPage = 1

	'메인위시리스트
	clsDF.FUserID 		= GetLoginUserID
	clsDF.FRDFS 		= iDFSeq
	clsDF.FDFCodeSeq 	= 3		'list용 이미지
	clsDF.FCategory		= 0
	clsDF.FSort			= 1
	clsDF.FSearchTxt	= ""
	clsDF.FCPage 		= iListCurrentPage
	clsDF.FPSize 		= 5
	arrMainWishList = clsDF.fnGetWishList
	iTotWishCnt = clsDF.FTotCnt
%>

<script type="text/javascript">
<!--
	$(function() {
		$(".favorFingers dt").mouseleave(function(){
			if($(".favorFingers dd").is(":hidden")){
				$(this).removeClass('on');
			}else{
				$(this).addClass('on');
			};
		});
		$(".favorFingers dt").click(function(){
			if($(".favorFingers dd").is(":hidden")){
				$(this).parent().children('dt').addClass('on');
				$(this).parent().children('dd').show("slide", { direction: "up" }, 300);
			}else{
				$(this).parent().children('dd').hide("slide", { direction: "up" }, 300);
			};
		});
		$(".favorFingers dd").mouseleave(function(){
			$(this).hide();
			$(this).parent().children('dt').removeClass('on');
		});

		$('.fingersPdtImgList li a').click(function(){
			$('.fingersPdtImgList li').removeClass('current');
			$(this).parent().addClass('current');
			var imgSrc= $(this).attr("href");
			var imgAlt= $(this).find("img").attr("alt");
			$(".detailBigPic > img").attr("src", imgSrc);
			$(".detailBigPic > img").attr("alt", imgAlt);
		});
	});

	// 베스트 리스트 - Refresh
	function CtgBestRefresh(order1,order2,order3) {
/*
		if(order3 != "x") {
			$("#Wlist_view").show();
		}
		var str = $.ajax({
			type: "GET",
			url: "designfingers_Ajax.asp",
			data: "fingerid=<%=iDFSeq%>&iLC="+order1+"&gubun="+order2,
			dataType: "text",
			async: false
		}).responseText;
		$("#Wlist_view").html(str);
*/


		$.ajax({
				url: "/play/designfingers_Ajax.asp?fingerid=<%=iDFSeq%>&iLC="+order1+"&gubun="+order2,
				cache: false,
				success: function(message)
				{
					$("#Wlist_view").empty().append(message);

					//맨하단
					//message.sortKey = null;
				}
		});
	}


//-->
	function jsGoPage(iP){
		$(this).parent().children('dd').show();
		document.pageFrm.iLC.value = iP;
		document.pageFrm.submit();
	}
</script>

<div class="playTit" style="padding-bottom:15px;">
	<h2 class="ftLt" style="margin-top:4px;"><a href="/play/playDesignFingers.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/tit_fingers.gif" alt="DESIGN FINGERS" /></a></h2>
	<div class="ftRt" style="width:420px;">
		<dl class="ftLt favorFingers" >
			<dt><span>내가 담은 관심 디자인핑거스</span></dt>

			<dd id="Wlist_view" style="display:none;">
				<table>
				<caption>내가 담은 관심 디자인핑거스 목록</caption>
				<colgroup>
					<col width="60px" /><col width="" />
				</colgroup>
				<tbody>
				<%
				If iTotWishCnt <> 0 Then
					IF isArray(arrMainWishList) THEN
						For intLoop = 0 To UBound(arrMainWishList,2)
				%>
				<tr>
					<td><img src="<%=arrMainWishList(2,intLoop)%>" alt="<%=chrbyte(arrMainWishList(1,intLoop),45,"Y")%>" width="50" height="50" /></td>
					<td>
						<p><strong>No.<%=arrMainWishList(0,intLoop)%></strong></p>
						<p><a href="/play/playdesignfingers.asp?fingerid=<%=arrMainWishList(0,intLoop)%>"><%=chrbyte(arrMainWishList(1,intLoop),45,"Y")%></a></p>
					</td>
				</tr>
				<%
						Next
					End If
				End If
				%>
				</tbody>
				</table>

				<div class="paging tMar10">
				<%
					clsDF.FCPage = 1
					clsDF.FPSize = 5
					clsDF.FTotCnt = iTotWishCnt
					clsDF.FGubun = "W"
					clsDF.sbGetSmallListDisplayAjax
				 %>
				</div>
			</dd>
		</dl>
		<p class="appLinkGo"><a href="/event/appdown/">모바일 웹과 APP으로 디자인핑거스를 즐기세요!</a></p>
	</div>
</div>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
<input type="hidden" name="fingerid" value="<%=iDFSeq%>">
<input type="hidden" name="iLC" value="">
</form>