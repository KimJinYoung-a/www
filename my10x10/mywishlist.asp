<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%

'#######################################################
'	Description : 나의 위시리스트
'	History	:  2010.04.09 한용민 생성
'              2013.09.13 허진원 2013리뉴얼
'              2015.04.09 이종화 2015리뉴얼
'#######################################################

	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 위시리스트"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
	strPageDesc = "관심 상품을 다시한번 확인 하세요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 위시"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/mywishlist.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim userid, page, pagesize, SortMethod, OrderType , arrList, intLoop,fidx , nowFldName, ttItemCnt, ttFolderCnt
dim ooption, optionBoxHtml , wishsearch , arrfriend , nowOpenYN, vDisp
dim SellScope
	userid		= getEncLoginUserID
	page       	= requestCheckVar(request("page"),9)
	vDisp         = requestCheckVar(request("disp"),3)
	pagesize    = requestCheckVar(request("pagesize"),9)
	SortMethod  = requestCheckVar(request("SortMethod"),10)
	OrderType   = requestCheckVar(request("OrderType"),10)
	fidx		= requestCheckVar(request("fidx"),10)
	wishsearch	= requestCheckVar(request("wishsearch"),32)
	SellScope	=requestCheckVar(request("sscp"),1)			'품절상품 제외여부

	if page="" then page=1
	if pagesize="" then pagesize= 28
	if fidx	= "" then fidx = 0
	nowOpenYN = false	'현재 선택폴더 공개설정 여부

'고객별 위시리스트 공개내역 가져오기
dim ofriend
set ofriend = new CMyFavorite
	ofriend.FRectUserID = wishsearch

	if wishsearch <> "" then
	arrfriend = ofriend.fnmyfavorite_search
	end if

dim myfavorite
set myfavorite = new CMyFavorite
	myfavorite.FPageSize        = pagesize
	myfavorite.FCurrpage        = page
	myfavorite.FScrollCount     = 10
	myfavorite.FRectOrderType   = OrderType
	myfavorite.FRectSortMethod  = SortMethod
	myfavorite.FRectDisp		= vDisp
	myfavorite.FRectSellScope	= SellScope


	'//내친구의 위시리스트 찾기 내역이 있으면 친구내역 가져오기
	if wishsearch <> "" then
		myfavorite.FRectUserID = wishsearch
		myfavorite.FRectviewisusing = "ON"

		'내친구 위시찾기가 값이 없는 경우 기본값으로 공개된 폴더의 젤 앞에 폴더를 가져다가 박아 넣는다.
		if fidx = "0" then
			if isarray(arrfriend) then
				myfavorite.FFolderIdx = arrfriend(0,0)
				fidx =  arrfriend(0,0)
			else
				myfavorite.FFolderIdx = fidx
			end if
		else
			myfavorite.FFolderIdx = fidx
		end if

	'//일반적 상황에서는 로그인한 사람 내역가져옴
	else
		myfavorite.FRectUserID      	= userid
		myfavorite.FFolderIdx		= fidx
	end if

	myfavorite.getMyWishList

	'위시리스트 폴더 검색
	arrList = myfavorite.fnGetFolderList

dim i,j, lp, ix

'######## 위시리스트 이벤트용########
Dim vWishEventIN, vWishEventFIdx, vWishPrice, vWishTotal, vWishEventOX
	vWishEventIN = "x"
	vWishEventFIdx = 999999

	myfavorite.FRectUserID	= userid
	myfavorite.FFolderIdx	= fidx
	myfavorite.fnWishListEventView

	vWishPrice = myfavorite.FWishEventPrice
	vWishTotal = myfavorite.FWishEventTotalCnt
