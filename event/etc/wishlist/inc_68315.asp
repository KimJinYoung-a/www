<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  아임 유어 텐바이텐
' History : 2015.12.24 한용민 생성
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

<%
dim eCode, userid, ifr, page, i, y, currenttime
	page = getNumeric(requestcheckvar(request("page"),10))

If page = "" Then page = 1

IF application("Svr_Info") = "Dev" THEN
	eCode   =  "65994"
Else
	eCode   =  "68315"
End If

userid = GetEncLoginUserID()

currenttime = now()
'currenttime = #12/28/2015 10:05:00#

Dim ename, emimg, cEvent, blnitempriceyn
set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN
set cEvent = nothing

set ifr = new evt_wishfolder
	ifr.FPageSize = 4
	ifr.FCurrPage = page
	ifr.FeCode = eCode
	ifr.Frectuserid = userid
	'ifr.evt_wishfolder_list		'메인디비
	ifr.evt_wishfolder_list_B	'캐쉬디비
	
Dim sp, spitemid, spimg
Dim arrCnt, foldername
foldername = "2016 소원수리"
Dim strSql, vCount, vFolderName, vViewIsUsing
vCount = 0

if userid<>"" then
	strSql = "Select COUNT(fidx) From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "' "
	'response.write strSql
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		vCount = rsget(0)
	else
		vCount = 0
	END IF
	rsget.Close
end if
%>

<!-- #include virtual="/lib/inc/head.asp" -->

<style type="text/css">
img {vertical-align:top;}
.navigator {position:fixed; top:38%; right:120px; z-index:100;}
.navigator ul li {position:relative; width:53px; height:52px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/btn_nav.png); background-repeat:no-repeat; background-position:0 0;}
.navigator ul li a {display:block; width:100%; height:100%; text-indent:-9999px;}
.navigator ul li.current {background-position:0 100%;}

.imyourCont {position:relative; width:1140px; margin:0 auto;}
.deco {position:absolute;}

