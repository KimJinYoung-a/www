<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<%

dim i,lp


dim userid
userid = getEncLoginUserID


dim CsAsID
CsAsID = request("CsAsID")
    
dim mycsdetail
set mycsdetail = new CCSASList
mycsdetail.FRectUserID = userid
mycsdetail.FRectCsAsID = CsAsID

if (CsAsID<>"") then
    mycsdetail.GetOneCSASMaster
end if


dim mycsdetailitem
set mycsdetailitem = new CCSASList
mycsdetailitem.FRectUserID = userid
mycsdetailitem.FRectCsAsID = CsAsID
if (CsAsID<>"") then
	mycsdetailitem.GetCsDetailList
end if

%>


<% if (mycsdetail.FResultCount>0) then %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-bottom:7px;"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main06_10.gif" width="199" height="17"></td>
	</tr>
	<tr>
	<td style="padding:10px 20px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td width="10"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/bullet_grey.gif" width="4" height="5" style="margin-bottom:3px;"></td>
		  <td height="24" width="80">서비스코드</td>
		  <td><%= mycsdetail.FOneItem.Fid %></td>
		</tr>
		<tr>
		  <td><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/bullet_grey.gif" width="4" height="5" style="margin-bottom:3px;"></td>
		  <td height="24">주문번호</td>
		  <td><%= mycsdetail.FOneItem.Forderserial %></td>
		</tr>
		<tr>
		  <td><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/bullet_grey.gif" width="4" height="5" style="margin-bottom:3px;"></td>
		  <td height="24">접수내용</td>
		  <td><%= nl2br(mycsdetail.FOneItem.Fopentitle) %></font>&nbsp;&nbsp;(접수사유 : <%= mycsdetail.FOneItem.Fgubun01Name %>><%= mycsdetail.FOneItem.Fgubun02Name %>)</td>
		</tr>

	<% if mycsdetailitem.FResultCount>0 then %>
		<tr>
		  <td style="padding:10px 0;" valign="top"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/bullet_grey.gif" width="4" height="5"></td>
		  <td style="padding:7px 0;" valign="top">접수상품</td>
		  <td style="padding:7px 0;" valign="top"><!--접수상품 리스트 시작--><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-top:solid 1px #eaeaea;">
		  <tr><td height="20" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-top:3px;">
				<tr align="center">
				<td width="60">상품</td>
				  <td width="80">상품번호</td>
				  <td>상품명</td>
				  <td width="100">판매가</td>
				  <td width="40">수량</td>
				</tr>
			  </table></td></tr>
		<% for i=0 to mycsdetailitem.FResultCount-1 %>
			<tr>
			  <td style="border-bottom:solid 1px #eaeaea; padding:6px 0 3px 0;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-top:3px;">
				<tr align="center">
				<td width="60" style="padding:0;">
				<%If mycsdetailitem.FItemList(i).Fitemid <> 0 Then %>
					<a href="javascript:ZoomItemPop(<%= mycsdetailitem.FItemList(i).FItemid %>,'new');" onFocus="blur()"><img src="<%= mycsdetailitem.FItemList(i).FSmallImage %>" width="50" height="50"></a>
				<%End If %>
				</td>
				  <td width="80"><%= mycsdetailitem.FItemList(i).Fitemid %></td>
				  <td align="left" style="padding-left:5px;"><%= mycsdetailitem.FItemList(i).Fitemname %>
				  <% if (mycsdetailitem.FItemList(i).Fitemoptionname<>"") then %>
				  [<%= mycsdetailitem.FItemList(i).Fitemoptionname %>]
				  <% end if %>
				  </td>
				  <td width="100">
				  <% if (mycsdetailitem.FItemList(i).Fitemcost<>0) then %>
				  <%= FormatNumber(mycsdetailitem.FItemList(i).Fitemcost,0) %>원
				  <% end if %>
				  </td>
				  <td width="40"><%= mycsdetailitem.FItemList(i).Fregitemno %></td>
				</tr>
			  </table></td>
			</tr>
		<% next %>
	
		  </table><!--접수상품 리스트 끝--></td>
		</tr>
	<% end if %>
		<tr valign="top">
		  <td><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/bullet_grey.gif" width="4" height="5" style="margin-bottom:3px;"></td>
		  <td height="24">처리내용</td>
		  <td><%= nl2br(mycsdetail.FOneItem.Fopencontents) %></td>
		</tr>
		<tr>
		  <td><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/bullet_grey.gif" width="4" height="5" style="margin-bottom:3px;"></td>
		  <td height="24">처리일시</td>
		  <td><font class="red_11px"><%= mycsdetail.FOneItem.Ffinishdate %></font></td>
		</tr>
	<% if (mycsdetail.FOneItem.Fdivcd = "A000") or (mycsdetail.FOneItem.Fdivcd = "A001") or (mycsdetail.FOneItem.Fdivcd = "A002") or (mycsdetail.FOneItem.Fdivcd = "A004") or (mycsdetail.FOneItem.Fdivcd ="A010") or (mycsdetail.FOneItem.Fdivcd ="A011") then %>
		<tr>
		  <td><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/bullet_grey.gif" width="4" height="5" style="margin-bottom:3px;"></td>
		  <td height="24">운송장번호</td>
		  <td>
				<% 
				dim idlvName, idlvLinkUrl, idlvPhone
				if (Not IsNULL(mycsdetail.FOneItem.Fsongjangdiv)) and (mycsdetail.FOneItem.Fsongjangdiv<>"") then
					Call GetOneDeliveryInfo(mycsdetail.FOneItem.Fsongjangdiv,mycsdetail.FOneItem.Fsongjangno, idlvName,idlvLinkUrl, idlvPhone)
				end if
				%>
				<% if mycsdetail.FOneItem.Fsongjangno<>"" then %>
					<a href="<%= idlvLinkUrl %>" target="_blank"><font color="#000000"><%= idlvName %>&nbsp;&nbsp<%= mycsdetail.FOneItem.Fsongjangno %></font></a>
					&nbsp;&nbsp;
					<font color="#000000">[ ☏ <%= idlvPhone %> ]</font>
					<br>*운송장번호를 클릭하시면 택배추적이 가능합니다.
				<% else %>
					<% if mycsdetail.FOneItem.Fdivcd = "A004" then %>
					<a href="javascript:popSongjang('<%= CsAsID %>');" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/btn_returninfo.gif" width="85" height="21" vspace="7" border="0" /></a>
					<% else %>
					택배정보가 등록되지 않았습니다.
					<% end if %>
				<% end if %>
		  </td>
		</tr>
	<% end if %>
	<% if mycsdetail.FOneItem.Frefundrequire > 0 then %>
		<tr>
		  <td><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/bullet_grey.gif" width="4" height="5" style="margin-bottom:3px;"></td>
		  <td height="24">환불예정액</td>
		  <td>
			<strong><%= FormatNumber(mycsdetail.FOneItem.Frefundrequire,0) %>원</strong>
		  </td>
		</tr>
	<% end if %>
	</table></td>
	</tr>
</table>
<% end if %>


<%
set mycsdetail = Nothing
set mycsdetailitem = Nothing
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->