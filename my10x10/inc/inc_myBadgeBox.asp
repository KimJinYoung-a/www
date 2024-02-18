<!-- #include virtual="/lib/util/badgelib.asp" -->
<%
	Dim arrBadgeList, badgeTitle, badgeContent, badgeObtainYN, badgeIdx, badgeDispNo, badgeTotalCnt
	Dim tmpArrBC, tmpItmBC, tmpBC1, tmpBC2
	Dim bdgGbnCnt: bdgGbnCnt=1
	Dim lpBdg

	'// 비회원도 뱃지 목록은 출력
	arrBadgeList = MyBadge_MyBadgeList(userid)

	dim totalObtainBadgeCount : totalObtainBadgeCount = 0
	dim firstObtainBadgeIdx : firstObtainBadgeIdx = 0

	IF isArray(arrBadgeList) THEN
		for lpBdg = 0 to UBound(arrBadgeList,2)
			if (arrBadgeList(2,lpBdg) = "Y") then
				'내가 취득한 총 뱃지 수
				totalObtainBadgeCount = totalObtainBadgeCount + 1

				'초기 뱃지 표시
				if (firstObtainBadgeIdx = 0) then firstObtainBadgeIdx = arrBadgeList(4,lpBdg)
			end if
		next
	end If

	If totalObtainBadgeCount>0 then
%>
<div class="badge">
	<a href="/my10x10/userinfo/popBadge.asp" onclick="window.open(this.href, 'popBadge', 'width=580, height=750, scrollbars=yes'); return false;" target="_blank" title="뱃지 팝업">
<%
		for lpBdg = 0 to UBound(arrBadgeList,2)
			IF isArray(arrBadgeList) THEN
				if (UBound(arrBadgeList,2) < lpBdg) then
					badgeTitle = ""
					badgeContent = ""
					badgeObtainYN = "N"
					badgeIdx = "0"
					badgeDispNo = "0"
					badgeTotalCnt = 0
				else
					badgeTitle = arrBadgeList(1,lpBdg)
					badgeContent = arrBadgeList(3,lpBdg)
					badgeObtainYN = arrBadgeList(2,lpBdg)
					badgeIdx = arrBadgeList(4,lpBdg)
					badgeDispNo = arrBadgeList(0,lpBdg)
					badgeTotalCnt = arrBadgeList(5,lpBdg)
	
					if (userid = "10x10green") and (lpBdg < 12) then
						'// 테스트 계정은 전부 표시
						badgeObtainYN = "Y"
					end if
				end if
			else
				badgeTitle = ""
				badgeContent = ""
				badgeObtainYN = "N"
				badgeIdx = "0"
				badgeDispNo = "0"
				badgeTotalCnt = 0
			end if
			
			'## 뱃지 최대 4개까지 노출 (4개이상 +나머지갯수표시)
			if (badgeObtainYN = "Y") then
				if lpBdg < 4 then
%>
		<span><img src="http://fiximage.10x10.co.kr/web2015/common/badge/ico_badge_40_<%=Num2Str(badgeDispNo, 2, "0", "R")%>.png" width="30" height="30" alt="<%= badgeTitle %>" /></span>
<%
				end if
			end if
		next
%>
	<% if totalObtainBadgeCount > 4 then %>
		<span class="more"><em>+</em> <strong><%= totalObtainBadgeCount-4 %></strong></span>
	<% end if %>
	</a>
</div>
<%	Else %>
<div class="nodata" style="display:none;"><span></span></div>
<%	End if %>
