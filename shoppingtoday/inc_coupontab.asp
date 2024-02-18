<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/couponshopcls.asp" -->
<%
Dim stab, vTempCount, arrList, cCouponMaster, intLoop, arrItem, intItem, k, stype, couCnt
stab = requestCheckVar(Request("stab"),4)
stype = request("stype")
If stab = "" Then stab = "all" End If
If stype = "" Then stype = 1 End If
set cCouponMaster = new ClsCouponShop
	cCouponMaster.Ftype = stype
	arrList = cCouponMaster.fnGetCouponTabList
If cCouponMaster.FRecordCount <> "" Then
	coucnt = cCouponMaster.FRecordCount
Else
	coucnt = 0
End If
%>
<script type="text/javascript">
function changetab(stab,stype){
   self.location.href = "/shoppingtoday/inc_coupontab.asp?stab="+stab+"&stype="+stype;
}
function PopItemCouponAssginList(iidx){
	var popwin = window.open('/my10x10/Pop_CouponItemList.asp?itemcouponidx=' + iidx + '&tab=Y','PopItemCouponAssginList','width=700,height=800,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function jsDownCoupon(stype,idx){
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
		return;
	}

	var frm;
		frm = document.frmIC;
		frm.stype.value = stype;
		frm.idx.value = idx;
		frm.submit();
}

function jsDownSelCoupon(sgubun,gubun){
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
		return;
	}

	var chkCnt = 0;
	var stype = "";
	var idx = "";
	var frm = document.frmIC;

	if(sgubun=="A"){
		if(frm.chkidx){
			if (!frm.chkidx.length){
				if(frm.chkidx.stype == gubun) {
					 stype = frm.chkidx.stype;
					 idx = frm.chkidx.value;
					 chkCnt = 1;
				}
			} else {
		 		for(i=0;i<frm.chkidx.length;i++) {
		 			if(frm.chkidx[i].getAttribute("stype") == gubun) {
		 				if (chkCnt == 0 ) {
		 					stype = frm.chkidx[i].getAttribute("stype");
		 					idx = frm.chkidx[i].value;
		 				} else {
		 					stype =stype+"," +frm.chkidx[i].getAttribute("stype");
		 					idx = idx+"," +frm.chkidx[i].value;
		 				}
		 				chkCnt += 1;
		 			}
		 		}
		 	}
	 	} else {
	 		alert("등록된 쿠폰이 없습니다.");
	 		return;
	 	}
	 } else {
	 	if(frm.chkidx){
	 		if (!frm.chkidx.length) {
	 			if (frm.chkidx.checked) {
	 				if(frm.chkidx.stype == gubun) {
	 					stype = frm.chkidx.stype;
	 					idx = frm.chkidx.value;
	 					chkCnt = 1;
	 				}
	 			}
 			} else {
 				for(i=0;i<frm.chkidx.length;i++) {
 					if(frm.chkidx[i].getAttribute("stype") == gubun) {
 						if (frm.chkidx[i].checked) {
 							if ( chkCnt == 0 ) {
 								stype = frm.chkidx[i].getAttribute("stype");
 								idx = frm.chkidx[i].value;
 							} else {
 								stype =stype+"," +frm.chkidx[i].getAttribute("stype");
 								idx = idx+"," +frm.chkidx[i].value;
 							}
 							chkCnt += 1;
 						}
 					}
 				}
 			}
 		} else {
 			alert("등록된 쿠폰이 없습니다.");
 			return;
 		}

 		if ( chkCnt == 0 ) {
 			alert("다운받으실 쿠폰을 선택해 주세요.");
 			return;
 		}
	 }

  	frm.stype.value = stype;
  	frm.idx.value =idx;
	frm.submit();
	}

   	function dblclick() {
		top.window.scrollTo(0,0)
	}
	if (document.layers) {
		document.captureEvents(Event.ONDBLCLICK);
	}
	document.ondblclick=dblclick;
</script>

	<div class="hotSectionV15 enjoyCouponV15">
		<div class="hotArticleV15">
		<form name="frmIC" method="post" action="couponshop_process.asp" style="margin:0px;">
		<input type="hidden" name="stype" value="">
		<input type="hidden" name="idx" value="">
			<div class="couponList">
				<h3 class="tMar35">상품쿠폰</h3>
				<ul class="tabMenu">
					<li><a href="javascript:changetab('','1');" onfocus="blur()" class="<%= chkIIF(stab="all","on","") %>">전체 <% If stab = "all" Then %>(<strong><%=coucnt%></strong>)<% End If %></a></li>
					<li><a href="javascript:changetab('sale','2');" onfocus="blur()" class="<%= chkIIF(stab="sale","on","") %>">할인쿠폰 <% If stab = "sale" Then %>(<strong><%=coucnt%></strong>)<% End If %></a></li>
					<li><a href="javascript:changetab('free','3');" onfocus="blur()" class="<%= chkIIF(stab="free","on","") %>">무료배송쿠폰 <% If stab = "free" Then %>(<strong><%=coucnt%></strong>)<% End If %></a></li>
				</ul>
				<%
				vTempCount = 0
				If cCouponMaster.FRecordCount <> "" Then
					For intLoop = 0 To UBound(arrList,2)
						If arrList(0,intLoop) <> "event" Then
				%>
				<div class="couponBox">
					<div class="box">
						<div class="title">
							<span class="tag green">
								<% IF arrList(2,intLoop) = 3 THEN	'쿠폰타입(무료배송) %>
                      				<img src="http://fiximage.10x10.co.kr/web2013/common/cp_green_freeship.png">
                      			<% ELSE %>
                      				<%=FnCouponValueView_2011(arrList(0,intLoop),CLng(arrList(3,intLoop)),arrList(2,intLoop))%>
                      			<% END IF %>
							</span>
						</div>
						<div class="account">
							<ul>
								<li class="name"><%=chrbyte(db2html(arrList(4,intLoop)),30,"Y")%></li>
								<li class="date"><%=FormatDate(arrList(7,intLoop),"0000.00.00")%>~<%=FormatDate(arrList(8,intLoop),"0000.00.00")%></li>
							</ul>
							<div class="photo">
							<%
								cCouponMaster.Fitemcouponidx = arrList(1,intLoop)

								arrItem = cCouponMaster.fnGetCouponItemList

								IF isArray(arrItem)	THEN
							%>
								<img src="<%=getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(arrItem(0,intItem)) & "/" & arrItem(12,intItem),230,230,"true","false")%>" width="230" height="230" alt="<%=arrItem(4,intItem)%>" />

							<%
								End If
							%>
							</div>
						</div>
					</div>
					<div class="btn">
						<a href="javascript:PopItemCouponAssginList('<%=arrList(1,intLoop)%>');" title="새창에서 열림"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_view.png" alt="적용상품보기" /></a>
						<a href="javascript:jsDownCoupon('<%=arrList(0,IntLoop)%>','<%=arrList(1,IntLoop)%>');" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_download_green.gif" alt="다운로드" /></a>
					</div>
				</div>
			<%
						End If
					Next
		      ELSE
			%>
				<p class="noData"><strong>진행되고 있는 할인 쿠폰이 없습니다.</strong></p>
			<% End If %>
			</div>
		</form>
		</div>
	</div>
