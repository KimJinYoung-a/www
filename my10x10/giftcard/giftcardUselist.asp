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
	strPageTitle = "텐바이텐 10X10 : 텐바이텐 Gift카드 사용 내역"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	dim pgLog, lp, jumpScroll, vIsOnOff
	dim userid: userid = getEncLoginUserID ''GetLoginUserID

	pgLog = requestCheckVar(getNumeric(request("pgLog")),4)
	vIsOnOff = requestCheckVar(request("isonoff"),1)
	if pgLog="" then pgLog=1
%>
<script type="text/javascript">
function jsGoPgLog(iP){
	self.location.href="?pgLog="+iP+"&isonoff=<%=vIsOnOff%>";
}
function jsUseListSort(s){
	self.location.href="?isonoff="+s;
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
						<!-- title -->
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
							<li><a href="/my10x10/giftcard/giftcardUselist.asp" class="on"><span>사용내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegistlist.asp"><span>등록내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegist.asp"><span>카드등록</span></a></li>
						</ul>
						<div class="sorting tMar35">
							<ul class="list">
								<li>최근 기프트카드 사용내역입니다.</li>
							</ul>
							<div class="option">
								<select name="isonoff" title="기프트카드 사용내역 정렬 옵션" class="optSelect" onChange="jsUseListSort(this.value);">
									<option value="" <%=CHKIIF(vIsOnOff="","selected","")%>>전체 사용내역</option>
									<option value="T" <%=CHKIIF(vIsOnOff="T","selected","")%>>온라인 사용내역</option>
									<option value="S" <%=CHKIIF(vIsOnOff="S","selected","")%>>오프라인 사용내역</option>
								</select>
							</div>
						</div>
<%
	dim oGiftLog
	set oGiftLog = new myGiftCard
		oGiftLog.FRectUserid = userid
		oGiftLog.FScrollCount = 10
		oGiftLog.FPageSize = 10
		oGiftLog.FCurrPage = pgLog
		oGiftLog.FRectSiteDiv = vIsOnOff
		oGiftLog.myGiftCardLogList
%>
						<table class="baseTable">
						<caption>기프트카드 사용내역</caption>
						<colgroup>
							<col style="width:160px;" /> <col style="width:120px;" /> <col style="width:*;" /> <col style="width:150px;" /> <col style="width:130px;" /> <col style="width:130px;" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">거래일시</th>
							<th scope="col">구분</th>
							<th scope="col">관련 주문번호</th>
							<th scope="col">이용내역</th>
							<th scope="col">이용금액</th>
							<th scope="col">잔액</th>
						</tr>
						</thead>
						<tbody>
						<%
							if oGiftLog.FResultCount>0 then
					
								For lp=0 to (oGiftLog.FResultCount-1)
						%>
						<tr>
							<td><%=formatDate(oGiftLog.FItemList(lp).Fregdate,"0000/00/00")%></td>
							<td>
							<%
								If oGiftLog.FItemList(lp).FsiteDiv = "T" OR oGiftLog.FItemList(lp).FsiteDiv = "F" Then
									Response.Write "온라인"
								ElseIf oGiftLog.FItemList(lp).FsiteDiv = "S" Then
									Response.Write "오프라인"
								End IF
							%>
							</td>
							<td><%=oGiftLog.FItemList(lp).Forderserial%></td>
							<td><%=oGiftLog.FItemList(lp).Fjukyo%></td>
							<td <%=chkIIF(oGiftLog.FItemList(lp).FuseCash>0,"class=""cMt0V15""","class=""cRd0V15""")%>><%=CHKIIF(oGiftLog.FItemList(lp).FuseCash>0,"+","")%><%=formatNumber(oGiftLog.FItemList(lp).FuseCash,0)%>원</td>
							<td><%=formatNumber(oGiftLog.FItemList(lp).Fremain,0)%>원</td>
						</tr>
						<%
								Next
							else
						%>
						<tr>
							<td colspan="6"><p class="noData fs12"><strong>사용내역이 없습니다.</strong></p></td>
						</tr>
						<% end if %>
						</tbody>
						</table>
						<%
							if oGiftLog.FResultCount>0 then
								Response.Write "<div class=""pageWrapV15 tMar20"">" & fnDisplayPaging_New(pgLog,oGiftLog.FTotalCount,10,10,"jsGoPgLog") & "</div>"
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
<% set oGiftLog = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->