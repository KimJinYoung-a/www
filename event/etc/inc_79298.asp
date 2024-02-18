<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 바디케어 이벤트
' History : 2017.07.17 원승현
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
	eCode = "66396"
Else
	eCode = "79298"
End If

nowdate = date()
'nowdate = "2017-01-01"

vUserID = getEncLoginUserID
%>
<style>
.evt79298 {background-color:#f8f8f8;}
.evtTit {position:relative; padding-top:120px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79298/bg_topic.png) no-repeat 50% 0; text-align:center;}
.evtTit .goToEvt {position:absolute; right:0; top:24px;}
.evtTit .movie {margin-top:66px;}
.evtTit .movie iframe {vertical-align:top; box-shadow:0 15px 35px rgba(0,0,0,.1);}
.evtTit p {margin-top:70px;}
.itemList ul {overflow:hidden; width:953px; margin:0 auto; padding:77px 0 40px;}
.itemList li {height:413px; margin-bottom:20px; text-align:left; border:1px solid #eee; background-color:#fff; background-repeat:no-repeat;}
.itemList li.item1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79298/img_item_1.jpg);}
.itemList li.item2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79298/img_item_2.jpg);}
.itemList li.item3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79298/img_item_3.jpg);}
.itemList li.item4 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79298/img_item_4.jpg);}
.itemList li.item5 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79298/img_item_5.jpg);}
.itemList li.typeA {background-position:0 50%;}
.itemList li.typeB {background-position:100% 50%;}
.itemList li a {display:block; height:413px;}
.itemList li.typeA a {padding-left:550px;}
.itemList li.typeB a {padding-left:84px;}
.itemList li a:hover {text-decoration:none;}
.itemList li h3 {padding:60px 0 17px; color:#333; font-size:15px; line-height:1; font-weight:bold;}
.itemList li .price {padding-bottom:15px; color:#888;}
.itemList li .price strong {color:#ff681e; padding-right:8px;}
.itemList li .price del {color:#9c9c9c; font-weight:bold;}
.itemList li .itemInfo p {overflow:hidden; color:#888;}
.itemList li .itemInfo p span {float:left; width:220px;}
.itemList li .itemInfo p span:first-child {width:150px;}
.itemList li dl {padding:18px 0 25px;}
.itemList li dt {position:relative; display:inline-block; padding:7px 0 10px; color:#333; line-height:1; font-weight:bold;}
.itemList li dt:after {content:''; position:absolute; left:0; top:0; width:100%; height:2px; background-color:#333;}
.itemList li dd {color:#888;}
</style>

<%' Tasting STORE %>
<div class="evt79298 care">
	<div class="evtTit">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/79298/tit_diet_food.png" alt="[Tasting Store] Diet Food - 당신이 먹어보기 전, 텐바이텐이 먼저 테스트 해드립니다." /></h2>
		<div class="movie">
			<iframe width="700" height="420" src="https://www.youtube.com/embed/rA2x52R4xIg" frameborder="0" allowfullscreen></iframe>
		</div>
		<span class="goToEvt"><a href="/event/eventmain.asp?eventid=79187"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79298/bnr_go_body.png" alt="[COOLING CARE] 관련 이벤트로 바로가기" /></a></span>
		<p class="tPad70"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79298/txt_better.png" alt="Better things for Everyday life - '케어' 속의 리뷰 코너! 당신의 바디 관리를 돕습니다" /></p>
	</div>
	<%' 상품 리스트 %>
	<div class="itemList">
		<ul>
			<li class="item1 typeA">
				<a href="/shopping/category_prd.asp?itemid=1678326&pEtr=79298">
					<h3>더슬림 도시락</h3>
					<%' for dev msg : 실시간 가격노출 유지(이하 상품 동일) %>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1678326
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/8)), 0) %>원 할인시 약<%= formatnumber( CLng((oItem.Prd.FSellCash/8)), 0) %>원)</div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/8)),0) %>원)</div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>칼로리 : 346kcal</span>
							<span>중량 : 202g</span>
						</p>
						<p>
							<span>식품군 : 도시락</span>
							<span>구성 : 제육볶음, 브로콜리,나물밥</span>
						</p>
						<p>포만감 : ★★★★</p>
						<p>맛 : 고기가 크지않고 짜잘해서 먹기 편했다<br />나물밥이 요물.동봉된 고추장에 비벼먹으면 세상꿀맛</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>풍부한 리뷰와 다양한 메뉴로 다이어터들의<br />입맛을 사로잡은 맛좋은 다이어트 도시락</dd>
					</dl>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79298/btn_buy.png" alt="구매하러가기" /></span>
				</a>
			</li>
			<li class="item2 typeB">
				<a href="/shopping/category_prd.asp?itemid=1659068&pEtr=79298">
					<h3>슈퍼스무디 시크릿블랙(14개입)</h3>
					<%' for dev msg : 실시간 가격노출 유지(이하 상품 동일) %>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1659068
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/14)), 0) %>원 할인시 약<%= formatnumber( CLng((oItem.Prd.FSellCash/14)), 0) %>원)</div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/14)),0) %>원)</div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>칼로리 : 100kcal</span>
							<span>중량 : 개당 30g</span>
						</p>
						<p>
							<span>식품군 : 가루형 쉐이크</span>
							<span>구성 : 슈퍼스무디 14개</span>
						</p>
						<p>포만감 : ★★★</p>
						<p>맛 : 고소하고 묵직한 스무디 식감<br />다 먹을 즈음 톡톡튀는 바질씨가 나를 위로해주는 느낌</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>다른 다이어트 대용식보다 간편하고 의외의 포만감이 상당해서<br />아침 저녁으로 먹기 좋은 다이어트 식품!</dd>
					</dl>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79298/btn_buy.png" alt="구매하러가기" /></span>
				</a>
			</li>
			<li class="item3 typeA">
				<a href="/shopping/category_prd.asp?itemid=1507511&pEtr=79298">
					<h3>딜리핏 3종 도시락 시즌2 - 12팩</h3>
					<%' for dev msg : 실시간 가격노출 유지(이하 상품 동일) %>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1507511
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/12)), 0) %>원 할인시 약<%= formatnumber( CLng((oItem.Prd.FSellCash/12)), 0) %>원)</div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/12)),0) %>원)</div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>칼로리 : 365kcal</span>
							<span>중량 : 210g</span>
						</p>
						<p>
							<span>식품군 : 도시락</span>
							<span>구성 : 현미밥,미니스테이크,계란후라이</span>
						</p>
						<p>포만감 : ★★★</p>
						<p>맛 : 비법 간장소스에 비벼먹는 나물밥에<br />다이어트라고 생각되지않는 함박스테이크가 의외로 맛있다</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>딜리핏의 새로운 3종메뉴로<br />함박스테이크의 합류로 더욱 업그레이드 했다.</dd>
					</dl>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79298/btn_buy.png" alt="구매하러가기" /></span>
				</a>
			</li>
			<li class="item4 typeB">
				<a href="/shopping/category_prd.asp?itemid=1724772&pEtr=79298">
					<h3>이너워터팩 잘빠진그대 20 DAYS 패키지</h3>
					<%' for dev msg : 실시간 가격노출 유지(이하 상품 동일) %>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1724772
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/20)), 0) %>원 할인시 약<%= formatnumber( CLng((oItem.Prd.FSellCash/20)), 0) %>원)</div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/20)),0) %>원)</div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>칼로리 : 0kcal</span>
							<span>중량 : 개당 4.5g</span>
						</p>
						<p>
							<span>식품군 : 건조식품</span>
							<span>구성 : 이너워터팩 20개</span>
						</p>
						<p>포만감 : ★</p>
						<p>맛 : 예쁜 빨간색 물이 보는맛을 주고<br />고소한 곡물차 맛이 무한 드링킹을 부른다.</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>다이어트에 빠질 수 없는 물<br />맛있으면 0칼로리를 실현시킨 이너워터팩 고소한 차를 물처럼 마실 수 있다</dd>
					</dl>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79298/btn_buy.png" alt="구매하러가기" /></span>
				</a>
			</li>
			<li class="item5 typeA">
				<a href="/shopping/category_prd.asp?itemid=1184962&pEtr=79298">
					<h3>파워닭 치킨브레스트 바질맛</h3>
					<%' for dev msg : 실시간 가격노출 유지(이하 상품 동일) %>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1184962
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/8)), 0) %>원 할인시 약<%= formatnumber( CLng((oItem.Prd.FSellCash/8)), 0) %>원)</div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong> (개당 약<%= formatnumber(CLng((oItem.Prd.FOrgPrice/8)),0) %>원)</div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>칼로리 : 137kcal</span>
							<span>중량 : 개당 약110g</span>
						</p>
						<p>
							<span>식품군 : 닭가슴살</span>
							<span>구성 : 8~10개</span>
						</p>
						<p>포만감 : ★★</p>
						<p>맛 : 마늘향과 양파향 바질향과 닭가슴살이 잘어우러진다.<br />싱겁지만 괜찮다. 구워 먹는걸 추천!</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>닭가슴살을 보다 향긋하게 즐길 수 있다.<br />바질이 들어있어 다른요리에 쉽게 응용해도 음식이 살아난다.</dd>
					</dl>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79298/btn_buy.png" alt="구매하러가기" /></span>
				</a>
			</li>
		</ul>
	</div>
</div>
<!--// Tasting STORE -->

<!-- #include virtual="/lib/db/dbclose.asp" -->