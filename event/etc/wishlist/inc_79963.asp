<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시리스트 - 하트시그널
' History : 2017-08-24 정태훈 생성
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
Dim eCode, subscriptcount, userid
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "66418"
Else
	eCode   =  "79963"
End If

Dim ename, emimg, cEvent, blnitempriceyn, vreturnurl
vreturnurl = Request.ServerVariables("url") &"?"&Request.ServerVariables("QUERY_STRING")

userid = GetEncLoginUserID()

Dim ifr, page, i, y
page = request("page")

If page = "" Then page = 1

Set ifr = new evt_wishfolder
	ifr.FPageSize	= 4
	ifr.FCurrPage	= page
	ifr.FeCode		= eCode
	ifr.Frectuserid = userid
	'ifr.evt_wishfolder_list		'메인디비
	ifr.evt_wishfolder_list_B	'캐쉬디비
%>
<style type="text/css">

.evt79963 button {background-color:transparent;}
img {vertical-align:top;}
.heartSignal {position:relative; padding-top:126px; background-color:#fba1cc;}
.heartSignal .heartHead {position:relative; z-index:50; width:885px; height:528px; padding-top:214px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79963/bg_heart.png) 50% 0 no-repeat;}
.heartSignal .heartHead h2 {position:relative; opacity:0;}
.heartSignal .heartHead .line {padding:15px 0 30px;}
.heartSignal .heartHead .date {padding-top:40px;}
.heartSignal .heartDeco span {display:inline-block; position:absolute; top:0; left:50%; z-index:30; opacity:0; animation:moveUp 1s 1s 30 ease-in-out; -webkit-animation:moveUp 1.3s 1s 30 ease-in-out;}
.heartSignal .heartDeco .heartL {width:62px; height:49px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79963/img_heart_1.png) 50% 0 no-repeat;}
.heartSignal .heartDeco .heartS {width:27px; height:21px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79963/img_heart_2.png) 50% 0 no-repeat;}
.heartSignal .heartDeco .ht1 {top:28px; margin-left:-650px;}
.heartSignal .heartDeco .ht2 {top:180px; margin-left:-492px; animation-delay:.3s;}
.heartSignal .heartDeco .ht3 {top:250px; margin-left:-885px; animation-delay:.3s;}
.heartSignal .heartDeco .ht4 {top:320px; margin-left:-800px; animation-delay:.5s;}
.heartSignal .heartDeco .ht5 {top:456px; margin-left:-370px; animation-delay:.5s;}
.heartSignal .heartDeco .ht6 {top:460px; margin-left:-625px; animation-delay:.5s;}
.heartSignal .heartDeco .ht7 {top:30px; margin-left:453px; animation-delay:.5s;}
.heartSignal .heartDeco .ht8 {top:155px; margin-left:705px; animation-delay:.3s;}
.heartSignal .heartDeco .ht9 {top:255px; margin-left:907px; animation-delay:.5s;}
.heartSignal .heartDeco .ht10 {top:330px; margin-left:882px; animation-delay:.5s;}
.heartSignal .heartDeco .ht11 {top:410px; margin-left:510px; animation-delay:.5s;}
@keyframes moveUp {
	0% {margin-top:100px; opacity:.4;}
	10%{opacity:1;}
	70%(opacity:1;)
	100% {margin-top:0; opacity:0;}
}
@-webkit-keyframes moveUp {
	0% {margin-top:200px; opacity:.4;}
	10%{opacity:1;}
	70%(opacity:1;)
	100% {margin-top:0; opacity:0;}
}
.heartSignal .wave {width:100%; height:94px;position:relative; z-index:30; margin-top:-246px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79963/bg_wave.png) 50% 0 repeat-x;}
.process {position:relative; padding:246px 0 157px; background-color:#181a48;}
.process .btnClick {position:absolute; left:50%; top:400px; margin-left:-440px; z-index:30;}
.process .btnClick img {position:absolute; top:0; left:0;}
.process .txtClick {position:absolute; left:50%; top:350px; margin-left:-324px; z-index:40;}
.process .price {position:absolute; left:50%; bottom:73px; margin-left:-419px;}
.process .price strong {position:absolute; right:140px; top:50px; font:bold 36px/30px arial; color:#fffb88;}
.process .price .btnTip {display:block; position:absolute; right:50px; top:43px; z-index:30;}
.process .price .txt {display:block; position:absolute; right:32px; top:92px; z-index:40; margin-top:-10px; opacity:0; transition:all .3s;}
.process .price .txt.open {margin-top:0; opacity:1;}

.friendsWish {background:url(http://webimage.10x10.co.kr/eventIMG/2017/79963/bg_dot_pattern.jpg) 50% 0 repeat-x;}
.friendsWish .inner{padding:130px 0 120px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79963/bg_pink.jpg) 50% 0 no-repeat;}
.friendsWish .wishView {width:1100px; margin:0 auto 45px; }
.friendsWish .wishView .viewCont {width:978px; height:1213px; padding:58px 60px 0;}
.friendsWish .wishView dl {border-bottom:solid 1px #f9a1d3;}
.friendsWish .wishView dl:first-child + dl + dl + dl{border:none;}
.friendsWish .wishView dt {height:16px; padding-left:36px; margin-top:60px; line-height:16px; text-align:left; color:#181a48; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79963/ico_heart.png) 9px 0 no-repeat;}
.friendsWish .wishView dd {padding:37px 0;}
.friendsWish .wishView ul {overflow:hidden;}
.friendsWish .wishView li {float:left; width:150px; padding:0 26px;}
.friendsWish .wishView li:first-child {padding-left:10px;}
.friendsWish .wishView li:first-child + li + li + li + li {padding-right:10px;}
.friendsWish .wishView li img {width:150px; height:150px; border-radius:50%; border:solid 1px #e5e5e5;}
.friendsWish .pageMove {display:none;}

.evt79963 .paging {height:30px; padding:5px 0; margin-top:25px;}
.evt79963 .paging a{width:29px; height:30px; background-color:transparent; border:none;}
.evt79963 .paging a.current:hover {background-color:transparent; }
.evt79963 .paging a span {width:100%; height:100%; color:#fff; padding:4px 0 0;}
.evt79963 .paging a.current span {color:#000;}
.evt79963 .paging a.arrow {width:30px;}
.evt79963 .paging a.arrow span {width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79963/btn_nav.png) no-repeat 0 0;}
.evt79963 .paging a.prev span {background-position:-33px 0;}
.evt79963 .paging a.next {margin-left:5px;}
.evt79963 .paging a.next span {background-position:-66px 0;}
.evt79963 .paging a.end span {background-position:100% 0;}

.evtNoti {padding:48px 0; background:#393939;}
.evtNoti div {position:relative; width:840px; margin:0 auto; text-align:left;}
.evtNoti h3 {position:absolute; left:0; top:50%; width:210px; margin-top:-46px;}
.evtNoti ul {width:560px; padding-left:280px; font-size:11px; line-height:16px; color:#fff;}
.evtNoti li {padding:0 0 9px 18px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79963/blt_dot.png) 0 6px no-repeat;}
.bounce {animation-name:bounce; animation-iteration-count:50; animation-duration:1s; -webkit-animation-name:bounce; -webkit-animation-iteration-count:50; -webkit-animation-duration:1s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:linear;}
	50% {margin-top:10px; animation-timing-function:linear;}
}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:linear;}
	50% {margin-top:10px; -webkit-animation-timing-function:linear;}
}
</style>
<script>
$(function(){
	titleAnimation()
	$(".heartHead h2").css({"top":"-20px", "opacity":"0"});
	function titleAnimation() {
		$(".heartHead h2").delay(100).animate({"top":"5px", "opacity":"1"},400).animate({"top":"0"},300);
	}
});

function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}

function jsSubmit()
{
	<% If IsUserLoginOK() Then %>
		<% If Now() > #09/03/2019 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If Now() > #08/24/2017 00:00:00# and Now() < #09/03/2019 23:59:59# Then '#02/10/2016 10:00:00# %>
				var frm = document.frm;
				frm.action="/event/etc/wishlist/wishfolderProc.asp";
				frm.hidM.value='I';
				frm.submit();
			<% Else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% End If %>
		<% End If %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End If %>
}

</script>
<%
Dim sp, spitemid, spimg
Dim arrCnt, foldername
foldername = "하트시그널"
Dim strSql, vCount, vFolderName, vViewIsUsing
vCount = 0

strSql = "Select COUNT(fidx) From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "' "
rsget.Open strSql,dbget,1
IF Not rsget.Eof Then
	vCount = rsget(0)
Else
	vCount = 0
END IF
rsget.Close
%>
						<form name="frm" method="post">
						<input type="hidden" name="hidM" value="I">
						<input type="hidden" name="foldername" value="<%=foldername%>">
						<input type="hidden" name="eventid" value="<%=eCode%>">
						<input type="hidden" name="returnurl" value="<%=vreturnurl%>">
						<div class="evt79963">
							<div class="heartSignal">
								<div class="heartHead">
									<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/tit_heart_signal.png" alt="" /></h2>
									<p class="line"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/img_deco_line.png" alt="" /></p>
									<p class="gift"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/txt_gift.png" alt="상품페이지에 있는 하트를 눌러 위시리스트를 채워주세요! 추첨을 통해 10분께 기프트카드 5만원 권을 드립니다" /></p>
									<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/txt_date.png" alt="이벤트 기간 : 8.28 ~ 9.3   당첨자 발표 : 9.4 (월)" /></p>
								</div>
								<div class="heartDeco">
									<span class="heartS ht1"></span>
									<span class="heartL ht2"></span>
									<span class="heartL ht3"></span>
									<span class="heartS ht4"></span>
									<span class="heartS ht5"></span>
									<span class="heartS ht6"></span>
									<span class="heartS ht7"></span>
									<span class="heartL ht8"></span>
									<span class="heartS ht9"></span>
									<span class="heartL ht10"></span>
									<span class="heartS ht11"></span>
								</div>
								<div class="wave"></div>
								<div class="process">
									<h3 style="display:none;">이벤트 참여방법</h3>
										<% If vCount > 0 Then%>
										<button type="button" class="btnClick" onclick="location.href='/my10x10/mywishlist.asp'; return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/btn_go_wish_prd.png" alt="" /></button>
										<% Else %>
										<button type="button" class="btnClick" onclick="jsSubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/btn_submit.png" alt="" /></button>
										<% End If %>
									<p class="txtClick bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/txt_click.png" alt="클릭" /></p>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/txt_process.png" alt="1.위 버튼 클릭하고 [하트시그널] 폴3더 만들기 2.원하는 상품의 하트 아이콘 클릭 3.총 5개 이상의 상품을 [하트시그널] 폴더에 담기 ※ 기본 폴더명을 수정하거나 수동으로 만드는 폴더는 응모대상에서 제외 됩니다." /></p>
								</div>
							</div>

							<% If ifr.FResultCount > 0 Then %>
							<div class="friendsWish">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/tit_freinds_wish.png" alt="다른 친구들의 하트 시그널" /></h3>
									<div class="wishView">
										<div class="viewCont">
											<% For i = 0 to ifr.FResultCount -1 %>
											<dl>
												<dt><strong><%=printUserId(ifr.FList(i).FUserid,2,"*")%></strong>님의 하트</dt>
												<dd>
													<ul>
														<%
															arrCnt=0
															if ifr.FList(i).FArrIcon2Img<>"" and not(isnull(ifr.FList(i).FArrIcon2Img)) then
																if isarray(Split(ifr.FList(i).FArrIcon2Img,",")) then
																	arrCnt = Ubound(Split(ifr.FList(i).FArrIcon2Img,","))
																end if
															end if

															If ifr.FList(i).FCnt > 4 Then
																arrCnt = 5
															Else
																arrCnt = ifr.FList(i).FCnt
															End IF

															For y = 0 to CInt(arrCnt) - 1
																if ifr.FList(i).FArrIcon2Img<>"" and not(isnull(ifr.FList(i).FArrIcon2Img)) then
																	if isarray(Split(ifr.FList(i).FArrIcon2Img,",")) then
																		sp = Split(ifr.FList(i).FArrIcon2Img,",")(y)

																		if isarray(Split(sp,"|")) then
																			spitemid = Split(sp,"|")(0)
																			spimg	 = Split(sp,"|")(1)
																		end if
																	end if
																end if
														%>
														<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" alt="" /></a></li>
															<%	Next %>
													</ul>
												</dd>
											</dl>
											<% Next %>
										</div>
									</div>
									<div class="pageWrapV15">
										<%= fnDisplayPaging_New(page,ifr.FTotalCount,4,10,"jsGoPage") %>
									</div>
								</div>
							</div>
							<% End If %>
							<div class="evtNoti">
								<div>
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79963/tit_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>본 이벤트에 ‘참여하기’를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
										<li>‘참여하기’ 클릭 시, [하트시그널] 위시리스트 폴더가 자동 생성됩니다.</li>
										<li>수동으로 위시리스트를 생성하거나 기존에 있던 폴더를 사용하는 경우 이벤트 참여가 불가합니다.</li>
										<li>[하트시그널] 폴더는 ID당 1개만 생성 가능합니다.</li>
										<li>해당 폴더에 5개 이상의 상품을 추가해야 응모가 완료됩니다.</li>
										<li>해당 폴더 외에 다른 폴더에 담긴 상품은 이벤트 응모와는 무관합니다.</li>
										<li>본 이벤트는 9월 3일 23시59분59초까지 담겨져 있는 상품을 기준으로 선정합니다.</li>
										<li>당첨자는 9월 4일 월요일 공지사항을 통해 발표될 예정입니다.</li>
									</ul>
								</div>
							</div>
						</div>
						</form>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
	<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="page" value="">
</form>
<% Set ifr = nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->