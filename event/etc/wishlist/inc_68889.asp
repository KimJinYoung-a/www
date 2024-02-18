<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시리스트 - 오늘은 털날
' History : 2016-02-02 이종화 생성
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
	dim eCode, subscriptcount, userid
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  "66021"
	Else
		eCode   =  "68889"
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

	'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
	dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle = Server.URLEncode(ename)
	snpLink = Server.URLEncode("http://www.10x10.co.kr/event/" & ecode)
	snpPre = Server.URLEncode("텐바이텐 이벤트")
	snpTag = Server.URLEncode("텐바이텐 " & Replace(ename," ",""))
	snpTag2 = Server.URLEncode("#10x10")
	snpImg = Server.URLEncode(emimg)
%>
<style type="text/css">
img {vertical-align:top;}
.evt68889 {background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_bg.png) 0 0 repeat;}
.evt68889 .pageMove {display:none;}
.emptDay {position:relative; text-align:center;}
.emptDayHead {position:relative; padding-top:85px;}
.makeFolder {position:relative; width:1140px; margin:0 auto; padding:92px 0 63px 0;}
.makeFolder a {overflow:hidden; display:block; position:absolute; left:0; top:25px; width:450px; height:500px; text-indent:-999em;}
.decoClick1 {position:absolute; left:96px; top:26px; width:55px; height:56px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/ico_click1.png) 0 0 no-repeat; animation:pointing1 1s cubic-bezier(.21,.89,.82,.41)  0s 10;}
.decoClick2 {position:absolute; left:386px; top:147px; width:52px; height:54px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/ico_click2.png) 0 0 no-repeat; animation:pointing2 1.1s ease-out 0s 10;}
.myFolder {position:relative; width:1140px; margin:50px auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/bg_empt_wish_box.png) 0 0 no-repeat; text-align:left;}
.myFolder .viewMyItem {width:1030px; margin:0 auto; padding-top:65px;}
.myFolder .tit {padding-bottom:12px; margin-bottom:45px; text-align:center;}
.myFolder .tit span {display:inline-block; height:25px; font-size:16px; font-weight:bold; color:#6f6f6f; line-height:25px;}
.myFolder ul {width:850px; height:160px; background:url(http://webimage.10x10.co.kr/eventIMG/201/68889/bg_product.gif) 0 0 repeat-x; z-index:100; text-align:left;}
.myFolder li {position:relative; float:left; width:160px; height:160px; margin:0 5px; z-index:100;}
.myFolder li a {z-index:100;}
.myFolder li img {width:160px; height:160px;}
.myFolder .btnAnother {display:block; position:absolute; right:55px; top:150px; width:176px; height:160px; z-index:100;}
.myFolder .total {text-align:center; padding:88px 0 63px 0;}
.myFolder .total strong {display:inline-block; line-height:31px; font-weight:normal; padding:0 3px 0 20px; font-size:46px; letter-spacing:-1px; font-family:arial; color:#972a15;}
.tipView {background-color:rgba(237,217,191,.5); height:216px;}
.tipView div {overflow:hidden; width:1015px; margin:0 auto; padding:50px 0;}
.decoCloud1 {position:absolute; left:50%; top:170px; width:125px; height:39px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_cloud1.png) 100% 0 no-repeat; animation:moving1 5s ease-in-out 0s 10;}
.decoCloud2 {position:absolute; right:50%; top:296px; width:446px; height:48px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_cloud2.png) 0 0 no-repeat; animation:moving2 7s ease-in-out 0s 5; z-index:0;}
.decoCloud3 {position:absolute; left:50%; top:349px; width:570px; height:45px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_cloud3.png) 100% 0 no-repeat; animation:moving2 5s ease-in-out 0s 7;}
.decoCloud4 {position:absolute; right:50%; top:398px; width:700px; height:31px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_cloud4.png) 0 0 no-repeat;}
@keyframes moving1 {
	50% {transform:translate(20px,0);}
}
@keyframes moving2 {
	50% {transform:translate(-30px,0);}
}
@keyframes pointing1 {
	50% {transform:translate(3px,3px);}
}
@keyframes pointing2 {
	50% {transform:translate(-2px,3px);}
}
.decoBird {position:absolute; left:50%; top:225px; width:645px; height:31px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_bird.png) 100% 0 no-repeat;}
.decoTree1 {position:absolute; right:50%; top:131px; width:50%; min-width:690px; height:253px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_tree1.png) 0 0 no-repeat;}
.decoTree2 {position:absolute; left:50%; top:570px; width:50%; min-width:690px; height:240px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_tree2.png) 100% 0 no-repeat; z-index:0}
.decoHill1 {position:absolute; left:0; bottom:216px; width:493px; height:219px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_deco1.png) 0 0 no-repeat;}
.decoHill2 {position:absolute; right:0; bottom:204px; width:276px; height:201px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_deco2.png) 0 0 no-repeat;}
.friendsWish {position:relative; padding:80px 0;}
.friendsWish .frWishList {width:1060px; margin:40px auto; padding:20px 40px 30px 40px; background-color:#fff;}
.friendsWish dl {width:1060px; padding:25px 0;}
.friendsWish dt {padding:10px 0 15px 50px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/wish_line.png) 0 100% repeat-x;}
.friendsWish dt span {display:block; height:12px; padding:5px 0 5px 30px; line-height:12px; color:#717171; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/ico_cart.png) 0 50% no-repeat;}
.friendsWish dd {padding:38px 0 10px 0;}
.friendsWish ul {overflow:hidden; width:1010px; margin:0 auto;}
.friendsWish ul li {float:left; width:150px; height:150px; margin:0 26px;}
.friendsWish ul li img {width:150px; height:150px;}
.decoHill3 {position:absolute; left:0; bottom:0; width:306px; height:182px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_deco3.png) 0 0 no-repeat;}
.decoHill4 {position:absolute; right:0; bottom:0; width:585px; height:218px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_deco4.png) 0 0 no-repeat;}
.notiWrap {padding:30px 0 20px; background:#efefef;}
.notiWrap .evtNoti {overflow:hidden; width:1140px; margin:0 auto;}
.notiWrap .evtNoti h3 {float:left; width:300px; padding-top:50px; text-align:center;}
.notiWrap .evtNoti ul {float:left; text-align:left;}
.notiWrap .evtNoti li {font-size:11px; line-height:12px; color:#8e8e8e; padding:0 0 12px 15px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68889/blt_round.png) 0 3px no-repeat;}
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
		<% If Now() > #02/14/2016 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If Now() > #02/03/2016 10:00:00# and Now() < #02/14/2016 23:59:59# Then '#02/10/2016 10:00:00# %>
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

function getsnscnt(snsno) {
	var str = $.ajax({
		type: "GET",
		url: "/event/etc/wishlist/wishfolderProc.asp",
		data: "hidM=S&snsno="+snsno+"&eventid="+<%=eCode%>,
		dataType: "text",
		async: false
	}).responseText;
	if(str=="tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(str=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else{
		alert('오류가 발생했습니다.');
		return false;
	}
}
</script>
<%
Dim sp, spitemid, spimg
Dim arrCnt, foldername

	foldername = "오늘은 털날"
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
<div class="evt68889">
	<div class="emptDay">
		<div class="emptDayHead">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_tit.png" alt="어제는 설날 오늘은 WISH를 털날" /></h2>
			<span class="decoCloud1"></span>
			<span class="decoCloud2"></span>
			<span class="decoCloud3"></span>
			<i class="decoCloud4"></i>
			<i class="decoBird"></i>
		</div>
		<% if vCount > 0 then %>
		<div class="myFolder">
			<div class="viewMyItem">
				<p class="tit"><span><%= userid %>님의 [오늘은 털날] 위시폴더</span></p>
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
				<a href="/my10x10/mywishlist.asp" class="btnAnother"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/btn_another.png" alt="그 이외 상품 확인하러 가기" /></a>
			</div>
			<div class="total">
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/txt_price01.png" alt="현재 합계금액" />
				<strong><%=FormatNumber(totcash,0)%></strong>
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/txt_price02.png" alt="원" />
			</div>
			<p class="tMar50"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_wish_join2.png" alt="참여방법 : 위시폴더만들고 이벤트 참여하기 후 원하는 상품의 위시아이콘 클릭해서 오늘은 털날 폴더에 위시상품 담기" /></p>
		</div>
		<% Else %>
		<div class="makeFolder">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/empt_wish_join.png" alt="이벤트 참여하기 버튼을 클릭하고 위시폴더 자동생성 한 후 원하는 상품의 위시아이콘 클릭해서 오늘은 털날 폴더에 위시상품 담기" />
			<a href="" onclick="jsSubmit(); return false;">오늘은 털날 이벤트 참여하기</a>
			<i class="decoClick1"></i>
			<i class="decoClick2"></i>
		</div>
		<% End If %>
		<div class="tipView">
			<div>
				<p class="ftLt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/txt_tip.png" alt="당첨 TIP" /></p>
				<p class="ftRt tMar12">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/btn_share.png" alt="친구들에게 소식 전해주기" usemap="#emptSnsMap" />
					<map name="emptSnsMap" id="emptSnsMap">
						<area shape="circle" coords="299,46,32" href="#" alt="Facebook Share" title="Facebook Share" onclick="getsnscnt('fb');return false;"/>
						<area shape="circle" coords="362,46,32" href="#" alt="Twitter Share" title="Twitter Share" onclick="getsnscnt('tw');return false;"/>
					</map>
				</p>
			</div>
		</div>

		<i class="decoTree1"></i>
		<i class="decoTree2"></i>
		<i class="decoHill1"></i>
		<i class="decoHill2"></i>
	</div>

	<% If ifr.FResultCount > 0 Then %>
	<div class="friendsWish">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/tit_friend_wish.png" alt="이미 손 빠르게 움직이고 있는 친구들" /></h3>
		<div class="frWishList">
			<% For i = 0 to ifr.FResultCount -1 %>
			<dl>
				<dt><span><strong><%=printUserId(ifr.FList(i).FUserid,2,"*")%></strong> 님의 위시리스트</span></dt>
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
		</div>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(page,ifr.FTotalCount,5,10,"jsGoPage") %>
		</div>
		<i class="decoHill3"></i>
		<i class="decoHill4"></i>
	</div>
	<% End If %>

	<div class="notiWrap">
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/68889/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>본 이벤트에서 참여하기를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
				<li>참여하기 클릭 시, 위시리스트에 &lt;오늘은 털날&gt; 폴더가 자동 생성됩니다.</li>
				<li>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다.</li>
				<li>위시리스트에 &lt;오늘은 털날&gt; 폴더는 한 ID당 1개만 생성이 가능합니다.</li>
				<li>해당 폴더에 5개 이상의 상품, 총 금액이 50만원 이상이 되도록 넣어주세요.</li>
				<li>해당 폴더 외에 다른 폴더에 담으시는 상품은 이벤트 응모와는 무관 합니다.</li>
				<li>당첨자에 한 해 개인정보를 요청하게 되며, 개인정보 확인 후 경품이 지금 됩니다.</li>
				<li>본 이벤트는 2월 14일 23시59분59초까지 담겨진 상품을 기준으로 선정합니다.</li>
				<li>위시리스트 속 상품은 최근 5개만 보여집니다.</li>
				<li>당첨자 안내는 2월 16일에 공지사항을 통해 진행됩니다.</li>
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
