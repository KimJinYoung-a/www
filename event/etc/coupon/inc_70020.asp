<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 꽃샘 쿠폰
' History : 2016-04-06 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid , strSql
Dim getbonuscoupon1 , getlimitcnt1, currenttime
Dim totcnt1

	IF application("Svr_Info") = "Dev" THEN
		eCode = "66099"
		getbonuscoupon1 = "2781"
	Else
		eCode = "70020"
		getbonuscoupon1 = "844"
	End If

	userid = getEncLoginUserID()
	getlimitcnt1 = 30000		'20000
	currenttime = now()

dim bonuscouponcount1, subscriptcount1, totalsubscriptcount1, totalbonuscouponcount1
Dim use_bonuscouponcount1

bonuscouponcount1=0
subscriptcount1=0
totalsubscriptcount1=0
totalbonuscouponcount1=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount1 = getevent_subscriptexistscount(eCode, userid, "", "", "")
	bonuscouponcount1 = getbonuscouponexistscount(userid, getbonuscoupon1, "", "", "")
	use_bonuscouponcount1 = getbonuscouponexistscount(userid, getbonuscoupon1, "", "Y", "")
end if

'//전체 참여수
totalsubscriptcount1 = getevent_subscripttotalcount(eCode, "", "", "")
'//전체 쿠폰 발행수량
totalbonuscouponcount1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")


dim cEvent, cEventItem, arrItem, arrGroup, intI, intG, vIsWide, evtFile, evtFileyn, evt_subcopyk, etc_itemid
dim sgroup_w, slide_w_flag, favCnt, vDisp, vDateView, evt_mo_listbanner, vIsweb, vIsmobile, vIsapp, onlyForMDTab, logparam
dim arrRecent, intR
dim bidx
dim ekind, emanager, escope, eName, esdate, eedate, estate, eregdate, epdate, bimg, eItemListType
dim ecategory, ecateMid, blnsale, blngift, blncoupon, blncomment, blnbbs, blnitemps, blnapply, edispcate
dim etemplate, emimg, ehtml, eitemsort, ebrand,gimg,blnFull,blnItemifno,blnitempriceyn, LinkEvtCode, blnBlogURL
dim itemid : itemid = ""
dim egCode, itemlimitcnt,iTotCnt
dim cdl_e, cdm_e, cds_e
dim com_egCode : com_egCode = 0
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
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}

.couponArea {position:relative; width:1140px; height:767px; background:#fefcce url(http://webimage.10x10.co.kr/eventIMG/2016/70020/bg_flower.png) no-repeat 50% 0;}
.couponArea h2 {position:absolute; top:91px; left:398px;}

.couponArea .flower {position:absolute; top:158px; left:735px;}
.couponArea .flower img {animation:swing 6s ease 0s 2; transform-origin:50% 50%;}
@keyframes swing {
	0% {transform:rotate(0);}
	50% {transform:rotate(10deg);}
	100% {transform:rotate(0);}
}

.couponArea .btnCoupon {position:absolute; top:323px; left:229px;}
.couponArea .btnCoupon button {background-color:transparent;}
.couponArea .btnCoupon .close {position:absolute; top:-62px; left:18px; z-index:5;}
.couponArea .btnCoupon .close {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.8s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.couponArea .btnGroup .soldout {position:absolute; top:8px; left:93px;}

.noti {position:relative; padding:45px 0 44px; background-color:#f1f3e8; text-align:left;}
.noti h3 {position:absolute; top:56px; left:100px;}
.noti ul {margin-left:271px; padding-left:45px; border-left:1px solid #fff;}
.noti ul li {position:relative; margin-bottom:7px; padding-left:10px; color:#838771; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#838771;}
</style>
<script type="text/javascript">

function jseventSubmit(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) >= "2016-04-10" and left(currenttime,10) < "2016-04-13") Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount1>0 or bonuscouponcount1>0 then %>
				alert("쿠폰은 한 개의 아이디당 한 번만 다운 받으실 수 있습니다.");
				return;
			<% else %>
				<% if totalsubscriptcount1>=getlimitcnt1 or totalbonuscouponcount1>=getlimitcnt1 then %>
					alert("죄송합니다. 쿠폰이 모두 소진 되었습니다.");
					return;
				<% else %>
					frm.action="/event/etc/doeventsubscript/doEventSubscript70020.asp";
					frm.target="evtFrmProc";
					//frm.target="_blank";
					frm.mode.value='coupon';
					frm.submit();
				<% end if %>
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}
</script>
<% If userid = "cogusdk" Or userid = "greenteenz" Or userid = "baboytw" Then %>
<div>
	<p>&lt;<%= getbonuscoupon1 %>&gt; 쿠폰 발급건수 : <%= totalbonuscouponcount1 %> </p>
</div>
<% End If %>
	<%'' [W] 70020 보너스쿠폰 - 꽃샘쿠폰 %>
	<div class="evt70020 floweringCoupon">
		<div class="couponArea">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/70020/tit_coupon.png" alt="꽃샘쿠폰 이른 봄, 꽃들도 샘내는 아름다운 할인쿠폰이 찾아왔습니다!" /></h2>
			<span class="flower"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70020/img_flower.png" alt="" /></span>
			<div class="btnCoupon">
				<% if totalsubscriptcount1>=getlimitcnt1 or totalbonuscouponcount1>=getlimitcnt1 then %>
					<%'' for dev msg : 쿠폰 모두 소진 시 %>
					<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70020/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다. 다음 기회에 이용해주세요" /></p>
				<% else %>
					<% if ((getlimitcnt1 - totalsubscriptcount1) < 10000) or ((getlimitcnt1 - totalbonuscouponcount1) < 10000) then %>
						<%'' for dev msg : 쿠폰이 ** 남아있을때 보여주세요 %>
						<strong class="close"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70020/ico_close.png" alt="마감임박" /></strong>
					<% end if %>
				<% end if %>
				<button type="button" onclick="jseventSubmit(evtFrm1);return false;" title="만원 쿠폰 다운 받기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70020/btn_coupon.png" alt="6만원 이상 구매시, 4월 11, 22일 사용 가능" /></button>
			</div>
		</div>

		<div class="appdownJoin">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/70020/txt_app_join.png" alt="" usemap="#link" />
			<map name="link" id="link">
				<area shape="rect" coords="119,47,456,150" href="/event/appdown/" alt="텐바이텐 앱 설치 아직이신가요? 텐바이텐 앱 다운" />
				<!-- for dev msg : 로그인 시 http://www.10x10.co.kr/event/eventmain.asp?eventid=69727 이벤트 참고해주세요 -->
				<area shape="rect" coords="681,45,1020,149" href="/member/join.asp" alt="텐바이텐에 처음오셨나요? 회원가입하고 구매하러 가기!" />
			</map>
		</div>

		<div class="noti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70020/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span> 이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
				<li><span></span> 지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
				<li><span></span> 쿠폰은 04/12(화) 23시 59분 종료됩니다.</li>
				<li><span></span> 주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
				<li><span></span> 이벤트는 조기 마감 될 수 있습니다.</li>
			</ul>
		</div>
	</div>
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
<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;">
	<input type="hidden" name="mode" />
</form>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>
<!-- #include virtual="/lib/db/dbclose.asp" -->