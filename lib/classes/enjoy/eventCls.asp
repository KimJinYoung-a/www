<%
'----------------------------------------------------
' ClsEvtCont : 이벤트 내용
'----------------------------------------------------
Class ClsEvtCont
	public FECode   '이벤트 코드
	public FEGCode
   	public FEGPCode

	public FEKind
	public FEManager
	public FEScope
	public FEName
	public FESDate
	public FEEDate
	public FEState
	public FERegdate
	public FEPDate
	public FECategory
	public FECateMid
	public FSale
	public FGift
	public FCoupon
	public FComment
	public FBlogURL
	public FBBS
	public FItemeps
	public FApply
	public FTemplate
	public FEMimg
	public FEHtml
	public FItemsort
	public FBrand
	public FGimg
	public FFullYN
	public FIteminfoYN
	public frectekind
	public FFBAppid
	public FFBcontent
	public FBimg
	public FFavCnt
	public FEDispCate
	public FEWideYN
	public FEItemID
	public FEItemImg
	public Fbasicimg600
	public Fbasicimg
	Public FevtFile
	Public FevtFileyn

	Public FItempriceYN '상품 가격
	Public FDateViewYN

	'//2015 리뉴얼추가
	Public Fisweb
	Public Fismobile
	Public Fisapp
	public FEmolistbanner '//모바일 리스트 이미지 PC에도 쓸 예정
	public FEvt_subcopyK '//PC용 서브카피

	Public FEsgroup_w

	Public FESlide_W_Flag '//슬라이드 템플릿 PC flag
	Public Fevt_pc_addimg_cnt '//이벤트 추가 이미지 카운트

	public FSidx 
	public FStopimg
	public FSbtmYN
	public FSbtmimg
	public FSbtmcode
	public FStopaddimg 
	public FSbtmaddimg
	public FSpcadd1
	public FSgubun
	public FevtType
	public Ftitle_pc

	'MD등록 이벤트 추가
	public Fmdtheme
	public Fthemecolor
	public Ftextbgcolor
	public Fmdbntype
	public Fcomm_isusing
	public Fcomm_text
	public Ffreebie_img
	public Fcomm_start
	public Fcomm_end
	public Feval_isusing
	public Feval_text
	public Feval_freebie_img
	public Feval_start
	public Feval_end
	public Fgift_isusing
	public Fgift_text1
	public Fgift_img1
	public Fgift_text2
	public Fgift_img2
	public Fgift_text3
	public Fgift_img3
	public Fusinginfo
	public Fusing_text1
	public Fusing_contents1
	public Fusing_text2
	public Fusing_contents2
	public Fusing_text3
	public Fusing_contents3
	public FsalePer
	public FsaleCPer
	public FendlessView
	public FSocName_Kor
	public Feventtype_pc
	public FvideoFullLink
	public FvideoType
	public FBrandName
	public FBrandContents
	public FGroupItemPriceView
	public FGroupItemCheck
	Public FDevice
	public FGroupItemType
	public FMenuIDX
	public Fboard_isusing
	public Fboard_text
	public Fboard_freebie_img
	public Fboard_start
	public Fboard_end
	public FcontentsAlign
	public FisOnlyTen
	public FisOnePlusOne
	public FisNew
	public FCopyHide
	public Fevt_tag

	public Function fnEventColorCode
		If FECode > "79054" Then
			If Fthemecolor="1" Then
				fnEventColorCode = "#ed6c6c"
			ElseIf Fthemecolor="2" Then
				fnEventColorCode = "#f385af"
			ElseIf Fthemecolor="3" Then
				fnEventColorCode = "#f3a056"
			ElseIf Fthemecolor="4" Then
				fnEventColorCode = "#e7b93c"
			ElseIf Fthemecolor="5" Then
				fnEventColorCode = "#8eba4a"
			ElseIf Fthemecolor="6" Then
				fnEventColorCode = "#43a251"
			ElseIf Fthemecolor="7" Then
				fnEventColorCode = "#50bdd1"
			ElseIf Fthemecolor="8" Then
				fnEventColorCode = "#5aa5ea"
			ElseIf Fthemecolor="9" Then
				fnEventColorCode = "#2672bf"
			ElseIf Fthemecolor="10" Then
				fnEventColorCode = "#2c5a85"
			ElseIf Fthemecolor="11" Then
				fnEventColorCode = "#848484"
			ElseIf Fthemecolor="12" Then
				fnEventColorCode = "#848484"
			Else
				fnEventColorCode = "#848484"
			End If
		Else
			If Fthemecolor="1" Then
				fnEventColorCode = "#c80e0e"
			ElseIf Fthemecolor="2" Then
				fnEventColorCode = "#274e87"
			ElseIf Fthemecolor="3" Then
				fnEventColorCode = "#9457a1"
			ElseIf Fthemecolor="4" Then
				fnEventColorCode = "#ea5b8d"
			ElseIf Fthemecolor="5" Then
				fnEventColorCode = "#e24343"
			ElseIf Fthemecolor="6" Then
				fnEventColorCode = "#9b613d"
			ElseIf Fthemecolor="7" Then
				fnEventColorCode = "#f08527"
			ElseIf Fthemecolor="8" Then
				fnEventColorCode = "#5eb041"
			ElseIf Fthemecolor="9" Then
				fnEventColorCode = "#209f6e"
			ElseIf Fthemecolor="10" Then
				fnEventColorCode = "#e4569c"
			ElseIf Fthemecolor="11" Then
				fnEventColorCode = "#3593d4"
			Else
				fnEventColorCode = "#ffffff"
			End If
		End If
	End Function

	public Function fnEventBarColorCode
		If FECode > "79054" Then
			If Fmdtheme<>"4" Then
				If Fthemecolor="1" Then
					fnEventBarColorCode = "#cb4848"
				ElseIf Fthemecolor="2" Then
					fnEventBarColorCode = "#d55787"
				ElseIf Fthemecolor="3" Then
					fnEventBarColorCode = "#e37f35"
				ElseIf Fthemecolor="4" Then
					fnEventBarColorCode = "#ce8d00"
				ElseIf Fthemecolor="5" Then
					fnEventBarColorCode = "#699426"
				ElseIf Fthemecolor="6" Then
					fnEventBarColorCode = "#358240"
				ElseIf Fthemecolor="7" Then
					fnEventBarColorCode = "#2899ae"
				ElseIf Fthemecolor="8" Then
					fnEventBarColorCode = "#2f7cc3"
				ElseIf Fthemecolor="9" Then
					fnEventBarColorCode = "#145290"
				ElseIf Fthemecolor="10" Then
					fnEventBarColorCode = "#1c3e5d"
				ElseIf Fthemecolor="11" Then
					fnEventBarColorCode = "#656565"
				Else
					fnEventBarColorCode = "#656565"
				End If
			else
				If Fthemecolor="1" Then
					fnEventBarColorCode = "#c80e0e"
				ElseIf Fthemecolor="2" Then
					fnEventBarColorCode = "#274e87"
				ElseIf Fthemecolor="3" Then
					fnEventBarColorCode = "#9457a1"
				ElseIf Fthemecolor="4" Then
					fnEventBarColorCode = "#ea5b8d"
				ElseIf Fthemecolor="5" Then
					fnEventBarColorCode = "#e24343"
				ElseIf Fthemecolor="6" Then
					fnEventBarColorCode = "#9b613d"
				ElseIf Fthemecolor="7" Then
					fnEventBarColorCode = "#f08527"
				ElseIf Fthemecolor="8" Then
					fnEventBarColorCode = "#5eb041"
				ElseIf Fthemecolor="9" Then
					fnEventBarColorCode = "#209f6e"
				ElseIf Fthemecolor="10" Then
					fnEventBarColorCode = "#e4569c"
				ElseIf Fthemecolor="11" Then
					fnEventBarColorCode = "#3593d4"
				ElseIf Fthemecolor="12" Then
					fnEventBarColorCode = "#ff427c"
				ElseIf Fthemecolor="13" Then
					fnEventBarColorCode = "#4d96fd"
				ElseIf Fthemecolor="14" Then
					fnEventBarColorCode = "#ff2977"
				ElseIf Fthemecolor="15" Then
					fnEventBarColorCode = "#018fec"
				ElseIf Fthemecolor="16" Then
					fnEventBarColorCode = "#004ae1"
				ElseIf Fthemecolor="17" Then
					fnEventBarColorCode = "#ff664e"
				ElseIf Fthemecolor="18" Then
					fnEventBarColorCode = "#4ecbc0"
				ElseIf Fthemecolor="19" Then
					fnEventBarColorCode = "#58d82a"
				ElseIf Fthemecolor="20" Then
					fnEventBarColorCode = "#a5447d"
				ElseIf Fthemecolor="21" Then
					fnEventBarColorCode = "#e784a2"
				ElseIf Fthemecolor="22" Then
					fnEventBarColorCode = "#4b6182"
				ElseIf Fthemecolor="23" Then
					fnEventBarColorCode = "#d88664"
				ElseIf Fthemecolor="24" Then
					fnEventBarColorCode = "#d84950"
				ElseIf Fthemecolor="25" Then
					fnEventBarColorCode = "#1e4c54"
				ElseIf Fthemecolor="26" Then
					fnEventBarColorCode = "#ff7e45"
				ElseIf Fthemecolor="27" Then
					fnEventBarColorCode = "#a2b72e"
				Else
					fnEventBarColorCode = "#656565"
				End If
			end if
		Else
			If Fmdtheme="1" Then
				If Fthemecolor="1" Then
					fnEventBarColorCode = "#f5742f"
				ElseIf Fthemecolor="2" Then
					fnEventBarColorCode = "#e2b500"
				ElseIf Fthemecolor="3" Then
					fnEventBarColorCode = "#6db003"
				ElseIf Fthemecolor="4" Then
					fnEventBarColorCode = "#79811"
				ElseIf Fthemecolor="5" Then
					fnEventBarColorCode = "#0e6d78"
				ElseIf Fthemecolor="6" Then
					fnEventBarColorCode = "#209ed2"
				ElseIf Fthemecolor="7" Then
					fnEventBarColorCode = "#1e5dd0"
				ElseIf Fthemecolor="8" Then
					fnEventBarColorCode = "#1e3b8e"
				ElseIf Fthemecolor="9" Then
					fnEventBarColorCode = "#7653ce"
				ElseIf Fthemecolor="10" Then
					fnEventBarColorCode = "#e4569c"
				Else
					fnEventBarColorCode = "#656565"
				End If
			ElseIf Fmdtheme="2" Then
				If Fthemecolor="1" Then
					fnEventBarColorCode = "#c80e0e"
				ElseIf Fthemecolor="2" Then
					fnEventBarColorCode = "#274e87"
				ElseIf Fthemecolor="3" Then
					fnEventBarColorCode = "#9457a1"
				ElseIf Fthemecolor="4" Then
					fnEventBarColorCode = "#ea5b8d"
				ElseIf Fthemecolor="5" Then
					fnEventBarColorCode = "#e24343"
				ElseIf Fthemecolor="6" Then
					fnEventBarColorCode = "#9b613d"
				ElseIf Fthemecolor="7" Then
					fnEventBarColorCode = "#f08527"
				ElseIf Fthemecolor="8" Then
					fnEventBarColorCode = "#5eb041"
				ElseIf Fthemecolor="9" Then
					fnEventBarColorCode = "#209f6e"
				ElseIf Fthemecolor="10" Then
					fnEventBarColorCode = "#e4569c"
				ElseIf Fthemecolor="11" Then
					fnEventBarColorCode = "#3593d4"
				Else
					fnEventBarColorCode = "#656565"
				End If
			Else
				If Fthemecolor="1" Then
					fnEventBarColorCode = "#2e2e2e"
				ElseIf Fthemecolor="2" Then
					fnEventBarColorCode = "#102d58"
				ElseIf Fthemecolor="3" Then
					fnEventBarColorCode = "#5d2869"
				ElseIf Fthemecolor="4" Then
					fnEventBarColorCode = "#bf1f57"
				ElseIf Fthemecolor="5" Then
					fnEventBarColorCode = "#b01b1b"
				ElseIf Fthemecolor="6" Then
					fnEventBarColorCode = "#693718"
				ElseIf Fthemecolor="7" Then
					fnEventBarColorCode = "#df5834"
				ElseIf Fthemecolor="8" Then
					fnEventBarColorCode = "#267909"
				ElseIf Fthemecolor="9" Then
					fnEventBarColorCode = "#26941"
				ElseIf Fthemecolor="10" Then
					fnEventBarColorCode = "#007c7e"
				ElseIf Fthemecolor="11" Then
					fnEventBarColorCode = "#0c69aa"
				Else
					fnEventBarColorCode = "#656565"
				End If
			End If
		End If
	End Function

	public Function fnEventColorImgCode
		If Fthemecolor="12" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_1.jpg"
		ElseIf Fthemecolor="13" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_2.jpg"
		ElseIf Fthemecolor="14" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_3.jpg"
		ElseIf Fthemecolor="15" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_4.jpg"
		ElseIf Fthemecolor="16" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_5.jpg"
		ElseIf Fthemecolor="17" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_6.jpg"
		ElseIf Fthemecolor="18" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_7.jpg"
		ElseIf Fthemecolor="19" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_8.jpg"
		ElseIf Fthemecolor="20" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_9.jpg"
		ElseIf Fthemecolor="21" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_10.jpg"
		ElseIf Fthemecolor="22" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_11.jpg"
		ElseIf Fthemecolor="23" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_12.jpg"
		ElseIf Fthemecolor="24" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_13.jpg"
		ElseIf Fthemecolor="25" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_14.jpg"
		ElseIf Fthemecolor="26" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_15.jpg"
		ElseIf Fthemecolor="27" Then
			fnEventColorImgCode = "http://fiximage.10x10.co.kr/web2018/event/bg_grd_16.jpg"
		Else
			fnEventColorImgCode = ""
		End If
	End Function

	public Function fnEventThemeColorCode
		If Fthemecolor="1" Then
			fnEventThemeColorCode = "#ed6c6c"
		ElseIf Fthemecolor="2" Then
			fnEventThemeColorCode = "#f385af"
		ElseIf Fthemecolor="3" Then
			fnEventThemeColorCode = "#f3a056"
		ElseIf Fthemecolor="4" Then
			fnEventThemeColorCode = "#e7b93c"
		ElseIf Fthemecolor="5" Then
			fnEventThemeColorCode = "#8eba4a"
		ElseIf Fthemecolor="6" Then
			fnEventThemeColorCode = "#43a251"
		ElseIf Fthemecolor="7" Then
			fnEventThemeColorCode = "#50bdd1"
		ElseIf Fthemecolor="8" Then
			fnEventThemeColorCode = "#5aa5ea"
		ElseIf Fthemecolor="9" Then
			fnEventThemeColorCode = "#2672bf"
		ElseIf Fthemecolor="10" Then
			fnEventThemeColorCode = "#2c5a85"
		ElseIf Fthemecolor="11" Then
			fnEventThemeColorCode = "#848484"
		ElseIf Fthemecolor="12" Then
			fnEventThemeColorCode = "#ff427c"
		ElseIf Fthemecolor="13" Then
			fnEventThemeColorCode = "#4d96fd"
		ElseIf Fthemecolor="14" Then
			fnEventThemeColorCode = "#ff2977"
		ElseIf Fthemecolor="15" Then
			fnEventThemeColorCode = "#018fec"
		ElseIf Fthemecolor="16" Then
			fnEventThemeColorCode = "#004ae1"
		ElseIf Fthemecolor="17" Then
			fnEventThemeColorCode = "#ff664e"
		ElseIf Fthemecolor="18" Then
			fnEventThemeColorCode = "#4ecbc0"
		ElseIf Fthemecolor="19" Then
			fnEventThemeColorCode = "#58d82a"
		ElseIf Fthemecolor="20" Then
			fnEventThemeColorCode = "#a5447d"
		ElseIf Fthemecolor="21" Then
			fnEventThemeColorCode = "#e784a2"
		ElseIf Fthemecolor="22" Then
			fnEventThemeColorCode = "#4b6182"
		ElseIf Fthemecolor="23" Then
			fnEventThemeColorCode = "#d88664"
		ElseIf Fthemecolor="24" Then
			fnEventThemeColorCode = "#d84950"
		ElseIf Fthemecolor="25" Then
			fnEventThemeColorCode = "#1e4c54"
		ElseIf Fthemecolor="26" Then
			fnEventThemeColorCode = "#ff7e45"
		ElseIf Fthemecolor="27" Then
			fnEventThemeColorCode = "#a2b72e"
		Else
			fnEventThemeColorCode = "#656565"
		End If
	End Function

	'// 이벤트 유형 변환
	public Function fnEventTypeName
		Select Case FevtType
			Case "10":  fnEventTypeName = "A"
			Case "20":  fnEventTypeName = "B"
			Case "30":  fnEventTypeName = "C"
			Case "40":  fnEventTypeName = "D"
			Case "70":  fnEventTypeName = "E"
			Case "60":  fnEventTypeName = "F"
			Case "50":  fnEventTypeName = "G"
			Case "80":  fnEventTypeName = "H"
			Case Else : fnEventTypeName = ""
		end Select
	end function

	'##### 이벤트 내용 ######
	public Function fnGetEvent
		Dim strSql
		IF 	FECode = "" THEN Exit Function
		FGimg = ""
		strSql ="[db_event].[dbo].[usp_WWW_Event_ContentsView_Get] ("&FECode&")"
