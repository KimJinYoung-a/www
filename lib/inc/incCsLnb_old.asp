				<div class="lnbWrap">
					<ul class="lnb">
						<li><a href="/cscenter/faq/faqList.asp?selectfaq=1"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/lnb_faq_01.gif" alt="주문 FAQ" /></a>
							<ul>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F001" title="주문/결제">주문/결제</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F002" title="배송">배송</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F003" title="주문변경/취소">주문변경/취소</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F004" title="반품/교환/AS">반품/교환/AS</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F005" title="환불">환불</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F006" title="증빙서류">증빙서류</a></li>
							</ul>
						</li>
						<li><a href="/cscenter/faq/faqList.asp?selectfaq=2"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/lnb_faq_02.gif" alt="회원 FAQ" /></a>
							<ul>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F007" title="회원정보">회원정보</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F008" title="텐바이텐 멤버십">텐바이텐 멤버십</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F016" title="텐바이텐 멤버십카드">텐바이텐 멤버십카드</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F009" title="결제방법">결제방법</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F010" title="마일리지/상품쿠폰/할인권">마일리지/상품쿠폰/할인권</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F011" title="상품문의">상품문의</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F012" title="이벤트/사은품">이벤트/사은품</a></li>
							</ul>
						</li>
						<li><a href="/cscenter/faq/faqList.asp?selectfaq=3"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/lnb_faq_03.gif" alt="기타 FAQ" /></a>
							<ul>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F013" title="오프라인">오프라인</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F014" title="사이트이용/장애">사이트이용/장애</a></li>
								<li><a href="/cscenter/faq/faqList.asp?divcd=F015" title="기타">기타</a></li>
							</ul>
						</li>
					</ul>

					<ul class="aside">
						<li><a href="/cscenter/membershipGuide/" title="회원혜택 안내"><span>회원혜택 안내</span></a></li>
						<li><a href="/offshop/point/card_service.asp" title="멤버십카드 안내"><span>멤버십카드 안내</span></a></li>
						<li><a href="/giftcard/" title="기프트카드 안내"><span>기프트카드 안내</span></a></li>
						<li><a href="/gift/gifticon/" title="기프티콘 상품 교환"><span>기프티콘 상품 교환</span></a></li>
						<% If now() < #07/31/2019 12:00:00# Then %>
							<li><a href="/event/etc/baroquick/" title="바로배송 안내"><span>바로배송 안내</span></a></li>
						<% End If %>
						<li><a href="/cscenter/oversea/emsIntro.asp" title="해외배송 안내"><span>해외배송 안내</span></a></li>
						<li><a href="/offshop/index.asp" title="매장안내"><span>매장안내</span></a></li>
					</ul>

					<p class="findDepositor" onclick="window.open('/common/online_banking_list.asp', 'popDepositor', 'width=395, height=685, scrollbars=yes'); return false;" title="입금자를 찾습니다"><strong>입금자를 찾습니다.</strong></p>

					<div class="csInfo">
						<%'// 대표님 지시로 인한 cs 전화번호 임시 비노출 2020-10-16 %>
						<% If left(now(),10)>="2022-01-01" Then %>
							<strong><img src="http://fiximage.10x10.co.kr/web2013/cscenter/txt_cs_tel.gif" alt="1644-6030" /></strong>
							<a href="mailto:customer@10x10.co.kr" class="crRed"><strong>customer@10x10.co.kr</strong></a>
							<p><strong>오전 10시 ~ 오후 5시</strong> (점심시간:오후 12시 30분~1시 30분)<br /> 토, 일, 공휴일 휴무</p>
						<% Else %>
							<a href="mailto:customer@10x10.co.kr" class="crRed"><strong>customer@10x10.co.kr</strong></a>
						<% End If %>
					</div>
				</div>