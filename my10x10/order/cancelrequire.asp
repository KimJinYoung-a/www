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
dim page
page = requestCheckVar(request("page"),9)
if (page="") then page = 1

dim userid, orderserial
userid = getEncLoginUserID()

dim ocslist
set ocslist = new CCSASList
ocslist.FPageSize = 5
ocslist.FCurrpage = page

if IsUserLoginOK() then
    ocslist.FRectUserID = getEncLoginUserID()
    ocslist.GetCSASCancelRequireList
elseif IsGuestLoginOK() then
    orderserial = GetGuestLoginOrderserial()
    ocslist.FRectOrderserial = orderserial
    ocslist.GetCSASCancelRequireList
end if


'네비바 내용 작성
strMidNav = "MY 쇼핑리스트 > 주문취소 > <b>품절취소상품 환불신청</b>"
%>



<script language='javascript'>
function goPage(page){
    location.href="?page=" + page ;
}


function popCancelRequire(iid){
    var popwin = window.open('/my10x10/orderPopup/popCancelRequire.asp?id=' + iid,'popCancelRequire','width=800,height=800,scrollbars=yes,resizable=yes');
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
            </td><!----- 주문취소 품절취소상품 환불신청 시작 ----->
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
                      <td style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2010/mytenbyten/title_main03_sub.gif"></td>
                    </tr>
                    <tr>
                      <td style="padding-bottom:20px;line-height:16px"><span class="red_11px">상품품절로 인해 주문하신 상품을 발송해 드리지 못할 경우고객님께 별도의 안내전화를 드립니다.</span><br>
                        고객님과 통화연결이 안될경우, SMS와 이메일로 품절취소 및 환불 안내를 보내드리며, 품절 쉬소 상품을 알려드리오니 취소확인 및 환불정보를 <br>입력해주시면, 
                        바로 환불처리해 드리도록 하겠습니다. 상품품절로 인해 주문하신 상품을 발송해드리지 못한 점 사과의 말씀드립니다.</td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <!----- 주문리스트 시작 ----->
                <td style="padding:0 0 25px 0"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr bgcolor="#fcf6f6">
                    <td height="30" style="border-top:3px solid #be0808;border-bottom:1px solid #eaeaea;padding-top:3px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="120" align="center" style="padding-left:5px;">주문번호</td>
                          <td width="110" align="center">접수일</td>
                          <td align="center">주문취소상품</td>
                          <td width="95" align="center">취소 금액</td>
                          <td width="105" align="center">취소 사유</td>
                        </tr>
                    </table></td>
                  </tr>
                  <% for i=0 to ocslist.FResultCount -1 %>
                  <tr>
                    <td height="30" style="border-bottom:1px solid #eaeaea;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="120" align="center" style="padding-left:5px;"><a href="javascript:popCancelRequire('<%= ocslist.FItemList(i).Fid %>');" class="link_gray_11px_line"><%= ocslist.FItemList(i).Forderserial %></a></td>
                          <td width="110" align="center" class="link_gray_11px_line" style="padding-top:3px;line-height:17px;"><%= Left(CStr(ocslist.FItemList(i).Fregdate),10) %></td>
                          <td style="padding:3px 0 0 5px;line-height:17px;"><a href="javascript:popCancelRequire('<%= ocslist.FItemList(i).Fid %>');" class="link_gray_11px_line"><%= ocslist.FItemList(i).FMitemname %></a></td>
                          <td width="95" align="center" style="padding-top:3px;"><%= FormatNumber(ocslist.FItemList(i).FrefundRequire,0) %>원</td>
                          <td width="105" align="center" style="padding-top:3px;">
                          <% if (FALSE) then %>
                          
                          <% else %>
                            <a href="javascript:popCancelRequire('<%= ocslist.FItemList(i).Fid %>');" class="link_red11px01"><%= ocslist.FItemList(i).Fgubun02Name %></a>
                          <% end if %>
                          </td>
                        </tr>
                    </table></td>
                  </tr>
                  <% next %>
                  
                  <% if ocslist.FResultCount < 1 then %>
					<tr>
						<td align="center" style="padding-top:10px">취소 요청 주문내역이 없습니다.</td>
					<tr>
				  <% end if %>

					<tr>
						<td align="center" style="padding-top:10px">
							<%=fnPaging("page", ocslist.FtotalCount, ocslist.FcurrPage, ocslist.FPageSize, 5)%>
						</td>
					</tr>

                </table></td>
           		 <!----- 주문리스트 끝 ----->
              </tr>
			  <tr>
				<td>
					<!----- 도움말 시작 ----->
					<!-- #include virtual ="/cscenter/help/help_order_cancelrequire.asp" -->
					<!----- 도움말 끝 ----->
				</td>
			  </tr>
            </table></td><!----- 주문취소 품절취소상품 환불신청 끝----->
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>



<%
set ocslist = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/tailer.asp" -->