<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% const MenuSelect = "03" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/header.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->

<%

dim i, j, lp
dim page, pflag
pflag = requestCheckVar(request("pflag"),10)
page = requestCheckVar(request("page"),9)
if (page="") then page = 1

dim userid, orderserial
userid = getEncLoginUserID()
orderserial  = requestCheckVar(request("idx"),11)

dim myorder
set myorder = new CMyOrder

myorder.FPageSize = 10
myorder.FCurrpage = page
myorder.FRectUserID = userid
myorder.FRectSiteName = "10x10"
myorder.FRectOldjumun = pflag
myorder.FrectSearchGubun = "cancel"

if IsUserLoginOK() then
        myorder.FRectUserID = getEncLoginUserID()
        myorder.GetMyOrderList
elseif IsGuestLoginOK() then
        orderserial = GetGuestLoginOrderserial()
        myorder.FRectOrderserial = orderserial
        myorder.GetMyOrderList 
end if

dim ocslist, IsCSASCancelRequireListExists
IsCSASCancelRequireListExists = False

set ocslist = new CCSASList
if IsUserLoginOK() then
    ocslist.FRectUserID = GetLoginUserID()
    IsCSASCancelRequireListExists = ocslist.IsCSASCancelRequireListExists
elseif IsGuestLoginOK() then
    orderserial = GetGuestLoginOrderserial()
    ocslist.FRectOrderserial = orderserial
    IsCSASCancelRequireListExists = ocslist.IsCSASCancelRequireListExists
end if
set ocslist = Nothing

'네비바 내용 작성
strMidNav = "MY 쇼핑리스트 > <b>주문취소</b>"
%>



<script language='javascript'>
function goPage(page){
    location.href="?page=" + page ;
}


function popEditOrderInfo(orderserial){
    var popwin = window.open('/my10x10/orderPopup/popEditOrderInfo.asp?orderserial=' + orderserial,'popEditOrderInfo','width=800,height=800,scrollbars=yes,resizable=yes');
    popwin.focus();
}

function popReqOrderInfo(){
    var popwin = window.open('/my10x10/orderPopup/popReqOrderInfo.asp?orderserial=' + orderserial,'popReqOrderInfo','width=800,height=800,scrollbars=yes,resizable=yes');
    popwin.focus();
}

function popEditOrderDetailInfo(orderserial){
    var popwin = window.open('/my10x10/orderPopup/popEditOrderDetailInfo.asp?orderserial=' + orderserial,'popEditOrderDetailInfo','width=800,height=800,scrollbars=yes,resizable=yes');
    popwin.focus();
}

function popCancelOrder(orderserial,flag){
    var popwin = window.open('/my10x10/orderPopup/popCancelOrder.asp?orderserial=' + orderserial + '&flag=' + flag,'popCancelOrder','width=800,height=800,scrollbars=yes,resizable=yes');
    popwin.focus();
}

