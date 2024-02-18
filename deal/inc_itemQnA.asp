<%
	Dim oQna, QnaTotalCNT

	QnaTotalCNT=0
	'//상품 문의
	set oQna = new CItemQna

	''스페셜 브랜드일경우 상품 문의 불러오기
	If (oItem.Prd.IsSpecialBrand and oItem.Prd.FQnaCnt>0) Then
		oQna.FRectItemID = itemid
		oQna.FPageSize = 5
		oQna.ItemQnaList
	End If
	Dim BasicQAItemID
'	If oItem.Prd.IsSpecialBrand then
%>
<script type="text/javascript">
<!--
	// 탭표시
	$("#lyQnACnt").html("<%=oQna.FTotalCount%>");
	$("#tab04").show();

	// 페이지이동
	function fnChgQnAMove(pg) {
		var itemid=$("#qitemid").val();
		var str = $.ajax({
			type: "GET",
			url: "/deal/act_itemQnA.asp",
			data: "itemid="+itemid+"&page="+pg,
			dataType: "text",
			async: false
		}).responseText;

		if(str!="") {
			$("#lyQnAContAll").html(str);
			$(".talkList .talkMore").hide();
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

			//위치 확인
			//if($("#detail04").offset().top < $(window).scrollTop()) {
			//	$('html,body').animate({scrollTop: $("#detail04").offset().top},'fast');
			//}
		}
	}

	// 상품문의 메일 체크
	function check_form_email(email){

		var pos;
		pos = email.indexOf('@');
		if (pos < 0){				//@가 포함되어 있지 않음
			return(false);
		} else {
			pos = email.indexOf('@', pos + 1)
			if (pos >= 0){			//@가 두번이상 포함되어 있음
				return(false);
			}
		}

		pos = email.indexOf('.');
		if (pos < 0){				//@가 포함되어 있지 않음
			return false;
		}
		return(true);
	}

	// 상품 문의 등록
	function GotoItemQnA(){
		var frm = document.qnaform;

		if($("#qnaEmail").is(":checked")) {
			if (frm.usermail.value == "") {
				alert("이메일을 입력하세요.");
				frm.usermail.focus();
				 return;
			}

			if(!check_form_email(frm.usermail.value)){
				alert("이메일 형식이 올바르지 않습니다.");
				frm.usermail.focus();
				return;
			}
		}


		if($("#qnaHp").is(":checked")) {
			if ((frm.userhp1.value == "") || (frm.userhp2.value == "") || (frm.userhp3.value == "")) {
				alert("핸드폰번호를 입력하세요.");
				frm.userhp1.focus();
				 return;
			}

			var hp = frm.userhp1.value + "-" + frm.userhp2.value + "-" + frm.userhp3.value;
				if ((validateHP(hp) != true) && (hp != "--")) {
				alert("잘못된 핸드폰번호입니다.");
				frm.userhp1.focus();
				return;
			}
		}

		if(frm.contents.value.length < 1){
			alert("내용을 적어주셔야 합니다.");
			frm.contents.focus();
			return;
		}

		if(confirm("상품에 대해 문의 하시겠습니까?")){
			frm.submit();
		}
	}

	// 상품문의 쓰기 취소
	function cancelItemQnA(inum,itotal) {
		var frm = document.qnaform;
		frm.contents.value = "";
		$("#inquiryForm").hide();
	}

	// 상품 문의 삭제
	function delItemQna(iid){
		if(confirm("상품문의를 삭제 하시겠습니까?")){
			document.qnaform.id.value = iid;
			document.qnaform.mode.value = "del";
			document.qnaform.submit();
		}
	}

	// 상품 문의 수정
	function modiItemQna(iid,itotal){
		if ($("#inquiryForm").css("display")=="none"){
			$.ajax({
				type: "GET",
				url: "/shopping/act_ItemQnA_XML.asp?idx=" + iid,
				dataType: "xml",
				cache: false,
				async: false,
				timeout: 5000,
				success: function(xml) {
					// 상품문의 쓰기 내용 접수/넣기
					if($(xml).find("list").find("item").length>0) {
						$("#inquiryForm").show();

						// item노드 폼에 대입
						document.qnaform.usermail.value=$(xml).find("list").find("item").find("email").text();
						if($(xml).find("list").find("item").find("emailchk").text()=="Y") {
							$("#qnaEmail")[0].checked = true;
							$("#emailok").val('Y');
						} else {
							$("#qnaEmail")[0].checked = false;
							$("#emailok").val('N');
						}

						document.qnaform.qnaSecret.value=$(xml).find("list").find("item").find("secretchk").text();
						if($(xml).find("list").find("item").find("secretchk").text()=="Y") {
							$("#qnaSecret")[0].checked = true;
							$("#secretyn").val('Y');
						} else {
							$("#qnaSecret")[0].checked = false;
							$("#secretyn").val('N');
						}
						
						var uhp = $(xml).find("list").find("item").find("userhp").text();
						if(uhp!='') {
							uhp = uhp.split("-");
							document.qnaform.userhp1.value=uhp[0];
							document.qnaform.userhp2.value=uhp[1];
							document.qnaform.userhp3.value=uhp[2];
						}

						document.qnaform.contents.value=$(xml).find("list").find("item").find("contents").text();

						// 폼 값변경
						document.qnaform.id.value = iid;
						document.qnaform.mode.value = "modi";
					}
				}
			});
		} else {
			$("#inquiryForm").hide();
		}

	}

	function validateHP(phone) {
		var re = /^[0-9]{2,4}-[0-9]{2,4}-[0-9]{2,4}$/;
		return re.test(phone);
	}

	function fnQnaChangList(qitemid){
		//alert(qitemid);
		$('#qitemid').val(qitemid);
		$('#qaitemid').val(qitemid);
		fnChgQnAMove(1);
	}

