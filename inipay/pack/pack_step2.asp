<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'#######################################################
'	History	:  2015.11.09 한용민 생성
'	Description : 포장 서비스
'#######################################################
%>
<!-- #include virtual="/login/checkBaguniLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->

<%
dim midx
	midx = getNumeric(requestcheckvar(request("midx"),10))

dim userid, guestSessionID, i, j, isBaguniUserLoginOK
If IsUserLoginOK() Then
	userid = getEncLoginUserID ''GetLoginUserID
	isBaguniUserLoginOK = true
Else
	userid = GetLoginUserID
	isBaguniUserLoginOK = false
End If
guestSessionID = GetGuestSessionKey

'if not(isBaguniUserLoginOK) then
'	response.write "<script type='text/javascript'>alert('회원전용 서비스 입니다. 로그인을 해주세요.');</script>"
'	dbget.close()	:	response.end
'end if

if midx="" or isnull(midx) then
	response.write "<script type='text/javascript'>alert('일렬번호가 없습니다.');</script>"
	dbget.close()	:	response.end
end if

'//선물포장 임시 패킹 리스트
dim opackmaster
set opackmaster = new Cpack
	opackmaster.FRectUserID = userid
	opackmaster.FRectSessionID = guestSessionID
	opackmaster.frectmidx = midx
	opackmaster.Getpojangtemp_master()

if opackmaster.FResultCount < 1 then
	response.write "<script type='text/javascript'>alert('해당 선물 포장 내역이 없습니다.');</script>"
	dbget.close()	:	response.end
end if

dim message, title
	message = opackmaster.FItemList(0).Fmessage
	title = opackmaster.FItemList(0).Ftitle

dim opackdetail
set opackdetail = new Cpack
	opackdetail.FRectUserID = userid
	opackdetail.FRectSessionID = guestSessionID
	opackdetail.frectmidx = midx
	opackdetail.frectpojangok = "Y"

'	if (IsForeignDlv) then
'	    if (countryCode<>"") then
'	        opackdetail.FcountryCode = countryCode
'	    else
'	        opackdetail.FcountryCode = "AA"
'	    end if
'	elseif (IsArmyDlv) then
'	    opackdetail.FcountryCode = "ZZ"
'	else
		opackdetail.FcountryCode = "TT"
'	end if

	opackdetail.Getpojangtemp_detail(true)

Dim IsRsvSiteOrder, IsPresentOrder
	IsRsvSiteOrder = opackdetail.IsRsvSiteSangpumExists
	IsPresentOrder = opackdetail.IsPresentSangpumExists

dim oSailCoupon
set oSailCoupon = new CCoupon
oSailCoupon.FRectUserID = userid
oSailCoupon.FPageSize=100

if (userid<>"") and (Not IsRsvSiteOrder) and (Not IsPresentOrder) then   ''현장수령/Present 상품 쿠폰 사용 불가
	oSailCoupon.getValidCouponList
end if

'' (%) 보너스쿠폰 존재여부 - %할인쿠폰이 있는경우만 [%할인쿠폰제외상품]표시하기위함
dim intp, IsPercentBonusCouponExists
IsPercentBonusCouponExists = false
for intp=0 to oSailCoupon.FResultCount-1
    if (oSailCoupon.FItemList(intp).FCoupontype=1) then
        IsPercentBonusCouponExists = true
        Exit for
    end if
next

dim vShoppingBag_checkset
	vShoppingBag_checkset=0

vShoppingBag_checkset = getShoppingBag_checkset("TT")		'실제 장바구니 수량		TT:텐배

%>

<!-- #include virtual="/lib/inc/head_SSL.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script src="/lib/js/jquery.tinyscrollbar.js"></script>

<script type="text/javascript">