'		Response.write strSql
'		Response.end
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				FECode		= rsget("evt_code")
				FEKind		= rsget("evt_kind")
				FEManager 	= rsget("evt_manager")
				FEScope 	= rsget("evt_scope")
				FEName 		= db2html(rsget("evt_name"))
				FESDate 	= rsget("evt_startdate")
				FEEDate 	= rsget("evt_enddate")
				FEState 	= rsget("evt_state")
				FERegdate 	= rsget("evt_regdate")
				FEPDate  	= rsget("evt_prizedate")
   				FECategory 	= rsget("evt_category")
   				FECateMid 	= rsget("evt_cateMid")
   				FSale 		= rsget("issale")
   				FGift 		= rsget("isgift")
   				FCoupon   	= rsget("iscoupon")
   				FComment 	= rsget("iscomment")
   				FBlogURL	= rsget("isGetBlogURL")
   				FBBS	 	= rsget("isbbs")
   				FItemeps 	= rsget("isitemps")
				FisOnlyTen	= rsget("isOnlyTen")
				FisOnePlusOne = rsget("isonePlusone")
				FisNew 		= rsget("isNew")
   				FApply 		= rsget("isapply")
   				FTemplate 	= rsget("evt_template")
   				FEMimg 		= rsget("evt_mainimg")
   				FEHtml 		= db2html(rsget("evt_html"))
   				FItemsort 	= rsget("evt_itemsort")
   				FBrand 		= db2html(rsget("brand"))
				FSocName_Kor= db2html(rsget("socname_kor"))
   				IF FGift THEN FGimg		= rsget("evt_giftimg")
   				FFullYN		= rsget("evt_fullYN")
   				FIteminfoYN	= rsget("evt_iteminfoYN")
   				FFBAppid	= rsget("fb_appid")
   				FFBcontent	= rsget("fb_content")
   				FBimg		= rsget("evt_bannerimg")
   				FItempriceYN	= rsget("evt_itempriceyn")
   				FFavCnt		= rsget("favCnt")
   				FEWideYN	= rsget("evt_wideyn")
   				FEItemID	= rsget("etc_itemid")
   				FEItemImg	= rsget("etc_itemimg")
   				Fbasicimg600 = rsget("basicimage600")
   				Fbasicimg	= rsget("basicimage")
   				If rsget("evt_dispCate") = 0 Then
   					FEDispCate	= ""
   				Else
   					FEDispCate	= rsget("evt_dispCate")
   				End If
   				FDateViewYN = rsget("evt_dateview")

				FevtFile			= rsget("evt_execFile")
				FevtFileyn			= rsget("evt_isExec")
				Fisweb				= rsget("isweb")
				Fismobile			= rsget("ismobile")
				Fisapp				= rsget("isapp")
				FEmolistbanner		= rsget("evt_mo_listbanner")
				FEvt_subcopyK		= rsget("evt_subcopyK")

				FESlide_W_Flag       = rsget("evt_slide_w_flag")
				Fevt_pc_addimg_cnt       = rsget("evt_pc_addimg_cnt")

				FEsgroup_w		= rsget("evt_sgroup_w") '// 이벤트 랜덤 코드
				
				FsalePer = rsget("salePer")
				FsaleCPer = rsget("saleCPer")
				Fmdtheme = rsget("mdtheme")
				Fthemecolor = rsget("themecolor")
				Ftextbgcolor = rsget("textbgcolor")
				Fmdbntype = rsget("mdbntype")
				Fcomm_isusing = rsget("comm_isusing")
				Fcomm_text = rsget("comm_text")
				Ffreebie_img = rsget("freebie_img")
				Fcomm_start = rsget("comm_start")
				Fcomm_end = rsget("comm_end")
				Fgift_isusing = rsget("gift_isusing")
				Fgift_text1 = rsget("gift_text1")
				Fgift_img1 = rsget("gift_img1")
				Fgift_text2 = rsget("gift_text2")
				Fgift_img2 = rsget("gift_img2")
				Fgift_text3 = rsget("gift_text3")
				Fgift_img3 = rsget("gift_img3")
				Fusinginfo = rsget("usinginfo")
				Fusing_text1 = rsget("using_text1")
				Fusing_contents1 = rsget("using_contents1")
				Fusing_text2 = rsget("using_text2")
				Fusing_contents2 = rsget("using_contents2")
				Fusing_text3 = rsget("using_text3")
				Fusing_contents3 = rsget("using_contents3")
				FevtType = rsget("evt_type")
				Ftitle_pc = rsget("title_pc")
				FendlessView = rsget("endlessView")
				Feventtype_pc = rsget("eventtype_pc")
				Feval_isusing = rsget("eval_isusing")
				Feval_text = rsget("eval_text")
				Feval_freebie_img = rsget("eval_freebie_img")
				Feval_start = rsget("eval_start")
				Feval_end = rsget("eval_end")
				FvideoFullLink = rsget("videoFullLink")
				FvideoType = rsget("videoType")
				FBrandName = rsget("BrandName")
				FBrandContents = rsget("BrandContents")
				FGroupItemPriceView = rsget("GroupItemPriceView")
				FGroupItemCheck = rsget("GroupItemCheck")
				FGroupItemType = rsget("GroupItemType")
				Fboard_isusing = rsget("board_isusing")
				Fboard_text = rsget("board_text")
				Fboard_freebie_img = rsget("board_freebie_img")
				Fboard_start = rsget("board_start")
				Fboard_end = rsget("board_end")
				FcontentsAlign = rsget("contentsAlign")
				FGroupItemType = rsget("GroupItemType")
				FCopyHide = rsget("videoType")
				Fevt_tag = rsget("evt_tag")
   			ELSE
   				FECode = ""
			END IF
		rsget.close
	END Function

	'##### 그룹 내용 ######
	public Function fnGetEventGroup
		Dim strSql
		IF  FEGCode = "" THEN FEGCode = 0
		strSql ="[db_event].[dbo].sp_Ten_eventitem_group("&FECode&","&FEGCode&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetEventGroup = rsget.getRows()
		END IF
		rsget.close
	End Function

	public Function fnGetEventGpcode0
		Dim strSql
		IF  FEGCode = "" THEN FEGCode = 0
		strSql ="[db_event].[dbo].sp_Ten_eventitem_grouppcode0("&FECode&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetEventGpcode0 = rsget.getRows()
		END IF
		rsget.close
	End Function

	'//그룹형 랜덤 1개
	public Function fnGetEventGroupTop
		Dim strSql
		IF  FEGCode = "" THEN FEGCode = 0
		strSql ="[db_event].[dbo].sp_Ten_eventitem_group_top1("&FECode&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetEventGroupTop = rsget.getRows()
		END IF
		rsget.close
	End Function

	'##### 최근리스트 10개 ######
	public Function fnGetRecentEvt
		Dim strSql
		strSql ="exec [db_event].[dbo].sp_Ten_event_top_list '"&FECategory&"'"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetRecentEvt = rsget.GetRows()
		END IF
		rsget.close
	End Function
	
	''최근리스트 _캐시 /2015/04/03
	public Function fnGetRecentEvt_Cache
		Dim strSql
		strSql ="exec [db_event].[dbo].sp_Ten_event_top_list '"&FECategory&"'"
		''rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"EVTRCT",strSql,60*5)
        if (rsMem is Nothing) then Exit function ''추가

		IF Not (rsMem.EOF OR rsMem.BOF) THEN
			fnGetRecentEvt_Cache = rsMem.GetRows()
		END IF
		rsMem.close
	End Function
	
	'///브랜드데이 최근리스트 20090323 한용민추가 '/street/index.asp
	public Function fngetbrandday
		Dim strSql
		strSql ="[db_event].[dbo].sp_Ten_event_brandday "
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fngetbrandday = rsget.GetRows()
		END IF
		rsget.close
	End Function	

	'///브랜드데이총리스트 20090423 한용민추가 '/street/street_brandday.asp
	public Function fngetbrandday_list
		Dim strSql
		strSql ="[db_event].[dbo].sp_Ten_event_brandday_all "
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fngetbrandday_list = rsget.GetRows()
		END IF
		rsget.close
	End Function

	'// 브랜드데이인지 체크 20090324 한용민추가  '/street/street_brandday.asp
    public Function fngetbranddaycheck	
        dim SqlStr

		SqlStr ="[db_event].[dbo].sp_Ten_event_brandday_all "
		
		'response.write sqlStr&"<br>" 
		rsget.Open SqlStr, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		        
        if rsget.Eof then
			response.write "<script>"
			response.write "alert('브랜드데이 이벤트가 아니거나 종료된 이벤트 입니다');"
			response.write "history.go(-1);"	
			response.write "</script>"
			dbget.close()	:	response.End                                 
        end if
        rsget.close
    end Function

	'//기프트 플러스용 '/giftplus/giftplus_event.asp 2010.04.06 한용민 추가
	public Function fnGetRedRibbonRecentCode
		Dim strSql
		
		strSql ="[db_giftplus].[dbo].ten_giftplus_RecentEvent ('"&frectekind&"') "
		
		'response.write strSql &"<br>"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				FECode		= rsget("evt_code")
				FEKind		= rsget("evt_kind")
   			ELSE
   				FECode = ""
   				FEKind = ""
			END IF
		rsget.close
	End Function

	'// 슬라이드 템플릿 
	public Function fnGetSlideTemplate_main
		Dim strSql
		IF FECode = "" THEN Exit Function
		strSql = "[db_event].[dbo].[sp_Ten_event_slidetemplate] ("&FECode&", 'W')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				FSidx		= rsget("idx")
				FStopimg	= rsget("topimg")
				FSbtmYN		= rsget("btmYN")
				FSbtmimg	= rsget("btmimg")
				FSbtmcode	= rsget("btmcode")
				FStopaddimg	= rsget("topaddimg")
				FSbtmaddimg = rsget("btmaddimg")
				FSpcadd1	= rsget("pcadd1")
				FSgubun		= rsget("gubun")
   			ELSE
   				FSidx		= ""
				FStopimg	= ""
				FSbtmYN		= ""
				FSbtmimg	= ""
				FSbtmcode	= ""
				FStopaddimg = ""
				FSbtmaddimg = ""
				FSpcadd1	= ""
				FSgubun		= ""
			END IF
		rsget.close
	END Function

	public Function fnGetSlideTemplate_sub
		Dim strSql
		If FECode = "" THEN Exit Function
		strSql ="[db_event].[dbo].[sp_Ten_event_slidetemplate_addimg] ("&FECode&", 'W')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetSlideTemplate_sub = rsget.GetRows()
		Else
			
		END IF
		rsget.close
	End Function

	'// 이벤트 PC 추가 배너
	Public Function fnGetPCAddimg
		Dim strSql
		If FECode = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_PCaddimg_Get] ("&FECode&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetPCAddimg = rsget.GetRows()
		END IF
		rsget.close
	End Function

	'// 관련 기획전 PC 추가
	public Function fnAnotherEventListGet
		Dim strSql
		strSql ="EXEC [db_event].[dbo].usp_WWW_event_EventISSUE_Get '"& FECode & "','" & FEKind & "','" & FBrand & "','" & FEDispCate & "' ,'"& FDevice &"'"
		'Response.write strSql
		'rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"EVTAND",strSql,60*30)
        if (rsMem is Nothing) then Exit function ''추가
		IF Not (rsMem.EOF OR rsMem.BOF) THEN
			fnAnotherEventListGet = rsMem.GetRows()
		END IF
		rsMem.close
	End Function

	public Function fnGetTopSlideTemplate
		Dim strSql
		If FECode = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_TopSlideaddimg_Get] ("&FECode&", 'W')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetTopSlideTemplate = rsget.GetRows()
		Else
			
		END IF
		rsget.close
	End Function

	'// 이벤트 PC 기프트박스 정보
	Public Function fnGetGiftBox
		Dim strSql
		If FECode = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_GiftBox_Get] ("&FECode&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetGiftBox = rsget.GetRows()
		END IF
		rsget.close
	End Function

	'멀티 컨텐츠 마스터 정보
	public Function fnGetEventMultiContentsMaster
		Dim strSql
		If FECode = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_MultiContentsMaster_Get] ("&FECode&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetEventMultiContentsMaster = rsget.getRows()
		END IF
		rsget.close
	End Function

	'멀티 컨텐츠 이미지 & 영상 정보
	public Function fnGetEventMultiContentsSwife
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_MultiContentsImageSwife_Get] ("&FMenuIDX&",'W')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetEventMultiContentsSwife = rsget.getRows()
		END IF
		rsget.close
	End Function

	'멀티 컨텐츠 이미지 & 영상 정보
	public Function fnGetEventMultiContentsVideo
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_MultiContentsVideo_Get] ("&FMenuIDX&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetEventMultiContentsVideo = rsget.getRows()
		END IF
		rsget.close
	End Function

	'멀티 컨텐츠 브랜드 스토리
	public Function fnGetEventMultiContentsBrandStory
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_MultiContentsBrandStory_Get] ("&FMenuIDX&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetEventMultiContentsBrandStory = rsget.getRows()
		END IF
		rsget.close
	End Function

	'멀티 컨텐츠 기차형 템플릿 (MD추천상품)
	public Function fnGetEventMultiContentsTrainTamplate
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_MultiContentsTrainTamplate_Get] ("&FMenuIDX&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetEventMultiContentsTrainTamplate = rsget.getRows()
		END IF
		rsget.close
	End Function

	'멀티 컨텐츠 에디터영역
	public Function fnGetEventMultiContentsCustomBox
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_MultiContentsCustomBox_Get] ("&FMenuIDX&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetEventMultiContentsCustomBox = rsget.getRows()
		END IF
		rsget.close
	End Function

	'멀티 컨텐츠 상단 슬라이드
	public Function fnGetTopSlideTemplateMulti
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="EXEC [db_event].[dbo].[usp_WWW_Event_TopSlideaddimg_Multi_Get] " & FMenuIDX & ", 'W'"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdText
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetTopSlideTemplateMulti = rsget.GetRows()
		END IF
		rsget.close
	End Function

	'멀티 컨텐츠 이미지 & HTML
	public Function fnGetImageHtmlTemplate
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="EXEC [db_event].[dbo].[usp_WWW_Event_MultiContents_ImageHtml_Get] " & FMenuIDX & ", 'W'"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdText
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetImageHtmlTemplate = rsget.GetRows()
		END IF
		rsget.close
	End Function

	'// 멀티 컨텐츠 슬라이드 템플릿 정보 
	public Function fnGetMultiContentsSlideTemplateInfo
		Dim strSql
		IF FMenuIDX = "" THEN Exit Function
		strSql = "EXEC [db_event].[dbo].[usp_WWW_Event_MultiContents_SlideTemplateInfo_Get] "&FMenuIDX&", 'W'"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdText
			IF Not (rsget.EOF OR rsget.BOF) THEN
				FSidx		= rsget("idx")
				FStopimg	= rsget("topimg")
				FSbtmYN		= rsget("btmYN")
				FSbtmimg	= rsget("btmimg")
				FSbtmcode	= rsget("btmcode")
				FStopaddimg	= rsget("topaddimg")
				FSbtmaddimg = rsget("btmaddimg")
				FSpcadd1	= rsget("pcadd1")
				FSgubun		= rsget("gubun")
   			ELSE
   				FSidx		= ""
				FStopimg	= ""
				FSbtmYN		= ""
				FSbtmimg	= ""
				FSbtmcode	= ""
				FStopaddimg = ""
				FSbtmaddimg = ""
				FSpcadd1	= ""
				FSgubun		= ""
			END IF
		rsget.close
	END Function
	'// 멀티 컨텐츠 슬라이드 템플릿 이미지 리스트 
	public Function fnGetMultiContentsSlideTemplateImages
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="EXEC [db_event].[dbo].[usp_WWW_Event_MultiContents_SlideTemplateImageList_Get] "&FMenuIDX&", 'W'"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdText
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetMultiContentsSlideTemplateImages = rsget.GetRows()
		END IF
		rsget.close
	End Function

	'// 멀티컨텐츠 모바일 연결배너
	Public Function fnGetPCMultiAddBanner
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="EXEC [db_event].[dbo].[usp_WWW_Event_PCAddbannerNew_Multi_Get] "&FMenuIDX&""
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdText
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetPCMultiAddBanner = rsget.GetRows()
		END IF
		rsget.close
	End Function

	'// 멀티컨텐츠 마스터 정보
	Public Function fnGetMultiContentsMasterSetCnt
		Dim strSql
		If FECode = "" THEN Exit Function
		strSql ="EXEC [db_event].[dbo].[usp_WWW_Event_MultiContents_MasterSetCount_Get] "&FECode&""
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdText
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetMultiContentsMasterSetCnt = rsget("CNT")
		END IF
		rsget.close
	End Function

	'멀티 컨텐츠 이미지 맵
	public Function fnGetImageMapTemplate
		Dim strSql
		If FMenuIDX = "" THEN Exit Function
		strSql ="EXEC [db_event].[dbo].[usp_WWW_Event_MultiContents_ImageMap_Get] " & FMenuIDX & ", 'W'"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdText
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetImageMapTemplate = rsget.GetRows()
		END IF
		rsget.close
	End Function

END Class


'----------------------------------------------------
' ClsEvtItem : 상품
'----------------------------------------------------
Class ClsEvtItem
	public FECode   '이벤트 코드
	public FEGCode
	public FEItemCnt
	public FItemsort
	public FTotCnt
	public FItemArr
	public FResultCount
	public FGroupItemCheck
	public FGroupItemType
	public FMenuIDX

	public FCategoryPrdList()

	Private Sub Class_Initialize()
		redim preserve FCategoryPrdList(0)
		FTotCnt = 0
		FItemArr = ""
	End Sub

	Private Sub Class_Terminate()

	End Sub

	'##### 상품 리스트 ######
	public Function fnGetEventItem
		Dim strSql, arrItem,intI
		IF FECode = "" THEN Exit Function
		IF FEGCode = "" THEN FEGCode= 0
		'//리뉴얼 교체 디바이스(1 pc , 2 mobile&app) 추가
		'strSql ="[db_item].[dbo].sp_Ten_event_GetItem ("&FECode&","&FEGCode&","&FEItemCnt&","&FItemsort&")"
		strSql ="[db_item].[dbo].sp_Ten_event_GetItem_new ("&FECode&","&FEGCode&","&FEItemCnt&","&FItemsort&",1)"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			arrItem = rsget.GetRows()
		END IF
		rsget.close

		IF isArray(arrItem) THEN
			FTotCnt = Ubound(arrItem,2)
			redim preserve FCategoryPrdList(FTotCnt)

			For intI = 0 To FTotCnt
			set FCategoryPrdList(intI) = new CCategoryPrdItem
				FCategoryPrdList(intI).FItemID       = arrItem(0,intI)
				IF intI =0 THEN
				FItemArr = 	FCategoryPrdList(intI).FItemID
				ELSE
				FItemArr = FItemArr&","&FCategoryPrdList(intI).FItemID
				END IF
				FCategoryPrdList(intI).FItemName    = db2html(arrItem(1,intI))

				FCategoryPrdList(intI).FSellcash    = arrItem(2,intI)
				FCategoryPrdList(intI).FOrgPrice   	= arrItem(3,intI)
				FCategoryPrdList(intI).FMakerId   	= db2html(arrItem(4,intI))
				FCategoryPrdList(intI).FBrandName  	= db2html(arrItem(5,intI))

				FCategoryPrdList(intI).FSellYn      = arrItem(9,intI)
				FCategoryPrdList(intI).FSaleYn     	= arrItem(10,intI)
				FCategoryPrdList(intI).FLimitYn     = arrItem(11,intI)
				FCategoryPrdList(intI).FLimitNo     = arrItem(12,intI)
				FCategoryPrdList(intI).FLimitSold   = arrItem(13,intI)

				FCategoryPrdList(intI).FRegdate 		= arrItem(14,intI)
				FCategoryPrdList(intI).FReipgodate		= arrItem(15,intI)

                FCategoryPrdList(intI).Fitemcouponyn 	= arrItem(16,intI)
				FCategoryPrdList(intI).FItemCouponValue	= arrItem(17,intI)
				FCategoryPrdList(intI).Fitemcoupontype	= arrItem(18,intI)

				FCategoryPrdList(intI).Fevalcnt 		= arrItem(19,intI)
				FCategoryPrdList(intI).FitemScore 		= arrItem(20,intI)
				FCategoryPrdList(intI).Fitemdiv			= arrItem(24,intI)

				If arrItem(24,intI)="21" Then
					if instr(arrItem(26,intI),"/") > 0 then
						FCategoryPrdList(intI).FImageList		= "http://webimage.10x10.co.kr/image/list/"&arrItem(6,intI)
						FCategoryPrdList(intI).FImageList120	= "http://webimage.10x10.co.kr/image/list120/"&arrItem(7,intI)
						FCategoryPrdList(intI).FImageSmall		= "http://webimage.10x10.co.kr/image/small/"&arrItem(8,intI)
						FCategoryPrdList(intI).FImageIcon1		= "http://webimage.10x10.co.kr/image/icon1/"&arrItem(21,intI)
						FCategoryPrdList(intI).FImageIcon2		= "http://webimage.10x10.co.kr/image/icon2/"&arrItem(22,intI)
						FCategoryPrdList(intI).FImageBasic		= "http://webimage.10x10.co.kr/image/basic/"&arrItem(26,intI)
						If arrItem(27,intI) <> "" Then
						FCategoryPrdList(intI).FImageBasic600	= "http://webimage.10x10.co.kr/image/basic/"&arrItem(27,intI)
						End If
					Else
						FCategoryPrdList(intI).FImageList		= "http://webimage.10x10.co.kr/image/list/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(6,intI)
						FCategoryPrdList(intI).FImageList120	= "http://webimage.10x10.co.kr/image/list120/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(7,intI)
						FCategoryPrdList(intI).FImageSmall		= "http://webimage.10x10.co.kr/image/small/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(8,intI)
						FCategoryPrdList(intI).FImageIcon1		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(21,intI)
						FCategoryPrdList(intI).FImageIcon2		= "http://webimage.10x10.co.kr/image/icon2/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(22,intI)
						FCategoryPrdList(intI).FImageBasic		= "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(26,intI)
						FCategoryPrdList(intI).FImageBasic600	= "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(27,intI)
					End If
					FCategoryPrdList(intI).FItemOptionCnt = arrItem(38,intI)
				Else
					FCategoryPrdList(intI).FImageList		= "http://webimage.10x10.co.kr/image/list/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(6,intI)
					FCategoryPrdList(intI).FImageList120	= "http://webimage.10x10.co.kr/image/list120/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(7,intI)
					FCategoryPrdList(intI).FImageSmall		= "http://webimage.10x10.co.kr/image/small/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(8,intI)
					FCategoryPrdList(intI).FImageIcon1		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(21,intI)
					FCategoryPrdList(intI).FImageIcon2		= "http://webimage.10x10.co.kr/image/icon2/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(22,intI)
					FCategoryPrdList(intI).FImageBasic		= "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(26,intI)
					FCategoryPrdList(intI).FImageBasic600	= "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(27,intI)
				End If
				FCategoryPrdList(intI).FItemSize		= arrItem(23,intI)
				
				
				FCategoryPrdList(intI).FfavCount		= arrItem(28,intI)

				If arrItem(29,intI) <> "" then
				FCategoryPrdList(intI).FAddImage		= "http://webimage.10x10.co.kr/image/add1/" & GetImageSubFolderByItemid(arrItem(0,intI)) & "/" & db2html(arrItem(29,intI))
				End if

				If Not(arrItem(31,intI)="" Or isnull(arrItem(31,intI))) Then 
					FCategoryPrdList(intI).Ftentenimage	= "http://webimage.10x10.co.kr/image/tenten/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(31,intI)
					FCategoryPrdList(intI).Ftentenimage50	= "http://webimage.10x10.co.kr/image/tenten50/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(32,intI)
					FCategoryPrdList(intI).Ftentenimage200	= "http://webimage.10x10.co.kr/image/tenten200/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(33,intI)
					FCategoryPrdList(intI).Ftentenimage400	= "http://webimage.10x10.co.kr/image/tenten400/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(34,intI)
					FCategoryPrdList(intI).Ftentenimage600	= "http://webimage.10x10.co.kr/image/tenten600/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(35,intI)
					FCategoryPrdList(intI).Ftentenimage1000	= "http://webimage.10x10.co.kr/image/tenten1000/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(36,intI)
				End If

				'// 해외직구배송작업추가(원승현)
				FCategoryPrdList(intI).FDeliverFixDay		= arrItem(39,intI) '해외 직구 배송
				FCategoryPrdList(intI).FadultType		= arrItem(40,intI) '성인

			Next
		ELSE
			FTotCnt = -1
		END IF
	End Function

	Public sub fnGetMDSlideTemplate_sub()
		Dim i, strSql
		'// 추천상품 목록접수
		strSql = "Select top 5 i.basicimage, i.itemid"
		strSql = strSql & " from [db_event].[dbo].[tbl_event_itembanner] e"
		strSql = strSql & "	join [db_item].[dbo].tbl_item i "
		strSql = strSql & "	on e.itemid = i.itemid"
		strSql = strSql & " where 1 = 1 "
		strSql = strSql & "	and e.evt_code=" & CStr(FECode)
		strSql = strSql & "	and e.sdiv='w'"
		strSql = strSql & " order by e.viewidx asc"
		''response.Write strSql
		rsget.Open strSql, dbget, 1

		FResultCount = rsget.RecordCount
		redim preserve FCategoryPrdList(FResultCount)

		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FCategoryPrdList(i) = new CCategoryPrdItem
				FCategoryPrdList(i).FImageList = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("basicimage")
				FCategoryPrdList(i).FItemID = rsget("itemid")
				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	End Sub

	'##### H형 템플릿 아이템 리스트 ######
	Public Function fnGetMDTemplateItemList
		Dim strSql
		If FECode = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_MDTemplateItemList_Get] ("&FECode & ",'" & FGroupItemType & "')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			arrItem = rsget.GetRows()
		END IF
		rsget.close

		IF isArray(arrItem) THEN
			FTotCnt = Ubound(arrItem,2)
			redim preserve FCategoryPrdList(FTotCnt)

			For intI = 0 To FTotCnt
			set FCategoryPrdList(intI) = new CCategoryPrdItem
				FCategoryPrdList(intI).FItemID			= arrItem(1,intI)
				If FGroupItemCheck="T" Then
					FCategoryPrdList(intI).FItemName    = db2html(arrItem(0,intI))
				Else
					FCategoryPrdList(intI).FItemName    = db2html(arrItem(2,intI))
				End If
				FCategoryPrdList(intI).FSellcash		= arrItem(8,intI)
				FCategoryPrdList(intI).FOrgPrice   		= arrItem(9,intI)
				FCategoryPrdList(intI).FSaleYn     		= arrItem(10,intI)
				FCategoryPrdList(intI).Fitemcouponyn 	= arrItem(11,intI)
				FCategoryPrdList(intI).FItemCouponValue	= arrItem(12,intI)
				FCategoryPrdList(intI).Fitemcoupontype	= arrItem(13,intI)
				FCategoryPrdList(intI).Fitemdiv			= arrItem(14,intI)'SalePercent
				FCategoryPrdList(intI).FitemScore		= arrItem(4,intI)'groupcode
				FCategoryPrdList(intI).Fevalcnt			= arrItem(6,intI)'iconnew
				FCategoryPrdList(intI).FItemOptionCnt	= arrItem(7,intI)'iconbest
				FCategoryPrdList(intI).FMakerId			= arrItem(15,intI)'iconbest
				If arrItem(3,intI) <> "" Then
					FCategoryPrdList(intI).FImageBasic = arrItem(3,intI)
				Else
					FCategoryPrdList(intI).FImageBasic = "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(arrItem(1,intI))&"/"&arrItem(5,intI)
				End If

			Next
		ELSE
			FTotCnt = -1
		END IF
	End Function

	'멀티 컨텐츠 기차형 템플릿 (MD추천상품)
	public Function fnGetEventMultiContentsTrainTamplate
		Dim strSql, arrItem
		dim totalPrice , salePercentString , couponPercentString , totalSalePercent
		If FMenuIDX = "" THEN Exit Function
		strSql ="[db_event].[dbo].[usp_WWW_Event_MultiContentsTrainTamplate_Get] ("&FMenuIDX&")"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			arrItem = rsget.getRows()
		END IF
		rsget.close

		IF isArray(arrItem) THEN
			FTotCnt = Ubound(arrItem,2)
			redim preserve FCategoryPrdList(FTotCnt)
			For intI = 0 To FTotCnt
			set FCategoryPrdList(intI) = new CCategoryPrdItem
				FCategoryPrdList(intI).FItemID			= arrItem(0,intI)
				If FGroupItemCheck="T" Then
					FCategoryPrdList(intI).FItemName    = db2html(arrItem(1,intI))
				Else
					FCategoryPrdList(intI).FItemName    = db2html(arrItem(2,intI))
				End If
				FCategoryPrdList(intI).FSellcash		= arrItem(9,intI)
				FCategoryPrdList(intI).FOrgPrice   		= arrItem(10,intI)
				FCategoryPrdList(intI).FSaleYn     		= arrItem(11,intI)
				FCategoryPrdList(intI).Fitemcouponyn 	= arrItem(12,intI)
				FCategoryPrdList(intI).FItemCouponValue	= arrItem(13,intI)
				FCategoryPrdList(intI).Fitemcoupontype	= arrItem(14,intI)
				FCategoryPrdList(intI).FitemScore		= arrItem(4,intI)'groupcode
				FCategoryPrdList(intI).Fevalcnt			= arrItem(5,intI)'iconnew
				FCategoryPrdList(intI).FItemOptionCnt	= arrItem(6,intI)'iconbest
				FCategoryPrdList(intI).FMakerId			= arrItem(7,intI)
				If arrItem(3,intI) <> "" Then
					FCategoryPrdList(intI).FImageBasic = arrItem(3,intI)
				Else
					FCategoryPrdList(intI).FImageBasic = "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(arrItem(0,intI))&"/"&arrItem(8,intI)
				End If
				FCategoryPrdList(intI).FBrandName		= arrItem(15,intI)
				FCategoryPrdList(intI).FItemName2		= db2html(arrItem(16,intI))
				FCategoryPrdList(intI).FMobileImageUrl	= arrItem(17,intI)
				FCategoryPrdList(intI).FPCImageUrl		= arrItem(18,intI)
				FCategoryPrdList(intI).FXPosition		= arrItem(19,intI)
				FCategoryPrdList(intI).FYPosition		= arrItem(20,intI)

				call FCategoryPrdList(intI).fnProductPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)

				FCategoryPrdList(intI).FProductTotalPrice 			= totalPrice
				FCategoryPrdList(intI).FProductSalePercentString 	= salePercentString
				FCategoryPrdList(intI).FProductCouponPercentString	= couponPercentString
				FCategoryPrdList(intI).FProductTotalSalePercent		= totalSalePercent
			Next
		ELSE
			FTotCnt = -1
		END IF
	End Function
