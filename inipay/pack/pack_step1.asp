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
dim idx
idx=0

Dim oTicketItem, TicketDlvType
Dim TicketBookingExired : TicketBookingExired=FALSE

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

dim oshoppingbag
set oshoppingbag = new Cpack
	oshoppingbag.FRectUserID = userid
	oshoppingbag.FRectSessionID = guestSessionID
	oshoppingbag.frectpojangok = "Y"

'	if (IsForeignDlv) then
'	    if (countryCode<>"") then
'	        oshoppingbag.FcountryCode = countryCode
'	    else
'	        oshoppingbag.FcountryCode = "AA"
'	    end if
'	elseif (IsArmyDlv) then
'	    oshoppingbag.FcountryCode = "ZZ"
'	else
		oshoppingbag.FcountryCode = "TT"
'	end if

	oshoppingbag.GetShoppingBag_pojangtemp_Checked(true)

dim vShoppingBag_pojang_checkValidItem, pojangcompleteyn
	vShoppingBag_pojang_checkValidItem=0
	pojangcompleteyn="N"

'/장바구니 상품과 선물포장 임시 상품이 유효한 상품인지 체크
vShoppingBag_pojang_checkValidItem = getShoppingBag_temppojang_checkValidItem("TT","Y")
if vShoppingBag_pojang_checkValidItem=1 then
	'//선물포장서비스 임시 테이블 비움
	call getpojangtemptabledel("")
	response.write "<script type='text/javascript'>alert('장바구니에 담긴 상품 수량 보다 선물포장이 된 상품 수량이 더많습니다.\n\n다시 포장해 주세요.');</script>"
	'dbget.close()	:	response.end
elseif vShoppingBag_pojang_checkValidItem=2 then
	response.write "<script type='text/javascript'>alert('장바구니에 담긴 상품이 없습니다.'); self.close();</script>"
	dbget.close()	:	response.end
elseif vShoppingBag_pojang_checkValidItem=3 then
	pojangcompleteyn="Y"
	'response.write "<script type='text/javascript'>alert('더이상 선물포장이 가능한 상품이 없습니다.');</script>"
	'dbget.close()	:	response.end
end if

Dim IsRsvSiteOrder, IsPresentOrder
	IsRsvSiteOrder = oshoppingbag.IsRsvSiteSangpumExists
	IsPresentOrder = oshoppingbag.IsPresentSangpumExists

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

'//선물포장 임시 패킹 리스트
dim opackmaster
set opackmaster = new Cpack
	opackmaster.FRectUserID = userid
	opackmaster.FRectSessionID = guestSessionID
	opackmaster.frectchkpojang = "Y"
	opackmaster.Getpojangtemp_master()

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
	$('.infoMoreViewV15a').mouseover(function(){
		$(this).children('.infoViewLyrV15a').show();
	});
	$('.infoMoreViewV15a').mouseleave(function(){
		$(this).children('.infoViewLyrV15a').hide();
	});

	$('.scrollbarwrap').tinyscrollbar();

	var mySwiper = new Swiper('.swiper-container',{
		pagination:false,
		slidesPerView:5
	})
	$('.arrow-left').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	})
	$('.arrow-right').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	})

	$('.swiper-slide a').click(function(e) {
		var thisIdx = $(this).parent().index();
		e.preventDefault();
//		mySwiper.removeSlide(thisIdx);
//		var slideNum = mySwiper.slides.length;
//		if (slideNum == 0) {
//			$('.pkgGroupV15a').hide();
//		}
	});

	<%
	'/단품일경우 바로 다음단계 로직을 태움.
	' if vShoppingBag_checkset=0 then
	%>
		//onedirectNextSelected();
	<% ' end if %>
});

<% '단품일경우 다음 단계 프로세스를 강제로 태우기 %>
function onedirectNextSelected(){
    var frm = document.baguniFrm;

	frm.chk_item.checked = true;
	NextSelected();
}

function pojangcomplete(){
    self.close();
}

function fnCheckAll(comp){
    var frm = document.baguniFrm;
    var p = comp.name;

    if (frm.chk_item){
        if (frm.chk_item.length){
            for(var i=0;i<frm.chk_item.length;i++){
				frm.chk_item[i].checked = comp.checked;
            }
        }else{
			frm.chk_item.checked = comp.checked;
        }
    }
}