//-->
</script>
<div class="section qnaV15" id="detail03">
	<div class="sorting">
		<h3>Q&amp;A <span class="fn fs11">(<strong id="qacurrentcnt"><%=formatNumber(oQna.FTotalCount,0)%></strong>/<strong id="qatotalcnt"><%=formatNumber(oQna.FTotalCount,0)%></strong>)</span></h3>
		<input type="hidden" id="qitemid" value="<%=ArrDealItemQNA(0,0)%>" />
		<div class="option">
			<% If isArray(ArrDealItemQNA) Then %>
			<div class="dropDown">
				<button type="button" class="btnDrop" id="qabtn">[상품1] <%=ArrDealItemQNA(1,0)%></button>
				<div class="dropBox multi">
					<ul>
						<% For intLoop = 0 To UBound(ArrDealItemQNA,2) %>
						<%
							If intLoop=0 Then BasicQAItemID=ArrDealItemQNA(0,intLoop)
							QnaTotalCNT = QnaTotalCNT + ArrDealItemQNA(2,intLoop)
						%>
						<li><a href="" onClick="fnQnaChangList(<%=ArrDealItemQNA(0,intLoop)%>);return false;"><div class="option">[상품<%=intLoop+1%>] <%=ArrDealItemQNA(1,intLoop)%> <em class="value"><%=FormatNumber(ArrDealItemQNA(2,intLoop),0)%>건</em></div></a></li>
						<% Next %>
					</ul>
				</div>
			</div>
			<% End If %>
			<a href="" onclick="return false;" id="inquiryBtn" class="btn btnS2 btnRed"><span class="whiteArr03 fn">상품 문의하기</span></a>
		</div>
	</div>
	<div id="inquiryForm" class="boardForm tMar05">
		<form name="qnaform" method="post" action="/my10x10/doitemqna.asp" onsubmit="return false;">
		<input type="hidden" name="id" value="" />
		<input type="hidden" name="itemid" id="qaitemid" value="<% = BasicQAItemID %>" />
		<input type="hidden" name="cdl" value="<%= oItem.Prd.FcdL %>" />
		<input type="hidden" name="disp" value="<%= oItem.Prd.FcateCode %>" />
		<input type="hidden" name="qadiv" value="02" />
		<input type="hidden" name="mode" value="write" />
		<fieldset>
		<legend>상품문의 입력 폼</legend>
			<div class="sorting">
				<h4><strong>상품문의</strong></h4>

				<div class="option">
					<input type="hidden" id="emailok" name="emailok" value="N">
					<input type="hidden" id="secretyn" name="secretyn" value="N">
					<span>
						<input type="checkbox" name="qnaEmail" class="check" id="qnaEmail" onclick="jsQNACheck('e');" /> <label for="qnaEmail">이메일 답변 받기</label>
						<input type="text" name="usermail" title="이메일" value="<% = GetLoginUserEmail %>" class="txtInp emailInfo"  onclick="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> />
					</span>
					<span class="lPad20"><input type="checkbox" class="check" id="qnaSecret" name="qnaSecret" onclick="jsQNACheck('s');" /> <label for="qnaSecret">비밀글로 문의하기</label></span>
				</div>
			</div>
			<div>
				<textarea name="contents" id="qnaMsg" cols="100" rows="6" onclick="jsCheckLimit();" <%=chkIIF(NOT(IsUserLoginOK),"readonly","")%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%END IF%></textarea>
			</div>
			<ul class="list01V15">
				<li>주문 후 주문/배송/취소 등에 관한 문의는 마이텐바이텐 &gt; <a href="/my10x10/qna/myqnalist.asp">1:1 상담</a>을 이용해주시기 바랍니다. <a href="/my10x10/qna/myqnalist.asp" class="more2V15">주문/배송/취소 문의</a></li>
				<li>고객님이 작성하신 문의 및 답변은 마이텐바이텐 &gt; <a href="/my10x10/myitemqna.asp">상품 Q&amp;A</a> 에서도 확인이 가능합니다.</li>
				<li>텐바이텐 APP을 이용하시면 좀 더 편리하게 답변을 받으실 수 있습니다.</li>
				<li>상품과 관련없는 문의는 강제 삭제 될 수 있습니다.</li>
			</ul>
			<div class="btnArea ct tMar30">
				<a href="" class="btn btnS1 btnRed btnW100" onclick="<% IF IsUserLoginOK THEN %>GotoItemQnA();<% ELSE %>jsCheckLimit();<% End IF%>return false;">등록</a>
				<a href="" class="btn btnS1 btnGry btnW100" onclick="$('#inquiryForm').hide();return false;">취소</a>
			</div>
		</fieldset>
		</form>
	</div>

	<span id="lyQnAContAll">
		<table class="talkList">
			<caption>Q&amp;A 목록</caption>
			<colgroup>
				<col width="140" /> <col width="" /> <col width="90" /> <col width="120" />
			</colgroup>
			<thead>
			<tr>
				<th scope="col">답변여부</th>
				<th scope="col">답변내용</th>
				<th scope="col">작성일자</th>
				<th scope="col">작성자</th>
			</tr>
			</thead>
			<tbody>
		<% if oQna.FTotalCount>0 then  %>
			<% for i = 0 to oQna.FResultCount - 1 %>
			<tr <%=chkIIF(oQna.FItemList(i).Fsecretyn="Y","class='secretV17'","")%>>
				<td><% if oQna.FItemList(i).IsReplyOk then %><strong>&lt;답변완료&gt;</strong><% else %><strong class="cr999">&lt;답변중&gt;</strong><% end if %></td>
				<td class="lt">
					<% if oQna.FItemList(i).Fsecretyn="Y" and LoginUserid <> oQna.FItemList(i).FUserid then %>
						비밀글 입니다.
					<% else %>
						<a href="javascript:" class="talkShort"><% = oQna.FItemList(i).FTitle %></a>
					<% end if %>
				</td>
				<td><%= FormatDate(oQna.FItemList(i).FRegdate,"0000/00/00") %></td>
				<td><%= printUserId(oQna.FItemList(i).FUserid,2,"*") %></td>
			</tr>
			<tr class="talkMore <%=chkIIF(oQna.FItemList(i).Fsecretyn="Y","secretV17","")%>">
				<td colspan="4">
					<div class="qnaList">
						<div class="question">
							<strong class="title"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_q.png" alt="질문" /></strong>
							<div class="account">
								<% if oQna.FItemList(i).Fsecretyn="Y" and LoginUserid <> oQna.FItemList(i).FUserid then %>
									비밀글 입니다.
								<% else %>
									<p><% = nl2br(oQna.FItemList(i).FContents) %></p>
								<% end if %>
								<% if (LoginUserid<>"") and (LoginUserid=oQna.FItemList(i).FUserid) then %>
								<div class="btnArea">
									<% IF Not(oQna.FItemList(i).IsReplyOk) THEN %><a href="" class="btn btnS2 btnGry2" onclick="modiItemQna('<%= oQna.FItemList(i).Fid %>','<% = oQna.FResultCount + 1 %>');return false;"><span class="fn">수정</span></a><% end if %>
									<a href="javascript:" class="btn btnS2 btnGry2" onclick="delItemQna('<%= oQna.FItemList(i).Fid %>');"><span class="fn">삭제</span></a>
								</div>
								<% end if %>
							</div>
						</div>
						<% IF oQna.FItemList(i).IsReplyOk THEN %>
						<div class="answer">
							<strong class="title"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_a.png" alt="답변" /></strong>
							<div class="account">
							<% if oQna.FItemList(i).Fsecretyn="Y" then %>
								<% if LoginUserid = oQna.FItemList(i).FUserid then %>
									<p><%= nl2br(oQna.FItemList(i).FReplycontents) %></p>
								<% else %>
									<p>비밀글 입니다.</p>
								<% end if %>
							<% else %>
								<p><%= nl2br(oQna.FItemList(i).FReplycontents) %></p>
							<% end if %>
							</div>
						</div>
						<% end if %>
					</div>
				</td>
			</tr>
			<% Next %>
		<% else %>
			<tr>
				<td colspan="4" class="noData"><strong>등록된 상품 문의가 없습니다</strong></td>
			</tr>
		<% end if %>
			</tbody>
		</table>
		<% if oQna.FTotalCount>0 then  %>
		<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(oQna.FCurrpage,oQna.FTotalCount,oQna.FPageSize,10,"fnChgQnAMove") %></div>
		<% end if %>
	</span>
</div>
<script>
$(function(){
	fnChgQnAMove(1);
	$("#qatotalcnt").empty().append("<%=formatNumber(QnaTotalCNT,0)%>");
	$("#lyQnATotalCnt").empty().append("<%=formatNumber(QnaTotalCNT,0)%>");
});
</script>
<%
'	end if
	set oQna = Nothing
%>