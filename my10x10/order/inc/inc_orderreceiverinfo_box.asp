<%
	dim TicketDlvType: TicketDlvType="0"
%>
  <% if (IsTicketOrder) then %>
  <%
        IF myorderdetail.FResultCount>0 then
        Dim oticketItem, oticketSchedule

        Set oticketItem = new CTicketItem
        oticketItem.FRectItemID = myorderdetail.FItemList(0).FItemID
        oticketItem.GetOneTicketItem

		TicketDlvType = oticketItem.FOneItem.FticketDlvType		'// 티켓수령방법

        Set oticketSchedule = new CTicketSchedule
        oticketSchedule.FRectItemID = myorderdetail.FItemList(0).FItemID
        oticketSchedule.FRectItemOption = myorderdetail.FItemList(0).FItemOption
        oticketSchedule.getOneTicketSchdule
  %>
		<div class="title">
			<h4>공연정보 확인</h4>
		</div>
		<table class="baseTable rowTable">
		<caption>공연정보 확인</caption>
		<colgroup>
			<col width="130" /> <col width="210" /> <col width="130" /> <col width="*" />
		</colgroup>
		<tbody>
		<tr>
			<th scope="row">공연명</th>
			<td colspan="3">
				<div><%= myorderdetail.FItemList(0).FItemName %></div>
				<% If myorderdetail.FItemList(0).FItemOptionName <> "" Then %>
				<div><strong>선택옵션</strong> : myorderdetail.FItemList(0).FItemOptionName</div>
				<% End If %>
			</td>
		</tr>
		<tr>
			<th scope="row">공연일시</th>
			<td colspan="3"><%= oticketSchedule.FOneItem.getScheduleDateStr %>&nbsp;<%= oticketSchedule.FOneItem.getScheduleDateTime %></td>
		</tr>
		<tr>
			<th scope="row">공연장소</th>
			<td colspan="3"><%= oticketItem.FOneItem.FticketPlaceName %> <a href="javascript:popTicketPlace('<%= oticketItem.FOneItem.FticketPlaceIdx %>');" title="약도보기" class="btn btnS2 btnGry2 lMar05"><span class="fn whiteArr01">약도보기</span></a></td>
		</tr>
		<tr>
			<th scope="row">티켓매수</th>
			<td><%= myorderdetail.FItemList(0).FItemNo %>장</td>
			<th scope="row">티켓수령방법</th>
			<td><%= oticketItem.FOneItem.getTicketDlvName %></td>
		</tr>
		</tbody>
		</table>
  <%
        Set oticketSchedule = Nothing
        set oticketItem = Nothing
        end if
  %>
<% end if %>

