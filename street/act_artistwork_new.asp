<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<%
dim  gal_div, OartGallery, Gallery_totalcnt
dim ia, olookbook_d, tmpgal_sn
	gal_div = requestcheckvar(request("gal_div"),1)

tmpgal_sn = ""
Gallery_totalcnt = 0
if gal_div="" then gal_div="W"

gal_div = ucase(gal_div)
if artistwork_yn="Y" then

'/브랜드 아티스트워크 총수량을 받아온다.
Gallery_totalcnt = GetGallery_totalcnt(makerid, "", "Y")

set OartGallery = new CGallery
	OartGallery.FRectGal_div = gal_div
	OartGallery.FRectDesignerId= makerid
	OartGallery.FPageSize = 50
	OartGallery.FCurrPage = 1
	
	if makerid<>"" then	
		OartGallery.GetGalleryDetail
	end if
	
%>
<%
'/갤러리구분중 하나라도 존재 한다면 다 뿌린다.
if Gallery_totalcnt > 0 then
%>
	<div class="wFix">
		<h4><img src="http://fiximage.10x10.co.kr/web2013/brand/tit_artistwork.gif" alt="ARTIST WORK" /></h4>
		<div class="workGallery">
			<div class="galleryTab">
				<ul>
					<% if GetGallery_totalcnt(makerid, "W", "Y") > 0 then %>
						<li gal_div='W' <% if gal_div="W" then response.write " class='current'" %>><span>WORK</span></li>
					<% end if %>
					<% if GetGallery_totalcnt(makerid, "D", "Y") > 0 then %>
						<li gal_div='D' <% if gal_div="D" then response.write " class='current'" %>><span>DRAWING</span></li>
					<% end if %>
					<% if GetGallery_totalcnt(makerid, "P", "Y") > 0 then %>
						<li gal_div='P' <% if gal_div="P" then response.write " class='current'" %>><span>PHOTO</span></li>
					<% end if %>
				</ul>
			</div>
			<% if OartGallery.fresultcount>0 then %>
			<div class="galleryArea tMar40">
				<div class="galleryView">
					<a class="arrow-left" href="#"></a>
					<a class="arrow-right" href="#"></a>
					<div class="swiper-container swiper2">
						<div class="swiper-wrapper">
							<% for ia = 0 to OartGallery.fresultcount -1 %>
							<% if tmpgal_sn="" then tmpgal_sn=OartGallery.FItemList(ia).Fgal_sn %>
								<p class="bigPic swiper-slide">
									<img src="<%= staticImgUrl %>/contents/artistGallery/<%= OartGallery.FItemList(ia).Fgal_img400 %>" alt="<%= OartGallery.FItemList(ia).Fdesignerid %> <%= Format00(2,ia+1) %>" width="400px" height="400px" />
								</p>
							<% next %>
						</div>
					</div>
				</div>
				<div class="tabs">
					<% for ia = 0 to OartGallery.fresultcount -1 %>
						<a href="#" <% if cstr(tmpgal_sn)=cstr(OartGallery.FItemList(ia).Fgal_sn) then response.write " class='active'" %>><img src="http://thumbnail.10x10.co.kr/imgstatic/contents/artistGallery/<%= OartGallery.FItemList(ia).Fgal_img400 %>?cmd=thumb&w=72&h=72&fit=true&ws=false" alt="<%= OartGallery.FItemList(ia).Fdesignerid %> <%= Format00(2,ia+1) %>" width="72px" height="72px" /></a>
					<% next %>
				</div>
			</div>
			<% end if %>
		</div>
	</div>
<% end if %>
<%
set OartGallery = nothing

end if
%>