<%
Dim cCa42thithi, fc42, vCate42EntrySDate, vCate42EntryEDate, vCate42AnnounDate, vCaWinTxt, vCate42WinVal, vCate42Notice, vCate42Img(3), vCa42IsEnd
Dim vCa42WinArr, intLoop42, vCate42EntryCopy, vCate42EntryEday, vCate42Badgetag

SET cCa42thithi = New CPlay
cCa42thithi.FRectDIdx = vDIdx
cCa42thithi.sbPlayThingThingDetail

vCa42IsEnd = "x"
If cCa42thithi.FOneItem.FCate42EntrySDate <> "" Then
	vCate42EntrySDate = Right(FormatDate(cCa42thithi.FOneItem.FCate42EntrySDate,"0000.00.00"),5)
End If
If cCa42thithi.FOneItem.FCate42EntryEDate <> "" Then
	vCate42EntryEday = cCa42thithi.FOneItem.FCate42EntryEDate
	vCate42EntryEDate = Right(FormatDate(cCa42thithi.FOneItem.FCate42EntryEDate,"0000.00.00"),5)
End If
If cCa42thithi.FOneItem.FCate42AnnounDate <> "" Then
	If CDate(cCa42thithi.FOneItem.FCate42AnnounDate) <= date() Then
		vCa42IsEnd = "o"
	End If
	vCate42AnnounDate = Right(FormatDate(cCa42thithi.FOneItem.FCate42AnnounDate,"0000.00.00"),5)
End If
vCaWinTxt			= cCa42thithi.FOneItem.FCate42WinnerTxt
vCate42WinVal		= cCa42thithi.FOneItem.FCate42WinnerValue
vCate42Notice		= cCa42thithi.FOneItem.FCate42Notice
vCate42EntryCopy	= cCa42thithi.FOneItem.FCate42Entrycopy
vCate42Badgetag		= cCa42thithi.FOneItem.FCate42Badgetag

'### 그외 작명센스 리스트
vCa42WinArr = cCa42thithi.FPlayThiThiWinList
SET cCa42thithi = Nothing

For fc42=1 To 3
	vCate42Img(fc42) = fnPlayImageSelectSortNo(vImageList,vCate,"8","i","0",fc42)
Next


'### 상품코드 받아오기
	Dim cCa42item, vCa42Item
	SET cCa42item = New CPlay
	cCa42item.FRectDIdx = vDIdx
	cCa42item.fnPlayItemList
	If cCa42item.FResultCount > 0 Then
		vCa42Item = cCa42item.FItemList(0).FItemID
	End If
	SET cCa42item = Nothing
