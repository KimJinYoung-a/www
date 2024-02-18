<%
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

	Dim oEval, vEvalTitle, sortMethod
	If sortMethod="" Then sortMethod="ne"
	If (IsPresentItem) Then 'Present상품
		vEvalTitle = "10x10 Present 후기"
	ElseIf (Not IsTicketItem) Then '티켓아닌경우 - 일반상품
		vEvalTitle = "상품 후기"
	Else
		vEvalTitle = "후기"
	End If

	'// 상품후기 총 평가점수
	dim vFdEvalTT, vFdEvalFun, vFdEvalDgn, vFdEvalPrc, vFdEvalStf
	vFdEvalTT=0: vFdEvalFun=0: vFdEvalDgn=0: vFdEvalPrc=0: vFdEvalStf=0

	if oItem.Prd.FEvalCnt>0 then
		Set oEval = new CEvaluateSearcher
		oEval.FRectItemID = itemid
		oEval.getItemEvalTotalPoint

		if oEval.FResultCount>0 then
			vFdEvalTT = chkIIF(oEval.FEvalItem.FTotalPoint="" or isNull(oEval.FEvalItem.FTotalPoint),"0",oEval.FEvalItem.FTotalPoint)
			vFdEvalFun = chkIIF(oEval.FEvalItem.FPoint_fun="" or isNull(oEval.FEvalItem.FPoint_fun),"0",oEval.FEvalItem.FPoint_fun)
			vFdEvalDgn = chkIIF(oEval.FEvalItem.FPoint_dgn="" or isNull(oEval.FEvalItem.FPoint_dgn),"0",oEval.FEvalItem.FPoint_dgn)
			vFdEvalPrc = chkIIF(oEval.FEvalItem.FPoint_prc="" or isNull(oEval.FEvalItem.FPoint_prc),"0",oEval.FEvalItem.FPoint_prc)
			vFdEvalStf = chkIIF(oEval.FEvalItem.FPoint_stf="" or isNull(oEval.FEvalItem.FPoint_stf),"0",oEval.FEvalItem.FPoint_stf)
		end if
		Set oEval = Nothing
	end if

	'//상품 후기
	set oEval = new CEvaluateSearcher
	oEval.FPageSize = 5
	oEval.FCurrpage = 1
	oEval.FRectItemID = itemid
	oEval.FEvalDiv = "a"
	oEval.FsortMethod = sortMethod
		'상품 후기가 있을때만 쿼리.
		if oItem.Prd.FEvalCnt>0 then
			oEval.getItemEvalList
		end if

dim arrUserid, bdgUid, bdgBno
			
'/상품고시관련 상품후기 제외 상품
dim Eval_excludeyn : Eval_excludeyn="N"
	Eval_excludeyn=getEvaluate_exclude_Itemyn(itemid)
%>

