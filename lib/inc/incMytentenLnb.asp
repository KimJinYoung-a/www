<div id="lnbMy10x10V15" class="lnbMy10x10V15">
	<div id="profileModalArea"></div>
<% if (IsUserLoginOK) then %>
	<div class="article profile new_pro21">
		<p class="hello">Hello, <%= GetLoginUserId() %></p>
		<div class="figure" id="myProfile">
			<%'// 2018 회원등급 개편 %>
			<strong onclick="location.href='/my10x10/special_info.asp';" class="classV18 <%=GetUserLevelCSSClass%>" style="cursor:pointer;"><%= GetUserLevelStr(GetLoginUserLevel()) %> 회원</strong>
			<div class="profile_container">
				<img src="<%= GetUserProfileImg(GetLoginUserICon,getloginuserid) %>" width="100" height="100" alt="프로필이미지" />
			</div>
			<!-- <a href="/my10x10/userinfo/memberprofile.asp" onclick="window.open(this.href, 'popProfile', 'width=580, height=750, scrollbars=yes'); return false;" target="_blank" title="프로필 이미지 팝업">EDIT</a> -->
			<a href="javascript:void(0);" onclick="openProfileWriteModal(); return false;" title="프로필 이미지 팝업">EDIT</a>
			<!-- 21-10-03 프로필 추가 -->
			<div class="pro_info_area">
				<p class="glade"></p>
				<p class="nick_name"></p>
			</div>
			<!-- // -->
		</div>

		<!-- my badge-->
		<!-- #include virtual="/my10x10/inc/inc_myBadgeBox.asp" -->

		<ul>
			<li><a href="/my10x10/couponbook.asp" title="쿠폰/보너스쿠폰 조회하기"><strong><%= GetLoginCouponCount() %>장</strong>쿠폰</a></li>
			<li class="mymileage"><a href="/my10x10/mymileage.asp" title="마일리지 현황 조회하기"><strong><%= FormatNumber(GetLoginCurrentMileage(), 0)%>P</strong>마일리지</a><span id="mileageCreditAvailable"></span></li>
			<li><a href="/my10x10/myTenCash.asp" title="예치금 조회하기"><strong><%= FormatNumber(GetLoginCurrentTenCash(), 0)%>원</strong>예치금</a></li>
			<li><a href="/my10x10/giftcard/" title="기프트카드 조회하기"><strong><%= FormatNumber(GetLoginCurrentTenGiftCard(), 0)%>원</strong>기프트카드</a></li>
		</ul>
	</div>

	<!-- 멤버십카드 배너 추가 -->
	<a href="/my10x10/membercard/point_search.asp">
		<div class="article bnrMemcard">
			<img src="http://fiximage.10x10.co.kr/web2018/memberCard/img_bnr_memcard.png" />
			<% if GetLoginCurrentCardyn() then %>
				<!-- 등록 후 -->
				 <div class="after">
					<p class="cRd0V15"><strong><%= FormatNumber(GetLoginCurrentCardpoint(), 0)%> P</strong></p>
					<p>텐바이텐 멤버십카드</p>
				</div>
			<% else %>
				<!-- 등록 전 -->
				<div class="before">
					<p>텐바이텐 멤버십카드</p>
					<p><strong class="cRd0V15">카드 발급/등록 &gt;</strong></p>
				</div>
			<% end if %>
		</div>
	</a>

	<div class="article nav15">
		<div class="quick">
			<strong class="heading"><span></span>QUICK MENU</strong>
			<ul>
				<li><a href="/my10x10/qna/myqnalist.asp" title="<%=CHKIIF(IsVIPUser()=True,"VIP ","")%>1:1 상담"><%=CHKIIF(IsVIPUser()=True,"VIP ","")%>1:1 상담</a></li>
				<li><a href="/my10x10/myeventmaster.asp" title="이벤트 당첨안내">당첨안내</a></li>
				<li><a href="/my10x10/order/order_return_detail.asp" title="반품/환불">반품/환불</a></li>
				<li><a href="/my10x10/order/order_myItemList.asp" title="내가 구매한 상품 보기">내가 구매한 상품 <span class="icoNew"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif" alt="New" /></span></a></li>
				<li><a href="/my10x10/userinfo/confirmuser.asp" title="개인정보 수정">개인정보 수정</a></li>
				<% If request.cookies("tinfo")("isTester") Then %>
					<li><a href="/my10x10/mytester/" title="테스터후기 쓰기/보기">테스터후기 쓰기/보기</a></li>
				<% End If %>
			</ul>
		</div>

		<div class="menuV15">
			<div class="all">
				<button type="button" class="open"><span>전체메뉴 보기</span></button>
			</div>
			<ul class="navigator">
				<li><a href="">MY 쇼핑리스트</a>
					<ul>
						<li><a href="/my10x10/order/myorderlist.asp" title="주문/배송 조회">주문배송조회</a></li>
						<li><a href="/my10x10/order/order_info_edit_detail.asp" title="주문정보변경">주문정보변경</a></li>
						<li><a href="/my10x10/order/order_cancel_detail.asp" title="주문취소">주문취소</a></li>
						<li><a href="/my10x10/order/order_return_detail.asp" title="반품/환불">반품/환불</a></li>
						<li><a href="/my10x10/order/document_issue.asp" title="증빙서류발급">증빙서류발급</a></li>
						<li><a href="/my10x10/order/order_cslist.asp" title="내가 신청한 서비스">내가 신청한 서비스</a></li>
					</ul>
				</li>
				<li><a href="">MY 쇼핑혜택</a>
					<ul>
						<li><a href="/my10x10/couponbook.asp" title="쿠폰/보너스 쿠폰">쿠폰/보너스 쿠폰</a></li>
						<li><a href="/my10x10/mymileage.asp" title="마일리지 현황">마일리지 현황</a></li>
						<li><a href="/my10x10/myTenCash.asp" title="예치금 관리">예치금 관리</a></li>
						<li><a href="/my10x10/mileage_shop.asp" title="마일리지샵">마일리지샵</a></li>
						<li><a href="/my10x10/special_info.asp" title="회원혜택 안내">회원혜택 안내</a>
					</ul>
				</li>
				<li><a href="">MY 쇼핑활동</a>
					<ul>
						<li><a href="/my10x10/qna/myqnalist.asp" title="<%=CHKIIF(IsVIPUser()=True,"VIP ","")%>1:1 상담"><%=CHKIIF(IsVIPUser()=True,"VIP ","")%>1:1 상담</a></li>
						<li><a href="/my10x10/myitemqna.asp" title="상품 Q&A">상품 Q&amp;A</a></li>
						<li><a href="/my10x10/goodsusing.asp" title="상품후기">상품후기</a></li>
						<li><a href="/my10x10/order/order_myItemList.asp" title="내가 구매한 상품 보기">내가 구매한 상품</a></li>
						<li><a href="/my10x10/myeventmaster.asp" title="이벤트 당첨안내">당첨안내</a></li>
						<li><a href="/my10x10/giftcard/" title="기프트카드">기프트카드</a></li>
						<% If request.cookies("tinfo")("isTester") Then %>
							<li><a href="/my10x10/mytester/" title="테스터후기 쓰기/보기">테스터후기 쓰기/보기</a></li>
						<% End If %>
					</ul>
				</li>
				<li><a href="">MY 관심목록</a>
					<ul>
						<li><a href="/my10x10/mywishlist.asp" title="위시리스트">위시</a></li>
						<li><a href="/my10x10/myzzimbrand.asp" title="찜브랜드">찜브랜드</a></li>
						<!--<li><a href="/my10x10/myfavorite_Play.asp" title="관심 PLAY">관심 PLAY</a></li>//-->
						<li><a href="/my10x10/myfavorite_event.asp" title="관심 이벤트">관심 이벤트</a></li>
						<li><a href="/my10x10/mytodayshopping.asp" title="최근 본 상품">최근 본 상품</a></li>
						<li><a href="/my10x10/MyAlarmHistory.asp" title="입고 알림 신청 내역">입고 알림 신청 내역</a></li>
					</ul>
				</li>
				<li><a href="">MY 회원정보</a>
					<ul>
						<li><a href="/my10x10/userinfo/confirmuser.asp" title="개인정보 수정">개인정보 수정</a></li>
						<li><a href="/my10x10/MyAddress/MyAddressList.asp" title="나의 주소록">나의 주소록</a></li>
						<li><a href="/my10x10/MyAnniversary/myAnniversaryList.asp" title="나의 기념일">나의 기념일</a></li>
						<li><a href="/my10x10/userinfo/withdrawal.asp" title="회원탈퇴">회원탈퇴</a></li>
					</ul>
				</li>
			</ul>
			<div class="all">
				<button type="button" class="close"><span>전체메뉴 닫기</span></button>
			</div>
		</div>
		<%' for dev msg : VIP 주소확인 이벤트 배너 %>
		<% if date()>="2017-07-03" and date() <= "2017-07-16" and IsVIPUser()=True then %>
			<div style="padding-top:22px;"><a href="/hitchhiker/"><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/img_bnr_vip_hitchhiker_address.gif" alt="VIP고객님 히치하이커 받으셨나요?" /></a></div>
		<% end if %>
	</div>
