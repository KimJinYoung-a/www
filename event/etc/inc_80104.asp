<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : After Holiday C.RE 
' History : 2017.08.23 유태욱
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
dim eCode, vUserID, nowdate, itemid, oItem

IF application("Svr_Info") = "Dev" THEN
	eCode = "66417"
Else
	eCode = "80104"
End If

nowdate = date()
'nowdate = "2017-01-01"

vUserID = getEncLoginUserID
%>
<style type="text/css">
.care {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2017/78835/bg_bar.png) repeat-x 0 0;}
.care .serise {position:relative; height:70px; text-align:left;}
.care .serise .navigator {position:absolute; top:18px; right:-14px; width:286px; height:34px;}
.care .serise .navigator iframe {width:286px; height:34px;}
.topic {position:relative; height:431px; background:#e9e1d2 url(http://webimage.10x10.co.kr/eventIMG/2017/80104/bg_topic.jpg) no-repeat 50% 0;}
.topic:after {content:''; position:absolute; left:50%; top:0; width:50%; height:100%; margin-left:950px; background:#42cfe5;}
.topic h2 {position:absolute; left:50%; top:124px; z-index:100; margin-left:-253px;}
.topic .btnEvtGo {position:absolute; left:50%; top:270px; margin-left:397px;}
.section {position:relative; width:1140px; margin:0 auto;}
.itemList {padding:100px 18px 0;}
.itemList ul {overflow:hidden; margin:0 auto; width:1104px;}
.itemList ul li {float:left; width:250px; height:695px; padding:0 13px; vertical-align:top; text-align:left;}
.itemList ul li a {display:block; width:250px;}
.itemList ul li a:hover {text-decoration:none;}
.itemList ul li h3 {padding-top:15px; font-size:15px; color:#333;}
.itemList ul li p, .itemList ul li dl dd {padding-top:5px; font-size:12px; color:#888; line-height:1.6;}
.itemList ul li dl {padding:20px 0 25px 0;}
.itemList ul li dl dt {display:inline-block; padding-top:2px; color:#333; border-top:2px solid #333; font-weight:bold;}
.itemList ul li .price {border-top:1px solid #dadada; padding-top:20px;}
.itemList ul li .price strong {color:#ec5353;}
</style>

<!-- CARE : after holiday -->
<div class="evt80104 care">
	<div class="section serise">
		<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78570/tag_tit.png" alt=";CARE - Better things for everyday task" /></span>
		<div class="navigator">
			<iframe frameborder="0" scrolling="no" src="/event/etc/group/iframe_care.asp?eventid=80104" width="350" height="70" title="CARE 시리즈" allowTransparency="true"></iframe>
		</div>
	</div>
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/tit_holiday.png" alt="AFTER HOLIDAY CARE - 휴가가 끝나면 케어가 필요해요" /></h2>
	</div>
	<div class="section itemList">
		<ul>
			<li>
				<a href="/shopping/category_prd.asp?itemid=752015&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_1.jpg" alt="" /></span>
					<h3>외장하드</h3>
					<p>1테라바이트의 저장공간을 가진 외장하드</p>
					<dl>
						<dt>추천이유</dt>
						<dd>브랜드 이름 하나로도 믿을 수 있는<br />씨게이트의 블랙 저장소. 휴가의 추억을<br />안전하게 보관합니다</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 752015
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1759294&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_2.jpg" alt="" /></span>
					<h3>비타민</h3>
					<p>수분/전해질/에너지 섭취를 위한 발포형<br />타블렛 비타민</p>
					<dl>
						<dt>추천이유</dt>
						<dd>휴가 후 지친 내 몸에 쉽고 편하게 비타민 섭취</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1759294
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1261567&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_3.jpg" alt="" /></span>
					<h3>카메라 보관용기</h3>
					<p>스테인레스로 제작되어 위생적이고 튼튼하며, 환경호르몬에도 안전한 용기</p>
					<dl>
						<dt>추천이유</dt>
						<dd>휴가 동안 열 일한 카메라 예쁘게 닦아서<br />제습제와 함께 보관하기 좋아요</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1261567
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1481888&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_4.jpg" alt="" /></span>
					<h3>카메라 청소키트</h3>
					<p>카메라 청소를 도와주는 키트</p>
					<dl>
						<dt>추천이유</dt>
						<dd>바닷가에 다녀온 소금끼 가득한 카메라 그냥 보관할 수 없죠. 깨끗이 닦아서 밀폐용기에<br />넣어주세요</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1481888
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1588853&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_5.jpg" alt="" /></span>
					<h3>부착형 앨범</h3>
					<p>정사각 사이즈의 사진을 보관할 수 있는 앨범</p>
					<dl>
						<dt>추천이유</dt>
						<dd>요즘 핫 한 느낌의 인스타그램의 사진을 보관. 휴가의 추억을 아름답게</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1588853
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1719369&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_6.jpg" alt="" /></span>
					<h3>알로에베라 젤</h3>
					<p>알로에베라 잎즙 97.7%</p>
					<dl>
						<dt>추천이유</dt>
						<dd>휴가철 태양에 지친 내 피부와 헤어를<br />촉촉하고 건강하게 보호해줍니다</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1719369
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1708956&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_7.jpg" alt="" /></span>
					<h3>중성세제</h3>
					<p>천연 식물성 원료를 사용하여 세제 찌꺼기를 99.9% 생분해 하는 세제</p>
					<dl>
						<dt>추천이유</dt>
						<dd>소금물과 수영장물에 쪄든 소중한 래쉬가드를 조물조물 빨아 관리 할 수 있는 중성세제.<br />천연에 식물성이라 아이들에게도 안심</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1708956
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=630073&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_8.jpg" alt="" /></span>
					<h3>수분크림</h3>
					<p>민감한 피부의 균형을 잡아주는 수분크림</p>
					<dl>
						<dt>추천이유</dt>
						<dd>휴가로 지친 내 얼굴에 수분과 편안함을 주기</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 630073
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1773933&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_9.jpg" alt="" /></span>
					<h3>경혈스티커</h3>
					<p>귀의 경혈자리에 붙여두면 효과가 있는<br />크리스탈 씰</p>
					<dl>
						<dt>추천이유</dt>
						<dd>귀에 붙이면 입맛이 떨어진다는 화제의 SNS 상품. 휴가철 많이 먹어 찐 살을 위한<br />극약 처방</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1773933
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1516932&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_10.jpg" alt="" /></span>
					<h3>클라우드형 외장하드</h3>
					<p>간편한 동영상재생이 가능한 클라우드 형<br />대형 외장하드</p>
					<dl>
						<dt>추천이유</dt>
						<dd>가지고 다닐 필요 없이 마이 클라우드 앱을<br />통해 손쉬운 접속. 휴가철 사진을<br />언제 어디서나 공유하기</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1516932
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1287903&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_11.jpg" alt="" /></span>
					<h3>스크랩북</h3>
					<p>여행의 기억을 자유롭게 스크랩 할 수 있는<br />레코드 북</p>
					<dl>
						<dt>추천이유</dt>
						<dd>단순한 사진 외에도 휴가에서 가져 온 추억의 자료들을 함께 넣고 기억하기 좋은 사이즈의 스크랩북</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1287903
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=770765&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_12.jpg" alt="" /></span>
					<h3>메모리포켓</h3>
					<p>사진이나 티켓 등의 지류를 보관하고<br />스크랩할 때 사용하는 OPP포켓</p>
					<dl>
						<dt>추천이유</dt>
						<dd>이 상품 외에도 사이즈나 목적별로 되어있어 추억을 보관하는 매력적인 상품</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 770765
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1766475&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_13.jpg" alt="" /></span>
					<h3>미네랄 워터</h3>
					<p>어마어마한 미네랄이 함유된 미네랄 워터</p>
					<dl>
						<dt>추천이유</dt>
						<dd>휴가 후에 지친 내 몸을 위한 건강한<br />수분 보충이 필요할 때</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1766475
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=619639&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_14.jpg" alt="" /></span>
					<h3>휴가아이템 수납</h3>
					<p>제습제 수납이 가능한 정리 보관함 셋트</p>
					<dl>
						<dt>추천이유</dt>
						<dd>휴가철 마다 찾아 다니는 튜브,수영복 등의<br />휴가 아이템을 제습과 함께 보관해주세요.<br />내년 휴가엔 이거 하나만 찾아요</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 619639
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1680434&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_15.jpg" alt="" /></span>
					<h3>트렁크 보관함</h3>
					<p>복잡한 차 트렁크를 깔끔하고 깨끗하게 하는 트렁크 정리함</p>
					<dl>
						<dt>추천이유</dt>
						<dd>차 트렁크의 톤에 맞는 디자인과 귀여운<br />스누피 포인트의 조화. 휴가 후에 복잡해진<br />차 안 정리 하세요</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1680434
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1643631&pEtr=80104">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/80104/img_thumnail_16.jpg" alt="" /></span>
					<h3>미니포켓 프린터</h3>
					<p>잉크걱정 없는 포토 전용 미니 프린터</p>
					<dl>
						<dt>추천이유</dt>
						<dd>작아도 할 껀 다 하는 다재 다능한 포토프린터. 휴가의 추억을 바로 뽑아 원하는 곳에<br />붙여주세요</dd>
					</dl>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1643631
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
				</a>
			</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->