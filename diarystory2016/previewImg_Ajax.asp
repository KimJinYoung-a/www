<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2016 프리뷰 레이어
' History : 2015.09.23 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2016/lib/classes/diary_class_B.asp" -->
<%
	Dim vDiary_idx, i, previewimglink
	vDiary_idx = request("diary_idx")

	dim odibest
	set odibest = new cdiary_list
		odibest.Fidx		= vDiary_idx
		odibest.getPreviewImgLoad

	IF application("Svr_Info") = "Dev" THEN
		'previewimglink = "testimgstatic"
		previewimglink = "imgstatic"
	Else
		previewimglink = "imgstatic"
	End If
%>
<% If odibest.FTotalCount > 0 Then %>
	<div class="slideWrap">
		<div class="slide">
			<% For i = 0 To odibest.FTotalCount - 1 %>
			<!-- 이미지 사이즈 670*470, 최대 8개까지 등록 -->
				<div><img src="http://<%= previewimglink %>.10x10.co.kr/diary/preview/detail/<%= odibest.FItemList(i).FpreviewImg %>" alt="" /></div>
			<% Next %>
		</div>
	</div>
	<div class="diaryItemInfo">
		<h3><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_preview.gif" alt="DIARY PREVIEW" /></h3>
		<div class="pdtInfo">
			<p class="brand"><a href="" onclick="GoToBrandShop('<%= odibest.FItemList(0).FMakerId %>'); return false;"><%=odibest.FItemList(0).FBrandName %></a></p>
			<p class="name"><%=odibest.FItemList(0).fitemname %></p>
			<% If odibest.FItemList(0).IsSaleItem or odibest.FItemList(0).isCouponItem Then %>
				<% If odibest.FItemList(0).IsSaleItem Then %>
					<p class="price"><%=FormatNumber(odibest.FItemList(0).getRealPrice, 0) %>원 <strong class="cRd0V15">[<%=odibest.FItemList(0).getSalePro%>]</strong></p>
				<% End If %>
				<% IF odibest.FItemList(0).IsCouponItem Then %>
					<p class="price"><%=FormatNumber(odibest.FItemList(0).GetCouponAssignPrice, 0) %>원 <strong class="cGr0V15">[<%=odibest.FItemList(0).GetCouponDiscountStr%>]</strong></p>
				<% End If %>
			<% Else %>
				<p class="price"><%=FormatNumber(odibest.FItemList(0).getRealPrice, 0) %>원</p>
			<% end if %>
		</div>
		<a href="/shopping/category_prd.asp?itemid=<%=odibest.FItemList(0).FItemid%>" class="btnGoMore"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/btn_more.gif" alt="상품 상세보기" /></a>
	</div>
<% End If %>
<p class="close" onclick="ClosePopLayer();"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/btn_close.gif" alt="닫기" /></p>
<% set odibest = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->