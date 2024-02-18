<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.Charset="UTF-8"
%>
<%
'#######################################################
'	Description : 내 뱃지 정보
'	History	:  2015.03.21 허진원 PC Web Conv.
'	Erc : 팝업 창 사이즈 width=580, height=750
'#######################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/badgelib.asp" -->
<%
	Dim arrBadgeList, badgeTitle, badgeContent, badgeTerm, badgeObtainYN, badgeIdx, badgeDispNo, badgeTotalCnt
	Dim tmpArrBC, tmpItmBC, tmpBC1, tmpBC2
	dim userid, i
	userid = requestCheckVar(Request("uid"),200)

	'// userid Decoding
	userid = tenDec(userid)

	if userid="" then userid=GetLoginUserID

	'뱃지목록 Get
	arrBadgeList = MyBadge_MyBadgeList(userid)

	dim totalObtainBadgeCount : totalObtainBadgeCount = 0
	dim firstObtainBadgeIdx : firstObtainBadgeIdx = 0

	IF isArray(arrBadgeList) THEN
		for i = 0 to UBound(arrBadgeList,2)
			if (arrBadgeList(2,i) = "Y") then
				'내가 취득한 총 뱃지 수
				totalObtainBadgeCount = totalObtainBadgeCount + 1

				'초기 뱃지 표시
				if (firstObtainBadgeIdx = 0) then firstObtainBadgeIdx = arrBadgeList(4,i)
			end if
		next
	end if

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/popup/tit_badge.png" alt="뱃지" /></h1>
		</div>
		<div class="popContent">
			<div class="badgeV15">
				<ul class="list01">
					<li>고객님의 쇼핑패턴을 분석하여 자동으로 달아드리는 뱃지입니다.</li>
					<li>후기작성 및 코멘트 이벤트 참여시 획득한 뱃지를 통해 타인에게 신뢰 및 어드바이스를 전달해 줄 수 있습니다.</li>
				</ul>

				<div class="article">
					<strong class="mine fs12">나의 뱃지 보유현황 : <span class="cRd0V15"><%=totalObtainBadgeCount%>개</span></strong>
					<table>
						<caption>텐바이텐 뱃지 안내</caption>
						<colgroup>
							<col style="width:*;" />
							<col style="width:125px; background-color:#f7f7f7;" />
						</colgroup>
						<tbody>
					<%
						for i = 0 to UBound(arrBadgeList,2)
							IF isArray(arrBadgeList) THEN
								if (UBound(arrBadgeList,2) < i) then
									badgeTitle = ""
									badgeContent = ""
									badgeTerm = ""
									badgeObtainYN = "N"
									badgeIdx = "0"
									badgeDispNo = "0"
									badgeTotalCnt = 0
								else
									badgeTitle = arrBadgeList(1,i)
									badgeContent = arrBadgeList(3,i)
									badgeObtainYN = arrBadgeList(2,i)
									badgeIdx = arrBadgeList(4,i)
									badgeDispNo = arrBadgeList(0,i)
									badgeTotalCnt = arrBadgeList(5,i)
					
									if (userid = "10x10green") and (i < 12) then
										'// 테스트 계정은 전부 표시
										badgeObtainYN = "Y"
									end if
					
									'설명 분해 표시
									tmpArrBC = split(badgeContent, vbCrLf)
									if isArray(tmpArrBC) then
										tmpBC1="": tmpBC2=""
										for each tmpItmBC in tmpArrBC
											if instr(tmpItmBC,":")>0 then
												tmpBC2 = tmpBC2 & chkIIF(tmpBC2<>"","<br>","") & tmpItmBC
											else
												tmpBC1 = tmpBC1 & chkIIF(tmpBC1<>"","<br>","") & tmpItmBC
											end if
										next
										badgeContent = tmpBC1
										badgeTerm = chkIIF(tmpBC2<>"",tmpBC2,"&nbsp;")
									end if
								end if
							else
								badgeTitle = ""
								badgeContent = ""
								badgeTerm = ""
								badgeObtainYN = "N"
								badgeIdx = "0"
								badgeDispNo = "0"
							end if
					
					%>
						<tr>
							<th scope="row">
							<% If badgeObtainYN="N" Then %>
								<span class="ico"></span>
							<% else %>
								<span class="ico"><img src="http://fiximage.10x10.co.kr/web2015/common/badge/ico_badge_72_<%=Num2Str(badgeDispNo, 2, "0", "R")%>.gif" width="36" height="36" alt="<%=replace(badgeTitle,"""","")%>" /></span>
							<% End If %>
								<dl>
									<dt><%=badgeTitle%></dt>
									<dd><%=badgeContent%></dd>
								</dl>
								<p><em class="cRd0V15"><%=badgeTerm%></em></p>
							</th>
							<td class="ct">뱃지보유 회원<br /> <strong><%=formatNumber(badgeTotalCnt,0)%>명</strong></td>
						</tr>
					<%
						next
					%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->