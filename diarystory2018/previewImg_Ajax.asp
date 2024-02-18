<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2017 프리뷰 레이어
' History : 2015.09.26 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2017/lib/classes/diary_class_B.asp" -->
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
	<h3><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_diary_story_2.png" alt="DIARY PREVIEW" /></h3>
	<div class="slide">
		<%' 이미지 사이즈 670*470 %>
		<% For i = 0 To odibest.FTotalCount - 1 %>
			<div><img src="http://<%= previewimglink %>.10x10.co.kr/diary/preview/detail/<%= odibest.FItemList(i).FpreviewImg %>" alt="" /></div>
		<% Next %>
	</div>
	<div class="pdtInfo">
		<p class="name"><span>[<%=odibest.FItemList(0).FBrandName %>] </span><%=odibest.FItemList(0).fitemname %></p>
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
	<a href="/shopping/category_prd.asp?itemid=<%=odibest.FItemList(0).FItemid%>" class="btn-detail"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/btn_detail.png" alt="상품 상세보기" /></a>
<% End If %>
<button type="button" class="btn-close" onclick="ClosePopLayer();"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/btn_close.png" alt="닫기" /></button>
<% set odibest = Nothing %>

<!-- #include virtual="/lib/db/dbclose.asp" -->