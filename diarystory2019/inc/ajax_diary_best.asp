<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2017 seller(best),wish,review,event
' History : 2017.09.18 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
dim awardlist, i, bestgubun, SortMet, PageSize
dim gubunreturn
	bestgubun = requestcheckvar(request("bestgubun"),1)
dim gaParam : gaParam = "&gaparam=diarystory_"

if bestgubun="" then bestgubun="b"
SortMet="dbest"
PageSize = 12
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
ElseIf bestgubun = "s" then 
	gubunreturn = "s"
end if

Set awardlist = new cdiary_list
'아이템 리스트
If bestgubun = "s" then 
	awardlist.getNowSellingItems
Else
	awardlist.FPageSize = PageSize
	awardlist.FCurrPage = 1
	if bestgubun = "b" then 
		awardlist.fmdpick = "o"
	else
		awardlist.Fbestgubun = bestgubun
		awardlist.ftectSortMet = SortMet
	end if 
	awardlist.getDiaryAwardBest
End If 

%>
<script>
	$(function(){
		var _beststate = $('#best li');
		var _nowstate = $('#now li');
		var _popularstate = $('#popular li');
		var _populareventstate = $('#popular-event li');
		$('.btn-more').click(function(){
			if($('.diary-rcmd').hasClass('unfold')){
				$('.diary-rcmd').removeClass('unfold');
				$('#best').find('.elmore').css("display","none");
				$('#now').find('.elmore').css("display","none");
				$('#popular').find('.elmore').css("display","none");
				$('#popular-event').find('.elmore').css("display","none");
			}else{
				$('.diary-rcmd').addClass('unfold');
				_beststate.css("display","");
				_nowstate.css("display","");
				_popularstate.css("display","");
				_populareventstate.css("display","");
			}
		});
	});
	var btnmore = function(){
		$('.diary-rcmd').addClass('unfold');
		$('#best li').css("display","");
		$('#now li').css("display","");
		$('#popular li').css("display","");
		$('#popular-event li').css("display","");
	}
</script>
<%

if gubunreturn="b" then
%>
	<div id="best" class="tab-cont items type-thumb item-250">
		<ul>
			<%
			If awardlist.FResultCount > 0 Then
				For i = 0 To awardlist.FResultCount - 1

				IF application("Svr_Info") = "Dev" THEN
					awardlist.FItemList(i).FImageicon1 = left(awardlist.FItemList(i).FImageicon1,7)&mid(awardlist.FItemList(i).FImageicon1,12)
				end if
			%>
			<li class=<%=chkiif(i > 3,"elmore","")%> style="display:none;">
				<a href="/shopping/category_prd.asp?itemid=<%=awardlist.FItemList(i).FItemid%><%=gaParam&"best_"&i+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_bestitems','gubun|itemid|number','best|<%=awardlist.FItemList(i).FItemid%>|<%=i+1%>');">
					<span class="thumbnail"><img src="<%= awardlist.FItemList(i).FDiaryBasicImg2 %>" alt=""><em><%=i+1%></em></span>
					<span class="desc">
						<span class="name">
							<% If awardlist.FItemList(i).isSaleItem Or awardlist.FItemList(i).isLimitItem Then %>
								<%= chrbyte(awardlist.FItemList(i).FItemName,30,"Y") %>
							<% Else %>
								<%= awardlist.FItemList(i).FItemName %>
							<% End If %>
						</span>
						<span class="price">
						<% if awardlist.FItemList(i).IsSaleItem or awardlist.FItemList(i).isCouponItem Then %>
							<% IF awardlist.FItemList(i).IsCouponItem Then %>
								<span class="sum"><%=FormatNumber(awardlist.FItemList(i).GetCouponAssignPrice,0)%>원</span>
								<span class="discount color-green">[<%=awardlist.FItemList(i).GetCouponDiscountStr%>]</span>							
							<% else'IF awardlist.FItemList(i).IsSaleItem then %>
								<span class="sum"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0)%>원</span>
								<span class="discount color-red">[<%=awardlist.FItemList(i).getSalePro%>]</span>
							<% End If %>
						<% else %>
							<span class="sum"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0) & chkIIF(awardlist.FItemList(i).IsMileShopitem,"Point","원")%></span>
						<% end if %>
						</span>
					</span>
				</a>
			</li>
			<% 
				Next
			end If
			%>
		</ul>
		<button class="btn-more"></button>
	</div>

