<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [2016 정기세일] 컬러가 터진다
' History : 2016.04.14 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->

<%
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66105
Else
	eCode   =  70032
End If

dim userid, i, vreload
	userid = getloginuserid()
	vreload	= requestCheckVar(Request("reload"),2)

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt, sqlstr
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 8	'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 8	'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'// sns데이터 총 카운팅 가져옴
sqlstr = "select count(*) "
sqlstr = sqlstr & " from [db_Appwish].[dbo].[tbl_snsSelectData]"
sqlstr = sqlstr & " Where evt_code="& eCode &""

'response.write sqlstr & "<br>"
rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
	iCTotCnt = rsCTget(0)
rsCTget.close

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
	
	

dim cEvent, cEventItem, arrItem, arrGroup, intI, intG, vIsWide, evtFile, evtFileyn, evt_subcopyk, etc_itemid
dim sgroup_w, slide_w_flag, favCnt, vDisp, vDateView, evt_mo_listbanner, vIsweb, vIsmobile, vIsapp, onlyForMDTab, logparam
dim arrRecent, intR
'dim bidx
dim ekind, emanager, escope, eName, esdate, eedate, estate, eregdate, epdate, bimg, eItemListType
dim ecategory, ecateMid, blnsale, blngift, blncoupon, blncomment, blnbbs, blnitemps, blnapply, edispcate
dim etemplate, emimg, ehtml, eitemsort, ebrand,gimg,blnItemifno,blnitempriceyn, LinkEvtCode 	'',blnFull, blnBlogURL
dim itemid : itemid = ""
dim egCode, itemlimitcnt,iTotCnt
dim cdl_e, cdm_e, cds_e
'dim com_egCode
com_egCode = 0
Dim emimgAlt , bimgAlt, isMyFavEvent, clsEvt
Dim j

egCode = requestCheckVar(Request("eGC"),10)	'이벤트 그룹코드
IF egCode = "" THEN egCode = 0

	itemlimitcnt = 105	'상품최대갯수
	'이벤트 개요 가져오기
	set cEvent = new ClsEvtCont
		cEvent.FECode = eCode

		cEvent.fnGetEvent

		eCode		= cEvent.FECode
		ekind		= cEvent.FEKind
		emanager	= cEvent.FEManager
		escope		= cEvent.FEScope
		ename		= cEvent.FEName
		esdate		= cEvent.FESDate
		eedate		= cEvent.FEEDate
		estate		= cEvent.FEState
		eregdate	= cEvent.FERegdate
		epdate		= cEvent.FEPDate
		ecategory	= cEvent.FECategory
		ecateMid	= cEvent.FECateMid
		blnsale		= cEvent.FSale
		blngift		= cEvent.FGift
		blncoupon	= cEvent.FCoupon
		blncomment	= cEvent.FComment
		blnBlogURL	= cEvent.FBlogURL
		blnbbs		= cEvent.FBBS
		blnitemps	= cEvent.FItemeps
		blnapply	= cEvent.FApply
		etemplate	= cEvent.FTemplate
		emimg		= cEvent.FEMimg
		ehtml		= cEvent.FEHtml
		eitemsort	= cEvent.FItemsort
		ebrand		= cEvent.FBrand
		gimg		= cEvent.FGimg
		blnFull		= cEvent.FFullYN
		blnItemifno = cEvent.FIteminfoYN
		evtFile		= cEvent.FevtFile
		evtFileyn	= cEvent.FevtFileyn
		evt_subcopyk= cEvent.FEvt_subcopyK
		etc_itemid = cEvent.FEItemID

		sgroup_w		= cEvent.FEsgroup_w '//이벤트 그룹랜덤

		slide_w_flag		=	cEvent.FESlide_W_Flag '// 슬라이드 모바일 플레그

		If Not(cEvent.FEItemImg="" or isNull(cEvent.FEItemImg)) then
			bimg		= cEvent.FEItemImg
		ElseIf cEvent.FEItemID<>"0" Then
			If cEvent.Fbasicimg600 <> "" Then
				bimg		= "http://webimage.10x10.co.kr/image/basic600/" & GetImageSubFolderByItemid(cEvent.FEItemID) & "/" & cEvent.Fbasicimg600 & ""
			Else
				bimg		= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(cEvent.FEItemID) & "/" & cEvent.Fbasicimg & ""
			End IF
		Else
			bimg		= ""
		End If
		if isNull(emimg) then emimg=""

		blnitempriceyn = cEvent.FItempriceYN
		favCnt		= cEvent.FfavCnt
		edispcate	= cEvent.FEDispCate
		vDisp		= edispcate
		vIsWide		= cEvent.FEWideYN
		vDateView	= cEvent.FDateViewYN

		evt_mo_listbanner	= cEvent.FEmolistbanner
		vIsweb				= cEvent.Fisweb
		vIsmobile			= cEvent.Fismobile
		vIsapp				= cEvent.Fisapp
		
