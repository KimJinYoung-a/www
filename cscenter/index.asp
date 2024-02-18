<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/classes/cscenter/BoardNoticecls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 고객센터"		'페이지 타이틀 (필수)
strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_help_v1.jpg"
strPageDesc = "텐바이텐 이용가이드"
'// 오픈그래프 메타태그
strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] FAQ 보기"" />" & vbCrLf &_
					"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
					"<meta property=""og:url"" content=""https://www.10x10.co.kr/cscenter/"" />" & vbCrLf &_
					"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf

dim i,ix,j,lp

'// 자주하는 질문
dim boardfaq
set boardfaq = New CBoardFAQ

boardfaq.FPageSize = 10
boardfaq.getFaqTopList "HIT"

'카카오 푸쉬로 들어왔을때 적용할 변수
Dim pushType 
pushType 	= requestCheckVar(request("pushtype"),10)
'// 공지사항
dim oBoardNotice
set oBoardNotice = New cBoardNotice

''oBoardNotice.FRectNoticeOrder =7
oBoardNotice.FPageSize = 7
oBoardNotice.FCurrPage = 1
oBoardNotice.FScrollCount = 5
oBoardNotice.FRectNoticetype = "A"
oBoardNotice.getNoticsList

'// 이벤트
dim oBoardEvent
set oBoardEvent = New cBoardNotice

''oBoardEvent.FRectNoticeOrder =7
oBoardEvent.FPageSize = 7
oBoardEvent.FCurrPage = 1
oBoardEvent.FScrollCount = 5
oBoardEvent.FRectNoticetype = "E"
oBoardEvent.getNoticsList

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	Kakao.init('fe75aa5e2410b215dce4e28494c10456');
</script>

<script type="text/javascript">
fnAmplitudeEventMultiPropertiesAction("view_cs","pushtype","<%=pushType%>");

var HitArr = new Array();

function CheckHit(faqId){
	for (var i=0;i<HitArr.length;i++){
		if (HitArr[i]==faqId) return;
	}

	HitArr.length = HitArr.length +1;
	HitArr[HitArr.length] = faqId;
	document.all["FaqCnt"].src="/cscenter/faq/process_faqhit.asp?faqid=" + faqId;
}

function showhideFAQ(tab, num, p_totcount, faqId)	{
  for (i=0; i<p_totcount; i++)   {
	  menu=eval("document.all.FAQblock"+tab+i+".style");

	  if (num==i ){
		if (menu.display=="table-row"){
			menu.display="none";
		}else{
		  menu.display="table-row";
//		  CheckHit(faqId);	// 메인에서는 카운트 올리지 않음
		}
	  }else{
		 menu.display="none";
	  }
	}
}

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
									<input id="searchFaq" type="text" name="srch" class="txtInp" />
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_faq_top10.gif" alt="자주하는 질문 TOP 10" /></h3>
						<table>
							<caption>자주하는 질문 TOP 10</caption>
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
							<% if boardfaq.FResultCount < 1 then %>
							<tr>
								<td></td>
								<td></td>
								<td class="lt">FAQ 내용이 없습니다</td>
							</tr>
							<% end if %>
							<% for i = 0 to (boardfaq.FResultCount - 1) %>
							<tr>
								<td><%=(10 - i)%></td>
								<td><%=boardfaq.FItemList(i).Fcomm_name%></td>
								<td class="lt"><a href="javascript:showhideFAQ('1', '<%= i %>','<%= boardfaq.FResultCount %>','<%= boardfaq.FItemList(i).FfaqId %>');" class="question" title="<%= boardfaq.FItemList(i).Ftitle %>"><%= left(boardfaq.FItemList(i).Ftitle, 38) %><% if (Len(boardfaq.FItemList(i).Ftitle) > 38) then %>...<% end if %></a></td>
							</tr>
							<tr class="answer" id="FAQblock1<%= i %>" style="DISPLAY:none;">
								<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER" /></td>
								<td colspan="2" class="detail">
									<%= nl2br(boardfaq.FItemList(i).Fcontents) %>
									<% if boardfaq.FItemList(i).Flinkurl<>"" then %>
									<div class="moreInfo tPad10">
										<div class="btnArea">
											<a href="<%= boardfaq.FItemList(i).Flinkurl %>"  class="linkBtn highlight"><strong><%= boardfaq.FItemList(i).Flinkname %> 바로가기</strong></a>
										</div>
									</div>
									<% end if %>
									<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
								</td>
							</tr>
							<% next %>
							</tbody>
						</table>
					</div>

					<div class="boardList noticeboard">
						<div class="column">
							<h3><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_notice.gif" alt="공지사항" /></h3>
							<ul>
							<% if oBoardNotice.FResultCount < 1 then %>
								<li>공지사항이 없습니다.</li>
							<% end if %>
							<% for i = 0 to (oBoardNotice.FResultCount - 1) %>
								<li>
									<a href="/common/news_popup.asp?idx=<%= oBoardNotice.FItemList(i).Fid %>" onclick="window.open(this.href, 'popNotice', 'width=620, height=750, scrollbars=yes'); return false;" title="<%= oBoardNotice.FItemList(i).Ftitle %>">
										<%= chrbyte(oBoardNotice.FItemList(i).Ftitle,38,"Y") %>
										<% IF oBoardNotice.FItemList(i).IsNewNotics THEN %>
											<img src="http://fiximage.10x10.co.kr/web2013/cscenter/ico_new.gif" alt="NEW" />
										<% END IF %>
									</a>
									<span><%=FormatDate(oBoardNotice.FItemList(i).Fyuhyostart,"0000.00.00")%></span>
								</li>
							<% Next%>
							</ul>
							<div class="moreBtn"><a href="/common/news_list.asp" onclick="window.open(this.href, 'popNotice', 'width=620, height=750, scrollbars=yes'); return false;" title="공지사항 더보기 새창">more</a></div>
						</div>

						<div class="column">
							<h3><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_event_win.gif" alt="이벤츠 당첨 안내" /></h3>
							<ul>
							<% if oBoardEvent.FResultCount < 1 then %>
								<li>이벤츠 당첨 안내가 없습니다.</li>
							<% end if %>
							<% for i = 0 to (oBoardEvent.FResultCount - 1) %>
								<li>
									<a href="/common/news_popup.asp?idx=<%= oBoardEvent.FItemList(i).Fid %>&type=E" onclick="window.open(this.href, 'popEvent', 'width=620, height=750, scrollbars=yes'); return false;" title="<%= oBoardEvent.FItemList(i).Ftitle %>">
										<%= chrbyte(oBoardEvent.FItemList(i).Ftitle,36,"Y") %>
										<% IF oBoardEvent.FItemList(i).IsNewNotics THEN %>
											<img src="http://fiximage.10x10.co.kr/web2013/cscenter/ico_new.gif" alt="NEW" />
										<% END IF %>
									</a>
									<span><%=FormatDate(oBoardEvent.FItemList(i).Fyuhyostart,"0000.00.00")%></span>
								</li>
							<% Next%>
							</ul>
							<div class="moreBtn"><a href="/common/news_list.asp?type=E" onclick="window.open(this.href, 'popNotice', 'width=620, height=750, scrollbars=yes'); return false;" title="이벤트 당첨 안내 더보기 새창">more</a></div>
						</div>
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

set boardfaq = Nothing
set oBoardNotice= Nothing
set oBoardEvent= Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
