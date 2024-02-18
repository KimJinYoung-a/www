<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description :  브랜드스트리트 interview
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/street/BrandStreetCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/classes/search/keywordcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/shopping/category_code_check.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/street/inc_street_lib.asp" -->
<%
dim classStr, adultChkFlag, adultPopupLink, linkUrl
dim shopview : shopview = getNumeric(requestCheckVar(request("shopview"),1))
dim slidecode : slidecode = getNumeric(requestCheckVar(request("slidecode"),1))
If shopview = "" Then shopview = "1"
If slidecode = "" Then slidecode = "0"

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/street/street_brand.asp?makerid=" & makerid & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			dbget.Close
			REsponse.End
		end if
	end if
end if

'//logparam
Dim logparam : logparam = "&pBtr="&makerid

Dim isShowSumamry : isShowSumamry = true  ''탭별 검색 갯수 표시 여부 : 느릴경우 FALSE 로
Dim isSaveSearchKeyword : isSaveSearchKeyword = true  ''검색어 DB에 저장 여부
Dim tmpPrevSearchKeyword, tmpCurrSearchKeyword

dim SearchText : SearchText = requestCheckVar(request("rect"),100) '현재 입력된 검색어
dim PrevSearchText : PrevSearchText = requestCheckVar(request("prvtxt"),100) '이전 검색어
dim ReSearchText : ReSearchText=requestCheckVar(request("rstxt"),100) '결과내 재검색용
dim ExceptText : ExceptText=requestCheckVar(request("extxt"),100) '결과내 제외어
dim DocSearchText
dim SearchItemDiv : SearchItemDiv="y"	'기본 카테고리만
dim SearchCateDep : SearchCateDep= "T"	'하위카테고리 모두 검색

dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),5))
dim SortMet		: SortMet = request("srm")
dim SearchFlag : SearchFlag = request("sflag")
dim dispCate : dispCate = getNumeric(requestCheckVar(request("dispCate"),18))
dim CurrPage : CurrPage = getNumeric(requestCheckVar(request("cpg"),8))
dim CheckResearch : CheckResearch= request("chkr")
dim CheckExcept : CheckExcept= request("chke")
dim minPrice : minPrice = getNumeric(requestCheckVar(request("minPrc"),8))
dim maxPrice : maxPrice = getNumeric(requestCheckVar(request("maxPrc"),8))
dim deliType : deliType = request("deliType")
dim colorCD : colorCD = ReplaceRequestSpecialChar(request("iccd"))
dim styleCD : styleCD = ReplaceRequestSpecialChar(request("styleCd"))
dim attribCd : attribCd = ReplaceRequestSpecialChar(request("attribCd"))
dim arrCate : arrCate = ReplaceRequestSpecialChar(request("arrCate"))
dim SellScope 	: SellScope=requestCheckVar(request("sscp"),1)			'품절상품 제외여부
if SellScope = "" then SellScope = "N"
dim ScrollCount : ScrollCount = 10
dim ListDiv : ListDiv = "brand"		'카테고리/검색 구분용
dim LogsAccept : LogsAccept = true		'검색Log 사용여부 (검색페이지: 사용)
dim lp, ColsSize
dim sColorMode : sColorMode = "S"
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)
Dim vWordBannerChk '// 특정 검색어 링크배너 노출여부
dim diarystoryitem 	: diarystoryitem=requestCheckVar(request("diarystoryitem"),1)			'다이어리 스토리 아이템 소팅
dim parentsPage : parentsPage = "brand"

vWordBannerChk = False

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)


if isMyFavBrand then
	if SortMet="" then 	'베스트:be, 신상:ne
		SortMet="ne"
	end if
else
	if SortMet="" then 	'베스트:be, 신상:ne
		SortMet="be"
	end if
end if

dim imgSz	: imgSz = chkIIF(icoSize="M",240,150)

'// 실제 타자로 입력된 검색어인지(2013-08-02 13:08:50 적용)
dim IsRealTypedKeyword : IsRealTypedKeyword = True
if requestCheckVar(request("exkw"),1) = "1" then
	IsRealTypedKeyword = False
end if

dim chkMyKeyword : chkMyKeyword=true		'나의 검색어

if CurrPage="" then CurrPage=1
if colorCD="" then colorCD="0"
IF searchFlag="" Then searchFlag= "n"

