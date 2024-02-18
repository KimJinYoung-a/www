<%
	Dim oTester

	'//테스터상품후기
	set oTester = new CEvaluateSearcher
		oTester.FPageSize = 5
		oTester.FCurrpage = 1
		oTester.FRectItemID = itemid
		oTester.FsortMethod = "ne"
		oTester.getItemEvalPopup()
		
If oTester.FTotalCount > 0 Then
%>
<script type="text/javascript">
<!--
	// 탭표시
	$("#lyTesterCnt").html("<b><%=oTester.FTotalCount%></b>");
	$("#tab03").show();

	// 페이지이동
	function fnChgTestEvMove(pg) {
		var str = $.ajax({
			type: "GET",
			url: "/shopping/act_testerEvaluate.asp",
			data: "itemid=<%=itemid%>&page="+pg,
			dataType: "text",
			async: false
		}).responseText;

		if(str!="") {
			$("#lyTesterContAll").empty().append(str);

			$(".talkList .talkMore").hide();
			$(".talkList .talkShort").unbind("click").click(function(){
				if($(this).parent().parent().next('.talkMore').is(":hidden")){
					$(".talkList .talkMore").hide();
					$(this).parent().parent().next('.talkMore').show();
				}else{
					$(this).parent().parent().next('.talkMore').hide();
				};
			});
		}
	}

	function popTesterEvalList() {
		popTestEvaluate('<%= itemid %>');
	}
//-->
</script>
<div class="section review testerReviewV15" id="detail03">
	<div class="sorting">
		<h3>테스터 후기 <span class="fn fs11">(<strong><%=formatNumber(oTester.FTotalCount,0)%></strong>)</span></h3>
		<div class="option">
		<% IF oTester.FResultCount>0 then %>
			<span><a href="" onclick="popTesterEvalList(); return false;" class="btn btnS2 btnGry2">테스터후기 전체보기</a></span>
		<% end if %>
		</div>
	</div>
	<span id="lyTesterContAll">
		<table class="talkList tMar05">
			<caption>테스터 후기 목록</caption>
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
				'사용자 아이디 모음 생성(for Badge)
				for i = 0 to oTester.FResultCount -1
					arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oTester.FItemList(i).FUserID) & "''"
				next

				'뱃지 목록 접수(순서 랜덤)
				Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

				for i = 0 to oTester.FResultCount - 1
			%>
			<tr>
				<td><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oTester.FItemList(i).FTotalPoint%>.png" alt="별<%=oTester.FItemList(i).FTotalPoint%>개" /></td>
				<td class="lt">
					<a href="" onclick="return false;" class="talkShort"><%= oTester.FItemList(i).getUsingTitle(45) %> <%=CHKIIF(oTester.FItemList(i).FIsPhoto="o"," <img src=""http://fiximage.10x10.co.kr/web2013/common/ico_photo.gif"" alt=""포토"" />","")%></a>
				</td>
				<td><%= FormatDate(oTester.FItemList(i).FRegdate, "0000/00/00") %></td>
				<td><%= printUserId(oTester.FItemList(i).FUserID,2,"*") %></td>
				<td>
					<p class="badgeView tPad01"><%=getUserBadgeIcon(oTester.FItemList(i).FUserID,bdgUid,bdgBno,3)%></p>
				</td>
			</tr>
			<tr class="talkMore">
				<td colspan="5">
					<div class="customerReview">
						<div class="rating">
							<ul>
								<li><span>기능</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oTester.FItemList(i).FPoint_fun%>.png" class="pngFix" alt="별<%=oTester.FItemList(i).FPoint_fun%>개" /></li>
								<li><span>디자인</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oTester.FItemList(i).FPoint_dgn%>.png" class="pngFix" alt="별<%=oTester.FItemList(i).FPoint_dgn%>개" /></li>
								<li><span>가격</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oTester.FItemList(i).FPoint_prc%>.png" class="pngFix" alt="별<%=oTester.FItemList(i).FPoint_prc%>개" /></li>
								<li><span>만족도</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oTester.FItemList(i).FPoint_stf%>.png" class="pngFix" alt="별<%=oTester.FItemList(i).FPoint_stf%>개" /></li>
							</ul>
						</div>
						<div class="comment">
							<div class="textArea">
								<ul class="reviewItem">
									<li>
										<strong>총평</strong>
										<p><% = nl2br(oTester.FItemList(i).FUesdContents) %></p>
									</li>
									<li>
										<strong>좋았던 점</strong>
										<p><% = nl2br(oTester.FItemList(i).FUseGood) %></p>
									</li>
									<li>
										<strong>특이한 점 및 이용 TIP</strong>
										<p><% = nl2br(oTester.FItemList(i).FUseETC) %></p>
									</li>
								</ul>
							</div>
							<% if oTester.FItemList(i).Flinkimg1<>"" then %>
							<div class="imgArea"><img src="<%=getStonThumbImgURL(oTester.FItemList(i).Flinkimg1,550,0,"","")%>" style="cursor:pointer;" onclick="popShowImg('<%= oTester.FItemList(i).Flinkimg1 %>');"></div>
							<% end if %>
							<% if oTester.FItemList(i).Flinkimg2<>"" then %>
							<div class="imgArea"><img src="<%=getStonThumbImgURL(oTester.FItemList(i).Flinkimg2,550,0,"","")%>" style="cursor:pointer;" onclick="popShowImg('<%= oTester.FItemList(i).Flinkimg2 %>');"></div>
							<% end if %>
							<% if oTester.FItemList(i).Flinkimg3<>"" then %>
							<div class="imgArea"><img src="<%=getStonThumbImgURL(oTester.FItemList(i).Flinkimg3,550,0,"","")%>" style="cursor:pointer;" onclick="popShowImg('<%= oTester.FItemList(i).Flinkimg3 %>');"></div>
							<% end if %>
							<% if oTester.FItemList(i).Flinkimg4<>"" then %>
							<div class="imgArea"><img src="<%=getStonThumbImgURL(oTester.FItemList(i).Flinkimg4,550,0,"","")%>" style="cursor:pointer;" onclick="popShowImg('<%= oTester.FItemList(i).Flinkimg4 %>');"></div>
							<% end if %>
							<% if oTester.FItemList(i).Flinkimg5<>"" then %>
							<div class="imgArea"><img src="<%=getStonThumbImgURL(oTester.FItemList(i).Flinkimg5,550,0,"","")%>" style="cursor:pointer;" onclick="popShowImg('<%= oTester.FItemList(i).Flinkimg5 %>');"></div>
							<% end if %>
							<% If GetLoginUserID = oTester.FItemList(i).FUserID Then %>
							<!--div class="btnArea"><a href="/my10x10/goodsusing.asp?EvaluatedYN=Y" class="btn btnS2 btnGry2"><span class="fn">수정</span></a></div-->
							<% End If %>
					</div>
				</div>
			</td>
		</tr>
		<% next %>
		</tbody>
	</table>
	<% if oTester.FResultCount > 0 then %>
	<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(oTester.FCurrpage,oTester.FTotalCount,oTester.FPageSize,10,"fnChgTestEvMove") %></div>
	<% end if %>
	</span>
</div>
<%
end if
Set oTester = Nothing
%>