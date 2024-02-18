<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/classes/street/BrandStreetCls.asp" -->

<%
dim lookbook_yn, makerid, lookbookidx, detailidx
dim olookbook_m, il, olookbook_d
	lookbook_yn = requestcheckvar(request("lookbook_yn"),1)
	makerid = requestcheckvar(request("makerid"),32)
	lookbookidx = getNumeric(requestcheckvar(request("lookbookidx"),10))
	detailidx = getNumeric(requestcheckvar(request("detailidx"),10))

if lookbook_yn="Y" then

set olookbook_m = new clookbook
	olookbook_m.frectmakerid = makerid
	olookbook_m.frectisusing = "Y"
	olookbook_m.frectidx=""
	olookbook_m.Frectstate="7"
	olookbook_m.FPageSize = 50
	olookbook_m.FCurrPage = 1
	
	if makerid<>"" then
		olookbook_m.getlookbook_master
	end if
%>

<% if olookbook_m.fresultcount>0 then %>
	
	<%
	if lookbookidx="" then lookbookidx=olookbook_m.FItemList(0).Fidx

	set olookbook_d = new clookbook
		olookbook_d.frectisusing = "Y"
		olookbook_d.frectidx=lookbookidx
		olookbook_d.FrectdetailIdx = detailIdx
		
		if lookbookidx<>"" then
			olookbook_d.getlookbook_detail_one
		end if
	%>
	<div class="wFix">
		<h4 class="line"><img src="http://fiximage.10x10.co.kr/web2013/brand/tit_lookbook.gif" alt="LOOKBOOK" /></h4>
		<div class="nav">
			<% for il = 0 to olookbook_m.fresultcount -1 %>
				<a href="" onclick="golookbookView('/street/act_lookbook.asp?makerid=<%=makerid%>&lookbook_yn=<%=lookbook_yn%>&lookbookidx=<%=olookbook_m.FItemList(il).Fidx%>'); return false;" <% if cstr(lookbookidx)=cstr(olookbook_m.FItemList(il).Fidx) then response.write " class='on'" %>>
				<%= olookbook_m.FItemList(il).Ftitle %>
				<% if datediff("d", left(olookbook_m.FItemList(il).Fregdate,10) , date) < 14 then response.write " <img src='http://fiximage.10x10.co.kr/web2013/brand/ico_new.gif' alt='NEW' />" %>
				</a>
			<% next %>
		</div>

		<% if olookbook_d.FTotalCount>0 then %>
			<div class="photoList">
				<% if olookbook_d.FOneItem.fpreidx<>"" and not(isnull(olookbook_d.FOneItem.fpreidx)) then %>
					<a class="arrow-left" href="" onclick="golookbookView('/street/act_lookbook.asp?makerid=<%=makerid%>&lookbook_yn=<%=lookbook_yn%>&lookbookidx=<%=lookbookidx%>&detailidx=<%=olookbook_d.FOneItem.fpreidx%>'); return false;"></a>
				<% end if %>
	
				<% if olookbook_d.FOneItem.fnextidx<>"" and not(isnull(olookbook_d.FOneItem.fnextidx)) then %>
					<a class="arrow-right" href="" onclick="golookbookView('/street/act_lookbook.asp?makerid=<%=makerid%>&lookbook_yn=<%=lookbook_yn%>&lookbookidx=<%=lookbookidx%>&detailidx=<%= olookbook_d.FOneItem.fnextidx %>'); return false;"></a>
				<% end if %>
				
				<div class="swiper-container swiper3">
					<div class="swiper-wrapper">
						<!--<div class="swiper-slide" id="a<%'= Format00(2,il+1) %>"><img src="http://thumbnail.10x10.co.kr/imgstatic/brandstreet/lookbook/detail/<%'= olookbook_d.FOneItem.flookbookimg %>?cmd=thumbnail&width=1024&noenlarge=true" alt="LookBook Detail <%'= Format00(2,il+1) %>" /></div>-->
						<div class="swiper-slide" id="a<%= Format00(2,il+1) %>"><img src="<%=staticImgUrl%>/brandstreet/lookbook/detail/<%= olookbook_d.FOneItem.flookbookimg %>" alt="LookBook Detail <%= Format00(2,il+1) %>" /></div>
					</div>
				</div>
			</div>
		<% end if %>
	</div>
<% end if %>

<%
set olookbook_m = nothing

end if
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->