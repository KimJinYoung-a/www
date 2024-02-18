<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%

'// 접근 중지
'/서버 주기적 업데이트 위한 공사중 처리 '2011.11.11 한용민 생성
'/리뉴얼시 이전해 주시고 지우지 말아 주세요
'Call serverupdate_underconstruction()
'dbget.close(): response.End

if date()>"2022-12-12" then
	Call alert_move("유효기간이 만료되었습니다.","/")
	dbget.close(): response.End
end if

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 직원 상품후기 쓰기"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

Dim refer : refer = request.ServerVariables("HTTP_REFERER")

dim userid,orderserial,itemid,ItemOption,EvaluatedYN,userlevel,itemgubun

userid	= getEncLoginUserID
userlevel= GetLoginUserLevel

'// STAFF만 접근허용
if userlevel<>7 then
	Call alert_close("STAFF만 볼 수 있는 페이지입니다.")
	dbget.close(): response.End
end if

'// 직원 후기 기본 정보 세팅
itemID	= requestCheckVar(request("itemID"),8)
itemoption	= requestCheckVar(request("optionCD"),4)
orderserial = "200518A0001"		 '' 주문번호가 없으므로 고정
itemgubun = "10"								'' 일단 온라인 상품만

''if itemID="" then itemID=2324973			''메일리 상품
''if itemoption="" then itemoption="0012"	''메일리 상품 옵션 - 핑크
''if itemID="" then itemID=2784155			''스누피 토스터
''if itemID="" then itemID=2784156			''스누피 와플메이커
''if itemID="" then itemID=2976317			''스누피 후라이팬
''if itemID="" then itemID="3586683"			''디즈니 진공쌀통
if itemoption="" then itemoption="0000"
''if Not(itemID="3586683" or itemID="3590032") then		'디즈니 진공쌀통/키티 도마
''if Not(itemID="4169194" or itemID="4169195") then		'스누피 생일 인형
''if Not(itemID="4409955") then		'케로케로케로피 크래들 선풍기
''if Not(itemID="4915845") then		'히치하이커 2023 캘린더
''if Not(itemID="4572966" or itemID="4572867" or itemID="4572790" or itemID="4495193" or itemID="4495197") then	'스누피 코지라인
if Not(itemID="4831286" or itemID="4831285" or itemID="4831284" or itemID="4524552" or itemID="4728736") then	'PB 상품
	Call alert_close("지정되어있는 상품이 아닙니다.")
	dbget.close(): response.End
end if

'// 상품정보 접수
dim oItem
set oItem = new CatePrdCls
oItem.GetItemData itemid

'// 후기 정보 접수
dim EvList
set EvList = new CEvaluateSearcher
EvList.FRectUserID = Userid
EvList.FRectEvaluatedYN=EvaluatedYN
EvList.FRectItemID=itemID
EvList.FRectOrderSerial=OrderSerial
EvList.FRectOption=ItemOption
If Len(orderserial)>11 Then
EvList.getEvaluatedOffShopItem	 ''/오프라인 후기 검사
Else
EvList.getEvaluatedItem	 ''/기존 후기 있는지 검사
End If


