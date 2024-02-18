<%

dim oEval,ix, intEval, oEvPhoto
set oEval = new CEvaluateSearcher

oEval.FPageSize = 5
oEval.FCurrpage = 1
oEval.FECode = eCode
oEval.GetTopEventGoodUsingList_B

	'//포토상품 후기
	set oEvPhoto = new CEvaluateSearcher
	oEvPhoto.FGubun = "count"
	oEvPhoto.FPageSize = 5
	oEvPhoto.FCurrpage = 1
	oEvPhoto.FsortMethod = "ph"
	oEvPhoto.FECode = eCode
	if (oEval.FResultCount>0) then
	    oEvPhoto.GetTopEventGoodUsingList_B
    end if
%>
<script language='javascript'>
<!--
$(function(){
	//상품 후기
	$(".talkList .talkMore").hide();
	$(".talkList .talkShort").click(function(){
		$(".talkList .talkMore").hide();
		$(this).parent().parent().next('.talkMore').show();
	});
});

function showhide(num, p_totcount)    {
	var imaxwidth = 600;

  	for (i=0; i<p_totcount; i++)   {
	  var menu=eval("document.all.evalu_block_"+i+".style");
	  if (num==i ) {
		if (menu.display==""){
			menu.display="none";
		}else{
		  menu.display="";
		}
	  }else{
		menu.display="none";
	  }
	}
}

function fnChgEvalMove(pg) {
	var sortMt = $("#sortMethod").val();
	var str = $.ajax({
		type: "GET",
		url: "/event/lib/evaluate_lib_act.asp",
		data: "ecode=<%=eCode%>&sortMtd="+sortMt+"&page="+pg,
		dataType: "text",
		async: false
	}).responseText;

	if(str!="") {
		if($("#sortMethod").val()=="ph") {
			$("#lyEvalContPhoto").empty().append(str);
		} else {
			$("#lyEvalContAll").empty().append(str);
		}
		// 상품후기
		$(".talkList .talkMore").hide();
		$(".talkList .talkShort").click(function(){
			$(".talkList .talkMore").hide();
			$(this).parent().parent().next('.talkMore').show();
		});
	}
}

function chgEvalVal(md) {
	if(md=="p") {
		$("#sortMethod").val("ph");
		$("#lyEvalContPhoto").show();
		$("#lyEvalContAll").hide();
		$("#evalall").removeClass("on");
		$("#evalph").addClass("on");
		fnChgEvalMove(1);
		<% if oEval.FTotalCount>0 then %>$("#lyEvalAll").hide();<% end if %>
	} else {
		$("#sortMethod").val("ne");
		$("#lyEvalAll").show();
		$("#lyEvalContAll").show();
		$("#lyEvalContPhoto").hide();
		$("#evalall").addClass("on");
		$("#evalph").removeClass("on");
	}
}

function isArray(obj){
  return obj instanceof Array
}