.section01 {padding:135px 0 0; background-color:#fef9db;}
.section01 .title {position:relative; width:661px; height:127px; margin:0 auto;}
.section01 .title .copy {position:absolute; left:50%; top:0; margin-left:-210px;}
.section01 .title h2 {position:absolute; left:0; bottom:0; width:100%; height:76px;}
.section01 .title h2 span {display:block; position:absolute; top:0; height:76px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/tit_your_tenten.png); background-repeat:no-repeat; text-indent:-9999px;}
.section01 .title h2 span.t01 {left:0; width:145px; background-position:0 0;}
.section01 .title h2 span.t02 {left:178px; width:145px; background-position:-178px 0;}
.section01 .title h2 span.t03 {left:358px; width:303px; background-position:100% 0;}
.section01 .title .deco {left:-112px; top:54px;}
.section01 ol {width:1185px; margin-left:45px; padding-bottom:67px;}
.section01 ol:after {visibility:hidden; display:block; clear:both; height:0; content:'';}
.section01 li {float:left;}
.section01 li.step01 {position:relative; width:418px; height:383px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_step_01.png) 0 0 no-repeat;}
.section01 li.step01 a {display:block; position:absolute; left:50%; top:0; padding-top:72px; margin-left:-137px;}
.section01 li.step01 .click {position:absolute; left:50%; top:0; margin-left:-34px;}
.section01 li.step02, .section01 li.step03 {padding-top:72px;}
.section01 .process {padding:95px 0 32px;}
.section01 .process .overHidden {padding:0 185px;}
.section01 .eventTip {background-color:#fff7c5;}
.section01 .eventTip .overHidden {padding:48px 60px 55px 78px;}
.section01 .eventTip .deco {left:-63px; top:-98px; width:133px; height:175px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/bg_banana.png) 100% 100% no-repeat;}
.section02 {background-color:#fde36b;}
.section02 h3 {padding:50px 0 75px;}
.section02 ul {position:relative; width:1112px; height:401px;}
.section02 li {position:absolute; top:0;}
.section02 li.card01 {left:0; z-index:40;}
.section02 li.card02 {left:281px; z-index:30;}
.section02 li.card03 {left:562px; z-index:20;}
.section02 li.card04 {left:843px; z-index:10;}
.section02 .overHidden {padding:70px 0 85px;}
.section03 {background-color:#f48356;}
.section03 h3 {padding:50px 0 52px;}
.section03 ul {position:relative; width:1105px; height:397px; margin:0 auto;}
.section03 li {position:absolute; top:0;}
.section03 li.pic01 {left:0;}
.section03 li.pic02 {left:281px;}
.section03 li.pic03 {left:562px;}
.section03 li.pic04 {left:843px;}
.section03 .overHidden {padding:42px 18px 45px;}
.section04 {padding-bottom:60px; background-color:#fef9db;}
.section04 h3 {padding:87px 0 58px;}
.section04 .friendsWish {position:relative; z-index:100; width:1060px; min-height:450px; padding:55px 41px 24px; margin-bottom:40px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/bg_box.png) 0 100% no-repeat;}
.section04 .friendsWish dl {padding-bottom:65px;}
.section04 .friendsWish dt {height:35px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/ico_cart.png) 0 0 no-repeat;}
.section04 .friendsWish dt span {display:inline-block; line-height:22px; padding:0 0 0 74px; color:#2b2b2b; font-size:12px;}
.section04 .friendsWish ul {overflow:hidden; padding:35px 0 0 50px;}
.section04 .friendsWish li {float:left; padding:0 26px;}
.section04 .friendsWish li img {width:150px; height:150px;}
.section04 .pageMove {display:none;}
.section04 .pageWrapV15 {display:inline-block; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/bg_pagination.png) 100% 0 no-repeat;}
.section04 .paging {display:inline-block; width:auto; height:35px; padding:5px 9px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/bg_pagination_lt.png) 0 0 no-repeat;}
.section04 .paging a {width:29px; height:29px; line-height:28px; border:0; background:none;}
.section04 .paging a.current:hover {background:none;}
.section04 .paging a span {color:#b58d5a;}
.section04 .paging a.current span {color:#a92508;}
.section04 .paging a.arrow span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/btn_pagination.png); width:29px; height:29px; padding:0;}
.section04 .paging a.first span {background-position:0 0;}
.section04 .paging a.prev span {background-position:-29px 0;}
.section04 .paging a.next span {background-position:-58px 0;}
.section04 .paging a.end span {background-position:100% 0;}
.section04 .monkey03 {right:-162px; top:50px; z-index:10;}
.section04 .monkey04 {left:-134px; bottom:10%; z-index:10;}
.section05 {margin-bottom:-80px; text-align:left; background-color:#efefef;}
.section05 .evtNoti {overflow:hidden; padding:40px 90px 30px;}
.section05 .evtNoti h3 {float:left; width:207px; padding-top:50px;}
.section05 .evtNoti ul {float:left;}
.section05 .evtNoti li {font-size:11px; line-height:12px; padding:0 0 12px 15px; color:#8e8e8e; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68315/blt_round.png) 0 1px no-repeat;}

/* anamation */
.section01 .title .deco {-webkit-animation: swinging 4s ease-in-out 3s 8; -moz-animation: swinging 4s ease-in-out 3s 8;  -ms-animation: swinging 4s ease-in-out 3s 8;}
@-webkit-keyframes swinging {
	0% { -webkit-transform: rotate(0);}
	15% { -webkit-transform: translate(-5px,0px) rotate(5deg); }
	50% { -webkit-transform: translate(8px,5px) rotate(-10deg); }
	100% { -webkit-transform: rotate(0);}
}
@-moz-keyframes swinging {
	0% { -moz-transform: rotate(0); }
	15% { -moz-transform: translate(-5px,0px) rotate(5deg); }
	50% { -moz-transform: translate(8px,5px) rotate(-10deg); }
	100% { -moz-transform: rotate(0); }
}
@-ms-keyframes swinging {
	0% { -ms-transform: rotate(0); }
	15% { -ms-transform: translate(-5px,0px) rotate(5deg); }
	50% { -ms-transform: translate(8px,5px) rotate(-10deg); }
	100% { -ms-transform: rotate(0); }
}

</style>
<script type="text/javascript">

function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}

<% if page>1 then %>
	//$(function(){
	//    var val = $('#friendsWish').offset();
	//    $('html,body').animate({scrollTop:val.top},100);
	//});
	//setTimeout("$('html,body',document).scrollTop(1400);", 200);
<% end if %>

function jsSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-12-28" and left(currenttime,10)<"2016-01-04" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% 'if Hour(currenttime) < 10 then %>
				//alert("오전 10시부터 이벤트가 진행 됩니다.");
				//return;
			<% 'else %>
				var frm = document.frm;
				frm.action="/event/etc/wishlist/wishfolderProc.asp";
				frm.hidM.value='I';
				frm.submit();
			<% 'end if %>
		<% end if %>
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% end if %>
}

