<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 찜브랜드"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
	strPageDesc = "내가 애정하는 브랜드는?"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 찜브랜드"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/myzzimbrand.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/street/sp_ZZimBrandCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'// 모달창이 필요한경우 아래 변수에 내용을 넣어주세요.
strModalCont = "<div id='itemLyr' class='window loginLyr'>" &_
				"<div style='background:#fff; width:500px; height:400px'>모달 내용</div>" &_
				"	<p class='lyrClose'>close</p>" &_
				"</div>"

'// 팝업창(레이어)이 필요한 경우 아래 변수에 내용을 넣어주세요.
strPopupCont = "<div id='popLyr' class='window certLyr'>" &_
				"<div style='background:#fef; width:500px; height:400px'>팝업 내용</div>" &_
				"	<p class='lyrClose'>close</p>" &_
				"</div>"

dim userid: userid = getEncLoginUserID ''GetLoginUserID
dim  page, cateCode, pagesize, SortMethod, OrderType
	page        = requestCheckVar(request("page"),9)
	cateCode    = requestCheckVar(request("cateCode"),3)
	pagesize    = requestCheckVar(request("pagesize"),9)
	SortMethod  = requestCheckVar(request("SortMethod"),10)
	OrderType   = requestCheckVar(request("OrderType"),10)

	if page="" then page=1

dim omyZzimbrand
	set omyZzimbrand = new CMyZZimBrand
	omyZzimbrand.FRectUserid = getEncLoginUserID
	omyZzimbrand.FCurrPage  = page
	omyZzimbrand.FPageSize  = 12
	omyZzimbrand.FRectCDL   = cateCode		'// 카테고리 코드(cdL 아님)
	omyZzimbrand.FRectOrder = OrderType

	'// 로그인상태일경우에만 처리
	if GetLoginUserID<>"" then
	    omyZzimbrand.GetMyZZimBrand
	end if

dim i, lp

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language='javascript'>

function goPage(pg){
    location.href='?page='+pg+'&cateCode<%=cateCode%>&ordertype<%=ordertype%>';
}

/*
//찜브랜드등록방법
function pop_zziminfo(idx){

	var pop_zziminfo;
	pop_zziminfo = window.open("/my10x10/myzzimbrand_info.asp", "pop_zziminfo",'width=610,height=760,scrollbars=no,resizable=yes');
	pop_zziminfo.focus();

}

//선택브랜드삭제하기
function DelFavBrand(upfrm){
if (!CheckSelected()){
		alert('선택아이템이 없습니다.');
		return;
	}
	var frm;
		for (var i=0;i<document.forms.length;i++){
			frm = document.forms[i];
			if (frm.name.substr(0,9)=="frmBuyPrc") {
				if (frm.cksel.checked){
					upfrm.makerid.value = upfrm.makerid.value + frm.makerid.value + "," ;
				}
			}
		}
upfrm.mode.value='del';
upfrm.action='/my10x10/myzzimbrand_process.asp';
upfrm.target='view';
upfrm.submit();
}
 */

function SwapCate(comp){
	var cateCode = comp.value;
	var frm = comp.form;
	//frm.cateCode.value = cateCode;
	frm.submit();
}

