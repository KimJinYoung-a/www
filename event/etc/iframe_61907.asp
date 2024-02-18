<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description :  상품 후기는 사진으로! 마일리지는 두배로!
' History : 2015.04.27 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->

<%
dim currenttime
	currenttime =  now()
	'currenttime = #04/22/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  61764
Else
	eCode   =  61907
End If

dim userid, i
	userid = getloginuserid()
%>

<!-- #include virtual="/lib/inc/head.asp" -->

<style type="text/css">
.evt61907 img {vertical-align:top;}
.evt61907 {position:relative;}
.evt61907 .viewMileage {height:156px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61907/bg_my_condition.gif) left top no-repeat;}
.evt61907 .viewMileage .viewCont {overflow:hidden; width:982px; margin:0 auto;}
.evt61907 .viewMileage .viewCont .ftRt {padding-top:40px;}
.evt61907 .viewMileage .viewCont .ftRt a {margin-left:5px;}
.evt61907 .viewMileage .typeA .ftLt {padding-top:45px;}
.evt61907 .viewMileage .typeB .ftLt {padding-top:30px;}
.evt61907 .viewMileage .typeB .ftLt p {padding-top:5px;}
.evt61907 .viewMileage .typeB .ftLt span {position:relative; top:-1px; color:#fff600; font-size:16px; line-height:16px; border-bottom:1px solid #fff600; font-weight:bold;}
.evt61907 .viewMileage .typeB .ftLt span.user {font-size:18px; font-family:tahoma;}
.evt61907 .bestPhotoReview {padding:0 0 40px 50px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61907/bg_stripe.gif) left top repeat-y;}
.evt61907 .bestPhotoReview h3 {padding:47px 0 30px;}
.evt61907 .bestPhotoReview ul {overflow:hidden; width:1024px; height:1024px; padding:30px 0 0 30px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61907/bg_box.png) left top no-repeat;}
.evt61907 .bestPhotoReview li {overflow:hidden; position:relative; float:left; width:240px; height:240px; margin:0 3px 7px; cursor:pointer;}
.evt61907 .bestPhotoReview li p {position:absolute; left:-240px; top:0;}
.evt61907 .evtNoti {padding:42px 70px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61907/bg_notice.gif) left top repeat-x;}
.evt61907 .evtNoti ul {padding-top:27px;}
.evt61907 .evtNoti li {font-size:11px; line-height:12px; color:#000; padding:0 0 10px 12px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61907/blt_arrow.gif) left top no-repeat;}
</style>
<script type="text/javascript">
$(function(){
	$('.bestPhotoReview li a').mouseenter(function(){
		$(this).children('p').animate({"left":"0"}, 500);
	});
	$('.bestPhotoReview li a').mouseleave(function(){
		$(this).children('p').animate({"left":"-240px"}, 500);
	});
});
</script>
</head>
<body>

<!-- 상품후기는 사진으로! 마일리지는 두배로! -->
<div class="evt61907">
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/txt_date.gif" alt="이벤트 기간 :2015.04.28~05.05" /></p>
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/tit_photo_review.gif" alt="상품후기는 사진으로! 마일리지는 두배로!" /></h2>
	<!-- 마일리지 확인하기 -->
	<div class="viewMileage">
		<% If IsUserLoginOK() Then %>
			<%
			dim cMil, vMileArr
				vMileArr = 0

			Set cMil = New CEvaluateSearcher
			cMil.FRectUserID = Userid
			cMil.FRectMileage = 200
			vMileArr = cMil.getEvaluatedTotalMileCnt
			Set cMil = Nothing
			%>
			<!-- 로그인 후 -->
			<div class="viewCont typeB">
				<div class="ftLt">
					<p class="bPad15">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/txt_my01.png" alt="안녕하세요" />
						<span class="user"><%= printUserId(userid,2,"*") %></span>
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/txt_my02.png" alt="고객님" />
					</p>
					<p>
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/txt_my03.png" alt="고객님은" />
						<span><%=vMileArr(0,0)%></span>
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/txt_my04.png" alt="개의 상품후기를 남기실 수 있습니다." />
					</p>
					<p>
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/txt_my05.png" alt="이벤트 기간 동안 포토후기로 올리시면 적립 예상 마일리지는" />
						<span><%=FormatNumber(vMileArr(1,0),0)%></span>
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/txt_my06.png" alt="원 입니다." />
					</p>
				</div>
				<div class="ftRt"><a href="/my10x10/goodsusing.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/btn_go_review.png" alt="포토후기 남기러 가기" /></a></div>
			</div>
		<% else %>
			<!-- 로그인 전 -->
			<div class="viewCont typeA">
				<div class="ftLt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/txt_view_mileage.png" alt="내 예상 적립 마일리지 확인하기" /></div>
				<div class="ftRt">
					<a href="" onclick="jsChklogin('<%=IsUserLoginOK%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/btn_login.png" alt="로그인 하기" /></a>
					<a href="/member/join.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/btn_join.png" alt="회원가입 하기" /></a>
				</div>
			</div>
		<% end if %>
	</div>
	<!--// 마일리지 확인하기 -->
	<div class="bestPhotoReview">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/tit_good_review.png" alt="바람직한 포토후기를 둘러 보세요!" /></h3>
		<ul>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1230915" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review01.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review01_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1237018" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review02.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review02_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1213212" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review03.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review03_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1162302" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review04.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review04_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1112357" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review05.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review05_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1153367" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review06.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review06_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1114838" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review07.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review07_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1149913" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review08.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review08_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1044817" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review09.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review09_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1118130" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review10.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review10_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1047285" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review11.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review11_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1076947" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review12.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review12_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1024665" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review13.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review13_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=1244973" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review14.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review14_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=491320" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review15.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review15_on.png" alt="" /></p>
				</a>
			</li>
			<li>
				<a href="/shopping/category_prd.asp?itemid=343756" target="_top">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review16.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_review16_on.png" alt="" /></p>
				</a>
			</li>
		</ul>
		<p class="tPad20 ct" style="padding-right:48px;"><a href="/bestreview/bestreview_photo.asp" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/btn_view_more.png" alt="더 많은 포토후기 보기" /></a></p>
	</div>
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/img_use_mileage.gif" alt="야무진 마일리지 사용법!" usemap="#map" />
		<map name="map" id="map">
			<area shape="rect" coords="46,109,568,316" href="/my10x10/mymileage.asp" target="_top" alt="마일리지 현황보기" />
			<area shape="rect" coords="574,109,1096,316" href="/my10x10/mileage_shop.asp" target="_top" alt="마일리지샵 가기" />
		</map>
	</div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/61907/tit_notice.gif" alt="유의사항은 꼭 읽어주세요!" /></h3>
		<ul>
			<li>텐바이텐 회원대상 이벤트 입니다. (비회원 참여 불가)</li>
			<li>포토후기를 남기시면 자동으로 200 마일리지가 적립됩니다.</li>
			<li>타인의 작품을 도용한 경우, 부적절한 후기로 간주될 경우 사전 통보 없이 삭제됩니다.</li>
			<li>포토후기에 대한 더블 마일리지는 이벤트 기간동안만 적용됩니다.</li>
		</ul>
	</div>
</div>
<!-- // 상품후기는 사진으로! 마일리지는 두배로! -->

</body>
</html>

<!-- #include virtual="/lib/poptailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->