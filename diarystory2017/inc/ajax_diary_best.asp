<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2017 seller(best),wish,review,event
' History : 2016.09.26 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2017/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
dim awardlist, i, bestgubun, SortMet, PageSize
dim gubunreturn
	bestgubun = requestcheckvar(request("bestgubun"),1)

if bestgubun="" then bestgubun="b"
SortMet="dbest"
PageSize = 8
if bestgubun="b" then 
	gubunreturn = "b"
elseif bestgubun="f" then 
	gubunreturn = "f"
elseif bestgubun="e" then 
	gubunreturn = "e"
elseif bestgubun="r" then 
	SortMet="dreview"
	bestgubun="b"
	gubunreturn = "r"
	PageSize = 4
end if

Set awardlist = new cdiary_list
'아이템 리스트
awardlist.FPageSize = PageSize
awardlist.FCurrPage = 1
awardlist.Fbestgubun = bestgubun
awardlist.ftectSortMet = SortMet
'awardlist.frectdesign = sArrDesign
'awardlist.frectcontents = ""
'awardlist.frectkeyword = ""
'awardlist.fmdpick = ""
'awardlist.fuserid = userid
awardlist.getDiaryAwardBest

if gubunreturn="b" then
%>
	<!-- SELLER -->
	<div id="seller" class="diaryList">
		<ul>
		<%
		If awardlist.FResultCount > 0 Then
			For i = 0 To awardlist.FResultCount - 1

			IF application("Svr_Info") = "Dev" THEN
				awardlist.FItemList(i).FImageicon1 = left(awardlist.FItemList(i).FImageicon1,7)&mid(awardlist.FItemList(i).FImageicon1,12)
				'response.write PrdBrandList.FItemList(i).FDiaryBasicImg
			end if
		%>
				<li class="best0<%= i +1 %>">
					<span class="ranking"><%= i +1 %></span>
					<div class="pdtBox">
						<a href="/shopping/category_prd.asp?itemid=<%=awardlist.FItemList(i).FItemid%>">
							<div><img src="<%= awardlist.FItemList(i).FImageicon1 %>" width="175" height="175" alt="상품명" /></div>
							<div class="pdtInfo">
								<p class="name">
									<% If awardlist.FItemList(i).isSaleItem Or awardlist.FItemList(i).isLimitItem Then %>
										<%= chrbyte(awardlist.FItemList(i).FItemName,30,"Y") %>
									<% Else %>
										<%= awardlist.FItemList(i).FItemName %>
									<% End If %>
								</p>
								<% if awardlist.FItemList(i).IsSaleItem or awardlist.FItemList(i).isCouponItem Then %>
									<% IF awardlist.FItemList(i).IsSaleItem then %>
										<p class="price"><span class="finalP"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=awardlist.FItemList(i).getSalePro%>]</strong></p>
									<% End If %>
									<% IF awardlist.FItemList(i).IsCouponItem Then %>
										<p class="price"><span class="finalP"><%=FormatNumber(awardlist.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=awardlist.FItemList(i).GetCouponDiscountStr%>]</strong></p>
									<% end if %>
								<% else %>
									<p class="price"><span class="finalP"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0) & chkIIF(awardlist.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
								<% end if %>
							</div>
						</a>
					</div>
				</li>
			<% next %>
		<% end if %>
		</ul>
	</div>
	<!--// SELLER -->

<% elseif gubunreturn="f" then %>
	<!-- WISH -->
	<div id="wish" class="diaryList">
		<ul>
		<%
		If awardlist.FResultCount > 0 Then
			For i = 0 To awardlist.FResultCount - 1

			IF application("Svr_Info") = "Dev" THEN
				awardlist.FItemList(i).FImageicon1 = left(awardlist.FItemList(i).FImageicon1,7)&mid(awardlist.FItemList(i).FImageicon1,12)
				'response.write PrdBrandList.FItemList(i).FDiaryBasicImg
			end if
		%>
				<li class="best0<%= i +1 %>">
					<span class="ranking"><%= i +1 %></span>
					<div class="pdtBox">
						<a href="/shopping/category_prd.asp?itemid=<%=awardlist.FItemList(i).FItemid%>">
							<div><img src="<%= awardlist.FItemList(i).FImageicon1 %>" width="175" height="175" alt="상품명" /></div>
							<div class="pdtInfo">
								<p class="name">
									<% If awardlist.FItemList(i).isSaleItem Or awardlist.FItemList(i).isLimitItem Then %>
										<%= chrbyte(awardlist.FItemList(i).FItemName,30,"Y") %>
									<% Else %>
										<%= awardlist.FItemList(i).FItemName %>
									<% End If %>
								</p>
								<% if awardlist.FItemList(i).IsSaleItem or awardlist.FItemList(i).isCouponItem Then %>
									<% IF awardlist.FItemList(i).IsSaleItem then %>
										<p class="price"><span class="finalP"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=awardlist.FItemList(i).getSalePro%>]</strong></p>
									<% End If %>
									<% IF awardlist.FItemList(i).IsCouponItem Then %>
										<p class="price"><span class="finalP"><%=FormatNumber(awardlist.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=awardlist.FItemList(i).GetCouponDiscountStr%>]</strong></p>
									<% end if %>
								<% else %>
									<p class="price"><span class="finalP"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0) & chkIIF(awardlist.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
								<% end if %>
							</div>
						</a>
					</div>
				</li>
			<% next %>
		<% end if %>
		</ul>
	</div>
	<!--// WISH -->

<% elseif gubunreturn="r" then %>
	<!-- REVIEW -->
	<div id="review" class="diaryList">
		<ul>
		<%
		If awardlist.FResultCount > 0 Then
			For i = 0 To awardlist.FResultCount - 1

			IF application("Svr_Info") = "Dev" THEN
				awardlist.FItemList(i).FImageicon1 = left(awardlist.FItemList(i).FImageicon1,7)&mid(awardlist.FItemList(i).FImageicon1,12)
				'response.write PrdBrandList.FItemList(i).FDiaryBasicImg
			end if
		%>
			<li class="best0<%= i +1 %>">
				<span class="ranking"><%= i +1 %></span>
				<div class="pdtBox">
					<a href="/shopping/category_prd.asp?itemid=<%=awardlist.FItemList(i).FItemid%>"><div><img src="<%= awardlist.FItemList(i).FImageicon1 %>" width="190" height="190" alt="상품명" /></div></a>
					<div class="pdtInfo">
						<p class="name">
							<% If awardlist.FItemList(i).isSaleItem Or awardlist.FItemList(i).isLimitItem Then %>
								<%= chrbyte(awardlist.FItemList(i).FItemName,30,"Y") %>
							<% Else %>
								<%= awardlist.FItemList(i).FItemName %>
							<% End If %>
						</p>
						<% if awardlist.FItemList(i).IsSaleItem or awardlist.FItemList(i).isCouponItem Then %>
							<% IF awardlist.FItemList(i).IsSaleItem then %>
								<p class="price"><span class="finalP"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=awardlist.FItemList(i).getSalePro%>]</strong></p>
							<% End If %>
							<% IF awardlist.FItemList(i).IsCouponItem Then %>
								<p class="price"><span class="finalP"><%=FormatNumber(awardlist.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=awardlist.FItemList(i).GetCouponDiscountStr%>]</strong></p>
							<% end if %>
						<% else %>
							<p class="price"><span class="finalP"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0) & chkIIF(awardlist.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
						<% end if %>
						
						<%
							dim tmpreview, tmpstar, tmpreviewtxt, lngStringArr
							tmpstar="0"
							tmpreviewtxt=""
							tmpreview=""
							if awardlist.FItemList(i).Freviewcontents <> "" then
								lngStringArr = Split(awardlist.FItemList(i).Freviewcontents,"!@#")
								if isArray(lngStringArr) then
									tmpreviewtxt	= lngStringArr(0)
									tmpstar		= lngStringArr(1)
								'	tmpreview = Split(awardlist.FItemList(i).Freviewcontents, "!@#")
								end if
							end if
						%>
						<div class="reviewBoxV15">
							<p class="starView"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%= tmpstar %>.png" alt="별<%= tmpstar %>개" /></p>
							<p class="tPad10"><% = chrbyte(tmpreviewtxt,45,"Y") %></p>
							<a href="" onclick="popEvalList('<%=awardlist.FItemList(i).FItemid%>'); return false;"class="more1V15">리뷰 더보기</a>
						</div>
					</div>
				</div>
			</li>
			<% next %>
		<% end if %>
		</ul>
	</div>
	<!--// REVIEW -->

<% elseif gubunreturn="e" then %>
	<%
	dim odibest
	set odibest = new cdiary_list
		odibest.FPageSize	= 4
		odibest.FselOp		= 2
		odibest.FEvttype = "1"
		odibest.Fisweb	 	= "1"
		odibest.Fismobile	= "0"
		odibest.Fisapp	 	= "0"
		odibest.fnGetdievent
	%>
	<!-- EVENT -->
	<div id="event" class="diaryList">
		<ul>
		<% If odibest.FResultCount > 0 Then %>
			<% 
				dim vLink, vName
				FOR i = 0 to odibest.FResultCount-1
					IF odibest.FItemList(i).FEvt_kind = "16" Then
						IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
							vLink = "location.href='" & odibest.FItemList(i).feventitemid & "';"
						ELSE
							vLink = "GoToBrandShopevent_direct('" & odibest.FItemList(i).fbrand & "','" & odibest.FItemList(i).fevt_code & "');"
						END IF
						vName = split(odibest.FItemList(i).FEvt_name,"|")(0)
					Elseif odibest.FItemList(i).FEvt_kind = "13" Then
						vLink = "TnGotoProduct('" & odibest.FItemList(i).fetc_itemid & "');"
						vName = odibest.FItemList(i).FEvt_name
					Else
						IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
							vLink = "location.href='" & odibest.FItemList(i).feventitemid & "';"
						ELSE
							vLink = "TnGotoEventMain('" & odibest.FItemList(i).fevt_code & "');"
						END IF
						vName = odibest.FItemList(i).FEvt_name
					End IF
 			%>
				<li class="best0<%=i+1%>">
					<span class="ranking"><%=i+1%></span>
					<div class="pdtBox">
						<a href="/event/eventmain.asp?eventid=<%=odibest.FItemList(i).fevt_code %>">
							<div>
								<% If odibest.FItemList(i).Fetc_itemimg <> "" Then %>
									<img src="<%=odibest.FItemList(i).Fetc_itemimg %>" width="190" height="190" alt="상품명" />
								<% else %>
									<img src="<%=odibest.FItemList(i).FImageList %>" width="190" height="190" alt="상품명" />
								<% end if %>
							</div>
							<div class="pdtInfo">
								<p class="evtTit">
								<%	'//이벤트 명 할인이나 쿠폰시
									If odibest.FItemList(i).fissale Or odibest.FItemList(i).fiscoupon Then
										if ubound(Split(vName,"|"))> 0 Then
											If odibest.FItemList(i).fissale Or (odibest.FItemList(i).fissale And odibest.FItemList(i).fiscoupon) then
												vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &" <span style=color:red>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</span>"
											ElseIf odibest.FItemList(i).fiscoupon Then
												vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &" <span style=color:green>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</span>"
											End If 			
										end If
									End If 
								%>
									<%=chrbyte(vName,80,"Y")%>
								</p>
								<p class="evtExp"><%=chrbyte(odibest.FItemList(i).FEvt_subcopyK,50,"Y") %></p>
								<p class="pdtStTag">
									<% If odibest.FItemList(i).fissale Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" />&nbsp;<% End if %>
									<% If odibest.FItemList(i).fiscoupon Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" />&nbsp;<% End if %>
									<% If odibest.FItemList(i).fisfreedelivery Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_free_ship.gif" alt="무료배송" />&nbsp;<% End if %>
									<% If odibest.FItemList(i).fisOnlyTen Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" />&nbsp;<% End if %>
									<% If odibest.FItemList(i).fisoneplusone Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_oneplus.gif" alt="1+1" />&nbsp;<% End if %>
									<% If odibest.FItemList(i).fisgift Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_gift.gif" alt="GIFT" /><% End if %>
								</p>
								<p class="evtDate">~<%=odibest.FItemList(i).fevt_enddate %></p>
							</div>
						</a>
					</div>
				</li>
			<% Next %>
		<% End if %>
		</ul>
		<a href="/diarystory2017/event.asp" class="more1V15">다이어리 이벤트 더보기</a>
	</div>
	<!--// EVENT -->
<% end if %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<%
Set awardlist = Nothing
Set odibest = Nothing
%>