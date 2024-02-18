<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/enjoy/mailzineCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
dim code1,code2,idx,page,arrow, omail, mode, Icode1, Icode2,Fidx,arrCode
dim Fimg1,Fimg2,Fimg3,Fimg4,Fimgmap1,Fimgmap2,Fimgmap3,Fimgmap4,Fregdate,FTitle, vNextIdx, vPreIdx, userid, secretgubun, fixedHTML


	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : ENJOY EVENT : 메일진"

	'// 모달창이 필요한경우 아래 변수에 내용을 넣어주세요.
	strModalCont = ""


	'// 팝업창(레이어)이 필요한 경우 아래 변수에 내용을 넣어주세요.
	strPopupCont = ""


mode = request("mode")
idx = getNumeric(request("idx"))
code1 = request("code1")
code2 = request("code2")
page = requestCheckVar(getNumeric(request("page")),10)
userid = GetLoginUserID
if page = "" then page = 1
arrow = getNumeric(request("arrow"))
'if arrow = "" then arrow = 0


Set omail = new CMailzineMaster

If idx = "" Then
	omail.MailzineIdx
	Fidx		= omail.Fidx
	omail.MailzineView
	Icode1		= omail.Icode1
	Icode2		= omail.Icode2
Else
	omail.Fidx		= idx
	omail.MailzineView

	if Not(omail.FRegdate="" or isNull(omail.FRegdate)) then
		arrCode = split(omail.FRegdate,".")
		Icode1 = arrCode(0)
		Icode2 = arrCode(1) + arrCode(2)
	else
		Icode1 = code1
		Icode2 = code2
	end if
End If

	Fimg1		= omail.FImg1
	Fimg2		= omail.FImg2
	Fimg3		= omail.FImg3
	Fimg4		= omail.FImg4
	Fimgmap1	= omail.FImgMap1
	Fimgmap2	= omail.FImgMap2
	Fimgmap3	= omail.FImgMap3
	Fimgmap4	= omail.FImgMap4
	Fregdate	= omail.FRegdate
	FTitle		= db2html(omail.FTitle)
	vNextIdx	= omail.FNextIdx
	vPreIdx		= omail.FPreIdx
	secretgubun = omail.Fsecretgubun
	fixedHTML	= omail.FfixedHTML

	mode = "map"
Set omail = nothing
%>
<script type="text/javascript">
$(function(){
	var currentPosition = parseInt($(".mailzineContV15 .prev").css("top"));
	$(window).scroll(function() {
		var position = $(window).scrollTop();
		windowCenterH = parseInt($(window).height()/2);
			$(".mailzineContV15 .prev, .mailzineContV15 .next").stop().animate({"top":position+currentPosition+"px"},400);
		if(position+currentPosition > document.body.scrollHeight-900){
			$(".mailzineContV15 .prev, .mailzineContV15 .next").stop().animate({"top":document.body.scrollHeight-900+"px"},400);
		}
	});
});

