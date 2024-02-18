<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'#############################################################
'	Description : 다이어리 메인 상품 리스트
'	History		: 2017.09.19 유태욱 생성
'#############################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->

<%
Dim i , PrdBrandList , imglink, vParaMeter , GiftSu, weekDate
Dim PageSize : PageSize	= requestcheckvar(request("page"),2)
dim SortMet : SortMet 	= requestCheckVar(request("srm"),9)
dim CurrPage : CurrPage 	= requestCheckVar(request("cpg"),9)
Dim ListDiv : ListDiv	= requestcheckvar(request("ListDiv"),4)
Dim design : design	= requestcheckvar(request("dsn"),12)
Dim keyword : keyword	= requestcheckvar(request("kwd"),12)
Dim contents : contents	= requestcheckvar(request("ctt"),32)
dim userid : userid		= getEncLoginUserID
If ListDiv = "" Then ListDiv = "item"
IF CurrPage = "" then CurrPage = 1
IF SortMet = "" Then SortMet = "best"

If ListDiv = "list" Then
	PageSize = 16
Else
	PageSize = 16
End If

Dim ArrDesign , tmp , iTmp , ctmp, ktmp, arrcontents ,arrkeyword
ArrDesign = design		'request("arrds")
ArrDesign = split(ArrDesign,",")

For iTmp =0 to Ubound(ArrDesign)-1
	IF ArrDesign(iTmp)<>"" Then
		tmp  = tmp & requestcheckvar(ArrDesign(iTmp),2) &","
	End IF
Next
ArrDesign = tmp

Dim sArrDesign,sarrcontents,sarrkeyword
sArrDesign =""
IF ArrDesign <> "" THEN sArrDesign =  left(ArrDesign,(len(ArrDesign)-1))

vParaMeter = "&arrds="&ArrDesign&""

design = xTrim(design , ",")
keyword = xTrim(keyword , ",")
contents = xTrim(contents , ",")

Set PrdBrandList = new cdiary_list
	'아이템 리스트
	PrdBrandList.FPageSize = PageSize
	PrdBrandList.FCurrPage = CurrPage
	PrdBrandList.frectdesign = design		'sArrDesign
	PrdBrandList.frectcontents = contents
	PrdBrandList.frectkeyword = keyword
	PrdBrandList.fmdpick = ""
	PrdBrandList.ftectSortMet = SortMet
	''PrdBrandList.fuserid = userid   '' 의미없음.
	PrdBrandList.getDiaryItemLIst
%>
<script type="text/javascript">
	function diaryPreviewSlide(){
		$('.diary-preview .slide').slidesjs({
			width:"670",
			height:"470",
			pagination:false,
			navigation:{effect:"fade"},
			play:{interval:2800, effect:"fade", auto:false},
			effect:{fade: {speed:800, crossfade:true}
			},
			callback: {
				complete: function(number) {
					var pluginInstance = $('.diary-preview .slide').data('plugin_slidesjs');
					setTimeout(function() {
						pluginInstance.play(true);
					}, pluginInstance.options.play.interval);
				}
			}
		});
	}

	$('.btn-preview').click(function(){
		diaryPreviewSlide();
	});