Select Case SearchFlag
	Case "n", "sc", "fv", "pk"
		'상품 목록 크기에 따라 선택
		if icoSize="B" then
			'2행 5열(총10개)
			ColsSize =2
			IF PageSize="" or PageSize<10 then PageSize = 10
		elseif icoSize="M" then
			'4행 10열(총40개)
			ColsSize =4
			IF PageSize="" or PageSize<40 then PageSize = 40
		else
			'6행 12열(총72개)
			ColsSize =6
			IF PageSize="" or PageSize<72 then PageSize = 72
		end if
	Case "ea"
		'일반 상품후기 2행 10열(총 20개)
		PageSize=20
	Case "ep"
		'포토 상품후기 2행 3열(총 6개)
		PageSize=6
	'2012-06-05	김진영 추가
	Case Else
		SearchFlag="n"
		if icoSize="B" then
			'2행 5열(총10개)
			ColsSize =2
			IF PageSize="" or PageSize<10 then PageSize = 10
		elseif icoSize="M" then
			'4행 10열(총40개)
			ColsSize =4
			IF PageSize="" or PageSize<40 then PageSize = 40
		else
			'6행 12열(총72개)
			ColsSize =6
			IF PageSize="" or PageSize<72 then PageSize = 72
		end if
End Select

IF CStr(SearchText)=CStr(PrevSearchText) Then
	LogsAccept = false
End if

dim enc,rect
enc = Request("enc")
'인코딩 여부에 따른 값변환(UTF-8 > ASCII)
IF enc="UTF-8" THEN
	rect = URLDecodeUTF8(request.ServerVariables("QUERY_STRING"))
	rect = Replace(rect, "enc=UTF-8&", "")
	response.redirect("?" & rect)
	dbget.close()	:	response.End
END IF

if CheckResearch="undefined" then CheckResearch=""
if len(CheckResearch)>5 then CheckResearch=""
IF CheckResearch="" then CheckResearch=false
if CheckExcept="undefined" then CheckExcept=""
if len(CheckExcept)>5 then CheckExcept=""
IF CheckExcept="" then CheckExcept=false

SearchText = RepWord(SearchText,"[^가-힣a-zA-Z0-9.&%\-\s]","")
ExceptText = RepWord(ExceptText,"[^가-힣a-zA-Z0-9.&%\-\s]","")

IF CheckReSearch Then
	ReSearchText = ReSearchText & " " & SearchText

	ReSearchText = RepWord(ReSearchText,SearchText,"")
	ReSearchText = RepWord(ReSearchText,"[\s]{2,}"," ")
	ReSearchText = RepWord(ReSearchText,"^[+\s]","")
	ReSearchText = ReSearchText & " " & SearchText
	DocSearchText = ReSearchText
Else
	ReSearchText  =	SearchText
	DocSearchText = SearchText
End if

if CheckExcept then
	ReSearchText  =	ReSearchText
	DocSearchText = ReSearchText
	SearchText = ExceptText
end if

IF Len(DocSearchText)<>0 and isNumeric(DocSearchText) THEN
	If Left(DocSearchText,1) <> "0" Then
		DocSearchText = Cdbl(DocSearchText)
	End If
'	DocSearchText = Cdbl(DocSearchText)
END IF

dim iRows,i,ix

'// 총 검색수 산출
' dim oTotalCnt
' set oTotalCnt = new SearchItemCls
' 	oTotalCnt.FRectSearchTxt = DocSearchText
' 	oTotalCnt.FRectExceptText = ExceptText
' 	oTotalCnt.FRectSearchItemDiv = SearchItemDiv
' 	oTotalCnt.FRectSearchCateDep = SearchCateDep
' 	oTotalCnt.FListDiv = ListDiv
' 	oTotalCnt.FSellScope=SellScope

' 	if shopview="1" then
' 		oTotalCnt.getTotalCount
' 	end if

'// 상품검색
dim oDoc,iLp
set oDoc = new SearchItemCls
If now() >= #2022-09-01 00:00:00# and now() < #2023-02-01 00:00:00# Then
	oDoc.FRectDiaryItem = diarystoryitem
elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" then
	oDoc.FRectDiaryItem = diarystoryitem
