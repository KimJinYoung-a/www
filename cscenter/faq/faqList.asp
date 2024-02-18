<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : FAQ 검색결과"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

dim i,ix,j,lp

Dim page	: page	= req("page",1)
Dim srch	: srch	= requestcheckvar(request("srch"),16)

if checkNotValidHTML(srch) then
	dbget.close()
	response.redirect "/cscenter/faq/faqList.asp"
	response.End
end if

Dim selectfaq, divcd

selectfaq 	= requestcheckvar(request("selectfaq"),1)
divcd		= requestcheckvar(request("divcd"),4)

if (divcd <> "") then
	selectfaq = "4"
end if

'// FAQ 검색결과
Dim boardfaq_new
Set boardfaq_new = New CBoardFAQ
boardfaq_new.FPageSize = 10
boardfaq_new.FCurrpage = page
boardfaq_new.FScrollCount = 5
boardfaq_new.FRectSearchString = srch

boardfaq_new.FRectCommCd = divcd
boardfaq_new.Fselectfaq = selectfaq

boardfaq_new.getFaqList_new


Dim titleImg, titleText, titleDesc
titleText = ""
Select Case selectfaq
	Case "1"
	titleImg	= "tit_faq_order"
	Case "2"
	titleImg	= "tit_faq_member"
	Case "3"
	titleImg	= "tit_faq_etc"
	Case Else
	titleImg	= "tit_faq_search_result"
End Select

Select Case divCd
	Case "F001"
	titleText	= titleText & "주문/결제</b></a>"
	Case "F002"
	titleText	= titleText & "배송</b></a>"
	Case "F003"
	titleText	= titleText & "주문변경/취소</b></a>"
	Case "F004"
	titleText	= titleText & "반품/교환</b></a>"
	Case "F005"
	titleText	= titleText & "환불</b></a>"
	Case "F006"
	titleText	= titleText & "증빙서류</b></a>"

	Case "F007"
	titleText	= titleText & "회원정보</b></a>"
	Case "F008"
	titleText	= titleText & "텐바이텐 멤버십</b></a>"
	Case "F009"
	titleText	= titleText & "결제방법</b></a>"
	Case "F010"
	titleText	= titleText & "마일리지/상품쿠폰/할인권</b></a>"
	Case "F011"
	titleText	= titleText & "상품문의</b></a>"
	Case "F012"
	titleText	= titleText & "이벤트/사은품</b></a>"

	Case "F013"
	titleText	= titleText & "오프라인</b></a>"
	Case "F014"
	titleText	= titleText & "사이트이용/장애</b></a>"
	Case "F015"
	titleText	= titleText & "기타</b></a>" 
	Case "F016"
	titleText	= titleText & "텐바이텐 멤버십카드</b></a>"

	Case Else	' 검색임
	titleText	= "전체"
End Select

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">

function TnFAQSearch(srch){
    frm = document.FAQSearchFrm;

	if (srch)
		frm.srch.value = srch;

    if (frm.srch.value == "") {
            alert("검색어를 입력하세요.");
            return;
    }
    frm.submit();
}

function goPage(page){
    location.href="?selectfaq=<%=selectfaq%>&page=" + page + "&divcd=<%= divcd %>" + "&srch=<%=srch %>" ;
}

var HitArr = new Array();
function CheckHit(faqId){
    for (var i=0;i<HitArr.length;i++){
        if (HitArr[i]==faqId) return;
    }

    HitArr.length = HitArr.length +1;
    HitArr[HitArr.length] = faqId;
//    document.all["FaqCnt"].src="/cscenter/faq/process_faqhit.asp?faqid=" + faqId;

	if (faqId)
	{
		var url = "/cscenter/faq/process_faqhit.asp?faqid=" + faqId;
		var xmlHttp = createXMLHttpRequest();
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=euc-kr");
		xmlHttp.setRequestHeader("Pragma", "no-cache");
		xmlHttp.send(null);
	}
}

