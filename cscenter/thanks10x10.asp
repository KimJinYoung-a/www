<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2010.04.08 한용민 생성
'             2013.09.17 허진원 2013리뉴얼
'	Description : culturestation
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 고객센터 - 고마워 텐바이텐"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/culturestation/_culturestation_class.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
dim oip, searchFlag, page, evt_type, listisusing, i

evt_type = "T"		'고마워텐텐 지정

	page = getNumeric(requestCheckVar(request("page"),5))
	searchFlag = requestCheckVar(request("sf"),2)
	if page = "" then page = 1
		
set oip = new cthanks10x10_list
	oip.FPageSize = 5
	oip.FCurrPage = page
	oip.FsearchFlag = searchFlag
	oip.fthanks10x10_list()									
%>
<script type="text/javascript">
// 글짜수 제한 
	function reg(){
		if(frmcontents.contents.value =="로그인 후 글을 남길 수 있습니다."){
		jsChklogin('<%=IsUserLoginOK%>');
		return;
		}

		if(!$("input[name='gubun']:checked").length){
			alert("구분을 선택해주세요.");
			return;
		}

		if (GetByteLength(frmcontents.contents.value) > 2000){
			alert("내용이 제한길이를 초과하였습니다. 1000자 까지 작성 가능합니다.");
			frmcontents.contents.focus();
		}else if(frmcontents.contents.value ==''){
			alert("글을 작성해 주세요.");
			frmcontents.contents.focus();
		}else{
		document.frmcontents.target = 'view';
		document.frmcontents.submit();	
		}
	}

// 고객글 삭제하기
	function delete_comment(idx){
	var ret;
	ret = confirm('해당 글을 삭제 하시겠습니까?');
	
	if (ret){
		document.frmcontents.target = 'view';
		document.frmcontents.idx.value = +idx
		document.frmcontents.submit();
	}
}