-->
</script>
	<div class="section review pdtReviewV15" id="detail02">
		<h3>상품 후기</h3>
		<div class="sorting tMar05">
			<ul class="tabMenuV15">
				<li><a href="javascript:chgEvalVal('a');" id="evalall" class="on">전체 (<strong><%= oEval.FTotalCount %></strong>)</a></li>
				<li><a href="javascript:chgEvalVal('p');" id="evalph">포토 후기 (<strong><%= oEvPhoto.FTotalCount %></strong>)</a></li>
			</ul>
			<input type="hidden" id="sortMethod" value="ne">
			<div class="option">
				<span class="badgeInfo addInfo"><strong>10x10 BADGE</strong>
					<div class="contLyr" style="width:210px;">
						<div class="contLyrInner">
							<dl class="badgeDesp">
								<dt><strong>10X10 BADGE?</strong></dt>
								<dd>
									<p>고객님의 쇼핑패턴을 분석하여 자동으로 달아드리는 뱃지입니다. <br />후기작성 및 코멘트 이벤트 참여시 획득한 뱃지를 통해 타인에게 신뢰 및 어드바이스를 전달 해줄 수 있습니다.</p>
									<p class="tPad10">나의 뱃지는 <a href="/my10x10/" target="_top" class="cr000 txtL">마이텐바이텐</a>에서 확인하실 수 있습니다.</p>
								</dd>
							</dl>
						</div>
					</div>
				</span>
				<% IF oEval.FResultCount>0 then %>
				<span id="lyEvalAll"><a href="/event/lib/popevaluateitem.asp?eventid=<%=eCode%>" onclick="window.open(this.href, 'popReviewAll', 'width=895, height=860, scrollbars=yes'); return false;" class="btn btnS2 btnGry2">상품후기 전체보기</a></span>
				<% end if %>
				<a href="/my10x10/goodsusing.asp" class="btn btnS2 btnRed">상품후기 쓰기</a>
			</div>
		</div>
		<span id="lyEvalContAll">
		<table class="talkList">
		<caption>상품후기 목록</caption>
		<colgroup>
			<col width="140" /><col width="" /><col width="90" /><col width="120" /><col width="95" />
		</colgroup>
		<thead>
		<tr>
			<th scope="col">평점</th>
			<th scope="col">내용</th>
			<th scope="col">작성일자</th>
			<th scope="col">작성자</th>
			<th scope="col">뱃지</th>
		</tr>
		</thead>
		<tbody>
		<%
			if oEval.FResultCount > 0 then
				'사용자 아이디 모음 생성(for Badge)
				dim arrUserid, bdgUid, bdgBno, i
				for i = 0 to oEval.FResultCount -1
					arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oEval.FItemList(i).FUserID) & "''"
				next

				'뱃지 목록 접수(순서 랜덤)
				Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

				for i = 0 to oEval.FResultCount - 1
		%>
				<tr>
					<td><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FTotalPoint%>.png" alt="별<%=oEval.FItemList(i).FTotalPoint%>개" /></td>
					<td class="lt"><a href="javascript:" class="talkShort"><%= chkiif(eva_db2html(oEval.FItemList(i).getUsingTitle(50))="",oEval.FItemList(i).FItemname,eva_db2html(oEval.FItemList(i).getUsingTitle(50))) %><% if oEval.FItemList(i).IsPhotoExist then %> <img src="//fiximage.10x10.co.kr/web2013/common/ico_photo.gif" alt="포토" /></a></td><% End If %>
					<td><%= FormatDate(oEval.FItemList(i).FRegdate,"0000/00/00") %></td>
					<td><%= printUserId(oEval.FItemList(i).FUserID,2,"*") %></td>
					<td>
						<p class="badgeView tPad01"><%=getUserBadgeIcon(oEval.FItemList(i).FUserID,bdgUid,bdgBno,3)%></p>
					</td>
				</tr>
				<tr class="talkMore">
					<td colspan="5">
						<div class="customerReview">
							<div class="rating">
								<ul>
									<li><span>기능</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_fun%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_fun%>개" /></li>
									<li><span>디자인</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_dgn%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_dgn%>개" /></li>
									<li><span>가격</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_prc%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_prc%>개" /></li>
									<li><span>만족도</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_stf%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_stf%>개" /></li>
								</ul>
							</div>

							<div class="comment">
								<% if Not(oEval.FItemList(i).FItemname="" or isNull(oEval.FItemList(i).FItemname)) then %>
								<h4><%=oEval.FItemList(i).FItemname%></h4>
								<% end if %>
								<% if Not(oEval.FItemList(i).FOptionName="" or isNull(oEval.FItemList(i).FOptionName)) then %>
								<div class="purchaseOption"><em>· 옵션 : <%=oEval.FItemList(i).FOptionName%></em></div>
								<% end if %>
								<div class="textArea"><p><% = eva_db2html(nl2br(oEval.FItemList(i).FUesdContents)) %></p></div>
								<% if oEval.FItemList(i).Flinkimg1<>"" then %>
								<div class="imgArea"><img src="<%= oEval.FItemList(i).getLinkImage1 %>" alt="file1<% = i %>" /></div>
								<% end if %>
								<% if oEval.FItemList(i).Flinkimg2<>"" then %>
								<div class="imgArea"><img src="<%= oEval.FItemList(i).getLinkImage2 %>" alt="file2<% = i %>" /></div>
								<% end if %>
								<% If GetLoginUserID = oEval.FItemList(i).FUserID Then %>
								<div class="btnArea"><a href="my10x10/goodsusing.asp?EvaluatedYN=Y" class="btn btnS2 btnGry2"><span class="fn">수정</span></a></div>
								<% End If %>
							</div>
						</div>
					</td>
				</tr>
			<% Next %>
		<% else %>
		<tr>
			<td colspan="5" class="noData"><strong>등록된 상품 후기가 없습니다</strong></td>
		</tr>
		<% end if %>
		</tbody>
		</table>

		<% if oEval.FResultCount > 0 then %>
		<div class="pageWrapV15 tMar20">
		<%= fnDisplayPaging_New(oEval.FCurrpage,oEval.FTotalCount,oEval.FPageSize,10,"fnChgEvalMove") %>
		</div>
		<% end if %>
		</span>
		<span id="lyEvalContPhoto" style="display:none;">
		</span>
	</div>

<%
set oEval = Nothing
set oEvPhoto = Nothing

function eva_db2html(checkvalue)
	dim v
	v = checkvalue
	if Isnull(v) then Exit function

    On Error resume Next
    v = replace(v, "&amp;", "&")
    v = replace(v, "&lt;", "<")
    v = replace(v, "&gt;", ">")
    v = replace(v, "&quot;", "'")
    v = Replace(v, "", "<br />")
    v = Replace(v, "\0x5C", "\")
    v = Replace(v, "\0x22", "'")
    v = Replace(v, "\0x25", "'")
    v = Replace(v, "\0x27", "%")
    v = Replace(v, "\0x2F", "/")
    v = Replace(v, "\0x5F", "_")
	'v = Replace(v, "><!", "&gt;&lt;!")
	v = Replace(v, ">", "&gt;")
	v = Replace(v, "<", "&lt;")
	v = Replace(v, "&lt;br&gt;", "<br>")
	v = Replace(v, "&lt;br/&gt;", "<br/>")
	v = Replace(v, "&lt;br /&gt;", "<br />")

    eva_db2html = v
end function
%>