End Class


'----------------------------------------------------
' sbEvtItemView : 상품목록 보여주기
'----------------------------------------------------
Sub sbEvtItemView
	Dim intIx, sBadges
	dim classStr, adultChkFlag, adultPopupLink, linkUrl

	IF eCode = "" THEN Exit Sub
	intI = 0
set cEventItem = new ClsEvtItem
	cEventItem.FECode 	= eCode
	cEventItem.FEGCode 	= egCode
	cEventItem.FEItemCnt= itemlimitcnt
	cEventItem.FItemsort= eitemsort
	cEventItem.fnGetEventItem
	iTotCnt = cEventItem.FTotCnt

	IF itemid = "" THEN
		itemid = cEventItem.FItemArr
	ELSE
		itemid = itemid&","&cEventItem.FItemArr
	END If
	
	intI = 0
	'// 이미지 사이즈가 큰경우(200px) 먼저 표시(2008.10.20; 허진원)
	IF (iTotCnt >= 0) THEN
		if cEventItem.FCategoryPrdList(0).FItemSize="2" or cEventItem.FCategoryPrdList(0).FItemSize="200" Then
			IF blnItemifno THEN 
			%>
			<div class="pdtWrap pdt400V15">
				<ul class="pdtList">
			<%
				For intI =0 To iTotCnt		
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if							
					'큰이미지가 끝나면 출력 종료
					if cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="150" or cEventItem.FCategoryPrdList(intI).FItemSize="153" or cEventItem.FCategoryPrdList(intI).FItemSize="155" or cEventItem.FCategoryPrdList(intI).FItemSize="160" then Exit For
			%>
				<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
					<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>
					<div class="pdtBox">
						<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>						
							<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"400","400","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"400","400","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
								<% If cEventItem.FCategoryPrdList(intI).FItemOptionCnt="" Or cEventItem.FCategoryPrdList(intI).FItemOptionCnt="0" Then %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원~</span></p>
								<% Else %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원~</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).FItemOptionCnt%>%]</strong></p>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% If cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% Else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).FItemOptionCnt>0 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% End If %>
							</p>
						</div>
					</div>
					<% Else %>
					<div class="pdtBox">
						<% '// 해외직구배송작업추가(원승현) %>						
						<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
							<i class="abroad-badge">해외직구</i>
						<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"400","400","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"400","400","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
							<% If blnitempriceyn = "1" Then %>
							<% Else %>
								<% If cEventItem.FCategoryPrdList(intI).FItemDiv="30" Then %>
									<%'' 이니렌탈 가격 표시 %>
									<p class="pdtPrice"><span class="finalP">월 <%=FormatNumber(RentalPriceCalculationDataInEventList(cEventItem.FCategoryPrdList(intI).getRealPrice),0)%>원~</span></p>
								<% Else %>
									<% if cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem Then %>
										<% IF cEventItem.FCategoryPrdList(intI).IsSaleItem then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).getSalePro%>]</strong></p>
										<% End If %>
										<% IF cEventItem.FCategoryPrdList(intI).IsCouponItem Then %>
											<% if Not(cEventItem.FCategoryPrdList(intI).IsFreeBeasongCoupon() or cEventItem.FCategoryPrdList(intI).IsSaleItem) Then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
											<% end If %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=cEventItem.FCategoryPrdList(intI).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0) & chkIIF(cEventItem.FCategoryPrdList(intI).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% IF cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% end if %>
							</p>
							<% End If %>
						</div>
						<ul class="pdtActionV15">
							<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=cEventItem.FCategoryPrdList(intI).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
							<li class="postView"><a href="" <%=chkIIF(cEventItem.FCategoryPrdList(intI).Fevalcnt>0,"onclick=""popEvaluate('" & cEventItem.FCategoryPrdList(intI).FItemid & "');return false;""","onclick=""return false;""")%>><span><%=cEventItem.FCategoryPrdList(intI).Fevalcnt%></span></a></li>
							<li class="wishView"><a href="" onclick="TnAddFavorite('<%=cEventItem.FCategoryPrdList(intI).FItemid %>');return false;"><span><%=cEventItem.FCategoryPrdList(intI).FfavCount%></span></a></li>
						</ul>
					</div>
					<% End If %>
					</li>
			<%
					set cEventItem.FCategoryPrdList(intI) = nothing
				Next
			%>
				</ul>
			</div>
		 <% Else %>
			<div class="pdtWrap pdt400V15">
				<ul class="pdtList">
			<%
				For intI =0 To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if							
					if cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="150" or cEventItem.FCategoryPrdList(intI).FItemSize="153" or cEventItem.FCategoryPrdList(intI).FItemSize="155" or cEventItem.FCategoryPrdList(intI).FItemSize="160" then Exit For
			%>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
				<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>
						<div class="pdtBox">
							<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
							<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>								
								<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"400","400","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"400","400","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
							</div>
						</div>
				<% Else %>					
						<div class="pdtBox">
							<% '// 해외직구배송작업추가(원승현) %>						
							<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
								<i class="abroad-badge">해외직구</i>
							<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
							<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>								
								<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"400","400","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"400","400","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
							</div>
						</div>
				<% End If %>
					</li>
			<%
					Set cEventItem.FCategoryPrdList(intI) = nothing
				Next 
			%>
				</ul>
			</div>
<%
			End If
		end if
	end If
	
	'// 이미지 사이즈가 중간일경우(320px) 표시(2015-04-01; 이종화) 추가
	intIx = intI

	IF (iTotCnt >= intIx) THEN
		if cEventItem.FCategoryPrdList(intI).FItemSize="160" then
			IF blnItemifno THEN 
			%>
			<div class="pdtWrap pdt320V15">
				<ul class="pdtList">
			<%
				For intI = intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if						
					'중간이미지가 끝나면 출력 종료
					if cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="150" or cEventItem.FCategoryPrdList(intI).FItemSize="153" or cEventItem.FCategoryPrdList(intI).FItemSize="155" then Exit For
			%>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >	
					<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>
					<div class="pdtBox">
						<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"320","320","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"320","320","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
								<% If cEventItem.FCategoryPrdList(intI).FItemOptionCnt="" Or cEventItem.FCategoryPrdList(intI).FItemOptionCnt="0" Then %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원~</span></p>
								<% Else %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원~</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).FItemOptionCnt%>%]</strong></p>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% If cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% Else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).FItemOptionCnt>0 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% End If %>
							</p>
						</div>
					</div>
					<% Else %>
					<div class="pdtBox">
						<% '// 해외직구배송작업추가(원승현) %>						
						<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
							<i class="abroad-badge">해외직구</i>
						<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"320","320","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"320","320","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
							<% If blnitempriceyn = "1" Then %>
							<% Else %>
								<% If cEventItem.FCategoryPrdList(intI).FItemDiv="30" Then %>
									<%'' 이니렌탈 가격 표시 %>
									<p class="pdtPrice"><span class="finalP">월 <%=FormatNumber(RentalPriceCalculationDataInEventList(cEventItem.FCategoryPrdList(intI).getRealPrice),0)%>원~</span></p>
								<% Else %>
									<% if cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem Then %>
										<% IF cEventItem.FCategoryPrdList(intI).IsSaleItem then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).getSalePro%>]</strong></p>
										<% End If %>
										<% IF cEventItem.FCategoryPrdList(intI).IsCouponItem Then %>
											<% if Not(cEventItem.FCategoryPrdList(intI).IsFreeBeasongCoupon() or cEventItem.FCategoryPrdList(intI).IsSaleItem) Then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
											<% end If %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=cEventItem.FCategoryPrdList(intI).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0) & chkIIF(cEventItem.FCategoryPrdList(intI).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% IF cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% end if %>
							</p>
							<% End If %>
						</div>
						<ul class="pdtActionV15">
							<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=cEventItem.FCategoryPrdList(intI).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
							<li class="postView"><a href="" <%=chkIIF(cEventItem.FCategoryPrdList(intI).Fevalcnt>0,"onclick=""popEvaluate('" & cEventItem.FCategoryPrdList(intI).FItemid & "');return false;""","onclick=""return false;""")%>><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).Fevalcnt,0)%></span></a></li>
							<li class="wishView"><a href="" onclick="TnAddFavorite('<%=cEventItem.FCategoryPrdList(intI).FItemid %>');return false;"><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).FfavCount,0)%></span></a></li>
						</ul>
					</div>
					<% End If %>
					</li>
			<%
					set cEventItem.FCategoryPrdList(intI) = nothing
				Next
			%>
				</ul>
			</div>
		 <% Else %>
			<div class="pdtWrap pdt320V15">
				<ul class="pdtList">
			<%
				For intI =intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if							
					if cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="150" or cEventItem.FCategoryPrdList(intI).FItemSize="153" or cEventItem.FCategoryPrdList(intI).FItemSize="155" then Exit For
			%>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >			
				<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>					
						<div class="pdtBox">
							<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
							<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>								
								<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"320","320","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"320","320","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
							</div>
						</div>
				<% Else %>					
						<div class="pdtBox">
							<% '// 해외직구배송작업추가(원승현) %>						
							<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
								<i class="abroad-badge">해외직구</i>
							<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
							<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>								
								<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"320","320","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"320","320","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
							</div>
						</div>
				<% End If %>
					</li>
			<%
					Set cEventItem.FCategoryPrdList(intI) = nothing
				Next 
			%>
				</ul>
			</div>
