<dl class="prsnlArea">
<% If IsUserLoginOK Then %>
<%
	Dim vUserID, vQuery, vRegdate, vAge, vSexFlag, vWishTotal, vWishExist, vFavCateCode, vFavCateName, vFavItem1, vFavItem1Img, vFavItem2, vFavItem2Img
	Dim vItemCount, vFavTotCount, vDayStandard, vAllFavItem1, vAllFavItem1Img, vAllFavItem2, vAllFavItem2Img, vAllFavItem3, vAllFavItem3Img, rsMem, vArr, vArr1, vArr2, k
	vUserID = getEncLoginUserID
	'vUserID = "okkang7"
	'vUserID = "motions"
	'vUserID = "kobula"
	'vUserID = "tozzinet"
	'vUserID = "baboytw"
	'vUserID = "thensi7"
	vItemCount = "424,979"
	vFavTotCount = "959,284"
	vDayStandard = "10.26"
	If getEncLoginUserID = "okkang77" Then
		'vUserID = "okkang777"
	End IF
	
	'### 가입일, 나이, 성별 받아오기.
	vQuery = "IF EXISTS(SELECT userid FROM [db_user].[dbo].[tbl_user_n] WHERE userid = '" & vUserID & "') " & vbCrLf & _
			 "BEGIN " & vbCrLf & _
			 "	SELECT regdate, birthday, sexflag FROM [db_user].[dbo].[tbl_user_n] WHERE userid = '" & vUserID & "' " & vbCrLf & _
			 "END " & vbCrLf & _
			 "ELSE " & vbCrLf & _
			 "BEGIN " & vbCrLf & _
			 "	SELECT regdate, birthday, sexflag FROM [db_user_Hold].[dbo].[tbl_hold_user_n] WHERE userid = '" & vUserID & "' " & vbCrLf & _
			 "END "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	If Not rsget.Eof Then
		vRegdate 	= rsget(0)
		vAge		= (Year(now) - Year(rsget(1))) + 1
		vSexFlag	= CStr(rsget(2))
		
		'### 홀수는 다 남자.
		If vSexFlag = "1" OR vSexFlag = "3" OR vSexFlag = "5" OR vSexFlag = "7" OR vSexFlag = "9" Then
			vSexFlag = "1"
		Else
			vSexFlag = "2"
		End If
	
		rsget.close
	Else
		'### 두군데 아이디 정보가 없을때. 있나?;;;
		rsget.close
		Response.Redirect "/"
		Response.end
	End If
	
	
	'### 받아온 가입일, 나이, 성별 로 연령별 BEST 변수 담기.
	Dim vTmp, vMyAge, vTmpItem, vMyAgeItem1, vMyAgeItem2, vMyAgeItemImg1, vMyAgeItemImg2
	vTmp = fnAgeSexflag(vAge,vSexFlag)	'### A||10대 초반, 남성. 함수로 이 값을 받아옴.
	vMyAge = Split(vTmp,"||")(1)		'### 받아온 값의 || 뒷쪽은 그냥 뿌려줌.
	
	'### 내 또래 상품 2개 받아오기.
	vQuery = "EXEC [db_temp].[dbo].[sp_Ten_14th_ourstory] '2','" & Split(vTmp,"||")(0)&vSexFlag & "',2,'" & vUserID & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	vArr1 = rsget.getRows()
	rsget.close
	
	If isArray(vArr1) Then
		vMyAgeItem1		= "<a href='/shopping/category_prd.asp?itemid=" & vArr1(0,0) & "'>" & vArr1(1,0) & "</a>"
		vMyAgeItemImg1	= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(vArr1(0,0)) & "/" & vArr1(2,0)
		vMyAgeItem2		= "<a href='/shopping/category_prd.asp?itemid=" & vArr1(0,1) & "'>" & vArr1(1,1) & "</a>"
		vMyAgeItemImg2	= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(vArr1(0,1)) & "/" & vArr1(2,1)
	End If
	
	
	
	'### 내위시 상품 갯수
	vQuery = "SELECT COUNT(itemid) FROM [db_my10x10].[dbo].[tbl_myfavorite] WHERE userid = '" & vUserID & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	vWishTotal = rsget(0)
	rsget.close
	
	
	'### 내위시 상품 있으면 o 없으면 x
	If vWishTotal > 0 Then
		vWishExist = "o"
	Else
		vWishExist = "x"
	End If
	
	
	'### 내위시 상품 있는 경우만 매칭 조회.
	If vWishExist = "o" Then
		
		'####### 만약의 경우 대비 DB케시 #######
		'vQuery = "EXEC [db_temp].[dbo].[sp_Ten_14th_ourstory] '1','',0,'" & vUserID & "'"
		'set rsMem = getDBCacheSQL(dbget,rsget,"OURSTORY",vQuery,60*60)
		'
		'If isNull(rsMem(0)) Then
		'	'### 전시카테고리 null이면 위시 없는 것으로 간주. 거의 전시 없으면 품절, 일시품절, 판매안하는 상품인것만 있는 경우임.
		'	vWishExist = "x"
		'	rsMem.close
		'Else
		'	vFavCateCode 	= rsMem(0)
		'	vFavCateName 	= rsMem(1)
		'	If vFavCateCode = "116" OR vFavCateCode = "117" Then
		'		vFavCateName = "패션 스타일"
		'	End IF
		'	rsMem.close
		'
		'	'### 좋아하는 카테고리 베스트 2개 받아옴.
		'	vQuery = "EXEC [db_temp].[dbo].[sp_Ten_14th_ourstory] '2','" & vFavCateCode & "',2,'" & vUserID & "'"
		'	rsget.CursorLocation = adUseClient
		'	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
		'	vArr2 = rsget.getRows()
		'	rsget.close
		'
		'	vFavItem1		= "<a href='/shopping/category_prd.asp?itemid=" & vArr2(0,0) & "'>" & vArr2(1,0) & "</a>"
		'	vFavItem1Img	= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(vArr2(0,0)) & "/" & vArr2(2,0)
		'	vFavItem2		= "<a href='/shopping/category_prd.asp?itemid=" & vArr2(0,1) & "'>" & vArr2(1,1) & "</a>"
		'	vFavItem2Img	= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(vArr2(0,1)) & "/" & vArr2(2,1)
		'End If
		'####### 만약의 경우 대비 DB케시 (아래 주석하고 여기 주석풀고.) #######
		
		
		vQuery = "EXEC [db_temp].[dbo].[sp_Ten_14th_ourstory] '1','',0,'" & vUserID & "'"
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
		If isNull(rsget(0)) Then
			'### 전시카테고리 null이면 위시 없는 것으로 간주. 거의 전시 없으면 품절, 일시품절, 판매안하는 상품인것만 있는 경우임.
			vWishExist = "x"
			rsget.close
		Else
			vFavCateCode 	= rsget(0)
			vFavCateName 	= rsget(1)
			If vFavCateCode = "116" OR vFavCateCode = "117" Then
				vFavCateName = "패션 스타일"
			End IF
			rsget.close
			
			'### 좋아하는 카테고리 베스트 2개 받아옴.
			vQuery = "EXEC [db_temp].[dbo].[sp_Ten_14th_ourstory] '2','" & vFavCateCode & "',2,'" & vUserID & "'"
			rsget.CursorLocation = adUseClient
			rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
			vArr2 = rsget.getRows()
			rsget.close

			vFavItem1		= "<a href='/shopping/category_prd.asp?itemid=" & vArr2(0,0) & "'>" & vArr2(1,0) & "</a>"
			vFavItem1Img	= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(vArr2(0,0)) & "/" & vArr2(2,0)
			vFavItem2		= "<a href='/shopping/category_prd.asp?itemid=" & vArr2(0,1) & "'>" & vArr2(1,1) & "</a>"
			vFavItem2Img	= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(vArr2(0,1)) & "/" & vArr2(2,1)
		End If
	End If
	
	
	If vWishExist = "x" Then
		'### 위시 없을때(전시카테고리없을때) 위시 가장 많이 담은 상품 랜덤 3개 가져옴.
		vQuery = "EXEC [db_temp].[dbo].[sp_Ten_14th_ourstory] '2','f',3,'" & vUserID & "'"
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
		vArr = rsget.getRows()
		rsget.close
		
		If isArray(vArr) Then
			vAllFavItem1		= "<a href='/shopping/category_prd.asp?itemid=" & vArr(0,0) & "'>" & vArr(1,0) & "</a>"
			vAllFavItem1Img		= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(vArr(0,0)) & "/" & vArr(2,0)
			vAllFavItem2		= "<a href='/shopping/category_prd.asp?itemid=" & vArr(0,1) & "'>" & vArr(1,1) & "</a>"
			vAllFavItem2Img		= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(vArr(0,1)) & "/" & vArr(2,1)
			vAllFavItem3		= "<a href='/shopping/category_prd.asp?itemid=" & vArr(0,2) & "'>" & vArr(1,2) & "</a>"
			vAllFavItem3Img		= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(vArr(0,2)) & "/" & vArr(2,2)
		End If
	End If