$(function() {
	$('.scrollbarwrap').tinyscrollbar();

	$('.inputBoxV15a input, .inputBoxV15a textarea').focus(function() {
		$(this).parent().children("label").hide();
	});
	$('.inputBoxV15a').focusin(function() {
		$(this).children("label").hide();
	});

//    $(document).keydown(function(event) {
//        if (event.ctrlKey==true && (event.which == '118' || event.which == '86')) {
//            event.preventDefault();
//         }
//    });

	<% if opackmaster.FItemList(0).Fpackitemcnt>0 then %>
		lengthcheck(pojangfrm.message);
	<% end if %>
});

function gostep1reset(midx){
	if (midx==''){
		alert('일렬번호가 없습니다.');
		return;
	}

	pojangfrm.mode.value='reset_step1';
	pojangfrm.midx.value=midx;
	pojangfrm.action = "<%= SSLURL %>/inipay/pack/pack_process.asp";
	pojangfrm.submit();
	return;
}

function lengthcheck(val){
	var len = val.value.length;
	if (len >= 101) {
		val.value = val.value.substring(0, 100);
	} else {
		$("#messagecnt").text(len);
	}
}
function lengthcheck2(val){
	var len = val.value.length;
	if (len >= 61) {
		val.value = val.value.substring(0, 60);
	}
}

//라인수체크		'//2015.12.11 한용민 생성
function fn_TextAreaLineLimit() {
    var tempText = $("textarea[name='message']").val();
    var lineSplit = tempText.split("\n");                //

    // 최대라인수 제어
    if(lineSplit.length >= 10 && event.keyCode == 13) {
        alert("선물 메세지는 10줄까지만 작성이 가능 합니다.");
        //event.returnValue = false;		//웹표준이 아님
        event.preventDefault(); 		//웹표준이긴한데.. 구형 브라우져에서 고장남.
    }
    return false;
}

function NextSelected(midx){
	if (midx==''){
		alert('일렬번호가 없습니다.');
		return;
	}
	if (pojangfrm.title.value == ''){
		alert("선물포장명을 입력해주세요.");
		pojangfrm.title.focus();
		return;
	}
//	if (GetByteLength(pojangfrm.title.value) > 60){
//		alert("선물 포장명이 제한길이를 초과하였습니다. 60자 까지 작성 가능합니다.");
//		pojangfrm.title.focus();
//		return;
//	}
//	if (pojangfrm.message.value != '' && GetByteLength(pojangfrm.title.value) > 100){
//		alert("선물 메세지가 제한길이를 초과하였습니다. 100자 까지 작성 가능합니다.");
//		pojangfrm.message.focus();
//		return;
//	}

	pojangfrm.mode.value='add_step2';
	pojangfrm.midx.value=midx;
	pojangfrm.action = "<%= SSLURL %>/inipay/pack/pack_process.asp";
	pojangfrm.submit();
	return;
}

function NextSelectedgostep1(midx, returnurl){
	if (midx==''){
		alert('일렬번호가 없습니다.');
		return;
	}
	if (pojangfrm.title.value == ''){
		alert("선물포장명을 입력해주세요.");
		pojangfrm.title.focus();
		return;
	}
//	if (GetByteLength(pojangfrm.title.value) > 60){
//		alert("선물 포장명이 제한길이를 초과하였습니다. 60자 까지 작성 가능합니다.");
//		pojangfrm.title.focus();
//		return;
//	}
//	if (pojangfrm.message.value != '' && GetByteLength(pojangfrm.title.value) > 100){
//		alert("선물 메세지가 제한길이를 초과하였습니다. 100자 까지 작성 가능합니다.");
//		pojangfrm.message.focus();
//		return;
//	}

	if(confirm("수정하시겠습니까?")){	
		pojangfrm.mode.value='add_step2';
		pojangfrm.midx.value=midx;
		pojangfrm.returnurl.value=returnurl;
		pojangfrm.action = "<%= SSLURL %>/inipay/pack/pack_process.asp";
		pojangfrm.submit();
	}
	return;
}