<script type="text/javascript">

	function fnChgEvalMove(pg) {		
		var sortMt = $("#sortMethod").val();
		var evalDiv = $("#evaldiv").val();
		var evalOpt = $("#evalopt").val();
		var str = $.ajax({
			type: "GET",
			url: "/shopping/act_itemEvaluate.asp",
			data: "itemid=<%=itemid%>&sortMtd="+sortMt+"&itemoption="+evalOpt+"&page="+pg+"&evaldiv="+evalDiv,
			dataType: "text",
			async: false
		}).responseText;

		if(str!="") {
			$("#lyEvalContAll").empty().append(str);
			<%
			'//상품고시관련 상품후기 제외 상품이 아닐경우
			if Eval_excludeyn="N" then
			%>
				// 상품후기
				if(evalDiv == 'p'){
					$(".talkList .talkMore").show();
				}else{
					$(".talkList .talkMore").hide();
				}
				$(".talkList .talkShort").unbind("click").click(function(){
					if($(this).parent().parent().next('.talkMore').is(":hidden")){
						$(".talkList .talkMore").hide();
						$(this).parent().parent().next('.talkMore').show();
					}else{
						$(this).parent().parent().next('.talkMore').hide();
					};

					// 클릭 위치가 가려질경우 스크롤 이동
					if($(window).scrollTop()>$(this).parent().parent().offset().top-47) {
						$('html, body').animate({scrollTop:$(this).parent().parent().offset().top-47}, 'fast');
					}
				});
			<%
			'//상품고시관련 상품후기 제외 상품일경우
			else
			%>
				// 건강/식품/의료기기 추가작업
				$(".healthReview .onlyPhotoReview").hide();
			<% end if %>

			//위치 확인
			if($("#detail02").offset().top < $(window).scrollTop()) {
				$('html,body').animate({scrollTop: $("#detail02").offset().top},'fast');
			}
		}
	}

	function chgEvalVal(md) {
		if(md=="p") {
			$("#evaldiv").val("p");
			$("#lyEvalSelBox").hide();
			$("#evalall").removeClass("on");
			$("#evaloff").removeClass("on");
			$("#evalph").addClass("on");
			$("#lyEvalAll").hide();
		}else if(md=="a") {
			$("#evaldiv").val("a");
			$("#lyEvalSelBox").show();
			$("#lyEvalAll").show();
			$("#evalall").addClass("on");
			$("#evalph").removeClass("on");
			$("#evaloff").removeClass("on");
		}else {
			$("#evaldiv").val("o");
			$("#lyEvalSelBox").show();
			$("#lyEvalAll").show();
			$("#evalall").removeClass("on");
			$("#evalph").removeClass("on");
			$("#evaloff").addClass("on");
		}
		fnChgEvalMove(1);
	}

	function popEvalList() {
		popEvaluate('<%= itemid %>',$("#sortMethod").val());
	}

	<%'// 후기 check 2017-05-23 이종화 %>
	function chk_myeval(v){
		$.ajax({
			type: "POST",
			url:"/shopping/act_myEval.asp?itemid="+v,
			dataType: "text",
			async: false,
	        success: function (str) {
	        	reStr = str.split("|");
				if(reStr[0]=="01"){
					alert(reStr[1]);
					return false;
				}else if (reStr[0]=="02"){
					if(confirm(reStr[1])){
					    location.href = '/login/loginpage.asp?backpath=' + encodeURIComponent(location.pathname + location.search);
					}
					return false;
				}else if (reStr[0]=="03"){
					alert(reStr[1]);
					return false;
				}else if (reStr[0]=="04"){
					alert(reStr[1]);
					AddEval(reStr[2],reStr[3],reStr[4],reStr[5]);
					return false;
				}else if (reStr[0]=="05"){
					AddEval(reStr[2],reStr[3],reStr[4],reStr[5]);
					return false;
				}else if (reStr[0]=="06"){
					alert(reStr[1]);
					return false;
				}else{
					alert("잘못된 오류입니다.");
					return false;
				}
	        }
		});
	}
