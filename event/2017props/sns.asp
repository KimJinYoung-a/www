<%
'####################################################
' Description : 2017 소품전 - SNS 공유 include
' History : 2017-03-28 이종화
'####################################################
Dim sCurrUrl , Etitle , Eurl , gTitle , snsHtml , Eimgurl
	sCurrUrl = Request.ServerVariables("url")
	'공유 문구 

	'Main page			-- 나만을 위한 소품이 가득한 곳! 15일동안 %! 
	'MD기획전			-- 15개의 테마별 상품을 매일매일 확인하세요!
	'출석체크			-- 하루에 한번 카드를 확인하면 피규어 친구가 찾아갑니다!
	'상품찾기이벤트		-- 매일매일 힌트를 확인하고, 텐바이텐 속 숨어있는 보물을 찾아보세요!
	'구매사은품			-- 선착순 한정수량! 생활 속 꼭 필요한 아이템이 사은품으로!
	'배송박스이벤트		-- 일상속에 스티커를 붙이고 인증샷을 찍어주세요! 

	'gTitle

	'1. 인덱스 페이지 제외 (title 없이 해주세요)
	'2. Welcome to 소품랜드
	'3. 내 친구를 소개합니다.
	'4. 숨은 보물 찾기
	'5. 구매사은품
	'6. 반짝반짝 내친구

	IF inStr(sCurrUrl,"index.asp")>0 Then '// 메인페이지
		Etitle = "나만을 위한 소품이 가득한 곳! 15일동안 30%! "
		Eurl   = ""
		gTitle = "소품전"
		Eimgurl= "http://webimage.10x10.co.kr/eventIMG/2017/77059/banMoList20170330174032.JPEG"
	ElseIf inStr(sCurrUrl,"sopumland.asp")>0 Then
		Etitle = "15개의 테마별 상품을 매일매일 확인하세요!"
		Eurl   = "sopumland.asp"
		gTitle = "Welcome to 소품랜드"
		Eimgurl= "http://webimage.10x10.co.kr/eventIMG/2017/77060/banMoList20170330121437.JPEG"
	ElseIf inStr(sCurrUrl,"friend.asp")>0 Then
		Etitle = "하루에 한번 카드를 확인하면 피규어 친구가 찾아갑니다!"
		Eurl   = "friend.asp"
		gTitle = "내 친구를 소개합니다."
		Eimgurl= "http://webimage.10x10.co.kr/eventIMG/2017/77061/banMoList20170330120655.JPEG"
	ElseIf inStr(sCurrUrl,"treasure.asp")>0 Then
		Etitle = "매일매일 힌트를 확인하고, 텐바이텐 속 숨어있는 보물을 찾아보세요!"
		Eurl   = "treasure.asp"
		gTitle = "숨은 보물 찾기"
		Eimgurl= "http://webimage.10x10.co.kr/eventIMG/2017/77062/banMoList20170330120640.JPEG"
	ElseIf inStr(sCurrUrl,"gift.asp")>0 Then
		Etitle = "선착순 한정수량! 생활 속 꼭 필요한 아이템이 사은품으로!"
		Eurl   = "gift.asp"
		gTitle = "완전 소중한 사은품"
		Eimgurl= "http://webimage.10x10.co.kr/eventIMG/2017/77063/banMoList20170330123402.JPEG"
	ElseIf inStr(sCurrUrl,"sticker.asp")>0 Then
		Etitle = "일상속에 스티커를 붙이고 인증샷을 찍어주세요!"
		Eurl   = "sticker.asp"
		gTitle = "반짝반짝 스티커"
		Eimgurl= "http://webimage.10x10.co.kr/eventIMG/2017/77064/banMoList20170330120626.JPEG"
	End If

	'// 페이지 타이틀 및 페이지 설명 작성 '// FB용 메타 테그
	strPageTitle = "텐바이텐 10X10 : "&gTitle							'페이지 타이틀 (필수)
	strPageDesc = Etitle												'페이지 설명
	strPageImage = Eimgurl												'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/event/2017props/"&	Eurl		'페이지 URL(SNS 퍼가기용)

dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle = Server.URLEncode("[텐바이텐] 이벤트 - "&Etitle)
	snpLink = Server.URLEncode("http://www.10x10.co.kr/event/2017props/"&Eurl)
	snpPre = Server.URLEncode("10x10 이벤트")

	'기본 태그
	snpTag = Server.URLEncode("텐바이텐")
	snpTag2 = Server.URLEncode("#10x10 #소품전")

	snsHtml = ""
	snsHtml = snsHtml &"<div class=""inner"">"
	snsHtml = snsHtml &"	<h3><img src=""http://webimage.10x10.co.kr/eventIMG/2017/sopum/common/tit_sns.png"" alt=""함께하는 즐거움, 텐바이텐 소품전을 공유해주세요!""/></h3>"
	snsHtml = snsHtml &"	<ul>"
	snsHtml = snsHtml &"		<li class=""facebook""><a href="""" title="""&gTitle&""" onclick=""popSNSPost('fb','"&snpTitle&"','"&snpLink&"','','');return false;""><img src=""http://webimage.10x10.co.kr/eventIMG/2017/sopum/common/btn_facebook.png"" alt=""페이스북 공유"" /></a></li>"
	snsHtml = snsHtml &"		<li class=""twitter""><a href="""" title="""&gTitle&""" onclick=""popSNSPost('tw','"&snpTitle&"','"&snpLink&"','"&snpPre&"','"&snpTag2&"'); return false;""><img src=""http://webimage.10x10.co.kr/eventIMG/2017/sopum/common/btn_twitter.png"" alt=""트위터 공유""/></a></li>"
	snsHtml = snsHtml &"	</ul>"
	snsHtml = snsHtml &"</div>"
%>