</script>

<form name="frm" method="post" style="margin:0px;">
<input type="hidden" name="hidM" value="I">
<input type="hidden" name="foldername" value="<%=foldername%>">
<input type="hidden" name="eventid" value="<%=eCode%>">
<!-- 아임 유어 텐바이텐 -->
<div class="evt68315">
	<div id="nav" class="navigator">
		<ul>
			<li><a href="#section01" class="current">01.소원수리 대작전</a></li>
			<li><a href="#section02">02.아임 유어 바나나</a></li>
			<li><a href="#section03">03.새 마음 새 옷으로</a></li>
			<li><a href="#section04">지금 텐바이텐 고객들이 좋아하는 상품 미리보기</a></li>
		</ul>
	</div>
	<div class="imYourBanana">

		<% '<!-- 1 --> %>
		<div id="section01" class="section section01">
			<div class="title">
				<p class="copy"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_copy.png" alt="2016년에도 당신 곁에는 우리가!" /></p>
				<h2>
					<span class="t01">아임</span>
					<span class="t02">유어</span>
					<span class="t03">텐바이텐</span>
				</h2>
				<div class="deco monkey01"><div><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_monkey_01.png" alt="원숭이" /></div></div>
			</div>
			<div class="imyourCont process">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/tit_wish_01.png" alt="01.소원수리 대작전 - 2016년에 꼭 갖고싶은 상품을 위시리스트 속에 듬뿍 담아 보세요. 참여해주신 30분에게 Gift카드 5만원권을 선물로 드립니다.(당첨자발표 2016년1월7일)" /></h3>
				<ol>
					<li class="step01">
						<a href="" onclick="jsSubmit(); return false;">
							<span class="click"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_click.gif" alt="CLICK" /></span>
							<span class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/btn_apply.png" alt="2016 소원수리" /></span>
						</a>
					</li>
					<li class="step02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_step_02.png" alt="원하는 상품 상세 페이지에서 위시리스트에 담기" /></li>
					<li class="step03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_step_03.png" alt="[2016 소원수리] 폴더에 상품을 가득가득 담기" /></li>
				</ol>
				<div class="overHidden">
					<div class="ftLt tPad15"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_caution.png" alt="기본 폴더명을 수정하거나 수동으로 만드는 폴더는 응모대상에서 제외 됩니다." /></div>
					<div class="ftRt"><a href="#section04" class="goOthers"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/btn_others.png" alt="다른 소원 수리 살펴보기" /></a></div>
				</div>
			</div>

			<%
			'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
			Dim vTitle, vLink, vPre, vImg
			
			dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
			snpTitle = Server.URLEncode("[텐바이텐]"&foldername&"")
			snpLink = Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
			snpPre = Server.URLEncode("10x10 이벤트")
		
			'기본 태그
			snpTag = Server.URLEncode("텐바이텐 " & Replace(foldername," ",""))
			snpTag2 = Server.URLEncode("#10x10")
			%>
			<div class="eventTip">
				<div class="imyourCont">
					<div class="overHidden">
						<div class="ftLt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_tip.png" alt="당첨 확률을 높여요!" /></div>
						<div class="ftRt tMar10">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_share.png" alt="친구들에게 소식 전해주기" usemap="#shareMap" />
							<map name="shareMap" id="shareMap">
								<area shape="circle" coords="298,46,27" href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','',''); return false;" alt="페이스북" />
								<area shape="circle" coords="362,45,27" href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;" alt="트위터" />
							</map>
						</div>
					</div>
					<div class="deco monkey02"><div><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_monkey_02.png" alt="원숭이" /></div></div>
				</div>
			</div>
		</div>

		<% '<!-- 2 --> %>
		<div id="section02" class="section section02">
			<div class="imyourCont">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/tit_wish_02.png" alt="02.아임 유어 바나나 - 가장 가까운 가족과 친구들에게 꼭 새해 인사를 전해보세요. 당신처럼 귀여운 원숭이 엽서 세트를 함께 보내드립니다." /></h3>
				<ul>
					<li class="card01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_postcard_01.jpg" alt="엽서 이미지" /></li>
					<li class="card02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_postcard_02.jpg" alt="엽서 이미지" /></li>
					<li class="card03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_postcard_03.jpg" alt="엽서 이미지" /></li>
					<li class="card04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_postcard_04.jpg" alt="엽서 이미지" /></li>
				</ul>
				<div class="overHidden">
					<div class="ftLt tPad15"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_get.png" alt="받는 방법 : 12월 28일(월) 부터 텐바이텐 배송 상품을 포함해서 쇼핑하신 모든 분에게! (단, 한정수량으로 조기조진 될 수 있습니다.)" /></div>
					<div class="ftRt"><a href="/event/eventmain.asp?eventid=66572" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/btn_ten_delivery.png" alt="텐바이텐 배송상품 보러가기" /></a></div>
				</div>
			</div>
		</div>

		<% '<!-- 3 --> %>
		<div id="section03" class="section section03">
			<div class="imyourCont">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/tit_wish_03.png" alt="03.새 마음 새 옷으로 - 2016년 새 출발하는 당신에게 모바일 화면을 선물합니다. 단, 모바일에서 다운로드 받으세요!" /></h3>
				<ul>
					<li class="pic01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_mobile_01.png" alt="모바일 배경화면1" /></li>
					<li class="pic02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_mobile_02.png" alt="모바일 배경화면2" /></li>
					<li class="pic03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_mobile_03.png" alt="모바일 배경화면3" /></li>
					<li class="pic04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_mobile_04.png" alt="모바일 배경화면4" /></li>
				</ul>
				<div class="overHidden">
					<div class="ftLt tMar50"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/txt_download.png" alt="받는 방법 : 12월 28일 (월) 부터 텐바이텐 배송 상품을 포함해서 쇼핑하신 모든 분에게! ( 단, 한정수량으로 조기소진 될 수 있습니다.)" /></div>
					<div class="ftRt">
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_go_event.png" alt="이벤트 바로가기" /></span>
						<span class="lPad25"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_app_down.png" alt="텐바이텐 APP 다운" /></span>
					</div>
				</div>
			</div>
		</div>
		
		<% If ifr.FResultCount > 0 Then %>
			<% '<!-- 4 --> %>
			<div id="section04" class="section section04">
				<div class="imyourCont">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/tit_preview.png" alt="지금 텐바이텐 고객들이 좋아하는 상품 미리보기" /></h3>
					<div class="friendsWish">
						<div class="deco monkey03"><div><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_monkey_03.png" alt="원숭이" /></div></div>
						<div class="deco monkey04"><div><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/img_monkey_04.png" alt="원숭이" /></div></div>
						
						<% '<!-- 고객 위시 4개씩 노출 --> %>
						<% For i = 0 to ifr.FResultCount -1 %>
						<dl>
							<dt><span><strong><%=printUserId(ifr.FList(i).FUserid,2,"*")%></strong> 님의 위시리스트</span></dt>
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
									<li>
										<a href="" onClick="jsViewItem('<%=spitemid%>'); return false;">
										<img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" /></a>
									</li>
									<% next %>
								</ul>
							</dd>
						</dl>
						<% next %>
					</div>

					<% '<!-- pagination --> %>
					<div class="pageWrapV15 tMar10">
						<%= fnDisplayPaging_New(page,ifr.FTotalCount,4,10,"jsGoPage") %>
					</div>
				</div>
			</div>
		<% end if %>

		<% '<!-- 5 --> %>
		<div class="section section05">
			<div class="imyourCont">
				<div class="evtNoti">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68315/tit_noti.png" alt="이벤트 유의사항" /></h3>
					<ul>
						<li>본 이벤트에서 참여하기를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
						<li>참여하기 클릭 시, 위시리스트에 &lt;2016 소원수리&gt; 폴더가 자동 생성됩니다.</li>
						<li>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다.</li>
						<li>위시리스트에 &lt;2016 소원수리&gt; 폴더는 한 ID당 1개만 생성이 가능합니다.</li>
						<li>해당 폴더에 다양한 카테고리로 10개 이상의 상품, 총 금액이 50만원 이상이 되도록 넣어주세요.</li>
						<li>해당 폴더 외에 다른 폴더에 담으시는 상품은 이벤트 응모와는 무관 합니다.</li>
						<li>본 이벤트는 2016년 1월 3일 23시59분59초까지 담겨진 상품을 기준으로 선정합니다.</li>
						<li>위시리스트 속 상품은 최근 5개만 보여집니다.</li>
						<li>당첨자 안내는 2016년 1월 7일에 공지사항을 통해 진행됩니다.</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- // 아임 유어 텐바이텐 -->
