<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시리스트 - 또! 담아영
' History : 2016-05-26 유태욱 생성
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
Dim currenttime, systemok
Dim subscriptcount1, subscriptcount2, subscriptcount3
Dim totalcnt1, totalcnt2, totalcnt3
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "66139"
Else
	eCode   =  "70923"
End If

currenttime = now()
'															currenttime = #05/20/2016 10:05:00#

Dim ename, emimg, cEvent, blnitempriceyn, vreturnurl
vreturnurl = Request.ServerVariables("url") &"?"&Request.ServerVariables("QUERY_STRING")

Set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN	
Set cEvent = nothing
userid = GetEncLoginUserID()

Dim ifr, page, i, y
page = request("page")

If page = "" Then page = 1

Set ifr = new evt_wishfolder
	ifr.FPageSize	= 4
	ifr.FCurrPage	= page
	ifr.FeCode	= eCode
	ifr.Frectuserid = userid
'	ifr.evt_wishfolder_list		'메인디비
	ifr.evt_wishfolder_list_B	'캐쉬디비

	Dim totcash : totcash = 0 '//합계금액
	if userid <> "" then
		If ifr.FmyTotalCount > 0 then 
			For y = 0 to cint(ifr.FmyTotalCount) - 1
				sp = Split(ifr.Fmylist,",")(y)
				totcash  = totcash + Split(sp,"|")(2)
			Next
		End If 
	end if

Dim sp, spitemid, spimg
Dim arrCnt, foldername

foldername = "또! 담아영"

subscriptcount1=0
subscriptcount2=0
subscriptcount3=0
'//본인 참여 여부
if userid<>"" then
	subscriptcount1 = getevent_subscriptexistscount(eCode, userid, "1", "", "")
	subscriptcount2 = getevent_subscriptexistscount(eCode, userid, "2", "", "")
	subscriptcount3 = getevent_subscriptexistscount(eCode, userid, "3", "", "")
end if

totalcnt1 = getevent_subscripttotalcount(eCode, "1", "", "")
totalcnt2 = getevent_subscripttotalcount(eCode, "2", "", "")
totalcnt3 = getevent_subscripttotalcount(eCode, "3", "", "")

''응모 차단시 X로 변경
	'systemok="X"
	systemok="O"

if left(currenttime,10)<"2016-05-30" then
	systemok="X"
	if userid = "baboytw" or userid = "greenteenz" or userid = "cogusdk" then
		systemok="O"
	end if
end if

