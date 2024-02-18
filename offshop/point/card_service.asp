<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/card_service.asp
' Description : 텐바이텐 멤버쉽 카드 WWW
' History : 2017.06.26 유태욱 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'매장 정보 가져오기
Dim offshoplist, ix
Set  offshoplist = New COffShop
offshoplist.GetOffShopList
%>
<%
	strPageTitle = "텐바이텐 10X10 : 멤버쉽카드안내"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_infomation_v1.jpg"
	strPageDesc = "쇼핑할 때마다 쏟아지는 마일리지 포인트를 놓치지 마세요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 멤버쉽카드안내"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/offshop/"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
function fnPopOffCardreg(wd,hi) {
	var popWidth  = wd;
	var popHeight = hi;
	var winWidth  = document.body.clientWidth;
	var winHeight = document.body.clientHeight;
	var winX      = window.screenX || window.screenLeft || 0;
	var winY      = window.screenY || window.screenTop || 0;
	var popupX = (winX + (winWidth - popWidth) / 2)- (wd / 4);
	var popupY = (winY + (winHeight - popHeight) / 2)- (hi / 1.2);
	var popup = window.open("/my10x10/membercard/popRegistMemcard.asp?mode=cardpop&itemid=cardreg","","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
}

function tencardreg(){
	//'카드 발급
	if (confirm('멤버십카드를 발급 받으시겠습니까?')){
		var rstStr = $.ajax({
			type: "POST",
			url: "/my10x10/dotentencard.asp",
			dataType: "text",
			async: false
		}).responseText;
		if (rstStr == "0000"){
			alert('멤버십카드 발급이 완료 되었습니다');
			document.location.reload();
		}else if(rstStr == "3435"){
			if(confirm("로그인 후 발급 받을 수 있습니다.\n로그인 하시겠습니까?")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
			return false;
		}else if (rstStr == "2101"){
			alert('이미 멤버십카드를 발급받으셨습니다.\n발급받은 카드 정보는 [마이텐바이텐 > 텐바이텐 멤버십카드]에서 확인하실 수 있습니다.');
			document.location.reload();
		}else{
			alert('오류가 발생했습니다.');
			document.location.reload();
		}
	}
}

</script>
</head>
<body>
<div class="membercardWrapV17a">
<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="membercardV17">
		<div class="hGroup">
			<h2><img src="http://fiximage.10x10.co.kr/web2017/membercard/tit_membercard.png" alt="텐바이텐 멤버십카드" /></h2>
			<div class="cardImg"><img src="http://fiximage.10x10.co.kr/web2017/membercard/img_balloon.png" alt="텐바이텐 멤버십카드" /></div>
			<ul>
				<li><a href="" onclick="tencardreg();return false;"><span>온라인 카드 발급</span></a></li>
				<li><a href="" onclick="fnPopOffCardreg('530','770'); return false;"><span>오프라인 카드 등록</span></a></li>
				<li><a href="\my10x10\membercard\point_search.asp"><span>내 포인트 조회/전환</span></a></li>
				<li><a href="/cscenter/faq/faqList.asp?divcd=F016"><span>FAQ</span></a></li>
			</ul>
		</div>
		<div class="content">
			<div class="section1">
				<div class="column methodV17">
					<h3>발급방법</h3>
					<div class="online">
						<p>온라인 쇼핑몰</p>
						<ol>
							<li>텐바이텐<br />온라인 쇼핑몰<br />접속</li>
							<li>멤버십카드<br />페이지를 통해<br />발급 신청</li>
							<li>별도의 등록없이<br />적립/사용</li>
						</ol>
					</div>
					<div class="offshop">
						<p>오프라인 가맹점</p>
						<ol>
							<li>텐바이텐<br />매장방문</li>
							<li>별도의<br />신청서 없이<br />발급</li>
							<li>온라인 쇼핑몰 카드<br />등록 후 사용</li>
						</ol>
						<ul>
							<li>- 오프라인 가맹점을 통한 멤버십카드 발급은 1,000원 이상 상품 구매 시 가능합니다.</li>
						</ul>
					</div>
				</div>
				<div class="column saveV17">
					<h3>적립/사용방법</h3>
					<div>
						<ol>
							<li>매장 구매 시<br />카드 제시<br />(온라인은 자동적립)</li>
							<li>이용 금액의<br />3% 적립</li>
							<li>결제 시<br />현금처럼 사용</li>
						</ol>
						<ul>
							<li>- 오프라인 가맹점 발급 시 카드를 등록하지 않아도 포인트 적립은 가능합니다.</li>
							<li class="cRd0V17">- 적립된 포인트를 사용하시려면, 본인확인을 위한 온라인 회원가입 및 카드 등록이 필요합니다.</li>
							<li>- 가용 포인트가 3,000포인트 이상일 경우 현금과 동일하게 사용 가능합니다. (텐바이텐 온/오프라인)</li>
							<li>- 온라인 사용을 위해서는 온라인 마일리지 전환이 필요합니다. <!-- (텐바이텐/더핑거스)--></li>
							<li>- 세일기간 또는 특정 상품 구매 시 적립 및 사용이 제한될 수 있습니다.</li>
						</ul>
					</div>
				</div>
				<div class="column expDateV17">
					<h3>적립 유효기간</h3>
					<div>
						<ul>
							<li>- 적립된 포인트는 적립된 순서로 사용되며, 적립된 해로부터 5년 이내에 사용하셔야 합니다.</li>
							<li>- 해당 기간 내에 사용하지 않은 잔여 포인트는 1년 단위로 매년 12월 31일에 자동 소멸됩니다.</li>
							<li>- 미적립된 포인트는 1개월 이내 매장으로 방문하시면 적립 가능합니다.</li>
						</ul>
					</div>
				</div>
				<div class="column replaceV17">
					<h3>카드 재발급</h3>
					<div>
						<ul>
							<li>- 실물 카드 분실 또는 이용이 불가능할 경우 텐바이텐 매장에서 신규 카드로 재발급 받으실 수 있습니다.</li>
							<li>- 실물 카드를 재발급 받으실 경우, 기존 카드의 포인트 이관을 위해 카드 재등록이 필요합니다.</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="section2 usedV17">
				<h3>사용처</h3>
				<ul>
					<li><a href="/" target="_blank" class="cRd0V17">텐바이텐 온라인 &gt;</a></li>
					<% If offshoplist.FResultCount >0 Then %>
					<% For ix=0 To offshoplist.FResultCount-1 %>
					<li><a href="/offshop/index.asp?shopid=<%=offshoplist.FItemList(ix).FShopID%>" target="_blank"><%=offshoplist.FItemList(ix).FShopName%> &gt;</a></li>
					<% Next %>
					<% End If %>
				</ul>
			</div>
		</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
	</div>
</div>
</body>
</html>
<% Set offshoplist = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->