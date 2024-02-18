<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  테스터이벤트
' History : 2015.04.10 한용민 리뉴얼 이전생성
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_tester_evaluatesearchercls.asp" -->
<%
strPageTitle = "텐바이텐 10X10 : 테스터 후기"
dim userid, itemid, EvaluatedYN, cdL, userlevel, vIdx, vECode, vPCode

userid	= getEncLoginUserID
userlevel= GetLoginUserLevel
vIdx = requestCheckVar(request("idx"),10)
vECode = requestCheckVar(request("ecode"),10)
vPCode = requestCheckVar(request("pcode"),10)
itemID	= requestCheckVar(request("itemid"),10)
cdl		= requestCheckVar(request("cdl"),3)

'####### 작성된 글이 있는지 체크 #######
Dim ClsCheck, vCheck
Set ClsCheck = new CEvaluateSearcher
	ClsCheck.FRectUserID = Userid
	ClsCheck.FRectItemID = itemID
	ClsCheck.FECode = vECode
	ClsCheck.FPCode = vPCode
	ClsCheck.getIsTesterEvaluatedWrite()
	vCheck = ClsCheck.Fgubun
Set ClsCheck = nothing

If vCheck <> "x" Then
	If vCheck = "o" Then
		If vIdx = "" Then
			Response.Write "<script language='javascript'>alert('등록하신 글이 있습니다.');window.close();opener.location.reload();</script>"
			dbget.close() : response.end
		End IF
	Else
		Response.Write "<script language='javascript'>alert('잘못된 경로입니다.');window.close();opener.location.reload();</script>"
		dbget.close() : response.end
	End If
End If
'####### 작성된 글이 있는지 체크 #######

dim EvList
set EvList = new CEvaluateSearcher
	EvList.FIdx = vIdx
	EvList.FRectUserID = Userid
	EvList.FRectItemID = itemID
	EvList.FECode = vECode
	EvList.FPCode = vPCode
	EvList.getEvaluatedItem

if EvList.FResultCount < 1 then
	response.write "<script>alert('잘못된 접근입니다.');</script>"
	response.write "<script>self.close();</script>"
	dbget.close() : response.end
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="javascript">

function changefile(iimage,comp){
	var tmpD 	= document.getElementById(comp);
	tmpD.checked=false;
	
}

function delimage(ifile,iimage,comp){
	var tmpT		= document.getElementById(ifile);
	var tmpV 	= document.getElementById(iimage);

	if (comp.checked){
		tmpV.style.display="none";
	}
}

function checkImageSuffix (fileInput) {
   var suffixPattern = /(gif|jpg|jpeg|png)$/i;
   if (!suffixPattern.test(fileInput.value)) {
     alert('GIF,JEPG,PNG 파일만 가능합니다.');
     fileInput.focus();
     fileInput.select();
     return false;
   }
   return true;
}

