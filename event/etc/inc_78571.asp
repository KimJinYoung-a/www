<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 쿨링케어서브(테이스팅 스토어) 이벤트
' History : 2017.06.23 원승현
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
	eCode = "66346"
Else
	eCode = "78571"
End If

nowdate = date()
'nowdate = "2017-01-01"

vUserID = getEncLoginUserID
%>
<style>
.evt78571 {background-color:#f8f8f8;}
.evtTit {position:relative; padding-top:120px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78571/bg_fan.jpg) no-repeat 50% 0; text-align:center;}
.evtTit .goToEvt {position:absolute; right:0; top:24px;}
.evtTit .movie {margin-top:66px;}
.evtTit p {margin-top:70px;}

.section {position:relative; width:1140px; margin:0 auto;}
.itemList ul {overflow:hidden; width:1020px; margin:0 auto; padding-top:82px;}
.itemList ul li {float:left; width:300px; height:630px; padding:0 20px; vertical-align:top; text-align:left;}
.itemList ul li a {display:block; width:300px;}
.itemList ul li a:hover {text-decoration:none;}
.itemList ul li h3 {padding-top:20px; padding-left:10px; font-size:15px; color:#333;}
.itemList ul li p, .itemList ul li dl dd {padding-top:5px; font-size:12px; color:#888; line-height:1.6;}
.itemList ul li dl {padding:22px 0 0 10px;}
.itemList ul li dl dt {display:inline-block; padding-top:2px; color:#333; border-top:2px solid #333; font-weight:bold;}
.itemList ul li .price {padding-top:10px; padding-left:10px; color:#9c9c9c; font-weight:600;}
.itemList ul li .price strong {color:#ff681e;}
.itemList ul li .itemInfo  {display:table; margin-top:10px; padding-left:10px;}
.itemList ul li .itemInfo p {display:table-row;}
.itemList ul li .itemInfo span {display:table-cell;}
.itemList ul li .itemInfo span:first-child {width:165px;}
</style>


<div class="evt78571 care">
	<div class="evtTit">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/78571/tit_v2.png" alt="[Tasting Store] Handy Fan - 당신의 취향, 우리의 테스트! 대신 테스트 해드립니다." /></h2>
		<div class="movie">
			<iframe width="700" height="420" src="https://www.youtube.com/embed/1j2DwX1OoIY?rel=0" frameborder="0" allowfullscreen></iframe>
		</div>
		<span class="goToEvt"><a href="/event/eventmain.asp?eventid=78570"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78571/img_bnr.png" alt="[COOLING CARE] 관련 이벤트로 바로가기" /></a></span>
		<p class="tPad70"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78571/img_txt.png" alt="Better things for Everyday task - '케어' 속의 리뷰 코너! 당신의 일상 테스크 관리를 돕습니다" /></p>
	</div>

	<div class="section itemList">
		<ul>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1719612&pEtr=78571">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78571/img_item1.jpg" alt="엘레컴 휴대용 선풍기" /></span>
					<h3>엘레컴 휴대용 선풍기</h3>
					<%' for dev msg : 실시간 가격노출 유지(기획서변경/이하 상품 동일) %>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1719612
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>크기(cm) : 11.2 x 20 x 4</span>
							<span>풍량 : 7.6m/s(2cm)</span>
						</p>
						<p>
							<span>배터리용량 : 2600mA</span>
							<span>데시벨 : 56dB</span>
						</p>
						<p>
							<span>무게 : 158g</span>
						</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>탁상용으로도 사용가능한 크래들, <br />귀여운 얼굴이지만 강력한 풍량</dd>
					</dl>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1685329&pEtr=78571">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78571/img_item2.jpg" alt="오난 코리아 핸디 선풍기" /></span>
					<h3>오난 코리아 핸디 선풍기</h3>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1685329
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>크기(cm) : 10.5 x 20.7 x 4.2</span>
							<span>풍량 : 7.6m/s(2cm)</span>
						</p>
						<p>
							<span>배터리용량 : 2500mA</span>
							<span>데시벨 : 62dB</span>
						</p>
						<p>
							<span>무게 : 165g</span>
						</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>스마트해보이는 바디와 <br />데스크에 잘어울리는 크래들로 <br />편리성과 디자인 두마리 토끼를 잡았다.</dd>
					</dl>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1700667&pEtr=78571">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78571/img_item3.jpg" alt="엠아이 핸디팬" /></span>
					<h3>엠아이 핸디팬</h3>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1700667
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>크기(cm) : 9.2 x 18.8 x 3.5</span>
							<span>풍량 : 3.7m/s(5cm)</span>
						</p>
						<p>
							<span>배터리용량 : 2000mA</span>
							<span>데시벨 : 57dB</span>
						</p>
						<p>
							<span>무게 : 140g</span>
						</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>깔끔한 디자인에 자그마한 크기로 휴대성 강조, <br />특허받은 그릴로 일직선 바람 기능</dd>
					</dl>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1510635&pEtr=78571">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78571/img_item4.jpg" alt="쿠마/우사미 usb 핸디형 선풍기" /></span>
					<h3>쿠마/우사미 usb 핸디형 선풍기</h3>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1510635
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>크기(cm) : 9 x 19 x 3.5</span>
							<span>풍량 : 4.5m/s(2cm)</span>
						</p>
						<p>
							<span>배터리용량 : 2000mA</span>
							<span>데시벨 : 50dB</span>
						</p>
						<p>
							<span>무게 : 137g</span>
						</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>귀여운 곰모양으로 심장어택. <br />작은 크기지만 풍량이 세고, 소음이 적다.</dd>
					</dl>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1695168&pEtr=78571">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78571/img_item5.jpg" alt="프롬비 핸디 토네이도 선풍기 알레스카" /></span>
					<h3>프롬비 핸디 토네이도 선풍기 알레스카</h3>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1695168
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>크기(cm) : 10 x 23 x 2.2</span>
							<span>풍량 : 5.3m/s(5cm)</span>
						</p>
						<p>
							<span>배터리용량 : 2600mA</span>
							<span>데시벨 : 59dB</span>
						</p>
						<p>
							<span>무게 : 173g</span>
						</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>접이식과 클립으로 다용도로 사용하기에 용이하고, <br />보조배터리로 사용가능</dd>
					</dl>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1719379&pEtr=78571">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78571/img_item6.jpg" alt="오아 슈퍼팬 핸디 선풍기" /></span>
					<h3>오아 슈퍼팬 핸디 선풍기</h3>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1719379
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price"><del><%= FormatNumber(oItem.Prd.FOrgPrice,0)%></del> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong></div>
						<% Else %>
							<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
						<% End If %>
					<% End If %>
					<% set oItem=nothing %>
					<div class="itemInfo">
						<p>
							<span>크기(cm) : 10.5 x 21 x 3.7</span>
							<span>풍량 : 8.1m/s(3cm)</span>
						</p>
						<p>
							<span>배터리용량 : 3000mA</span>
							<span>데시벨 : 52dB</span>
						</p>
						<p>
							<span>무게 : 170g</span>
						</p>
					</div>
					<dl>
						<dt>추천이유</dt>
						<dd>적은 소음, 강한 풍량, <br />3000mA의 괴물용량 배터리 3박자 선풍기</dd>
					</dl>
				</a>
			</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->