<% elseif (IsGuestLoginOK) then %>
	<div class="article nomemberV15">
		<div class="benefit">
			<div class="bg"></div>
			<strong>텐바이텐 회원혜택</strong>
			<ul>
				<li>회원가입과 동시에 쿠폰발급! (무료배송쿠폰/2,000원 쿠폰)</li>
				<li>구매금액 및 횟수에 따른 회원등급별 혜택 제공!</li>
				<li>회원 마일리지로만 구매 가능한 마일리지샵 에디션 상품!</li>
			</ul>
		</div>
		<a href="/member/join.asp" class="btn btnS1 btnRed"><span class="whiteArr01 fs12">신규회원가입</span></a>

		<div class="orderNo"><strong>주문번호 <span class="cRd0V15"><%= GetGuestLoginOrderserial() %></span></strong></div>
	</div>

	<div class="article nav navNomemberV15">
		<strong class="heading"><span></span>SHOPPING MENU</strong>
		<div class="menuV15">
			<ul class="navigator">
				<li><a href="">MY 쇼핑리스트</a>
					<ul>
						<li><a href="/my10x10/order/myorderlist.asp">주문배송조회</a></li>
						<li><a href="/my10x10/order/order_info_edit_detail.asp">주문정보변경</a></li>
						<li><a href="/my10x10/order/order_cancel_detail.asp">주문취소</a></li>
						<li><a href="/my10x10/order/order_return_detail.asp">반품/환불</a></li>
						<li><a href="/my10x10/order/document_issue.asp">증빙서류발급</a></li>
						<li><a href="/my10x10/order/order_cslist.asp">내가 신청한 서비스</a></li>
					</ul>
				</li>
				<li><a href="">MY 쇼핑활동</a>
					<ul>
						<li><a href="/my10x10/qna/myqnalist.asp">1:1 상담</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
