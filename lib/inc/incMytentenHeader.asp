<%

dim csMy10x10HeaderTitleGroupString : csMy10x10HeaderTitleGroupString = ""
dim csMy10x10HeaderTitleString : csMy10x10HeaderTitleString = ""

Select Case lcase(Request.ServerVariables("URL"))

	Case "/my10x10/order/myorderlist.asp", "/my10x10/order/myorderdetail.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑리스트"
		csMy10x10HeaderTitleString = "주문배송조회"

	Case "/my10x10/order/myshoporderlist.asp", "/my10x10/order/myshoporderdetail.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑리스트"
		csMy10x10HeaderTitleString = "주문배송조회"

	Case "/my10x10/order/order_info_edit_detail.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑리스트"
		csMy10x10HeaderTitleString = "주문정보변경"

	Case "/my10x10/order/order_cancel_detail.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑리스트"
		csMy10x10HeaderTitleString = "주문취소"

	Case "/my10x10/order/order_return_detail.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑리스트"
		csMy10x10HeaderTitleString = "반품/환불"

	Case "/my10x10/order/document_issue.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑리스트"
		csMy10x10HeaderTitleString = "증빙서류발급"

	Case "/my10x10/order/order_cslist.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑리스트"
		csMy10x10HeaderTitleString = "내가 신청한 서비스"

	Case "/my10x10/couponbook.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑혜택"
		csMy10x10HeaderTitleString = "쿠폰/보너스 쿠폰"

	Case "/my10x10/mymileage.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑혜택"
		csMy10x10HeaderTitleString = "마일리지 현황"

	case "/my10x10/mytencash.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑혜택"
		csMy10x10HeaderTitleString = "예치금 관리"

	Case "/my10x10/special_corner.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑혜택"
		csMy10x10HeaderTitleString = "우수회원 전용코너"

	Case "/my10x10/viplounge.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑혜택"
		csMy10x10HeaderTitleString = "VIP LOUNGE"

	Case "/my10x10/mileage_shop.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑혜택"
		csMy10x10HeaderTitleString = "마일리지샵"

	Case "/my10x10/special_info.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑혜택"
		csMy10x10HeaderTitleString = "회원혜택 안내"

	Case "/my10x10/mywishlist.asp"
		csMy10x10HeaderTitleGroupString = "MY 관심목록"
		csMy10x10HeaderTitleString = "위시"

	Case "/my10x10/myzzimbrand.asp"
		csMy10x10HeaderTitleGroupString = "MY 관심목록"
		csMy10x10HeaderTitleString = "찜브랜드"

	Case "/my10x10/myfavorite_dayand.asp"
		csMy10x10HeaderTitleGroupString = "MY 관심목록"
		csMy10x10HeaderTitleString = "관심 DAY&"

	case "/my10x10/myfavorite_play.asp"
		csMy10x10HeaderTitleGroupString = "MY 관심목록"
		csMy10x10HeaderTitleString = "관심 PLAY"

	Case "/my10x10/myfavoritecolor.asp"
		csMy10x10HeaderTitleGroupString = "MY 관심목록"
		csMy10x10HeaderTitleString = "Favorite 컬러"

	Case "/my10x10/myfavorite_event.asp"
		csMy10x10HeaderTitleGroupString = "MY 관심목록"
		csMy10x10HeaderTitleString = "관심 이벤트/컨텐츠"

	Case "/my10x10/mytodayshopping.asp"
		csMy10x10HeaderTitleGroupString = "MY 관심목록"
		csMy10x10HeaderTitleString = "최근 본 상품"

	Case "/my10x10/qna/myqnalist.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑활동"
		csMy10x10HeaderTitleString = "" & CHKIIF(IsVIPUser()=True,"VIP ","") &  "1:1 상담"

	Case "/my10x10/myitemqna.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑활동"
		csMy10x10HeaderTitleString = "상품 Q&amp;A"

	Case "/my10x10/goodsusing.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑활동"
		csMy10x10HeaderTitleString = "상품후기"

	Case "/my10x10/myeventmaster.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑활동"
		csMy10x10HeaderTitleString = "이벤트 당첨안내"

	Case "/my10x10/giftcard/", "/my10x10/giftcard/index.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑활동"
		csMy10x10HeaderTitleString = "GIFT 카드"

	Case "/my10x10/giftcard/giftcardOrderlist.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑활동"
		csMy10x10HeaderTitleString = "GIFT 카드 주문내역"

	case "/my10x10/giftcard/giftcardregist.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑활동"
		csMy10x10HeaderTitleString = "GIFT 카드 온라인 사용 등록 및 내역"

	Case "/my10x10/userinfo/confirmuser.asp", "/my10x10/userinfo/membermodify.asp"
		csMy10x10HeaderTitleGroupString = "MY 회원정보"
		csMy10x10HeaderTitleString = "개인정보 수정"

	case "/my10x10/myaddress/myaddresslist.asp"
		csMy10x10HeaderTitleGroupString = "MY 회원정보"
		csMy10x10HeaderTitleString = "나의 주소록"

	case "/my10x10/myanniversary/myanniversarylist.asp"
		csMy10x10HeaderTitleGroupString = "MY 회원정보"
		csMy10x10HeaderTitleString = "나의 기념일"

	Case "/my10x10/userinfo/withdrawal.asp"
		csMy10x10HeaderTitleGroupString = "MY 회원정보"
		csMy10x10HeaderTitleString = "회원탈퇴"
		
	Case "/my10x10/gift/talk.asp"
		csMy10x10HeaderTitleGroupString = "MY 관심목록"
		csMy10x10HeaderTitleString = "GIFT"

	case "/my10x10/order/order_myitemlist.asp"
		csMy10x10HeaderTitleGroupString = "MY 쇼핑활동"
		csMy10x10HeaderTitleString = "내가 구매한 상품"

	case "/my10x10/myalarmhistory.asp"
		csMy10x10HeaderTitleGroupString = "MY 관심목록"
		csMy10x10HeaderTitleString = "입고 알림 신청 내역"

	Case Else
		''
