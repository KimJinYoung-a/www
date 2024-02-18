<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<%
Sub Alert_returnOrIndexTmp(strMSG)
	dim strTemp
	strTemp = "<script language='javascript'>" & vbCrLf 
	strTemp = strTemp & "alert('" & strMSG & "');" & vbCrLf 
	strTemp = strTemp & "document.referrer&&-1!=document.referrer.indexOf('10x10.co.kr')?history.back():location.href='http://www.10x10.co.kr';" & vbCrLf 
	strTemp = strTemp & "</script>"
	
	Response.Write strTemp
End Sub

'// 페이지 타이틀 및 페이지 설명 작성<input type="password" >
strPageTitle = "텐바이텐 10X10 : 브랜드 스트리트"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

dim makerid, catecode, recommendcount
	makerid = requestcheckvar(request("makerid"),32)
	
'// 파라메타 브랜드코드가 없을경우 팅겨냄
If (makerid="") or (makerid="-1") or (Len(makerid)=1) Then
	Call Alert_returnOrIndexTmp("브랜드코드가 없습니다.")
	dbget.close()	:	response.End
End If

dim sid, sidx, interview_idx, artistwork_idx, shop_event_idx, lookbook_idx, topmenudispyn
	sid = requestcheckvar(request("sid"),3)
	sidx = requestcheckvar(request("sidx"),10)		'/숫자 문자 모두 해당됨

topmenudispyn="N"

'/////////셀렉션 파라메터 타고 들어오는값 처리/////////
'파라메타 받아서 펼치는 설명서
'/인터뷰 : 			/street/street_brand.asp?makerid=ithinkso&sid=i&sidx=5
'/아티스트워크 : 	/street/street_brand.asp?makerid=ithinkso&sid=a&sidx=d
'/샵 : 				/street/street_brand.asp?makerid=ithinkso&sid=s_1
'/샵_콜렉션 : 		/street/street_brand.asp?makerid=ithinkso&sid=s_2
'/샵_이벤트 : 		/street/street_brand.asp?makerid=ithinkso&sid=s_3&sidx=3
'/룩북 : 			/street/street_brand.asp?makerid=ithinkso&sid=l&sidx=5
if lcase(sid)="i" then
	interview_idx=sidx
elseif lcase(sid)="t" then
elseif lcase(sid)="a" then
	artistwork_idx=sidx
elseif lcase(sid)="s_1" then
elseif lcase(sid)="s_2" then
elseif lcase(sid)="s_3" then
	shop_event_idx=sidx
elseif lcase(sid)="l" then
	lookbook_idx=sidx
else
	sid="" : sidx=""
end if
'/////////셀렉션 파라메터 타고 들어오는값 처리/////////

'########################## 브랜드 매뉴 권한 셋팅 ############################
'/각매뉴 권한
dim hello_confirm, interview_confirm, tenbytenand_confirm, artistwork_confirm, shop_collection_confirm, shop_event_confirm, lookbook_confirm
'/각매뉴 존재여부 카운트
dim hello_cnt, interview_cnt, tenbytenand_cnt, artistwork_cnt, shop_collection_cnt, shop_event_cnt, lookbook_cnt
'/각매뉴 실제 오픈여부
dim hello_yn, interview_yn, tenbytenand_yn, artistwork_yn, shop_collection_yn, shop_event_yn, lookbook_yn
dim brandgubun, socname, socname_kor, omenu, shop_event_one, shop_event_one_code
	hello_yn="N" : interview_yn="N" : tenbytenand_yn="N" : artistwork_yn="N" : shop_collection_yn="N" : shop_event_yn="N" : lookbook_yn="N"
	hello_cnt=0 : interview_cnt=0 : tenbytenand_cnt=0 : artistwork_cnt=0 : shop_collection_cnt=0 : shop_event_cnt=0 : lookbook_cnt=0