</form>
<form name="pageFrm" method="get" action="<%=CurrURL()%>" style="margin:0px;">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="page" value="">
</form>

<script type="text/javascript">
/*
 * jQuery One Page Nav Plugin
 * http://github.com/davist11/jQuery-One-Page-Nav
 *
 * Copyright (c) 2010 Trevor Davis (http://trevordavis.net)
 * Dual licensed under the MIT and GPL licenses.
 * Uses the same license as jQuery, see:
 * http://jquery.org/license
 *
 * @version 3.0.0
 *
 * Example usage:
 * $('#nav').onePageNav({
 *   currentClass: 'current',
 *   changeHash: false,
 *   scrollSpeed: 750
 * });
 */

;(function($, window, document, undefined){
	// our plugin constructor
	var OnePageNav = function(elem, options){
		this.elem = elem;
		this.$elem = $(elem);
		this.options = options;
		this.metadata = this.$elem.data('plugin-options');
		this.$win = $(window);
		this.sections = {};
		this.didScroll = false;
		this.$doc = $(document);
		this.docHeight = this.$doc.height();
	};

	// the plugin prototype
	OnePageNav.prototype = {
		defaults: {
			navItems: 'a',
			currentClass: 'current',
			changeHash: false,
			easing: 'swing',
			filter: '',
			scrollSpeed: 750,
			scrollThreshold: 0.5,
			begin: false,
			end: false,
			scrollChange: false
		},
		init: function() {
			// Introduce defaults that can be extended either
			// globally or using an object literal.
			this.config = $.extend({}, this.defaults, this.options, this.metadata);

			this.$nav = this.$elem.find(this.config.navItems);

			//Filter any links out of the nav
			if(this.config.filter !== '') {
				this.$nav = this.$nav.filter(this.config.filter);
			}

			//Handle clicks on the nav
			this.$nav.on('click.onePageNav', $.proxy(this.handleClick, this));

			//Get the section positions
			this.getPositions();

			//Handle scroll changes
			this.bindInterval();

			//Update the positions on resize too
			this.$win.on('resize.onePageNav', $.proxy(this.getPositions, this));
			return this;
		},

		adjustNav: function(self, $parent) {
			self.$elem.find('.' + self.config.currentClass).removeClass(self.config.currentClass);
			$parent.addClass(self.config.currentClass);
		},

		bindInterval: function() {
			var self = this;
			var docHeight;

			self.$win.on('scroll.onePageNav', function() {
				self.didScroll = true;
			});

			self.t = setInterval(function() {
				docHeight = self.$doc.height();

				//If it was scrolled
				if(self.didScroll) {
					self.didScroll = false;
					self.scrollChange();
				}

				//If the document height changes
				if(docHeight !== self.docHeight) {
					self.docHeight = docHeight;
					self.getPositions();
				}
			}, 250);
		},

		getHash: function($link) {
			return $link.attr('href').split('#')[1];
		},

		getPositions: function() {
			var self = this;
			var linkHref;
			var topPos;
			var $target;

			self.$nav.each(function() {
				linkHref = self.getHash($(this));
				$target = $('#' + linkHref);

				if($target.length) {
					topPos = $target.offset().top;
					self.sections[linkHref] = Math.round(topPos);
				}
			});
		},

		getSection: function(windowPos) {
			var returnValue = null;
			var windowHeight = Math.round(this.$win.height() * this.config.scrollThreshold);

			for(var section in this.sections) {
				if((this.sections[section] - windowHeight) < windowPos) {
					returnValue = section;
				}
			}

			return returnValue;
		},

		handleClick: function(e) {
			var self = this;
			var $link = $(e.currentTarget);
			var $parent = $link.parent();
			var newLoc = '#' + self.getHash($link);

			if(!$parent.hasClass(self.config.currentClass)) {
				//Start callback
				if(self.config.begin) {
					self.config.begin();
				}

				//Change the highlighted nav item
				self.adjustNav(self, $parent);

				//Removing the auto-adjust on scroll
				self.unbindInterval();

				//Scroll to the correct position
				self.scrollTo(newLoc, function() {
					//Do we need to change the hash?
					if(self.config.changeHash) {
						window.location.hash = newLoc;
					}

					//Add the auto-adjust on scroll back in
					self.bindInterval();

					//End callback
					if(self.config.end) {
						self.config.end();
					}
				});
			}

			e.preventDefault();
		},

		scrollChange: function() {
			var windowTop = this.$win.scrollTop();
			var position = this.getSection(windowTop);
			var $parent;

			//If the position is set
			if(position !== null) {
				$parent = this.$elem.find('a[href$="#' + position + '"]').parent();

				//If it's not already the current section
				if(!$parent.hasClass(this.config.currentClass)) {
					//Change the highlighted nav item
					this.adjustNav(this, $parent);

					//If there is a scrollChange callback
					if(this.config.scrollChange) {
						this.config.scrollChange($parent);
					}
				}
			}
		},

		scrollTo: function(target, callback) {
			var offset = $(target).offset().top;

			$('html, body').animate({
				scrollTop: offset
			}, this.config.scrollSpeed, this.config.easing, callback);
		},

		unbindInterval: function() {
			clearInterval(this.t);
			this.$win.unbind('scroll.onePageNav');
		}
	};

	OnePageNav.defaults = OnePageNav.prototype.defaults;

	$.fn.onePageNav = function(options) {
		return this.each(function() {
			new OnePageNav(this, options).init();
		});
	};

})( jQuery, window , document );