function addItemNo(idx,addno){
    var frm = document.baguniFrm;

    var itemeacomp;
    var itemexistscnt=0;
    if (!frm.itemkey.length){
        itemeacomp = frm.itemea;
        itemexistscnt = parseInt(frm.bagitemea.value*1)-parseInt(frm.pojangitemno.value*1);
    }else{
        itemeacomp = frm.itemea[idx];
        itemexistscnt = parseInt(frm.bagitemea[idx].value*1)-parseInt(frm.pojangitemno[idx].value*1);
    }

    if (itemeacomp.value*1+addno<1) return;
    if ( itemeacomp.value*1+addno > itemexistscnt ) return;
    itemeacomp.value = itemeacomp.value*1+addno;
}

function chpojangdel(midx){
	if (midx==''){
		alert('일렬번호가 없습니다.');
		return;
	}

	if(confirm("선물포장을 삭제 하시겠습니까?")){	
		pojangfrm.mode.value='pojangdel';
		pojangfrm.midx.value=midx;
		pojangfrm.action = "<%= SSLURL %>/inipay/pack/pack_process.asp";
		pojangfrm.submit();
	}
	return;
}

function NextSelected(){
    var frm = document.baguniFrm;
    var chkExists = false;
    var mitemExists = false;
    var oitemExists = false;
    var nitemExists = false;
    var titemCount = 0;        //Ticket
    var rstemCount = 0;        //현장수령상품
    var pitemCount = 0;        //Present상품
    var mitemttl = 0;
    var itemexistscnt=0;
    var limitpackitemcnt=0;
    var limitpackitemnocnt=0;
    pojangfrm.itemidarr.value = "";
	pojangfrm.itemoptionarr.value = "";
	pojangfrm.itemeaarr.value = "";

    if (frm.chk_item){
        if (frm.chk_item.length){
            for(var i=0;i<frm.chk_item.length;i++){
                if (frm.chk_item[i].checked){
                    chkExists = true;
                    if (frm.mtypflag[i].value=="m"){
                        mitemExists = true;
                        mitemttl+=frm.isellprc[i].value*1;
                    }else if(frm.mtypflag[i].value=="o"){
                        oitemExists = true;
                    }else if(frm.mtypflag[i].value=="t"){
                        titemCount = titemCount+1;
                    }else if(frm.mtypflag[i].value=="r"){
                        rstemCount = rstemCount+1;
                    }else if(frm.mtypflag[i].value=="p"){
                        pitemCount = pitemCount+1;
                    }else{
                        nitemExists = true;
                    }
                    if (frm.soldoutflag[i].value == "Y"){
            			alert('품절된 상품은 구매하실 수 없습니다.');
            			frm.itemea[i].focus();
            			return;
            		}

					if (!IsDouble(frm.itemea[i].value)){
						alert('수량은 숫자만 가능합니다.');
						frm.itemea[i].focus();
						return;
					}
					if (frm.itemea[i].value<1){
						alert('수량은 1개부터 입력 가능 합니다.');
						frm.itemea[i].focus();
						return;
					}

					itemexistscnt = parseInt(frm.bagitemea[i].value*1)-parseInt(frm.pojangitemno[i].value*1);
				    if ( frm.itemea[i].value*1 > itemexistscnt ){
				        alert('포장 가능한 수량을 초과 하였습니다.\n수량을 확인해주세요.');
				        return;
				    }

				    pojangfrm.itemidarr.value = pojangfrm.itemidarr.value + frm.itemid[i].value + ","
					pojangfrm.itemoptionarr.value = pojangfrm.itemoptionarr.value + frm.itemoption[i].value + ","
					pojangfrm.itemeaarr.value = pojangfrm.itemeaarr.value + frm.itemea[i].value + ","
					
					limitpackitemcnt = limitpackitemcnt + 1;
					limitpackitemnocnt = parseInt(limitpackitemnocnt) + parseInt(frm.itemea[i].value*1)
                }
            }
        }else{
            if (frm.chk_item.checked){
                chkExists = true;
                if (frm.mtypflag.value=="m"){
                    mitemExists = true;
                    mitemttl+=frm.isellprc.value*1;
                }
                if (frm.soldoutflag.value == "Y"){
        			alert('품절된 상품은 구매하실 수 없습니다.');
        			frm.itemea.focus();
        			return;
        		}

				if (!IsDouble(frm.itemea.value)){
					alert('수량은 숫자만 가능합니다.');
					frm.itemea.focus();
					return;
				}
				if (frm.itemea.value<1){
					alert('수량은 1개부터 입력 가능 합니다.');
					frm.itemea.focus();
					return;
				}

				itemexistscnt = parseInt(frm.bagitemea.value*1)-parseInt(frm.pojangitemno.value*1);

			    if ( frm.itemea.value*1 > itemexistscnt ){
			        alert('포장 가능한 수량을 초과 하였습니다.\n수량을 확인해주세요.');
			        return;
			    }

			    pojangfrm.itemidarr.value = pojangfrm.itemidarr.value + frm.itemid.value
				pojangfrm.itemoptionarr.value = pojangfrm.itemoptionarr.value + frm.itemoption.value
				pojangfrm.itemeaarr.value = pojangfrm.itemeaarr.value + frm.itemea.value
				
				limitpackitemcnt = 1;
				limitpackitemnocnt = parseInt(frm.itemea.value*1)
            }
        }
    }

    if (!chkExists){
        alert('선택된 상품이 없습니다.\n포장하실 상품을 선택 후 진행해 주세요.');
		return;
    }

    if (rstemCount>0){
        alert('현장수령 상품은 포장 하실수 없습니다.');
        return;
    }

    if (limitpackitemcnt>10){
        alert('특별하고 예쁜 포장을 위해\n포장 상품 개수는 10개로 제한됩니다.');
        return;
    }
    if (limitpackitemnocnt>10){
        alert('특별하고 예쁜 포장을 위해\n포장 상품 개수는 10개로 제한됩니다.');
        return;
    }

	pojangfrm.mode.value='add_step1';
	pojangfrm.midx.value='';
	pojangfrm.action = "<%= SSLURL %>/inipay/pack/pack_process.asp";
	pojangfrm.submit();
	return;
}