%>
<style type="text/css">
img {vertical-align:top;}
.evt70923 {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2016/70923/bg_body.png) 0 0 repeat-x;}
.putAgain {position:relative; height:929px; padding-top:450px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70923/bg_cont.png) 50% 0 no-repeat;}
.putAgain h2 {position:absolute; left:50%; top:102px; margin-left:-219px;}
.process {position:relative; width:1064px; margin:0 auto;}
.process .btnClick {position:absolute; left:134px; top:251px; z-index:30;}
.process .txtClick {position:absolute; left:133px; top:215px; z-index:40;}
.process .price {position:absolute; left:50%; bottom:73px; margin-left:-419px;}
.process .price strong {position:absolute; right:140px; top:50px; font:bold 36px/30px arial; color:#fffb88;}
.process .price .btnTip {display:block; position:absolute; right:50px; top:43px; z-index:30;}
.process .price .txt {display:block; position:absolute; right:32px; top:92px; z-index:40; margin-top:-10px; opacity:0; transition:all .3s;}
.process .price .txt.open {margin-top:0; opacity:1;}
.applyEvent h3 {padding:75px 0 60px;}
.applyEvent ul {overflow:hidden; width:882px; margin:0 auto; padding-bottom:85px;}
.applyEvent li {position:relative; float:left;}
.applyEvent li .num {position:absolute; right:70px; top:80px; z-index:30; width:40px; height:40px; color:#fff; font-weight:bold; font-size:13px; text-align:center; line-height:41px; background:#000; border-radius:50%;}
.applyEvent li .count {position:absolute; left:0; bottom:4px; width:100%; font-size:13px; line-height:14px; text-align:center; color:#888;}
.applyEvent li .count span {display:inline-block; border-bottom:1px solid #999;}
.applyEvent li .count em {color:#f96fa6;}
.applyEvent .goItem {display:block; position:absolute; left:0; top:0; width:100%; height:250px; text-indent:-999em;}
.friendsWish {padding:50px 0 80px; border-top:10px solid #f5d5e9; background:#fae4f2;}
.friendsWish .wishView {width:1142px; margin:0 auto 45px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70923/bg_box_btm.png) 0 100% no-repeat;}
.friendsWish .wishView .viewCont {width:1058px; padding:55px 42px 22px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70923/bg_box_top.png) 0 0 no-repeat;}
.friendsWish .wishView dl {padding-bottom:64px;}
.friendsWish .wishView dt {height:31px; padding-left:75px; line-height:24px; text-align:left; color:#717171; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70923/ico_cart.png) 44px 0 no-repeat;}
.friendsWish .wishView dd {padding-top:40px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70923/bg_double_line.png) 0 0 repeat-x;}
.friendsWish .wishView ul {overflow:hidden; padding:0 24px;}
.friendsWish .wishView li {float:left; width:150px; padding:0 26px;}
.friendsWish .wishView li img {width:150px; height:150px;}
.friendsWish .pageMove {display:none;}
.evtNoti {padding:30px 0; background:#f6f6f6;}
.evtNoti div {position:relative; width:956px; margin:0 auto; text-align:left;}
.evtNoti h3 {position:absolute; left:0; top:50%; width:210px; margin-top:-40px;}
.evtNoti ul {width:740px; padding-left:211px; font-size:11px; line-height:16px; color:#8e8e8e;}
.evtNoti li {padding:0 0 5px 13px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70923/blt_dot.png) 0 4px no-repeat;}
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
<script type="text/javascript">
$(function(){
	$(".btnTip").click(function(){
		$(".price .txt").toggleClass("open");
	});
	titleAnimation()
	$(".putAgain h2").css({"margin-top":"-10px", "opacity":"0"});
	function titleAnimation() {
		$(".putAgain h2").delay(100).animate({"margin-top":"10px", "opacity":"1"},400).animate({"margin-top":"0"},300);
	}
});

function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}

function jsSubmit()
{
	<% If IsUserLoginOK() Then %>
		<% If Now() > #06/05/2016 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If Now() > #05/26/2016 00:00:00# and Now() < #06/05/2016 23:59:59# Then %>
				var frm = document.frm;
				frm.action ="/event/etc/wishlist/wishfolderProc.asp";
				frm.hidM.value ='I';
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

function jsevtgo(gb){
<% if systemok = "O" then %>
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-05-26" and left(currenttime,10)<"2016-06-06" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			if(gb=="1"){
				<% if subscriptcount1 > 0 then %>
					alert('이미 응모 하셨습니다.');
					return;
				<% else %>
					<% if totcash < 100000 then %>
						alert('또! 담아영 폴더에 10만원이상 담아주세요!');
						return;
					<% end if %>
				<% end if %>
			}else if(gb=="2"){
				<% if subscriptcount2 > 0 then %>
					alert('이미 응모 하셨습니다.');
					return;
				<% else %>
					<% if totcash < 500000 then %>
						alert('또! 담아영 폴더에 50만원이상 담아주세요!');
						return;
					<% end if %>
				<% end if %>
			}else if(gb=="3"){
				<% if subscriptcount3 > 0 then %>
					alert('이미 응모 하셨습니다.');
					return;
				<% else %>
					<% if totcash < 1000000 then %>
						alert('또! 담아영 폴더에 100만원이상 담아주세요!');
						return;
					<% end if %>
				<% end if %>
			}
				
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/doeventsubscript/doEventSubscript70923.asp",
				data: "mode=evtgo&gb="+gb,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				var img1 = document.getElementById('img1');
				var img2 = document.getElementById('img2');
				var img3 = document.getElementById('img3');
				if(gb=="1"){
					img1.src = img1.src.replace('_on.gif', '_finish.gif');
				}else if(gb=="2"){
					img2.src = img2.src.replace('_on.gif', '_finish.gif');
				}else if(gb=="3"){
					img3.src = img3.src.replace('_on.gif', '_finish.gif');
				}

				$("#totalcnt1").html(str1[1]);
				$("#totalcnt2").html(str1[2]);
				$("#totalcnt3").html(str1[3]);
				alert('응모가 완료 되었습니다.');
				return false;
			}else if (str1[0] == "01"){
				alert('잘못된 접속입니다.');
				return false;
			}else if (str1[0] == "02"){
				alert('로그인을 해야\n이벤트에 참여할 수 있어요.');
				return false;
			}else if (str1[0] == "03"){
				alert('이벤트 기간이 아닙니다.');
				return false;
			}else if (str1[0] == "04"){
				alert('이미 응모 하셨습니다.');
				return false;
			}else if (str1[0] == "00"){
				alert('정상적인 경로가 아닙니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
<% else %>
	alert('이벤트 기간이 아닙니다.');
	return;
<% end if %>
}

</script>

<form name="frm" method="post">
<input type="hidden" name="hidM" value="I">
<input type="hidden" name="foldername" value="<%=foldername%>">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="returnurl" value="<%=vreturnurl%>">
	<!-- 위시이벤트 - 또! 담아영 -->
	<div class="evt70923">
		<div class="putAgain">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/tit_put_again.png" alt="또! 담아영" /></h2>
			<!-- 위시폴더 만들고 금액 확인 -->
			<div class="process">
				<button type="button" onclick="jsSubmit(); return false;" class="btnClick bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/btn_folder.gif" alt="또 담아영 Click!" /></button>
				<p class="txtClick bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/txt_click.png" alt="" /></p>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/txt_process.png" alt="하트 버튼 클릭하고 폴더 만들기→[또!담아영]폴더에 원하는 상품 담기→담은 금액 확인하고 금액별 사은품 응모하기!" /></p>
				<div class="price">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/txt_price_v2.png" alt="위시담은금액" /></p>
					<strong><%=FormatNumber(totcash,0)%></strong>
					<button type="button" class="btnTip"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/btn_q.png" alt="?" /></button>
					<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/txt_tip.png" alt="위 금액은 서버 과부하로 인해 실시간 적용이 어렵습니다. 5분 뒤에 다시 확인해주세요." /></p>
				</div>
			</div>
		</div>

		<!-- 사은품 응모 -->
		<div class="applyEvent">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/txt_gift.png" alt="담은 금액에 따라 사은품에 응모하세요!" /></h3>
			<ul>
				<li>
					<a href="/shopping/category_prd.asp?itemid=770217&pEtr=70923" class="goItem">인스탁스 미니8 카메라</a>
					<span class="num">5개</span>
					<button type="button" onclick="jsevtgo('1');">
						<% if totcash >= 100000 then %>
							<% if subscriptcount1 > 0 then %>
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/img_camera_finish.gif" alt="" />
							<% else %>
								<img id="img1" src="http://webimage.10x10.co.kr/eventIMG/2016/70923/img_camera_on.gif" alt="" />
							<% end if %>
						<% else %>
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/img_camera_off.gif" alt="" />
						<% end if %>
					</button>
					<p class="count"><span>현재 <em id="totalcnt1"><%= totalcnt1 %></em>명 응모</span></p>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=884069&pEtr=70923" class="goItem">Miffy lamp XL</a>
					<span class="num">2개</span>
					<button type="button" onclick="jsevtgo('2');">
						<% if totcash >= 500000 then %>
							<% if subscriptcount2 > 0 then %>
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/img_lamp_finish.gif" alt="" />
							<% else %>
								<img id="img2" src="http://webimage.10x10.co.kr/eventIMG/2016/70923/img_lamp_on.gif" alt="" />
							<% end if %>
						<% else %>
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/img_lamp_off.gif" alt="" />
						<% end if %>
					</button>
					<p class="count"><span>현재 <em id="totalcnt2"><%= totalcnt2 %></em>명 응모</span></p>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1182604&pEtr=70923" class="goItem">애플 아이패드 에어2 Wi-Fi</a>
					<span class="num">1개</span>
					<button type="button" onclick="jsevtgo('3');">
						<% if totcash >= 1000000 then %>
							<% if subscriptcount3 > 0 then %>
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/img_ipad_finish.gif" alt="" />
							<% else %>
								<img id="img3" src="http://webimage.10x10.co.kr/eventIMG/2016/70923/img_ipad_on.gif" alt="" />
							<% end if %>
						<% else %>
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/img_ipad_off.gif" alt="" />
						<% end if %>
					</button>
					<p class="count"><span>현재 <em id="totalcnt3"><%= totalcnt3 %></em>명 응모</span></p>
				</li>
			</ul>
		</div>


		<!-- 친구들위시 -->
		<% If ifr.FResultCount > 0 Then %>
			<div class="friendsWish">
				<h3 class="bPad10"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/tit_friends_wish.png" alt="이미 손 빠르게 담고있는 친구들" /></h3>
				<div class="wishView">
					<div class="viewCont">
						<% For i = 0 to ifr.FResultCount -1 %>
							<dl>
								<dt><strong><%=printUserId(ifr.FList(i).FUserid,2,"*")%></strong>님의 위시리스트</dt>
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
										<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%= GetImageSubFolderByItemid(spitemid) %>/<%= spimg %>" /></a></li>
									<%	Next %>	
									</ul>
								</dd>
							</dl>
						<% next %>
					</div>
				</div>
				<div class="pageWrapV15 tMar20">
					<%= fnDisplayPaging_New(page,ifr.FTotalCount,4,10,"jsGoPage") %>
				</div>
			</div>
		<% end if %>

		<div class="evtNoti">
			<div>
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70923/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li>본 이벤트는 위시폴더 생성 후 담은 금액에 따라 사은품에 응모할 수 있습니다.</li>
					<li>금액대 사은품별로 각각 한 번씩 응모 가능합니다.</li>
					<li>상단 하트모양의 버튼 클릭 시, 위시리스트에 &lt;또! 담아영&gt; 폴더가 자동 생성됩니다.</li>
					<li>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다.</li>
					<li>위시리스트에 &lt;또! 담아영&gt; 폴더는 ID당 1개만 생성이 가능합니다.</li>
					<li>해당 폴더 외에 다른 폴더에 담으시는 상품은 ‘위시 담은 금액’에 포함되지 않습니다.</li>
					<li>5만원 이상의 상품에 당첨되신 분께는 세무신고를 위해 개인정보를 요청할 수 있으며, 개인정보 확인 후 경품이 지급 됩니다.<br />제세공과금은 텐바이텐 부담입니다.</li>
					<li>위시리스트 속 상품은 최근 추가된 상품으로 구성됩니다.</li>
					<li>당첨자발표는 6월 8일 수요일 공지사항을 통해 진행됩니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<!--// 위시이벤트 - 또! 담아영 -->
</form>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="ICC" value="<%= page %>">
<input type="hidden" name="page" value="">
</form>
<% Set ifr = nothing %>
<script type="text/javascript">
<% if Request("iCC") <> "" then %>
	$(function(){
		window.$('html,body').animate({scrollTop:$(".friendsWish").offset().top}, 0);
	});
<% end if %>
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->