function SubmitForm(frm){
    if (frm.usedcontents.value == "") {
            alert("총평을 적어주세요.");
            frm.usedcontents.focus();
            return;
    } 
    
    if (frm.usedcontents.value.length>10000) {
           alert("총평은 10000자 이내로 작성해 주세요");
           frm.usedcontents.focus();
           return;
    }
    
    if (frm.usegood.value == "") {
            alert("이런 점 좋았어요. 를 적어주세요.");
            frm.usegood.focus();
            return;
    } 
    
    if (frm.usegood.value.length>10000) {
           alert("이런 점 좋았어요. 는 10000자 이내로 작성해 주세요");
           frm.usegood.focus();
           return;
    }
    
    if (frm.useetc.value == "") {
            alert("특이한 점과 이용 tip 을 적어주세요.");
            frm.useetc.focus();
            return;
    } 
    
    if (frm.useetc.value.length>10000) {
           alert("특이한 점과 이용 tip 은 10000자 이내로 작성해 주세요");
           frm.useetc.focus();
           return;
    }

    if ((frm.totPnt[0].checked)||(frm.totPnt[1].checked)||(frm.totPnt[2].checked)||(frm.totPnt[3].checked)||(frm.totPnt[4].checked)){

    }else{
    	alert("총평을 선택해 주세요.");
    	frm.totPnt[3].focus();
    	return;
    };

    if ((frm.funPnt[0].checked)||(frm.funPnt[1].checked)||(frm.funPnt[2].checked)||(frm.funPnt[3].checked)||(frm.funPnt[4].checked)){

    }else{
    	alert("기능평을 선택해 주세요.");
    	frm.funPnt[3].focus();
    	return;
    };

    if ((frm.dgnPnt[0].checked)||(frm.dgnPnt[1].checked)||(frm.dgnPnt[2].checked)||(frm.dgnPnt[3].checked)||(frm.dgnPnt[4].checked)){

    }else{
    	alert("디자인평을 선택해 주세요.");
    	frm.dgnPnt[3].focus();
    	return;
    };

    if ((frm.PrcPnt[0].checked)||(frm.PrcPnt[1].checked)||(frm.PrcPnt[2].checked)||(frm.PrcPnt[3].checked)||(frm.PrcPnt[4].checked)){

    }else{
    	alert("가격평을 선택해 주세요.");
    	frm.PrcPnt[3].focus();
    	return;
    };

    if ((frm.stfPnt[0].checked)||(frm.stfPnt[1].checked)||(frm.stfPnt[2].checked)||(frm.stfPnt[3].checked)||(frm.stfPnt[4].checked)){

    }else{
    	alert("만족도평을 선택해 주세요.");
    	frm.stfPnt[3].focus();
    	return;
    };

	if ((frm.file1.value.length>0)&&(!checkImageSuffix(frm.file1))){
		return;
	};

	if ((frm.file2.value.length>0)&&(!checkImageSuffix(frm.file2))){
		return;
	};

	/*
	if ((frm.file3.value.length>0)&&(!checkImageSuffix(frm.file3))){
		return;
	};
	*/

	<% If vIdx = "" Then %>
	if (frm.file1.value.length>0){
		if ((frm.file1.fileSize>1024000)||(frm.file1.fileSize<1)){
			alert('파일사이즈가 너무 크거나 사용할 수 없습니다. 최대 1M까지 가능');
			frm.file1.focus();
			frm.file1.select();
			return;
		}

		if (frm.file1_image.width>600){
			alert('이미지 사이즈는 가로 600까지 가능합니다.');
			frm.file1.focus();
			frm.file1.select();
			return;
		}
	}
	else
	{
		alert('최소한 사진 1장 이상은 올려주시기 바랍니다.');
		frm.file1.focus();
		frm.file1.select();
		return;
	}
	<% Else %>
	
	<% End If %>

	if (frm.file2.value.length>0){
		if ((frm.file2.fileSize>1024000)||(frm.file2.fileSize<1)){
			alert('파일사이즈가 너무 크거나 사용할 수 없습니다. 최대 1M까지 가능');
			frm.file2.focus();
			frm.file2.select();
			return;
		}

		if (frm.file2_image.width>600){
			alert('이미지 사이즈는 가로 600까지 가능합니다.');
			frm.file2.focus();
			frm.file2.select();
			return;
		}
	}
	
	/*
	if (frm.file3.value.length>0){
		if ((frm.file3.fileSize>1024000)||(frm.file3.fileSize<1)){
			alert('파일사이즈가 너무 크거나 사용할 수 없습니다. 최대 1M까지 가능');
			frm.file3.focus();
			frm.file3.select();
			return;
		}

		if (frm.file3_image.width>600){
			alert('이미지 사이즈는 가로 600까지 가능합니다.');
			frm.file3.focus();
			frm.file3.select();
			return;
		}
	}
	*/

    if (confirm("입력사항이 정확합니까?") == true) { frm.submit(); }
}

function jsGoOpenerPrd(itemid){
	opener.location.href = '/shopping/category_prd.asp?itemid='+itemid;
	self.close();
}