<%
			End If
		end if
	end If
	
	'// 이미지 사이즈가 중간일경우(270px) 표시(2015-04-01; 이종화 추가)
	intIx = intI

	IF (iTotCnt >= intIx) THEN
		if cEventItem.FCategoryPrdList(intI).FItemSize="155" then
			IF blnItemifno THEN 
			%>
			<div class="pdtWrap pdt270V15">
				<ul class="pdtList">
			<%
				For intI = intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if						
					'중간이미지가 끝나면 출력 종료
					if cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="150"  or cEventItem.FCategoryPrdList(intI).FItemSize="153" then Exit For
			%>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
					<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>
					<div class="pdtBox">
						<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"270","270","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"270","270","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
								<% If cEventItem.FCategoryPrdList(intI).FItemOptionCnt="" Or cEventItem.FCategoryPrdList(intI).FItemOptionCnt="0" Then %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원~</span></p>
								<% Else %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원~</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).FItemOptionCnt%>%]</strong></p>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% If cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% Else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).FItemOptionCnt>0 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% End If %>
							</p>
						</div>
					</div>
					<% Else %>
					<div class="pdtBox">
						<% '// 해외직구배송작업추가(원승현) %>						
						<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
							<i class="abroad-badge">해외직구</i>
						<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"270","270","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"270","270","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
							<% If blnitempriceyn = "1" Then %>
							<% Else %>
								<% If cEventItem.FCategoryPrdList(intI).FItemDiv="30" Then %>
									<%'' 이니렌탈 가격 표시 %>
									<p class="pdtPrice"><span class="finalP">월 <%=FormatNumber(RentalPriceCalculationDataInEventList(cEventItem.FCategoryPrdList(intI).getRealPrice),0)%>원~</span></p>
								<% Else %>							
									<% if cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem Then %>
										<% IF cEventItem.FCategoryPrdList(intI).IsSaleItem then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).getSalePro%>]</strong></p>
										<% End If %>
										<% IF cEventItem.FCategoryPrdList(intI).IsCouponItem Then %>
											<% if Not(cEventItem.FCategoryPrdList(intI).IsFreeBeasongCoupon() or cEventItem.FCategoryPrdList(intI).IsSaleItem) Then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
											<% end If %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=cEventItem.FCategoryPrdList(intI).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0) & chkIIF(cEventItem.FCategoryPrdList(intI).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% IF cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% end if %>
							</p>
							<% End If %>
						</div>
						<ul class="pdtActionV15">
							<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=cEventItem.FCategoryPrdList(intI).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
							<li class="postView"><a href="" <%=chkIIF(cEventItem.FCategoryPrdList(intI).Fevalcnt>0,"onclick=""popEvaluate('" & cEventItem.FCategoryPrdList(intI).FItemid & "');return false;""","onclick=""return false;""")%>><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).Fevalcnt,0)%></span></a></li>
							<li class="wishView"><a href="" onclick="TnAddFavorite('<%=cEventItem.FCategoryPrdList(intI).FItemid %>');return false;"><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).FfavCount,0)%></span></a></li>
						</ul>
					</div>
					<% End If %>
					</li>
			<%
					set cEventItem.FCategoryPrdList(intI) = nothing
				Next
			%>
				</ul>
			</div>
		 <% Else %>
			<div class="pdtWrap pdt270V15">
				<ul class="pdtList">
			<%
				For intI =intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if							
					if cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="150"  or cEventItem.FCategoryPrdList(intI).FItemSize="153" then Exit For
			%>
				<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
				<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>				
						<div class="pdtBox">
							<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
							<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>								
								<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"270","270","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"270","270","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
							</div>
						</div>
				<% Else %>					
						<div class="pdtBox">
							<% '// 해외직구배송작업추가(원승현) %>						
							<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
								<i class="abroad-badge">해외직구</i>
							<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
							<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>								
								<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"270","270","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"270","270","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
							</div>
						</div>
				<% End If %>
					</li>
			<%
					Set cEventItem.FCategoryPrdList(intI) = nothing
				Next 
			%>
				</ul>
			</div>