'/상품고시관련 상품후기 제외 상품
dim Eval_excludeyn : Eval_excludeyn="N"
	Eval_excludeyn=getEvaluate_exclude_Itemyn(itemid)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">

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

	/* 가상의 옵션으로 상품 코드 선택 로직(매일리)
	if(frm.item_option.value=="") {
		alert("가지고 계신 상품의 옵션을 선택해주세요.");
		frm.item_option.focus();
		return;
	}
	
	switch (frm.item_option.value) {
		case "0011":
			//크림
			frm.itemid.value = "2320381";
			break;
		case "0012":
			//핑크
			frm.itemid.value = "2320382";
			break;
		default:
			break;
	}
	frm.itemoption.value="";
	frm.itemoptNm.value="";
	//frm.itemoption.value=frm.item_option.value;
	//frm.itemoptNm.value=frm.item_option.options[frm.item_option.selectedIndex].text;
	*/
	<%
	'//상품고시관련 상품후기 제외 상품이 아닐경우
	if Eval_excludeyn="N" then
	%>
	    if (frm.usedcontents.value == "") {
	            alert("상품평을 적어주세요.");
	            frm.usedcontents.focus();
	            return;
	    }

	    if (frm.usedcontents.value.length<10) {
	           alert("상품평은 최소 10자 이상 입력해주세요.");
	           frm.usedcontents.focus();
	           return;
	
	    }

	    if (!chktext(frm.usedcontents.value,5)) {
            alert("동일문구는 5자 연속 입력이 불가합니다.");
            frm.usedcontents.focus();
            return;
	    }

	    if (frm.usedcontents.value.length>10000) {
	           alert("상품평은 10000자 이내로 작성해 주세요");
	           frm.usedcontents.focus();
	           return;
	
	    }

		if ((frm.file1.value.length>0)&&(!checkImageSuffix(frm.file1))){
			return;
		};
	
		if ((frm.file2.value.length>0)&&(!checkImageSuffix(frm.file2))){
			return;
		};

		if ((frm.file3.value.length>0)&&(!checkImageSuffix(frm.file3))){
			return;
		};

		if (frm.file1.value.length>0){
			if ((frm.file1.fileSize>1024000)||(frm.file1.fileSize<1)){
				alert('파일사이즈가 너무 크거나 사용할 수 없습니다. 최대 1M까지 가능');
				frm.file1.focus();
				frm.file1.select();
				return;
			}
	
			/*
			if (frm.file1_image.width>600){
				alert('이미지 사이즈는 가로 600까지 가능합니다.');
				frm.file1.focus();
				frm.file1.select();
				return;
			}
			*/
		}
	
		if (frm.file2.value.length>0){
			if ((frm.file2.fileSize>1024000)||(frm.file2.fileSize<1)){
				alert('파일사이즈가 너무 크거나 사용할 수 없습니다. 최대 1M까지 가능');
				frm.file2.focus();
				frm.file2.select();
				return;
			}
	
			/*
			if (frm.file2_image.width>600){
				alert('이미지 사이즈는 가로 600까지 가능합니다.');
				frm.file2.focus();
				frm.file2.select();
				return;
			}
			*/
		}

		if (frm.file3.value.length>0){
			if ((frm.file3.fileSize>1024000)||(frm.file3.fileSize<1)){
				alert('파일사이즈가 너무 크거나 사용할 수 없습니다. 최대 1M까지 가능');
				frm.file3.focus();
				frm.file3.select();
				return;
			}
	
			/*
			if (frm.file3.width>600){
				alert('이미지 사이즈는 가로 600까지 가능합니다.');
				frm.file3.focus();
				frm.file3.select();
				return;
			}
			*/
		}

	<% end if %>
	
    if ((frm.totPnt[0].checked)||(frm.totPnt[1].checked)||(frm.totPnt[2].checked)||(frm.totPnt[3].checked)||(frm.totPnt[4].checked)){

    }else{
    	alert("총평을 선택해 주세요.");
    	frm.totPnt[3].focus();
    	return;
    };

    <% if  Not EvList.FEvalItem.IsTicketItem then %>
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
    <% end if %>

    if (confirm("입력사항이 정확합니까?") == true) { frm.submit(); }
}

function jsGoOpenerBrand(makerid){
	if (confirm("상품후기 작성을 중단하고 브랜드샵으로 이동하시겠습니까?") == false) {
		return;
	}

	opener.location.href = '/street/street_brand.asp?makerid='+makerid;
	self.close();
}

function jsGoOpenerPrd(itemid){
	if (confirm("상품후기 작성을 중단하고 상품페이지로 이동하시겠습니까?") == false) {
		return;
	}

	opener.location.href = '/shopping/category_prd.asp?itemid='+itemid;
	self.close();
}