'####################################
%>
<script type="text/javascript" src="/lib/js/tenbytencommon.js"></script>
<script type="text/javascript">
function Add2Favorate(frm){
    if (frm.bagarray==undefined) return;

    var buf = "";

    frm.bagarray.value = "";
    for (i = 0; i < frm.elements.length; i++) {
		var e = frm.elements[i];
		if ((e.type == 'checkbox') && (e.checked == true)) {
		    frm.bagarray.value = frm.bagarray.value + frm.elements[i].value + ",";
		}
    }

    if (frm.bagarray.value == "") {
        alert("선택된 상품이 없습니다.");
        return;
    }

    if (confirm("선택된 상품을 관심품목에 등록 하시겠습니까?") == true) {
        frm.mode.value = "AddFavItems";
        frm.target="FavWin";
        frm.action = "/my10x10/popMyFavorite.asp";
        window.open('' ,'FavWin','width=380,height=300,scrollbars=no,resizable=no');
        frm.submit();
    }
}

//카테고리 검색
function SwapCate(comp){
	if (document.frmsearch.wishsearch.value=='아이디를 입력해주세요.'){
		document.frmsearch.wishsearch.value = '';
	}

	document.frmsearch.disp.value=comp;
	document.frmsearch.page.value=1;
	document.frmsearch.submit();
}

//정렬 검색
function orderitem(comp){
	if (document.frmsearch.wishsearch.value=='아이디를 입력해주세요.'){
		document.frmsearch.wishsearch.value = '';
	}

	document.frmsearch.page.value=1;
	document.frmsearch.ordertype.value=comp;
	document.frmsearch.submit();
}

//위시리스트 폴더내용보기
function SwapFidx(fidx){

	if (document.frmsearch.wishsearch.value=='아이디를 입력해주세요.'){
		document.frmsearch.wishsearch.value = '';
	}

	document.frmsearch.fidx.value = fidx;
	document.frmsearch.submit();
}


// 상품목록 페이지 이동
function goPage(pg){
	var frm = document.SubmitFrm;
	frm.action="mywishlist.asp";
	frm.page.value=pg;
	frm.submit();
}


//위시리스트 상품 삭제하기
function DelFavItems(frm){
    if (frm.bagarray==undefined) return;

    var buf = "";

    frm.bagarray.value = "";
    for (i = 0; i < frm.elements.length; i++) {
		var e = frm.elements[i];
		if ((e.type == "checkbox") && (e.name="itemid") && (e.checked == true)) {
		    frm.bagarray.value = frm.bagarray.value + frm.elements[i].value + ",";
		}
    }

    if (frm.bagarray.value == "") {
        alert("선택된 상품이 없습니다.");
        return;
    }

    if (confirm("선택된 상품을 삭제 하시겠습니까?") == true) {
        frm.mode.value = "DelFavItems";
        frm.action = "/my10x10/myfavorite_process.asp";

        frm.submit();
    }
}

//장바구니 담기
function Add2Shoppingbag(frm){
    var frmBaguni = document.frmBaguni;

    if (frm.bagarray==undefined) return;

    var buf = "";
	var isAdult = <%=chkiif(session("isAdult")=True,1,0)%>;
    frm.bagarray.value = "";
    for (i = 0; i < frm.elements.length; i++) {
        var e = frm.elements[i];
        if ((e.type == 'checkbox') && (e.checked == true)) {
    		if ((frm.elements[i+2].type == 'hidden') && (frm.elements[i + 2].value=='0')){
            	alert("품절된 상품은 장바구니에 담을수 없습니다.");
            	e.focus();
            	return;
            }

			
			if(isAdult == 0 && $(e).attr("adultType") != "0"){
				confirmAdultAuth('/my10x10/mywishlist.asp');
				return;
			}

            // 옵션이 없는 경우
            if ((frm.elements.length > (i+3)) && (frm.elements[i + 3].type != 'select-one')) {
                    frm.bagarray.value = frm.bagarray.value + e.value + ",0000,1|";
            } else if (frm.elements.length <= (i+3)) {
                    frm.bagarray.value = frm.bagarray.value + e.value + ",0000,1|";
            }
        }
        if ((e.type == "select-one") && (frm.elements[i-3].type == "checkbox") && (frm.elements[i-3].checked==true)) {
            // 옵션이 있는 경우
            if (e.selectedIndex == 0) { alert("옵션을 선택하세요."); e.focus(); return; }
            if (e[e.selectedIndex].id == "S") { alert("품절된 옵션은 구매하실 수 없습니다."); return; }
            frm.bagarray.value = frm.bagarray.value + frm.elements[i - 3].value + "," + e[e.selectedIndex].value + ",1|";
        }

    }

    if (frm.bagarray.value == "") {
        alert("선택된 상품이 없습니다.");
        return;
    }

    if (confirm("선택하신 상품을 장바구니에 추가하시겠습니까?") == true) {
        frmBaguni.mode.value = "arr";
        frmBaguni.bagarr.value = frm.bagarray.value;
        frmBaguni.action = "/inipay/shoppingbag_process.asp";

        frmBaguni.submit();
    }
}

