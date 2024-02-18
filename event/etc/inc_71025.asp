<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 페이스백
' History : 2016.06.01 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
dim eCode, userid, currenttime, subscriptcount, systemok, sqlstr, totalprice
dim arrList
	IF application("Svr_Info") = "Dev" THEN
		eCode = "66141"
	Else
		eCode = "71025"
	end if

currenttime = now()
'currenttime = #05/20/2016 10:05:00#

userid = GetEncLoginUserID()
totalprice = 0
subscriptcount=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", left(currenttime,10))
end if

''응모 차단시 X로 변경
	'systemok="X"
	systemok="O"

if left(currenttime,10)<"2016-06-06" then
	systemok="X"
	if userid = "baboytw" or userid = "greenteenz" then
		systemok="O"
	end if
end if

if userid <> "" then
	sqlstr = sqlstr & " select isnull(sum(subtotalprice),0) as totalprice"
	sqlstr = sqlstr & " from db_order.dbo.tbl_order_master m"
	sqlstr = sqlstr & " where convert(varchar(10),regdate,21)='"&date()&"' "
	sqlstr = sqlstr & " and m.jumundiv not in (6,9)"
	sqlstr = sqlstr & " and m.ipkumdiv>3 and cancelyn='N'"
	sqlstr = sqlstr & " and m.userid='"& userid &"'"

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		totalprice = rsget("totalprice")
	else
		totalprice = 0
	END IF
	rsget.close
end if
	
	dim rsMem
	sqlstr = ""
	sqlstr = sqlstr & " select top 45 d.itemid, d.itemname, i.listimage, i.basicimage "
	sqlstr = sqlstr & " 	from db_order.dbo.tbl_order_detail as d "
	sqlstr = sqlstr & " 	join db_item.dbo.tbl_item as i "
	sqlstr = sqlstr & " 		on d.itemid = i.itemid "
	sqlstr = sqlstr & " where d.itemid <> 0 and d.itemid <> 100 "
	sqlstr = sqlstr & " order by orderserial desc "

	set rsMem = getDBCacheSQL(dbget,rsget,"71025EVT",sqlstr,60*5)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		arrList = rsMem.getRows()
	END IF
	rsMem.close

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg

dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode("[텐바이텐] 페이스 백!")
snpLink = Server.URLEncode("http://m.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre = Server.URLEncode("10x10 이벤트")

'기본 태그
snpTag = Server.URLEncode("텐바이텐")
snpTag2 = Server.URLEncode("#10x10")

%>
<style type="text/css">
img {vertical-align:top;}
.myShopping {height:540px; background:#d4d9e9 url(http://webimage.10x10.co.kr/eventIMG/2016/71025/bg_gradation.png) repeat-x 0 0;}
.myShopping h3 {padding:70px 0 60px;}
.myShopping .price {position:relative; width:320px; min-height:118px; margin:0 auto 45px; padding:0 320px 0 150px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71025/ico_member.png) no-repeat 0 50%;}
.myShopping .price dl {overflow:hidden; padding:50px 0 45px; border-top:3px solid #ccd6e8; border-bottom:3px solid #ccd6e8;}
.myShopping .price dt {float:left; text-align:left;}
.myShopping .price dd {float:right; text-align:right;}
.myShopping .price dd strong {color:#fe3b18; padding-right:8px; font:bold 28px/24px arial;}
.myShopping .price .btnApply {position:absolute; right:0; top:50%; margin-top:-45px; background:transparent;}
.myShopping .winList {position:relative; width:498px; height:86px; margin:0 auto; padding:6px 0 0 210px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71025/bg_win.png) no-repeat 0 0;}
.myShopping .winList h4 {position:absolute; left:67px; top:40px;}
.myShopping .winList .winSwipe {position:relative;}
.myShopping .winList .winSwipe .swiper-container {width:490px; height:86px;}
.myShopping .winList .winSwipe .swiper-container p {color:#2d2d2d; font-size:13px; line-height:89px;}
.myShopping .winList .winSwipe .swiper-container p em {color:#3b579d; font-family:arial; font-weight:bold;}
.myShopping .winList .winSwipe button {display:block; position:absolute; right:0; width:70px; height:43px; background:transparent; text-indent:-999em;}
.myShopping .winList .winSwipe .prev {top:0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71025/btn_prev.png) no-repeat 50% 28px;}
.myShopping .winList .winSwipe .next {bottom:0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71025/btn_next.png) no-repeat 50% 7px;}
.myShopping .tip {padding-top:25px;}
.saleNow {position:relative; padding-bottom:134px; background:#e9ebee;}
.saleNow h3 {padding:54px 0 45px;}
.saleNow .itemRolling {overflow:visible !important; position:relative; width:993px; height:843px; padding:10px 5px 23px 4px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71025/bg_box.png) no-repeat 0 0;}
.saleNow .itemRolling .swiper-slide {}
.saleNow .itemRolling .swiper-slide ul {overflow:hidden;}
.saleNow .itemRolling .swiper-slide li {float:left; width:20%; height:257px; padding-top:24px;}
.saleNow .itemRolling .swiper-slide li img {width:150px; height:150px;}
.saleNow .itemRolling .swiper-slide li p {padding:28px 25px 0; color:#888; line-height:19px;}
.saleNow .itemRolling .slidesjs-pagination {position:absolute; left:50%; bottom:-40px; z-index:20; overflow:hidden; width:70px; height:10px; margin-left:-35px;}
.saleNow .itemRolling .slidesjs-pagination li {float:left; padding:0 6px;}
.saleNow .itemRolling .slidesjs-pagination li a {display:inline-block; width:11px; height:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71025/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.saleNow .itemRolling .slidesjs-pagination li a.active {background-position:100% 0;}
.saleNow .share {position:absolute; right:75px; bottom:62px;}
.evtNoti {padding:30px 0; background:#dee0e3;}
.evtNoti div {position:relative; text-align:left; padding:0 0 0 355px;}
.evtNoti h3 {position:absolute; left:100px; top:50%; margin-top:-12px;}
.evtNoti ul {padding-left:68px; font-size:12px; line-height:20px; color:#8e8e8e; border-left:1px solid #ebecee;}
.evtNoti li {padding:0 0 3px 10px; text-indent:-10px;}
</style>
<script type="text/javascript">
$(function(){
	// 당첨자소식
	var swiper1 = new Swiper('.winSwipe .swiper-container',{
		mode :'vertical',
		loop:false,
		speed:800,
		autoplay:2000,
		pagination:false
	});
	$('.winSwipe .prev').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	})
	$('.winSwipe .next').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	// 방금판매상품
	$(".itemRolling").slidesjs({
		width:"993",
		height:"843",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:5000, effect:"fade", auto:false},
		effect:{fade:{speed:800}}
	});
});

function jsevtgo(){
<% if systemok = "O" then %>
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-06-01" and left(currenttime,10)<"2016-06-13" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount > 0 then %>
				alert('오늘은 이미 응모 하셨습니다.');
				return;
			<% else %>
				<% if totalprice < 1 then %>
					alert('금일 구매 금액이 있어야 응모가 가능 합니다.');
					return false;
				<% else %>
					var str = $.ajax({
						type: "POST",
						url: "/event/etc/doeventsubscript/doEventSubscript71025.asp",
						data: "mode=evtgo",
						dataType: "text",
						async: false
					}).responseText;
					var str1 = str.split("||")
					if (str1[0] == "11"){
						<% if left(currenttime,10)="2016-06-10" or left(currenttime,10)="2016-06-11" or left(currenttime,10)="2016-06-12" then %>
							alert('응모가 완료 되었습니다.\n\n당첨자는 다음주 월요일 오전 10시\n공지사항에서 확인하세요.');
							return false;
						<% else %>
							alert('응모가 완료 되었습니다.');
							return false;
						<% end if %>
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
						alert('오늘은 이미 응모 하셨습니다.');
						return false;
					}else if (str1[0] == "00"){
						alert('정상적인 경로가 아닙니다.');
						return false;
					}else{
						alert('오류가 발생했습니다.');
						return false;
					}
				<% end if %>
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 응모가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
<% else %>
	alert('잠시 후 다시 시도해 주세요!!');
	return;
<% end if %>
}
</script>
	<div class="evt71025">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/tit_pay_back.png" alt="페이스백" /></h2>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/txt_step.png" alt="원하는 상품 쇼핑하고 결제→이벤트 페이지에서 응모→다음날 오전 10시 당첨자 확인하기!" /></p>

		<div class="myShopping">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/tit_my_shopping.png" alt="오늘 MY 쇼핑활동" /></h3>
			<div class="price">
				<dl>
					<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/txt_price.png" alt="구매금액 :" /></dt>
					<dd><strong><%= FormatNumber(totalprice,0) %></strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/txt_won.png" alt="원" /></dd>
				</dl>
				<button type="button" onclick="jsevtgo(); return false;" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/btn_apply.png" alt="오늘 MY 쇼핑활동" /></button>
			</div>
			<div class="winList">
				<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/txt_win.png" alt="당첨자 소식" /></h4>
				<div class="winSwipe">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<% if left(currenttime,10) <="2016-06-06" then %>
								<div class="swiper-slide"><p>내일 오전 10시부터 당첨자가 발표 됩니다.</p></div>

							<% elseif left(currenttime,10) ="2016-06-07" then %>
								<div class="swiper-slide"><p>6월 6일 응모하신 <em>waal**</em>님 구매금액 <em> 109,181 </em>원 당첨 되셨습니다.</p></div>

							<% elseif left(currenttime,10) ="2016-06-08" then %>
								<div class="swiper-slide"><p>6월 6일 응모하신 <em>waal**</em>님 구매금액 <em> 109,181 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 7일 응모하신 <em>kma295**</em>님 구매금액 <em> 530,000 </em>원 당첨 되셨습니다.</p></div>

							<% elseif left(currenttime,10) ="2016-06-09" then %>
								<div class="swiper-slide"><p>6월 6일 응모하신 <em>waal**</em>님 구매금액 <em> 109,181 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 7일 응모하신 <em>kma295**</em>님 구매금액 <em> 530,000 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 8일 응모하신 <em>eehw**</em>님 구매금액 <em> 55,260 </em>원 당첨 되셨습니다.</p></div>

							<% elseif left(currenttime,10) ="2016-06-10" then %>
								<div class="swiper-slide"><p>6월 6일 응모하신 <em>waal**</em>님 구매금액 <em> 109,181 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 7일 응모하신 <em>kma295**</em>님 구매금액 <em> 530,000 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 8일 응모하신 <em>eehw**</em>님 구매금액 <em> 55,260 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 9일 응모하신 <em>kindj**</em>님 구매금액 <em> 68,610 </em>원 당첨 되셨습니다.</p></div>

							<% elseif left(currenttime,10) ="2016-06-11" then %>
								<div class="swiper-slide"><p>6월 6일 응모하신 <em>waal**</em>님 구매금액 <em> 109,181 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 7일 응모하신 <em>kma295**</em>님 구매금액 <em> 530,000 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 8일 응모하신 <em>eehw**</em>님 구매금액 <em> 55,260 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 9일 응모하신 <em>kindj**</em>님 구매금액 <em> 68,610 </em>원 당첨 되셨습니다.</p></div>
								<% ''<div class="swiper-slide"><p>6월 10일 응모하신 <em>xxxxxx</em>님 구매금액 <em> 0 </em>원 당첨 되셨습니다.</p></div> %>

							<% elseif left(currenttime,10) ="2016-06-12" then %>
								<div class="swiper-slide"><p>6월 6일 응모하신 <em>waal**</em>님 구매금액 <em> 109,181 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 7일 응모하신 <em>kma295**</em>님 구매금액 <em> 530,000 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 8일 응모하신 <em>eehw**</em>님 구매금액 <em> 55,260 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 9일 응모하신 <em>kindj**</em>님 구매금액 <em> 68,610 </em>원 당첨 되셨습니다.</p></div>
								<% ''<div class="swiper-slide"><p>6월 10일 응모하신 <em>xxxxxx</em>님 구매금액 <em> 0 </em>원 당첨 되셨습니다.</p></div> %>
								<% ''<div class="swiper-slide"><p>6월 11일 응모하신 <em>xxxxxx</em>님 구매금액 <em> 0 </em>원 당첨 되셨습니다.</p></div> %>

							<% elseif left(currenttime,10) >="2016-06-13" then %>
								<div class="swiper-slide"><p>6월 6일 응모하신 <em>waal**</em>님 구매금액 <em> 109,181 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 7일 응모하신 <em>kma295**</em>님 구매금액 <em> 530,000 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 8일 응모하신 <em>eehw**</em>님 구매금액 <em> 55,260 </em>원 당첨 되셨습니다.</p></div>
								<div class="swiper-slide"><p>6월 9일 응모하신 <em>kindj**</em>님 구매금액 <em> 68,610 </em>원 당첨 되셨습니다.</p></div>
								<% ''<div class="swiper-slide"><p>6월 10일 응모하신 <em>xxxxxx</em>님 구매금액 <em> 0 </em>원 당첨 되셨습니다.</p></div> %>
								<% ''<div class="swiper-slide"><p>6월 11일 응모하신 <em>xxxxxx</em>님 구매금액 <em> 0 </em>원 당첨 되셨습니다.</p></div> %>
								<% ''<div class="swiper-slide"><p>6월 12일 응모하신 <em>xxxxxx</em>님 구매금액 <em> 0 </em>원 당첨 되셨습니다.</p></div> %>

							<% end if %>
						</div>
					</div>
					<button type="button" class="prev">이전</button>
					<button type="button" class="next">다음</button>
				</div>
			</div>
			<p class="tip"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/txt_tip.png" alt="※ 금, 토, 일 당첨자는 13일 월요일 오전 10시에 공지사항을 통해 발표됩니다." /></p>
		</div>

		<div class="saleNow">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/tit_sell.png" alt="방금 전 판매된 상품" /></h3>
			<div class="itemRolling">
				<div class="swiper-slide">
					<ul>
					<%
					dim numcols, numrows, rowcounter, colcounter, thisfield
					numcols=ubound(arrList,1)
					numrows=ubound(arrList,2)
						FOR rowcounter= 0 TO numrows
						     thisfield=arrList(colcounter,rowcounter)
					%>
									<li>
										<a href="/shopping/category_prd.asp?itemid=<%= arrList(0,rowcounter) %>">
											<img src="http://webimage.10x10.co.kr/image/basic/<%= GetImageSubFolderByItemid(arrList(0,rowcounter)) %>/<%= arrList(3,rowcounter) %>" alt="" />
											<p><%= arrList(1,rowcounter) %></p>
										</a>
									</li>
							<% if rowcounter = 14 or rowcounter = 29 then %>
								</ul>
							</div>
							<div class="swiper-slide">
								<ul>
							<% end if %>
						<%
						NEXT
						%>
					</ul>
				</div>
			</div>
			<p class="share"><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/btn_facecbook.png" alt="페이스북 친구들에게 공유하기" /></a></p>
		</div>

		<div class="evtNoti">
			<div>
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71025/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li>- 본 이벤트는 당일 구매이력이 있는 고객 대상으로 응모가 가능합니다.</li>
					<li>- 당첨자는 익일 오전 10시 응모하기 버튼 하단에 있는 당첨자소식을 통해 확인할 수 있습니다.</li>
					<li>- 금, 토, 일요일 당첨자는 13일 월요일 오전 10시 공지사항을 통해 확인할 수 있습니다.</li>
					<li>- 당첨된 금액은 당일 구매한 고객님의 총 결제금액이며 해당 금액의 기프트카드로 지급합니다.</li>
					<li>- 기프트카드는 6월 27일 주문완료 된 고객 대상으로 지급될 예정입니다.</li>
					<li>- 본 이벤트는 당첨 후 주문취소 및 환불하게 되면 당첨에서 제외됩니다.</li>
					<li>- 5만원 이상의 경품에 당첨되신 분께는 세무신고를 위해 개인정보를 요청할 수 있으며, 개인정보 확인 후<br />경품이 지급 됩니다. 제세공과금은 텐바이텐 부담입니다.</li>
				</ul>
			</div>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->