<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% const MenuSelect = "01" %>
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
pflag = requestCheckvar(request("pflag"),10)
page = requestCheckvar(request("page"),9)
if (page="") then page = 1

dim userid
userid = getEncLoginUserID()

dim myorder
set myorder = new CMyOrder

myorder.FPageSize = 10
myorder.FCurrpage = page
myorder.FRectUserID = userid
myorder.FRectSiteName = "10x10"
myorder.FRectOldjumun = pflag

if IsUserLoginOK() then
    myorder.GetMyCancelOrderList
elseif IsGuestLoginOK() then
    myorder.FRectOrderserial = GetGuestLoginOrderserial()
    myorder.GetMyCancelOrderList 
end if

'네비바 내용 작성
strMidNav = "MY 쇼핑리스트 > <b>취소주문조회</b>"
%>

<script language='javascript'>
function goPage(page,pflag){
    location.href="?page=" + page + "&pflag=" + pflag;
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
            </td><!----- 주문 배송조회 시작 ----->
            <td width="780" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- My10x10 메뉴 -->
					<!-- #include virtual ="/lib/topmenu/Menu_my10x10.asp" -->
					</td>
				</tr>
              <tr>
                <td class="pdd_top_30px" style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2010/mytenbyten/title_main01_sub03.gif" alt="취소 주문 내역"></td>
              </tr>
              <tr>
                <td class="link_gray_11px_line" style="line-height:16px;padding-bottom:20px">
				    최근 6개월간 고객님의 취소된 주문내역입니다.<br>
					[주문번호] 또는 [주문상품]을 클릭하시면 주문 상세 내역을 보실 수 있습니다.
					
				 </td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="right" style="padding:0 10px 4px 0"><table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="120">
					
						</td>
                        <td style="padding-left:10px;">
							<a href="/my10x10/order/myorderlist.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/btn_ordersearch03.gif"  border="0"></a>
						</td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr bgcolor="#fcf6f6">
                          <td height="30" style="border-top:3px solid #be0808;border-bottom:1px solid #eaeaea;padding-top:3px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="100" align="center" style="padding-left:5px;">주문번호</td>
                                <td width="100" align="center">주문일자</td>
                                <td width="100" align="center">취소일</td>
                                <td align="center">상품명 </td>
                                <td width="95" align="center">총 결제 금액</td>
                                <td width="95" align="center">주문상태</td>
                              </tr>
                          </table></td>
                        </tr>
					<% for i = 0 to (myorder.FResultCount - 1) %>
                        <tr>
                          <td height="30" style="border-bottom:1px solid #eaeaea;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="100" align="center" style="padding-left:5px;"><a href="mycancelorderdetail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>&pflag=<%= pflag %>" class="link_gray_11px_line"><%= myorder.FItemList(i).FOrderSerial %></a></td>
                                <td width="100" align="center" class="link_gray_11px_line" style="padding-top:3px;line-height:17px;"><%= Left(CStr(myorder.FItemList(i).Fregdate),10) %></td>
                                <td width="100" align="center" class="link_gray_11px_line" style="padding-top:3px;line-height:17px;"><%= Left(CStr(myorder.FItemList(i).Fcanceldate),10) %></td>
                                <td style="padding:3px 0 0 5px;line-height:17px;"><a href="mycancelorderdetail.asp?idx=<%=myorder.FItemList(i).FOrderSerial%>&pflag=<%=pflag%>" class="link_gray_11px_line"><%=myorder.FItemList(i).GetItemNames%></a></td>
                                <td width="95" align="center" style="padding-top:3px;"><%=FormatNumber(myorder.FItemList(i).FSubTotalPrice,0)%>원</td>
                                <td width="95" align="center" class="red_11px" style="padding-top:3px;">
                                <% if myorder.FItemList(i).FCancelyn<>"N" then %>
                                    주문취소
                                <% else %>
                                    <%=myorder.FItemList(i).GetIpkumDivName%>
                                <% end if %>
                                </td>
                              </tr>
                          </table></td>
                        </tr>
					<% next %>
					<% if myorder.FResultCount < 1 then %>
                        <tr>
							<td align="center" style="padding-top:10px">검색된 주문내역이 없습니다.</td>
                        <tr>
					<% end if %>

						<tr>
							<td align="center" style="padding-top:10px">
								<%=fnPaging("page", myorder.FtotalCount, myorder.FcurrPage, myorder.FPageSize, 5)%>
							</td>
						</tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
				<tr>
					<td>
						<!----- 도움말 시작 ----->
						<!-- include virtual ="/cscenter/help/help_order.asp" -->
						<!----- 도움말 끝 ----->
					</td>
				</tr>
            </table></td><!----- 주문 배송조회 끝 ----->
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>

<%
set myorder = Nothing
%>
        
<!-- #include virtual="/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