// 클릭 확인
	function jsCheckLimit() {
		if ("<%=IsUserLoginOK%>"=="False") {
			jsChklogin('<%=IsUserLoginOK%>');
		}
	}
	
	function jsGoPage(iP){
		document.pageFrm.page.value = iP;
		document.pageFrm.submit();
	}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container culture-stationV17"><!-- 20170725 -->
		<div id="contentWrap">
			<div class="csHeader">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_cs_center.gif" alt="고객행복센터" /></h2>
				<p><img src="http://fiximage.10x10.co.kr/web2013/cscenter/txt_cs_center.gif" alt="기분 좋은 쇼핑이 될 수 있도록 정성을 다하겠습니다." /></p>
			</div>
			<div class="csContent">
				<!-- #include virtual="/lib/inc/incCsLnb.asp" -->
				<!-- content -->
				<div class="content">
					<h3><img src="http://fiximage.10x10.co.kr/web2017/cscenter/tit_thankyou.png" alt="고마워! 텐바이텐!" /></h3><!-- 20170725 -->

					<!-- 칭찬 글 입력하기 -->
					<div class="thankyouWrite">
						<form name="frmcontents" method="post" action="/culturestation/culturestation_thanks10x10_process.asp" style="margin:0px;">
						 <input type="hidden" name="idx">
						<fieldset>
						<legend>텐바이텐 칭찬 글 남기기</legend>
							<ul class="commnetIcon">
								<li>
									<label for="thankyou01"><img src="http://fiximage.10x10.co.kr/web2013/culturestation/ico_thankyou_01.gif" alt="Best Friend" /></label>
									<input type="radio" id="thankyou01" name="gubun" value="0" class="radio" />
								</li>
								<li>
									<label for="thankyou02"><img src="http://fiximage.10x10.co.kr/web2013/culturestation/ico_thankyou_02.gif" alt="I love you" /></label>
									<input type="radio" id="thankyou02" name="gubun" value="1" class="radio" />
								</li>
								<li>
									<label for="thankyou03"><img src="http://fiximage.10x10.co.kr/web2013/culturestation/ico_thankyou_03.gif" alt="Very Good" /></label>
									<input type="radio" id="thankyou03" name="gubun" value="2" class="radio" />
								</li>
								<li>
									<label for="thankyou04"><img src="http://fiximage.10x10.co.kr/web2013/culturestation/ico_thankyou_04.gif" alt="Always Smile" /></label>
									<input type="radio" id="thankyou04" name="gubun" value="3" class="radio" />
								</li>
								<li>
									<label for="thankyou05"><img src="http://fiximage.10x10.co.kr/web2013/culturestation/ico_thankyou_05.gif" alt="Thank you" /></label>
									<input type="radio" id="thankyou05" name="gubun" value="4" class="radio" />
								</li>
							</ul>

							<div class="writeBox">
								<textarea name="contents" title="의견을 작성해주세요." cols="60" rows="5" style="width:576px; height:118px;" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();"<%IF NOT(IsUserLoginOK) THEN%> readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%END IF%></textarea><!-- 20170725 -->
								<input type="submit" value="보내기" class="btn" />
							</div>

							<ul class="noticeMsg">
								<li><span>&gt;</span> <strong>여러분들이 보내주신 소중한 칭찬 글은 텐바이텐이 감사의 답변을 작성한 후 함께 게시됩니다.</strong></li>
								<li class="crAAA"><span>&gt;</span> 통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있습니다.</li>
							</ul>
						</fieldset>
						</form>
					</div>
					<!-- //칭찬 글 입력하기 -->

					<!-- 칭찬 리스트 -->
					<div class="thankyouComment">
						<!-- 2013.09.23 : 내가쓴글보기/전체글보기 버튼 추가 -->
						<div class="btnArea">
						<%
							'//검색 필터
							if IsUserLoginOK then
								if searchFlag="my" then
						%>
							<a href="?page=1" class="btn btnS2 btnGrylight btnW120"><span class="fn gryArr01">전체 글 보기</span></a>
						<%		else %>
							<a href="?sf=my" class="btn btnS2 btnGrylight btnW120"><span class="fn gryArr01">내가 쓴 글 보기</span></a>
						<%
								end if
							end if
						%>
						</div>
					<% 
						dim idx_ix, arrThxNm
						arrThxNm = split("Best Friend,I love you,Very Good,Always Smile,Thank you",",")
						idx_ix = oip.ftotalcount 

						if oip.FResultCount > 0 then 
							for i = 0 to oip.FResultCount -1 
					%>
						<div class="comment">
							<div class="customer">
								<div class="ico"><img src="http://fiximage.10x10.co.kr/web2013/culturestation/ico_thankyou_<%=Num2Str(oip.FItemList(i).fgubun+1,2,"0","R")%>.gif" alt="<%=arrThxNm(oip.FItemList(i).fgubun)%>" /></div>
								<div class="msg">
									<p><%= nl2br(oip.FItemList(i).fcontents) %></p>
									<div class="date"><span><%= printUserId(oip.FItemList(i).fuserid,2,"*") %></span>, <span><%= FormatDate(oip.FItemList(i).freg_date,"0000/00/00") %></span></div>
									<% if cstr(GetLoginUserID) = cstr(oip.FItemList(i).fuserid) then %>
									<div class="btnDelete"><a href="" onclick="delete_comment(<%=oip.FItemList(i).fidx%>);return false;"><span class="btnListDel">삭제</span></a></div>
									<% end if %>
								</div>
							</div>
							<% if oip.FItemList(i).fcomment <> "" then %>
							<div class="tenbyten">
								<div class="tenten">
									<div class="ico"><img src="http://fiximage.10x10.co.kr/web2013/culturestation/ico_tenbyten.gif" alt="텐바이텐" /></div>
									<div class="msg">
										<p><%= nl2br(oip.FItemList(i).fcomment) %></p>
									</div>
								</div>
							</div>
							<% end if %>
						</div>

					<%
							Next
						Else
					%>
						<p class="noData"><strong>해당 게시물이 없습니다.</strong></p>
					<%
						End if
					%>
					</div>
					<!-- //칭찬 리스트 -->
					<div class="paging tMar20">
						<%= fnDisplayPaging_New_nottextboxdirect(page,oip.ftotalcount,5,10,"jsGoPage") %>
					</div>
				</div>
				<!-- //content -->

				<!-- #include virtual="/lib/inc/incCsQuickmenu.asp" -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="pageFrm" method="get" action="<%=CurrURL()%>" style="margin:0px;">
<input type="hidden" name="page" value="">
<input type="hidden" name="sf" value="<%=searchFlag%>">
</form>
<iframe id="view" name="view" width=0 height=0 frameborder="0" scrolling="no"></iframe>
</body>
</html>
<% set oip = nothing %>	
<!-- #include virtual="/lib/db/dbclose.asp" -->