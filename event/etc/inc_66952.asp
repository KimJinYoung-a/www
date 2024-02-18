<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [생일은 끝났지만] 더블 마일리지! 
' History : 2015.10.26 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
dim eCode, vUserID, cMil, vMileValue, vMileArr
	vUserID = GetEncLoginUserID()
	'vUserID = "10x10yellow"
	If Now() > #10/27/2015 00:00:00# AND Now() < #10/31/2015 23:59:59# Then
		vMileValue = 200
	Else
		vMileValue = 100
	End If

	Set cMil = New CEvaluateSearcher
	cMil.FRectUserID = vUserID
	cMil.FRectMileage = vMileValue
	
	If vUserID <> "" Then
		vMileArr = cMil.getEvaluatedTotalMileCnt
	End If
	Set cMil = Nothing
%>
<style type="text/css">
img {vertical-align:top;}
.evt66952 {}
.evt66952 .topic {position:relative;}
.evt66952 .topic .hand {position:absolute; top:166px; left:435px;}
.evt66952 .topic .deco {position:absolute; top:125px; left:155px;}
.checkMileage {position:relative;}
.viewMileage {position:absolute; bottom:0; left:50%; width:855px; height:123px; margin-left:-427px;}
.viewMileage .mgCont {position:relative; padding-top:37px; text-align:left;}
.viewMileage .mgCont img {padding-right:8px; vertical-align:middle;}
.viewMileage .mgCont strong {display:inline-block; position:relative; top:1px; font-family:'Verdana'; font-size:15px; font-weight:normal; line-height:19px;}
.viewMileage .mgCont .t01 {border-bottom:1px solid #333; color:#333;}
.viewMileage .mgCont .t02 {border-bottom:1px solid #fddb75; color:#fddb75;}
.viewMileage .mgCont .t03 {border-bottom:1px solid #ef0000; color:#ef0000;}
.viewMileage .mgBtn {position:absolute; top:15px; right:0;}

.checkMileage .after .mgCont {padding-top:17px;}
.checkMileage .after .mgBtn {top:0;}

.itemList {padding-top:50px; padding-bottom:66px; background:#bdcffa url(http://webimage.10x10.co.kr/eventIMG/2015/66952/bg_sky.png) repeat-y 50% 0;}
.itemList ul {overflow:hidden; padding-top:46px; padding-left:66px;}
.itemList ul li {overflow:hidden; float:left; width:244px; height:244px; margin:4px;}
.itemList ul li a {display:block; position:relative;}
.itemList ul li a .over {position:absolute; top:-205px; left:20px; transition:top 0.7s;}
.itemList ul li a:hover .over {top:20px;}

.evtNoti {position:relative; padding:34px 0 50px; background-color:#f1f5fb; text-align:left;}
.evtNoti h3 {position:absolute; top:45px; left:100px;}
.evtNoti ul {margin-left:265px; padding-left:34px; border-left:1px solid #ddd; color:#917a70; font-size:12px; line-height:13px;}
.evtNoti ul li {padding-top:10px;}
.evtNoti ul li:first-child {padding-top:0;}

.bubble {-webkit-animation-name:bubble; -webkit-animation-duration:3s; -webkit-animation-timing-function:ease-in-out; -webkit-animation-delay:-1s;-webkit-animation-iteration-count:infinite; -webkit-animation-direction:alternate; -webkit-animation-play-state:running; animation-name:bubble; animation-duration:3s; animation-timing-function:ease-in-out; animation-delay:-1s; animation-iteration-count:infinite; animation-direction:alternate; animation-play-state:running}
@-webkit-keyframes bubble {
	0% {margin-top:0;}
	100%{margin-top:20px;}
}
@keyframes bubble{
	0%{margin-top:0;}
	100%{margin-top:20px;}
}

/* flash animation */
@-webkit-keyframes updown {
	0% {margin-top:0;}
	50% {margin-top:5px;}
	100% {margin-top:0;}
}
@keyframes updown {
	0% {margin-top:0;}
	50% {margin-top:5px;}
	100% {margin-top:0;}
}
.updown {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-name:updown; animation-name:updown; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
</style>
<script type="text/javascript">

function jsSubmitComment(){
	jsChklogin('<%=IsUserLoginOK%>');
	return;
}

</script>

	<!-- [생일은 끝났지만] 더블 마일리지! -->
	<div class="evt66952">
		<div class="topic">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/tit_review.png" alt="생일이 끝났지만 우린 더블 마일리지" /></h2>
			<span class="hand updown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_hand.png" alt="" /></span>
			<span class="deco bubble"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_deco.png" alt="" /></span>
		</div>

		<!-- 마일리지 확인하기 -->
		<div class="checkMileage">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/txt_point.png" alt="상품후기를 쓰면 200포인트, 첫 상품후기를 쓰면 400포인트를 드립니다." /></p>
			<% If IsUserLoginOK Then %>
				<!-- 로그인 후 -->
				<!-- for dev msg : 로그인 후에는 클래스 after 붙여주세요 <div class="viewMileage after"> -->
				<div class="viewMileage after">
					<div class="mgCont">
						<p>
							<strong class="t01"><%=vUserID%></strong> <img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/txt_mileage_01.png" alt="고객님," />
							<strong class="t02"><%=vMileArr(0,0)%></strong> <img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/txt_mileage_02.png" alt="개의 상품후기를 남길 수 있습니다." />
						</p>
						<p class="tPad10">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/txt_mileage_03.png" alt="이벤트 기간 동안 예상 마일리지 적립금은" />
							<strong class="t03"><%=FormatNumber(vMileArr(1,0),0)%></strong> <img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/txt_mileage_04.png" alt="원 입니다." />
						</p>
					</div>
					<p class="mgBtn"><a href="/my10x10/goodsusing.asp" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/btn_review.png" alt="상품후기쓰고 더블 마일리지 받기" /></a></p>
				</div>
			<% else %>
				<!-- 로그인 전 -->
				<div class="viewMileage">
					<div class="mgCont">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/txt_expect_mileage.png" alt="나의 예상 적립 마일리지를 확인하세요!" /></p>
					</div>
					<p class="mgBtn"><a href="" onClick="jsSubmitComment(); return false;" ><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/btn_login.png" alt="로그인하기" /></a></p>
				</div>
				<!--// 로그인 전 -->
			<% end if %>
		</div>
		<!-- //마일리지 확인하기 -->

		<div class="ex">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_review_example.jpg" alt="상품후기의 좋은 예" usemap="#Map01" />
			<map name="Map01" id="Map01">
				<area shape="rect" coords="70,164,395,761" href="/shopping/category_prd.asp?itemid=1353278" alt="2016 월드 와이드 스케줄러" />
				<area shape="rect" coords="408,164,733,761" href="/shopping/category_prd.asp?itemid=1347843" alt="half neck basic knit top" />
				<area shape="rect" coords="746,165,1070,762" href="/shopping/category_prd.asp?itemid=1260092" alt="캔빌리지 원형수납장" />
				<area shape="rect" coords="904,773,1071,810" href="/bestreview/bestreview_main.asp?sortDiv=pnt" alt="더 많은 상품후기 보기" />
			</map>
		</div>

		<div class="itemList">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/tit_best_review.png" alt="베스트 상품에는 베스트 리뷰가 따라온다!" /></h3>
			<ul>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1368291">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_01.jpg" alt="모슈 보온보냉 텀블러 350" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_01_over.png" alt="핫뜨거뜨거 핫핫" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1371252">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_02.jpg" alt="로즈골드 크리스탈 미러 케이스" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_02_over.png" alt="핸드폰 새로샀니" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1321501">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_03.jpg" alt="굵은글씨용 MEDIUM 네임펜 은색" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_03_over.png" alt="켈리 그라펜" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1370180">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_04.jpg" alt="아이뉴 USB 아로마 디퓨저 가습기" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_04_over.png" alt="내방의 구름구름" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1317089">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_05.jpg" alt="작약 피오니 드라이플라워 1단 3송이" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_05_over.png" alt="꽃을 드립니다" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1071435">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_06.jpg" alt="이어폰 보관 케이스 &amp; 수납 파우치 이어폰레스트" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_06_over.png" alt="꼬인 우리 사이" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1196780">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_07.jpg" alt="H&amp;B Cat Diamond Marble" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_07_over.png" alt="네가 사는 그 집" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1160000">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_08.jpg" alt="BLANKET 2종" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_08_over.png" alt="울라울라 이쁘다" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1323283">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_09.jpg" alt="스크래치 나이트뷰 Scratch Night View" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_09_over.png" alt="심심할 땐 파리타임" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1371651">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_10.jpg" alt="데꼴 2015 크리스마스 피규어 마스코트" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_10_over.png" alt="미리 크리스데꼴" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1354485">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_11.jpg" alt="2016 심플래너 mini" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_11_over.png" alt="2016년 부탁해" /></span>
					</a>
				</li>
				<li>
					<a href="/shopping/category_prd.asp?itemid=1260174">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_12.jpg" alt="Mini basket" /></span>
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66952/img_item_12_over.png" alt="바글바글 바구니" /></span>
					</a>
				</li>
			</ul>
		</div>

		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/tit_event_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>- 이벤트 기간 내에 새롭게 작성하신 상품후기에 한해서만 더블 마일리지가 적용됩니다.</li>
				<li>- 기존에 작성했던 상품후기 수정은 적용되지 않습니다.</li>
				<li>- 상품후기가 삭제된 경우에는 마일리지 지급이 되지 않습니다.</li>
				<li>- 상품후기는 배송정보 [출고완료] 이후부터 작성 하실 수 있습니다.</li>
				<li>- 상품과 관련 없는 내용이나 이미지를 올리거나, 직접 찍은 사진이 아닐 경우 삭제 및 마일리지 지급이 취소 될 수 있습니다.</li>
			</ul>
		</div>
	</div>
	<!-- //[생일은 끝났지만] 더블 마일리지! -->
<!-- #include virtual="/lib/db/dbclose.asp" -->