// 선택상품 위시리스트 폴더로 이동
function jsChangeFolder(frm){
 if (frm.bagarray==undefined) return;

    var buf = "";

    frm.bagarray.value = "";
    for (i = 0; i < frm.elements.length; i++) {
		var e = frm.elements[i];
		if ((e.type == 'checkbox') && (e.checked == true)) {
		    frm.bagarray.value = frm.bagarray.value + frm.elements[i].value + ",";
		}
    }

    if (frm.bagarray.value == "") {
        alert("선택된 상품이 없습니다.");
        return;
    }

    frm.mode.value = "Change";
    frm.fidx.value = $("select[name='selCF'] option:selected").val();
    frm.action = "/my10x10/myfavorite_process.asp";
    frm.submit();

}

//택스트창 클릭시 아이디창 글 삭제
function searchboxch(){
	if (document.frmsearch.wishsearch.value=='아이디를 입력해주세요.'){
		document.frmsearch.wishsearch.value = '';
	}
}

//고객아이디검색
function searchuserid(){

	if (document.frmsearch.wishsearch.value=='아이디를 입력해주세요.'||document.frmsearch.wishsearch.value==''){
		document.frmsearch.wishsearch.value = '';
		alert('아이디를 입력해주세요');
		document.frmsearch.wishsearch.focus();
		return;
	}

	document.frmsearch.disp.value = '';
	document.frmsearch.ordertype.value = '';
	document.frmsearch.fidx.value = '';
	document.frmsearch.submit();
}

// 품절상품 보기 여부 변경
function swViewSoldout(sw) {
	var frm = document.SubmitFrm;
	frm.action="mywishlist.asp";
	frm.page.value=1;
	frm.sscp.value=sw;
	frm.submit();
}

function jsWishEvent()
{
	//wishlistevent.location.href = "/my10x10/event/myfavorite_folderProc.asp?hidM=I";
	var url = "/event/openevent/pop_pickshow.asp?hidM=I";
	window.open(url,"poppickshow","width=463,height=280,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no");
}