<% end if %>
<script type="text/javascript">
var CSLeftMenuCurrURL = "<%= Request.ServerVariables("URL")  %>";

if (CSLeftMenuCurrURL.substring(0, "/my10x10/giftcard/".length) == "/my10x10/giftcard/") {
	CSLeftMenuCurrURL = CSLeftMenuCurrURL.substring(0, "/my10x10/giftcard/".length);
}
if (CSLeftMenuCurrURL.substring(0, "/my10x10/mytester/".length) == "/my10x10/mytester/") {
	CSLeftMenuCurrURL = CSLeftMenuCurrURL.substring(0, "/my10x10/mytester/".length);
}
if (CSLeftMenuCurrURL.substring(0, "/my10x10/gift/".length) == "/my10x10/gift/") {
	CSLeftMenuCurrURL = "/my10x10/gift/talk.asp";
}
if (CSLeftMenuCurrURL == "/my10x10/userinfo/membermodify.asp") {
	CSLeftMenuCurrURL = "my10x10/userinfo/confirmuser.asp";
}

$(document).ready(function() {
	// Left Menu Highlight
	var obj = $('.quick a[href$="' + CSLeftMenuCurrURL + '"], .navigator a[href$="' + CSLeftMenuCurrURL + '"]');
	obj.addClass("on");

	// Left Menu Folding control
	var objFolder = obj.closest("ul");
	$(objFolder).show().prev().addClass("on");
	getEvalMileageUserInfoMyTenTenLnb();
});