%>
	<dt>
		<strong><%=printUserId(vUserID,2,"*")%></strong> <img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/txt1.png" alt="님과 텐바이텐," /><br /><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/txt2.png" alt="우리만의 이야기" style="margin-top:5px" />
	</dt>
	<% If vWishExist = "o" Then %>
		<dd class="prsnlTxt">
			<p>우리가 처음 만났던 날, <strong><%=Year(vRegdate)%>년 <%=Month(vRegdate)%>월 <%=Day(vRegdate)%>일</strong><br />벌써 <strong><%=FormatNumber(DateDiff("d",DateAdd("d",-1,vRegdate),Now()),0)%></strong>일째 함께 하고 있어요.</p>
			<p>텐바이텐은 현재 총 <%=vItemCount%> 개의 상품을 가지고 있어요.<br />당신의 위시리스트 속에는 현재 <strong><a href="/my10x10/mywishlist.asp"><%=FormatNumber(vWishTotal,0)%></a></strong>개의 상품이 들어 있고요!<br />당신은 <strong><a href="/award/awardlist.asp?atype=f&disp=<%=vFavCateCode%>"><%=vFavCateName%></a></strong> 매니아인가요?<br />그렇다면 <strong><%=vFavItem1%></strong> 와 <strong><%=vFavItem2%></strong> 같은 상품은 어떠신가요?</p>
			<p class="pad0">음, 텐바이텐 안에서 당신 또래의 친구들은 (<%=vMyAge%>)<br /><strong><%=vMyAgeItem1%></strong> 와 <strong><%=vMyAgeItem2%></strong> 을 가장 많이 구매하고 있어요!</p>
		</dd>
	<% ElseIf vWishExist = "x" Then %>
		<dd class="prsnlTxt">
			<p>우리가 처음 만났던 날, <strong><%=Year(vRegdate)%>년 <%=Month(vRegdate)%>월 <%=Day(vRegdate)%>일</strong><br />벌써 <strong><%=FormatNumber(DateDiff("d",DateAdd("d",-1,vRegdate),Now()),0)%></strong>일째 함께 하고 있어요.</p>
			<p>텐바이텐의 감성이 담긴 총 <%=vItemCount%> 개의 상품 중<br />가장 많은 위시를 받은 상품은 <strong><%=vAllFavItem1%></strong> 와 <strong><%=vAllFavItem2%></strong>, 그리고 <strong><%=vAllFavItem3%></strong>도 있어요. : )<br />당신도 위시리스트를 시작해보세요. <a href="/my10x10/popularwish.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/btn_wishlist.png" alt="Wishlist" class="tMar04" /></a>
			<br />이미 <%=vFavTotCount%> 분이 위시를 담고 있답니다.
			</p>
			<p class="pad0">음, 텐바이텐 안에서 당신 또래의 친구들은 (<%=vMyAge%>)<br /><strong><%=vMyAgeItem1%></strong> 와 <strong><%=vMyAgeItem2%></strong> 을 가장 많이 구매하고 있어요!</p>
		</dd>
	<% End If %>
	<dd class="tPad10 tMar05 rt cr888">(2015.<%=vDayStandard%> 기준)</dd>
	<dd class="tPad30"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/txt3.png" alt="어때요? 당신을 늘 생각하고 고민하는 텐바이텐의 마음! 앞으로도 우리 친하게 지내요. : )" /></dd>