end if
	oDoc.FRectSearchTxt = DocSearchText
	oDoc.FRectPrevSearchTxt = PrevSearchText
	oDoc.FRectExceptText = ExceptText
	oDoc.FRectSortMethod	= SortMet
	oDoc.FRectSearchFlag = searchFlag
	oDoc.FRectSearchItemDiv = SearchItemDiv
	oDoc.FRectSearchCateDep = SearchCateDep
	oDoc.FRectCateCode	= dispCate
	oDoc.FRectMakerid	= makerid
	oDoc.FminPrice	= minPrice
	oDoc.FmaxPrice	= maxPrice
	oDoc.FdeliType	= deliType
	oDoc.FCurrPage = CurrPage
	oDoc.FPageSize = PageSize
	oDoc.FScrollCount = ScrollCount
	oDoc.FListDiv = ListDiv
	oDoc.FLogsAccept = LogsAccept
	oDoc.FRectColsSize = ColsSize
	oDoc.FcolorCode = colorCD
	oDoc.FstyleCd = styleCd
	oDoc.FattribCd = attribCd
	oDoc.FSellScope=SellScope
	oDoc.FarrCate=arrCate

	if shopview="1" or shopview="2" then
		oDoc.getSearchList
	end if

'// 검색어 DB저장
tmpPrevSearchKeyword = PrevSearchText
tmpCurrSearchKeyword = SearchText

'// 검색 조건 재설정
PrevSearchText = SearchText
'CheckResearch=false

'// 검색결과 내위시 표시정보 접수
if IsUserLoginOK then
	'// 검색결과 상품목록 작성
	dim rstArrItemid: rstArrItemid=""
	IF oDoc.FResultCount >0 then
		For iLp=0 To oDoc.FResultCount -1
			rstArrItemid = rstArrItemid & chkIIF(rstArrItemid="","",",") & oDoc.FItemList(iLp).FItemID
		Next
	End if
end if

'// 카테고리 총상품수 산출 함수
function getCateListCount(srcFlag,sDiv,sDep,dspCd,arrCt,mkrid,ccd,stcd,atcd,deliT,lDiv,sRect,sExc)
	dim oTotalCnt
	set oTotalCnt = new SearchItemCls
		oTotalCnt.FRectDiaryItem = diarystoryitem
		oTotalCnt.FRectSearchFlag = srcFlag
		oTotalCnt.FRectSearchItemDiv = sDiv
		oTotalCnt.FRectSearchCateDep = sDep
		oTotalCnt.FRectCateCode	= dspCd
		oTotalCnt.FarrCate=arrCt
		oTotalCnt.FRectMakerid	= mkrid
		oTotalCnt.FcolorCode= ccd
		oTotalCnt.FstyleCd= stcd
		oTotalCnt.FattribCd = atcd
		oTotalCnt.FdeliType	= deliT
		oTotalCnt.FListDiv = lDiv
		oTotalCnt.FRectSearchTxt = sRect
		oTotalCnt.FRectExceptText = sExc
		oTotalCnt.FSellScope=SellScope
		oTotalCnt.getTotalCount
		getCateListCount = oTotalCnt.FTotalCount
	set oTotalCnt = Nothing
end function

'//다이어리 스토리  전용 카운트
function getCateListDiaryItemCount(srcFlag,sDiv,sDep,dspCd,arrCt,mkrid,ccd,stcd,atcd,deliT,lDiv,sRect,sExc)
	dim oTotalCnt
	set oTotalCnt = new SearchItemCls
		oTotalCnt.FRectDiaryItem = "R"
		oTotalCnt.FRectSearchFlag = srcFlag
		oTotalCnt.FRectSearchItemDiv = sDiv
		oTotalCnt.FRectSearchCateDep = sDep
		oTotalCnt.FRectCateCode	= dspCd
		oTotalCnt.FarrCate=arrCt
		oTotalCnt.FRectMakerid	= mkrid
		oTotalCnt.FcolorCode= ccd
		oTotalCnt.FstyleCd= stcd
		oTotalCnt.FattribCd = atcd
		oTotalCnt.FdeliType	= deliT
		oTotalCnt.FListDiv = lDiv
		oTotalCnt.FRectSearchTxt = sRect
		oTotalCnt.FRectExceptText = sExc
		oTotalCnt.FSellScope=SellScope
		oTotalCnt.getTotalCount
		getCateListDiaryItemCount = oTotalCnt.FTotalCount
	set oTotalCnt = Nothing
