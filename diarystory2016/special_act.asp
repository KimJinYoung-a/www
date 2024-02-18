<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2016 스페셜 상품리스트
' History : 2015.10. 12 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/diarystory2016/lib/classes/diary_class_B.asp" -->
<%
	Dim cSpecial, vCurrPage, i, j, dCnt, LoginUserid

	vCurrPage = RequestCheckVar(Request("cpg"),5)
	LoginUserid = GetencLoginUserID()

	dCnt = 1

	If vCurrPage = "" Then vCurrPage = 1

	SET cSpecial = New cdiary_list
	cSpecial.FPageSize = 30
	cSpecial.Fuserid = LoginUserid
	cSpecial.FCurrpage = vCurrPage
	cSpecial.fnspecialList

	dim isMyFavItem: isMyFavItem=false
%>
<script type="text/javascript">
function fnmainbnlink(linkgubun,linkcode) {
	if(linkcode=='0'){
		return;
	}else{
		if (linkgubun=='i'){
			TnGotoProduct(linkcode);
		}else{
			parent.location.href='/event/eventmain.asp?eventid='+linkcode;
		}
	}
}
</script>
<% If (cSpecial.FResultCount > 0) Then %>
	<% If vCurrPage > 70 Then %>
		<script>$("#popspecialnodata").show();</script>
	<% Else %>
		<% For i = 0 To cSpecial.FResultCount-1 %>
		<%
			if dCnt > 5 then
				dCnt = 1
			end if
		%>
			<% if dCnt = 1 then %>
				<div class="item">
					<a href="" onclick="fnmainbnlink('<%=cSpecial.FItemList(i).Flinkgubun%>','<%=cSpecial.FItemList(i).Flinkcode%>'); return false;">
						<div class="pic">
							<img src="<%= cSpecial.FItemList(i).Fpcmainimage %>" alt="" width="360px" height="360px" />
							<div class="txtImg"><img src="<%= cSpecial.FItemList(i).Fpcoverimage %>" alt="" width="360px" height="360px" /></div>
						</div>
					</a>
				<ul>
			<% end if %>
				<% if cSpecial.FItemList(i).Fitemid <> "0" then %>
					<!-- 품절시 클래스 soldout 넣어주세요 -->
					<li <% if cSpecial.FItemList(i).IsSoldOut then %>class="soldout"<% end if %>>
						<a href="" onclick="TnGotoProduct('<%=cSpecial.FItemList(i).FItemid%>'); return false;">
							<div class="thumb">
								<img src="<%= cSpecial.FItemList(i).Fdetailitemimage %>" alt="<%= cSpecial.FItemList(i).Fitemname %>" />
								<% if cSpecial.FItemList(i).IsSoldOut then %>
									<span><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_soldout.png" alt="SOLD OUT" /></span>
								<% end if %>
							</div>
							<div class="pdtInfo">
								<p class="name"><%= cSpecial.FItemList(i).Fitemname %></p>
								<% if cSpecial.FItemList(i).IsSaleItem or cSpecial.FItemList(i).isCouponItem Then %>
									<% IF cSpecial.FItemList(i).IsSaleItem then %>
										<p class="price"><span class="finalP"><%=FormatNumber(cSpecial.FItemList(i).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=cSpecial.FItemList(i).getSalePro%>]</strong></p>
									<% End If %>
									<% IF cSpecial.FItemList(i).IsCouponItem Then %>
										<p class="price"><span class="finalP"><%=FormatNumber(cSpecial.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=cSpecial.FItemList(i).GetCouponDiscountStr%>]</strong></p>
									<% end if %>
								<% else %>
									<p class="price"><span class="finalP"><%=FormatNumber(cSpecial.FItemList(i).getRealPrice,0) & chkIIF(cSpecial.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
								<% end if %>
							</div>
						</a>
						<%
						if IsUserLoginOK then
							isMyFavItem = getIsMyFavItem(LoginUserid,cSpecial.FItemList(i).FItemid)
						end if
						%>
						<a href="" id="wsIco<%=cSpecial.FItemList(i).FItemid%>"class="btnWish <%=chkIIF(isMyFavItem,"myWishOn","")%>"><em class="wishActionV15" onclick="javascript:TnAddFavorite('<%= cSpecial.FItemList(i).FItemID %>'); return false;">위시담기</em></a>
					</li>
				<% end if %>
			<% if dCnt = 5 then %>
				</ul>
			</div>
			<% end if %>
		<%
			dCnt = dCnt + 1
		%>
		<% Next %>
	<% End If %>
<% Else %>
<script>$("#popspecialnodata").show();</script>
<%
End If
SET cSpecial = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->