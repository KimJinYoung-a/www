<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/hitchhiker/hitchhikerCls.asp"-->

<%
'#############################################################
'	Description : HITCHHIKER
'	History		: 2014.08.08 유태욱 생성
'#############################################################
Dim i, j, page
	page = request("page")
	
if page="" then page=1

dim owallpaper
set owallpaper = new CHitchhikerlist
	owallpaper.Fgubun = 1
	owallpaper.FPageSize = 3
	owallpaper.FCurrPage = page
	owallpaper.Frectisusing = "Y"
	owallpaper.fnGetwallpaper
%>
<% if owallpaper.fresultcount > 0 then %>
	<h3><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_pc_wallpaper.gif" alt="PC WALLPAPER" /></h3>
	<!-- for dev msg : 썸네일이 왼쪽 정렬일 경우 클래스명 flowRight / 오른쪽 정렬일 경우 flowLeft이 붙여주세요. -->
	<div class="downPcWrap">
	<!-- for dev msg : downPc로 반복 -->
		<div class="downPc">
			<% for i = 0 to owallpaper.fresultcount-1 %>
				<%
				dim olink
				set	olink = new CHitchhikerlist
					olink.Frectcontentsidx = owallpaper.FItemList(i).Fcontentsidx
					olink.Frectisusing="Y"
					olink.Fgubun = "1"
					olink.fnGetContents_link
				%>
				<div class="down <%=CHKIIF((i mod 2)=0,"flowLeft","flowRight")%>">
					<p class="figure"><img src="<%= owallpaper.FItemList(i).FReqcon_viewthumbimg %>" width="300" height="170" alt="미래에 대해 걱정하는건 풍선껌을 씹어서 방정식을 풀겠다는 것만큼이나 소용없는 짓이라고 했다." /></p>
					<ul>
						<% if olink.fresultcount > 0 then %>
						<% for j = 0 to olink.FResultCount-1 %>
							<% if len(trim(olink.FItemList(j).FContentslink)) > 4 then %>
								<li><a href="<%= trim(olink.FItemList(j).FContentslink) %>"><strong><%= olink.FItemList(j).FContentsSize %></strong></a></li>
							<% else %>
								<li><a href="javascript:fileDownload('<%= trim(olink.FItemList(j).FContentslink) %>');"><strong><%= olink.FItemList(j).FContentsSize %></strong></a></li>
							<% end if %>
						<% next %>
						<% end if %>
					</ul>
				</div>
			<% next %>
		</div>
		
		<div class="counting">
			<span><strong class="on"><%= owallpaper.FCurrPage %></strong> / <%= owallpaper.FtotalPage %></span>
			<% if owallpaper.FCurrPage > 1 then %>
				<button type="button" onclick="pcwallpaper('<%= owallpaper.FCurrPage-1 %>')" class="btnPrev">이전 월페이퍼 보기</button>
			<% else %>
				<button type="button" onclick="alert('이전페이지가 없습니다.');" class="btnPrev">이전 월페이퍼 보기</button>
			<% end if %>
			<% if cint(owallpaper.FCurrPage) < cint(owallpaper.FtotalPage) then %>
				<button type="button" onclick="pcwallpaper('<%= owallpaper.FCurrPage+1 %>')" class="btnNext">다음 월페이퍼 보기</button>
			<% else %>
				<button type="button" onclick="alert('다음페이지가 없습니다.');" class="btnNext">다음 월페이퍼 보기</button>
			<% end if %>
		</div>
	</div>
<% end if %>

<%
set owallpaper = nothing
set olink = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->