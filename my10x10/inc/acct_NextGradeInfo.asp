<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myTenbytenInfoCls.asp" -->
<%
	dim userid, NextuserLevel
	dim userlevel, BuyCount, BuySum

	userid = GetLoginUserID
	if userid="" then response.End

	dim oMyInfo
	set oMyInfo = new CMyTenByTenInfo
	oMyInfo.FRectUserID = userid
	oMyInfo.getNextUserBaseInfoData
	    userlevel		= oMyInfo.FOneItem.Fuserlevel
	    BuyCount		= oMyInfo.FOneItem.FBuyCount
	    BuySum			= oMyInfo.FOneItem.FBuySum
	set oMyInfo = Nothing

''	set oMyInfo = new CMyTenByTenInfo
''	oMyInfo.FRectUserID = userid
''	oMyInfo.GetLastMonthUserLevelData
''		'' yyyymm			= oMyInfo.FOneItem.Fyyyymm
''		userlevel		= oMyInfo.FOneItem.Fuserlevel
''		BuyCount		= oMyInfo.FOneItem.FBuyCount
''		BuySum			= oMyInfo.FOneItem.FBuySum
''	set oMyInfo = Nothing

	'userlevel="2": BuyCount=2: BuySum=10000		'미리 확인 Test

	NextuserLevel = getUserLevelByQual(BuyCount,BuySum)			'조건으로 회원등급 확인

	if cStr(userlevel)="5" and cStr(NextuserLevel)="0" then NextuserLevel="5"	'오렌지회원
	if cStr(userlevel)="7" then NextuserLevel="7"								'STAFF

	'' '//구매내역 출력
	'' Response.Write userid & " 님 다음달 기준으로<br>최근 5개월 동안 <b>" & FormatNumber(BuyCount,0) & "회</b>(1만이상)<br><b>" & FormatNumber(BuySum,0) & "원</b> 구매하셨습니다.<br><br>"

	'' '//다음 등급 안내
	'' if cStr(NextuserLevel)=cStr(userlevel) and userlevel<>"4" and userlevel<>"7" then
	'' 	'# 현상유지 라면
	'' 	NextuserLevel = getNextMayLevel(NextuserLevel)
	'' 	Response.Write "이번달에 " & getRequireLevelUpBuyCount(NextuserLevel,BuyCount) & "회(1만이상)<br>또는 " & FormatNumber(getRequireLevelUpBuySum(NextuserLevel,BuySum),0) & "원 구매하시면<br>" & month(dateadd("m",1,date)) & "월에 " & GetUserLevelStr(NextuserLevel) & "회원이 될 예정입니다.<br>"
	'' elseif cStr(NextuserLevel)<cStr(userlevel) and userlevel<>"5" then
	'' 	'# 다음달 등급이 떨어진다면
	'' 	if (cInt(userlevel)-cInt(NextuserLevel))>1 then
	'' 		'2단계이상 급락할 경우
	'' 		NextuserLevel = getNextMayLevel(NextuserLevel)
	'' 		Response.Write "이번달에 " & getRequireLevelUpBuyCount(NextuserLevel,BuyCount) & "회(1만이상)<br>또는 " & FormatNumber(getRequireLevelUpBuySum(NextuserLevel,BuySum),0) & "원 구매하시면<br>" & month(dateadd("m",1,date)) & "월에 " & GetUserLevelStr(NextuserLevel) & "회원으로 될 예정입니다.<br>"
	'' 	else
	'' 		'1단계 하락시
	'' 		NextuserLevel = getNextMayLevel(NextuserLevel)
	'' 		Response.Write "이번달에 " & getRequireLevelUpBuyCount(NextuserLevel,BuyCount) & "회(1만이상)<br>또는 " & FormatNumber(getRequireLevelUpBuySum(NextuserLevel,BuySum),0) & "원 구매하시면<br>" & month(dateadd("m",1,date)) & "월에 " & GetUserLevelStr(NextuserLevel) & "회원이 유지될 예정입니다.<br>"
	'' 	end if
	'' else
	'' 	'// 다음달 등급이 올라간다면
	'' 	if Not(NextuserLevel="4" or NextuserLevel="7") then
	'' 		'최고등급(GOLD)이 아니면 그 다음등급 안내
	'' 		Response.Write "이번달에 " & getRequireLevelUpBuyCount(NextuserLevel,BuyCount) & "회(1만이상)<br>또는 " & FormatNumber(getRequireLevelUpBuySum(NextuserLevel,BuySum),0) & "원 구매하시면<br>" & GetUserLevelStr(NextuserLevel) & "회원이 될 예정입니다.<br>"
	'' 	else
	'' 		Response.Write month(dateadd("m",1,date)) & "월에 " & GetUserLevelStr(NextuserLevel) & " 회원이 될 예정입니다.<br>"
	'' 	end if
	'' end if
%>
<%

'//다음 등급 안내
if NextuserLevel = "4" or NextuserLevel = "7" then
	''// 골드 또는 직원
%>
<p><span class="fb cr555"><%= userid %></span> 님은 <%= month(dateadd("m",1,date)) %>월에 <span class="fb cr555"><%= GetUserLevelStr(NextuserLevel) %></span> 회원이 될 예정입니다.</p>
<br>
<%
else
%>
<p><span class="fb cr555"><%= userid %></span> 님 다음달 기준으로 최근 5개월 동안<br /><span class="fb cr555"><%= FormatNumber(BuyCount,0) %>회</span>(1만이상), <span class="fb cr555"><%= FormatNumber(BuySum,0) %>원</span> 구매하시어<br />예상회원등급은 <span class="fb cr555"><%= GetUserLevelStr(NextuserLevel) %></span> 회원입니다.</p>
<%
	NextuserLevel = getNextMayLevel(NextuserLevel)
%>
<br>
<p><span class="fb cr555"><%= month(dateadd("m",1,date)) %>월에 <%= GetUserLevelStr(NextuserLevel) %> 등급이 되시려면,</span><br />결제금액 또는 주문횟수 두 가지 중 한 가지만 만족하시면 다음 단계가<br />적용됩니다. (결제완료기준)</p>
<ul class="exGrade">
	<li>필요한 주문횟수 : <%= getRequireLevelUpBuyCount(NextuserLevel,BuyCount) %> 회</li>
	<li>필요한 결제금액 : <%= FormatNumber(getRequireLevelUpBuySum(NextuserLevel,BuySum),0) %> 원</li>
</ul>
<% end if %>

<p class="lsM1">(취소/반품 발생 시 예상과 다를 수 있습니다.)</p>
<!-- #include virtual="/lib/db/dbclose.asp" -->
