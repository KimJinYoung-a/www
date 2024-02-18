<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2013.09.05 - 허진원 생성
'	Description : e기프트카드 등록/내역 정보
'#######################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 텐바이텐 Gift카드 동록 내역"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	dim pgReg, lp, jumpScroll
	dim userid: userid = getEncLoginUserID ''GetLoginUserID

	pgReg = requestCheckVar(getNumeric(request("pgReg")),4)
	jumpScroll = requestCheckVar(request("jmp"),1)
	if pgReg="" then pgReg=1
%>
<script type="text/javascript">
function jsGoPgReg(iP){
	self.location.href="?pgReg=" + iP;
}
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap skinBlue">
		<div id="contentWrap">
			<div class="myHeader">
				<h2><a href="/my10x10/"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_my10x10.png" alt="MY 10X10" /></a></h2>
				<div class="breadcrumb">
					<a href="/">HOME</a> &gt;
					<a href="/my10x10/">MY TENBYTEN</a> &gt;
					<a href="" onclick="return false;">MY 쇼핑활동</a> &gt;
					<strong>GIFT 카드</strong>
				</div>
			</div>
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<div class="myContent">
					<div class="giftcard giftcardV15a">
						<div class="subHeader">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_giftcard.png" alt="텐바이텐 기프트카드" /></h3>
							<p>무슨 선물을 할까 늘 고민인 당신, 간편한 기프트 카드로 마음을 전해보세요.</p>
							<div class="btnGroupV15a">
								<a href="<%=SSLUrl%>/giftcard/present.asp" class="btn btnS1 btnRed">선물하기</a>
								<a href="/giftcard/" class="btn btnS1 btnWhite">안내 및 유의사항</a>
							</div>
							<div class="ico"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/img_gift_card_visual.png" alt=""></div>
						</div>
						<ul class="tabMenu addArrow tabReview">
							<li><a href="/my10x10/giftcard/giftcardOrderlist.asp"><span>주문내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardUselist.asp"><span>사용내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegistlist.asp" class="on"><span>등록내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegist.asp"><span>카드등록</span></a></li>
						</ul>
						<ul class="list tMar35">
							<li>사용자에 의해 인증된 기프트카드 등록내역입니다.</li>
						</ul>
<%
	dim oGiftcard
	set oGiftcard = new myGiftCard
		oGiftcard.FRectUserid = userid
		oGiftcard.FScrollCount = 10
		oGiftcard.FPageSize = 10
		oGiftcard.FCurrPage = pgReg
		oGiftcard.myGiftCardRegList
%>
						<table class="baseTable tMar10">
						<caption>기프트카드 등록내역</caption>
						<colgroup>
							<col style="width:120px;" /> <col style="width:120px;" /> <col style="width:120px" /> <col style="width:*;" /> <col style="width:130px;" /> <col style="width:130px;" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">구매일자</th>
							<th scope="col">등록일자</th>
							<th scope="col">사용 만료일자</th>
							<th scope="col">상품명</th>
							<th scope="col">등록금액</th>
							<th scope="col">인증번호</th>
						</tr>
						</thead>
						<tbody>
						<%
							if oGiftcard.FResultCount>0 then
					
								For lp=0 to (oGiftcard.FResultCount-1)
						%>
						<tr>
							<td><%=formatDate(oGiftcard.FItemList(lp).FbuyDate,"0000/00/00")%></td>
							<td><%=formatDate(oGiftcard.FItemList(lp).FregDate,"0000/00/00")%></td>
							<td class="cRd0V15"><%=formatDate(oGiftcard.FItemList(lp).FcardExpire,"0000/00/00")%></td>
							<td><%=oGiftcard.FItemList(lp).FCarditemname%>&nbsp;<%=oGiftcard.FItemList(lp).FcardOptionName%></td>
							<td><%=FormatNumber(oGiftcard.FItemList(lp).FcardPrice,0)%>원</td>
							<td><%=oGiftcard.FItemList(lp).FmasterCardCode%></td>
						</tr>
						<%
								Next
							Else
						%>
						<tr>
							<td colspan="6"><p class="noData fs12"><strong>등록된 카드가 없습니다.</strong></p></td>
						</tr>
						<% end if %>
						</tbody>
						</table>
						<%
							if oGiftcard.FResultCount>0 then
								Response.Write "<div class=""pageWrapV15 tMar20"">" & fnDisplayPaging_New(pgReg,oGiftcard.FTotalCount,10,10,"jsGoPgReg") & "</div>"
							end if
						%>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% set oGiftcard = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->