End Select

%>

<% '2013-08-27 이종화 추가 2012 menu_my10x10.asp 파일에 포함된 함수
Dim detailUrl, strMidNav
Dim MyOrdActType : MyOrdActType = "N"
'response.write getThisUrl
Select Case LCase(getThisUrl)
	Case "/my10x10/order/myorderdetail.asp"
		detailUrl = "/my10x10/order/myorderlist.asp"
	Case "/my10x10/order/myshoporderdetail.asp"
		detailUrl = "/my10x10/order/myshoporderlist.asp"
	Case "/my10x10/order/order_info_edit_detail.asp"
		detailUrl = "/my10x10/order/order_info_edit.asp"
		MyOrdActType = "E"
	Case "/my10x10/order/order_cancel_detail.asp"
		MyOrdActType = "C"
	Case "/my10x10/order/mycancelorderlist.asp", "/my10x10/order/mycancelorderdetail.asp"   '''취소된 주문건..?
		detailUrl = "/my10x10/order/order_cancel.asp"
	Case "/my10x10/order/order_return_detail.asp"
		detailUrl = "/my10x10/order/order_return.asp"
		MyOrdActType = "R"
	Case "/my10x10/myaddress/seaaddresslist.asp"
		detailUrl = "/my10x10/MyAddress/MyAddressList.asp"
	Case "/my10x10/userinfo/membermodify.asp"
		detailUrl = "/my10x10/userinfo/confirmuser.asp"
End Select

%>
			<div class="myHeader">
				<h2><a href="/my10x10/" title="MY 10X10 메인 페이지"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_my10x10.png" alt="MY 10X10" /></a></h2>
				<div class="breadcrumb">
					<a href="/" title="10X10 메인 페이지">HOME</a> &gt;
					<a href="/my10x10/" title="MY 10X10 메인 페이지">MY TENBYTEN</a>
					<% if (csMy10x10HeaderTitleGroupString <> "") then %>
					&gt; <%= csMy10x10HeaderTitleGroupString %> &gt; <strong><%= csMy10x10HeaderTitleString %></strong>
					<% end if %>
				</div>
			</div>