$(document).ready(function() {
	$('#nav').onePageNav();
});

$(function(){
	$(".goOthers").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});

	$(".section01 .copy").css({"margin-top":"5px", "opacity":"0"});
	$(".section01 h2 span").css({"opacity":"0"});
	$(".section01 h2 span.t01").css({"margin-left":"-20px"});
	$(".section01 h2 span.t02").css({"margin-top":"20px"});
	$(".section01 h2 span.t03").css({"margin-left":"20px"});
	$(".section01 .monkey01").css({"opacity":"0"});
	function intro() {
		$(".section01 .copy").animate({"margin-top":"0", "opacity":"1"},600);
		$(".section01 h2 span.t01").delay(600).animate({"margin-left":"0", "opacity":"1"},800);
		$(".section01 h2 span.t02").delay(1000).animate({"margin-top":"0", "opacity":"1"},800);
		$(".section01 h2 span.t03").delay(1400).animate({"margin-left":"0", "opacity":"1"},800);
		$(".section01 .monkey01").delay(1100).animate({"opacity":"1"},500);
	}
	intro();

	$(".section02 li").css({"left":"0", "margin-top":"-20px", "opacity":"0"});
	function animation1() {
		$(".section02 li").animate({"margin-top":"0", "opacity":"1"},600);
		$(".section02 li.card02").animate({"left":"281px"},700);
		$(".section02 li.card03").animate({"left":"562px"},700);
		$(".section02 li.card04").animate({"left":"843px"},700);
	}

	$(".section03 li").css({"left":"50%", "margin-left":"-131px", "margin-top":"-20px", "opacity":"0"});
	function animation2() {
		$(".section03 li").animate({"margin-top":"0", "opacity":"1"},600);
		$(".section03 li.pic01").animate({"margin-left":"0", "left":"0"},700);
		$(".section03 li.pic02").animate({"margin-left":"0", "left":"281px"},700);
		$(".section03 li.pic03").animate({"margin-left":"0", "left":"562px"},700);
		$(".section03 li.pic04").animate({"margin-left":"0", "left":"843px"},700);
	}

	function moveMonkey () {
		$(".monkey02 div").animate({"margin-left":"0"},1000).animate({"margin-left":"10px"},1000, moveMonkey);
	}
	moveMonkey();

	moveBtn();
	function moveBtn() {
		$(".section01 li.step01 a").effect( "bounce", {times:3}, 800);
	}
	setInterval(function() {
		moveBtn();
	},3000);

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1500 ) {
			animation1();
		}
		if (scrollTop > 2420 ) {
			animation2();
		}
		if (scrollTop > 3520 ) {
			$(".monkey03").animate({"top":"260px"},1500);
		}
		if (scrollTop > 3900 ) {
			$(".monkey04").animate({"bottom":"10px"},1500);
		}
	});
});

</script>

<!-- #include virtual="/lib/db/dbclose.asp" -->