function popMailling()
{
		<% if Not(IsUserLoginOK) then %>
		   window.open('/member/mailzine/notmember_pop.asp','popMailling','width=520,height=700');
		<% else %>
		    alert("이미 회원가입이 되어있습니다.");
		<% end if %>

}
</script>
</head>
<body>
<div id="mailzineV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap">
			<div class="hotHgroupV19 bg-purple">
				<div class="tab-area">
					<ul>
						<li><a href="/shoppingtoday/shoppingchance_allevent.asp">기획전</a></li>
						<li><a href="/shoppingtoday/couponshop.asp">쿠폰북</a></li>
						<li class="on"><a href="/shoppingtoday/shoppingchance_mailzine.asp">메일진</a></li>
					</ul>
				</div>
				<h2>MAILZINE<p class="tit-sub">텐바이텐의 놓칠 수 없는 이벤트와 할인 소식,<br>메일로 받아 볼 수 있어요!</p></h2>
			</div>
			<div class="hotSectionV15">
				<div class="lnbHotV15">
					<div class="mailzineListV15">
						<dl>
							<dt>MAILZINE LIST</dt>
							<dd>
								<ul>
							<%
								Dim Lomail, ix, cssColor, selct
								set Lomail = new CMailzineMaster
								Lomail.FCurrPage = page
								Lomail.FPageSize = 7
								Lomail.MailzineList

								For ix =0 To Lomail.FResultCount - 1

							%>
									<li class="addInfo">
										<span><%=Lomail.FItemList(ix).Fregdate%></span>
										<% If Lomail.FItemList(ix).Fsecretgubun = "Y" Then %>
												<%=chrbyte(StripHtml(Lomail.FItemList(ix).FTitle),40,"Y")%>
											<div class="contLyr">
												<div class="contLyrInner">텐바이텐 회원님들께만 드리는 시크릿 메일진 입니다. 메일 구독을 원하시면 로그인 후 메일진을 신청해 주세요.</div>
											</div>
										<% else %>
											<a href="?page=<%= page %>&idx=<% = Lomail.FItemList(ix).Fidx %>&code1=<% = Lomail.FItemList(ix).Fcode1 %>&code2=<% = Lomail.FItemList(ix).Fcode2 %>" <%=CHKIIF(CStr(idx)=CStr(Lomail.FItemList(ix).Fidx),"class='current'","")%>>
												<%=chrbyte(StripHtml(Lomail.FItemList(ix).FTitle),40,"Y")%>
											</a>
										<% End If %>
									</li>
							<%
								Next

							%>
								</ul>
							</dd>
						</dl>
						<div class="otherList">
						<% If Lomail.FResultCount <> 7 Then %>
							<a href="javascript:alert('현재 보시는 페이지는 마지막 페이지입니다.');"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_prev_list.gif" alt="이전 메일진 목록" /></a>
						<% Else %>
							<a href="?page=<%=page+1%>&idx=<%=Idx%>"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_prev_list.gif" alt="이전 메일진 목록" /></a>
						<% End If %>



						<% If page = 1 Then %>
							<a href="javascript:alert('현재 보시는 페이지는 최신 페이지입니다');"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_next_list.gif" alt="다음 메일진 목록" /></a>
						<% Else %>
							<a href="?page=<%=page-1%>&idx=<%=Idx%>"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_next_list.gif" alt="다음 메일진 목록" /></a>
						<% End If %>
						</div>
					</div>

					<div class="nonMemApplyV15">
						<p><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/txt_nonmember_mailzine.gif" alt="비회원도 받아보는 텐바이텐 메일진" /></p>
						<a href="javascript:popMailling()" class="btn btnRed btnM2"><em class="whiteArr01">비회원 메일진 신청</em></a>
					</div>

					<% If GetLoginUserID = "" Then %>
						<div class="nomemberV15">
							<div class="benefit">
								<div class="bg"></div>
								<strong>텐바이텐 회원혜택</strong>
								<ul>
									<li>회원가입과 동시에 쿠폰발급! (무료배송쿠폰/2,000원 쿠폰)</li>
									<li>구매금액 및 횟수에 따른 회원등급별 혜택 제공!</li>
									<li>회원 마일리지로만 구매 가능한 마일리지샵 에디션 상품!</li>
								</ul>
							</div>
							<a href="/member/join.asp" class="btn btnS1 btnRed"><span class="whiteArr01 fs12">신규회원가입</span></a>
						</div>
					<% End If %>
				</div>
				<div class="hotArticleV15">
					<div class="mailzineContV15">
						<dl>
							<dt><%=FTitle%></dt>
							<dd>
								<% if IsNull(fixedHTML) then %>
								<img src="http://mailzine.10x10.co.kr/<% = Icode1 %>/<% = Fimg1 %>" usemap="#ImgMap1" border="0">
								<% if Fimg2 <> "" then %><img src="http://mailzine.10x10.co.kr/<% = Icode1 %>/<% = Fimg2 %>" usemap="#ImgMap2" border="0"><% end if %>
								<% if Fimg3 <> "" then %><img src="http://mailzine.10x10.co.kr/<% = Icode1 %>/<% = Fimg3 %>" usemap="#ImgMap3" border="0"><% end if %>
								<% if Fimg4 <> "" then %><img src="http://mailzine.10x10.co.kr/<% = Icode1 %>/<% = Fimg4 %>" usemap="#ImgMap4" border="0"><% end if %>
								<% if mode = "map" then %>
									<% = ReverseBracket(db2html(Fimgmap1)) %>
									<% = ReverseBracket(db2html(Fimgmap2)) %>
									<% = ReverseBracket(db2html(Fimgmap3)) %>
									<% = ReverseBracket(db2html(Fimgmap4)) %>
								<% end if %>
								<% else %>
								<%= fixedHTML %>
								<% end if %>
							</dd>
						</dl>

					<% If arrow = "9" Then %>
						<p class="prev"><a href="shoppingchance_mailzine.asp?page=<%=page%>&arrow=0&idx=<%=vPreIdx%>&code1=<%=Icode1%>&code2=<%=Icode2%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_prev_mailzine.gif" alt="이전 메일진" /></a></p>
					<% ElseIf vPreIdx = "0"  Then %>
						<p class="prev"><a href="javascript:alert('현재 보시는 글이 마지막 글입니다.');" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_prev_mailzine.gif" alt="이전 메일진" /></a></p>
					<% Else %>
						<p class="prev"><a href="shoppingchance_mailzine.asp?page=<%=page%>&arrow=<%=arrow+1%>&idx=<%=vPreIdx%>&code1=<%=Icode1%>&code2=<%=Icode2%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_prev_mailzine.gif" alt="이전 메일진" /></a></p>
					<% End If %>

					<% If vNextIdx = "0" Then %>
						<p class="next"><a href="javascript:alert('현재 보시는 글이 최신글입니다.');" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_next_mailzine.gif" alt="다음 메일진" /></a></p>
					<% ElseIf arrow = "0" Then %>
						<p class="next"><a href="shoppingchance_mailzine.asp?page=<%=page%>&arrow=<%=Replace(arrow-1,"-1","9")%>&idx=<%=vNextIdx%>&code1=<%=code1%>&code2=<%=code2%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_next_mailzine.gif" alt="다음 메일진" /></a></p>
					<% Else %>
						<p class="next"><a href="shoppingchance_mailzine.asp?page=<%=page%>&arrow=<%=Replace(arrow-1,"-1","9")%>&idx=<%=vNextIdx%>&code1=<%=code1%>&code2=<%=code2%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_next_mailzine.gif" alt="다음 메일진" /></a></p>
					<% End If %>

					</div>
				</div>
			</div>
		</div>
	</div>
<% Set Lomail = nothing %>
<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