set omenu = new cmanager
	omenu.frectmakerid = makerid

	if makerid<>"" then
		omenu.sbbrandgubunlist
	end if

	if omenu.Ftotalcount > 0 then
		brandgubun = omenu.FOneItem.fbrandgubun
		socname = omenu.FOneItem.fsocname
		socname_kor = omenu.FOneItem.fsocname_kor
		hello_confirm = omenu.FOneItem.fhello_yn
		catecode	= omenu.FOneItem.FCatecode
		recommendcount	= omenu.FOneItem.FRecommendcount
			if hello_confirm="Y" then
				hello_cnt = Gethello_totalcnt(makerid)
				if hello_cnt>0 then
					hello_yn="Y"
				end if
			end if
		interview_confirm = omenu.FOneItem.finterview_yn
			if interview_confirm="Y" then
				interview_cnt = Getinterview_totalcnt(makerid)
				if interview_cnt>0 then
					interview_yn="Y"
				end if
			end if
		tenbytenand_confirm = omenu.FOneItem.ftenbytenand_yn
			if tenbytenand_confirm="Y" then
				tenbytenand_cnt = Gettenbytenand_totalcnt(makerid)
				if tenbytenand_cnt>0 then
					tenbytenand_yn="Y"
				end if
			end if
		artistwork_confirm = omenu.FOneItem.fartistwork_yn
			if artistwork_confirm="Y" then
				artistwork_cnt = GetGallery_totalcnt(makerid, "", "Y")
				if artistwork_cnt>0 then
					artistwork_yn="Y"
				end if
			end if
		shop_collection_confirm = omenu.FOneItem.fshop_collection_yn
			if shop_collection_confirm="Y" then
				shop_collection_cnt = Getshop_collection_totalcnt(makerid)
				if shop_collection_cnt>0 then
					shop_collection_yn="Y"
				end if
			end if
		shop_event_confirm = omenu.FOneItem.fshop_event_yn
			if shop_event_confirm="Y" then
				shop_event_cnt = Getshop_event_totalcnt(makerid,"16")
				if shop_event_cnt>0 then
					shop_event_yn="Y"
					
					shop_event_one = Getshop_event_one(makerid,"16")
					if isarray( split(shop_event_one,"!@#") ) then
						shop_event_one_code = split(shop_event_one,"!@#")(1)
						shop_event_one = split(shop_event_one,"!@#")(0)
					end if
				end if
			end if
		lookbook_confirm = omenu.FOneItem.flookbook_yn
			if lookbook_confirm="Y" then
				lookbook_cnt = Getlookbook_totalcnt(makerid)
				if lookbook_cnt>0 then
					lookbook_yn="Y"
				end if
			end if
	else
	    response.write "<script type='text/javascript' src='/common/addlog.js?tp=noresult&ror="&server.UrlEncode(Request.serverVariables("HTTP_REFERER"))&"'></script>"
		Call Alert_returnOrIndexTmp("삭제된 브랜드 이거나, 존재하지 않는 브랜드입니다.")
		dbget.close()	:	response.End
	end if
set omenu = nothing
'########################## 브랜드 매뉴 권한 셋팅 ############################

If hello_yn = "Y" Then
	Dim ohello
	Dim subtopimage, bgImageURL, StoryTitle, StoryContent, philosophyTitle, philosophyContent, designis
	Dim bookmark1SiteName, bookmark1SiteURL, bookmark1SiteDetail, bookmark2SiteName, bookmark2SiteURL, bookmark2SiteDetail, bookmark3SiteName, bookmark3SiteURL, bookmark3SiteDetail
	Dim brandTag, samebrand
	SET ohello = new cHello
		ohello.FRectMakerid = makerid
		ohello.sbHellolist

		subtopimage				= ohello.FOneItem.FSubtopimage				'프리미엄일 때 가운데 이미지
		bgImageURL				= ohello.FOneItem.FBgImageURL				'Hello 메뉴에서 등록한 백그라운드 이미지
		StoryTitle				= ohello.FOneItem.FStoryTitle				'Hello 스토리 타이틀
		StoryContent			= ohello.FOneItem.FStoryContent				'Hello 스토리 내용
		philosophyTitle			= ohello.FOneItem.FPhilosophyTitle			'Hello 필로소피 타이틀
		philosophyContent		= ohello.FOneItem.FPhilosophyContent		'Hello 필로소피 내용
		designis				= ohello.FOneItem.FDesignis					'Hello DesignIS
		bookmark1SiteName		= ohello.FOneItem.FBookmark1SiteName		'브랜드 북마크1 사이트명
		bookmark1SiteURL		= ohello.FOneItem.FBookmark1SiteURL			'브랜드 북마크1 사이트URL
		bookmark1SiteDetail		= ohello.FOneItem.FBookmark1SiteDetail		'브랜드 북마크1 내용
		bookmark2SiteName		= ohello.FOneItem.FBookmark2SiteName		'브랜드 북마크2 사이트명
		bookmark2SiteURL		= ohello.FOneItem.FBookmark2SiteURL			'브랜드 북마크2 사이트URL
		bookmark2SiteDetail		= ohello.FOneItem.FBookmark2SiteDetail		'브랜드 북마크2 내용	
		bookmark3SiteName		= ohello.FOneItem.FBookmark3SiteName		'브랜드 북마크3 사이트명
		bookmark3SiteURL		= ohello.FOneItem.FBookmark3SiteURL			'브랜드 북마크3 사이트URL
		bookmark3SiteDetail		= ohello.FOneItem.FBookmark3SiteDetail		'브랜드 북마크3 내용
		brandTag				= ohello.FOneItem.FBrandTag					'브랜드 TAG
		samebrand				= ohello.FOneItem.FSamebrand				'연관브랜드
	Set ohello = nothing
End If

Dim LoginUserid
Dim isMyFavBrand: isMyFavBrand=false
LoginUserid = getLoginUserid()
If IsUserLoginOK then
	isMyFavBrand = getIsMyFavBrand(LoginUserid, makerid)
End If

'//탑매뉴 노출여부
if hello_yn="Y" or interview_yn="Y" or artistwork_yn="Y" or lookbook_yn="Y" then		'or shop_collection_yn="Y" or shop_event_yn="Y"
	topmenudispyn="Y"
end if

dim refer
	refer = request.ServerVariables("HTTP_REFERER")
%>