<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_tester_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/eventprizeCls.asp" -->
<%
dim userid, page,  pagesize, SortMethod,cdL,vDisp,ix,EvaluatedYN,i, lp
userid      = getEncLoginUserID
page        = requestCheckVar(request("page"),9)
pagesize    = requestCheckVar(request("pagesize"),9)
SortMethod  = requestCheckVar(request("SortMethod"),10)
vDisp		= requestCheckVar(request("disp"),3)
EvaluatedYN	= requestCheckVar(request("EvaluatedYN"),2)



'####### Tester 당첨 여부. #######
Dim clsEvtPrize	: set clsEvtPrize  = new CEventPrize
clsEvtPrize.FUserid = userid
	clsEvtPrize.fnGetTesterEventCheck
	if clsEvtPrize.FTotCnt>0 then
		response.Cookies("tinfo")("isTester") = true
	else
		response.Cookies("tinfo")("isTester") = false
	end if
set clsEvtPrize = Nothing
'####### Tester 당첨 여부. #######



if page="" then page=1
if pagesize="" then pagesize="30"
if EvaluatedYN="" then EvaluatedYN="N"
if SortMethod ="" then
	'고객작성후기라면 정렬기본값은 작성일자순(2008.04.28;허진원)
	if EvaluatedYN="Y" then
		SortMethod ="Reg"
	else
		SortMethod ="Buy"
	end if
end if
dim EvList
set EvList = new CEvaluateSearcher
EvList.FRectUserID = Userid 
EvList.FPageSize = pagesize 
EvList.FCurrPage	= page
EvList.FScrollCount =10
EvList.FRectDisp= vDisp
EvList.FRectEvaluatedYN=EvaluatedYN
EvList.FSortMethod = SortMethod 

if EvaluatedYN="Y" then
	EvList.EvalutedItemList ''후기 가져오기 
else 
	EvList.NotEvalutedItemList ''후기 안쓰인 상품 가져오기 
end if

strPageTitle = "텐바이텐 10X10 : 테스터 후기"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script language="javascript">
function SwapCate(comp){
    var disp = comp.value;
    var frm = comp.form;
	frm.disp.value = disp;
	frm.submit();
}

function DelEval(idx,pcode,ecode){
	if (confirm('상품평을 삭제 하시겠습니까? \n\n삭제후 재작성이 불가능합니다.')){
	    var frm = document.dFrm;
	    frm.idx.value = idx;
	    frm.evtprize_code.value = pcode;
	    frm.evt_code.value = ecode;
	    
	    frm.action = "/my10x10/mytester/goodsUsing_delProc.asp";
	    frm.submit();
	    
	}
}

function goPage(page){
    var frm = document.evaluateFrm;
    frm.page.value = page;
    frm.submit();
}