$(function(){
	// layer popup
	$('.addInfo').hover(function(){
		$(this).next('.contLyr').toggle();
	});

	//위시 폴더탭
	$(".fldTabBtn").click(function(e){
		e.preventDefault();
		$(".fldTabBtn").removeClass("on");
		$(this).addClass("on");
		if($(this).attr("value")=="fr") {
			$("#lyrSearchWish").show();
		} else {
			<% if wishsearch<>"" then %>
			document.frmsearch.wishsearch.value = '';
			document.frmsearch.disp.value = '';
			document.frmsearch.ordertype.value = '';
			document.frmsearch.fidx.value = '';
			document.frmsearch.submit();
			<% end if %>

			$("#lyrSearchWish").hide();
		}
	});

	//폴더 이동 팝업
	$("#btnFdlMove").click(function(e){
		e.preventDefault();
		if(!$(".myWishList input[name='itemid']:checked").length){
			alert("선택된 상품이 없습니다.");
			return;
		}
		viewPoupLayer('modal',$("#folderLyr").html());
	});

	$("#selectAll").click(function(){
		$(".myWishList input[name='itemid']").prop("checked",$(this).prop("checked"));
	});

});
</script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_wish.gif" alt="위시" /></h3>
						<ul class="list">
							<li>위시에 담긴 상품은 바로 장바구니에 담으실 수 있으며 폴더로 구분하여 관리하실 수 있습니다.</li>
							<li>관심품목에 담은 시점과 구매시점에서 상품가격 및 이벤트가 변경될 수 있으며 조기품절 될 수 있습니다.</li>
							<li>폴더는 기본폴더를 포함, 최대 20개 까지 등록 가능하며 공개 여부를 설정하실 수 있습니다.</li>
						</ul>
						<% If Now() >= #02/10/2016 10:00:00# AND Now() < #02/15/2016 00:00:00# Then %>
						<span style="position:absolute; right:30px; bottom:30px;"><a href="/event/eventmain.asp?eventid=68889"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/bnr.png" alt="새해 위시 이벤트 오늘은 Wish를 털날" /></a></span>
						<% End if %>
					</div>

					<div class="mySection">
					<form name="frmsearch" method="post" action="mywishlist.asp">
					<input type="hidden" name="fidx" value="<%=fidx%>">
					<input type="hidden" name="page" value="1">
					<input type="hidden" name="sscp" value="<%=SellScope%>">
					<input type="hidden" name="disp" value="<%=vDisp%>">
					<input type="hidden" name="ordertype" value="<%=orderType%>">
						<div class="tabWishWrap">
							<ul class="tabMenu tabWish">
								<li><a href="" value="my" class="fldTabBtn <%=chkIIF(wishsearch="","on","")%>">나의 위시폴더</a></li>
								<li><a href="" value="fr" class="fldTabBtn <%=chkIIF(wishsearch<>"","on","")%>">친구 위시폴더</a></li>
							</ul>
							<div id="lyrSearchWish" class="searchWish" <%=chkIIF(wishsearch="","style=""display:none;""","")%>>
								<fieldset>
								<legend>친구의 공개위시 검색</legend>
									<label for="friendWish"><strong>[친구의 공개위시 찾기]</strong></label>
									<input type="text" name="wishsearch" id="friendWish" value="<%=chkIIF(wishsearch="","아이디를 입력해주세요.",wishsearch)%>" placeholder="아이디를 입력해주세요." onclick="searchboxch();" onkeydown="if(event.keyCode==13) {searchuserid();return false;}" class="txtInp" />
									<input type="button" value="" class="btnSearch" onclick="searchuserid();" />
								</fieldset>
							</div>
						</div>

						<div class="wishFloder">
						<%
							if wishsearch="" then
								'/// 본인의 위시리스트 목록 ///
								ttItemCnt = 0
								IF isArray(arrList) THEN
									'상품총 갯수 및 현재 폴더명 접수
									For intLoop = 0 To UBound(arrList,2)
										ttItemCnt = ttItemCnt + arrList(3,intLoop)
										If Cstr(fidx)=Cstr(arrList(0,intloop)) Then
											nowFldName = chkIIF(arrList(0,intLoop)="0","기본폴더",arrList(1,intLoop))
											if arrList(2,intLoop)="Y" then nowOpenYN=true
										end if
									Next
									ttFolderCnt = UBound(arrList,2)+1
								else
									ttFolderCnt = 1
									nowFldName = "기본폴더"
								End if
						%>
							<div class="breakdown">
								<p class="fs12"><strong><%=getLoginUserId%></strong>님의 위시 폴더는 <strong><%=ttFolderCnt%></strong>개, 상품은 <strong><%=formatNumber(ttItemCnt,0)%></strong>개 입니다.</p>
								<a href="popmyfavorite_folder.asp" onclick="window.open(this.href, 'popF', 'width=480, height=530, scrollbars=no'); return false;" title="새창에서 열림" class="btn btnGrylight btnS2"><span class="gryArr01 fn">폴더 추가/수정</span></a>
							</div>
							<ul>
							<%
								IF isArray(arrList) THEN
									For intLoop = 0 To UBound(arrList,2)
										'이벤트 여부 확인
										if arrList(0,intLoop)<>"0" then
											If left(arrList(1,intLoop),11) = "[pick show]" Then
												vWishEventIN = "o"
													If Cstr(fidx)=Cstr(arrList(0,intloop)) Then
														vWishEventOX = "o"
														vWishEventFIdx = arrList(0,intloop)
													End If
											end if
										end if
							%>
								<li>
									<a href="" <%=chkIIF(Cstr(fidx)=Cstr(arrList(0,intLoop)),"class=""current""","")%> onclick="SwapFidx(<%=arrList(0,intloop)%>);return false;">
										<%=chkIIF(arrList(0,intLoop)="0","기본폴더",arrList(1,intLoop))%><span> (<strong><%=arrList(3,intLoop)%></strong>개)</span>
										<% if arrList(2,intLoop)="Y" then %><img src="http://fiximage.10x10.co.kr/web2013/common/ico_open.gif" alt="공개" /><% end if %>
										<% if vWishEventIN="o" AND Now() < #10/14/2013 00:00:00# then %><em class="crMint">| 이벤트 진행 중 |</em><% end if %>
										<% IF Trim(arrList(1,intLoop)) = "넣어둬 넣어둬" AND Now() < #02/23/2015 00:00:00# then %><em class="crMint fs11">| 이벤트 진행 중 |</em><% end if %>
									</a>
								</li>
							<%
									Next
								else
							%>
								<li><a href="" class="current"  onclick="SwapFidx(0);return false;">기본폴더<span> (<strong>0</strong>개)</span></a></li>
							<%	end if %>
							</ul>
						<%
							else
								'/// 친구의 위시리스트 목록 ///
								ttItemCnt = 0

								if isarray(arrfriend) then
									For intLoop = 0 To UBound(arrfriend,2)
										ttItemCnt = ttItemCnt + arrfriend(5,intLoop)
										If Cstr(fidx)=Cstr(arrfriend(0,intloop)) Then
											nowFldName = arrfriend(2,intLoop)
										end if
									Next
						%>
							<div class="breakdown">
								<p class="fs12"><strong><%=wishsearch%></strong>님의 위시 폴더는 <strong><%=ubound(arrfriend,2)+1%></strong>개, 상품은 <strong><%=formatNumber(ttItemCnt,0)%></strong>개 입니다.</p>
							</div>
							<ul>
								<%	For intLoop = 0 To UBound(arrfriend,2) %>
								<li>
									<a href="" <%=chkIIF(Cstr(fidx)=Cstr(arrfriend(0,intLoop)),"class=""current""","")%> onclick="SwapFidx(<%=arrfriend(0,intloop)%>);return false;">
										<%=arrfriend(2,intLoop)%><span> (<strong><%=arrfriend(5,intLoop)%></strong>개)</span>
										<% if arrfriend(4,intLoop)="Y" then %><img src="http://fiximage.10x10.co.kr/web2013/common/ico_open.gif" alt="공개" /><% end if %>
									</a>
								</li>
								<%	Next %>
							</ul>

						<%
								else
						%>
							<div class="breakdown">
								<p class="fs12"><%=wishsearch%>님의 공개 위시폴더가 존재하지 않습니다.</p>
							</div>
						<%
								end if
							end if
						%>
						</div>
					</form>
        			<%
        				'### 위시리스트 이벤트 이고 01월 12일 00시 이후 부터 시작
						If Now() > #12/14/2015 00:00:00# AND Now() < #12/21/2015 00:00:00# Then
        			%>
						<div class="tPad30"><a href="/event/eventmain.asp?eventid=67490"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/bnr_wish.png" alt="크리스마스 위시 이벤트 확인하러 가기" /></a></div>

 						<!--div class="eventWish">
							<div class="box">
								<p class="fs12 txtL"><strong>지상최대의 Pick show, 여러분의 참여를 기다립니다</strong></p>
								<p>자신만의 컨셉이 있는 상품을 선택하여 [Pick Show] 폴더에 담아주세요.<br /> 상품교체는 얼마든지 가능하며 이벤트에 응모되는 상품은 이벤트 종료 예정일인 <em class="crRed">10월 13일 24시 기준으로 선정</em>합니다</p>
							</div>
							<div class="btnArea ct tMar20">
								<a href="/event/openevent/pickshow.asp" class="btn btnS1 btnWhite">이벤트 확인</a>
								<%' If vWishEventIN <> "o" then %><a href="javascript:jsWishEvent()" class="btn btnS1 btnRed fs12">참여하기</a><%' End If %>
							</div>
						</div-->

        				<!--// 위시리스트 이벤트 참여 현황 및 배너 //-->
        			<%	end if %>

						<div class="myWishWrap">
							<div class="titleArea">
							<% if nowFldName<>"" then %>
								<h4><%=nowFldName%> <span>(<strong><%= FormatNumber(myfavorite.FTotalCount,0) %></strong>)</span></h4>
								<div class="option">
									<% if nowOpenYN then %>
									<div class="addInfo">
										<strong class="share">위시 공유하기</strong>
										<div class="contLyr">
											<div class="contLyrInner">
												<div class="sns">
												<%	'// 쇼셜서비스로 글보내기
													dim snpTitle, snpLink, snpPre, snpTag, snpTag2, opnLink
													opnLink = wwwUrl & "/common/openWishList.asp?fid=" & rdmSerialEnc(fidx)
													snpTitle = Server.URLEncode("내가 갖고 싶은건 바로 이거야!")
													snpLink = Server.URLEncode(opnLink)

													'기본 태그
													snpPre = Server.URLEncode("텐바이텐 OPEN WISH LIST")
													snpTag = Server.URLEncode("텐바이텐")
													snpTag2 = Server.URLEncode("#10x10")
												%>
													<!--<a href="" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a>-->
													<a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a>
													<a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a>
													<input type="text" class="txtInp" value="<%=opnLink%>" style="width:241px;" onfocus="this.select()" />
												</div>
												<p>나의 위시리스트를 친구에게 알려주세요!<br />
												공개로 설정된폴더만 공유가 가능하니 위시 [폴더 추가/수정] 에서<br />
												설정 해주세요.</p>
											</div>
										</div>
									</div>
									<% end if %>
									<a href="" class="btn btnS2 btnRed" onclick="Add2Shoppingbag(document.SubmitFrm);return false;"><span class="fn">장바구니 담기</span></a>
								</div>
							<% end if %>
							</div>

							<div class="favorOption">
								<div class="ftLt">
									<span style="padding-top:5px">
										<input type="checkbox" class="check" id="selectAll" />
										<label for="selectAll">전체선택</label>
									</span>
									<a href="" id="btnFdlMove" class="btn btnS2 btnGrylight fn rMar05">폴더이동</a>
									<a href="" onclick="DelFavItems(document.SubmitFrm); return false;" class="btn btnS2 btnGrylight fn">삭제</a>
								</div>
								<div class="ftRt">
									<a href="" onclick="swViewSoldout('<%=chkIIF(SellScope="Y","N","Y")%>');return false;" class="btn btnS2 btnGry2 rMar05"><span class="fn"><%=chkIIF(SellScope="Y","품절상품 포함보기","품절상품 제외보기")%></span></a>
									<select onChange="SwapCate(this.value);" title="카테고리 선택" class="optSelect2" style="width:123px;">
									<%=CategorySelectBoxOption(vDisp)%>
									</select>

									<select onchange="orderitem(this.value);" class="optSelect2 lMar05" style="width:113px;" title="정렬방식 선택">
										<option value="recent" <% if orderType="" or orderType="recent" then response.write "selected" %>>최근담은순</option>
										<option value="new" <% if orderType="new" then response.write "selected" %>>신상품순</option>
										<option value="fav" <% if orderType="fav" then response.write "selected" %>>베스트상품순</option>
										<option value="highprice" <% if orderType="highprice" then response.write "selected" %>>높은가격순</option>
										<option value="lowprice" <% if orderType="lowprice" then response.write "selected" %>>낮은가격순</option>
										<option value="highsale" <% if orderType="highsale" then response.write "selected" %>>높은할인율순</option>
									</select>
								</div>
							</div>

							<!-- 리스트 -->
							<div class="pdtWrap pdt150V15">
							<form name="SubmitFrm" method="post" action="" onsubmit="return false;" >
							<input type="hidden" name="mode" value="">
							<input type="hidden" name="wishsearch" value="<%=wishsearch%>">
							<input type="hidden" name="bagarray" value="">
							<input type="hidden" name="fidx" value="<%=fidx%>">
							<input type="hidden" name="oldfidx" value="<%=fidx%>">
							<input type="hidden" name="disp" value="<%=vDisp%>">
							<input type="hidden" name="ordertype" value="<%=orderType%>">
							<input type="hidden" name="page" value="<%=page%>">
							<input type="hidden" name="sscp" value="<%=SellScope%>">
							<input type="hidden" name="sitename" value="10x10">
							<input type="hidden" name="backurl" value="mywishlist.asp">
							<% If (myfavorite.FResultCount < 1) Then %>
								<div class="noData">
									<p><strong><%=chkIIF(vDisp="","등록된 위시가 없습니다..","조건에 맞는 상품이 없습니다.")%></strong></p>
									<a href="/my10x10/popularwish.asp" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/btn_view_wish.gif" alt="인기 위시 보러가기" /></a>
								</div>
							<% else %>
								<ul class="pdtList myWishList">
								<% for ix = 0 to myfavorite.FResultCount-1 %>
									<li <%=chkiif(myfavorite.FItemList(ix).isSoldOut,"class=""soldOut""","")%>>
										<input type="checkbox"  name="itemid" value="<%= myfavorite.FItemList(ix).FItemID %>" class="check" adultType="<%=myfavorite.FItemList(ix).FAdultType%>"/>
										<div class="pdtBox">
											<div class="pdtPhoto">
												<a href="/shopping/category_prd.asp?itemid=<%= myfavorite.FItemList(ix).FItemID %>&gaparam=<%=chkIIF(wishsearch="","wishlist","wishlist_a")%>">
													<span class="soldOutMask"></span>
													<img src="<%=getThumbImgFromURL(myfavorite.FItemList(ix).FImageIcon2,"150","150","true","false")%>" alt="<%= Replace(myfavorite.FItemList(ix).FItemName,"""","") %>" />
												</a>
											</div>
											<div class="pdtInfo">
												<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= myfavorite.FItemList(ix).FMakerid %>"><%= myfavorite.FItemList(ix).FBrandName %></a></p>
												<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= myfavorite.FItemList(ix).FItemID %>&gaparam=<%=chkIIF(wishsearch="","wishlist","wishlist_a")%>"><%= myfavorite.FItemList(ix).FItemName %></a></p>
												<% if myfavorite.FItemList(ix).IsSaleItem or myfavorite.FItemList(ix).isCouponItem Then %>
													<% IF myfavorite.FItemList(ix).IsSaleItem then %>
													<p class="pdtPrice"><span class="txtML"><%=FormatNumber(myfavorite.FItemList(ix).getOrgPrice,0)%>원</span></p>
													<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myfavorite.FItemList(ix).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=myfavorite.FItemList(ix).getSalePro%>]</strong></p>
													<% End If %>
													<% IF myfavorite.FItemList(ix).IsCouponItem Then %>
														<% if Not(myfavorite.FItemList(ix).IsFreeBeasongCoupon() or myfavorite.FItemList(ix).IsSaleItem) Then %>
													<p class="pdtPrice"><span class="txtML"><%=FormatNumber(myfavorite.FItemList(ix).getOrgPrice,0)%>원</span></p>
														<% end If %>
													<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myfavorite.FItemList(ix).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=myfavorite.FItemList(ix).GetCouponDiscountStr%>]</strong></p>
													<% End If %>
												<% Else %>
													<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myfavorite.FItemList(ix).getRealPrice,0) & chkIIF(myfavorite.FItemList(ix).IsMileShopitem,"Point","원")%></span></p>
												<% End If %>
												<p class="pdtStTag tPad05">
													<input type="hidden" name="itemoption" value="">
													<% if (myfavorite.FItemList(ix).IsSoldOut) then %>
													<input type="hidden" name="itemea" value="0">
													<% else %>
													<input type="hidden" name="itemea" value="1">
													<% end if %>
													<% IF myfavorite.FItemList(ix).isSoldOut Then %>
														<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
													<% else %>
														<% IF myfavorite.FItemList(ix).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
														<% IF myfavorite.FItemList(ix).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
														<% IF myfavorite.FItemList(ix).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
														<% IF myfavorite.FItemList(ix).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
														<% IF myfavorite.FItemList(ix).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
														<% IF myfavorite.FItemList(ix).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /><% end if %>
													<% end if %>
												</p>

											</div>
											<p class="wishOpt">
												<%
													optionBoxHtml = ""
													''품절시 제외.
													If (myfavorite.FItemList(ix).IsItemOptionExists) and (Not myfavorite.FItemList(ix).IsSoldOut) then
														if (myfavorite.FItemList(ix).Fdeliverytype="6") then ''현장수령 한정표시 안함.
															optionBoxHtml = getOneTypeOptionBoxDpLimitHtml(myfavorite.FItemList(ix).FItemID,myfavorite.FItemList(ix).IsSoldOut,"class=""optSelect2"" style=""width:100%;""",false)
														else
															optionBoxHtml = getOneTypeOptionBoxHtml(myfavorite.FItemList(ix).FItemID,myfavorite.FItemList(ix).IsSoldOut,"class=""optSelect2"" style=""width:100%;""")
														end if
													End If

													response.write optionBoxHtml
												%>
											</p>
											<ul class="pdtActionV15">
												<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=myfavorite.FItemList(ix).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
												<li class="postView"><a href="" <%=chkIIF(myfavorite.FItemList(ix).Fevalcnt>0,"onclick=""popEvaluate('" & myfavorite.FItemList(ix).FItemid & "');return false;""","onclick=""return false;""")%>><span><%=FormatNumber(myfavorite.FItemList(ix).Fevalcnt,0)%></span></a></li>
												<li class="wishView"><a href="" onclick="TnAddFavorite('<%=myfavorite.FItemList(ix).FItemid %>');return false;"><span><%=FormatNumber(myfavorite.FItemList(ix).FfavCount,0)%></span></a></li>
											</ul>
										</div>
									</li>
								<% next %>
								</ul>
							<% end if %>
							</form>
							</div>
							<!-- //Paging -->
							<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(myfavorite.FcurrPage, myfavorite.FtotalCount, myfavorite.FPageSize, 10, "goPage") %></div>
						</div>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<form name="frmBaguni" method="post">
		<input type="hidden" name="mode" value="arr">
		<input type="hidden" name="bagarr" value="">
	</form>
	<iframe src="about:blank" name="wishlistevent" frameborder="0" width="0" height="0" marginheight="0" marginwidth="0" style="display:none;"></iframe>
	<div id="folderLyr" style="display:none;">
		<div class="window certLyr" style="height:311px;">
			<div class="popTop pngFix"><div class="pngFix"></div></div>
			<div class="popContWrap pngFix">
				<div class="popCont pngFix">
					<div class="popHead">
						<h2><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_folder_move.gif" alt="폴더이동" /></h2>
						<p class="lyrClose"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_pop_close.gif" onclick="ClosePopLayer()" alt="닫기" /></p>
					</div>
					<div class="popBody ct">
						<div class="certCont">
							<fieldset>
							<legend>폴더 이동 관리</legend>
								<div class="folderMove">
									선택한 상품을
									<select name="selCF" title="폴더 선택 하기" class="select" style="width:208px;">
									<%
										IF isArray(arrList) THEN
											For intLoop = 0 To UBound(arrList,2)
									%>
										<option value="<%=arrList(0,intLoop)%>"><%=chkIIF(arrList(0,intLoop)="0","기본폴더",arrList(1,intLoop))%></option>
									<%
											Next
										END IF
									%>
									</select>
									폴더로
								</div>
								<div class="btnArea ct tMar20">
									<a href="" class="btn btnS1 btnRed btnW100 fs12" onclick="jsChangeFolder(document.SubmitFrm);return false;">이동</a>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
	set myfavorite = Nothing
	set ofriend = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
