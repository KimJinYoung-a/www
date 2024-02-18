<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/badgelib.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myTenbytenInfoCls.asp" -->
<%

dim returnStr, i
if IsUserLoginOK() and GetLoginUserID() <> "" then
	if (Not MyBadge_IsExist_LoginDateCookie()) then

		Call MyBadge_CheckInsertBadgeLog(GetLoginUserID(), "0001", "", "", "")

		returnStr = MyBadge_GetNewObtainedBadge(GetLoginUserID())

	else
		returnStr = MyBadge_GetNewObtainedBadge(GetLoginUserID())
	end if

	if returnStr = "" then
		dbget.Close
		response.end
	end if

	returnStr = Split(returnStr, ",")

	dim firstBadgeShowed : firstBadgeShowed = False

%>

<!-- 마이뱃지 Layer Popup -->
<div id="myBadgeLyrPopup" class="window myBadgeLyr" style="width:586px;">
	<div class="popTop pngFix"><div class="pngFix"></div></div>
	<div class="popContWrap pngFix">
		<div class="popCont pngFix">
			<div class="popHead">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/common/tit_congratulations.jpg" alt="CONGRATULATIONS!" /></h2>
				<p class="lyrClose"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_pop_close.png" alt="닫기" /></p>
			</div>
			<div class="popBody">
				<div class="myBadgeCont">
					<p class="congratulation"><strong>축하합니다!</strong></p>
					<p>새로운 뱃지 <em class="crRed"><%= (UBound(returnStr) + 1) %>개</em>를 획득하셨습니다.</p>

					<div class="myBadgeList">
						<ul>
	<%
	for i = 0 to UBound(returnStr)
		Select Case returnStr(i)
			Case "1"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_01.gif" alt="슈퍼 코멘터" />
								</div>
								<strong class="name">슈퍼 코멘터</strong>
								<p class="account">상품 퀄리티는 내가 정한다!<br />상품 후기를 작성하는 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "2"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_02.gif" alt="기프트 초이스" />
								</div>
								<strong class="name">기프트 초이스</strong>
								<p class="account">마음이 따뜻한 사람!<br />선물을 잘 고르는 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "3"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_03.gif" alt="위시 메이커" />
								</div>
								<strong class="name">위시 메이커</strong>
								<p class="account">나는 위시 메이커!<br />위시 컬렉션을 이용하는 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "4"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_04.gif" alt="포토 코멘터" />
								</div>
								<strong class="name">포토 코멘터</strong>
								<p class="account">상품만족도는 내 손으로! 찰칵!<br />포토 후기를 작성하는 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "5"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_05.gif" alt="브랜드 쿨" />
								</div>
								<strong class="name">브랜드 쿨!</strong>
								<p class="account">좋아하는 브랜드가 확실한 사람!<br />선호하는 브랜드가 확실한 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "6"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_06.gif" alt="얼리버드" />
								</div>
								<strong class="name">얼리버드</strong>
								<p class="account">신상품의 귀재!<br />신상품을 자주 구입하는 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "7"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_07.gif" alt="세일헌터" />
								</div>
								<strong class="name">세일헌터</strong>
								<p class="account">찜 한 상품은 놓치지 않는다!<br /> 현명한 소비를 하는 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "8"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_08.gif" alt="스타일리스트" />
								</div>
								<strong class="name">스타일리스트</strong>
								<p class="account">타고난 스타일 감각!<br />엣지 있는 스타일을 가진 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "9"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_09.gif" alt="컬러홀릭" />
								</div>
								<strong class="name">컬러홀릭</strong>
								<p class="account">나만의 컬러가 확실한 사람!<br />컬러를 사랑하는 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "10"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_10.gif" alt="텐텐 트윅스" />
								</div>
								<strong class="name">텐텐 트윅스</strong>
								<p class="account">텐바이텐이 좋아요!<br />텐바이텐에 자주 방문한 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "11"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_11.gif" alt="카테고리 마스터" />
								</div>
								<strong class="name">카테고리 마스터</strong>
								<p class="account">좋아하는 카테고리가 확실한 사람!<br />선호 카테고리가 확실한 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "12"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_12.gif" alt="톡 엔젤" />
								</div>
								<strong class="name">톡! 엔젤</strong>
								<p class="account">타고난 쇼핑멘토!<br />쇼핑톡 고민을 해결해준 텐텐피플을 위한 뱃지</p>
							</li>
	<%
			Case "13"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_13.gif" alt="10월 스페셜" />
								</div>
								<strong class="name">10월 스페셜 뱃지</strong>
								<p class="account">10월 리뉴얼 빙고 이벤트 미션 CLEAR!<br />11월, 12월 스페셜 뱃지에도 도전하세요!<br />2014년 1월, 시크릿 선물을 보내 드립니다.</p>
							</li>
		<%
			Case "14"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_14.gif" alt="11월 스페셜" />
								</div>
								<strong class="name">11월 스페셜 뱃지</strong>
								<p class="account">11월 컬쳐 페스티벌 이벤트 미션 CLEAR!<br />12월 스페셜 뱃지에도 도전하세요!<br />2014년 1월, 시크릿 선물을 보내 드립니다.</p>
							</li>
	<%
			Case "15"
	%>
							<li <% if firstBadgeShowed then %>style="display:none"<% end if %> >
								<div class="ico">
									<img src="http://fiximage.10x10.co.kr/web2013/common/ico_my_badge_15.gif" alt="12월 스페셜" />
								</div>
								<strong class="name">12월 스페셜 뱃지</strong>
								<p class="account">12월 보글보글 , 떡만둣국 이벤트 미션 CLEAR!<br />2014년 1월, 시크릿 선물을 보내 드립니다.</p>
							</li>
	<%
			Case Else
				''
		End Select

		if Not firstBadgeShowed then
			firstBadgeShowed = True
		end if
	next

	%>
						</ul>
						<button type="button" id="myBadgePrevBtn" class="prevBtn" <% if (UBound(returnStr) = 0) then %>style="display:none"<% end if %> >이전</button>
						<button type="button" id="myBadgeNextBtn" class="nextBtn" <% if (UBound(returnStr) = 0) then %>style="display:none"<% end if %> >다음</button>
					</div>
				</div>
			</div>
			<div class="btnGo"><a href="/my10x10/index.asp"><strong>뱃지 확인하러 가기</strong></a></div>
		</div>
	</div>
</div>
<!-- //마이뱃지 Layer Popup -->

<%

end if

%>

<!-- #include virtual="/lib/db/dbclose.asp" -->