</script>
</head>
<body>
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="//fiximage.10x10.co.kr/web2013/my10x10/tit_tester_review_write.gif" alt="테스터후기 쓰기" /></h1>
		</div>
		<div class="popContent">
			<!-- content -->
			<form name="FrmGoodusing" method="post" action="<%=staticImgUpUrl%>/linkweb/do_test_evaluatewithimage_utf8.asp" EncType="multipart/form-data">
			<input type="hidden" name="idx" value="<%= EvList.FEvalItem.Fidx %>" />
			<input type="hidden" name="itemid" value="<%= EvList.FEvalItem.FItemID %>" />
			<input type="hidden" name="evtprize_code" value="<%=vPCode%>" />
			<input type="hidden" name="evt_code" value="<%=vECode%>" />
			<input type="hidden" name="chkp5yn" value="Y" />
			<div class="mySection">
				<ul class="list">
					<li>테스터 상품에 대한 유용한 정보를 다른 고객과 공유하는 곳으로 솔직담백한 후기를 올려주세요.</li>
					<li>테스터 후기를 작성하시면 마일리지 1,000 point가 적립되며 테스터후기 작성기간에만 작성하실수 있습니다.</li>
					<li>테스터 후기내용 삭제 시 적립된 마일리지는 자동삭제 됩니다.</li>
					<li>테스터 후기 작성 기간이 지나면 후기 내용을 수정 및 삭제할 수 없습니다.</li>
					<li>우수 테스터 후기는 테스터 진행 담당자가 별도 연락을 드립니다.</li>
				</ul>

				<fieldset>
					<legend>테스터후기 쓰기</legend>
					<table class="baseTable rowTable docForm tMar15">
					<caption>테스터후기 쓰기</caption>
					<colgroup>
						<col width="120" /> <col width="*" />
					</colgroup>
					<tbody>
					<tr>
						<th scope="row" class="ct">상품정보</th>
						<td>
							<div class="goodsInfo">
								<div class="pdtPhoto"><img src="<%= EvList.FEvalItem.FImageIcon2 %>" width="150" height="150" alt="<%= EvList.FEvalItem.FItemName %>" /></div>
								<div class="pdfInfo">
									<p class="pdtBrand"><a href="javascript:jsGoOpenerPrd('<%= EvList.FEvalItem.FItemID %>');"><%= EvList.FEvalItem.FMakerName %></a></p>
									<p class="pdtName tPad10"><a href="javascript:jsGoOpenerPrd('<%= EvList.FEvalItem.FItemID %>');"><%= EvList.FEvalItem.FItemName %></a></p>
									<p class="pdtPrice tPad10"><span class="finalP"><%= FormatNumber(EvList.FEvalItem.FItemCost,0) %>원</span></p>
									<p class="pdtCode tPad10">상품코드: <%= EvList.FEvalItem.FItemID %></p>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct"><label for="testerComment">총평</label></th>
						<td>
							<textarea id="testerComment" name="usedcontents" cols="60" rows="8" style="width:95.5%; height:88px;"><%= EvList.FEvalItem.FUesdContents %></textarea>
							<p class="tPad07 fs11">테스터 후기와 상관 없는 판매 관련이나 홍보글은 사전통보 없이 관리자에 의해 삭제 될 수 있습니다.</p>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct"><label for="testerGood">이런 점<br /> 좋았어요</label></th>
						<td>
							<textarea id="testerGood" name="usegood" cols="60" rows="8" style="width:95.5%; height:88px;"><%= EvList.FEvalItem.FUseGood %></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct"><label for="testerSpecial">특이한 점과<br /> 이용 tip</label></th>
						<td>
							<textarea id="testerSpecial" name="useetc" cols="60" rows="8" style="width:95.5%; height:88px;"><%= EvList.FEvalItem.FUseETC %></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct"><label for="blogUrl">나의 Blog</label></th>
						<td>
							<input type="text" id="blogUrl" name="myblog" class="txtInp" style="width:94.2%;" value="<% If EvList.FEvalItem.FMyBlog <> "" Then %><%=EvList.FEvalItem.FMyBlog %><% Else %>http://<% End If %>" />
							<p class="tPad07 fs11">내 블로그에 테스터 후기를 포스팅 한 분은 블로그 주소를 남겨주세요</p>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct">첨부이미지</th>
						<td>
							<div class="attachFile">
								<input type="file" name="file1" title="첨부이미지 찾아보기" class="inputFile" style="width:570px;" onchange="changefile('file1_image','file1_del');" />
								<div class="imgArea">
								<% if EvList.FEvalItem.Flinkimg1<>"" then %>				                  
									<img id="file1_image" name="file1_image" src="<%= EvList.FEvalItem.getLinkImage1 %>" alt="첨부이미지" style="display:block" >
								<% else %>
									<img id="file1_image" name="file1_image" src="" style="display:none" >
								<% end if %>
									<span><input type="checkbox" class="check" id="file1_del" name="file1_del" onclick="delimage('file1','file1_image',this);" <% If vIdx <> "" Then %>disabled<% End If %> /> <label for="file1_del">등록된 이미지 삭제</label></span>
								</div>
							</div>
							<div class="attachFile tMar10">
								<input type="file" name="file2" title="첨부이미지 찾아보기" class="inputFile" style="width:570px;" onchange="changefile('file2_image','file2_del');" />
								<div class="imgArea">
								<% if EvList.FEvalItem.Flinkimg2<>"" then %>
									<img name="file2_image" id="file2_image" src="<%= EvList.FEvalItem.getLinkImage2 %>" style="display:block" >
								<% else %>
									<img id="file2_image" name="file2_image" src="" style="display:none" >
								<% end if %>
									<span><input type="checkbox" class="check" id="file2_del" name="file2_del" onclick="delimage('file2','file2_image',this);" /> <label for="file2_del">등록된 이미지 삭제</label></span>
								</div>
							</div>
							<p class="tMar07 fs11">파일크기는 1MB이하, JPG 또는 GIF형식의 파일만 가능합니다. 사이즈는 가로 450이하로 설정해 주시기 바랍니다.</p>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct">만족도 평가</th>
						<td>
							<div class="satisfactionList">
								<div class="itemField">
									<span>총평</span>
									<ul>
										<li><input type="radio" name="totPnt" id="satisfaction15" value="5" <% if EvList.FEvalItem.FTotalPoint="5" or isNull(EvList.FEvalItem.FTotalPoint) then response.write "checked" %>/> <label for="satisfaction15"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

										<li><input type="radio" name="totPnt" id="satisfaction11" value="4" <% if EvList.FEvalItem.FTotalPoint="4" then response.write "checked" %>/> <label for="satisfaction11"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
										<li><input type="radio" name="totPnt" id="satisfaction12" value="3" <% if EvList.FEvalItem.FTotalPoint="3" then response.write "checked" %>/> <label for="satisfaction12"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
										<li><input type="radio" name="totPnt" id="satisfaction13" value="2" <% if EvList.FEvalItem.FTotalPoint="2" then response.write "checked" %>/> <label for="satisfaction14"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
										<li><input type="radio" name="totPnt" id="satisfaction14" value="1" <% if EvList.FEvalItem.FTotalPoint="1" then response.write "checked" %>/> <label for="satisfaction14"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
									</ul>
								</div>
								<div class="itemField">
									<span>기능</span>
									<ul>
										<li><input type="radio" name="funPnt" id="satisfaction25" value="5" <% if EvList.FEvalItem.FPoint_fun="5" or isNull(EvList.FEvalItem.FPoint_fun) then response.write "checked" %>/> <label for="satisfaction25"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

										<li><input type="radio" name="funPnt" id="satisfaction21" value="4" <% if EvList.FEvalItem.FPoint_fun="4" then response.write "checked" %>/> <label for="satisfaction21"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
										<li><input type="radio" name="funPnt" id="satisfaction22" value="3" <% if EvList.FEvalItem.FPoint_fun="3" then response.write "checked" %>/> <label for="satisfaction22"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
										<li><input type="radio" name="funPnt" id="satisfaction23" value="2" <% if EvList.FEvalItem.FPoint_fun="2" then response.write "checked" %>/> <label for="satisfaction23"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
										<li><input type="radio" name="funPnt" id="satisfaction24" value="1" <% if EvList.FEvalItem.FPoint_fun="1" then response.write "checked" %>/> <label for="satisfaction24"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
									</ul>
								</div>
								<div class="itemField">
									<span>디자인</span>
									<ul>
										<li><input type="radio" name="dgnPnt" id="satisfaction35" value="5" <% if EvList.FEvalItem.FPoint_dgn="5" or isNull(EvList.FEvalItem.FPoint_dgn) then response.write "checked" %>/> <label for="satisfaction35"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

										<li><input type="radio" name="dgnPnt" id="satisfaction31" value="4" <% if EvList.FEvalItem.FPoint_dgn="4" then response.write "checked" %>/> <label for="satisfaction31"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
										<li><input type="radio" name="dgnPnt" id="satisfaction32" value="3" <% if EvList.FEvalItem.FPoint_dgn="3" then response.write "checked" %>/> <label for="satisfaction32"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
										<li><input type="radio" name="dgnPnt" id="satisfaction33" value="2" <% if EvList.FEvalItem.FPoint_dgn="2" then response.write "checked" %>/> <label for="satisfaction33"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
										<li><input type="radio" name="dgnPnt" id="satisfaction34" value="1" <% if EvList.FEvalItem.FPoint_dgn="1" then response.write "checked" %>/> <label for="satisfaction34"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
									</ul>
								</div>
								<div class="itemField">
									<span>가격</span>
									<ul>
										<li><input type="radio" name="PrcPnt" id="satisfaction45" value="5" <% if EvList.FEvalItem.FPoint_prc="5" or isNull(EvList.FEvalItem.FPoint_prc) then response.write "checked" %>/> <label for="satisfaction45"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

										<li><input type="radio" name="PrcPnt" id="satisfaction41" value="4" <% if EvList.FEvalItem.FPoint_prc="4" then response.write "checked" %>/> <label for="satisfaction41"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
										<li><input type="radio" name="PrcPnt" id="satisfaction42" value="3" <% if EvList.FEvalItem.FPoint_prc="3" then response.write "checked" %>/> <label for="satisfaction42"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
										<li><input type="radio" name="PrcPnt" id="satisfaction43" value="2" <% if EvList.FEvalItem.FPoint_prc="2" then response.write "checked" %>/> <label for="satisfaction43"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
										<li><input type="radio" name="PrcPnt" id="satisfaction44" value="1" <% if EvList.FEvalItem.FPoint_prc="1" then response.write "checked" %>/> <label for="satisfaction44"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
									</ul>
								</div>
								<div class="itemField">
									<span>만족도</span>
									<ul>
										<li><input type="radio" name="stfPnt" id="satisfaction55" value="5" <% if EvList.FEvalItem.FPoint_stf="5" or isNull(EvList.FEvalItem.FPoint_stf) then response.write "checked" %>/> <label for="satisfaction55"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

										<li><input type="radio" name="stfPnt" id="satisfaction51" value="4" <% if EvList.FEvalItem.FPoint_stf="4" then response.write "checked" %>/> <label for="satisfaction51"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
										<li><input type="radio" name="stfPnt" id="satisfaction52" value="3" <% if EvList.FEvalItem.FPoint_stf="3" then response.write "checked" %>/> <label for="satisfaction52"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
										<li><input type="radio" name="stfPnt" id="satisfaction53" value="2" <% if EvList.FEvalItem.FPoint_stf="2" then response.write "checked" %>/> <label for="satisfaction53"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
										<li><input type="radio" name="stfPnt" id="satisfaction54" value="1" <% if EvList.FEvalItem.FPoint_stf="1" then response.write "checked" %>/> <label for="satisfaction54"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
									</ul>
								</div>
							</div>
						</td>
					</tr>
					</tbody>
					</table>

					<div class="btnArea ct tPad30">
						<input type="button" class="btn btnS1 btnRed btnW160" value="신청하기" onClick="SubmitForm(document.FrmGoodusing);" />
						<button type="button" class="btn btnS1 btnGry btnW160" onClick="self.close();">취소하기</button>
					</div>
				</fieldset>

			</div>
			</form>
			<!-- //content -->
		</div>
	</div>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
</body>
</html>

<% set EvList= nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->