end function

dim diaryItemCnt, categorydiaryItemCnt
If now() >= #2022-09-01 00:00:00# and now() < #2023-02-01 00:00:00# Then
	diaryItemCnt = getCateListCount(searchFlag,SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText)
	categorydiaryItemCnt = getCateListDiaryItemCount(searchFlag,SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText)
elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" then
	diaryItemCnt = getCateListCount(searchFlag,SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText)
	categorydiaryItemCnt = getCateListDiaryItemCount(searchFlag,SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText)
else
	diaryItemCnt=0
	categorydiaryItemCnt=0
end if

'//브랜드 정보
dim brandinfo : brandinfo = getbrandinfo(makerid)

'타이틀 설정 //2016/03/09 - 239 요청
strPageTitle = "텐바이텐 10X10 : " & Replace(socname&" ("&socname_kor&")","""","")
strPageKeyword = "브랜드 스트리트, " & replace(socname,"""","") & ", " & replace(socname_kor,"""","")

'// 브랜드 로그 사용여부(2017.04.04)
Dim LogUsingCustomChk
If LoginUserId="thensi7" Then
	LogUsingCustomChk = True
Else
	LogUsingCustomChk = True
End If

'// 브랜드 로그저장(2017.04.04 원승현)
If LogUsingCustomChk Then
	If IsUserLoginOK() Then
		Call fnUserLogCheck("brand", LoginUserid, "", "", makerid, "pc")
	End If
End If

'// 19주년 프랜드 브랜드일 경우 최대 할인율 표시(2020년 10월 29일까지)
Dim sqlStr, maxSalePercent, chkMaxSalePercent
sqlStr = " SELECT top 1 idx, makerid, socname, socname_kor, frontcategory, makerimageurl, maxsalepercent, orderby "
sqlStr = sqlStr & " FROM db_temp.dbo.tbl_brandMaxSalePercent WITH(NOLOCK) Where makerid='"&makerid&"'"
rsget.Open sqlStr,dbget, adOpenForwardOnly, adLockReadOnly
if Not(rsget.EOF or rsget.BOF) then
	maxSalePercent = rsget("maxsalepercent")
	chkMaxSalePercent = true
Else
	chkMaxSalePercent = false
End if
rsget.close
If Left(now(),10) >= "2020-10-30" Then
	chkMaxSalePercent = false
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />

<% If shopview = "1" then %>
	<script type="text/javascript" src="/lib/js/searchFilter.js?v=1.31"></script>
<% end if %>

<script type="text/javascript">
	$(function() {
		var id = "<%=slidecode%>";
		if ( id > "0" )
		{
			//$('html,body').animate({scrollTop: $("#section0"+id).offset().top},'slow');
		}

		// Item Image Control
		$(".pdtList li .pdtPhoto").mouseenter(function(e){
			$(this).find("dfn").fadeIn(150);
		}).mouseleave(function(e){
			$(this).find("dfn").fadeOut(150);
		});

		<% If shopview = "1" then %>
			//SHOP
			$('.brDeliveryInfo').hover(function(){
				$(this).children('.contLyr').toggle();
			});

			$('.dFilterWrap').hide();
			$('.dFilterTabV15 li').click(function(){
				$('.dFilterWrap').show();
				$('.filterSelect > div').hide();
				$("[id='"+'ft'+$(this).attr("id")+"']").show();
			});

			$('.filterLyrClose').click(function(){
				$('.dFilterWrap').hide();
				$('.dFilterTabV15 li').removeClass('selected');
				$('.sortingTabV15 li:first-child').addClass('selected');
			});

			//design filter - colorchip control
			/*
			$('.colorchipV15 li p input').click(function(){
				$(this).parent().parent().toggleClass('selected');
			});
			*/

			//design filter - price slide control
			$('#slider-range').slider({
				range:true,
				min:10000, //for dev msg : 자리수 3자리 콤마(,) 표시되게 해주세요
				max:150000, //for dev msg : 자리수 3자리 콤마(,) 표시되게 해주세요
				values:[10000, 50000],
				slide:function(event, ui) {
					$('#amountFirst').val(ui.values[0] + "원");
					$('#amountEnd').val(ui.values[1] + "원");
				}
			});
			$("#amountFirst").val($("#slider-range").slider("values", 0) + "원");
			$("#amountEnd").val($("#slider-range").slider("values", 1) + "원");
			$('.ui-slider a:first').append($('.amoundBox1'));
			$('.ui-slider a:last').append($('.amoundBox2'));

			//로딩시 더보기 펼침 처리
			if($("#lyrCate .trCateMore .check:checked").length) {
				$(".trCateMore").show();
				$('.schMoreView').addClass('folderOff');
			}
		 	// 로딩시 카테고리 선택 처리
		 	$("#lyrCate input[name^='ctCd1']").each(function(){
		 		var selCt = $(this).val().substr(0,3);
		 		if($(this).prop("checked")) {
		 			$("input[name^='ctCd2"+selCt+"']").prop("checked",true);
				}
		 	});

			// 카테고리 선택 클릭(1dep)
		 	$("#lyrCate input[name^='ctCd1']").click(function(){
		 		//alert('1dep');
		 		var selCt = $(this).val().substr(0,3);
		 		if($(this).prop("checked")) {
		 			$("input[name^='ctCd2"+selCt+"']").prop("checked",true);
			 	} else {
			 		$("input[name^='ctCd2"+selCt+"']").prop("checked",false);
				}
				setDispCateArr()
		 	});
			// 카테고리 선택 클릭(2dep)
		 	$("#lyrCate input[name^='ctCd2']").click(function(){
		 		//alert('2dep');
				var selCt = $(this).val().substr(0,3);

				var chkCnt = $("input[name^='ctCd2"+selCt+"']:checked").length;
				var totCnt = $("input[name^='ctCd2"+selCt+"']").length;
				if(chkCnt==totCnt) {
					$("#cate"+selCt).prop("checked",true);
				} else {
					$("#cate"+selCt).prop("checked",false);
				}
				setDispCateArr()
		 	});

			// 카테고리 링크 클릭(1/2dep)
		 	$("#lyrCate input[name^='ctCd1'],input[name^='ctCd2']").next().click(function(e){
		 		//alert('1/2dep');
		 		e.preventDefault();

				document.sFrm.makerid.value = '<%= makerid %>';
				document.sFrm.arrCate.value=$(this).prev().val();
				document.sFrm.cpg.value=1;
				document.sFrm.iccd.value="0";
				document.sFrm.styleCd.value="";
				document.sFrm.attribCd.value="";
				document.sFrm.minPrc.value="";
				document.sFrm.maxPrc.value="";
				document.sFrm.deliType.value="";
				document.sFrm.submit();
		 	});

			// 카테고리 링크 클릭(3dep)
		 	$("#lyrCate .depthWrap .depth a").click(function(e){
		 		e.preventDefault();

				document.sFrm.makerid.value = '<%= makerid %>';
				document.sFrm.arrCate.value=$(this).attr("selcd3");
				document.sFrm.cpg.value=1;
				document.sFrm.iccd.value="0";
				document.sFrm.styleCd.value="";
				document.sFrm.attribCd.value="";
				document.sFrm.minPrc.value="";
				document.sFrm.maxPrc.value="";
				document.sFrm.deliType.value="";
				document.sFrm.submit();
		 	});

			// 더보기 버튼 클릭
			$('.schMoreView').click(function(){
				$(this).toggleClass('folderOff');

				//카테고리 더보기
				if($(this).hasClass("btnMoreCate")) {
					$(".trCateMore").toggle();
				}
			});

			// 선택조건 해제 버튼
			$("#btnDelTerm").click(function(){
				$("#lyrCate .check").prop("checked",false);
				$("#lyrBrand .check").prop("checked",false);
				setDispCateArr();
				setMakerIdArr();
				return false;
			});
			// 선택조건 검색실행 버튼
			$("#btnActTerm").click(function(){
				//alert('a');
				document.sFrm.makerid.value = '<%= makerid %>';
				document.sFrm.cpg.value=1;
				//검색필터조건 리셋
				document.sFrm.iccd.value="0";
				document.sFrm.styleCd.value="";
				document.sFrm.attribCd.value="";
				document.sFrm.minPrc.value="";
				document.sFrm.maxPrc.value="";
				document.sFrm.deliType.value="";
				document.sFrm.submit();
				return false;
			});

			// SHOP - EVENT
			$('.enjoyEvent').hide();
			if ($('.relatedEventV15 .evtItem').length > 1) {
				$('.relatedEventV15 .enjoyEvent').slidesjs({
					width:200,
					height:305,
					navigation:{effect: "fade"},
					pagination:false,
					play:{active:false, interval:3300, effect:"fade", auto:false},
					effect:{
						fade:{speed:300, crossfade:true}
					},
					callback: {
						complete: function(number) {
							$('.count strong').text(number);

						}
					}
				});
				var itemSize = $(".shopBestPrdV15 .evtItem").length;
				$('.count span').text(itemSize);
			} else {
				$(".relatedEventV15 .enjoyEvent").css({display:'block'});
				$('.count').hide();
			}
		<% end if %>

		<% If shopview = "2" then %>
			// 컬렉션 더보기 버튼 클릭
			$('.clctMoreBtn').unbind("click").click(function(){
				//더보기가 접힌 상태
				if ( $(this).attr("view")=="" ){
					$(this).addClass('clctMoreBtn clctClose');
					var collectionidx = $(this).attr("idx");
					$(".trcollectionMore"+eval(collectionidx)).show();
					$(this).attr("view","ON")
				//펼침 상태
				}else{
					$(this).addClass('clctMoreBtn');
					var collectionidx = $(this).attr("idx");
					$(".trcollectionMore"+eval(collectionidx)).hide();
					$(this).attr("view","")
				}
			});
		<% end if %>

		<% If CurrPage > 1 Then %>
		$('html, body').animate({ scrollTop: $(".ctgyWrapV15").offset().top }, 10)
		<% End If %>
		$(".pdtList p").click(function(e){
			e.stopPropagation();
		});

		if(typeof qg !== "undefined"){
            let appier_brand_view = {
                "brand_id" : "<%= makerid %>"
                , "brand_name" : "<%= replace(socname_kor,"""","") %>"
                , "sort" : "<%= SortMet %>"
            };

            qg("event", "brand_view", appier_brand_view);
        }
	});

	// 선택된 카테고리 폼값으로 저장
	function setDispCateArr(rt) {
		var arrCt="";
		$("#lyrCate input[name^='ctCd1']").each(function(){
			if($(this).prop("checked")) {
				// 1Depth가 선택되면 1Depth 코드만
				if(arrCt) {
					arrCt += "," + $(this).val();
				} else {
					arrCt = $(this).val();
				}
			} else {
				// 1Depth 없고 2Depth 선택된 코드 접수
				$("#lyrCate input[name^='ctCd2"+$(this).val().substr(0,3)+"']:checked").each(function(){
					if(arrCt) {
						arrCt += "," + $(this).val();
					} else {
						arrCt = $(this).val();
					}
				});
			}
		});
		document.sFrm.arrCate.value=arrCt;

		if(rt!="R") swBtnDelTerm();
	}

	// 선택된 브랜드ID 폼값으로 저장
	function setMakerIdArr(rt) {
		var arrMk="";
		$("#lyrBrand input[name='mkrid']").each(function(){
			if($(this).prop("checked")) {
				if(arrMk) {
					arrMk += "," + $(this).val();
				} else {
					arrMk = $(this).val();
				}
			}
		});
		document.sFrm.makerid.value=arrMk;

		if(rt!="R") swBtnDelTerm();
	}

	// 조건 해제버튼 On/Off
	function swBtnDelTerm() {
		if(document.sFrm.arrCate.value!=""||document.sFrm.makerid.value!="") {
			$("#btnDelTerm").fadeIn('fast');
		} else {
			$("#btnDelTerm").fadeOut('fast');
		}

	}

	function jsGoPagebrand(iP){
		document.sFrm.makerid.value = '<%= makerid %>';
		document.sFrm.cpg.value = iP;
		document.sFrm.submit();
	}

	//샵 & 브랜드기획전 선택 할시
	function shopchg(val){
		if (val=='1'){
			location.href="/street/street_brand_sub06.asp?makerid=<%=makerid%>&shopview="+val;
		}else if (val=='2'){
			location.href="/street/street_brand_sub06.asp?makerid=<%=makerid%>&shopview="+val;
		}else if (val=='3'){
			location.href="/street/street_brand_sub06.asp?makerid=<%=makerid%>&shopview="+val;
		}
	}

	function amplitudeDiaryStory() {
		fnAmplitudeEventAction('view_diarystory_main', 'place', 'brand');
	}

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container brandV15">
		<div id="contentWrap">
			<!-- #include virtual="/street/inc_topnavi.asp" -->
		</div>
		<div class="brandContWrapV15">
			<!-- #include virtual="/street/inc_topmenu.asp" -->

			<%' <!-- for dev msg : 19주년 10월 정기세일 배너 --> %>
			<% If chkMaxSalePercent Then %>
				<style>
				.go-19th {position:absolute; top:30px; right:50%; z-index:55; margin-right:-370px; opacity:0; transform:translateX(150px);}
				.go-19th.show {opacity:1; transform:none; transition:.8s ease-in-out;}
				.go-19th .inner {position:relative; width:120px; height:130px; padding:20px 10px 0 0; text-align:center; font-size:15px; line-height:1; color:#fff; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/brand/bg.png) no-repeat center / contain;}
				.go-19th span {display:block;}
				.go-19th .txt-2 {margin-bottom:3px;}
				.go-19th img {vertical-align:top;}
				.go-19th .txt-1 img {width:58px;}
				.go-19th .txt-2 img {width:90px;}
				.go-19th .ani {margin-bottom:3px; font-weight:700; font-size:16px; color:#ffe676;}
				.go-19th.show .ani {animation:flash .8s 1s;}
				@keyframes flash{0%,100%,50%{opacity:1}25%,75%{opacity:0}}
				.go-19th .ani b {font-size:17px;}
				.go-19th .link {position:absolute; left:0; top:0; width:100%; height:100%; font-size:0; color:transparent;}
				.go-19th .btn-close {position:absolute; right:0; top:5px; width:30px; height:30px; font-size:0; color:transparent; background:none;}
				</style>
				<script>
				$(function() {
					$('.go-19th').addClass('show');
					$('.go-19th .btn-close').on('click', function() {
						$('.go-19th').hide();
					});
				});
				</script>
				<div class="go-19th">
					<div class="inner">
						<span class="txt-1"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/brand/txt_01.png" alt="19주년"></span>
						<div class="ani">
							<span class="txt-2"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/brand/txt_02.png" alt="세일프렌드"></span>
							<span>최대 <b><%=Formatnumber(maxSalePercent,0)%>%</b></span>
						</div>
						<span>할인중!</span>
						<a href="/event/19th/" class="link">19주년 메인으로 이동</a>
						<button type="button" class="btn-close">배너 닫기</button>
					</div>
				</div>
			<% End If %>
			<%' <!-- //19주년 10월 정기세일 배너 --> %>

			<div class="brandSection">
				<%
				'/현재 브랜드가 헬로우 매뉴 노출 권한이 있을경우 뿌림
				If hello_yn="Y" Then
				%>
					<!-- ABOUT BRAND-->
					<div class="aboutBrandV15">
						<!-- #include virtual="/street/inc_aboutbrand.asp" -->
					</div>
					<!-- //ABOUT BRAND -->
				<% end if %>

				<!-- SHOP -->
				<div class="brandShopV15">
					<div class="titleWrap line">
						<ul class="navigator">
							<!-- 현재 선택된 탭에 on 붙여주세요 -->
							<li class="nav1">
								<a href="" onclick="shopchg('1'); return false;" <% If shopview = "1" then %> class='on'<% end if %>>
								<em>SHOP</em>

								<% If shopview = "1" then %>
									<strong>(<%= oDoc.ftotalcount %>)</strong>
								<% end if %>
								</a>
							</li>

							<%
							'//현재 브랜드가 이벤트매뉴 노출 권한이 있고 기획전이 존재 할때만 뿌림
							if shop_event_yn="Y" then
							%>
								<% if shop_event_one<>"" then %>
									<% '<!-- for dev msg : 브랜드기획전(이벤트) 있을경우만 보여주세요 --> %>
									<li class="nav2">
										<a href="" onclick="shopchg('3'); return false;" <% If shopview = "3" then %> class='on'<% end if %>>
										<em>브랜드기획전</em> <strong><span>:</span> <%= shop_event_one %></strong></a>
									</li>
								<% end if %>
							<% end if %>
						</ul>

						<% if isarray(brandinfo) then %>
							<%
							'//브랜드 배송정보가 있을시 뿌림	'//상품상세와 장바구니단 내용과 비슷함
							if brandinfo(4,0)>0 and brandinfo(5,0)>0 then
							%>
								<p class="delivery fs11"><strong><%= brandinfo(1,0) %>(<%= brandinfo(2,0) %>)</strong> 제품으로만 <span class="cRd0V15"><%= FormatNumber(brandinfo(4,0),0) %>원 이상 구매시 무료배송 됩니다.</span> 배송비(<%= FormatNumber(brandinfo(5,0),0) %>원)</p>
							<% end if %>
						<% end if %>
					</div>

					<%
					'/카테고리와 컬렉션 일경우에만 노출됨
					If shopview = "1" or shopview = "2" then
					%>
						<!-- shop -->
						<div class="article">
							<h4>SHOP</h4>

							<%
							'//상품이 4개 보다 커야 노출함
							if oDoc.ftotalcount > 4 then
							%>
								<!-- #include virtual="/street/inc_bestitem_event.asp" -->
							<% end if %>

							<% if shop_collection_yn="Y" then %>
								<div class="overHidden">
									<ul class="shopListTab ftLt">
										<li <% If shopview = "1" then %>class="current"<% end if %>><a href="" onclick="shopchg('1'); return false;"><span>카테고리</span></a></li>

										<% if shop_collection_yn="Y" then %>
											<li <% If shopview = "2" then %>class="current"<% end if %>><a href="" onclick="shopchg('2'); return false;"><span>컬렉션</span></a></li>
										<% end if %>
									</ul>
								</div>
							<% end if %>

							<% If shopview = "1" then %>
								<div class="shopViewCtgy" id="section05">
									<!-- #include virtual="/street/inc_shop.asp" -->
								</div>
							<% elseif shopview = "2" then %>
								<div class="shopViewClct tPad20" id="section05">
									<!-- #include virtual="/street/inc_collection.asp" -->
								</div>
							<% end if %>
						</div>
						<!-- //shop -->
					<% end if %>

					<% If shopview = "3" then %>
						<div class="article" id="section05">
							<!-- #include virtual="/street/inc_brandplan.asp" -->
						</div>
					<% end if %>

					<form name="sFrm" id="listSFrm" method="get" action="/street/street_brand_sub06.asp" style="margin:0px;">
					<input type="hidden" name="rect" value="<%= SearchText %>">
					<input type="hidden" name="prvtxt" value="<%= PrevSearchText %>">
					<input type="hidden" name="rstxt" value="<%= ReSearchText %>">
					<input type="hidden" name="extxt" value="<%= ExceptText %>">
					<input type="hidden" name="sflag" value="<%= SearchFlag  %>">
					<input type="hidden" name="dispCate" value="<%= dispCate %>">
					<input type="hidden" name="cpg" value="">
					<input type="hidden" name="chkr" value="<%= CheckResearch %>">
					<input type="hidden" name="chke" value="<%= CheckExcept %>">
					<input type="hidden" name="makerid" value="<%= makerid %>">
					<input type="hidden" name="sscp" value="<%= SellScope %>">
					<input type="hidden" name="psz" value="<%= PageSize %>">
					<input type="hidden" name="srm" value="<%= SortMet %>">
					<input type="hidden" name="iccd" value="<%=colorCD%>">
					<input type="hidden" name="styleCd" value="<%=styleCd%>">
					<input type="hidden" name="attribCd" value="<%=attribCd%>">
					<input type="hidden" name="icoSize" value="<%=icoSize%>">
					<input type="hidden" name="arrCate" value="<%=arrCate%>">
					<input type="hidden" name="deliType" value="<%=deliType%>">
					<input type="hidden" name="minPrc" value="<%=minPrice%>">
					<input type="hidden" name="maxPrc" value="<%=maxPrice%>">
					<input type="hidden" name="lstDiv" value="<%=ListDiv%>">
					<input type="hidden" name="slidecode" value="5">
					<input type="hidden" name="shopview" value="<%= shopview %>">
					<input type="hidden" name="diarystoryitem" value="<%=diarystoryitem%>">
					</form>
				</div>
				<!-- //SHOP -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->