<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% const MenuSelect = "04" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/header.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->

<%

dim i, j, lp
dim page
dim pflag
pflag = requestCheckVar(request("pflag"),10)
page  = requestCheckVar(request("page"),9)
if (page="") then page = 1

'==============================================================================
'나의주문
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
myorder.FrectSearchGubun = "return"

if IsUserLoginOK() then
    myorder.FRectUserID = getEncLoginUserID()
    myorder.GetMyOrderList
elseif IsGuestLoginOK() then
    myorder.FRectOrderserial = GetGuestLoginOrderserial()
    myorder.GetMyOrderList 
else
    dbget.close()	:	response.End
end if


'네비바 내용 작성
strMidNav = "MY 쇼핑리스트 > <b>반품 / 환불</b>"
%>
<script language='javascript'>
function goPage(page){
    location.href="?page=" + page ;
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
            </td><!----- 반품신청 시작 ----->
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
                      <td style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2010/mytenbyten/title_main04.gif"></td>
                    </tr>
                    <tr>
                      <td style="padding-bottom:20px;line-height:16px"><span class="red_11px">상품출고일 기준으로 7일 이내(평일기준)에 반품 / 환불 가능합니다.</span><br>
                        반품을 원하시는 상품이 포함된 주문의 주문번호나 [반품접수] 버튼을 클릭해주시면, 상세정보에서 반품등록이 가능합니다. <br>
                        이미 접수한신 반품/환불 서비스는 [내가 신청한 서비스]에서도 확인하실 수 있습니다. </td>
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
                          <td width="95" align="center">배송상태</td>
                          <td width="95" align="center">반품가능여부</td>
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
						<% if (myorder.FItemList(i).IsWebOrderReturnEnable) then %>
							<a href="order_return_detail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>&pflag=<%= pflag %>" onFocus="this.blur();">
							<%= myorder.FItemList(i).GetItemNames %>
							</a>
						<% elseif myorder.FItemList(i).FcsReturnCnt>0 then %>
							<a href="order_cslist.asp?orderSerial=<%= myorder.FItemList(i).FOrderSerial %>" onFocus="this.blur();">
							<%= myorder.FItemList(i).GetItemNames %>
							</a>
						<% else %>
							<%= myorder.FItemList(i).GetItemNames %>
						<% end if %>
						  </td>
                          <td width="95" align="center" style="padding-top:3px;"><%= FormatNumber(myorder.FItemList(i).FSubTotalPrice,0) %>원</td>
                          <td width="95" align="center" class="link_gray_11px_line" style="padding-top:3px;"><font color="<%=myorder.FItemList(i).GetIpkumDivColor%>"><%= myorder.FItemList(i).GetIpkumDivName %></font></td>
                          <td width="95" align="center" style="padding-top:3px;">
						<% if (myorder.FItemList(i).IsWebOrderReturnEnable) then %>
							<a href="order_return_detail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>&pflag=<%= pflag %>" onFocus="this.blur();">
							<span class="green11px02">WEB반품접수</span>
							</a>
						<% elseif myorder.FItemList(i).FcsReturnCnt>0 then %>
							<a href="order_cslist.asp?orderSerial=<%= myorder.FItemList(i).FOrderSerial %>" onFocus="this.blur();"><span class="link_skyblue_11px">반품신청완료</span></a>
						<% else %>
							<span class="red_11px">반품불가</span>
						<% end if %>
						  </td>
                        </tr>
                    </table></td>
                  </tr>
				<% next %>
				<% if myorder.FResultCount < 1 then %>
					<tr>
						<td align="center" style="padding-top:10px;padding-bottom:5px; border-bottom:1px solid #eaeaea;">반품 가능한 주문내역이 없습니다.</td>
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
						<!-- #include virtual ="/cscenter/help/help_order_return.asp" -->
						<!----- 도움말 끝 ----->
					</td>
				</tr>
            </table></td><!----- 반품신청 끝----->
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