%>
<div class="article playDetailV16 thingthing">
	<div class="cont">
		<div class="hgroup">
			<div>
				<!--<a href="list.asp?cate=4" class="corner">THING.</a>//-->
				THING.
				<% If vCa42IsEnd = "o" Then	'당첨발표후 %>
					<h2>내 이름은<br /><b style="color:#<%=vBGColor%>;"><%=vCate42WinVal%></b></h2>
					<p class="id"><%=vCaWinTxt%></p>
				<% Else %>
					<h2><%=vTitleStyle%></h2>
				<% End If %>
			</div>
		</div>
		<div class="detail">
			<div id="thingRolling" class="swiperFull" style="background-color:#<%=vBGColor%>;">
				<p class="say"><img src="http://fiximage.10x10.co.kr/web2016/play/txt_say_my_name.png" alt="Say my name!" /></p>
				<div class="bg top" style="background-color:#<%=vBGColor%>;"></div>
				<div class="bg btm" style="background-color:#<%=vBGColor%>;"></div>
				<div class="swiper-container">
					<em class="month"><span><%= vCate42Badgetag %></span></em>
					<!--<em class="month"><span>07월 THING</span></em>-->
					<div class="swiper-wrapper">
					<%
					For fc42=1 To 3
						If vCate42Img(fc42) <> "" Then
					%>
						<div class="swiper-slide">
							<img src="<%=vCate42Img(fc42)%>" alt="" />
						</div>
					<%
						End If
					Next
					%>
					</div>
					<div class="paginationDot"></div>
				</div>

				<div class="itemDesc">
					<p><%=vSubCopy%></p>
					<% If vCa42Item <> "" Then %>
					<div class="btnGet">
						<% if (FALSE) then ''2017/06/09 링크수정 %>
						<a href="" style="color:#<%=vBGColor%>;" onclick="ZoomItemInfo('<%=vCa42Item %>'); return false;">뱃지 구매하러가기 <span>&gt;</span></a>
					    <% end if %>
					    <a href="/shopping/category_prd.asp?itemid=<%=vCa42Item %>&gaparam=playing_<%=vCate%>_<%=vDIdx%>" style="color:#<%=vBGColor%>;" >뱃지 구매하러가기 <span>&gt;</span></a>
					</div>
					<% End If %>
				</div>
			</div>
			<% If vCa42IsEnd = "x" Then	'당첨발표전 %>
			<div class="summary" style="background-color:#<%=vBGColor%>;">
				<div class="inner">
					<div class="desc">
						<p class="msg" style="color:#<%=vBGColor%>;"><%=vCate42EntryCopy%></p>
						<p class="date">응모기간 : <%=vCate42EntrySDate%> ~ <%=vCate42EntryEDate%> <span>|</span> 발표 : <%=vCate42AnnounDate%></p>
					</div>
					<div class="form" style="background-color:#<%=vBGColor%>;">
						<span class="triangle" style="border-bottom-color:#<%=vBGColor%>;"></span>
						<form name="frm42" method="post" action="thingthing_proc.asp" onSubmit="return <% If vCate42EntryEday <> "" Then Response.Write CHKIIF(CDate(vCate42EntryEday)<date(),"jsTCommentEnd();","chkfrm42(this);") Else Response.Write "chkfrm42(this);" End If %>">
						<input type="hidden" name="didx" value="<%=vDidx%>">
							<fieldset>
							<legend class="hidden">어울리는 이름 짓기</legend>
								<label for="myname">내 이름은</label>
								<div class="itext"><input type="text" id="myname" title="이름 입력" placeholder="최대 9글자" style="border-color:#<%=vBGColor%>;" name="entryvalue" value="" maxlength="9" /></div>
								<div class="btnSubmit"><input type="submit" value="이름 지어주기" style="background-color:#<%=vBGColor%>;" /></div>
							</fieldset>
						</form>
					</div>
					<div class="noti">
						<h3>유의사항</h3>
						<ul>
							<%=Replace(vCate42Notice,vbCrLf,"<br />")%>
						</ul>
					</div>
				</div>
			</div>
			<% End If %>
			<% If vCa42IsEnd = "o" Then	'당첨발표후 %>
			<div class="other" style="background-color:#<%=vBGColor%>;">
				<div class="inner" style="background-color:#<%=vBGColor%>;">
					<h3>그 외의 작명센스!</h3>
					<ul>
						<%
						IF isArray(vCa42WinArr) THEN
							For intLoop42 =0 To UBound(vCa42WinArr,2)
								Response.Write "<li><span>" & vCa42WinArr(0,intLoop42) & "</span></li>" & vbCrLf
							Next
						End If
						%>
					</ul>
				</div>
			</div>
			<% End If %>
			<!-- #include file="./thingthing_comment.asp" -->
		</div>
	</div>
	<% If fnPlayImageSelect(vImageList,vCate,"21","i") <> "" AND vCa42IsEnd = "o" Then %>
	<div class="bnr">
		<a href="<%=fnPlayImageSelect(vImageList,vCate,"21","l")%>"><img src="<%=fnPlayImageSelect(vImageList,vCate,"21","i")%>" alt="" /></a>
	</div>
	<% End If %>
	<!-- #include file="./inc_sns.asp" -->
	<div class="listMore">
		<div class="more">
			<h2>다른 THING. 보기</h2>
			<a href="list.asp?cate=thing">more</a>
		</div>
		<!-- #include file="./inc_listmore.asp" -->
	</div>
</div>