<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시리스트 - 내가 꿈꾸는 서재
' History : 2015-08-27 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/etc/wishlist/wisheventCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	dim eCode, subscriptcount, userid
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  "64866"
	Else
		eCode   =  "65808"
	End If

	Dim ename, emimg, cEvent, blnitempriceyn
	set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN	

	set cEvent = nothing

	userid = getloginuserid()

	Dim ifr, page, i, y
	page = request("page")

	If page = "" Then page = 1

	set ifr = new evt_wishfolder
	ifr.FPageSize = 5
	ifr.FCurrPage = page
	ifr.FeCode = eCode

	ifr.Frectuserid = userid
	ifr.evt_wishfolder_list
%>
<style type="text/css">
img {vertical-align:top;}
.evt65808 {position:relative;}
.evt65808 .makeFolder {position:absolute; top:352px; right:10px;}
.evt65808 img {vertical-align:top;}
.evt65808 .myWeddingWish {padding-bottom:55px; background:#a7daf1 url(http://webimage.10x10.co.kr/eventIMG/2015/65808/bg_pattern.png) repeat 0 0;}
.evt65808 .putMyWish {width:860px; margin:0 auto; padding:52px 83px 55px; text-align:center; background:#fff;}
.evt65808 .putMyWish .myFolder {position:relative; padding-bottom:5px; border-bottom:2px solid #000;}
.evt65808 .putMyWish .myFolder img {vertical-align:middle;}
.evt65808 .putMyWish .myFolder span {padding-right:10px; font-size:25px; line-height:25px; color:#000; vertical-align:middle;}
.evt65808 .putMyWish .myFolder a {display:inline-block; position:absolute; top:11px; right:5px;}
.evt65808 .putList {width:834px; height:150px; margin:48px 0 28px 12px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65703/bg_my_item.gif) no-repeat 0 0;}
.evt65808 .putList ul {overflow:hidden; margin-right:-21px;}
.evt65808 .putList li {float:left; width:150px; height:150px; padding-right:21px;}
.evt65808 .putList li img {width:150px; height:150px;}
.evt65808 .friendsWish {padding-bottom:60px; background:#fff;}
.evt65808 .friendsWish h3 {padding-bottom:55px;}
.evt65808 .friendsWish dl {width:1001px; margin:0 auto;}
.evt65808 .friendsWish dt {padding:0 0 8px 42px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65703/bg_line.gif) repeat-x 0 100%; text-align:left;}
.evt65808 .friendsWish dt span {display:inline-block; height:20px; padding-left:28px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65703/ico_cart.gif) no-repeat 0 0; font-size:13px; color:#000;}
.evt65808 .friendsWish dd {padding-bottom:72px;}
.evt65808 .friendsWish dd ul {overflow:hidden; padding-top:44px;}
.evt65808 .friendsWish dd li {float:left; width:150px; padding-left:42px;}
.evt65808 .friendsWish dd li img {width:150px; height:150px;}

.evt65808 .evtNoti {position:relative; padding:60px 70px; text-align:left;}
.evt65808 .evtNoti p {position:absolute; top:57px; right:85px;}
.evt65808 .evtNoti dt {padding-bottom:25px;}
.evt65808 .evtNoti dd li {padding:0 0 10px 12px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65703/blt_arrow.gif) no-repeat 0 2px; font-size:11px; line-height:12px; color:#000; }
.evt65808 .evtNoti dd li img {display:inline-block; margin-top:-2px; vertical-align:top;}

.pageWrapV15 {width:1001px; margin:0 auto;}
</style>
<Script>
function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}
<% if page>1 then %>
	setTimeout("$('html,body',document).scrollTop(1400);", 200);
<% end if %>

function jsSubmit()
{
	<% If IsUserLoginOK() Then %>
		<% If Now() > #09/06/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If date() >= "2015-08-28" and date() < "2015-09-07" Then %>
				var frm = document.frm;
				frm.action="/event/etc/wishlist/wishfolderProc.asp";
				frm.hidM.value='I';
				frm.submit();
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>
		<% end if %>
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}
</script>
<%
Dim sp, spitemid, spimg
Dim arrCnt, foldername

	foldername = "내가 꿈꾸는 서재"
	Dim strSql, vCount, vFolderName, vViewIsUsing
	vCount = 0

	strSql = "Select COUNT(fidx) From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "' "
	'response.write strSql
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		vCount = rsget(0)
	else
		vCount = 0
	END IF
	rsget.Close
%>
<form name="frm" method="post">
<input type="hidden" name="hidM" value="I">
<input type="hidden" name="foldername" value="<%=foldername%>">
<input type="hidden" name="eventid" value="<%=eCode%>">
<div class="evt65808">
	<h2>
		<img src="http://webimage.10x10.co.kr/eventIMG/2015/65808/tit_my_wedding_wish.jpg" alt="MY DREAM HOUSE V.2 내가 꿈꾸는 서재" usemap="#goEvt" />
		<map name="goEvt" id="goEvt">
			<area shape="rect" coords="1,1,148,142" href="/event/eventmain.asp?eventid=65779" alt="서재 기획전 바로가기" />
		</map>
	</h2>
	<p class="makeFolder"><a href="" onclick="jsSubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65808/btn_make_folder.png" alt="[내가 꿈꾸는 서재] 위시폴더 만들고 이벤트 참여하기" /></a></p>
	<div class="myWeddingWish">
		<% If IsUserLoginOK() Then %>
			<% if vCount > 0 then %>
				<div class="putMyWish">
					<div class="myFolder">
						<span><%= userid %></span><img src="http://webimage.10x10.co.kr/eventIMG/2015/65808/txt_my_folder.png" alt="<%= userid %>님의 [내가 꿈꾸는 서재] 위시 폴더" />
						<a href="/my10x10/mywishlist.asp" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65703/btn_go_mywish.gif" alt="나의 위시 보러가기" /></a>
					</div>
					<div class="putList">
						<ul>
						<% if ifr.FmyTotalCount > 0 then %>
							<%
								if isarray(Split(ifr.Fmylist,",")) then
									arrCnt = Ubound(Split(ifr.Fmylist,","))
								else
									arrCnt=0
								end if
	
								If ifr.FmyTotalCount > 4 Then
									arrCnt = 5
								Else
									arrCnt = ifr.FmyTotalCount
								End IF
	
								For y = 0 to CInt(arrCnt) - 1
									sp = Split(ifr.Fmylist,",")(y)
									spitemid = Split(sp,"|")(0)
									spimg	 = Split(sp,"|")(1)
							%>
							<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" /></a></li>
							<%
								Next
							%>
						<% end if %>
						</ul>
					</div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65703/txt_tip.gif" alt="최소 5개 이상의 상품을 담아주셔야 당첨이 됩니다." /></p>
				</div>
			<% else %>
				<p style="display:block;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65808/img_apply_process.png" alt="이벤트 참여방법" /></p>
			<% end if %>
		<% else %>
			<p style="display:block;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65808/img_apply_process.png" alt="이벤트 참여방법" /></p>
		<% end if %>
	</div>

	<% If ifr.FResultCount > 0 Then %>
	<div class="friendsWish">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65808/tit_friends_wish.png" alt="다른 친구들의 [내가 꿈꾸는 서재] 폴더를 둘러보세요!" /></h3>
		<% For i = 0 to ifr.FResultCount -1 %>
			<dl>
				<dt><span><%=printUserId(ifr.FList(i).FUserid,2,"*")%>님의 위시리스트</span></dt>
				<dd>
					<ul>
					<%
						if isarray(Split(ifr.FList(i).FArrIcon2Img,",")) then
							arrCnt = Ubound(Split(ifr.FList(i).FArrIcon2Img,","))
						else
							arrCnt=0
						end if

						If ifr.FList(i).FCnt > 4 Then
							arrCnt = 5
						Else
							arrCnt = ifr.FList(i).FCnt
						End IF

						For y = 0 to CInt(arrCnt) - 1
							sp = Split(ifr.FList(i).FArrIcon2Img,",")(y)
							spitemid = Split(sp,"|")(0)
							spimg	 = Split(sp,"|")(1)
					%>
						<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" /></a></li>
					<%
						Next
					%>	
					</ul>
				</dd>
			</dl>
		<% next %>
		<div class="pageWrapV15">
		<%= fnDisplayPaging_New(page,ifr.FTotalCount,5,10,"jsGoPage") %>
		</div>
	</div>
	<% end if %>

	<div class="evtNoti">
		<dl>
			<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/65703/tit_noti.gif" alt="유의사항은 꼭 읽어주세요!" /></dt>
			<dd>
				<ul>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/65703/btn_apply.gif" alt="참여하기" /> 클릭 시, 위시리스트에 &lt;내가 꿈꾸는 키친&gt; 폴더가 자동 생성 됩니다.</li>
					<li>본 이벤트에서 <img src="http://webimage.10x10.co.kr/eventIMG/2015/65703/btn_apply.gif" alt="참여하기" />를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
					<li>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다.</li>
					<li>위시리스트에 &lt;내가 꿈꾸는 키친&gt; 폴더는 한 ID당 1개만 생성이 가능합니다.</li>
					<li>해당 폴더에 5개 이상의 상품, 총 금액이 50만원 이상이 되도록 넣어주세요.</li>
					<li>해당 폴더 외에 다른 폴더에 담으시는 상품은 이벤트 응모와는 무관 합니다.</li>
					<li>당첨자에 한 해 개인정보를 요청하게 되며, 개인정보 확인 후 경품이 지금 됩니다.</li>
					<li>본 이벤트는 종료일인 9월 6일 23시 59분 59초까지 담겨진 상품을 기준으로 선정합니다.</li>
				</ul>
			</dd>
		</dl>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65808/img_wish_ex.png" alt="" /></p>
	</div>
	<%
		'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
		dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
		snpTitle = Server.URLEncode(ename)
		snpLink = Server.URLEncode("http://10x10.co.kr/event/" & ecode)
		snpPre = Server.URLEncode("텐바이텐 이벤트")
		snpTag = Server.URLEncode("텐바이텐 " & Replace(ename," ",""))
		snpTag2 = Server.URLEncode("#10x10")
		snpImg = Server.URLEncode(emimg)
	%>
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2015/65808/img_share_sns.png" alt="친구에게도 알려주자!" usemap="#share" />
		<map name="share" id="share">
			<area shape="rect" coords="892,82,942,131" onfocus="this.blur();" href="#" alt="twitter" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');return false;"/>
			<area shape="rect" coords="956,82,1007,129" onfocus="this.blur();" href="#" alt="facebook" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"/>
		</map>
	</div>
</div>
</form>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
	<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="page" value="">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->