<%
			End If
		end if
	end if

	'// 이미지 사이즈가 중간일경우(240px:4개) 표시(2017-08-07; 정태훈) 추가
	intIx = intI

	IF (iTotCnt >= intIx) THEN
		if cEventItem.FCategoryPrdList(intI).FItemSize="153" then
			IF blnItemifno THEN 
			%>
			<div class="pdtWrap pdt240V15">
				<ul class="pdtList">
			<%
				For intI = intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if						
					'중간이미지가 끝나면 출력 종료
					if cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="150" then Exit For
			%>
				<% If cEventItem.FCategoryPrdList(intI).FSellYn<>"N" Then %>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
					<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>
					<div class="pdtBox">
						<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"240","240","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"240","240","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
								<% If cEventItem.FCategoryPrdList(intI).FItemOptionCnt="" Or cEventItem.FCategoryPrdList(intI).FItemOptionCnt="0" Then %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원~</span></p>
								<% Else %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원~</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).FItemOptionCnt%>%]</strong></p>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% If cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% Else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).FItemOptionCnt>0 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% End If %>
							</p>
						</div>
					</div>
					<% Else %>
					<div class="pdtBox">
						<% '// 해외직구배송작업추가(원승현) %>						
						<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
							<i class="abroad-badge">해외직구</i>
						<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"240","240","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"240","240","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
							<% If blnitempriceyn = "1" Then %>
							<% Else %>
								<% If cEventItem.FCategoryPrdList(intI).FItemDiv="30" Then %>
									<%'' 이니렌탈 가격 표시 %>
									<p class="pdtPrice"><span class="finalP">월 <%=FormatNumber(RentalPriceCalculationDataInEventList(cEventItem.FCategoryPrdList(intI).getRealPrice),0)%>원~</span></p>
								<% Else %>							
									<% if cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem Then %>
										<% IF cEventItem.FCategoryPrdList(intI).IsSaleItem then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).getSalePro%>]</strong></p>
										<% End If %>
										<% IF cEventItem.FCategoryPrdList(intI).IsCouponItem Then %>
											<% if Not(cEventItem.FCategoryPrdList(intI).IsFreeBeasongCoupon() or cEventItem.FCategoryPrdList(intI).IsSaleItem) Then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
											<% end If %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=cEventItem.FCategoryPrdList(intI).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0) & chkIIF(cEventItem.FCategoryPrdList(intI).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% IF cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% end if %>
							</p>
							<% End If %>
						</div>
						<ul class="pdtActionV15">
							<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=cEventItem.FCategoryPrdList(intI).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
							<li class="postView"><a href="" <%=chkIIF(cEventItem.FCategoryPrdList(intI).Fevalcnt>0,"onclick=""popEvaluate('" & cEventItem.FCategoryPrdList(intI).FItemid & "');return false;""","onclick=""return false;""")%>><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).Fevalcnt,0)%></span></a></li>
							<li class="wishView"><a href="" onclick="TnAddFavorite('<%=cEventItem.FCategoryPrdList(intI).FItemid %>');return false;"><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).FfavCount,0)%></span></a></li>
						</ul>
					</div>
					<% End If %>
					</li>
				<% End If %>
			<%
					set cEventItem.FCategoryPrdList(intI) = nothing
				Next
			%>
				</ul>
			</div>
		 <% Else %>
			<div class="pdtWrap pdt240V15">
				<ul class="pdtList">
			<%
				For intI =intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if							
					if cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="150" then Exit For
			%>
				<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
				<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>					
					<div class="pdtBox">
						<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"240","240","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"240","240","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
					</div>
				<% Else %>					
					<div class="pdtBox">
						<% '// 해외직구배송작업추가(원승현) %>						
						<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
							<i class="abroad-badge">해외직구</i>
						<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage400)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage400%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"240","240","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"240","240","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
					</div>
				<% End If %>
					</li>
			<%
					Set cEventItem.FCategoryPrdList(intI) = nothing
				Next 
			%>
				</ul>
			</div>
<%
			End If
		end if
	end If

	'// 이미지 사이즈가 중간일경우(200px 기존 -> 180xp 변경)
	intIx = intI

	IF (iTotCnt >= intIx) THEN
		if cEventItem.FCategoryPrdList(intI).FItemSize="150" then
			IF blnItemifno THEN 
			%>
			<div class="pdtWrap pdt180V15">
				<ul class="pdtList">
			<%
				For intI = intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if						
					'중간이미지가 끝나면 출력 종료
					if cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="100" then Exit For
			%>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
					<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>
					<div class="pdtBox">
						<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage200="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage200)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage200%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"180","180","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"180","180","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
								<% If cEventItem.FCategoryPrdList(intI).FItemOptionCnt="" Or cEventItem.FCategoryPrdList(intI).FItemOptionCnt="0" Then %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원~</span></p>
								<% Else %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원~</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).FItemOptionCnt%>%]</strong></p>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% If cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% Else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).FItemOptionCnt>0 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% End If %>
							</p>
						</div>
					</div>
					<% Else %>
					<div class="pdtBox">
						<% '// 해외직구배송작업추가(원승현) %>						
						<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
							<i class="abroad-badge">해외직구</i>
						<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage200="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage200)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage200%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"180","180","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"180","180","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
							<% If blnitempriceyn = "1" Then %>
							<% Else %>
								<% If cEventItem.FCategoryPrdList(intI).FItemDiv="30" Then %>
									<%'' 이니렌탈 가격 표시 %>
									<p class="pdtPrice"><span class="finalP">월 <%=FormatNumber(RentalPriceCalculationDataInEventList(cEventItem.FCategoryPrdList(intI).getRealPrice),0)%>원~</span></p>
								<% Else %>														
									<% if cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem Then %>
										<% IF cEventItem.FCategoryPrdList(intI).IsSaleItem then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).getSalePro%>]</strong></p>
										<% End If %>
										<% IF cEventItem.FCategoryPrdList(intI).IsCouponItem Then %>
											<% if Not(cEventItem.FCategoryPrdList(intI).IsFreeBeasongCoupon() or cEventItem.FCategoryPrdList(intI).IsSaleItem) Then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
											<% end If %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=cEventItem.FCategoryPrdList(intI).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0) & chkIIF(cEventItem.FCategoryPrdList(intI).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% IF cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% end if %>
							</p>
							<% End If %>
						</div>
						<ul class="pdtActionV15">
							<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=cEventItem.FCategoryPrdList(intI).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
							<li class="postView"><a href="" <%=chkIIF(cEventItem.FCategoryPrdList(intI).Fevalcnt>0,"onclick=""popEvaluate('" & cEventItem.FCategoryPrdList(intI).FItemid & "');return false;""","onclick=""return false;""")%>><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).Fevalcnt,0)%></span></a></li>
							<li class="wishView"><a href="" onclick="TnAddFavorite('<%=cEventItem.FCategoryPrdList(intI).FItemid %>');return false;"><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).FfavCount,0)%></span></a></li>
						</ul>
					</div>
					<% End If %>
					</li>
			<%
					set cEventItem.FCategoryPrdList(intI) = nothing
				Next
			%>
				</ul>
			</div>
		 <% Else %>
			<div class="pdtWrap pdt200V15">
				<ul class="pdtList">
			<%
				For intI =intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if							
					If cEventItem.FCategoryPrdList(intI).FItemSize="1" or cEventItem.FCategoryPrdList(intI).FItemSize="100" Then Exit For
			%>
				<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >			
				<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>				
					<div class="pdtBox">
						<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage200="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage200)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage200%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"200","200","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"200","200","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
					</div>
				<% Else %>					
					<div class="pdtBox">
						<% '// 해외직구배송작업추가(원승현) %>						
						<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
							<i class="abroad-badge">해외직구</i>
						<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><% if Not(cEventItem.FCategoryPrdList(intI).Ftentenimage200="" Or isnull(cEventItem.FCategoryPrdList(intI).Ftentenimage200)) Then %> <img src="<%=cEventItem.FCategoryPrdList(intI).Ftentenimage200%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% Else %> <img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"200","200","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /> <% End If %> <% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"200","200","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
					</div>
				<% End If %>
					</li>
			<%
					Set cEventItem.FCategoryPrdList(intI) = nothing
				Next 
			%>
				</ul>
			</div>
<%
			End If
		end if
	end if

	'// 일반 사이즈 상품 목록 출력
	intIx = intI

	IF (iTotCnt >= intIx) THEN
		IF blnItemifno THEN 
%>
			<div class="pdtWrap pdt130V15">
				<ul class="pdtList">
			<%
				For intI =intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if												
			%>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
					<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>
					<div class="pdtBox">
						<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"130","130","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /><% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"130","130","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
								<% If cEventItem.FCategoryPrdList(intI).FItemOptionCnt="" Or cEventItem.FCategoryPrdList(intI).FItemOptionCnt="0" Then %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원~</span></p>
								<% Else %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원~</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).FItemOptionCnt%>%]</strong></p>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% If cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% Else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).FItemOptionCnt>0 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% End If %>
							</p>
						</div>
					</div>
					<% Else %>
					<div class="pdtBox">
						<% '// 해외직구배송작업추가(원승현) %>						
						<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
							<i class="abroad-badge">해외직구</i>
						<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
						<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>							
							<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"130","130","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /><% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"130","130","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=cEventItem.FCategoryPrdList(intI).FMakerId %>"><%=cEventItem.FCategoryPrdList(intI).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><%=cEventItem.FCategoryPrdList(intI).FItemName%></a></p>
							<% If blnitempriceyn = "1" Then %>
							<% Else %>
								<% If cEventItem.FCategoryPrdList(intI).FItemDiv="30" Then %>
									<%'' 이니렌탈 가격 표시 %>
									<p class="pdtPrice"><span class="finalP">월 <%=FormatNumber(RentalPriceCalculationDataInEventList(cEventItem.FCategoryPrdList(intI).getRealPrice),0)%>원~</span></p>
								<% Else %>														
									<% if cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem Then %>
										<% IF cEventItem.FCategoryPrdList(intI).IsSaleItem then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=cEventItem.FCategoryPrdList(intI).getSalePro%>]</strong></p>
										<% End If %>
										<% IF cEventItem.FCategoryPrdList(intI).IsCouponItem Then %>
											<% if Not(cEventItem.FCategoryPrdList(intI).IsFreeBeasongCoupon() or cEventItem.FCategoryPrdList(intI).IsSaleItem) Then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)%>원</span></p>
											<% end If %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=cEventItem.FCategoryPrdList(intI).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0) & chkIIF(cEventItem.FCategoryPrdList(intI).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
								<% End If %>
							<p class="pdtStTag tPad10">
								<% IF cEventItem.FCategoryPrdList(intI).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% else %>
									<% IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
									<% IF cEventItem.FCategoryPrdList(intI).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% end if %>
							</p>
							<% End If %>
						</div>
						<ul class="pdtActionV15">
							<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=cEventItem.FCategoryPrdList(intI).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
							<li class="postView"><a href="" <%=chkIIF(cEventItem.FCategoryPrdList(intI).Fevalcnt>0,"onclick=""popEvaluate('" & cEventItem.FCategoryPrdList(intI).FItemid & "');return false;""","onclick=""return false;""")%>><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).Fevalcnt,0)%></span></a></li>
							<li class="wishView"><a href="" onclick="TnAddFavorite('<%=cEventItem.FCategoryPrdList(intI).FItemid %>');return false;"><span><%=FormatNumber(cEventItem.FCategoryPrdList(intI).FfavCount,0)%></span></a></li>
						</ul>
					</div>
					<% End If %>
					</li>
			<%
					set cEventItem.FCategoryPrdList(intI) = nothing
				Next
			%>
				</ul>
			</div>
			<%set cEventItem = nothing%>
	   <% Else %>
			<div class="pdtWrap pdt130V15">
				<ul class="pdtList">
			<%
				For intI =intIx To iTotCnt
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID & "&" & logparam					
					adultChkFlag = session("isAdult") <> true and cEventItem.FCategoryPrdList(intI).FadultType = 1
					
					If cEventItem.FCategoryPrdList(intI).FItemDiv="21" then
						classStr = addClassStr(classStr,"deal-item")							
					end if
					If cEventItem.FCategoryPrdList(intI).isSoldOut=true then
						classStr = addClassStr(classStr,"soldOut")							
					end if				
					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if							
			%>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
				<% If cEventItem.FCategoryPrdList(intI).FItemDiv="21" Then %>					
						<div class="pdtBox">
							<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
							<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>								
								<a href="/deal/deal.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"130","130","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /><% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"130","130","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
							</div>
						</div>
				<% Else %>					
						<div class="pdtBox">
							<% '// 해외직구배송작업추가(원승현) %>						
							<% If cEventItem.FCategoryPrdList(intI).IsDirectPurchase Then %>
								<i class="abroad-badge">해외직구</i>
							<% End If %>
						<% if cEventItem.FCategoryPrdList(intI).Fiskimtentenrecom="Y" or cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
									<span class="badge_anniv21">
										<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
									</span>
								<% end if %>
							<% end if %>
						<% end if %>
							<div class="pdtPhoto">
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>								
								<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>"><span class="soldOutMask"></span><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"130","130","true","false")%>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName%>" /><% if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"130","130","true","false")%>" alt="<%=Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")%>" /></dfn><% end if %></a>
							</div>
						</div>
				<% End If %>
					</li>
			<%
					Set cEventItem.FCategoryPrdList(intI) = nothing
				Next 
			%>
				</ul>
			</div>
<%			
			Set cEventItem = nothing
		End If
	End IF
End Sub

'----------------------------------------------------
' sbSlidetemplate : 슬라이드 템플릿 PCWEB
' 2016-02-17 이종화
'----------------------------------------------------
Sub sbSlidetemplate

	IF eCode = "" THEN Exit Sub
	
	Dim vSArray , intSL , gubuncls
	'template
	set cEventadd = new ClsEvtCont
	cEventadd.FECode 	= eCode
	cEventadd.fnGetSlideTemplate_main
	'slide
	vSArray = cEventadd.fnGetSlideTemplate_sub

	If cEventadd.FSgubun = "1" Then
		gubuncls = " wideSlide" '//와이드 슬라이드
	ElseIf cEventadd.FSgubun = "2" Then
		gubuncls = " wideSwipe" '//와이드+풀단 슬라이드
	ElseIf cEventadd.FSgubun = "3" Then
		gubuncls = " fullSlide" '//풀단 슬라이드
	End If

	If cEventadd.FSidx <> "" Then 