function gostep2edit(midx){
	if (midx==''){
		alert('일렬번호가 없습니다.');
		return;
	}

	pojangfrm.midx.value=midx;
	pojangfrm.action = "<%= SSLURL %>/inipay/pack/pack_step2.asp";
	pojangfrm.submit();
	return;
}

function IsDouble(v){
	if (v.length<1) return false;

	for (var j=0; j < v.length; j++){
		if ("0123456789.".indexOf(v.charAt(j)) < 0) {
			return false;
		}
	}
	return true;
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
<% '<!-- for dev msg : 팝업 창 사이즈 width=800, height=800 --> %>
<div class="heightgird">

	<div class="popWrap pkgProcessV15a">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_pop_tit.png" alt="선물포장" /></h1>

			<%
			'/<!-- for dev msg : 포장할 상품 있을때 -->
			if pojangcompleteyn="N" then
			%>
				<div class="pkgStepV15a">
					<p class="step1"><span><strong>상품선택</strong></span></p>
					<p class="step2"><span>메시지입력</span></p>
					<p class="step3"><span>포장완료</span></p>
				</div>
			<% end if %>
		</div>
		<div class="popContent">
			<form name="baguniFrm" method="post" onSubmit="return false" style="margin:0px;" >
			<input type="hidden" name="mode">
			
			<%
			'/<!-- for dev msg : 포장할 상품 있을때 -->
			if pojangcompleteyn="N" then
			%>
				<div class="pkgInfoV15a">
					<p class="fs12">상품 선택 후 "<strong>선택상품 포장하기</strong>"를 눌러 선물 포장을 진행해주세요.</p>
					<!--
					<dl class="wtTotalV15a">
						<dt class="infoMoreViewV15a">
							<span>선택된 상품용량</span>
							<div class="infoViewLyrV15a">
								<div class="infoViewBoxV15a">
									<dfn></dfn>
									<div class="infoViewV15a">
										<div class="pad15"><span class="cRd0V15">선물상자 한 개</span>에 최대로 담을 수 있는 <br /><span class="cRd0V15">상품 용량</span>을 알려드립니다</div>
									</div>
								</div>
							</div>
						</dt>
						<dd class="pkgWt">
							<div style="width:30%;"></div><!-- for dev msg : 상품 용량대비 백분율 적용(한칸=10%) 
						</dd>
					</dl>
					-->
				</div>
	
				<div class="pkgPdtListWrapV15a">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<caption>선물 포장 상품 목록</caption>
						<colgroup>
							<col width="30" /><col width="60" /><col width="" /><col width="90" /><!-- <col width="80" /> --><col width="125" />
						</colgroup>
						<thead>
						<tr>
							<th><input type="checkbox" name="chk_all" onClick="fnCheckAll(this);" /></th>
							<th colspan="2">상품정보</th>
							<th>가격</th>
							<th>수량</th>
							<!--
							<th>상품용량</th>
							-->
						</tr>
						</thead>
						<tbody>
						<tr>
							<td colspan="6">
								<div class="scrollbarwrap">
									<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
									<div class="viewport">
										<div class="overview">
											<% if oshoppingbag.FShoppingBagItemCount > 0 then %>
												<table width="100%" border="0" cellpadding="0" cellspacing="0" class="pkgPdtListV15a">
													<caption>선물 포장 상품 목록</caption>
													<colgroup>
														<col width="30" /><col width="60" /><col width="" /><col width="90" /><!-- <col width="80" /> --><col width="125" />
													</colgroup>
													<tbody>
													<%
													for i=0 to oshoppingbag.FShoppingBagItemCount - 1
													
													if oshoppingbag.FItemList(i).FItemEa > oshoppingbag.FItemList(i).fpojangitemno then
													%>
														<%
														TicketBookingExired = FALSE
														IF (oshoppingbag.FItemList(i).IsTicketItem) then
																set oTicketItem = new CTicketItem
																oTicketItem.FRectItemID = oshoppingbag.FItemList(0).FItemID
																oTicketItem.GetOneTicketItem
																IF (oTicketItem.FResultCount>0) then
																		TicketBookingExired = oTicketItem.FOneItem.IsExpiredBooking
																		TicketDlvType = oTicketItem.FOneItem.FticketDlvType
																END IF
																set oTicketItem = Nothing
														end if
														%>
														<input type="hidden" name="distinctkey" value="<%= i %>">
														<input type="hidden" name="itemkey" value="<%=oshoppingbag.FItemList(i).FItemID %>_<%=oshoppingbag.FItemList(i).FItemOption %>">
														<input type="hidden" name="itemid" value="<%= oshoppingbag.FItemList(i).FItemID %>">
														<input type="hidden" name="itemoption" value="<%= oshoppingbag.FItemList(i).FItemoption %>">
														<input type="hidden" name="soldoutflag" value="<% if (oshoppingbag.FItemList(i).IsSoldOut or TicketBookingExired) then response.write "Y" else response.write "N" end if %>">
														<input type="hidden" name="foreignflag" value="<% if oshoppingbag.FItemList(i).IsForeignDeliverValid then response.write "Y" else response.write "N" end if %>">
														<input type="hidden" name="itemcouponsellpriceflag" value="<%= oshoppingbag.FItemList(i).GetCouponAssignPrice %>">
														<input type="hidden" name="curritemcouponidxflag" value="<%= oshoppingbag.FItemList(i).Fcurritemcouponidx %>">
														<input type="hidden" name="itemsubtotalflag" value="<%= oshoppingbag.FItemList(i).GetCouponAssignPrice * oshoppingbag.FItemList(i).FItemEa %>">
														<input type="hidden" name="couponsailpriceflag" value="<%= (oshoppingbag.FItemList(i).getRealPrice-oshoppingbag.FItemList(i).GetCouponAssignPrice) * oshoppingbag.FItemList(i).FItemEa %>">
														<input type="hidden" name="dtypflag" value="<%=oshoppingbag.FItemList(i).Fdeliverytype%>">
		
														<% if oshoppingbag.FItemList(i).Is09Sangpum then %>
															<input type="hidden" name="mtypflag" value="o">
														<% elseif oshoppingbag.FItemList(i).IsTicketItem then %>
															<input type="hidden" name="mtypflag" value="t">
														<% elseif oshoppingbag.FItemList(i).IsPresentItem then %>
															<input type="hidden" name="mtypflag" value="p">
														<% elseif oshoppingbag.FItemList(i).IsMileShopSangpum then %>
															<input type="hidden" name="mtypflag" value="m">
														<% elseif oshoppingbag.FItemList(i).IsReceiveSite then %>
															<input type="hidden" name="mtypflag" value="r">
														<% else %>
															<input type="hidden" name="mtypflag" value="">
														<% end if %>
		
														<input type="hidden" name="isellprc" value="<%= oshoppingbag.FItemList(i).getRealPrice %>">
														<tr>
															<td><input type="checkbox" name="chk_item" id="<%= oshoppingbag.FItemList(i).FItemID & oshoppingbag.FItemList(i).FItemoption %>" value="ON" /></td>
															<td class="lt"><img src="<%= Replace(oshoppingbag.FItemList(i).FImageSmall,"http://webimage.10x10.co.kr/","/webimage/") %>" alt="<%= oshoppingbag.FItemList(i).FItemName %>" /></td>
															<td class="lt cGy1V15">
																<p>
																	<% if oshoppingbag.FItemList(i).IsPLusSaleItem then %>
																		<span class="crRed">[<strong>+</strong> Sale 상품]</span>
																	<% end if %>
																	<% if oshoppingbag.FItemList(i).IsMileShopSangpum then %>
																		<span class="crRed">[마일리지샵상품]</span>
																	<% end if %>
																	<% if oshoppingbag.FItemList(i).Is09Sangpum or oshoppingbag.FItemList(i).IsReceiveSite then %>
																		<span class="crRed">[단독구매상품]</span>
																	<% end if %>
																	<% if (oshoppingbag.FItemList(i).IsFreeBeasongItem) and Not(oshoppingbag.FItemList(i).IsReceiveSite) then %>
																	<% if (oshoppingbag.FItemList(i).FMakerid<>"goodovening") then %>
																		<span class="crRed">[무료배송상품]</span>
																	<% end if %>
																	<% end if %>
																	<% if (oshoppingbag.FItemList(i).IsSpecialUserItem) then %>
																		<span class="crGrn">[우수회원샵상품]</span>
																	<% end if %>
																	<% if (IsPercentBonusCouponExists and (oshoppingbag.FItemList(i).IsUnDiscountedMarginItem and Not oshoppingbag.FItemList(i).IsMileShopSangpum )) then %>
																		<span class="crGrn">[%보너스쿠폰제외상품]</span>
																	<% end if %>
																	<% if (oshoppingbag.FItemList(i).IsBuyOrderItem) then %>
																		<span class="crBlu">[선착순구매상품]</span>
																	<% end if %>
																	<% if (oshoppingbag.FItemList(i).IsForeignDeliverValid) then %>
																		<span class="crBlu">[해외배송가능]</span>
																	<% end if %>
																	<% if (oshoppingbag.FItemList(i).FPojangOk="Y") then %>
																		<span class="cPk0V15">[선물포장가능]</span>
																	<% end if %>
																</p>
																<p class="tPad05"><%= oshoppingbag.FItemList(i).FItemName %></p>
		
																<% if oshoppingbag.FItemList(i).getOptionNameFormat<>"" then %>
																	<p class="tPad02"><%= oshoppingbag.FItemList(i).getOptionNameFormat %></p>
																<% end if %>
															</td>
															<td>
																<% if oshoppingbag.FItemList(i).IsMileShopSangpum then %>
																	<%= FormatNumber(oshoppingbag.FItemList(i).getRealPrice,0) %> Pt
																<% else %>
																	<%= FormatNumber(oshoppingbag.FItemList(i).getRealPrice,0) %>원
																<% end if %>
															</td>
															<td><% ' oshoppingbag.FItemList(i).FItemEa-oshoppingbag.FItemList(i).fpojangitemno %>
																<input type="text" name="itemea" value="1" style="width:24px" class="txtInp ct" />
																<span class="orderNumAtc">
																	<span>
																		<a href="" onclick="addItemNo(<%= idx %>,1); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_num_up.png" alt="갯수 더하기" /></a>
																	</span>
																	<span class="tPad02">
																		<a href="" onclick="addItemNo(<%= idx %>,-1); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_num_down.png" alt="갯수 빼기" /></a>
																	</span>
																</span>
																<span> / <%= oshoppingbag.FItemList(i).FItemEa-oshoppingbag.FItemList(i).fpojangitemno %></span>
																<input type="hidden" name="bagitemea" value="<%= oshoppingbag.FItemList(i).FItemEa %>" />
																<input type="hidden" name="pojangitemno" value="<%= oshoppingbag.FItemList(i).fpojangitemno %>" />
															</td>
															<!--
															<td><div class="pkgWt" style="width:100px;"><div></div></div></td><!-- for dev msg : 상품 용량대비 백분율 적용(한칸=10px) 
															-->
														</tr>
														<% idx = idx +1 %>
													<% end if %>
													<% next %>
													</tbody>
												</table>
											<% end if %>
										</div>
									</div>
								</div>
							</td>
					</table>
				</div>
			<%
			'/<!-- for dev msg : 포장할 상품 없을때 -->
			else
			%>
				<div class="pkgPdtNoneV15a">
					<p class="fs16"><strong>모든 상품이 선물포장 되었습니다.</strong></p>
					<p class="cGy0V15">포장 내역 확인 또는 메시지 수정 시 아래 선물상자 아이콘을 선택해주세요.</p>
				</div>
			<% end if %>
			</form>
		</div>
		
		<% if opackmaster.FResultCount > 0 then %>
			<div class="pkgGroupV15a">
				<div class="groupViewV15a">
					<a class="arrow-left" href="#">이전 폴더 보기</a>
					<a class="arrow-right" href="#">다음 폴더 보기</a>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<% for i=0 to opackmaster.FResultCount - 1 %>
							<div class="swiper-slide" midx="<%= opackmaster.FItemList(i).Fmidx %>">
								<% '<!-- for dev msg : 포장에 메세지 입력된경우 msgHaveV15a 클래스 추가해주세요 --> %>
								<div class="pkgBoxV15a <% if opackmaster.FItemList(i).Fmessage<>"" then response.write " msgHaveV15a" %>" onclick="gostep2edit('<%= opackmaster.FItemList(i).Fmidx %>'); return false;">
									<%= opackmaster.FItemList(i).Fpackitemcnt %><i>포장메세지</i>
								</div>
								<p><%= opackmaster.FItemList(i).Ftitle %></p>
								<a href="" onclick="chpojangdel('<%= opackmaster.FItemList(i).Fmidx %>'); return false;" class="btn btnS2 btnGry2">
								<em class="fn">삭제</em></a>
							</div>
							<% next %>
						</div>
					</div>
				</div>
			</div>
		<% end if %>

		<div class="popFooter">
			<%
			'/포장한 내역이 있을경우
			if opackmaster.FResultCount < 1 then
			%>
				<a href="" onclick="NextSelected(); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_select_pkg.png" alt="선택상품 포장하기" /></a>
			<% else %>
				<%
				'/<!-- for dev msg : 포장할 상품 있을때 -->
				if pojangcompleteyn="N" then
				%>
					<a href="" onclick="NextSelected(); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_select_pkg.png" alt="선택상품 포장하기" /></a>
				<% else %>
					<a href="" onclick="pojangcomplete(); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_pkg_ok2.png" alt="포장완료" /></a>
				<% end if %>

				<% '<!-- for dev msg : 폴더 리스트 생성후 아래버튼 노출됩니다. --> %>
				<!--<a href="" onclick="NextSelected(); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_select_pkg2.png" alt="선택상품 포장하기" /></a>
				<a href="" onclick="pojangcomplete(); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_pkg_ok.png" alt="포장완료" /></a>-->
			<% end if %>
		</div>
	</div>
</div>
<form name="pojangfrm" method="post" action="" style="margin:0px;">
<input type="hidden" name="mode">
<input type="hidden" name="midx">
<input type="hidden" name="itemidarr">
<input type="hidden" name="itemoptionarr">
<input type="hidden" name="itemeaarr">
</form>
</body>
</html>

<%
set oshoppingbag=nothing
set oSailCoupon=nothing
set opackmaster=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->