<%'적립예상마일리지 호출%>
function getEvalMileageUserInfoMyTenTenLnb(){
	$.ajax({
		url: "/my10x10/act_MyUncompletedEvalData.asp",
		cache: false,
		success: function(message) {
			var str;
			str = message.split("||");
			if (str[0]!="Err"){
				$("#mileageCreditAvailable").empty().html("<div><a href='/my10x10/goodsusing.asp'><em>+"+str[1]+"p</em> <span>적립 가능</span></a></div>");
			}
		}
		,error: function(err) {
			//alert(err.responseText);
		}
	});
}
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.10.4/polyfill.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
<% IF application("Svr_Info") = "Dev" THEN %>
    <script src="/vue/vue_dev.js"></script>
<% Else %>
    <script src="/vue/2.5/vue.min.js"></script>
<% End If %>
<script src="/vue/vue.lazyimg.min.js"></script>
<script src="/vue/vuex.min.js"></script>
<script src="/vue/common/common.js?v=1.00"></script>
<script src="/vue/components/common/functions/common.js"></script>
<script src="/vue/components/linker/modal_profile_write.js"></script>
<script type="text/javascript" src="/lib/js/swiper6.0.4-bundle.min.js"></script>
<script>
	const staticImgUpUrl = "<%= staticImgUpUrl %>";
	var userAgent = navigator.userAgent.toLowerCase();

	const profileApp = new Vue({
		el : '#profileModalArea',
		template : /*html*/`
			<MODAL-PROFILE-WRITE v-if="showProfileModal"
					:myProfile="myProfile" :userId="userId"
					@closeModal="closeProfileModal" @completePostProfile="completePostProfile"/>
		`,
		data() {return {
			showProfileModal : false, // 프로필 작성 모달 노출 여부
			isLogin : false, // 로그인 여부
			userId : '<%=GetLoginUserID%>', // 유저 ID
			myProfile : {}, // 프로필 데이터
		}},
		methods : {
			completePostProfile() {
				getMyProfile()
			},
			openProfileModal() {
				document.querySelector('body').classList.add('noscroll');
				this.showProfileModal = true;
			},
			closeProfileModal() {
				document.querySelector('body').classList.remove('noscroll');
				this.showProfileModal = false;
			},
		}
	});

	let myProfile;
	function getMyProfile() {
		const success = function(data) {
			myProfile = $('#myProfile');
			profileApp.myProfile = data;
			if( data.auth !== 'N' && data.description != null ) {
				myProfile.find('.glade').text(data.description);
			}
			if( data.registration ) {
				myProfile.find('.nick_name').text(data.nickName);
				if( data.image ) {
					myProfile.find('img').attr('src', data.image);
				} else {
					myProfile.find('img').attr('src',`//fiximage.10x10.co.kr/web2015/common/img_profile_${data.avataNo < 10 ? '0' : ''}${data.avataNo}.png`);
				}
			} else {
				myProfile.find('.nick_name').text('프로필 입력하기');
			}

			profileApp.closeProfileModal();
		}
		getFrontApiData('GET', '/user/profile', null, success);
	}

	function openProfileWriteModal() {
		profileApp.openProfileModal();
	}

	getMyProfile();
</script>
</div>