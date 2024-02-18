<%@ language=vbscript %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/badgelib.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myTenbytenInfoCls.asp" -->
<%

dim returnStr, itemid, returnHTML
dim badgeTitle, badgeText, imgName, exImg
if IsUserLoginOK() and getEncLoginUserID() <> "" then
	returnStr = MyBadge_MyBadgeGetRecommandItem(getEncLoginUserID(), request("bidx"))
	if IsArray(returnStr) then
		if UBound(returnStr,2) >= 0 then
			if returnStr(0,0)>0 then
				itemid = returnStr(0,0)
				imgName = returnStr(1,0)
			end if

			Select Case request("bidx")
				Case "1"
					badgeTitle = "슈퍼 코멘터"
					badgeText = "슈퍼코멘터 인기상품후기에 민감해지자!"
				Case "2"
					badgeTitle = "포토 코멘터"
					badgeText = "인기 상품 포토후기 엿보기!"
				Case "3"
					badgeTitle = "얼리버드"
					badgeText = "얼리버드 당신에게 추천하는 텐바이텐 신상품!!"
				Case "4"
					badgeTitle = "텐텐트윅스"
					badgeText = "텐바이텐 회원을 위한 특별한 혜택!!"
				Case "5"
					badgeTitle = "세일헌터"
					badgeText = "세일헌터 당신이 놓치면 후회하는 세일상품"
				Case "6"
					badgeTitle = "브랜드 쿨"
					badgeText = "인기있는 브랜드 상품을 추천해드립니다."
				Case "7"
					badgeTitle = "카테고리 마스터"
					badgeText = "당신이 좋아할 만한 상품입니다."
				Case "8"
					badgeTitle = "위시 메이커"
					badgeText = "이 상품위시에 담아 보시겠어요?"
				Case "9"
					badgeTitle = "스타일리스트"
					badgeText = "스타일에 민감한 당신을 위한 추천상품"
				Case "10"
					badgeTitle = "컬러홀릭"
					badgeText = "컬러홀릭에게 추천하는 컬러상품"
				Case "11"
					badgeTitle = "톡! 엔젤"
					badgeText = "당신의 도움이 필요한 톡피플!!"
				Case "12"
					badgeTitle = "기프트초이스"
					badgeText = "가장인기있는 선물 상품을 소개합니다"
				Case "13"
					badgeTitle = "10월 스페셜 뱃지"
					badgeText = "11월, 12월 스페셜 뱃지에도 도전하세요!<br />2014년 1월, 시크릿 선물을 드립니다."
					exImg = "http://fiximage.10x10.co.kr/web2013/my10x10/img_get_badge_10month.gif"
				Case "14"
					badgeTitle = "11월 스페셜 뱃지"
					badgeText = "12월 스페셜 뱃지에도 도전하세요!<br />2014년 1월, 시크릿 선물을 드립니다."
					exImg = "http://fiximage.10x10.co.kr/web2013/my10x10/img_get_badge_11month.gif"
				Case "15"
					badgeTitle = "12월 스페셜 뱃지"
					badgeText = "2014년 1월, 시크릿 선물을 드립니다."
					exImg = "http://fiximage.10x10.co.kr/web2013/my10x10/img_get_badge_12month.gif"
				Case Else
					''
			End Select

			returnHTML = ""
			returnHTML = returnHTML + "<dl>"
			returnHTML = returnHTML + "	<dt>" + CStr(badgeTitle) + "</dt>"
			returnHTML = returnHTML + "	<dd>"
			returnHTML = returnHTML + "		<p>" + CStr(badgeText) + "</p>"
			if itemid>0 then
				returnHTML = returnHTML + "		<div class='pic'><a href='/shopping/category_prd.asp?itemid=" + CStr(itemid) + "' title='상품 페이지로 이동하기'><img src='" + CStr("http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(itemid) + "/" + imgName) + "' width='244px' height='244px' alt='추천상품' /></a></div>"
				returnHTML = returnHTML + "		<a href='javascript:jsGetRecommandItem(" + CStr(request("bidx")) + ");' class='refresh'>새로고침</a>"
			else
				'별도 이미지 표시
				returnHTML = returnHTML + "		<div class='pic'><img src='" & exImg & "' width='244px' height='244px' alt='" & badgeTitle & "' /></div>"
			end if
			returnHTML = returnHTML + "	</dd>"
			returnHTML = returnHTML + "</dl>"
		end if

		Set returnStr = Nothing
	end if

end if

%><%= returnHTML %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