</script>
<div class="section review pdtReviewV15" id="detail02">
	<% if Eval_excludeyn="N" then '//일반상품 %><h3><%=vEvalTitle%> </h3><% end if %>
	<div class="sorting tMar05">
		<% if Eval_excludeyn="N" then '//일반상품 %>
		<ul class="tabMenuV15">
			<li><a href="" onclick="chgEvalVal('a'); return false;" id="evalall" class="on">전체 (<strong><%= formatNumber(oItem.Prd.FEvalCnt,0) %></strong>)</a></li>
			<li><a href="" onclick="chgEvalVal('p'); return false;" id="evalph">포토 (<strong><%= formatNumber(oItem.Prd.FEvalCnt_photo,0) %></strong>)</a></li>
            <% If Not isBizItem Then %>
			    <li><a href="" onclick="chgEvalVal('o'); return false;" id="evaloff">매장 (<strong><%= formatNumber(oItem.Prd.FEvalOffCnt,0) %></strong>)</a></li>
			<% End If %>
		</ul>
		<% else		'//상품고시관련 상품후기(음식,식약품) %>
		<h3>상품 총 평점 <span class="fn fs11">(<strong><%= formatNumber(oItem.Prd.FEvalCnt,0) %></strong>개 상품 후기 기준)</span></h3>
		<% end if %>
		<input type="hidden" id="evaldiv" value="a">
		<input type="hidden" id="sortMethod" value="ne">
		<input type="hidden" id="evalopt" value="">

		<div class="option">
		<% if Eval_excludeyn="N" then %>
			<%=getItemEvalOptSelectbox("itemoption","",itemid,"title=""상품옵션 선택"" class=""optSelect2"" onchange=""$('#evalopt').val(this.value);fnChgEvalMove(1)""")%>

			<span id="lyEvalSelBox">
			<select name="sortMtd" title="상품 후기 정렬 옵션" class="optSelect2" onchange="$('#sortMethod').val(this.value);fnChgEvalMove(1)">
				<option value="ne">최신후기순</option>
				<option value="be">우수상품후기순</option>
			</select>
			</span>
		<% end if %>

			<% IF oEval.FResultCount>0 then %>
			<span id="lyEvalAll"><a href="" onclick="popEvalList(); return false;" class="btn btnS2 btnGry2">상품후기 전체보기</a></span>
			<% end if %>
			<a href="" onclick="chk_myeval('<%=itemid%>');return false;"  class="btn btnS2 btnRed"><span class="whiteArr03">후기 작성하기</span></a>
		</div>
	</div>
	<span id="lyEvalContAll">
	<%
		'//일반 상품 후기
		If Eval_excludeyn="N" then
	%>
		<table class="talkList">
			<caption>상품후기 목록</caption>
			<colgroup>
				<col width="140" /><col width="" /><col width="116" /><col width="120" /><col width="95" />
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
			<% if oEval.FResultCount > 0 then %>
			<%
				'사용자 아이디 모음 생성(for Badge)
				for i = 0 to oEval.FResultCount -1
					arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oEval.FItemList(i).FUserID) & "''"
				next

				'뱃지 목록 접수(순서 랜덤)
				Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

				for i = 0 to oEval.FResultCount - 1
			%>
			<tr>
				<td><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FTotalPoint%>.png" alt="별<%=oEval.FItemList(i).FTotalPoint%>개" /></td>
				<td class="lt">
					<% if Not(oEval.FItemList(i).FOptionName="" or isNull(oEval.FItemList(i).FOptionName)) then %>
					<p class="purchaseOption talkShort">구매옵션 : <%=oEval.FItemList(i).FOptionName%></p>
					<% end if %>
					<a href="" onclick="return false;" class="talkShort"><%= eva_db2html(oEval.FItemList(i).getUsingTitle(50)) %><% if oEval.FItemList(i).IsPhotoExist then %> <img src="http://fiximage.10x10.co.kr/web2013/common/ico_photo.gif" alt="포토" /><% End If %></a>
				</td>
				<td><%= FormatDate(oEval.FItemList(i).FRegdate,"0000/00/00") %><% If oEval.FItemList(i).FShopName<>"" Then %> <p class="offshop cMt0V15"><% = oEval.FItemList(i).FShopName %></p><% End If %></td>
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
								<% If (Not IsTicketItem) Then %>
								<li><span>기능</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_fun%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_fun%>개" /></li>
								<li><span>디자인</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_dgn%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_dgn%>개" /></li>
								<li><span>가격</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_prc%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_prc%>개" /></li>
								<li><span>만족도</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_stf%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_stf%>개" /></li>
								<% Else %>
								<li></li>
								<% End If %>
							</ul>
							
						</div>
						<div class="comment">
							<% if Not(oEval.FItemList(i).FOptionName="" or isNull(oEval.FItemList(i).FOptionName)) then %>
							<div class="purchaseOption"><em><strong>구매옵션</strong> : <%=oEval.FItemList(i).FOptionName%></em></div>
							<% end if %>
							<div class="textArea"><p><% = eva_db2html(nl2br(oEval.FItemList(i).FUesdContents)) %></p></div>
							<% if oEval.FItemList(i).Flinkimg1<>"" then %>
							<div class="imgArea"><img src="<%=getStonThumbImgURL(oEval.FItemList(i).getLinkImage1,550,0,"","")%>" alt="file1<% = i %>" /></div>
							<% end if %>
							<% if oEval.FItemList(i).Flinkimg2<>"" then %>
							<div class="imgArea"><img src="<%=getStonThumbImgURL(oEval.FItemList(i).getLinkImage2,550,0,"","")%>" alt="file2<% = i %>" /></div>
							<% end if %>
							<% if oEval.FItemList(i).Flinkimg3<>"" then %>
							<div class="imgArea"><img src="<%=getStonThumbImgURL(oEval.FItemList(i).getLinkImage3,550,0,"","")%>" alt="file3<% = i %>" /></div>
							<% end if %>
							<% If GetLoginUserID = oEval.FItemList(i).FUserID Then %>
							<div class="btnArea"><a href="/my10x10/goodsusing.asp?EvaluatedYN=Y" class="btn btnS2 btnGry2"><span class="fn">수정</span></a></div>
							<% End If %>
							<% If now() >= "2018-09-04" And now() < "2018-09-05" Then %>
								<%' temp-M-20180903 : 상품후기 '도움이 돼요' '도움 안돼요' 버튼추가(sy) %>
								<div class="btn-group"><button class="btnV18 btn-line-grey" onclick="fnAmplitudeEventMultiPropertiesAction('click_like_in_product','itemid','<%=itemid%>');return false;">도움이 돼요</button><button class="btnV18 btn-line-red" onclick="fnAmplitudeEventMultiPropertiesAction('click_dislike_in_product','itemid','<%=itemid%>');return false;">도움 안 돼요</button></div>
								<%'// temp-M-20180903 : 상품후기 '도움이 돼요' '도움 안돼요' 버튼추가(sy) %>
							<% End If %>
						</div>
					</div>
				</td>
			</tr>
			<%
					Next
				else
			%>
			<tr>
				<td colspan="5" class="noData">
				    <strong>등록된 상품 후기가 없습니다</strong>
				    <% If Not isBizItem Then %>
				        <br />구매고객님, 첫 후기 작성 시 마일리지 200Point를 드립니다.
				    <% End If %>
                </td>
			</tr>
			<% end if %>
			</tbody>
		</table>
	<%
		'//상품고시관련 상품후기 제외 상품일경우
		else
	%>
		<table class="healthReview tMar05">
			<caption>상품후기 목록</caption>
			<colgroup>
				<col width="140" /><col width="20%" /><col width="20%" /><col width="20%" /><col width="20%" />
			</colgroup>
			<thead>
			<tr>
				<th scope="col" class="generalV15">총평</th>
				<th scope="col">기능</th>
				<th scope="col">디자인</th>
				<th scope="col">가격</th>
				<th scope="col">만족도</th>
			</tr>
			</thead>
			<tbody>
			<% if oEval.FResultCount > 0 then %>
			<tr>
				<td class="generalV15"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalTT)%>.png" alt="별<%=cInt(vFdEvalTT)%>개"></td>
				<td><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalFun)%>.png" alt="별<%=cInt(vFdEvalFun)%>개"></td>
				<td><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalDgn)%>.png" alt="별<%=cInt(vFdEvalDgn)%>개"></td>
				<td><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalPrc)%>.png" alt="별<%=cInt(vFdEvalPrc)%>개"></td>
				<td><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalStf)%>.png" alt="별<%=cInt(vFdEvalStf)%>개"></td>
			</tr>
			<%
				else
			%>
			<tr>
				<td colspan="5" class="noData">
                    <strong>등록된 상품 후기가 없습니다</strong>
                    <% If Not isBizItem Then %>
                        <br />구매고객님, 첫 후기 작성 시 마일리지 200Point를 드립니다.
                    <% End If %>
                </td>
			</tr>
			<% end if %>
			</tbody>
		</table>
		<p class="tPad10 rt">* 주관적인 의견에 의해 기능 및 효과에 대한 오해의 소지가 있는 상품은 후기를 게시하지 않습니다.</p>
	<%
		end if
	%>
	<% if Eval_excludeyn="N" and oEval.FResultCount > 0 then %>
	<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(oEval.FCurrpage,oEval.FTotalCount,oEval.FPageSize,10,"fnChgEvalMove") %></div>
	<% end if %>
	</span>
</div>
<script type="text/javascript">
//상품 별점 수정
$("#rtRvImg").attr("src","//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalTT)%>.png");
//후기 영역 더블클릭 해제
$("#detail02").dblclick(function(e){
	e.preventDefault(); return false;
});
</script>
<%
Set oEval = Nothing
%>