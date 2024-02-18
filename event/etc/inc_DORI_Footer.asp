<%
'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2

If application("Svr_Info") = "Dev" Then
	Select Case eCode
		Case "66147"
			snpTitle	= Server.URLEncode("쇼핑만 하면 귀여운 비치볼이 온다! 선착순이니 서둘러 주세요. 영화 <도리를 찾아서>가 함께 합니다!")
			snpLink		= Server.URLEncode("http://bit.ly/dori10x10_1")
			snpPre		= Server.URLEncode("텐바이텐")
			snpTag		= Server.URLEncode("텐바이텐")
			snpTag2		= Server.URLEncode("#텐바이텐 #도리를찾아서")
		Case "66148"
			snpTitle	= Server.URLEncode("매일 ‘도리를 찾아서’ 응모하면 시사회 초대권, 휴대폰케이스 등 선물이 가득! 까먹지 말고 꼭 만나요.")
			snpLink		= Server.URLEncode("http://bit.ly/dori10x10_2")
			snpPre		= Server.URLEncode("텐바이텐")
			snpTag		= Server.URLEncode("텐바이텐")
			snpTag2		= Server.URLEncode("#텐바이텐 #도리를찾아서")
		Case "66149"
			snpTitle	= Server.URLEncode("영화 <도리를 찾아서>의 귀여운 친구들이 트럼프카드, 휴대폰케이스에 쏙! 이 놀라운 상품들은 오직 텐바이텐에서!")
			snpLink		= Server.URLEncode("http://bit.ly/dori10x10_2")
			snpPre		= Server.URLEncode("텐바이텐/디즈니")
			snpTag		= Server.URLEncode("텐바이텐")
			snpTag2		= Server.URLEncode("#텐바이텐 #도리를찾아서")
	End Select
Else
	Select Case eCode
		Case "71110"
			snpTitle	= Server.URLEncode("쇼핑만 하면 귀여운 비치볼이 온다! 선착순이니 서둘러 주세요. 영화 <도리를 찾아서>가 함께 합니다!")
			snpLink		= Server.URLEncode("http://bit.ly/dori10x10_1")
			snpPre		= Server.URLEncode("텐바이텐")
			snpTag		= Server.URLEncode("텐바이텐")
			snpTag2		= Server.URLEncode("#텐바이텐 #도리를찾아서")
		Case "71111"
			snpTitle	= Server.URLEncode("매일 ‘도리를 찾아서’ 응모하면 시사회 초대권, 휴대폰케이스 등 선물이 가득! 까먹지 말고 꼭 만나요.")
			snpLink		= Server.URLEncode("http://bit.ly/dori10x10_2")
			snpPre		= Server.URLEncode("텐바이텐")
			snpTag		= Server.URLEncode("텐바이텐")
			snpTag2		= Server.URLEncode("#텐바이텐 #도리를찾아서")
		Case "71112"
			snpTitle	= Server.URLEncode("영화 <도리를 찾아서>의 귀여운 친구들이 트럼프카드, 휴대폰케이스에 쏙! 이 놀라운 상품들은 오직 텐바이텐에서!")
			snpLink		= Server.URLEncode("http://bit.ly/dori10x10_2")
			snpPre		= Server.URLEncode("텐바이텐/디즈니")
			snpTag		= Server.URLEncode("텐바이텐")
			snpTag2		= Server.URLEncode("#텐바이텐 #도리를찾아서")
	End Select	
End If
%>
		<div class="intro">
			<div class="inner">
				<div id="rolling" class="rolling">
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<iframe src="http://serviceapi.rmcnmv.naver.com/flash/outKeyPlayer.nhn?vid=776B75C9F93DD7C13D1FE75DA69B38681D3C&outKey=V128342fa5823e4a2d0a3994d9e29bba102c37f54388cb6d2c188994d9e29bba102c3&controlBarMovable=true&jsCallable=true&isAutoPlay=false&skinName=tvcast_white" width="598" height="344" frameborder="0" title="도리를 찾아서 예고편" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
								</div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_movie_02.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_movie_03.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_movie_04.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_movie_05.jpg" alt="" /></div>
							</div>
						</div>
						<div class="pagination"></div>
						<button type="button" class="btn-nav btn-prev">Previous</button>
						<button type="button" class="btn-nav btn-next">Next</button>
					</div>
				</div>

				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/txt_intro_v1.png" alt="도리를 찾아서! 내가 누구라고? 도리? 도리! 무엇을 상상하든 그 이상을 까먹는 도리의 어드벤쳐가 시작된다! 니모를 함께 찾으면서 베스트 프렌드가 된 도리와 말린은 우여곡절 끝에 다시 고향으로 돌아가 평화로운 일상을 보내고 있다. 모태 건망증 도리가 기억이라는 것을 하기 전까지! 도리는 깊은 기억 속에 숨어 있던 가족의 존재를 떠올리고 니모와 말린과 함께 가족을 찾아 대책 없는 어드벤쳐를 떠나게 되는데… 깊은 바다도 막을 수 없는 스펙터클한 어드벤쳐가 펼쳐진다!" /></p>
			</div>
		</div>

		<div class="shareSns">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/txt_sns.png" alt="친구에게도 이 놀라운 사실을 알려주자!" /></p>
			<ul>
				<li><a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/ico_twitter.png" alt="트위터에 텐바이텐 어드벤처 공유하기" /></a></li>
				<li><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/ico_facebook.png" alt="페이스북에 텐바이텐 어드벤처 공유하기" /></a></li>
			</ul>
		</div>