//마우스 오른쪽 클릭 막음		//2015.12.15 한용민 생성
window.document.oncontextmenu = new Function("return false");
//새창 띄우기 막음		//2015.12.15 한용민 생성
window.document.onkeydown = function(e){    	//Crtl + n 막음
    if(typeof(e) != "undefined"){
        if((e.ctrlKey) && (e.keyCode == 78)) return false;
    }else{
        if((event.ctrlKey) && (event.keyCode == 78)) return false;
    }
}
//드레그 막음		//2015.12.15 한용민 생성
window.document.ondragstart = new Function("return false");

</script>
</head>
<body>
<%' <!-- for dev msg : 팝업 창 사이즈 width=800, height=800 -->%>
<div class="heightgird">

	<div class="popWrap pkgProcessV15a">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_pop_tit.png" alt="선물포장" /></h1>

			<% '<!-- for dev msg : 메세지 수정하러 왔을경우, 단품포장 메세지 입력 경우 노출안됩니다. --> %>
			<% if not(opackmaster.FItemList(0).Fpackitemcnt>0 or vShoppingBag_checkset=0) then %>
				<div class="pkgStepV15a">
					<p class="step1"><span>상품선택</span></p>
					<p class="step2"><span><strong>메시지입력</strong></span></p>
					<p class="step3"><span>포장완료</span></p>
				</div>
			<% end if %>
		</div>
		<div class="popContent">
			<% '<!-- for dev msg : 메세지 수정하러 왔을때 노출됩니다.//--> %>
			<% if opackmaster.FItemList(0).Fpackitemcnt>0 then %>
				<p class="fs12">포장안에 들어갈 <strong>메세지를</strong> 수정하실 수 있습니다.</p>
			<% else %>
				<% '<!-- for dev msg : 묶음포장 메세지 입력 경우만 노출됩니다. --> %>
				<% if vShoppingBag_checkset=1 then %>
					<p class="fs12"><strong>선물포장명</strong>과 포장안에 들어갈 메시지를 입력해주세요.<br>(선물포장명은 각각의 포장을 구분하기 위한 포장의 이름입니다.)</p>
				<% else %>
					<!--<p class="fs12"><strong>선물포장명</strong>과 포장안에 들어갈 메시지를 입력해주세요.</p>-->
				<% end if %>
			<% end if %>

			<form name="pojangfrm" method="post" action="" style="margin:0px;">
			<input type="hidden" name="mode">
			<input type="hidden" name="midx">
			<input type="hidden" name="returnurl">
			<div class="pkgMakeV15a">
				<% '<!-- for dev msg : 묶음포장 메세지 입력 경우만 노출됩니다. --> %>
				<% if vShoppingBag_checkset=1 then %>
					<div class="inputBoxV15a" style="height:25px;">
						<input type="text" name="title" value="<%= title %>" onkeyup="lengthcheck2(this);" style="width:650px;" />
						<label class="fs16 cr999"><% if title="" then %>선물포장명을 입력해주세요.<% end if %></label>
					</div>
				<%
				'/장바구니단 에서 레알 단품 인것은 제목 입력창이 없어서 박아넣음
				else
				%>
					<input type="hidden" name="title" value="선물포장" />
				<% end if %>

				<% if opackdetail.FShoppingBagItemCount > 0 then %>
					<% '<!-- for dev msg : 묶음포장 메세지 입력 경우만 노출됩니다.(묶음, 단품의 개념이 아니고 여기서는 뿌릴때의 단순 항목의 수를 말하는거임. 기획자가 그러길 원함--> %>
					<% if opackdetail.FShoppingBagItemCount>1 then %>
						<div class="pkgBoxListV15a tMar30">
							<div class="scrollbarwrap">
								<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
								<div class="viewport">
									<div class="overview">
										<table width="100%" border="0" cellpadding="0" cellspacing="0" class="pkgPdtListV15a">
											<caption>선물 포장 상품 목록</caption>
											<colgroup>
												<col width="70" /><col width="" /><col width="90" /><col width="80" />
											</colgroup>
											<tbody>
											<% for i=0 to opackdetail.FShoppingBagItemCount - 1 %>
											<tr>
												<td><img src="<%= Replace(opackdetail.FItemList(i).FImageSmall,"http://webimage.10x10.co.kr/","/webimage/") %>" alt="<%= opackdetail.FItemList(i).FItemName %>" /></td>
												<td class="lt cGy1V15">
													<p>
														<% if opackdetail.FItemList(i).IsPLusSaleItem then %>
															<span class="crRed">[<strong>+</strong> Sale 상품]</span>
														<% end if %>
														<% if opackdetail.FItemList(i).IsMileShopSangpum then %>
															<span class="crRed">[마일리지샵상품]</span>
														<% end if %>
														<% if opackdetail.FItemList(i).Is09Sangpum or opackdetail.FItemList(i).IsReceiveSite then %>
															<span class="crRed">[단독구매상품]</span>
														<% end if %>
														<% if (opackdetail.FItemList(i).IsFreeBeasongItem) and Not(opackdetail.FItemList(i).IsReceiveSite) then %>
														<% if (opackdetail.FItemList(i).FMakerid<>"goodovening") then %>
															<span class="crRed">[무료배송상품]</span>
														<% end if %>
														<% end if %>
														<% if (opackdetail.FItemList(i).IsSpecialUserItem) then %>
															<span class="crGrn">[우수회원샵상품]</span>
														<% end if %>
														<% if (IsPercentBonusCouponExists and (opackdetail.FItemList(i).IsUnDiscountedMarginItem and Not opackdetail.FItemList(i).IsMileShopSangpum )) then %>
															<span class="crGrn">[%보너스쿠폰제외상품]</span>
														<% end if %>
														<% if (opackdetail.FItemList(i).IsBuyOrderItem) then %>
															<span class="crBlu">[선착순구매상품]</span>
														<% end if %>
														<% if (opackdetail.FItemList(i).IsForeignDeliverValid) then %>
															<span class="crBlu">[해외배송가능]</span>
														<% end if %>
														<% if (opackdetail.FItemList(i).FPojangOk="Y") then %>
															<span class="cPk0V15">[선물포장가능]</span>
														<% end if %>
													</p>
													<p class="tPad05"><%= opackdetail.FItemList(i).FItemName %></p>
	
													<% if opackdetail.FItemList(i).getOptionNameFormat<>"" then %>
														<p class="tPad02"><%= opackdetail.FItemList(i).getOptionNameFormat %></p>
													<% end if %>
												</td>
												<td>
													<% if opackdetail.FItemList(i).IsMileShopSangpum then %>
														<%= FormatNumber(opackdetail.FItemList(i).getRealPrice,0) %> Pt
													<% else %>
														<%= FormatNumber(opackdetail.FItemList(i).getRealPrice,0) %>원
													<% end if %>
												</td>
												<td><%= opackdetail.FItemList(i).fpojangitemno %></td>
											</tr>
											<% next %>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					<% else %>
						<% '<!-- for dev msg : 단품포장 메세지 입력 경우 노출됩니다.//--> %>
						<div class="pkgBoxListV15a tMar30">
							<table width="100%" border="0" cellpadding="0" cellspacing="0" class="pkgPdtListV15a">
								<caption>선물 포장 상품 목록</caption>
								<colgroup>
									<col width="70" /><col width="" /><col width="90" /><col width="80" />
								</colgroup>
								<tbody>
								<tr>
									<td><img src="<%= Replace(opackdetail.FItemList(0).FImageSmall,"http://webimage.10x10.co.kr/","/webimage/") %>" alt="<%= opackdetail.FItemList(0).FItemName %>" /></td>
									<td class="lt cGy1V15">
										<p>
											<% if opackdetail.FItemList(0).IsPLusSaleItem then %>
												<span class="crRed">[<strong>+</strong> Sale 상품]</span>
											<% end if %>
											<% if opackdetail.FItemList(0).IsMileShopSangpum then %>
												<span class="crRed">[마일리지샵상품]</span>
											<% end if %>
											<% if opackdetail.FItemList(0).Is09Sangpum or opackdetail.FItemList(0).IsReceiveSite then %>
												<span class="crRed">[단독구매상품]</span>
											<% end if %>
											<% if (opackdetail.FItemList(0).IsFreeBeasongItem) and Not(opackdetail.FItemList(0).IsReceiveSite) then %>
											<% if (opackdetail.FItemList(0).FMakerid<>"goodovening") then %>
												<span class="crRed">[무료배송상품]</span>
											<% end if %>
											<% end if %>
											<% if (opackdetail.FItemList(0).IsSpecialUserItem) then %>
												<span class="crGrn">[우수회원샵상품]</span>
											<% end if %>
											<% if (IsPercentBonusCouponExists and (opackdetail.FItemList(0).IsUnDiscountedMarginItem and Not opackdetail.FItemList(0).IsMileShopSangpum )) then %>
												<span class="crGrn">[%보너스쿠폰제외상품]</span>
											<% end if %>
											<% if (opackdetail.FItemList(0).IsBuyOrderItem) then %>
												<span class="crBlu">[선착순구매상품]</span>
											<% end if %>
											<% if (opackdetail.FItemList(0).IsForeignDeliverValid) then %>
												<span class="crBlu">[해외배송가능]</span>
											<% end if %>
											<% if (opackdetail.FItemList(0).FPojangOk="Y") then %>
												<span class="cPk0V15">[선물포장가능]</span>
											<% end if %>
										</p>
										<p class="tPad05"><%= opackdetail.FItemList(0).FItemName %></p>

										<% if opackdetail.FItemList(0).getOptionNameFormat<>"" then %>
											<p class="tPad02"><%= opackdetail.FItemList(0).getOptionNameFormat %></p>
										<% end if %>
									</td>
									<td>
										<% if opackdetail.FItemList(0).IsMileShopSangpum then %>
											<%= FormatNumber(opackdetail.FItemList(0).getRealPrice,0) %> Pt
										<% else %>
											<%= FormatNumber(opackdetail.FItemList(0).getRealPrice,0) %>원
										<% end if %>
									</td>
									<td><%= opackdetail.FItemList(0).fpojangitemno %></td>
								</tr>
								</tbody>
							</table>
						</div>
					<% end if %>
				<% end if %>

				<div class="inputBoxV15a" style="height:65px;">
					<textarea name="message" onkeyup="lengthcheck(this);" onkeydown="fn_TextAreaLineLimit();" style="width:650px;" rows="5"><%= message %></textarea>
					<label class="cr999"><% if message="" then %>선물과 함께 보낼 메시지를 입력해주세요. <br />(보내실 메세지가 없을 경우 작성하지 않으셔도 좋습니다 :D )<% end if %></label>
				</div>
				<p class="rt tPad05"><strong id="messagecnt">1</strong>/100</p>
			</div>
			</form>
		</div>
		<div class="popFooter">
			<%' <!-- for dev msg : 메세지 수정하러 왔을때 아래 버튼 하나만 노출됩니다.--> %>
			<% if opackmaster.FItemList(0).Fpackitemcnt>0 then %>
				<a href="" onclick="NextSelectedgostep1('<%= midx %>','STEP1'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_edit_ok.png" alt="수정 완료" /></a>

			<% '<!-- for dev msg : 단품 포장 메세지 입력의 경우 아래 버튼 하나만 노출됩니다.--> %>
			<% elseif vShoppingBag_checkset=0 then %>
				<a href="" onclick="NextSelected('<%= midx %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_msg_ok2.png" alt="입력 완료" /></a>

			<% else %>
				<a href="" onclick="gostep1reset('<%= midx %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_re_select.png" alt="상품 다시 선택하기" /></a>
				<a href="" onclick="NextSelected('<%= midx %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_msg_ok.png" alt="입력 완료" /></a>
			<% end if %>
		</div>
	</div>
</div>
</body>
</html>

<%
set opackdetail=nothing
set oSailCoupon=nothing
set opackmaster=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->