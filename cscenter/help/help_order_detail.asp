					<div class="helpSection">
						<h4><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_help.gif" alt="도움말 HELP" /></h4>
						<ul class="list">
							<li>주문의 진행상태에 따라 수정가능여부가 달라집니다.</li>
							<li>[상품 확인 중] 단계시까지는 WEB에서 바로변경이 가능하며, [상품 포장 중]상태일 경우나 취소를 원하실 경우에는<br /> 1:1상담문의를 통해 변경요청을 하시거나, 고객센터로 연락 부탁드립니다.</li>
							<li>이니셜 등 제작상품의 제작문구는 주문확인 후 바로 작업이 되기 때문에, [상품 포장 중]상태에서 변경이 불가능할 수 있습니다.</li>
						</ul>

						<ol class="orderProcess step5">
							<li class="receipt">
								<strong>결제 대기 중</strong>
								<p>입금을 기다리고 있습니다.<br /> 3일 내 미입금시 자동으로<br /> 주문이 취소됩니다.</p>
							</li>
							<li class="payment">
								<strong>결제 완료</strong>
								<p>주문하신 상품의<br /> 결제가 완료되었습니다.</p>
							</li>
							<li class="inform">
								<strong>상품 확인 중</strong>
								<p>주문이 접수 되었으며<br /> 상품의 재고 및 상태를<br /> 꼼꼼하게 확인합니다.</p>
							</li>
							<li class="preparation">
								<strong>상품 포장 중</strong>
								<p>재고 및 상태 확인 후<br /> 안전한 배송을 위해<br /> 상품을 포장합니다.</p>
							</li>
							<li class="release last">
								<strong>배송 시작</strong>
								<p>포장 완료 후 배송을 위해<br /> 상품이 배송사로<br /> 전달되었습니다.</p>
							</li>
						</ol>
						<% If vIsInterparkTravelExist = True Then %>
							<ul class="list tMar30">
								<li>여행상품의 경우, 특별약관이 적용되오니 자세한 내용은 상품 상세 페이지를 확인해 주세요.<br />여행상품 취소시 국외여행표준약관 제 15조 소비자분쟁해결규정에 따라 취소료가 부과될 수 있습니다.</li>
							</ul>
							<ol class="orderProcess step5">
								<li class="receipt">
									<strong>결제 대기 중</strong>
									<p>입금전 상태입니다.<br /> 7일 이내 미입금시 자동취소<br /> (Mail 및 SMS 발송)</p>
								</li>
								<li class="payment">
									<strong>결제 완료</strong>
									<p>고객님의 결제 내역<br /> 확인이 완료되었습니다.<br /> (Mail 및 SMS 발송)</p>
								</li>
								<li class="happycall">
									<strong>해피콜</strong>
									<p>결제 후 72시간내에 진행되며, <br />여행자 정보 및 여권사본을 <br />전달해 주세요.</p>
								</li>
								<li class="issue">
									<strong>발권</strong>
									<p>전달주신 정보로 발권 및 <br />예약을 진행합니다.<br />(발권 이후 취소/변경 <br />수수료부과)</p>
								</li>
								<li class="abroad last">
									<strong>여행 출발</strong>
									<p>즐거운 여행 <br />되시기 바랍니다.</p>
								</li>
							</ol>
						<% End If %>
					</div>