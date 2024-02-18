<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/cscenter/boardfaqcls.asp" -->
			<%
				dim faqDiv, fgLoop
				set faqDiv = New CBoardFAQ
				faqDiv.getFAQDivList
			%>
				<div class="lnbWrap">
					<ul class="lnb">
						<li>
							<a href="/cscenter/faq/faqList.asp"><strong>FAQ 안내</strong></a>
							<ul>
							<%
								for fgLoop=0 to faqDiv.FResultCount-1
									Response.Write "<li><a href=""/cscenter/faq/faqList.asp?divcd=" & faqDiv.FItemList(fgLoop).FcommCd & """ title=""" & faqDiv.FItemList(fgLoop).Fcomm_name & """>" & faqDiv.FItemList(fgLoop).Fcomm_name & "</a></li>"
								Next
							%>
							</ul>
						</li>
					</ul>
			<%	set faqDiv = Nothing %>
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