$(document).ready(function() {

	$(".clsChkAll").click(function() {
		var ischecked = $(this).attr('checked');
		if (typeof ischecked == "undefined") {
			ischecked = "undefined";
		}

		if (ischecked != "checked") {
			$('.clsChkAll').attr('checked', false);
			$('.chkZzimBrandItem').attr('checked', false);
		} else {
			$('.clsChkAll').attr('checked', true);
			$('.chkZzimBrandItem').attr('checked', true);
		}
	});

	$(".btnDelSelectedBrand").click(function() {
		var arrBrandList = "";
		var frm = document.frmItem;

		$("input[name=chkZzimBrandItem]:checked").each(function() {
			arrBrandList = arrBrandList + $(this).val() + ",";
		});

		if (arrBrandList == "") {
			alert('선택된 브랜드가 없습니다.');
			return;
		}

		if (confirm("선택 찜브랜드를 삭제하시겠습니까?") == true) {
			frm.mode.value		='del';
			frm.makerid.value	= arrBrandList;
			frm.action			= '/my10x10/myzzimbrand_process.asp';
			frm.target			= 'view';

			frm.submit();
		}
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
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_zzim_brand.gif" alt="찜 브랜드" /></h3>
						<ul class="list">
							<li>최근 6개월간 저장하신 찜브랜드 리스트입니다.</li>
							<li>6개월 이전 저장하신 찜브랜드 및 거래종료 브랜드는 자동 삭제됩니다.</li>
							<li>리스트의 브랜드 삭제 및 변경 등의 관리로 보다 편리하게 이용 하실 수 있습니다.</li>
						</ul>
					</div>

					<form name="frmItem" method="post">
					<input type="hidden" name="page" value="">
					<input type="hidden" name="mode" value="">
					<input type="hidden" name="makerid">

					<div class="mySection">
						<div class="favorOption">
							<div class="ftLt">
								<span>
									<input type="checkbox" class="check clsChkAll" id="selectAll" />
									<label for="selectAll">전체선택</label>
								</span>
								<a href="#" onClick="return false;" class="btn btnS2 btnGrylight fn btnDelSelectedBrand" title="선택된 찜브랜드 삭제하기">삭제</a>
							</div>
							<div class="ftRt">
								<select title="카테고리 선택" class="optSelect2" name="cateCode" onChange="SwapCate(this);">
									<%=CategorySelectBoxOption(cateCode)%>
								</select>
								<select title="정렬방식 선택" class="optSelect2 lMar05" name="ordertype" onchange="this.form.submit();">
									<option value="recent" <% if orderType="" or orderType="recent" then response.write "selected" %>>최근 등록순</option>
									<option value="brandname" <% if orderType="brandname" then response.write "selected" %>>이름 순</option>
								</select>
							</div>
						</div>

						<div class="myZzimList">
<%

If (omyZzimbrand.FResultCount > 0) Then
	for i = 0 to omyZzimbrand.FResultCount - 1

%>
							<% if ((i Mod 3) = 0) then %>
							<ul>
							<% end if %>
								<li>
									<input type="checkbox" name="chkZzimBrandItem" class="check chkZzimBrandItem" value="<%= omyZzimbrand.FItemList(i).Fmakerid %>" />
									<dl>
										<dt>
											<a href="/street/street_brand.asp?makerid=<%= omyZzimbrand.FItemList(i).FMakerid %>">
												<strong><%= omyZzimbrand.FItemList(i).Fsocname %></strong>
												<span><%= omyZzimbrand.FItemList(i).Fsocname_Kor %></span>
												<span class="tag">
													<% if omyZzimbrand.FItemList(i).Fsaleflg="Y" then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><% end if %>
													<% if omyZzimbrand.FItemList(i).Fnewflg="Y" then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /><% end if %>
												</span>
											</a>
										</dt>
										<dd class="txt"><a href="/street/street_brand.asp?makerid=<%= omyZzimbrand.FItemList(i).FMakerid %>"><%= chrbyte(stripHTML(omyZzimbrand.FItemList(i).Fdgncomment), 34, "Y") %></a></dd>
										<dd class="pic"><a href="/street/street_brand.asp?makerid=<%= omyZzimbrand.FItemList(i).FMakerid %>"><img src="<%= omyZzimbrand.FItemList(i).FbasicImage %>" alt="<%= omyZzimbrand.FItemList(i).Fsocname %>" width="180px" height="180px" /></a></dd>
									</dl>
								</li>
							<% if ((i Mod 3) = 2) then %>
							</ul>
							<% end if %>
<%

	next
else

%>
							<div class="noData">
								<p><strong>등록된 찜브랜드가 없습니다.</strong></p>
								<a href="/street/index.asp" class="btnView" title="BRAND STREET 보러가기"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/btn_view_brand_street.gif" alt="BRAND STREET 보러가기" /></a>
							</div>
<%

end if

%>
						</div>

						<div class="favorOption">
							<div class="ftLt">
								<span>
									<input type="checkbox" class="check clsChkAll" id="selectAll" />
									<label for="selectAll">전체선택</label>
								</span>
								<a href="#" onClick="return false;" class="btn btnS2 btnGrylight fn btnDelSelectedBrand" title="선택된 찜브랜드 삭제하기">삭제</a>
							</div>
						</div>

						<div class="pageWrapV15 tMar20 rMar15">
							<%= fnDisplayPaging_New_nottextboxdirect(omyZzimbrand.FcurrPage, omyZzimbrand.FtotalCount, omyZzimbrand.FPageSize, 5, "goPage") %>
						</div>

						<iframe id="view" name="view" width=0 height=0 frameborder="0" scrolling="no"></iframe>

					</div>
					</form>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
set omyZzimbrand = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