function jsDelUpFile(idName) {
	document.getElementById(idName).innerHTML = document.getElementById(idName).innerHTML;
}

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="//fiximage.10x10.co.kr/web2013/my10x10/tit_product_review_write.gif" alt="상품후기 쓰기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<ul class="list">
						<li>구매하신 상품에 대한 유용한 정보를 다른 고객과 공유하는 곳으로 솔직담백한 상품후기를 올려주세요.</li>
						<li>상품후기를 작성하시면 100point가 적립되며 배송정보[출고완료]이후부터 사용하실 수 있습니다.</li>
						<li>취소/반품/교환의 경우 해당상품의 후기 및 적립된 마일리지는 자동삭제 됩니다.</li>
						<li>절판된 상품 및 6개월 이전 구매상품에 대한 후기는 작성하실 수 없습니다.</li>
					</ul>

					<form name="FrmGoodusing" method="post" action="<%=staticImgUpUrl%>/linkweb/doevaluatewithimage_utf8_New.asp" EncType="multipart/form-data">
					<input type="hidden" name="idx" value="<%= EvList.FEvalItem.Fidx %>" />
					<input type="hidden" name="gubun" value="<%= itemgubun %>" />
					<input type="hidden" name="itemid" value="<%= itemid %>" />
					<input type="hidden" name="orderserial" value="<%= orderserial %>" />
					<input type="hidden" name="chkp5yn" value="Y" />

					<fieldset>
						<legend>상품후기 쓰기</legend>
						<table class="baseTable rowTable docForm tMar15">
						<caption>상품후기 쓰기</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row" class="ct">상품정보</th>
							<td>
								<div class="goodsInfo">
									<div class="pdtPhoto"><img src="<%= oitem.Prd.FImageIcon2 %>" width="150" height="150" alt="<%= oitem.Prd.FItemName %>" /></div>
									<div class="pdfInfo">
										<p class="pdtBrand"><a href="javascript:jsGoOpenerBrand('<%= oitem.Prd.FMakerID %>')" title="브랜드 샵으로 이동"><%= oitem.Prd.FMakerName %></a></p>
										<p class="pdtName tPad10"><%= oitem.Prd.FItemName %></p>
										<p class="pdtPrice tPad10"><span class="finalP"><%= FormatNumber(oitem.Prd.FSellcash,0) %>원</span></p>
									</div>
								</div>
							</td>
						</tr>
					<% if EvList.FEvalItem.FOptionName<>"" then %>
						<tr>
							<th scope="row" class="ct">옵션 공개</th>
							<td>
								<%= EvList.FEvalItem.FOptionName %>
								<input type="hidden" name="itemoption" value="<%= EvList.FEvalItem.FitemOption %>" />
								<input type="hidden" name="itemoptNm" value="<%= EvList.FEvalItem.FOptionName %>" />
								<span class="lPad20"><input type="radio" id="optionOpen" class="radio" name="useOpt" value="Y" checked onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_options','option','public');" /> <label for="optionOpen">공개</label></span>
								<span class="lPad20"><input type="radio" id="optionClosed" class="radio" name="useOpt" value="N" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_options','option','private');"/> <label for="optionClosed">비공개</label></span>
							</td>
						</tr>
					<% else %>
						<% if oitem.Prd.FOptionCnt>0 then %>
						<tr>
							<th scope="row" class="ct">옵션</th>
							<td>
								<span class="lPad20">
								<%
									Response.Write getOneTypeOptionBoxHtml(itemid,false,"class=""optSelect2""")
								%>
								</span>
								<input type="hidden" name="itemoption" value="" />
								<input type="hidden" name="itemoptNm" value="" />
								<!--
								<span class="lPad20"><input type="radio" id="optionOpen" class="radio" name="useOpt" value="Y" checked onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_options','option','public');" /> <label for="optionOpen">공개</label></span>
								<span class="lPad20"><input type="radio" id="optionClosed" class="radio" name="useOpt" value="N" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_options','option','private');"/> <label for="optionClosed">비공개</label></span>
								-->
							</td>
						</tr>
						<% end if %>
					<% end if %>
						<%
						'//상품고시관련 상품후기 제외 상품이 아닐경우
						if Eval_excludeyn="N" then
						%>
						<tr>
							<th scope="row" class="ct"><label for="productComment">상품평</label></th>
							<td>
								<textarea id="productComment" name="usedcontents" cols="60" rows="8" placeholder="상품평은 최소 10자 이상 입력해주세요." style="width:95.5%; height:188px; ime-mode:active;"><%= EvList.FEvalItem.FUesdContents %></textarea>
								<p class="tPad07 fs12">상품평과 상관없는 판매 관련이나 관련 홍보글은 사전통보없이 관리자에 의해 삭제될 수 있습니다.</p>
							</td>
						</tr>
						<tr>
							<th scope="row" class="ct">첨부이미지</th>
							<td>
								<div class="attachFile" id="idDivInputFile1">
									<input type="file" name="file1" id="file1" title="첨부이미지 찾아보기" class="inputFile" style="width:570px;" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_files','','');" />
									<a href="javascript:jsDelUpFile('idDivInputFile1');" class="btnListDel">삭제</a>
									<% if EvList.FEvalItem.Flinkimg1<>"" then %>
									<div class="imgArea">
										<img src="<%= EvList.FEvalItem.getLinkImage1 %>" alt="상품후기 이미지" />
										<span><input type="checkbox" id="imgDelete01" name="file1_del" class="check" /> <label for="imgDelete01">등록된 이미지 삭제</label></span>
									</div>
									<% end if %>
								</div>
								<div class="attachFile tMar10" id="idDivInputFile2">
									<input type="file" name="file2" id="file2" title="첨부이미지 찾아보기" class="inputFile" style="width:570px;" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_files','','');"/>
									<a href="javascript:jsDelUpFile('idDivInputFile2');" class="btnListDel">삭제</a>
									<% if EvList.FEvalItem.Flinkimg2<>"" then %>
									<div class="imgArea">
										<img src="<%= EvList.FEvalItem.getLinkImage2 %>" alt="상품후기 이미지" />
										<span><input type="checkbox" id="imgDelete02" name="file2_del" class="check" /> <label for="imgDelete02">등록된 이미지 삭제</label></span>
									</div>
									<% end if %>
								</div>

								<div class="attachFile tMar10" id="idDivInputFile3">
									<input type="file" name="file3" id="file3" title="첨부이미지 찾아보기" class="inputFile" style="width:570px;" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_files','','');"/>
									<a href="javascript:jsDelUpFile('idDivInputFile3');" class="btnListDel">삭제</a>
									<% if EvList.FEvalItem.Flinkimg3<>"" then %>
									<div class="imgArea">
										<img src="<%= EvList.FEvalItem.getLinkImage3 %>" alt="상품후기 이미지" />
										<span><input type="checkbox" id="imgDelete03" name="file3_del" class="check" /> <label for="imgDelete03">등록된 이미지 삭제</label></span>
									</div>
									<% end if %>
								</div>

								<p class="tMar07 fs12">파일크기는 1MB이하, JPG 또는 GIF형식의 파일만 가능합니다. 사이즈는 가로 450이하로 설정해 주시기 바랍니다.</p>
							</td>
						</tr>
						<%
						'//상품고시관련 상품후기 제외 상품일경우
						else
						%>
							<style>
							.healthNoti {background:#f7f7f7;}
							.healthNoti p {text-align:center; font-size:11px; margin:30px 0 25px; padding-top:40px; background:url(//fiximage.10x10.co.kr/web2013/common/ico_warning02.png) center top no-repeat;}
							</style>
							<tr>
								<td colspan="2" class="healthNoti">
									<input type="hidden" name="usedcontents" value="<%= EvList.FEvalItem.FUesdContents %>">
									<p>본 상품은 건강식품 및 의료기기에 해당되는 상품으로 고객 상품평 이용이 제한됩니다.<br />(만족도 평가를 이용바랍니다.)</p>
								</td>
							</tr>
						<% end if %>
	
					
						<tr>
							<th scope="row" class="ct">만족도 평가</th>
							<td>
								<div class="satisfactionList">
									<div class="itemField">
										<span>총평</span>
										<ul>
											<li><input name="totPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','5|overall');" value="5" <% if EvList.FEvalItem.FTotalPoint="5" or isNull(EvList.FEvalItem.FTotalPoint) then response.write "checked" %> id="satisfaction15" /> <label for="satisfaction15"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

											<li><input name="totPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','4|overall');" value="4" <% if EvList.FEvalItem.FTotalPoint="4" then response.write "checked" %> id="satisfaction11" /> <label for="satisfaction11"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
											<li><input type="radio" name="totPnt" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','3|overall');" type="radio" value="3" <% if EvList.FEvalItem.FTotalPoint="3" then response.write "checked" %> id="satisfaction12" /> <label for="satisfaction12"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
											<li><input type="radio" name="totPnt" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','2|overall');" type="radio" value="2" <% if EvList.FEvalItem.FTotalPoint="2" then response.write "checked" %> id="satisfaction13" /> <label for="satisfaction14"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
											<li><input type="radio" name="totPnt" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','1|overall');" type="radio" value="1" <% if EvList.FEvalItem.FTotalPoint="1" then response.write "checked" %> id="satisfaction14" /> <label for="satisfaction14"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
										</ul>
									</div>
<% if  EvList.FEvalItem.IsTicketItem then %>
									<input name="funPnt" type="hidden" value="<%= CHKIIF(IsNULL(EvList.FEvalItem.FPoint_fun),"0",EvList.FEvalItem.FPoint_fun) %>" >
									<input name="dgnPnt" type="hidden" value="<%= CHKIIF(IsNULL(EvList.FEvalItem.FPoint_dgn),"0",EvList.FEvalItem.FPoint_dgn) %>" >
									<input name="PrcPnt" type="hidden" value="<%= CHKIIF(IsNULL(EvList.FEvalItem.FPoint_prc),"0",EvList.FEvalItem.FPoint_prc) %>" >
									<input name="stfPnt" type="hidden" value="<%= CHKIIF(IsNULL(EvList.FEvalItem.FPoint_stf),"0",EvList.FEvalItem.FPoint_stf) %>" >
<% else %>
									<div class="itemField">
										<span>기능</span>
										<ul>
											<li><input name="funPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','5|functionality');" value="5" <% if EvList.FEvalItem.FPoint_fun="5" or isNull(EvList.FEvalItem.FPoint_fun) then response.write "checked" %> id="satisfaction25" /> <label for="satisfaction25"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

											<li><input name="funPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','4|functionality');" value="4" <% if EvList.FEvalItem.FPoint_fun="4" then response.write "checked" %> id="satisfaction21" /> <label for="satisfaction21"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
											<li><input name="funPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','3|functionality');" value="3" <% if EvList.FEvalItem.FPoint_fun="3" then response.write "checked" %> id="satisfaction22" /> <label for="satisfaction22"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
											<li><input name="funPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','2|functionality');" value="2" <% if EvList.FEvalItem.FPoint_fun="2" then response.write "checked" %> id="satisfaction23" /> <label for="satisfaction23"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
											<li><input name="funPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','1|functionality');" value="1" <% if EvList.FEvalItem.FPoint_fun="1" then response.write "checked" %> id="satisfaction24" /> <label for="satisfaction24"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
										</ul>
									</div>
									<div class="itemField">
										<span>디자인</span>
										<ul>
											<li><input name="dgnPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','5|design');" value="5" <% if EvList.FEvalItem.FPoint_dgn="5" or isNull(EvList.FEvalItem.FPoint_dgn) then response.write "checked" %> id="satisfaction35" /> <label for="satisfaction35"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

											<li><input name="dgnPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','4|design');" value="4" <% if EvList.FEvalItem.FPoint_dgn="4" then response.write "checked" %> id="satisfaction31" /> <label for="satisfaction31"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
											<li><input name="dgnPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','3|design');" value="3" <% if EvList.FEvalItem.FPoint_dgn="3" then response.write "checked" %> id="satisfaction32" /> <label for="satisfaction32"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
											<li><input name="dgnPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','2|design');" value="2" <% if EvList.FEvalItem.FPoint_dgn="2" then response.write "checked" %> id="satisfaction33" /> <label for="satisfaction33"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
											<li><input name="dgnPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','1|design');" value="1" <% if EvList.FEvalItem.FPoint_dgn="1" then response.write "checked" %> id="satisfaction34" /> <label for="satisfaction34"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
										</ul>
									</div>
									<div class="itemField">
										<span>가격</span>
										<ul>
											<li><input name="PrcPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','5|price');" value="5" <% if EvList.FEvalItem.FPoint_prc="5" or isNull(EvList.FEvalItem.FPoint_prc) then response.write "checked" %> id="satisfaction45" /> <label for="satisfaction45"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

											<li><input name="PrcPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','4|price');" value="4" <% if EvList.FEvalItem.FPoint_prc="4" then response.write "checked" %> id="satisfaction41" /> <label for="satisfaction41"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
											<li><input name="PrcPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','3|price');" value="3" <% if EvList.FEvalItem.FPoint_prc="3" then response.write "checked" %> id="satisfaction42" /> <label for="satisfaction42"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
											<li><input name="PrcPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','2|price');" value="2" <% if EvList.FEvalItem.FPoint_prc="2" then response.write "checked" %> id="satisfaction43" /> <label for="satisfaction43"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
											<li><input name="PrcPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','1|price');" value="1" <% if EvList.FEvalItem.FPoint_prc="1" then response.write "checked" %> id="satisfaction44" /> <label for="satisfaction44"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
										</ul>
									</div>
									<div class="itemField">
										<span>만족도</span>
										<ul>
											<li><input name="stfPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','5|satisfaction');" value="5" <% if EvList.FEvalItem.FPoint_stf="5" or isNull(EvList.FEvalItem.FPoint_stf) then response.write "checked" %> id="satisfaction55" /> <label for="satisfaction55"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_05.png" alt="별5개" /></label></li>

											<li><input name="stfPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','4|satisfaction');" value="4" <% if EvList.FEvalItem.FPoint_stf="4" then response.write "checked" %> id="satisfaction51" /> <label for="satisfaction51"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_04.png" alt="별4개" /></label></li>
											<li><input name="stfPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','3|satisfaction');" value="3" <% if EvList.FEvalItem.FPoint_stf="3" then response.write "checked" %> id="satisfaction52" /> <label for="satisfaction52"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_03.png" alt="별3개" /></label></li>
											<li><input name="stfPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','2|satisfaction');" value="2" <% if EvList.FEvalItem.FPoint_stf="2" then response.write "checked" %> id="satisfaction53" /> <label for="satisfaction53"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_02.png" alt="별2개" /></label></li>
											<li><input name="stfPnt" type="radio" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_star','star|type','1|satisfaction');" value="1" <% if EvList.FEvalItem.FPoint_stf="1" then response.write "checked" %> id="satisfaction54" /> <label for="satisfaction54"><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_01.png" alt="별1개" /></label></li>
										</ul>
									</div>
<% end if %>
								</div>
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad30">
							<a href="javascript:SubmitForm(document.FrmGoodusing);" class="btn btnS1 btnRed btnW160" onclick="fnAmplitudeEventMultiPropertiesAction('click_my_review_regist','','');">저장하기</a>
							<a href="javascript:self.close();" class="btn btnS1 btnGry btnW160">취소하기</a>
						</div>
					</fieldset>

					</form>

				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%

set EvList= nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->