%>
	<div class="slideTemplateV15 <%=gubuncls%>">
		<% If cEventadd.FStopimg <> "" Then %>
		<div class="evtTop" <% If cEventadd.FStopaddimg <> "" Then %>style="background-image:url(<%=cEventadd.FStopaddimg%>);"<% End If %>>
			<img src="<%=cEventadd.FStopimg%>" alt="" />
		</div>
		<% End If %>
		<div class="swiper-container" <% If cEventadd.FSpcadd1 <>"" Then %>style="background-image:url(<%=cEventadd.FSpcadd1%>);"<% End If %>>
			<div class="swiper-wrapper">
				<% 
					If isArray(vSArray) THEN 
						For intSL = 0 To UBound(vSArray,2)
				%>
				<div class="swiper-slide" <% If vSArray(5,intSL) <> "" Then %>style="background-image:url(<%=vSArray(5,intSL)%>);"<% End If %>>
					<% If vSArray(4,intSL) <> "" Then %><a href="<%=Trim(vSArray(4,intSL))%>"><% End If %><img src="<%=vSArray(3,intSL)%>" alt="" /><% If vSArray(4,intSL) <> "" Then %></a><% End If %>
				</div>
				<%
						Next 
					End If 
				%>
			</div>
			<div class="pagination"></div>
			<button class="slideNav btnPrev">이전</button>
			<button class="slideNav btnNext">다음</button>
			<div class="mask left"></div>
			<div class="mask right"></div>
		</div>
		<div class="evtBtm" <% If cEventadd.FSbtmaddimg <>"" Then %>style="background-image:url(<%=cEventadd.FSbtmaddimg%>);"<% End If %>>
		<% If cEventadd.FSbtmYN = "Y" Then %>
			<% IF cEventadd.FSbtmimg <> "" THEN %>
			<img src="<%=cEventadd.FSbtmimg%>" alt="" />
			<% End If %>
		<% Else %>
			<%=db2html(cEventadd.FSbtmcode)%>
		<% End If %>
		</div>
	</div>
<%
	End If 
End Sub

Sub sbSlidetemplateMD
	IF eCode = "" THEN Exit Sub
	
	Dim vSArray , intSL , gubuncls
	'template
	set cEventadd = new ClsEvtCont
	cEventadd.FECode 	= eCode
	cEventadd.fnGetSlideTemplate_main
	'slide
	vSArray = cEventadd.fnGetSlideTemplate_sub

	If cEventadd.FSidx <> "" Then 
		If isArray(vSArray) THEN 
			For intSL = 0 To UBound(vSArray,2)
	%>
	<div><% If vSArray(4,intSL) <> "" Then %><a href="<%=Trim(vSArray(4,intSL))%>"><% End If %><img src="<%=vSArray(3,intSL)%>" alt="" /><% If vSArray(4,intSL) <> "" Then %></a><% End If %></div>
	<%
			Next 
		End If 
	End If 
End Sub

Sub sbSlidetemplateItemMD
	IF eCode = "" THEN Exit Sub
	
	Dim intSL , gubuncls
	'template
	set cEventadd = new ClsEvtItem
	cEventadd.FECode 	= eCode
	cEventadd.fnGetMDSlideTemplate_sub

	If cEventadd.FResultCount >= 1 Then 
		for intSL=0 to cEventadd.FResultCount-1
	%>
	<div><a href="/shopping/category_prd.asp?itemid=<%=cEventadd.FCategoryPrdList(intSL).FItemID%>&pEtr=<%=eCode%>"><img src="<%=cEventadd.FCategoryPrdList(intSL).FImageList%>" alt="" /></a></div>
	<%
		Next 
	End If 
End Sub

Sub sbSlidetemplateCntMD
	IF eCode = "" And mdtheme ="" THEN Exit Sub
	
	Dim intSL , gubuncls, Tcnt, vSArray
	'template
	If mdtheme=3 Then
	set cEventadd = new ClsEvtItem
	cEventadd.FECode 	= eCode
	cEventadd.fnGetMDSlideTemplate_sub
	Tcnt = cEventadd.FResultCount-1
	ElseIf mdtheme=2 Then
	set cEventadd = new ClsEvtCont
	cEventadd.FECode 	= eCode
	cEventadd.fnGetSlideTemplate_main
	vSArray = cEventadd.fnGetSlideTemplate_sub
		IF isArray(vSArray) THEN
		Tcnt = UBound(vSArray,2)
		Else
		Tcnt=0
		End If
	Else
	Tcnt=0
	End If
	If Tcnt=0 Then Tcnt=1
	Response.write Tcnt
End Sub

Function fnEvtItemGroupLinkInfo(LinkKind)
	If LinkKind="1" Then
		fnEvtItemGroupLinkInfo = "/search/search_result.asp?rect="
	ElseIf LinkKind="2" Then
		fnEvtItemGroupLinkInfo = "/event/eventmain.asp?eventid="
	ElseIf LinkKind="3" Then
		fnEvtItemGroupLinkInfo = "/shopping/category_prd.asp?itemid="
	ElseIf LinkKind="4" Then
		fnEvtItemGroupLinkInfo = "/shopping/category_list.asp?disp="
	ElseIf LinkKind="5" Then
		fnEvtItemGroupLinkInfo = "/street/street_brand.asp?makerid="
	End If
End Function

Function fnEvtItemGroupLinkTitle(LinkKind)
	If LinkKind="1" Then
		fnEvtItemGroupLinkTitle = "더보기"
	ElseIf LinkKind="2" Then
		fnEvtItemGroupLinkTitle = "이벤트 바로가기"
	ElseIf LinkKind="3" Then
		fnEvtItemGroupLinkTitle = "상품 바로가기"
	ElseIf LinkKind="4" Then
		fnEvtItemGroupLinkTitle = "카테고리 더보기"
	ElseIf LinkKind="5" Then
		fnEvtItemGroupLinkTitle = "브랜드 바로가기"
	End If
End Function


'--------------------------------------------------------------
' sbMDTemplateItemListView : H형 추가 템플릿 아이템 리스트
' 2018-08-21 정태훈
'==============================================================
' 기차바 상품일 경우 : go-grpbar 두개 클래스 추가
' 상품갯수가 4,7,8개일 경우 : item-240 클래스 추가
' 상품갯수가 3,5,6개일 경우 : item-280 클래스 추가
' 상품 갯수 2개일 경우 : item-400 클래스 추가
' 할인율만 노출 시킬 경우 only-discount 클래스
'--------------------------------------------------------------
Sub sbMDTemplateItemListView

	If eCode = "" Then Exit Sub
	
	Dim vSArray , intI , gubuncls, ItemSize
	Set cEventItem = New ClsEvtItem
	cEventItem.FECode = eCode
	cEventItem.FGroupItemCheck = GroupItemCheck
	cEventItem.FGroupItemType = GroupItemType
	cEventItem.fnGetMDTemplateItemList
	iTotCnt = cEventItem.FTotCnt

	intI = 0

	If (iTotCnt >= 1) Then
		If iTotCnt <= 1 Then
			ItemSize = " item-400"
		ElseIf iTotCnt = 2 Or iTotCnt = 4 Or iTotCnt = 5 Then
			ItemSize = " item-280"
		ElseIf iTotCnt = 3 Or iTotCnt = 6 Or iTotCnt = 7 Then
			ItemSize = " item-240"
		Else
			ItemSize = " item-240"
		End If
%>
								<div class="evt-prdV18">
									<div class="items type-thumb<%=ItemSize%><% If GroupItemPriceView="N" Then %> only-discount<% End If %>">
										<ul>
											<% For intI =0 To iTotCnt %>
											<li>
												<% If GroupItemCheck="T" Then %>
												<a href="#group<%=cEventItem.FCategoryPrdList(intI).FitemScore %>">
												<% ElseIf GroupItemCheck="B" Then %>
												<a href="javascript:GoToBrandShop('<%=cEventItem.FCategoryPrdList(intI).FMakerid %>');">
												<% Else %>
												<a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(intI).FItemID %><%=logparam%>">
												<% End If %>
													<span class="thumbnail">
														<img src="<%=cEventItem.FCategoryPrdList(intI).FImageBasic %>" alt="<%=cEventItem.FCategoryPrdList(intI).FItemName %>">
														<em class="label-group">
															<% If cEventItem.FCategoryPrdList(intI).Fevalcnt="Y" Then %>
															<em class="new-label">NEW</em>
															<% End If %>
															<% If cEventItem.FCategoryPrdList(intI).FItemOptionCnt="Y" Then %>
															<em class="best-label">BEST</em>
															<% End If %>
														</em>
													</span>
													<span class="desc">
														<span class="name"><%=cEventItem.FCategoryPrdList(intI).FItemName %><span class="arrow-bottom bottom3"></span></span>
														<span class="price">
															<% If cEventItem.FCategoryPrdList(intI).IsSaleItem Or cEventItem.FCategoryPrdList(intI).isCouponItem Then %>
																<% If cEventItem.FCategoryPrdList(intI).IsSaleItem and not(cEventItem.FCategoryPrdList(intI).isCouponItem) Then %>
																<span class="discount color-red"><%=cEventItem.FCategoryPrdList(intI).getSalePro%></span>
																<span class="sum"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원</span>
																<% elseIf not(cEventItem.FCategoryPrdList(intI).IsSaleItem) and cEventItem.FCategoryPrdList(intI).isCouponItem Then %>
																<span class="discount color-green"><%=cEventItem.FCategoryPrdList(intI).GetCouponDiscountStr%></span>
																	<span class="sum"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).GetCouponAssignPrice,0)%>원</span>
																<% else %>
																<span class="discount color-red"><%=cEventItem.FCategoryPrdList(intI).getSalePro%></span>
																<span class="discount color-green"> + <%=cEventItem.FCategoryPrdList(intI).GetCouponDiscountStr%></span>
																	<span class="sum"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).GetCouponAssignPrice,0)%>원</span>
																<% End If %>
															<% Else %>
																<span class="sum"><%=FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0)%>원</span>
															<% End If %>
														</span>
													</span>
												</a>
											</li>
											<% Next %>
										</ul>
									</div>
								</div>
<%
	End If
End Sub

'----------------------------------------------------
' sbMultiContentsSlidetemplate : 멀티 컨텐츠 슬라이드 템플릿 PCWEB
' 2019.10.17 정태훈
'----------------------------------------------------
Function sbMultiContentsSlidetemplate(MenuIDX)

	IF MenuIDX = "" THEN Exit Function
	
	Dim vSArray , intSL , gubuncls
	'template
	set cEventadd = new ClsEvtCont
	cEventadd.FMenuIDX 	= MenuIDX
	cEventadd.fnGetMultiContentsSlideTemplateInfo
	'slide
	vSArray = cEventadd.fnGetMultiContentsSlideTemplateImages

	If cEventadd.FSgubun = "1" Then
		gubuncls = "wideSlide" '//와이드 슬라이드
	ElseIf cEventadd.FSgubun = "2" Then
		gubuncls = "wideSwipe" '//와이드+풀단 슬라이드
	ElseIf cEventadd.FSgubun = "3" Then
		gubuncls = "fullSlide" '//풀단 슬라이드
	End If

	If cEventadd.FSidx <> "" Then 
%>
	<div class="slideTemplateV15 <%=gubuncls%>">
		<% If cEventadd.FStopimg <> "" Then %>
		<div class="evtTop" <% If cEventadd.FStopaddimg <> "" Then %>style="background-image:url(<%=cEventadd.FStopaddimg%>);"<% End If %>>
			<img src="<%=cEventadd.FStopimg%>" alt="" />
		</div>
		<% End If %>
		<div class="swiper-container" <% If cEventadd.FSpcadd1 <>"" Then %>style="background-image:url(<%=cEventadd.FSpcadd1%>);"<% End If %>>
			<div class="swiper-wrapper">
				<% 
					If isArray(vSArray) THEN
						slide_w_flagmulti="Y"
						For intSL = 0 To UBound(vSArray,2)
				%>
				<div class="swiper-slide" <% If vSArray(5,intSL) <> "" Then %>style="background-image:url(<%=vSArray(5,intSL)%>);"<% End If %>>
					<% If vSArray(4,intSL) <> "" Then %><a href="<%=Trim(vSArray(4,intSL))%>"><% End If %><img src="<%=vSArray(3,intSL)%>" alt="" /><% If vSArray(4,intSL) <> "" Then %></a><% End If %>
				</div>
				<%
						Next 
					End If 
				%>
			</div>
			<div class="pagination"></div>
			<button class="slideNav btnPrev">이전</button>
			<button class="slideNav btnNext">다음</button>
			<div class="mask left"></div>
			<div class="mask right"></div>
		</div>
		<div class="evtBtm" <% If cEventadd.FSbtmaddimg <>"" Then %>style="background-image:url(<%=cEventadd.FSbtmaddimg%>);"<% End If %>>
		<% If cEventadd.FSbtmYN = "Y" Then %>
			<% IF cEventadd.FSbtmimg <> "" THEN %>
			<img src="<%=cEventadd.FSbtmimg%>" alt="" />
			<% End If %>
		<% Else %>
			<%=db2html(cEventadd.FSbtmcode)%>
		<% End If %>
		</div>
	</div>
<%
	End If 
End Function

'----------------------------------------------------
' sbMultiContentsTopSlide : 멀티 컨텐츠 슬라이드 템플릿 PCWEB
' 2019.10.17 정태훈
'----------------------------------------------------
Function sbMultiContentsTopSlide(MenuIDX)

	IF MenuIDX = "" THEN Exit Function
	
	Dim vSArray , intSL , gubuncls
	'template
	set cEventadd = new ClsEvtCont
	cEventadd.FMenuIDX 	= MenuIDX
	arrAddTopSlide = cEventadd.fnGetTopSlideTemplateMulti
%>
<% If isArray(arrAddTopSlide) Then '//이미지들 있음 %>
<div class="full-contV19<% If textbgcolor<>1 Then %> blk<% else %> wht<% end if %>"<% if newGiftBox="" then %> id="topslide"<% end if %>>
	<div class="rolling">
		<div class="slider">
			<% For intAi = 0 To UBound(arrAddTopSlide,2) %>
			<%
			slideImage = arrAddTopSlide(0,intAi)
			slideLinkURL = arrAddTopSlide(1,intAi)
			slideBGLeft = arrAddTopSlide(2,intAi)
			slideBGRight = arrAddTopSlide(3,intAi)
			slideContentsAlign = arrAddTopSlide(4,intAi)
			%>
			<% if slideContentsAlign=1 then %>
			<div class="rolling-item" style="background-image:url(<%=slideImage%>);">
				<div class="bg-color left" style="background-color:<%=slideBGLeft%>;"></div>
				<div class="bg-color right" style="background-color:<%=slideBGRight%>;"></div>
			</div>
			<% else %>
			<div class="rolling-item bg-wide" style="background-image:url(<%=slideImage%>);"></div>
			<% End If %>
			<% Next %>
		</div>
		<div class="pagination-progressbar"><span class="pagination-progressbar-fill"></span></div>
	</div>
	<div class="desc<% if GroupItemType="C" then %> ct<% else %> lt<% end if %>">
		<% If (salePer<>"" And salePer>"0") Or (saleCPer<>"" And saleCPer>"0") or (blngift) or (isOnePlusOne) or (isNew)  or (isOnlyTen) or (blncomment or blnbbs or blnitemps) Then %>
		<div class="labels">
			<% If salePer<>"" And salePer>"0" and blnsale Then %>
			<span class="labelV18 label-red">~<%=salePer%>%</span>
			<% End If %>
			<% If saleCPer<>"" And saleCPer>"0" and blncoupon Then %>
			<span class="labelV18 label-green">+<%=saleCPer%>%</span>
			<% End If %>
			<% If blngift Then %>&nbsp;<span class="labelV18 label-blue">GIFT</span><% end if %>
			<% If isOnePlusOne Then %>&nbsp;<span class="labelV18 label-blue">1+1</span><% end if %>
			<% If isNew Then %>&nbsp;<span class="labelV18 label-black">런칭</span><% end if %>
			<% If blncomment or blnbbs or blnitemps Then %>&nbsp;<span class="labelV18 label-black">참여</span><% end if %>
			<% If isOnlyTen Then %>&nbsp;<span class="labelV18 label-blue">단독</span><% end if %>
		</div>
		<% End If %>
		<p class="title"><%=eOnlyName%></p>
		<p class="subcopy"><%=chrbyte(evt_subcopyk,50,"Y")%></p>
		<div class="btn-group"> <!-- for dev msg : 테마색상 등록 -->
			<% If (blncomment) Then %>
			<a href="#commentarea" style="color:<%=ThemeColorCode%>;" class="btn-go">코멘트 이벤트 <span class="arrow" style="border-color:<%=ThemeColorCode%>;"></span></a>
			<% End If %>
			<%If (blnbbs) Then %>
			<a href="#photocmtarea" style="color:<%=ThemeColorCode%>;" class="btn-go">포토 코멘트 이벤트 <span class="arrow" style="border-color:<%=ThemeColorCode%>;"></span></a>
			<% End If %>
			<%If (blnitemps) Then %>
			<a href="#reviewarea" style="color:<%=ThemeColorCode%>;" class="btn-go">상품후기 이벤트 <span class="arrow" style="border-color:<%=ThemeColorCode%>"></span></a>
			<% End If %>
		</div>
	</div>