<% If vIsDeliveItemExist = True Then %>
			<div class="title">
			<% if (myorder.FOneItem.IsReceiveSiteOrder) or (IsTicketOrder and TicketDlvType="1") then %>
				<h4>수령인정보</h4>
					<% if (IsWebEditEnabled) then %>
				  	  <% if (myorder.FOneItem.IsReceiveSiteOrder) or (IsTicketOrder and TicketDlvType="1") then %>
				  	    <a href="javascript:popEditOrderInfo('<%= orderserial %>','recv');" title="수령인 정보 변경" class="btn btnS2 btnGrylight"><span class="fn">수령인 정보 변경</span></a>
				  	  <% else %>
					    <a href="javascript:popEditOrderInfo('<%= orderserial %>','recv');" title="배송지 정보 변경" class="btn btnS2 btnGrylight"><span class="fn">배송지 정보 변경</span></a>
					  <% End If %>
					<% End If %>
			<% else %>
				<h4>
					배송지정보
					<% if (IsTicketOrder) and Not(TicketDlvType="1") then %>
					<span class="fs11 fn">(사은품 배송을 위한 배송지)</span>
					<% End If %>
					<% if (IsWebEditEnabled) then %>
				  	  <% if (myorder.FOneItem.IsReceiveSiteOrder) or (IsTicketOrder and TicketDlvType="1") then %>
				  	    <a href="javascript:popEditOrderInfo('<%= orderserial %>','recv');" title="수령인 정보 변경" class="btn btnS2 btnGrylight"><span class="fn">수령인 정보 변경</span></a>
				  	  <% else %>
					    <a href="javascript:popEditOrderInfo('<%= orderserial %>','recv');" title="배송지 정보 변경" class="btn btnS2 btnGrylight"><span class="fn">배송지 정보 변경</span></a>
					  <% End If %>
					<% End If %>
				</h4>
			<% end if %>
			</div>
			<table class="baseTable rowTable">
			<% if (myorder.FOneItem.IsReceiveSiteOrder) or (IsTicketOrder and TicketDlvType="1") then %>
			<caption>수령인정보</caption>
			<% else %>
			<caption>배송지정보</caption>
			<% end if %>
			<colgroup>
				<col width="130" /> <col width="210" /> <col width="130" /> <col width="*" />
			</colgroup>
			<tbody>
		<% if (myorder.FOneItem.IsForeignDeliver) then %>
			<tr>
				<th scope="row">Country</th>
				<td colspan="3"><%= myorder.FOneItem.FDlvcountryName %></td>
			</tr>
			<tr>
				<th scope="row">수령인명(Name)</th>
				<td><%= myorder.FOneItem.FReqName %></td>
				<th scope="row">이메일(E-mail)</th>
				<td><%= myorder.FOneItem.FReqEmail %>&nbsp;</td>
			</tr>
			<tr>
				<th scope="row">전화번호(Tel.No)</th>
				<td colspan="3"><%= myorder.FOneItem.FReqPhone %></td>
			</tr>
			<tr>
				<th scope="row">우편번호(Zip Code)</th>
				<td colspan="3"><%= myorder.FOneItem.FemsZipCode %></td>
			</tr>
			<tr>
				<th scope="row">도시/주(City/State)</th>
				<td colspan="3"><%= myorder.FOneItem.Freqzipaddr %></td>
			</tr>
			<tr>
				<th scope="row">상세주소(Address)</th>
				<td colspan="3"><%= myorder.FOneItem.Freqaddress %></td>
			</tr>
		<% else %>
			<tr>
				<th scope="row">받으시는 분</th>
				<td colspan="3"><%= myorder.FOneItem.FReqName %></td>
			</tr>
			<tr>
				<th scope="row">휴대전화 번호</th>
				<td><%= myorder.FOneItem.FReqHp %></td>
				<th scope="row">전화번호</th>
				<td><%= myorder.FOneItem.FReqPhone %></td>
			</tr>
			<% if (myorder.FOneItem.IsReceiveSiteOrder) then %>
			<tr>
				<th scope="row">수령 방법</th>
				<td colspan="3">현장 수령</td>
			</tr>
			<% elseif Not(TicketDlvType="1") then %>
			<tr>
				<th scope="row">주소</th>
				<td colspan="3">[<%= Trim(myorder.FOneItem.FreqzipCode) %>] <%= myorder.FOneItem.Freqzipaddr %>&nbsp;<%= myorder.FOneItem.Freqaddress %></td>
			</tr>
			<tr>
				<th scope="row">배송 유의사항</th>
				<td colspan="3"><%= nl2Br(myorder.FOneItem.Fcomment) %>&nbsp;</td>
			</tr>
			<% end if %>
		<% end if %>
		<% If vIsPacked = "Y" Then
			
			dim ii,opackmaster, guestSessionID
			guestSessionID = GetGuestSessionKey
			set opackmaster = new Cpack
				opackmaster.FRectUserID = userid
				opackmaster.FRectSessionID = guestSessionID
				opackmaster.FRectOrderSerial = orderserial
				opackmaster.FRectCancelyn = "N"
				opackmaster.FRectSort = "ASC"
				opackmaster.Getpojang_master()
		%>
			</tbody>
			</table>
			<div class="title">
				<h4>선물포장 정보 확인</h4>
				<a href="" onClick="window.open('/inipay/pack/pack_message_edit.asp?idx=<%=orderserial%>', 'pkgMsgEdit', 'width=670, height=650, scrollbars=yes'); return false;" class="btn btnS2 btnWhite"><span class="fn">선물포장 상품확인</span></a>
			</div>
			<table class="baseTable rowTable">
				<caption>선물포장 정보</caption>
				<colgroup><col width="130" /> <col width="*" /></colgroup>
				<tbody>
				<tr>
					<th scope="row">포장내역</th>
					<td><%=packcnt%>개 <%= FormatNumber(packpaysum,0) %>원</td>
				</tr>
				<tr>
					<th scope="row">입력 메세지</th>
					<td class="fs11 lh19">
						<%
						If opackmaster.FResultCount > 0 Then
							For ii=0 To opackmaster.FResultCount-1
								Response.Write "<p><strong>[" & opackmaster.FItemList(ii).Ftitle & "]</strong> " & opackmaster.FItemList(ii).Fmessage & "</p>" & vbCrLf
							Next
						End If
						%>
					</td>
				</tr>
			<%
				Set opackmaster = Nothing
			End If %>
			</tbody>
			</table>
<% End If %>

<% if Not(IsNull(myorder.FOneItem.Freqdate)) and Not(myorder.FOneItem.IsReceiveSiteOrder) then %>
		<div class="title">
			<h4>플라워배송정보</h4>
			<a href="javascript:popEditOrderInfo('<%= orderserial %>','flow');" title="플라워 정보변경" class="btn btnS2 btnGrylight"><span class="fn">플라워 정보변경</span></a>
		</div>
		<table class="baseTable rowTable">
		<caption>플라워배송정보</caption>
		<colgroup>
			<col width="130" /> <col width="*" />
		</colgroup>
		<tbody>
		<tr>
			<th scope="row">보내시는 분</th>
			<td><%= myorder.FOneItem.Ffromname %></td>
		</tr>
		<tr>
			<th scope="row">희망배송일</th>
			<td><%= myorder.FOneItem.Freqdate %>일 <%= myorder.FOneItem.GetReqTimeText %></td>
		</tr>
		<tr>
			<th scope="row">메시지 선택</th>
			<td><%= myorder.FOneItem.GetCardLibonText %></td>
		</tr>
		<tr>
			<th scope="row">메시지 내용</th>
			<td><%= myorder.FOneItem.Fmessage %>&nbsp;</td>
		</tr>
		</tbody>
		</table>
<% End If %>