function showhideFAQ(num, p_totcount, faqId)	{
	for(i=0; i<p_totcount; i++) {
		if (num==i ){
			$("#FAQblock"+i).toggle();
			if($("#FAQblock"+i).css("display")!="none") CheckHit(faqId);
		}else{
			$("#FAQblock"+i).hide();
		}
	}
}

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
        <div class="csHeader wide">
            <div class="csHeadinner">
                <h2>고객센터<span style="display:none;">1500-0000</span></h2>
                <div class="info-open">
                    <div class="info open">
                        <img src="http://fiximage.10x10.co.kr/web2021/cscenter/img_open_info01.png?v=2.1" alt="운영시간 : 10:00 ~ 17:00">
                    </div>
                    <div class="info lunch">
                        <img src="http://fiximage.10x10.co.kr/web2021/cscenter/img_open_info02.png?v=2.1" alt="점심시간 : 12:30 ~ 13:30">
                    </div>
                </div>
                <div class="btn-csgroups">
                    <a href="http://pf.kakao.com/_xiAFPs/chat" target="_blank" class="talk-kakao"><img src="http://fiximage.10x10.co.kr/web2021/cscenter/btn_kakao_talk.png?v=2.1" alt="카카오 상담하기"></a>
                    <div class="service-group">
                        <img src="http://fiximage.10x10.co.kr/web2021/cscenter/btn_csgroup.png?v=2.1" alt="1:1상담하기 / 1:1상담내역">
                        <a href="" onClick="myqnawrite(); fnAmplitudeEventMultiPropertiesAction('click_cs_1on1','',''); return false;" class="btn-consulting01"><%=CHKIIF(IsVIPUser()=True,"VIP ","")%>1:1 상담신청</a>
                        <a href="/my10x10/qna/myqnalist.asp"  class="btn-consulting02"><%=CHKIIF(IsVIPUser()=True,"VIP ","")%>1:1 상담내역</a>
                    </div>
                </div>
            </div>
        </div>
		<div id="contentWrap">

			<div class="csContent">
				<!-- #include virtual="/lib/inc/incCsLnb.asp" -->

				<!-- content -->
				<div class="content">
					<div class="searchBox">
						<form name="FAQSearchFrm" method="get" action="/cscenter/faq/faqList.asp" onKeyPress="if (event.keyCode == 13) TnFAQSearch();" onSubmit="return false;">
						<input type="hidden" name="pg" value="1">
							<fieldset>
								<legend>FAQ 검색</legend>
								<div class="searchField">
									<label for="searchFaq">FAQ 검색</label>
									<input id="searchFaq" type="text" class="txtInp" name="srch" value="<%=request("srch")%>" />
									<input type="submit" value="검색" class="btn btnS1 btnRed" onClick="TnFAQSearch()" />
								</div>

								<ul class="searchOption">
									<li><a href="javascript:TnFAQSearch('반품')" title="반품 검색">반품</a></li>
									<li><a href="javascript:TnFAQSearch('교환')" title="교환 검색">교환</a></li>
									<li><a href="javascript:TnFAQSearch('배송비')" title="배송비 검색">배송비</a></li>
									<li><a href="javascript:TnFAQSearch('쿠폰')" title="쿠폰 검색">쿠폰</a></li>
									<li><a href="javascript:TnFAQSearch('마일리지')" title="마일리지 검색">마일리지</a></li>
								</ul>
							</fieldset>
						</form>
					</div>

					<div class="boardList faqList">
						<div class="faqResult">
							<h3><img src="http://fiximage.10x10.co.kr/web2013/cscenter/<%= titleImg %>.gif" alt="<%= titleText %> FAQ" /> <strong><%= titleText %></strong></h3>
							<p>총 <em><%= boardfaq_new.FtotalCount %>건</em>의 FAQ가 검색되었습니다.</p>
						</div>
						<table>
							<caption>주문 FAQ의 반품/교환/AS 목록</caption>
							<colgroup>
								<col width="70" /> <col width="150" /> <col width="*" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">구분</th>
								<th scope="col">제목</th>
							</tr>
							</thead>
							<tbody>
							<% if boardfaq_new.FResultCount < 1 then %>
							<tr>
								<td></td>
								<td></td>
								<td class="lt">검색된 FAQ 내용이 없습니다.</td>
							</tr>
							<% end if %>
							<% for i = 0 to (boardfaq_new.FResultCount - 1) %>
							<tr>
								<td><%=(boardfaq_new.FtotalCount - boardfaq_new.Fpagesize * (page-1) - i)%></td>
								<td><%=boardfaq_new.FItemList(i).Fcomm_name%></td>
								<td class="lt"><a href="javascript:showhideFAQ('<%= i %>','<%= boardfaq_new.FResultCount %>','<%= boardfaq_new.FItemList(i).FfaqId %>');" class="question" title="<%= boardfaq_new.FItemList(i).Ftitle %>"><%= left(boardfaq_new.FItemList(i).Ftitle, 38) %><% if (Len(boardfaq_new.FItemList(i).Ftitle) > 38) then %>...<% end if %></a></td>
							</tr>
							<tr class="answer" id="FAQblock<%= i %>" style="DISPLAY:none;">
								<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER" /></td>
								<td colspan="2" class="detail">
									<%= nl2br(boardfaq_new.FItemList(i).Fcontents) %>
									<div class="moreInfo">
										<% if boardfaq_new.FItemList(i).Flinkurl<>"" then %>
										<div class="btnArea">
											<a href="<%= boardfaq_new.FItemList(i).Flinkurl %>"  class="linkBtn highlight"><strong><%= boardfaq_new.FItemList(i).Flinkname %> 바로가기</strong></a>
											</div>
										<% else %><p><% end if %>
										<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
									</div>
								</td>
							</tr>
							<% next %>
							</tbody>
						</table>
						<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(boardfaq_new.FcurrPage, boardfaq_new.FtotalCount, boardfaq_new.FPageSize, 5, "goPage") %></div>
						<iframe id="FaqCnt" name="FaqCnt" frameBorder="0" src="" border=0 frameSpacing=0 width="0" height="0"></iframe>
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
<%

set boardfaq_new = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