<% elseif gubunreturn="f" then %>
	<%'!-- WISH --%>
	<div id="popular" class="tab-cont items type-thumb item-250">
		<ul>
			<%
			If awardlist.FResultCount > 0 Then
				For i = 0 To awardlist.FResultCount - 1

				IF application("Svr_Info") = "Dev" THEN
					awardlist.FItemList(i).FImageicon1 = left(awardlist.FItemList(i).FImageicon1,7)&mid(awardlist.FItemList(i).FImageicon1,12)
				end if
			%>
			<li class=<%=chkiif(i > 3,"elmore","")%> style="display:none;">
				<a href="/shopping/category_prd.asp?itemid=<%=awardlist.FItemList(i).FItemid%><%=gaParam&"wish_"&i+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_bestitems','wish|itemid|number','best|<%=awardlist.FItemList(i).FItemid%>|<%=i+1%>');">
					<span class="thumbnail"><img src="<%= awardlist.FItemList(i).FDiaryBasicImg2 %>" alt=""><% If awardlist.FItemList(i).Ffavcount > 0 Then %><em><%=formatnumber(awardlist.FItemList(i).Ffavcount,0)%>명</em><% End If %></span>
					<span class="desc">
						<span class="name">
							<% If awardlist.FItemList(i).isSaleItem Or awardlist.FItemList(i).isLimitItem Then %>
								<%= chrbyte(awardlist.FItemList(i).FItemName,30,"Y") %>
							<% Else %>
								<%= awardlist.FItemList(i).FItemName %>
							<% End If %>
						</span>
						<span class="price">
						<% if awardlist.FItemList(i).IsSaleItem or awardlist.FItemList(i).isCouponItem Then %>
							<% IF awardlist.FItemList(i).IsCouponItem Then %>
								<span class="price"><%=FormatNumber(awardlist.FItemList(i).GetCouponAssignPrice,0)%>원</span>
								<span class="discount color-green">[<%=awardlist.FItemList(i).GetCouponDiscountStr%>]</strong></span>
							<% else'IF awardlist.FItemList(i).IsSaleItem then %>
								<span class="price"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0)%>원</span>
								<span class="discount color-red">[<%=awardlist.FItemList(i).getSalePro%>]</strong></span>
							<% End If %>
						<% else %>
							<span class="price"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0) & chkIIF(awardlist.FItemList(i).IsMileShopitem,"Point","원")%></span>
						<% end if %>
						</span>
					</span>
				</a>
			</li>
			<%
				Next
			end If
			%>
		</ul>
		<button class="btn-more"></button>
	</div>
	<%'!--// WISH --%>

<% elseif gubunreturn="r" then %>
	<!-- REVIEW -->
	<div id="review" class="diary-list">
		<ul>
		<%
		If awardlist.FResultCount > 0 Then
			For i = 0 To awardlist.FResultCount - 1

			IF application("Svr_Info") = "Dev" THEN
				awardlist.FItemList(i).FImageicon1 = left(awardlist.FItemList(i).FImageicon1,7)&mid(awardlist.FItemList(i).FImageicon1,12)
			end if
		%>
				<li>
					<a href="/shopping/category_prd.asp?itemid=<%=awardlist.FItemList(i).FItemid%>">
						<div class="pdtPhoto"><img src="<%= awardlist.FItemList(i).FDiaryBasicImg2 %>" alt="" /></div>
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
									<p class="price"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0)%>원 <strong class="cRd0V15">[<%=awardlist.FItemList(i).getSalePro%>]</strong></p>
								<% End If %>
								<% IF awardlist.FItemList(i).IsCouponItem Then %>
									<p class="price"><%=FormatNumber(awardlist.FItemList(i).GetCouponAssignPrice,0)%>원<strong class="cGr0V15">[<%=awardlist.FItemList(i).GetCouponDiscountStr%>]</strong></p>
								<% end if %>
							<% else %>
								<p class="price"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0) & chkIIF(awardlist.FItemList(i).IsMileShopitem,"Point","원")%></p>
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
							<p class="star"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%= tmpstar %>.png" alt="별<%= tmpstar %>개" /></p>
						</div>
					</a>
					<div class="txt">
						<!-- for dev msg : 80자 이상은 ...처리해주세용 -->
						<p><% = chrbyte(tmpreviewtxt,45,"Y") %></p>
						<a href="" onclick="popEvalList('<%=awardlist.FItemList(i).FItemid%>'); return false;" class="btn-more">more</a>
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
		odibest.FPageSize	= 12
		odibest.FselOp		= 0 '0 신규순 1 종료 임박 2 인기순
		odibest.FEvttype = "1"
		odibest.Fisweb	 	= "1"
		odibest.Fismobile	= "0"
		odibest.Fisapp	 	= "0"
		odibest.fnGetdievent
	%>
	<%'!-- EVENT --%>
	<div id="popular-event" class="tab-cont items type-list">
		<ul>
		<% 
			If odibest.FResultCount > 0 Then 
				dim vLink, vName
				FOR i = 0 to odibest.FResultCount-1
					IF odibest.FItemList(i).FEvt_kind = "16" Then
						IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
							vLink = "location.href='" & odibest.FItemList(i).feventitemid & "';"
						ELSE
							vLink = "GoToBrandShopevent_direct('" & odibest.FItemList(i).fbrand & "','" & odibest.FItemList(i).fevt_code & "');"
						END IF
						vName = "<span class='name'>"&split(odibest.FItemList(i).FEvt_name,"|")(0)&"</span>"
					Elseif odibest.FItemList(i).FEvt_kind = "13" Then
						vLink = "TnGotoProduct('" & odibest.FItemList(i).fetc_itemid & "');"
						vName = "<span class='name'>"&odibest.FItemList(i).FEvt_name&"</span>"
					Else
						IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
							vLink = "location.href='" & odibest.FItemList(i).feventitemid & "';"
						ELSE
							vLink = "TnGotoEventMain('" & odibest.FItemList(i).fevt_code & "');"
						END IF
						vName = "<span class='name'>"&odibest.FItemList(i).FEvt_name&"</span>"
					End IF
 		%>
			<li class=<%=chkiif(i > 3,"elmore","")%> style="display:none;">
				<a href="/event/eventmain.asp?eventid=<%=odibest.FItemList(i).fevt_code %><%=gaParam&"event_"&i+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_bestitems','event|itemid|number','best|<%=odibest.FItemList(i).fevt_code%>|<%=i+1%>');">
					<span class="thumbnail">
						<% If odibest.FItemList(i).Fetc_itemimg <> "" Then %>
							<img src="<%=odibest.FItemList(i).Fetc_itemimg %>" alt="" />
						<% else %>
							<img src="<%=odibest.FItemList(i).FImageList %>" alt="" />
						<% end if %>
						<% If odibest.FItemList(i).fisgift Then %><em class="gift">GIFT</em><% End If %>
					</span>
					<span class="desc">
						<%	'//이벤트 명 할인이나 쿠폰시
							If odibest.FItemList(i).fissale Or odibest.FItemList(i).fiscoupon Then
								if ubound(Split(vName,"|"))> 0 Then
									If odibest.FItemList(i).fissale Or (odibest.FItemList(i).fissale And odibest.FItemList(i).fiscoupon) then
										vName = "<span class='name'>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &"</span><span class='sale'>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</span>"
									ElseIf odibest.FItemList(i).fiscoupon Then
										vName = "<span class='name'>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &"</span><span class='coupon'>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</span>"
									End If 			
								end If
							End If 
						%>
						<%=chrbyte(vName,80,"Y")%>
						<span class="sub"><%=chrbyte(odibest.FItemList(i).FEvt_subcopyK,50,"Y") %></span>
						<span class="date"><%=odibest.FItemList(i).fevt_enddate %>까지</span>
					</span>
				</a>
			</li>
		<%		
				Next 
			End if 
		%>
		</ul>
		<button class="btn-more"></button>
	</div>
	<%'!--// EVENT --%>