</div>
<%
End If 
End Function

'--------------------------------------------------------------
' sbMultiContentsView : I형 멀티 컨텐츠
' 2019-02-13 정태훈
' 순서 지정 가능, 컨텐츠 중복 가능
' 2019.10.17 6-10번 컨텐츠 추가 정태훈
' 2021.01.11 12번 컨텐츠 추가 이전도
'==============================================================
' memudiv 1~5
' 1. 롤링 이미지 & 영상
' 2. 영상
' 3. 브랜드 스토리
' 4. 기차형 템플릿
' 5. 추가 텍스트 박스
' 6. 상단 슬라이드
' 7. 이미지 & HTML
' 8. 이미지 템플릿 슬라이드
' 9. 연결배너
' 10. 개발파일
' 11. 이미지 맵
' 12. 상품가격연동
'--------------------------------------------------------------
Sub sbMultiContentsView
	IF eCode = "" THEN Exit Sub
	
	Dim vSArray , intSL , gubuncls, AddContents, iTotCnt, cEventItem, txtcolor
	'멀티 컨텐츠 마스터 정보 가져오기
	set cEventadd = new ClsEvtCont
	cEventadd.FECode = eCode
	vSArray = cEventadd.fnGetEventMultiContentsMaster
	AddContents=""
	If isArray(vSArray) THEN 
		For intSL = 0 To UBound(vSArray,2)
			if vSArray(1,intSL)="1" then
				if vSArray(5,intSL)<>"" then
					AddContents = "<div class='evt-sliderV19' style='background-image:url(" & vSArray(5,intSL) & ");margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				else
					AddContents = "<div class='evt-sliderV19' style='margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				end if
				AddContents = AddContents & "	<div class='slider'>"& vbcrlf
				AddContents = AddContents & sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				AddContents = AddContents & "	</div>"& vbcrlf
				AddContents = AddContents & "	<div class='pagination-progressbar'><span class='pagination-progressbar-fill'></span></div>" & vbcrlf
				if vSArray(6,intSL)<>"" then
				AddContents = AddContents & "	<div class='bg-color left' style='background-color:" & vSArray(6,intSL) & ";'></div>" & vbcrlf
				AddContents = AddContents & "	<div class='bg-color right' style='background-color:" & vSArray(7,intSL) & ";'></div>" & vbcrlf
				end if
				AddContents = AddContents & "</div>"
				response.write AddContents
			elseif vSArray(1,intSL)="2" then
				if vSArray(5,intSL)<>"" then
					AddContents = "<div class='evt-vod' style='background-image:url(" & vSArray(5,intSL) & ");margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				else
					AddContents = "<div class='evt-vod' style='margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				end if
				AddContents = AddContents & sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				if vSArray(6,intSL)<>"" then
				AddContents = AddContents & "	<div class='bg-color left' style='background-color:" & vSArray(6,intSL) & ";'></div>" & vbcrlf
				AddContents = AddContents & "	<div class='bg-color right' style='background-color:" & vSArray(7,intSL) & ";'></div>" & vbcrlf
				end if
				AddContents = AddContents & "</div>"
				response.write AddContents
			elseif vSArray(1,intSL)="3" then
				if vSArray(5,intSL)<>"" then
					AddContents = "<div class='evt-brandV18' style='background-image:url(" & vSArray(5,intSL) & ");margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				else
					AddContents = "<div class='evt-brandV18' style='margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				end if
				AddContents = AddContents & sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				if vSArray(6,intSL)<>"" then
				AddContents = AddContents & "	<div class='bg-color left' style='background-color:" & vSArray(6,intSL) & ";'></div>" & vbcrlf
				AddContents = AddContents & "	<div class='bg-color right' style='background-color:" & vSArray(7,intSL) & ";'></div>" & vbcrlf
				end if
				AddContents = AddContents & "</div>"
				response.write AddContents
			elseif vSArray(1,intSL)="4" then
				Set cEventItem = New ClsEvtItem
				cEventItem.FMenuIDX = vSArray(0,intSL)
				cEventItem.FGroupItemCheck = vSArray(3,intSL)
				cEventItem.fnGetEventMultiContentsTrainTamplate
				iTotCnt = cEventItem.FTotCnt
				if vSArray(10,intSL)="1" then
					txtcolor="wht"
				else
					txtcolor="blk"
				end if
				if vSArray(5,intSL)<>"" then
					AddContents = "<div class='evt-prdV18 " & txtcolor & "' style='background-image:url(" & vSArray(5,intSL) & ");margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				else
					AddContents = "<div class='evt-prdV18 " & txtcolor & "' style='margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				end if
				If vSArray(2,intSL)="N" Then
					if iTotCnt="4" or iTotCnt="5" then
						AddContents = AddContents & "	<div class='items type-thumb col3 only-discount'>" & vbcrlf
					else
						AddContents = AddContents & "	<div class='items type-thumb only-discount'>" & vbcrlf
					end if
				else
					if iTotCnt="4" or iTotCnt="5" then
						AddContents = AddContents & "	<div class='items type-thumb col3'>" & vbcrlf
					else
						AddContents = AddContents & "	<div class='items type-thumb'>" & vbcrlf
					end if
				End If
				AddContents = AddContents & "		<ul>" & vbcrlf
				AddContents = AddContents & sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				AddContents = AddContents & "		</ul>" & vbcrlf
				AddContents = AddContents & "	</div>" & vbcrlf
				if vSArray(6,intSL)<>"" then
				AddContents = AddContents & "	<div class='bg-color left' style='background-color:" & vSArray(6,intSL) & ";'></div>" & vbcrlf
				AddContents = AddContents & "	<div class='bg-color right' style='background-color:" & vSArray(7,intSL) & ";'></div>" & vbcrlf
				end if
				AddContents = AddContents & "</div>"
				response.write AddContents
			elseif vSArray(1,intSL)="5" then
				if vSArray(5,intSL)<>"" then
					AddContents = "<div class='evt-descV19' style='background-image:url(" & vSArray(5,intSL) & ");margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				else
					AddContents = "<div class='evt-descV19' style='margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				end if
				AddContents = AddContents & "	<div class='inner'>" & vbcrlf
				AddContents = AddContents & sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				AddContents = AddContents & "	</div>" & vbcrlf
				if vSArray(6,intSL)<>"" then
				AddContents = AddContents & "	<div class='bg-color left' style='background-color:" & vSArray(6,intSL) & ";'></div>" & vbcrlf
				AddContents = AddContents & "	<div class='bg-color right' style='background-color:" & vSArray(7,intSL) & ";'></div>" & vbcrlf
				end if
				
				AddContents = AddContents & "</div>" & vbcrlf
				response.write AddContents
			elseif vSArray(1,intSL)="6" then
				AddContents = sbMultiContentsTopSlide(vSArray(0,intSL))
				response.write AddContents
			elseif vSArray(1,intSL)="7" then
				if vSArray(5,intSL)<>"" then
					AddContents = "<div class='evt-descV19' style='background-image:url(" & vSArray(5,intSL) & ");margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				else
					AddContents = "<div class='evt-descV19' style='margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				end if
				if vSArray(8,intSL)="1" then
				AddContents = AddContents & "	<div class='inner'>" & vbcrlf
				AddContents = AddContents & sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				AddContents = AddContents & "	</div>" & vbcrlf
				else
				AddContents = AddContents & sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				end if
				if vSArray(6,intSL)<>"" then
				AddContents = AddContents & "	<div class='bg-color left' style='background-color:" & vSArray(6,intSL) & ";'></div>" & vbcrlf
				AddContents = AddContents & "	<div class='bg-color right' style='background-color:" & vSArray(7,intSL) & ";'></div>" & vbcrlf
				end if
				AddContents = AddContents & "</div>" & vbcrlf
				response.write AddContents
			elseif vSArray(1,intSL)="8" then
				AddContents = sbMultiContentsSlidetemplate(vSArray(0,intSL))
				response.write AddContents
			elseif vSArray(1,intSL)="9" then
				if vSArray(5,intSL)<>"" then
					AddContents = "<div class='evt-descV19' style='background-image:url(" & vSArray(5,intSL) & ");margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				else
					AddContents = "<div class='evt-descV19' style='margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				end if
				AddContents = AddContents & sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				if vSArray(6,intSL)<>"" then
				AddContents = AddContents & "	<div class='bg-color left' style='background-color:" & vSArray(6,intSL) & ";'></div>" & vbcrlf
				AddContents = AddContents & "	<div class='bg-color right' style='background-color:" & vSArray(7,intSL) & ";'></div>" & vbcrlf
				end if
				AddContents = AddContents & "</div>" & vbcrlf
				response.write AddContents
			elseif vSArray(1,intSL)="10" then
				AddContents = sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				response.write AddContents
			elseif vSArray(1,intSL)="11" then
				if vSArray(5,intSL)<>"" then
					AddContents = "<div class='evt-descV19' style='background-image:url(" & vSArray(5,intSL) & ");margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				else
					AddContents = "<div class='evt-descV19' style='margin-top:" & vSArray(9,intSL) & "px;'>" & vbcrlf
				end if
				AddContents = AddContents & sbMultiContentsDetail(vSArray(0,intSL), vSArray(1,intSL), vSArray(3,intSL))
				if vSArray(6,intSL)<>"" then
				AddContents = AddContents & "	<div class='bg-color left' style='background-color:" & vSArray(6,intSL) & ";'></div>" & vbcrlf
				AddContents = AddContents & "	<div class='bg-color right' style='background-color:" & vSArray(7,intSL) & ";'></div>" & vbcrlf
				end if
				AddContents = AddContents & "</div>" & vbcrlf
				response.write AddContents
			elseif vSArray(1,intSL)="12" then '// 상품 가격 연동
				Dim Margin, MarginBottom, MarginColor, MarginBottomColor
				Margin = vSArray(21,intSL) '// 상단여백
				MarginColor = chkiif(vSArray(22,intSL) <> "", vSArray(22,intSL), "#FFF") '// 상단여백 배경색코드
				MarginBottom = vSArray(23,intSL) '// 하단여백
				MarginBottomColor = chkiif(vSArray(24,intSL) <> "", vSArray(24,intSL), "#FFF") '// 하단여백 배경색코드

				AddContents = "<div class='evt-priceV20'>"
				If Margin > 0 Then '// 상단 여백이 0px 이상이면
					AddContents = AddContents & "<div class='blank' style='height:" & Margin & "px; background-color:" & MarginColor & ";'></div>"
				End If
				AddContents = AddContents & getMultiItemContentsList(vSArray(0,intSL) , vSArray(2,intSL) , vSArray(3,intSL), vSArray(10,intSL), vSArray(11,intSL), vSArray(12,intSL), vSArray(13,intSL), vSArray(14,intSL), vSArray(15,intSL), vSArray(16,intSL), vSArray(17,intSL))
				If MarginBottom > 0 Then '// 하단 여백이 0px 이상이면
					AddContents = AddContents & "<div class='blank' style='height:" & MarginBottom & "px; background-color:" & MarginBottomColor & ";'></div>"
				End If
				AddContents = AddContents & "</div>"
				response.write AddContents
			end if
		Next
	else
		AddContents = "<script>$('#topslide').css('margin-bottom','20px')</script>"
	End If
End Sub