'		IF etemplate = "3" OR etemplate = "7" THEN	'그룹형(etemplate = "3" or "7")일때만 그룹내용 가져오기
			If sgroup_w And egCode = "0" Then '// 그룹형 랜덤 체크 되었을때
				arrTopGroup = cEvent.fnGetEventGroupTop
				egCode = arrTopGroup(0,0)
			End If 
			cEvent.FEGCode = 	egCode
			arrGroup =  cEvent.fnGetEventGroup
			onlyForMDTab = cEvent.fnGetEventGpcode0
'		END IF

		cEvent.FECategory  = ecategory
		arrRecent = cEvent.fnGetRecentEvt_Cache ''fnGetRecentEvt
	set cEvent = nothing
%>
<style type="text/css">
/* 4ten common */
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}
.fourtenColor {background-color:#fff;}
.fourtenColor .navigator {border-bottom:10px solid #fff;}
.fourtenColor .colorHead {position:relative;}
.fourtenColor .title {position:absolute; left:50%; top:85px; z-index:40; width:520px; margin-left:-260px;}
.fourtenColor .title h2 {position:relative;width:520px; height:118px; margin-bottom:27px;}
.fourtenColor .title h2 span {display:block; height:118px; position:absolute; top:0; text-indent:-999em; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/tit_red_pang.png) 0 0 no-repeat;}
.fourtenColor .title h2 .red {left:0; width:218px;}
.fourtenColor .title h2 .pang {right:0; width:302px; background-position:100% 0;}
.fourtenColor .title h2 .flash {left:50%; top:50%; width:520px; margin-left:-260px; margin-top:-59px; background-position:50% 50%; background-size:100% 100%; z-index:30; opacity:0;}
.fourtenColor .title p {text-align:center;}
.fourtenColor .slide {position:relative; width:100% !important; height:1335px !important;}
.fourtenColor .slide .slidesjs-container {width:100% !important; height:1335px !important;}
.fourtenColor .slide .slidesjs-slide {width:100%; height:362px; padding-top:976px !important;}
.fourtenColor .slide .slidesjs-navigation {position:absolute; z-index:10; top:551px; left:50%; width:52px; height:52px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.fourtenColor .slide .slidesjs-previous {margin-left:-542px;}
.fourtenColor .slide .slidesjs-next {margin-left:487px; background-position:100% 0;}
.fourtenColor .slide .color01 {background:#ffe0e6 url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/img_slide_01.jpg) 50% 0 no-repeat;}
.fourtenColor .slide .color02 {background:#f6ec73 url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/img_slide_02.jpg) 50% 0 no-repeat;}
.fourtenColor .slide .color03 {background:#e0feff url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/img_slide_03.jpg) 50% 0 no-repeat;}
.fourtenColor .slide .txt {position:absolute; left:50%; top:1282px; z-index:30; margin-left:-293px;}
.fourtenColor .slide .wave {position:absolute; left:0; top:947px;width:100%; height:30px; background-repeat:repeat-x; background-position:0 0;}
.fourtenColor .slide .color01 .wave {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/bg_wave_01.png);}
.fourtenColor .slide .color02 .wave {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/bg_wave_02.png);}
.fourtenColor .slide .color03 .wave {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/bg_wave_03.png);}
.fourtenColor .slide .bg {height:360px;}
.fourtenColor .slide .color01 .bg {background-color:#fdb6c4;}
.fourtenColor .slide .color02 .bg {background-color:#fbcd5c;}
.fourtenColor .slide .color03 .bg {background-color:#95dee9;}
.fourtenColor .frame {position:absolute; left:50%; top:375px; z-index:40; width:560px; height:520px; margin-left:-280px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/img_frame.png) 0 0 no-repeat;}
.fourtenColor .process {overflow:hidden; position:absolute; left:50%; top:1050px; z-index:40; width:1032px; margin-left:-516px;}
.fourtenColor .process h3 {float:left; width:200px; padding-top:20px;}
.fourtenColor .process ul {float:left;}
.fourtenColor .process li {float:left; padding-left:30px;}
.colorPang {position:relative; padding:110px 0 95px;}
.colorPang .colorCont {position:relative; width:1170px; margin:0 auto;}
.colorPang ul {overflow:hidden; padding:35px 0 15px;}
.colorPang li {float:left; width:262px; height:262px; padding:15px;}
.colorPang li img {width:262px; height:262px;}
.colorPang .deco {position:absolute;}
.colorPang .paint {left:50%; bottom:0; margin-left:-902px;}
.colorPang .brush {left:50%; bottom:-8px; margin-left:400px;}
.colorPang .pageMove {display:none;}
.noti {text-align:left; background-color:#eee;}
.noti .inner {position:relative; width:1140px; margin:0 auto; padding:40px 0; }
.noti .inner h3 {position:absolute; top:50%; left:160px; margin-top:-12px;}
.noti .inner ul {padding-left:340px;}
.noti .inner ul li {margin-bottom:2px; padding-left:14px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/blt_dot.png) no-repeat 0 6px; color:#949393; font-family:'Dotum', 'Verdana'; font-size:12px; line-height:1.5em;}
.fourtenSns {position:relative; background-color:#84edc9;}
.fourtenSns button {overflow:hidden; position:absolute; top:40px; left:50%; width:225px; height:70px; background-color:transparent;}
.fourtenSns .ktShare {margin-left:90px;}
.fourtenSns .fbShare {margin-left:325px;}
.eventContV15 {background-color:#fff; padding-bottom:40px;}
</style>
<script type="text/javascript">
$(function(){
	$('.slide').slidesjs({
		width:1920,
		height:1305,
		pagination:false,
		navigation:{effect:'fade'},
		play:{interval:2400, effect:'fade', auto:true},
		effect:{fade:{speed:1000, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	animation();
	$(".title h2 .red").css({"opacity":"0", "margin-left":"-30px"});
	$(".title h2 .pang").css({"opacity":"0", "margin-right":"-30px"});
	function animation () {
		$(".title h2 .red").delay(600).animate({"opacity":"1", "margin-left":"10px"},500).animate({ "margin-left":"0"},300);
		$(".title h2 .pang").delay(600).animate({"opacity":"1", "margin-right":"10px"},500).animate({"margin-right":"0"},300);
		$(".title h2 .flash").delay(800).animate({ "opacity":"0.2"},100).animate({"width":"620px","height":"218px","margin-left":"-310px","margin-top":"-109px",'opacity':'0'},400);
		$('.title p').delay(1800).effect("pulsate", {times:2},500);
	}
});

$(function(){
	<% if vreload<>"" then %>
		$('html,body').animate({scrollTop: $("#instagram").offset().top},0);
	<% end if %>
});

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">

				<div class="eventContV15">
					<%'' event area(이미지만 등록될때 / 수작업일때) %>
					<div class="contF contW">

						<%'' [W] 70032 컬러가 터진다 %>
						<div class="fourten fourtenColor">
							<!-- #include virtual="/event/4ten/nav.asp" -->
							<div class="colorHead">
								<div class="title">
									<h2>
										<span class="red">RED</span>
										<span class="pang">PANG!</span>
										<span class="flash"></span>
									</h2>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/txt_sub_copy.png" alt="" /></p>
								</div>
								<div class="slide">
									<div class="color01">
										<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/txt_brush_01.png" alt="페인트 붓은 텐바이텐 배송 상품과 함께 배송됩니다. 선착순 한정수량으로 발송되며, 소진 시 미포함될 수 있습니다." /></p>
										<div class="wave"></div>
										<div class="bg"></div>
									</div>
									<div class="color02">
										<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/txt_brush_02.png" alt="페인트 붓은 텐바이텐 배송 상품과 함께 배송됩니다. 선착순 한정수량으로 발송되며, 소진 시 미포함될 수 있습니다." /></p>
										<div class="wave"></div>
										<div class="bg"></div>
									</div>
									<div class="color03">
										<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/txt_brush_03.png" alt="페인트 붓은 텐바이텐 배송 상품과 함께 배송됩니다. 선착순 한정수량으로 발송되며, 소진 시 미포함될 수 있습니다." /></p>
										<div class="wave"></div>
										<div class="bg"></div>
									</div>
								</div>
								<div class="frame"></div>
								<div class="process">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/tit_process.png" alt="이벤트 참여방법" /></h3>
									<ul>
										<li><a href="/event/eventmain.asp?eventid=68802"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/txt_process_01.png" alt="텐바이텐 배송상품 쇼핑하기" /></a></li>
										<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/txt_process_02_v2.png" alt="배송상자 속 리플렛의 붓 확인하기" /></li>
										<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/txt_process_03.png" alt="리플렛의 붓과 함께 인증샷 찍기" /></li>
										<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/txt_process_04.png" alt="#텐바이텐 해시태그로 인스타그램 업로드" /></li>
									</ul>
								</div>
							</div>
							<%'' 인스타그램 이미지 불러오기(이미지 8개씩 노출) %>
							<div class="colorPang" id="instagram">
								<div class="colorCont">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/tit_color.png" alt="텐바이텐 컬러로 일상 곳곳을 칠해주세요" /></h3>
									<%
									sqlstr = "Select * From "
									sqlstr = sqlstr & " ( "
									sqlstr = sqlstr & " 	Select row_Number() over (order by idx desc) as rownum, snsid, link, img_low, img_thum, img_stand, text, snsuserid, snsusername, regdate "
									sqlstr = sqlstr & " 	From db_AppWish.dbo.tbl_snsSelectData "
									sqlstr = sqlstr & " 	Where evt_code="& eCode &""
									sqlstr = sqlstr & " ) as T "
									sqlstr = sqlstr & " Where RowNum between "&(iCCurrpage*iCPageSize)-7&" And "&iCCurrpage*iCPageSize&" "
						
									'response.write sqlstr & "<br>"
									rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
									If Not(rsCTget.bof Or rsCTget.eof) Then
									%>
									<ul>
										<%
										Do Until rsCTget.eof
										%>
										<% '8개 뿌리기 %>
											<li>
												<a href="<%=rsCTget("link")%>"  target="_blank">
													<img src="<%=rsCTget("img_stand")%>" onerror="this.src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/img_delete.png'" alt="" />
												</a>
											</li>
										<%
										rsCTget.movenext
										Loop
										%>
									</ul>
									<div class="pageWrapV15 tMar20">
										<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
									</div>
									<%
									End If
									rsCTget.close
									%>
								</div>
								<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
									<input type="hidden" name="iCC" value="1">
									<input type="hidden" name="reload" value="ON">
									<input type="hidden" name="iCTot" value="<%= iCTotCnt %>">
								</form>
								<div class="deco paint"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/img_deco_paint.gif" alt="" /></div>
								<div class="deco brush"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/img_deco_brush.gif" alt="" /></div>
							</div>
							<%''// 인스타그램 이미지 불러오기 %>
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70032/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>본 이벤트는 인스타그램을 통해서만 참여할 수 있습니다.</li>
										<li>인스타그램 포스팅 시에는 <strong>#텐바이텐</strong>을 꼭 입력해주세요.</li>
										<li>#텐바이텐 해시태그가 입력된 포스팅에 한해 별도의 동의 없이 리스트에 보여집니다.</li>
										<li>본 이벤트 페이지에서 보여지는 것과 당첨여부는 관계가 없을 수 있습니다.</li>
										<li>응모한 계정과 포스팅은 공개로 설정해야 하며, 비공개 시 응모가 불가합니다.</li>
										<li>당첨자 발표는 2016년 5월 4일 오후 입니다.</li>
									</ul>
								</div>
							</div>
							<!-- #include virtual="/event/4ten/sns.asp" -->
						</div>
						<%''// [W] 70032 컬러가 터진다 %>

<%
	IF isArray(arrGroup) THEN
%>
		<% If arrGroup(0,0) <> "" Then %>
		<div class="eventContV15 tMar15">
			<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>"><%''=strExpireMsg%>
			<% if arrGroup(3,0) <> "" then %>
				<a name="event_namelink0"></a>
				<img src="<%=arrGroup(3,0)%>" alt="<%=egCode%>" usemap="#mapGroup<%=egCode%>" class="gpimg"/>
			<% ElseIf (arrGroup(3,0) = "") and ((date() < esdate) and (estate < 5)) Then
				For intTab = 0 To UBound(onlyForMDTab,2)
					if trim(onlyForMDTab(1, intTab))<>"" then
						response.write "<span style=cursor:pointer; onclick=javascript:TnGotoEventGroupMain('"&eCode&"','"&onlyForMDTab(0, intTab)&"');>"& onlyForMDTab(1, intTab) & "</span>"&"<br>"
					end if
				Next
			%>
			<% end if %>
			<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,0))%></map>
			<% If vDateView = False Then %><div class="evtTermWrap"><div class="evtTerm"><p><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></p></div></div><% End If %>
			</div>

<%
		Response.Write "<div class=""evtPdtListWrapV15"">"
			egCode = arrGroup(0,0)
%>
			<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
<%
		Response.Write "</div>"
%>
		</div>

		<%
		j = 1
		End If %>
<%
		Response.Write "<div class=""evtPdtListWrapV15"">"
		For intG = j To UBound(arrGroup,2)
			egCode = arrGroup(0,intG)
%>
			<% if arrGroup(3,intG) <> "" then %>
			<div class="pdtGroupBar" id="groupBar<%=intG%>" name="groupBar<%=intG%>">
				<a name="event_namelink<%=intG%>"></a>
				<img src="<%=arrGroup(3,intG)%>"  usemap="#mapGroup<%=egCode%>" alt="" />
			</div>
			<% Else %>
			<div class="pdtGroupBar" id="groupBar<%=intG%>" name="groupBar<%=intG%>">
				<a name="event_namelink<%=intG%>"></a>
				<%= arrGroup(1,intG) %>
			</div>
			<% end if %>
			<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,intG))%></map>
			<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>" ><% sbEvtItemView %></div>
<%
		Next
		Response.Write "</div>"
	END IF
%>

					</div>
					<%'' //event area(이미지만 등록될때 / 수작업일때) %>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbCTclose.asp" -->