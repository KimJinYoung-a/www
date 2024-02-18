<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  습격자들 온라인편 - 위시리스트
' History : 2015-11-03 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/etc/wishlist/wisheventCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	dim eCode, subscriptcount, userid , vreturnurl
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  "65944"
	Else
		eCode   =  "67204"
	End If

	vreturnurl = Request.ServerVariables("url") &"?"&Request.ServerVariables("QUERY_STRING")

	Dim ename, emimg, cEvent, blnitempriceyn
	set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN	

	set cEvent = nothing

	userid = GetEncLoginUserID()

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
.evt67204 {background-color:#fff;}
.evt67204 .pageMove {display:none;}
.marauders {height:1371px; text-align:left;  background:url(http://webimage.10x10.co.kr/eventIMG/2015/67204/bg_body.gif) 50% 0 repeat-x;}
.maraudersCont {overflow:hidden; width:1140px; height:736px; margin:0 auto;}
.maraudersCont h2 {padding:82px 0 0 62px;}
.maraudersCont .mission {padding:115px 0 0 0;}
.makeFolder {position:relative; width:1140px; margin:0 auto;}
.makeFolder .btnSubmit {display:inline-block; position:absolute; left:58px; top:-209px;}
.myFolder {position:relative; width:1272px; height:414px; padding-top:45px; margin:50px auto 0; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67204/bg_box.png) 0 0 no-repeat;}
.myFolder .viewMyItem {width:1140px; margin:0 auto;}
.myFolder .tit {padding-bottom:12px; margin-bottom:45px; text-align:center; border-bottom:2px solid #972a15;}
.myFolder .tit span {display:inline-block; height:25px; font-size:16px; font-weight:bold; color:#972a15; line-height:25px; padding-left:37px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67204/ico_star.gif) 0 0 no-repeat;}
.myFolder ul {width:950px; height:160px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67204/bg_product.gif) 0 0 repeat-x;}
.myFolder li {float:left; width:160px; height:160px; margin-left:30px;}
.myFolder li:first-child {margin-left:0;}
.myFolder li img {width:160px; height:160px;}
.myFolder .btnGoWish {display:inline-block; position:absolute; left:124px; top:-260px;}
.myFolder .btnAnother {display:inline-block; position:absolute; right:77px; bottom:166px;}
.myFolder .total {text-align:center; padding-top:88px;}
.myFolder .total strong {display:inline-block; line-height:31px; font-weight:normal; padding:0 3px 0 20px; font-size:46px; letter-spacing:-1px; font-family:arial; color:#972a15;}
.friendsWish {position:relative; width:1057px; margin:0 auto;  padding-top:90px;}
.friendsWish h3 {position:absolute; left:145px; top:-70px; z-index:50;}
.friendsWish dl {padding-bottom:60px;}
.friendsWish dt {width:985px; height:26px; font-size:11px; line-height:12px; color:#972a15; padding:5px 0 0 72px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67204/ico_cart.gif) 0 0 no-repeat;}
.friendsWish dd {width:970px; padding:38px 0 0 68px;}
.friendsWish ul {overflow:hidden; width:970px;}
.friendsWish ul li {float:left; width:150px; height:150px; margin-right:43px;}
.friendsWish ul li img {width:150px; height:150px;}
.shareSns {width:1140px; margin:0 auto; padding:70px 0 55px;}
.notiWrap {padding:30px 0 20px; background:#efefef;}
.notiWrap .evtNoti {overflow:hidden; width:1140px; margin:0 auto;}
.notiWrap .evtNoti h3 {float:left; width:300px; padding-top:50px; text-align:center;}
.notiWrap .evtNoti ul {float:left; text-align:left;}
.notiWrap .evtNoti li {font-size:11px; line-height:12px; color:#8e8e8e; padding:0 0 12px 15px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67204/blt_round.gif) 0 3px no-repeat;}
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
		<% If Now() > #11/13/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If Now() > #11/05/2015 10:00:00# and Now() < #11/13/2015 23:59:59# Then %>
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

	foldername = "습격자들"
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
<input type="hidden" name="returnurl" value="<%=vreturnurl%>">
<div class="evt67204">
	<div class="marauders">
		<div class="maraudersCont">
			<h2 class="ftLt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/tit_marauders02.png" alt="습격자들" /></h2>
			<div class="ftRt mission"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/txt_mission.png" alt="MISSION" /></div>
		</div>
		<% if vCount > 0 then %>
		<div class="myFolder">
			<div class="viewMyItem">
				<p class="tit"><span><%= userid %>님의 [습격자들] 위시폴더</span></p>
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
					End If
					
					Dim totcash : totcash = 0 '//합계금액
					For y = 0 to cint(ifr.FmyTotalCount) - 1
						sp = Split(ifr.Fmylist,",")(y)
						totcash  = totcash + Split(sp,"|")(2)
					next

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
				<a href="/my10x10/mywishlist.asp" class="btnAnother"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/btn_another.gif" alt="그 이외 상품 확인하러 가기" /></a>
			</div>
			<div class="total">
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/txt_price01.gif" alt="현재 합계금액" />
				<strong><%=FormatNumber(totcash,0)%></strong>
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/txt_price02.gif" alt="원" />
			</div>
			<a href="/my10x10/popularwish.asp" class="btnGoWish" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/btn_go_wish.png" alt="위시리스트 채우러 가기" /></a>
		</div>
		<% Else %>
		<div class="makeFolder">
			<input type="image" onclick="jsSubmit(); return false;" src="http://webimage.10x10.co.kr/eventIMG/2015/67204/btn_apply.png" class="btnSubmit"  alt="[습격자들] 이벤트 참여하기" />
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/txt_process.png" alt="이벤트 참여 방법" /></div>
		</div>
		<% End If %>
	</div>
	<% If ifr.FResultCount > 0 Then %>
	<div class="friendsWish">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/tit_friends_wish.png" alt="이미 발 빠르게 움직이고 있는 친구들" /></h3>
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
	<% End If %>
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
	<div class="shareSns">
		<img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/btn_share.gif" alt="" usemap="#map" />
		<map name="map" id="map">
			<area shape="rect" coords="398,17,451,69" alt="페이스북" href="#" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"/>
			<area shape="rect" coords="460,16,515,70" alt="트위터" href="#" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');return false;"/>
			<area shape="rect" coords="580,0,1052,90" alt="습격자들 오프라인편 확인하러 가기" href="/event/eventmain.asp?eventid=67284" />
		</map>
	</div>
	<div class="notiWrap">
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/67204/tit_noti.gif" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>본 이벤트에서 참여하기를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
				<li>참여하기 클릭 시, 위시리스트에 &lt;습격자들&gt; 폴더가 자동 생성됩니다.</li>
				<li>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다.</li>
				<li>위시리스트에 &lt;습격자들&gt; 폴더는 한 ID당 1개만 생성이 가능합니다.</li>
				<li>해당 폴더에 5개 이상의 상품, 총 금액이 50만원 이상이 되도록 넣어주세요. </li>
				<li>해당 폴더 외에 다른 폴더에 담으시는 상품은 이벤트 응모와는 무관 합니다.</li>
				<li>당첨자에 한 해 개인정보를 요청하게 되며, 개인정보 확인 후 경품이 지금 됩니다.</li>
				<li>본 이벤트는 11월 15일 23시59분59초까지 담겨진 상품을 기준으로 선정합니다.</li>
				<li>위시리스트 속 상품은 최근 5개만 보여집니다.</li>
				<li>당첨자 안내는 11월 17일에 공지사항을 통해 진행됩니다.</li>
			</ul>
		</div>
	</div>
</div>
</form>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
	<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="page" value="">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->
