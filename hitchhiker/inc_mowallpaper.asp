<%
'#############################################################
'	Description : HITCHHIKER
'	History		: 2014.08.08 유태욱 생성
'#############################################################
dim j
	page = request("page")
	
if page="" then page=1

dim owallpaper
set owallpaper = new CHitchhikerlist
	owallpaper.Fgubun = 2
	owallpaper.FPageSize = 2
	owallpaper.FCurrPage = page
	owallpaper.Frectisusing = "Y"
	owallpaper.fnGetwallpaper

%>
<% if owallpaper.fresultcount > 0 then %>
	<h3><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_mobile_wallpaper.gif" alt="MOBILE WALLPAPER" /></h3>
	<div class="downMobileWrap">
	<% ' for dev msg : downMobile로 반복 %>
		<div class="downMobile">
			<% for i = 0 to owallpaper.fresultcount-1 %>
				<%
				dim olink
				set	olink = new CHitchhikerlist
					olink.Frectcontentsidx = owallpaper.FItemList(i).Fcontentsidx
					olink.Frectisusing="Y"
					olink.Fgubun = "2"
					olink.fnGetContents_link
				%>
				<div class="down">
					<p class="figure"><img src="<%=owallpaper.FItemList(i).FReqcon_viewthumbimg%>" width="194" height="300" alt="IT&apos;S HALF TIME" /></p>
					<ul>
						<% if olink.fresultcount > 0 then %>
							<% for j = 0 to olink.fresultcount-1 %>
								<% if len(trim(olink.FItemList(j).FContentslink)) > 4 then %>
									<li><a href="<%= trim(olink.FItemList(j).FContentslink) %>"><strong><%= olink.FItemList(j).FContentsSize %></strong> <span><%=olink.FItemList(j).FDevicename%></span></a></li>
								<% else %>
									<li><a href="javascript:fileDownload('<%= trim(olink.FItemList(j).FContentslink) %>');"><strong><%= olink.FItemList(j).FContentsSize %></strong> <span><%=olink.FItemList(j).FDevicename%></span></a></li>
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
				<button type="button" onclick="mowallpaper('<%= owallpaper.FCurrPage-1 %>')" class="btnPrev">이전 월페이퍼 보기</button>
			<% else %>
				<button type="button" onclick="alert('이전페이지가 없습니다.');" class="btnPrev">이전 월페이퍼 보기</button>
			<% end if %>
			
			<% if cint(owallpaper.FCurrPage) < cint(owallpaper.FtotalPage) then %>
				<button type="button" onclick="mowallpaper('<%= owallpaper.FCurrPage+1 %>')" class="btnNext">다음 월페이퍼 보기</button>
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