<% elseif gubunreturn="s" then %>
	<%'!-- realtimesell --%>
	<div id="now" class="tab-cont items type-thumb item-250">
		<ul>
			<%
			If awardlist.FResultCount > 0 Then
				For i = 0 To awardlist.FResultCount - 1

				IF application("Svr_Info") = "Dev" THEN
					awardlist.FItemList(i).FImageicon1 = left(awardlist.FItemList(i).FImageicon1,7)&mid(awardlist.FItemList(i).FImageicon1,12)
				end if
			%>
			<li class=<%=chkiif(i > 3,"elmore","")%> style="display:none;">
				<a href="/shopping/category_prd.asp?itemid=<%=awardlist.FItemList(i).FItemid%><%=gaParam&"latestsell_"&i+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_bestitems','sell|itemid|number','best|<%=awardlist.FItemList(i).FItemid%>|<%=i+1%>');">
					<span class="thumbnail"><img src="<%= awardlist.FItemList(i).FImageBasic %>" alt=""><em><%= awardlist.FItemList(i).Gettimeset %></em></span>
					<span class="desc">
						<span class="name"><%= awardlist.FItemList(i).FItemName %></span>
						<span class="price">
						<% if awardlist.FItemList(i).IsSaleItem or awardlist.FItemList(i).isCouponItem Then %>
							<% IF awardlist.FItemList(i).IsCouponItem Then %>
								<span class="price"><%=FormatNumber(awardlist.FItemList(i).GetCouponAssignPrice,0)%>원</span>
								<span class="discount color-green">[<%=awardlist.FItemList(i).GetCouponDiscountStr%>]</strong></span>							
							<% else'IF awardlist.FItemList(i).IsSaleItem then %>
								<span class="price"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0)%>원</span>
								<span class="discount color-red">[<%=awardlist.FItemList(i).getSalePro%>]</strong></span>
							<% End If %>
						<% else %>
							<span class="price"><%=FormatNumber(awardlist.FItemList(i).getRealPrice,0) & chkIIF(awardlist.FItemList(i).IsMileShopitem,"Point","원")%></span>
						<% end if %>
						</span>
					</span>
				</a>
			</li>
			<%
				Next
			end If
			%>
		</ul>
		<!--button class="btn-more"></button-->
	</div>
	<%'!--// realtimesell --%>
<% end if %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<%
Set awardlist = Nothing
Set odibest = Nothing
%>