<% Else '### 로그인 안했을때 %>
	<dt>
		<img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/txt1-1.png" alt="당신과 텐바이텐," /><br /><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/txt2.png" alt="우리들의 이야기" class="tMar05" />
	</dt>
	<dd class="prsnlTxt">우리가 처음 만났던 날, <strong>****년 **월 **일</strong><br />벌써 <strong>**,***</strong>일째 함께 하고 있어요.</dd>
	<dd class="tPad30"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/txt4.png" alt="지금 로그인을 하고 함께 확인해볼까요? 당신을 기다릴게요." /></dd>
	<dd class="tPad30">
		<a href="/login/loginpage.asp?vType=G" class="btn btnS1 btnRed btnW100">로그인</a>
		<a href="/member/join.asp" class="btn btnS1 btnWhite btnW100">회원가입</a>
	</dd>
<% End If %>
</dl>

<%
Function fnAgeSexflag(a,s)
	Dim x, y
	If s = "1" Then
		y = "남성"
	Else
		y = "여성"
	End If
	
	If a>9 AND a<13 Then
		x = "A||10대 초반, " & y
	ElseIf a>12 AND a<17 Then
		x = "B||10대 중반, " & y
	ElseIf a>16 AND a<20 Then
		x = "C||10대 후반, " & y
	ElseIf a>19 AND a<23 Then
		x = "D||20대 초반, " & y
	ElseIf a>22 AND a<27 Then
		x = "E||20대 중반, " & y
	ElseIf a>26 AND a<30 Then
		x = "F||20대 후반, " & y
	ElseIf a>29 AND a<33 Then
		x = "G||30대 초반, " & y
	ElseIf a>32 AND a<37 Then
		x = "H||30대 중반, " & y
	ElseIf a>36 AND a<40 Then
		x = "I||30대 후반, " & y
	ElseIf a>39 AND a<43 Then
		x = "J||40대 초반, " & y
	ElseIf a>42 AND a<47 Then
		x = "K||40대 중반, " & y
	ElseIf a>46 AND a<50 Then
		x = "L||40대 후반, " & y
	ElseIf a>49 AND a<53 Then
		x = "M||50대 초반, " & y
	ElseIf a>52 AND a<57 Then
		x = "N||50대 중반, " & y
	ElseIf a>56 AND a<60 Then
		x = "O||50대 후반, " & y
	ElseIf a>59 Then
		x = "P||60대 이상, " & y
	Else
		x = "G||30대 초반, " & y
	End If

	fnAgeSexflag = x
End Function
%>