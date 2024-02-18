<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 개인정보 취급방침"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

%>
<!-- #include virtual="/lib/inc/head.asp" -->
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="csContent">
				<!-- #include virtual="/lib/inc/incCsLnb.asp" -->

				<!-- content -->
				<div class="content">
					<h3 id="individual" class="line"><img src="http://fiximage.10x10.co.kr/web2013/common/tit_individual_information.gif" alt="개인정보 취급방침" /></h3>
					<div class="anchorNav">
						<ul class="tPad30">
							<li><a href="#individual1">- 제 1조 (총칙)</a></li>
							<li><a href="#individual2">- 제 2조 (수집하는 개인정보 항목 및 수집방법)</a></li>
							<li><a href="#individual3">- 제 3조 (개인정보의 수집목적 및 이용 목적)</a></li>
							<li><a href="#individual4">- 제 4조 (개인정보의 공유 및 제공)</a></li>
							<li><a href="#individual5">- 제 5조 (수집한 개인정보 취급 위탁)</a></li>
							<li><a href="#individual6">- 제 6조 (개인정보의 보유, 이용기간)</a></li>
							<li><a href="#individual7">- 제 7조 (개인정보의 파기 절차)</a></li>
							<li><a href="#individual8">- 제 8조 (개인정보 처리를 위한 기술적, 관리적 대책)</a></li>
							<li><a href="#individual9">- 제 9조 (링크사이트)</a></li>
						</ul>
						<ul class="wide tPad30">
							<li><a href="#individual9">- 제 9조 (링크사이트)</a></li>
							<li><a href="#individual10">- 제 10조 (게시물)</a></li>
							<li><a href="#individual11">- 제 11조 (이용자의 권리와 의무)</a></li>
							<li><a href="#individual12">- 제 12조 (이용자 및 법정 대리인의 권리와 그 행사방법)</a></li>
							<li><a href="#individual13">- 제 13조 (개인정보 자동 수집 장치의 설치, 운영 및 그 거부에 관한 사항)</a></li>
							<li><a href="#individual14">- 제 14조 (개인정보 보호문의처)</a></li>
							<li><a href="#individual15">- 제 15조 (개인정보보호책임자 및 담당자)</a></li>
							<li><a href="#individual16">- 제 16조 (광고성 정보 전송)</a></li>
							<li><a href="#individual17">- 제 17조 (고지의 의무)</a></li>
						</ul>
					</div>

					<div class="articleSection">
						<h4 id="individual1" class="tPad0">제 1조 (총칙) </h4>
						<p>1. 개인정보란 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는 성명, 주민등록번호 등의 사항에 의하여 당해 개인을 알아볼 수 있는 부호,문자,음성,음향 및 영상 등의 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함합니다)를 말합니다.</p>
						<p>2. (주)텐바이텐(“회사” 또는 “텐바이텐”이라 함)은 이용자의 개인정보보호를 매우 중요시하며, 「개인정보보호법」,「정보통신망 이용 촉진 및 정보보호에 관한 법률」 등 개인정보보호 관련 법률 및 하위 법령들을 준수하고 있습니다.</p>
						<p>3. 회사는 개인정보취급방침을 통하여 이용자가 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다. 회사는 개인정보취급방침을 홈페이지 하단에 공개함으로써 언제나 용이하게 보실 수 있습니다</p>
						<p>4. 회사는 개인정보취급방침의 지속적인 개선을 위하여 개정하는데 필요한 절차를 정하고 있으며, 개인정보취급방침을 회사의 필요와 사회적 변화에 맞게 변경할 수 있습니다.</p>
						<p>5. 본 개인정보취급방침은 텐바이텐이 제공하는 서비스(모바일 웹/앱 포함) 이용에 적용됩니다.</p>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual2">제 2조 (수집하는 개인정보 항목 및 수집방법)</h4>
						<p>1. 수집하는 개인정보의 항목</p>
						<ul>
							<li>
								① 회사는 회원가입시 원할한 고객상담, 각종 서비스의 제공을 위해 아래와 같은 최소한의 개인정보를 필수항목을 수집하고 있습니다.
								<p>- 아이디, 비밀번호, 이름, 성별, 생년월일, 이메일주소, 휴대폰번호, 가입인증정보</p>
							</li>
							<li>② 서비스 이용과정이나 사업 처리과정에서 아래와 같은 정보들이 생성되어 수집될 수 있습니다.
								<ul>
									<li>- 최근접속일, 접속 IP 정보, 쿠키, 구매로그, 이벤트로그</li>
									<li>- 물품 주문시 : 이메일주소, 전화번호, 휴대폰번호, 주소</li>
									<li>- 물품(서비스)구매에 대한 결제 및 환불시 : 은행계좌정보</li>
									<li>- 개인맞춤서비스 이용시 : 주소록, 기념일</li>
								</ul>
							</li>
						</ul>
						<p>2. 개인정보 수집방법<br />회사는 다음과 같은 방법으로 개인정보를 수집합니다.</p>
						<ol>
							<li>① 홈페이지, 서면양식, 팩스, 전화, 상담 게시판, 이메일, 이벤트 응모, 배송요청</li>
							<li>② 협력회사로부터의 제공</li>
							<li>③ 로그 분석 프로그램을 통한 생성정보 수집</li>
						</ol>
						<p>3. 개인정보 수집에 대한 동의</p>
						<p>회사는 귀하께서 텐바이텐의 개인정보취급방침 및 이용약관의 내용에 대해 「동의한다」버튼 또는 「동의하지 않는다」버튼을 클릭할 수 있는 절차를 마련하여, 「동의한다」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다. 「동의안함」을 선택하실 경우, 회사가 제공하는 기본서비스 제공이 제한됩니다.</p>
						<p>4. 14세 미만 아동의 개인정보보호</p>
						<p>회사는 법정 대리인의 동의가 필요한 만14세 미만 아동의 회원가입은 받고 있지 않습니다.</p>
						<p>5. 비회원의 개인정보보호</p>
						<ol>
							<li>① 회사는 비회원 주문의 경우에도 배송, 대금결제, 주문내역 조회 및 구매확인을 위하여 필요한 개인정보만을 요청하고 있으며, 이 경우 그 정보는 대금결제 및 상품의 배송에 관련된 용도 이외에는 다른 어떠한 용도로도 사용되지 않습니다.</li>
							<li>② 회사는 비회원의 개인정보도 회원과 동등한 수준으로 보호합니다.</li>
						</ol>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual3">제 3조 (개인정보의 수집목적 및 이용 목적)</h4>
						<ul>
							<li>① 회원제 서비스 이용에 따른 본인 식별 절차에 이용</li>
							<li>② 고지사항 전달, 본인 의사 확인, 불만 처리 등 원활한 의사소통 경로의 확보, 새로운 서비스, 신상품이나 이벤트 정보 등 최신 정보의 안내</li>
							<li>③ 쇼핑 물품 배송에 대한 정확한 배송지의 확보</li>
							<li>④ 개인맞춤 서비스를 제공하기 위한 자료</li>
							<li>⑤ 경품 수령 및 세무신고를 위한 별도의 개인정보 요청</li>
						</ul>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual4">제 4조 (개인정보의 공유 및 제공)</h4>
						<p>1. 회사는 귀하의 개인정보를 「개인정보의 수집목적 및 이용목적」에서 고지한 범위내에서 사용하며, 동 범위를 초과하여 이용하거나 타인 또는 타기업, 기관에 제공하지 않습니다.</p>
						<p>2. 단, 다음은 예외로 합니다.</p>
						<ul>
							<li>① 관계법령에 의하여 수사상의 목적으로 관계기관으로부터의 요구가 있을 경우</li>
							<li>② 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우</li>
							<li>③ 이용자들이 사전에 동의한 경우</li>
						</ul>
						<p>3. 그러나 예외사항에서도 관계법령에 의하거나 수사기관의 요청에 의해 정보를 제공한 경우에는 이를 당사자에게 고지하는 것을 원칙으로 운영하고 있습니다. 법률상의 근거에 의해 부득이하게 고지를 하지 못할 수도 있습니다. 본래의 수집목적 및 이용목적에 반하여 무분별하게 정보가 제공되지 않도록 최대한 노력하겠습니다.</p>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual5">제 5조 (수집한 개인정보 취급 위탁)</h4>
						<p>회사는 서비스 향상을 위해서 귀하의 개인정보가 필요한 경우 동의 등 법률상의 요건을 구비하여 외부에 수집, 취급, 관리등을 위탁하여 처리할 수 있으며, 개인정보의 처리와 관련하여 아래와 같이 업무를 위탁하고 있으며, 관계 법령에 따라 위탁계약시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다. 또한 공유하는 정보는 당해 목적을 달성하기 위하여 필요한 최소한의 정보에 국한됩니다. 하기 수탁자 전체에 개인정보가 제공되는 사항은 아니며, 고객님의 서비스 요청에 따라 해당하는 업체에 선택적으로 제공됩니다.</p>
						<div class="boardList tPad20 bPad10">
							<table>
							<caption>수집한 개인정보 취급 위탁</caption>
							<colgroup>
							<col width="40%" /> <col width="60%" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">수탁자</th>
								<th scope="col">수탁범위</th>
							</tr>
							</thead>
							<tbody>
							<tr>
							<td>이니시스, KCP, LG U+</td>
							<td>상품구매에 필요한 신용카드, 현금결제 등의 결제정보전송</td>
							</tr>
							<tr>
							<td>인포뱅크, LG U+</td>
							<td>문자메세지 전송</td>
							</tr>
							<tr>
							<td>NICE평가정보(주), 한국모바일인증(주)</td>
							<td>실명/본인인증, 아이핀제공</td>
							</tr>
							<tr>
							<td>카카오톡</td>
							<td>카카오톡 맞춤정보서비스를 위한 사용자 휴대폰번호 확인</td>
							</tr>
							<tr>
							<td>CJ대한통운</td>
							<td>주문 상품의 배송</td>
							</tr>
							<tr>
							<td>입점업체</td>
							<td>주문 상품의 배송</td>
							</tr>
							</tbody>
							</table>
						</div>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual6">제 6조 (개인정보의 보유, 이용기간) </h4>
						<p>1. 귀하의 개인정보는 회사가 신청인에게 서비스를 제공하는 기간 동안에 한하여 보유하고 이를 활용합니다. 다만 다른 법률에 특별한 규정이 있는 경우에는 관계법령에 따라 보관합니다. </p>
						<div class="boardList tPad20 bPad10">
							<table>
							<caption>개인정보의 보유, 이용기간</caption>
							<colgroup>
							<col width="50%" /> <col width="50%" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">개인정보</th>
								<th scope="col">파기시점</th>
							</tr>
							</thead>
							<tbody>
							<tr>
							<td>회원가입정보</td>
							<td>회원가입을 탈퇴하거나 회원에 제명된 때</td>
							</tr>
							<tr>
							<td>대금지급정보</td>
							<td>대금의 완제일 또는 채권소명시효기간이 만료된 때</td>
							</tr>
							<tr>
							<td>배송정보</td>
							<td>물품 또는 서비스가 인도되거나 제공된 때</td>
							</tr>
							<tr>
							<td>설문조사, 이벤트 등 일시적 목적을 위하여 수집한 경우</td>
							<td>당해 설문조사, 이벤트 등이 종료한 때</td>
							</tr>
							</tbody>
							</table>
						</div>
						<p>2. 위 개인정보 수집목적 달성시 즉시파기 원칙에도 불구하고 다음과 같이 거래 관련 권리 의무 관계의 확인 등을 이유로 일정기간 보유하여야 할 필요가 있을 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등에 근거하여 일정기간 보유합니다.</p>
						<ul>
							<li>① 「전자상거래 등에서의 소비자보호에 관한 법률」에 의한 보관
								<ul>
									<li>- 계약 또는 청약철회 등에 관한 기록 : 5년</li>
									<li>- 대금결제 및 재화 등의 공급에 관한 기록 : 5년</li>
									<li>- 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년</li>
								</ul>
							</li>
							<li>② 「통신비밀보호법」 시행령 제41조에 의한 통신사실확인자료 보관
								<p>- 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월</p>
							</li>
							<li>③ 설문조사, 이벤트 등 일시적 목적을 위하여 수집한 경우 : 당해 설문조사, 이벤트 등의 종료 시점</li>
						</ul>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual7">제 7조 (개인정보의 파기 절차)</h4>
						<p>회사는 원칙적으로 개인정보 수집 및 이용목적이 달성되면 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.</p>
						<ul>
							<li>1. 파기절차
								<ol>
									<li>① 귀하가 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(제6조 개인정보의 보유, 이용기간 참조) 일정 기간 저장된 후 파기되어집니다. </li>
									<li>② 동 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다.</li>
								</ol>
							</li>
							<li>2. 파기방법
								<ol>
									<li>① 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.</li>
									<li>② 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.</li>
								</ol>
							</li>
						</ul>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual8">제 8조 (개인정보 처리를 위한 기술적, 관리적 대책)</h4>
						<h5>1. 기술적 대책</h5>
						<p>텐바이텐은 귀하의 개인정보를 처리함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안정성 확보를 위하여 다음과 같은 기술적 대책을 강구하고 있습니다.</p>
						<ul>
							<li>① 회사는 방화벽(Fire Wall)과 Nescape사의 채널보안방식인 SSL(Secure Socket Layer)방식 암호화 체계 시스템 등을 갖추어 개인정보 보호에 만전을 기하고 있습니다.</li>
							<li>② 귀하의 개인정보는 비밀번호에 의해 보호되며, 파일 및 전송 데이터를 암호화하거나 파일 잠금기능(Lock)을 사용하여 중요한 데이터는 별도의 보안기능을 통해 보호되고 있습니다.</li>
							<li>③ 회사는 백신프로그램을 이용하여 컴퓨터바이러스에 의한 피해를 방지하기 위한 조치를 취하고 있습니다. 백신프로그램은 주기적으로 업데이트되며 갑작스런 바이러스가 출현할 경우 백신이 나오는 즉시 이를 제공 함으로써 개인정보가 침해되는 것을 방지하고 있습니다.</li>
						</ul>
						<h5>2. 관리적 대책</h5>
						<ol>
							<li>① 회사는 귀하의 개인정보에 대한 접근 권한을 최소한의 인원으로 제한하며, 개인정보를 취급하는 직원을 대상으로 새로운 보안 기술 습득 및 개인정보 보호 의무 등에 관해 정기적인 사내교육 및 외부 위탁교육을 실시하고 있습니다.</li>
							<li>② 입사 시 전 직원의 보안서약서를 통하여 사람에 의한 정보유출을 사전에 방지하고 개인정보처리방침에 대한 이행사항 및 직원의 준수여부를 감사하기 위한 내부절차를 마련하고 있습니다.</li>
							<li>③ 개인정보 관련 처리자의 업무 인수인계는 보안이 유지된 상태에서 철저하게 이뤄지고 있으며 입사 및 퇴사 후 개인정보 사고에 대한 책임을 명확화하고 있습니다.</li>
							<li>④ 전산실 및 자료 보관실 등을 특별 보호구역으로 설정하여 출입을 통제하고 있습니다.</li>
							<li>⑤ 회사는 이용자 개인의 실수나 기본적인 인터넷의 위험성 때문에 일어나는 일들에 대해 책임을 지지 않습니다. 회원 개개인이 본인의 개인정보를 보호하기 위해서 자신의 ID 와 비밀번호를 적절하게 관리하고 여기에 대한 책임을 져야 합니다.</li>
							<li>⑥ 그 외 내부 관리자의 실수나 기술관리 상의 사고로 인해 개인정보의 상실, 유출, 변조, 훼손이 유발될 경우 회사는 즉각 귀하께 사실을 알리고 적절한 대책과 보상을 강구할 것입니다. </li>
						</ol>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual9">제 9조 (링크사이트) </h4>
						<ol>
							<li>1. 회사는 귀하께 다른 회사의 웹사이트 또는 자료에 대한 링크를 제공할 수 있습니다. 이 경우 텐바이텐은 외부사이트 및 자료에 대한 아무런 통제권이 없으므로 그로부터 제공받는 서비스나 자료의 유용성에 대해 책임질 수 없으며 보증할 수 없습니다.</li>
							<li>2. 텐바이텐이 포함하고 있는 링크를 클릭(Click)하여 타 사이트(Site)의 페이지로 옮겨갈 경우 해당 사이트의 개인정보처리방침은 텐바이텐과 무관하므로 새로 방문한 사이트의 정책을 검토해 보시기 바랍니다.</li>
						</ol>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual10">제 10조 (게시물)</h4>
						<p>1. 회사는 귀하의 게시물을 소중하게 생각하여 변조, 훼손, 삭제되지 않도록 최선을 다하여 보호합니다. 그러나 다음의 경우는 그렇지 아니합니다.</p>
						<ol>
							<li>① 스팸(spam)성 게시물 및 상업성 게시물 (예: 행운의 편지, 특정사이트 광고 등)</li>
							<li>② 타인을 비방할 목적으로 허위 사실을 유포하여 타인의 명예를 훼손하는 글</li>
							<li>③ 동의 없는 타인의 신상공개, 제3자의 저작권 등 권리를 침해하는 내용, 기타 게시판 주제와 다른 내용의 게시물</li>
						</ol>
						<p>2. 회사는 바람직한 게시판 문화를 활성화하기 위하여 동의 없는 타인의 신상 공개 시 특정부분 이동 경로를 밝혀 오해가 없도록 하고 있습니다. 그 외의 경우 명시적 또는 개별적인 경고 후 삭제 조치할 수 있습니다.</p>
						<p>3. 근본적으로 게시물에 관련된 제반 관리와 책임은 작성자 개인에게 있습니다. 또 게시물을 통해 자발적으로 공개된 정보는 보호받기 어려우므로 정보 공개 전에 심사 숙고하시기 바랍니다.</p>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual11">제 11조 (이용자의 권리와 의무)</h4>
						<p>1. 귀하의 개인정보를 최신의 상태로 정확하게 입력하여 불의의 사고를 예방해 주시기 바랍니다. 귀하가 입력한 부정확 한 정보로 인해 발생하는 사고의 책임은 이용자 자신에게 있으며 타인 정보의 도용 등 허위정보를 입력할 경우 회원 자격이 상실될 수 있습니다.</p>
						<p>2. 귀하는 개인정보를 보호받을 권리와 함께 스스로를 보호하고 타인의 정보를 침해하지 않을 의무도 가지고 있습니다. 비밀번호를 포함한 귀하의 개인정보가 유출되지 않도록 조심 하시고 게시물을 포함한 타인의 개인정보를 훼손하지 않도록 유의해 주십시오. 만약 이 같은 책임을 다하지 못하고 타인의 정보 및 존엄성을 훼손할 시에는 ‘정보통신망이용 촉진및정보보호등에관한법률’ 등에 의해 처벌받을 수 있습니다. </p>
						<p>3. 온라인상에서(게시판, E-mail, 또는 채팅 등) 귀하가 자발적으로 제공하는 개인정보는 다른 사람들이 수집하여 사용할 수 있음을 항상 유념하시기 바랍니다. 즉, 공개적으로 접속할 수 있는 온라인상에서 개인정보를 게재하는 경우, 다른 사람들로부터 원치 않는 메시지를 답장으로 받게 될 수도 있음을 의미합니다.</p>
						<p>4. 공공장소에서 이용할 때에는 자신의 비밀번호가 노출되지 않도록 하고 서비스 이용을 마친 후에는 반드시 로그아웃을 해주시기 바랍니다.</p>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual12">제 12조 (이용자 및 법정 대리인의 권리와 그 행사방법) </h4>
						<p>1. 귀하는 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며 가입해지를 요청할 수도 있습니다.</p>
						<p>2. 귀하의 개인정보 조회, 수정 또는 가입해지를 위해서는 「MY 개인정보」버튼을 클릭하여 본인확인 절차를 거치신 후 직접 열람, 정정 또는 탈퇴가 가능합니다. 혹은 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체 없이 조치하겠습니다.</p>
						<p>3. 회사는 귀하의 요청에 의해 해지 또는 삭제된 개인정보는 “제 6조 개인정보의 보유, 이용기간”에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.</p>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual13">제 13조 (개인정보 자동 수집 장치의 설치, 운영 및 그 거부에 관한 사항)</h4>
						<p>1. 쿠키(cookie)란?</p>
						<ol>
							<li>① 회사는 귀하에 대한 정보를 저장하고 수시로 찾아내는 쿠키(cookie)를 사용합니다</li>
							<li>② 쿠키는 웹사이트가 귀하의 컴퓨터 브라우저(Internet Explorer, Chrome, Safari, Firefox 등)로 전송하는 소량의 정보입니다. 귀하께서 웹사이트에 접속을 하면 회사의 서버는 귀하의 브라우저에 추가정보를 임시로 저장하여 접속에 따른 성명 등의 추가 입력 없이 회사의 서비스를 제공할 수 있습니다.</li>
						</ol>
						<p>2. 회사는 다음과 같은 목적을 위해 쿠키를 통하여 수집된 이용자의 개인정보를 사용합니다.</p>
						<ol>
							<li>① 개인의 관심 분야에 따라 차별화된 정보를 제공 </li>
							<li>② 쇼핑한 품목들에 대한 정보와 장바구니 서비스를 제공 </li>
							<li>③ 회원과 비회원의 접속빈도 또는 머문 시간 등을 분석하여 서비스 개편 및 마케팅에 활용</li>
						</ol>
						<p>3. 쿠키의 설치 및 거부</p>
						<ol>
							<li>① 귀하는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서 귀하는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다</li>
							<li>② 다만, 쿠키의 저장을 거부할 경우에는 로그인이 필요한 텐바이텐 일부 서비스는 이용에 어려움이 있을 수 있습니다. </li>
							<li>③ 쿠키 설치 허용 여부를 지정하는 방법
								<ul>
									<li>- Internet Explorer의 경우 : [도구] 메뉴에서 [인터넷 옵션]을 선택 &rarr; [개인정보]를 클릭 &rarr; [고급]을 클릭 &rarr; 쿠키 허용여부를 선택</li>
									<li>- Safari의 경우 :MacOS 상단 좌측 메뉴바에서 [Safari]에서 [환경설정]을 선택 &rarr; [환경설정] 창에서 [보안]으로 이동하여 쿠키 허용여부 선택 </li>
									<li>- Chrome의 경우 : 웹 브라우저 우측상단 메뉴에서 [설정] 선택 &rarr; [고급설정표시]선택 &rarr; 개인정보 [콘텐츠설정]선택 &rarr; 쿠키 메뉴에서 설정</li>
								</ul>
							</li>
						</ol>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual14">제 14조 (개인정보 보호문의처) </h4>
						<p>1. 회사는 귀하의 의견을 소중하게 생각하며, 귀하는 의문사항으로부터 언제나 성실한 답변을 받을 권리가 있습니다.</p>
						<p>2. 당사는 귀하와의 원활한 의사소통을 위해 고객행복센터를 운영하고 있습니다.</p>
						<p>3. 고객행복센터의 연락처는 다음과 같습니다. </p>
						<p class="tPad20">[고객행복센터]</p>
						<ul>
							<li>- 이메일 : <a href="mailto:customer@10x10.co.kr"><em>customer@10x10.co.kr</em></a></li>
							<li>- 전화번호 : <em>1644-6030</em></li>
							<li>- 팩스번호 : 02-3493-1032 </li>
							<li>- 주소 : 서울시 종로구 대학로 57 홍익대학교 대학로캠퍼스 교육동 13층 텐바이텐 고객센터</li>
						</ul>
						<p class="tPad20">4. 전화상담은 월~금요일 오전 09:00 ~ 오후 06:00에만 가능합니다. (주말, 공휴일 휴무)</p>
						<p>5. 전자우편이나 팩스 및 우편을 이용한 상담은 접수 후 24시간 내에 성실하게 답변 드리겠습니다. 다만 근무시간 이후 또는 주말 및 공휴일에는 익일 처리하는 것을 원칙으로 합니다.</p>
						<p>6. 기타 개인정보에 관한 상담이 필요한 경우에는 개인정보침해신고센터, 대검찰청 인터넷범죄수사센터, 경찰청 사이버테러대응센터 등으로 문의하실 수 있습니다.</p>
						<div class="boardList tPad20 bPad10">
							<table>
							<caption>기타 개인정보 상담 문의처</caption>
							<colgroup>
							<col width="33%" /> <col width="33%" /> <col width="*" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">개인정보침해신고센터</th>
								<th scope="col">대검찰청 인터넷범죄수사센터</th>
								<th scope="col">경찰청 사이버테러대응센터</th>
							</tr>
							</thead>
							<tbody>
							<tr>
							<td>
								<ul>
									<li><em>118</em></li>
									<li><a href="118@kisa.or.kr" target="_blank">http://www.118.or.kr/</a></li>
									<li><a href="mailto:118@kisa.or.kr">118@kisa.or.kr</a></li>
								</ul>
							</td>
							<td>
								<ul>
									<li><em>02-3480-3600</em></li>
									<li><a href="http://icic.sppo.go.kr/" target="_blank">http://icic.sppo.go.kr/</a></li>
								</ul>
							</td>
							<td>
								<ul>
									<li><em>02-392-0330 </em></li>
									<li><a href="http://ctrc.go.kr/" target="_blank">http://ctrc.go.kr/</a></li>
									<li></li>
								</ul>
							</td>
							</tr>
							</tbody>
							</table>
						</div>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual15">제 15조 (개인정보보호책임자 및 담당자)</h4>
						<p>회사는 귀하가 좋은 정보를 안전하게 이용할 수 있도록 최선을 다하고 있습니다. 개인정보를 보호하는데 있어 귀하께 고지한 사항들에 반하는 사고가 발생할 시에 개인정보관리책임자가 모든 책임을 집니다. 그러나 기술적인 보완조치를 했음에도 불구하고, 해킹 등 기본적인 네트워크상의 위험성에 의해 발생하는 예기치 못한 사고로 인한 정보의 훼손 및 방문자가 작성한 게시물에 의한 각종 분쟁에 관해서는 책임이 없습니다. 귀하의 개인정보를 취급하는 책임자 및 담당자는 다음과 같으며 개인정보 관련 문의사항에 신속하고 성실하게 답변해드리고 있습니다.</p>
						<p class="tPad20">[개인정보 관리 책임자]</p>
						<ul>
							<li>- 성명: 이문재</li>
							<li>- 소속: 영업지원부문</li>
							<li>- 직책: 부문장</li>
							<li>- 이메일: <a href="mailto:moon@10x10.co.kr">moon@10x10.co.kr</a></li>
							<li>- 전화: 02-554-2033</li>
							<li>- Fax: 02-2179-9245 </li>
						</ul>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>

						<h4 id="individual16">제 16조 (고지의 의무)</h4>
						<p>개인정보처리방침은 2014년 08월 06일부터 적용됩니다. 내용의 추가, 삭제 및 수정이 있을 시에는 개정 최소 7일전부터 홈페이지의 공지사항을 통하여 고지할 것입니다. 또한 개인정보처리방침에 버전번호 및 개정일자 등을 부여하여 개정여부를 쉽게 알 수 있도록 하고 있습니다</p>
						<ul class="tPad20">
							<li>- 개인정보처리방침 버전번호 : v20120821 &nbsp;&nbsp;<a href="/common/private_v20120821.asp" class="linkBtn" target="_blank"><strong>이전버전보기</strong></a></li>
							<li>- 개인정보처리방침 변경공고일자 : 2014년 07월 30일</li>
							<li>- 개인정보처리 시행일자 : 2014년 08월 06일</li>
						</ul>
						<div class="btnTop"><a href="#individual"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/btn_top.gif" alt="TOP" /></a></div>
					</div>
				</div>
				<!-- //content -->

				<!-- #include virtual="/lib/inc/incCsQuickmenu.asp" -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