</script>
	<ul>
	<%
	Dim tempimg, tempimg2
	dim imgSz : imgSz = 240
	If PrdBrandList.FResultCount > 0 Then
		For i = 0 To PrdBrandList.FResultCount - 1
			If ListDiv = "item" Then
				tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg
				tempimg2 = PrdBrandList.FItemList(i).FDiaryBasicImg2
			End If
			If ListDiv = "list" Then''2016부터 사용안함(활용컷-마우스오버로)
				tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg2
			End If

			IF application("Svr_Info") = "Dev" THEN
				tempimg = left(tempimg,7)&mid(tempimg,12)
				tempimg2 = left(PrdBrandList.FItemList(i).FDiaryBasicImg2,7)&mid(PrdBrandList.FItemList(i).FDiaryBasicImg2,12)''마우스오버 활용컷
			end if
	%>
			<%' for dev msg : 리스트 16개씩 노출 / 품절일경우 클래스 soldOut 붙여주세요 %>
			<li <% if PrdBrandList.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>>
				<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>" target="_blank">
					<span class="thumbnail">
						<% if PrdBrandList.FItemList(i).IsSoldOut then %>
							<span class="soldOutMask"></span>
						<% end if %>
						<img src="<%=tempimg %>" alt="<%= PrdBrandList.FItemList(i).FItemName %>" />

						<%' 미리보기 %>
						<% If IsNull(PrdBrandList.FItemList(i).FpreviewImg) Or PrdBrandList.FItemList(i).FpreviewImg="" Then %>
						<% Else %>
							<button type="button" onclick="fnviewPreviewImg('<%= PrdBrandList.FItemList(i).FpreviewImg %>'); return false;" target="_top" class="btn-preview">미리보기</button>
						<% end if %>
					</span>
					<span class="desc">
						<span class="brand"><a href="/street/street_brand.asp?makerid=<%= PrdBrandList.FItemList(i).FMakerId %>" target="_blank"><%= PrdBrandList.FItemList(i).Fsocname %></a></span>
						<span class="name">
							<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>" target="_blank">
								<% If PrdBrandList.FItemList(i).isSaleItem Or PrdBrandList.FItemList(i).isLimitItem Then %>
									<%= chrbyte(PrdBrandList.FItemList(i).FItemName,30,"Y") %>
								<% Else %>
									<%= PrdBrandList.FItemList(i).FItemName %>
								<% End If %>
							</a>
						</span>
						<% if PrdBrandList.FItemList(i).IsSaleItem or PrdBrandList.FItemList(i).isCouponItem Then %>
							<% IF PrdBrandList.FItemList(i).IsSaleItem then %>
								<span class="price">
									<span class="sum"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0)%>원</span>
									<span class="discount color-red">[<%=PrdBrandList.FItemList(i).getSalePro%>]</span>
								</span>
							<% End If %>
							<% IF PrdBrandList.FItemList(i).IsCouponItem Then %>
								<span class="price">
									<span class="sum"><%=FormatNumber(PrdBrandList.FItemList(i).GetCouponAssignPrice,0)%>원</span>
									<span class="discount colorgreen">[<%=PrdBrandList.FItemList(i).GetCouponDiscountStr%>]</span>
								</span>
							<% end if %>
						<% else %>
							<span class="price"><span class="sum"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0) & chkIIF(PrdBrandList.FItemList(i).IsMileShopitem,"Point","원")%></span>
						<% end if %>
					</span>
				</a>
			</li>
	<%
		next
	End If
	%>
	</ul>
	<% if PrdBrandList.FtotalPage > 1 then %>
	<div class="pageWrapV15">
		<div class="paging">
			<a href="" onclick="drlistpg('1'); return false;" class="first arrow"><span>맨 처음 페이지로 이동</span></a>
			<% if PrdBrandList.FCurrPage > 1 then %>
				<a href="" onclick="drlistpg('<%= PrdBrandList.FCurrPage-1 %>'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a>
			<% else %>
				<a href="" onclick="alert('이전페이지가 없습니다.'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a>
			<% end if %>
	
			<% for i = 0 + PrdBrandList.StartScrollPage to PrdBrandList.StartScrollPage + PrdBrandList.FScrollCount - 1 %>
				<% if (i > PrdBrandList.FTotalpage) then Exit for %>
				<% if CStr(i) = CStr(PrdBrandList.FCurrPage) then %>			
					<a href="" class="current"><span><%= i %></span></a>
				<% else %>
					<a href="" onclick="drlistpg('<%= i %>'); return false;" ><span><%= i %></span></a>
				<% end if %>
			<% next %>
			
			<% if cint(PrdBrandList.FCurrPage) < cint(PrdBrandList.FtotalPage) then %>
				<a href="" onclick="drlistpg('<%= PrdBrandList.FCurrPage+1 %>'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>
			<% else %>
				<a href="" onclick="alert('다음 페이지가 없습니다.'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>
			<% end if %>
			<a href="" onclick="drlistpg('<%= PrdBrandList.FTotalPage %>'); return false;" class="end arrow"><span>맨 마지막 페이지로 이동</span></a>
		</div>
		<div class="pageMove">
			<input type="text" style="width:24px;" /> /23페이지 <a href="" class="btn btnS2 btnGry2"><em class="whiteArr01 fn">이동</em></a>
		</div>
	</div>
	<% end if %>
<%
set PrdBrandList=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