'// GET 가격연동 컨텐츠 영역 HTML
public function getMultiItemContentsList(IDX , GroupItemPriceView , GroupItemCheck , TextColor , GroupItemTitleName , GroupItemViewType , GroupItemBrandName , SaleColor , PriceColor , OrgPriceColor, BGImage)
	IF IDX = "" THEN Exit Function
	IF GroupItemViewType = "" THEN Exit Function

	'// 테스트 Print
	'dim alertStr
	'alertStr = ""
	'alertStr = alertStr & " 인덱스 : " & IDX
	'alertStr = alertStr & "\n 타입 : " & GroupItemViewType
	'alertStr = alertStr & "\n 가격 노출 여부 : " & GroupItemPriceView
	'alertStr = alertStr & "\n 상품명 노출 여부 : " & GroupItemTitleName
	'alertStr = alertStr & "\n 브랜드명 노출 여부 : " & GroupItemBrandName
	'alertStr = alertStr & "\n 상품명/브랜드명 색코드 : " & TextColor
	'alertStr = alertStr & "\n 할인율 색코드 : " & SaleColor
	'alertStr = alertStr & "\n 가격 색코드 : " & PriceColor
	'alertStr = alertStr & "\n 기존가격 색코드 : " & OrgPriceColor
	'alertStr = alertStr & "\n GroupItemCheck(?) : " & GroupItemCheck
	'alertStr = alertStr & "\n 배경이미지 : " & BGImage
	'Response.Write "<script>alert('" & alertStr & "');</script>"

	'// 색 Default 설정
	If TextColor = "" Then TextColor = "#222" End If
	If SaleColor = "" Then SaleColor = "#222" End If
	If PriceColor = "" Then PriceColor = "#222" End If
	If OrgPriceColor = "" Then OrgPriceColor = "#222" End If

	DIM BodyContents , ArrContents , iTotCnt , cEventItem , intSL
	dim totalPrice , salePercentString , couponPercentString , totalSalePercent
		
	Set cEventItem = New ClsEvtItem
	cEventItem.FMenuIDX = IDX
	cEventItem.FGroupItemCheck = GroupItemCheck
	cEventItem.fnGetEventMultiContentsTrainTamplate
	iTotCnt = cEventItem.FTotCnt

	ArrContents = ""
	If (iTotCnt >= 0) Then
		IF GroupItemViewType = "A" OR GroupItemViewType = "B" THEN '// A or B
			For intSL=0 To iTotCnt
				'// 배경이미지
				Dim thisBackgroundImage
				If cEventItem.FCategoryPrdList(intSL).FPCImageUrl <> "" Then
					thisBackgroundImage = cEventItem.FCategoryPrdList(intSL).FPCImageUrl
				Else
					thisBackgroundImage = cEventItem.FCategoryPrdList(intSL).FImageBasic
				End If
				'// 상품설명 Left & Top Style
				Dim thisItemDescLocation
				If cEventItem.FCategoryPrdList(intSL).FXPosition <> "" And cEventItem.FCategoryPrdList(intSL).FYPosition <> "" Then '// 좌표값이 저장되어 있으면 좌표값
					thisItemDescLocation = "left:" & cEventItem.FCategoryPrdList(intSL).FXPosition & "%; top:" & cEventItem.FCategoryPrdList(intSL).FYPosition & "%;"
				ElseIf GroupItemViewType = "A" Then
					thisItemDescLocation = "left:55%; top:76%;"
				ElseIf GroupItemViewType = "B" Then
					thisItemDescLocation = "left:15%; top:85%;"
				End If

				ArrContents = ArrContents & "<div class='evt-itemV20 "& chkiif( GroupItemViewType = "A" , "typeA" , "typeB" ) &"' " & chkiif( BGImage <> "", "style='background-image:url(" & BGImage & ");'", "" ) & ">"
				ArrContents = ArrContents & "<a href='/shopping/category_prd.asp?itemid=" + Cstr(cEventItem.FCategoryPrdList(intSL).FItemID) + logparam + "'>" & VbCrlf
				ArrContents = ArrContents & "<div class='thumbnail'><img src='"& thisBackgroundImage &"' alt='"& cEventItem.FCategoryPrdList(intSL).FItemName &"'></div>"
				ArrContents = ArrContents & createPriceLinkageItemDescHtml(cEventItem.FCategoryPrdList(intSL), thisItemDescLocation, GroupItemBrandName _
								 ,GroupItemTitleName, GroupItemPriceView, TextColor, SaleColor, OrgPriceColor, PriceColor)
				ArrContents = ArrContents & "</a>"
				ArrContents = ArrContents & "</div>"
			Next
		Else '// 가로, 세로형(Type A, B)
			Dim thisContentType '// Type
			thisContentType = chkiif(GroupItemViewType = "C" or GroupItemViewType = "D", "A", "B")

			ArrContents = "<div class='evt-prdV18' " & chkiif( BGImage <> "", "style='background-image:url(" & BGImage & ");'", "" ) & ">"
			ArrContents = ArrContents & "<div class='items type-thumb'>"
			ArrContents = ArrContents & "<ul>"
				FOR intSL = 0 TO iTotCnt
					Dim thisThumbnail '// 배경이미지
					If cEventItem.FCategoryPrdList(intSL).FPCImageUrl <> "" Then
						thisThumbnail = cEventItem.FCategoryPrdList(intSL).FPCImageUrl
					Else
						thisThumbnail = cEventItem.FCategoryPrdList(intSL).FImageBasic
					End If

					ArrContents = ArrContents & "<li>"
					ArrContents = ArrContents & "<div class='evt-itemV20 type" & thisContentType & "'>"
					ArrContents = ArrContents & "<a href='/shopping/category_prd.asp?itemid=" + Cstr(cEventItem.FCategoryPrdList(intSL).FItemID) + logparam + "'>"
					ArrContents = ArrContents & "<div class='thumbnail'><img src='"& thisThumbnail &"' alt='"& cEventItem.FCategoryPrdList(intSL).FItemName &"'></div>"
					ArrContents = ArrContents & createPriceLinkageItemDescHtml(cEventItem.FCategoryPrdList(intSL), "", GroupItemBrandName _
								 ,GroupItemTitleName, GroupItemPriceView, TextColor, SaleColor, OrgPriceColor, PriceColor)
					ArrContents = ArrContents & "</a>"
					ArrContents = ArrContents & "</div>"
					ArrContents = ArrContents & "</li>"
				NEXT
			ArrContents = ArrContents & "</ul>"
			ArrContents = ArrContents & "</div>"
			ArrContents = ArrContents & "</div>"
		End If
	End If

	getMultiItemContentsList = ArrContents

	Set cEventItem = Nothing
end function 

'// 가격연동 템플릿 상품 desc영역 HTML 생성
' = linkItem		: 상품
' = itemDescLocation: 상품설명 좌표 위치('left:x%; top:y%;')
' = brandViewYn		: 브랜드명 노출 여부 (Y/N)
' = nameViewYn		: 상품명 노출 여부 (Y/N)
' = priceViewYn		: 가격영역 노출 여부 (Y/N)
' = textColor		: 브랜드명/상품명 텍스트 색코드
' = saleColor		: 할인율 텍스트 색코드
' = orgPriceColor	: 정가 텍스트 색코드
' = priceColor		: 가격 텍스트 색코드
Private Function createPriceLinkageItemDescHtml(linkItem, itemDescLocation, brandViewYn, nameViewYn, priceViewYn, textColor, saleColor, orgPriceColor, priceColor)
	Dim contentHtml
	contentHtml = "<div class='desc' style='"& itemDescLocation &"'>"
	If brandViewYn = "Y" Then '// 브랜드명
		contentHtml = contentHtml & "<span class='brand' style='color:" & textColor & ";'>"& linkItem.FBrandName &"</span>"
	End If
	If nameViewYn = "Y" Then '// 상품명
		contentHtml = contentHtml & "<p class='name' style='color:" & textColor & ";'>"& linkItem.FItemName &"</p>"
	End If
	If priceViewYn = "Y" Then '// 가격정보
		contentHtml = contentHtml & "<div class='price'>"
		If linkItem.FProductTotalSalePercent <> "" And linkItem.FProductTotalSalePercent <> "0" Then '// 할인율
			contentHtml = contentHtml & "<p class='origin-price' style='color:" & orgPriceColor & ";'>"& FormatNumber(linkItem.getOrgPrice,0) &"</p>"
			contentHtml = contentHtml & "<b class='discount' style='color:" & saleColor & ";'>"& linkItem.FProductTotalSalePercent &"</b>"
		End If
		contentHtml = contentHtml & "<span class='sum' style='color:" & priceColor & ";'>"& linkItem.FProductTotalPrice & "원</span>"
		contentHtml = contentHtml & "</div>"
	End If
	createPriceLinkageItemDescHtml = contentHtml & "</div>"
End Function

Public Function sbMultiContentsDetail(IDX, MenuDIV, GroupItemCheck)
	IF IDX = "" THEN Exit Function

	dim ArrContents, vSArray, intSL, iTotCnt, cEventItem
	'멀티 컨텐츠 마스터 정보 가져오기
	set cEventadd = new ClsEvtCont
	cEventadd.FMenuIDX = IDX
	if MenuDIV="1" then
		vSArray = cEventadd.fnGetEventMultiContentsSwife
	elseif MenuDIV="2" then
		vSArray = cEventadd.fnGetEventMultiContentsVideo
	elseif MenuDIV="3" then
		vSArray = cEventadd.fnGetEventMultiContentsBrandStory
	elseif MenuDIV="4" then
		Set cEventItem = New ClsEvtItem
		cEventItem.FMenuIDX = IDX
		cEventItem.FGroupItemCheck = GroupItemCheck
		cEventItem.fnGetEventMultiContentsTrainTamplate
		iTotCnt = cEventItem.FTotCnt
	elseif MenuDIV="5" then
		vSArray = cEventadd.fnGetEventMultiContentsCustomBox
	elseif MenuDIV="7" then
		vSArray = cEventadd.fnGetImageHtmlTemplate
	elseif MenuDIV="9" then
		vSArray = cEventadd.fnGetPCMultiAddBanner
	elseif MenuDIV="10" then
		vSArray = cEventadd.fnGetImageHtmlTemplate
	elseif MenuDIV="11" then
		vSArray = cEventadd.fnGetImageMapTemplate
	end if
	ArrContents=""
	if MenuDIV="4" then
		If (iTotCnt >= 1) Then
			For intSL=0 To iTotCnt
				ArrContents = ArrContents & "<li>" & vbcrlf
											If GroupItemCheck="T" Then
												if cEventItem.FCategoryPrdList(intSL).FItemID <> "" then
				ArrContents = ArrContents & "	<a href='/shopping/category_prd.asp?itemid=" + Cstr(cEventItem.FCategoryPrdList(intSL).FItemID) + logparam + "'>" & vbcrlf
												else
				ArrContents = ArrContents & "	<a href='#group" + Cstr(cEventItem.FCategoryPrdList(intSL).FitemScore) + "'>" & vbcrlf
												end if
											ElseIf GroupItemCheck="B" Then
				ArrContents = ArrContents & "	<a href=""javascript:GoToBrandShop('" + cEventItem.FCategoryPrdList(intSL).FMakerid + "');"">" & vbcrlf
											Else
				ArrContents = ArrContents & "	<a href='/shopping/category_prd.asp?itemid=" + Cstr(cEventItem.FCategoryPrdList(intSL).FItemID) + logparam + "'>" & vbcrlf
											End If
				ArrContents = ArrContents & "	<span class='thumbnail'>" & vbcrlf
				ArrContents = ArrContents & "		<img src='" + cEventItem.FCategoryPrdList(intSL).FImageBasic + " ' alt='" + cEventItem.FCategoryPrdList(intSL).FItemName + "'>" & vbcrlf
				ArrContents = ArrContents & "	</span>" & vbcrlf
				ArrContents = ArrContents & "	<span class='desc'>" & vbcrlf
				ArrContents = ArrContents & "		<em class='label-group'>" & vbcrlf
														If cEventItem.FCategoryPrdList(intSL).Fevalcnt="Y" Then
				ArrContents = ArrContents & "			<em class='new-label'>NEW</em>" & vbcrlf
														End If
														If cEventItem.FCategoryPrdList(intSL).FItemOptionCnt="Y" Then
				ArrContents = ArrContents & "			<em class='best-label'>BEST</em>" & vbcrlf
														End If
				ArrContents = ArrContents & "		</em>" & vbcrlf
				ArrContents = ArrContents & "		<span class='name'>" + cEventItem.FCategoryPrdList(intSL).FItemName + " <span class='arrow-bottom bottom3'></span></span>" & vbcrlf
				ArrContents = ArrContents & "		<span class='price'>" & vbcrlf
														If cEventItem.FCategoryPrdList(intSL).IsSaleItem Or cEventItem.FCategoryPrdList(intSL).isCouponItem Then
															If cEventItem.FCategoryPrdList(intSL).IsSaleItem and not(cEventItem.FCategoryPrdList(intSL).isCouponItem) Then
				ArrContents = ArrContents & "			<span class='discount color-red'>" + cEventItem.FCategoryPrdList(intSL).getSalePro + " </span>" & vbcrlf
				ArrContents = ArrContents & "			<span class='sum'>" + FormatNumber(cEventItem.FCategoryPrdList(intSL).getRealPrice,0) + " 원</span>" & vbcrlf
															elseIf not(cEventItem.FCategoryPrdList(intSL).IsSaleItem) and cEventItem.FCategoryPrdList(intSL).isCouponItem Then
				ArrContents = ArrContents & "			<span class='discount color-green'>" + cEventItem.FCategoryPrdList(intSL).GetCouponDiscountStr + " </span>" & vbcrlf
				ArrContents = ArrContents & "			<span class='sum'>" + FormatNumber(cEventItem.FCategoryPrdList(intSL).GetCouponAssignPrice,0) + " 원</span>" & vbcrlf
															else
				ArrContents = ArrContents & "			<span class='discount color-red'>" + cEventItem.FCategoryPrdList(intSL).getSalePro + " </span>" & vbcrlf
				ArrContents = ArrContents & "			<span class='discount color-green'> + " + cEventItem.FCategoryPrdList(intSL).GetCouponDiscountStr + " </span>" & vbcrlf
				ArrContents = ArrContents & "			<span class='sum'>" + FormatNumber(cEventItem.FCategoryPrdList(intSL).GetCouponAssignPrice,0) + " 원</span>" & vbcrlf
															End If
														Else
				ArrContents = ArrContents & "			<span class='sum'>" + FormatNumber(cEventItem.FCategoryPrdList(intSL).getRealPrice,0) + " 원</span>" & vbcrlf
														End If
				ArrContents = ArrContents & "		</span>" & vbcrlf
				ArrContents = ArrContents & "	</span>" & vbcrlf
				ArrContents = ArrContents & "	</a>" & vbcrlf
				ArrContents = ArrContents & "</li>" & vbcrlf
			Next
		End If
	elseif MenuDIV="11" then
		If isArray(vSArray) then
			ArrContents = ArrContents & "<img src='" & vSArray(0,0) & "' usemap='#CustomMap" & Cstr(IDX) & "' />" & vbcrlf
			ArrContents = ArrContents & "<map name='CustomMap" & Cstr(IDX) & "'>" & vbcrlf
			For intSL = 0 To UBound(vSArray,2)
				ArrContents = ArrContents & "	<area shape='rect' coords='" & Cstr(vSArray(1,intSL)) & "," & Cstr(vSArray(2,intSL)) & "," & Cstr(vSArray(3,intSL)) & "," & Cstr(vSArray(4,intSL)) & "' href='" & Cstr(vSArray(5,intSL)) & "' onfocus='this.blur();'>" & vbcrlf
			Next
			ArrContents = ArrContents & "</map>" & vbcrlf
		end if
	else
		If isArray(vSArray) THEN
			For intSL = 0 To UBound(vSArray,2)
				if MenuDIV="1" then
					ArrContents = ArrContents & "		<div class='slide-item'><img src='" + vSArray(0,intSL) + "' alt='' /></div>" & vbcrlf '이미지
				elseif MenuDIV="2" then
					ArrContents = ArrContents & vSArray(0,intSL) & vbcrlf'동영상
				elseif MenuDIV="3" then
					if vSArray(0,intSL)<>"" then
					ArrContents = ArrContents & "	<h3>" + vSArray(0,intSL) + "<span class='arrow-right right1'></h3>" & vbcrlf
					ArrContents = ArrContents & "	<a href=""javascript:GoToBrandShop('" + vSArray(2,intSL) + "');"" class='btn-go-brand'>BRAND HOME</a>" & vbcrlf
					end if
					ArrContents = ArrContents & "	<div class='txt'>" + nl2br(db2html(vSArray(1,intSL))) + "</div>" & vbcrlf
				elseif MenuDIV="5" then
					'ArrContents = ArrContents & "	<p class='tit'>" + db2html(vSArray(0,intSL)) + "</p>" '타이틀 삭제
					ArrContents = ArrContents & "	<p class='txt'>" + nl2br(db2html(vSArray(1,intSL))) + "</p>" & vbcrlf
				elseif MenuDIV="7" then
					if vSArray(0,intSL)<>"" then
					ArrContents = ArrContents & "<img src='" & vSArray(0,intSL) & "' usemap='#Mainmap"&Cstr(IDX)&"' class='gpimg' />" & vbcrlf
					end if
					ArrContents = ArrContents & vSArray(1,intSL) & vbcrlf
				elseif MenuDIV="9" then
					If vSArray(1,intSL) <> "" Then
						ArrContents = ArrContents & "<a href='"& chkiif(vSArray(3,intSL) <> "",vSArray(3,intSL),"#") &"'><img src='"& vSArray(1,intSL) &"' alt='"& vSArray(2,intSL) &"'></a>" & vbcrlf
					End If
				elseif MenuDIV="10" then
					ArrContents = ArrContents & server.execute(vSArray(0,intSL)) & vbcrlf
				end if
			Next
		End If
	End If
	sbMultiContentsDetail=ArrContents
	
End Function

Public Function RentalPriceCalculationDataInEventList(p)
	dim rentalPee
	'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨
	If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then
		'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)
		rentalPee = 1.105
		RentalPriceCalculationDataInEventList = Fix(((p*rentalPee) / 12)/100)*100
	Else
		'// 2021년 8월 2일부터 md 요청으로 인해 12개월 기본값으로 변경
		rentalPee = 1.135
		RentalPriceCalculationDataInEventList = Fix(((p*rentalPee) / 12)/100)*100
	End If
End Function
%>