function popEditHandMadeReq(orderserial,idx){
    var popwin = window.open('/my10x10/orderPopup/popEditHandMadeReq.asp?orderserial=' + orderserial + '&idx=' + idx,'popEditHandMadeReq','width=340,height=300,scrollbars=yes,resizable=yes');
    popwin.focus();
}
</script>

		
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="960">
	<!----- 마이텐바이텐 타이틀 시작 ----->
	<!-- #include virtual ="/lib/topMenu/top_my10x10.asp" -->
	<!----- 마이텐바이텐 타이틀 끝 ----->
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="mar_top_20px">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="180" valign="top" style="padding-right:20px">
            <!----- 레프트 시작 ----->
            <!-- #include virtual ="/lib/leftmenu/left_my10x10.asp" -->
            <!----- 레프트 끝 ----->
            </td><!----- 주문취소 시작 ----->
            <td width="780" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- My10x10 메뉴 -->
					<!-- #include virtual ="/lib/topmenu/Menu_my10x10.asp" -->
					</td>
				</tr>
              <tr>
                <td class="pdd_top_30px"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2010/mytenbyten/title_main03.gif"></td>
                    </tr>
                    <tr>
                      <td style="padding-bottom:20px"><table width="760" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                          <td style="line-height:16px">주문취소가 가능한 주문내역만 표시됩니다. <br>
                            <strong>WEB바로취소</strong> : 주문통보 이전단계에서는 고객님이 직접 WEB 취소가 가능합니다.<br>
                            <strong>1:1상담요청</strong> : 1:1상담요청을 통해 취소요청을 해주시면, 취소가능여부 확인 후, 고객님께 안내해드리겠습니다.</td>
                          <td width="200" align="right" style="padding-right:15px">
                          <% if (IsCSASCancelRequireListExists) then %>
                          <a href="/my10x10/order/cancelrequire.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/btn_gosoldout.gif" width="114" height="42" border="0"></a>
                          <% end if %>
                          </td>
                        </tr>
                      </table></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <!----- 주문리스트 시작 ----->
                <td style="padding:0 0 25px 0"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr bgcolor="#fcf6f6">
                    <td height="30" style="border-top:3px solid #be0808;border-bottom:1px solid #eaeaea;padding-top:3px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="100" align="center" style="padding-left:5px;">주문번호</td>
                          <td width="100" align="center">주문일자</td>
                          <td align="center">상품명 [옵션]</td>
                          <td width="95" align="center">총 결제 금액</td>
                          <td width="95" align="center">주문상태</td>
                          <td width="95" align="center">취소가능여부</td>
                        </tr>
                    </table></td>
                  </tr>

				<% for i = 0 to (myorder.FResultCount - 1) %>
                  <tr>
                    <td height="30" style="border-bottom:1px solid #eaeaea;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="100" align="center" style="padding-left:5px;"><%= myorder.FItemList(i).FOrderSerial %></td>
                          <td width="100" align="center" class="link_gray_11px_line" style="padding-top:3px;line-height:17px;"><%= Left(CStr(myorder.FItemList(i).Fregdate),10) %></td>
                          <td style="padding:3px 0 0 5px;line-height:17px;">
						<% if (myorder.FItemList(i).IsWebOrderCancelEnable) then %>
							<a href="javascript:popCancel('<%= myorder.FItemList(i).FOrderSerial %>');" onFocus="this.blur();" class="link_gray_11px_line">
							<%= myorder.FItemList(i).GetItemNames %>
							</a>
						<% else %>
							<%= myorder.FItemList(i).GetItemNames %>
						<% end if %>
						  </td>
                          <td width="95" align="center" style="padding-top:3px;"><%= FormatNumber(myorder.FItemList(i).FSubTotalPrice,0) %>원</td>
                          <td width="95" align="center" class="link_gray_11px_line" style="padding-top:3px;"><font color="<%=myorder.FItemList(i).GetIpkumDivColor%>"><%= myorder.FItemList(i).GetIpkumDivName %></font></td>
                          <td width="95" align="center" style="padding-top:3px;">
						<% if (myorder.FItemList(i).IsWebOrderCancelEnable) then %>
							<a href="javascript:popCancel('<%= myorder.FItemList(i).FOrderSerial %>');" onFocus="this.blur();" class="green11px02"><span class="green11px02">WEB바로취소</span></a>
						<% elseif (myorder.FItemList(i).IsWebOrderCancelRequirable) then %>
							<a href="javascript:myqnawriteWithParam('<%= myorder.FItemList(i).FOrderSerial %>','04','');" onFocus="this.blur();" class="blue11px02"><span class="blue11px02">1:1상담요청</span></a>
						<% else %>
							<span class="red_11px">취소불가</span>
						<% end if %>
						  </td>
                        </tr>
                    </table></td>
                  </tr>
				<% next %>
				<% if myorder.FResultCount < 1 then %>
					<tr>
						<td align="center" style="padding-top:10px;padding-bottom:5px; border-bottom:1px solid #eaeaea;">취소 가능한 주문내역이 없습니다.</td>
					<tr>
				<% end if %>

					<tr>
						<td align="center" style="padding-top:10px">
							<%=fnPaging("page", myorder.FtotalCount, myorder.FcurrPage, myorder.FPageSize, 5)%>
						</td>
					</tr>
                </table></td>
           		 <!----- 주문리스트 끝 ----->
              </tr>
				<tr>
					<td>
						<!----- 도움말 시작 ----->
						<!-- #include virtual ="/cscenter/help/help_order_cancel.asp" -->
						<!----- 도움말 끝 ----->
					</td>
				</tr>

            </table></td><!----- 주문취소 끝----->
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>



<%
set myorder = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/tailer.asp" -->