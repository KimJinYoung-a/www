<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  더블 마일리지! 
' History : 2016.05.02 원승현 생성
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
	If Now() > #05/04/2016 00:00:00# AND Now() < #05/11/2016 23:59:59# Then
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

#contentWrap {padding-bottom:0;}

.doubleMileage .topic {position:relative; height:349px; padding-top:287px;background:#fcd936 url(http://webimage.10x10.co.kr/eventIMG/2016/70512/bg_pattern_dot_yellow.png) repeat 0 0;}
.doubleMileage .topic h2 {position:absolute; top:102px; left:50%; width:528px; height:89px; margin-left:-264px;}
.doubleMileage .topic h2 span {position:absolute; top:4px; left:0;}
.doubleMileage .topic h2 .letter2 {left:158px;}

.doubleMileage .topic .date {position:absolute; top:33px; left:50%; margin-left:-241px;}
.doubleMileage .topic .desc {position:relative; width:998px; height:300px; margin:0 auto;}
.doubleMileage .topic .desc .check {position:absolute; top:73px; right:129px; width:270px;}
.doubleMileage .topic .desc .check ul {margin:0 10px;}
.doubleMileage .topic .desc .check ul li {position:relative; margin-bottom:20px;}
.doubleMileage .topic .desc .check ul li b {position:absolute; top:0; right:20px; color:#fbd213; font-family:'Dotum'; font-size:20px; line-height:16px; text-align:right;}
.doubleMileage .topic .desc .check .btnGroup {position:absolute; top:128px; left:0;}
.doubleMileage .topic .desc .check .btnGroup p {margin-top:15px;}

.doubleMileage .example {position:relative; height:836px; padding-top:54px; background:#f9f5e1 url(http://webimage.10x10.co.kr/eventIMG/2016/70512/bg_pattern_dot_ivory.png) repeat 0 0;}
.doubleMileage .example .item {margin-top:50px;}
.doubleMileage .example .btnMore {position:absolute; bottom:42px; left:50%; margin-left:382px;}
.doubleMileage .example .btnMore:hover {animation-play-state:paused;}

.doubleMileage .best {height:943px; padding-top:53px; background:#f1ecd6 url(http://webimage.10x10.co.kr/eventIMG/2016/70512/bg_pattern_dot_beige.png) repeat 0 0;}
.doubleMileage .best .item {overflow:hidden; width:1088px; margin:50px auto 0;}
.doubleMileage .best .item li {float:left; margin:0 14px 28px;}
.doubleMileage .best .item li a {position:relative; display:block; width:100%;}
.doubleMileage .best .item li .mask {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70512/bg_mask.png) no-repeat 50% 50%;}
.doubleMileage .best .item li a .over {opacity:0; filter:alpha(opacity=0);}
.doubleMileage .best .item li .mask {transition:opacity 0.2s ease-out; opacity:0; filter:alpha(opacity=0);}
.doubleMileage .best .item li a:hover .mask {opacity:1; filter:alpha(opacity=100); height:101%;}
.doubleMileage .best .item li .over {position:absolute; top:50%; left:0; width:100%; margin-top:-60px; transition:all 0.3s linear;opacity:0;}
.doubleMileage .best .item li a:hover .over {margin-top:-25px; opacity:1; filter:alpha(opacity=100);}

.noti {background-color:#e9e2c4; text-align:left;}
.noti .inner {position:relative; width:1140px; margin:0 auto; padding:45px 0 44px; }
.noti h3 {position:absolute; top:50%; left:100px; margin-top:-9px;}
.noti ul {margin-left:265px; padding-left:34px; border-left:1px solid #c0b99c;}
.noti ul li {position:relative; margin-bottom:7px; padding-left:14px; color:#878062; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#878062;}

@keyframes updown {
	0% {margin-top:0;}
	50% {margin-top:5px;}
	100% {margin-top:0;}
}
.updown {animation-name:updown; animation-duration:1s; animation-iteration-count:infinite;}

@keyframes shake {
	0% {margin-left:382px;}
	50% {margin-left:378px;}
	100% {margin-left:382px;}
}
.shake {animation-name:shake; animation-duration:1s; animation-iteration-count:infinite;}
</style>
<script type="text/javascript">

function jsSubmitComment(){
	jsChklogin('<%=IsUserLoginOK%>');
	return;
}

</script>


<div class="evt70512 doubleMileage">
	<div class="topic">
		<h2>
			<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/tit_double_mileage_v1.png" alt="더블 마일리지" /></span>
			<span class="letter2 updown"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_finger.png" alt="" /></span>
		</h2>
		<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_date_v1.png" alt="지금 5월 11일까지 상품후기를 쓰면 마일리지를 두배로 적립해드립니다. 이벤트 기간은 2016년 5월 4일부터 11일까지 진행합니다." /></p>

		<div class="desc">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_double_mileage_v1.png" alt="후기 작성시 100마일리지의 두배인 200마일리지를, 해당 상품의 첫 후기를 작성시 200마일리지의 두배인 400마일리지를 드립니다. 마이텐바이텐의 MY 쇼핑활동의상품후기, 각 상품 별 하단에 기입되어있음" /></p>

			<% If IsUserLoginOK Then %>
				<%' for dev msg : 로그인 후 %>
				<div class="check">
					<ul>
						<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_review_count.png" alt="상품 후기 개수" /><b><%=vMileArr(0,0)%></b></li>
						<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_expect_mileage.png" alt="예상 마일리지" /><b><%=FormatNumber(vMileArr(1,0),0)%></b></li>
					</ul>
					<div class="btnGroup">
						<a href="/my10x10/goodsusing.asp" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/btn_write_review.png" alt="상품 후기 쓰러가기" /></a>
					</div>
				</div>
			<% Else %>
				<!-- for dev msg : 로그인 전 -->
				<div class="check">
					<ul>
						<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_review_count.png" alt="상품 후기 개수" /><b>*</b></li>
						<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_expect_mileage.png" alt="예상 마일리지" /><b>*</b></li>
					</ul>
					<div class="btnGroup">
						<a href="" onClick="jsSubmitComment(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/btn_login.png" alt="로그인 하기" /></a>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_need_login.png" alt="예상 마일리지는 로그인 후 확인 할 수 있습니다" /></p>
					</div>
				</div>
			<% End If %>
		</div>
	</div>

	<div class="example">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/tit_example.png" alt="상품후기의 좋은 예" /></h3>
		<div class="item">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_review_example.png" alt="" usemap="#itemLink" />
			<map name="itemLink" id="itemLink">
				<area shape="rect" coords="2,2,344,640" href="/shopping/category_prd.asp?itemid=1389253&amp;pEtr=70512" alt="알렉스 103 패브릭 좌식 소파베드" />
				<area shape="rect" coords="360,2,705,639" href="/shopping/category_prd.asp?itemid=1246002&amp;pEtr=70512" alt="셀카렌즈 신제품 New lens mount system wide angle" />
				<area shape="rect" coords="717,2,1061,639" href="/shopping/category_prd.asp?itemid=1419077&amp;pEtr=70512" alt="레꼴뜨 프레스샌드메이커 퀼트" />
			</map>
		</div>
		<a href="/bestreview/bestreview_main.asp?disp=" title="베스트 리뷰 페이지로 이동" class="btnMore shake"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/btn_more_review.png" alt="더 많은 상품후기 보기 " /></a>
	</div>

	<div class="best">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/tit_best_reivew.png" alt="Best 상품에는 Best 리뷰가 따라온다!" /></h3>
		<ul class="item">
			<li>
				<a href="/shopping/category_prd.asp?itemid=1226544&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_01.jpg" alt="가정용 소형 공기청정기 에어비타 큐" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_01.png" alt="공기가 상큼 Air" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1395662&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_02.jpg" alt="the band pink" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_02.png" alt="쉴 때도 예쁘게" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=749271&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_03.jpg" alt="원목 사각 스툴" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_03.png" alt="화분 자리" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1313570&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_04.jpg" alt="메모리 래인 캔들 워머 화이트" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_04.png" alt="향기 on" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1194365&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_05.jpg" alt="슬림팩 리모와 디자인 휴대용 보조배터리 6,000mAh" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_05.png" alt="넌 너무 가벼워" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1149977&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_06.jpg" alt="tobe 원데이레코드북" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_06.png" alt="오늘을 기록해" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1460978&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_07.jpg" alt="그랜드 부다페스트 호텔 책" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_07.png" alt="그랜드 부다페스트" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1146524&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_08.jpg" alt="Excelsior Low Cut W3166R" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_08.png" alt="매일매일 신고 싶어" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=879996&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_09.jpg" alt="lifestudio 자동장우산" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_09.png" alt="비를 막아주세요" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1350646&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_10.jpg" alt="아이띵소 neat bag ash" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_10.png" alt="든든한 백" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=243393&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_11.jpg" alt="Retro 모닝세트 컵과 트레이" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_11.png" alt="굿 모닝 모닝" /></span>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1112223&amp;pEtr=70512">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/img_best_item_12.jpg" alt="건강한 인테리어를 위한 모던화분 시리즈" />
					<span class="mask"></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/txt_best_item_12.png" alt="내 방 속 작은 정원" /></span>
				</a>
			</li>
		</ul>
	</div>

	<div class="noti">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70512/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span>이벤트 기간 내에 작성하신 상품후기에 한해서만 더블 마일리지가 적용됩니다.</li>
				<li><span></span>기존에 작성했던 상품후기 수정은 적용되지 않습니다.</li>
				<li><span></span>상품후기가 삭제된 경우에는 마일리지 지급이 되지 않습니다.</li>
				<li><span></span>상품후기는 배송정보 [출고완료] 이후부터 작성 하실 수 있습니다.</li>
				<li><span></span>상품과 관련 없는 내용이나 이미지를 올리거나, 직접 찍은 사진이 아닐 경우 삭제 및 마일리지 지급이 취소 될 수 있습니다.</li>
			</ul>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->