function TesterAddEval(idx,pzCode,eCode,itID){	
	var winTEval; 
	winTEval = window.open('/my10x10/mytester/goodsUsingWrite.asp?idx=' + idx + '&pcode=' + pzCode + '&ecode=' + eCode + '&itemid=' + itID + '','poptteval','width=925,height=800,status=no,resizable=yes,scrollbars=yes');
	winTEval.focus();
}
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap skinBlue">
		<div id="contentWrap">
			<div class="myHeader">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my10x10.png" class="pngFix" alt="MY TENBYTEN" /></h2>
				<div class="breadcrumb">
					<a href="#">HOME</a> &gt;
					<a href="#">MY TENBYTEN</a> &gt;
					<a href="#">MY 스페셜 리스트</a> &gt;
					<strong>테스터 후기</strong>
				</div>
			</div>
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_tester_review.gif" alt="테스터 후기" /></h3>
						<ul class="list">
							<li>테스터 상품에 대한 유용한 정보를 다른 고객과 공유하는 곳으로 솔직담백한 후기를 올려주세요.</li>
							<li>테스터 후기를 작성하시면 마일리지 1,000 point가 적립되며 테스터후기 작성기간에만 작성하실수 있습니다.</li>
							<li>테스터 후기내용 삭제 시 적립된 마일리지는 자동삭제 됩니다.</li>
							<li>테스터 후기 작성 기간이 지나면 후기 내용을 수정 및 삭제할 수 없습니다.</li>
							<li>우수 테스터 후기는 테스터 진행 담당자가 별도 연락을 드립니다.</li>
						</ul>
					</div>
					<div class="mySection">
						<div class="myWishWrap">
							<div class="sorting">
								<ul class="tabMenu addArrow tabTester">
								<% if EvaluatedYN="N" then %>
									<li><a href="?EvaluatedYN=N" class="on"><span>테스터후기 작성</span></a></li>
									<li><a href="?EvaluatedYN=Y"><span>테스터후기 수정/보기</span></a></li>
								<% else %>
									<li><a href="?EvaluatedYN=N"><span>테스터후기 작성</span></a></li>
									<li><a href="?EvaluatedYN=Y" class="on"><span>테스터후기 수정/보기</span></a></li>
								<% end if %>
								</ul>
								<form name="evaluateFrm" method="get" action="" style="margin:0px;">
								<input type="hidden" name="mode" value="" />
								<input type="hidden" name="page" value="" />
								<input type="hidden" name="EvaluatedYN" value="<%= EvaluatedYN %>" />
								<input type="hidden" name="orderserial" value="" />
								<input type="hidden" name="itemid" value="" />
								<input type="hidden" name="optionCD" value="" />
								<div class="option">
									<select name="disp" title="카테고리 옵션 선택" onChange="SwapCate(this);" class="optSelect2">
										<%=CategorySelectBoxOption(vDisp)%>
									</select>
								</div>
								</form>
							</div>
						<% if EvaluatedYN="Y" then %>
							<!-- 수정 리스트 -->
							<div class="myItemList">
							<% if EvList.FResultCount = 0 then %>
								<p class="noData"><strong>등록하신 테스터 후기가 없습니다.</strong></p>
							<% else %>
							<% for  i = 0 to EvList.FResultCount-1 %>
								<div class="myItem">
									<div class="pdfInfo">
										<div class="pdtPhoto"><img src="<%= EvList.FItemList(i).FImageList120 %>" width="120" height="120" alt="" /></div>
										<p class="pdtBrand"><a href="javascript:GoToBrandShop('<% = EvList.FItemList(i).FMakerID %>');"><%= EvList.FItemList(ix).FMakerName %></a></p>
										<p class="pdtName tPad10"><a href="/shopping/category_prd.asp?itemid=<%=EvList.FItemList(i).FItemid%>"><%= EvList.FItemList(i).FItemName %></a></p>
									</div>
									<div class="reviewInfo">
										<div class="rating">
											<ul>
												<li><span>기능</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=EvList.FItemList(i).FPoint_fun%>.png" class="pngFix" alt="별<%=EvList.FItemList(i).FPoint_fun%>개" /></li>
												<li><span>디자인</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=EvList.FItemList(i).FPoint_dgn%>.png" class="pngFix" alt="별<%=EvList.FItemList(i).FPoint_dgn%>개" /></li>
												<li><span>가격</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=EvList.FItemList(i).FPoint_prc%>.png" class="pngFix" alt="별<%=EvList.FItemList(i).FPoint_prc%>개" /></li>
												<li><span>만족도</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%= EvList.FItemList(i).FPoint_stf%>.png" class="pngFix" alt="별<%= EvList.FItemList(i).FPoint_stf%>개" /></li>
											</ul>
										</div>
										<div class="comment">
											<div class="textArea">
												<ul class="reviewItem">
													<li>
														<strong>[ 총평 ]</strong>
														<p><%= nl2br(EvList.FItemList(i).FUesdContents) %></p>
													</li>
													<li>
														<strong>[ 좋았던 점 ]</strong>
														<p><%= nl2br(EvList.FItemList(i).FUseGood) %></p>
													</li>
													<li>
														<strong>[ 특이한 점 및 이용 TIP ]</strong>
														<p><%= nl2br(EvList.FItemList(i).FUseETC) %></p>
													</li>
												</ul>
												<p class="date"><%= Replace(Left(CStr(EvList.FItemList(i).FRegDate),10),"-","/") %></p>
											</div>
											<% if EvList.FItemList(i).Flinkimg1<>"" then %>
												<div class="imgArea"><img src="<%= EvList.FItemList(i).getLinkImage1 %>" name="image_fix_1_<%= i %>" id="image_fix_1_<%= i %>" style="cursor:pointer;" onclick="popShowImg('<%= EvList.FItemList(i).getLinkImage1 %>');" onload="Resizeimg('400','image_fix_1_<%= i %>');" alt="테스터후기 첨부이미지" /></div>
											<% end if %>
											<% if EvList.FItemList(i).Flinkimg2<>"" then %>
												<div class="imgArea"><img src="<%= EvList.FItemList(i).getLinkImage2 %>" name="image_fix_2_<%= i %>" id="image_fix_2_<%= i %>" style="cursor:pointer;" onclick="popShowImg('<%= EvList.FItemList(i).getLinkImage2 %>');" onload="Resizeimg('400','image_fix_2_<%= i %>');" alt="테스터후기 첨부이미지" /></div>
											<% end if %>
											<% if EvList.FItemList(i).Flinkimg3<>"" then %>
												<div class="imgArea"><img src="<%= EvList.FItemList(i).getLinkImage3 %>" name="image_fix_3_<%= i %>" id="image_fix_3_<%= i %>" style="cursor:pointer;" onclick="popShowImg('<%= EvList.FItemList(i).getLinkImage3 %>');" onload="Resizeimg('400','image_fix_3_<%= i %>');" alt="테스터후기 첨부이미지" /></div>
											<% end if %>
											<% if EvList.FItemList(i).Flinkimg4<>"" then %>
												<div class="imgArea"><img src="<%= EvList.FItemList(i).getLinkImage4 %>" name="image_fix_4_<%= i %>" id="image_fix_4_<%= i %>" style="cursor:pointer;" onclick="popShowImg('<%= EvList.FItemList(i).getLinkImage4 %>');" onload="Resizeimg('400','image_fix_4_<%= i %>');" alt="테스터후기 첨부이미지" /></div>
											<% end if %>
											<% if EvList.FItemList(i).Flinkimg5<>"" then %>
												<div class="imgArea"><img src="<%= EvList.FItemList(i).getLinkImage5 %>" name="image_fix_5_<%= i %>" id="image_fix_5_<%= i %>" style="cursor:pointer;" onclick="popShowImg('<%= EvList.FItemList(i).getLinkImage5 %>');" onload="Resizeimg('400','image_fix_5_<%= i %>');" alt="테스터후기 첨부이미지" /></div>
											<% end if %>
											<% If DateDiff("d",now(),EvList.FItemList(i).FendDate) >= 0 Then %>
											<div class="btnArea">
												<a href="javascript:TesterAddEval('<%= EvList.FItemList(i).FIdx %>','<%= EvList.FItemList(i).FEvtprize_Code %>','<%= EvList.FItemList(i).FEvt_Code %>','<%= EvList.FItemList(i).FItemID %>');" class="btn btnS2 btnGry2"><span class="fn">수정</span></a>
												<a href="javascript:DelEval('<%= EvList.FItemList(i).FIdx %>','<%= EvList.FItemList(i).FEvtprize_Code %>','<%= EvList.FItemList(i).FEvt_Code %>');" class="btn btnS2 btnGry2"><span class="fn">삭제</span></a>
											</div>
											<% End If %>
										</div>
									</div>
								</div>
							<% next
							end if
						else %>
							<!-- index 리스트 -->
							<div class="pdtWrap pdt150V15">
								<ul class="pdtList testerReviewList">
								<% if EvList.FResultCount = 0 then %>
									<p class="noData"><strong>작성하실 테스터 후기가 없습니다.</strong></p>
								<%
									else

									for i=0 to EvList.FResultCount-1
								%>
									<li>
										<div class="pdtBox">
											<div class="pdtPhoto">
												<a href="" onclick="TnGotoProduct('<%= EvList.FItemList(i).FItemID %>');return false;">
													<span class="soldOutMask"></span>
													<img src="<%=getThumbImgFromURL(EvList.FItemList(i).FImageIcon2,"150","150","true","false")%>" alt="<%= EvList.FItemList(i).FItemName %>" />
												</a>
											</div>
											<div class="pdtInfo">
												<p class="pdtBrand tPad10"><a href="" onclick="GoToBrandShop('<% = EvList.FItemList(i).FMakerID %>');return false;"><%= EvList.FItemList(ix).FMakerName %></a></p>
												<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=EvList.FItemList(i).FItemid%>"><%= EvList.FItemList(i).FItemName %></a></p>
												<p class="pdtPrice"><span class="finalP"><%= FormatNumber(EvList.FItemList(i).FItemCost,0) %>원</span></p>
											</div>
											<p class="cartBtn">
												<% If EvList.FItemList(ix).FstartDate > now() Then %>
													<span class="btn btnM2 btnGry2 btnW150 fn"><%=Month(EvList.FItemList(i).FstartDate)%>월 <%=Day(EvList.FItemList(i).FstartDate)%>일부터 작성</span>
												<% Else %>
													<a href="javascript:TesterAddEval('','<%= EvList.FItemList(i).FEvtprize_Code %>','<%= EvList.FItemList(i).FEvt_Code %>','<%= EvList.FItemList(i).FItemID %>');" class="btn btnM2 btnRed btnW150">테스터후기 쓰기</a>
												<% End If %>
											</p>
											<p class="duringDate">
												<span>작성기간</span>
												<span><%=EvList.FItemList(i).FstartDate%> ~ <%=EvList.FItemList(i).FendDate%></span>
											</p>
											<ul class="pdtActionV15">
												<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=EvList.FItemList(i).FItemid%>');return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
												<li class="postView"><a href="" <% If EvList.FItemList(i).FEvalCount>0 Then %>onclick="popEvaluate('<%=EvList.FItemList(i).FItemid%>');return false;"<% Else %>onclick="return false;"<% End If %>><span><%= FormatNumber(EvList.FItemList(i).FEvalCount,0) %></span></a></li>
												<li class="wishView"><a href="" onclick="TnAddFavorite('<%=EvList.FItemList(i).FItemid%>');return false;"><span><%= FormatNumber(EvList.FItemList(i).FFavCount,0) %></span></a></li>
											</ul>
										</div>
									</li>
								<%
									next
								end if %>
								</ul>
						<% end if %>
							</div>

							<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(EvList.FCurrpage,EvList.FTotalCount,EvList.FPageSize,10,"goPage") %></div>
						</div>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<form name="dFrm" method="post" action="">
	<input type="hidden" name="idx" value="">
	<input type="hidden" name="evtprize_code" value="">
	<input type="hidden" name="evt_code" value="">
	</form>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% 
set EvList= nothing 
%>