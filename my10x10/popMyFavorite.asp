<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2010.04.09 한용민 생성
'           : 2013.09.12 허진원 2013리뉴얼
'	Description : 위시리스트 담기
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 위시리스트 담기"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<%
dim i, sqlStr
dim userid, bagarray, mode, itemid, vOpenerChk, ttFolderCnt
dim backurl,fidx
dim arrList, intLoop

userid  	= getEncLoginUserID
bagarray	= Trim(requestCheckvar(request("bagarray"),1024))
mode    	= requestCheckvar(request("mode"),16)
itemid  	= requestCheckvar(request("itemid"),9)
fidx		= requestCheckvar(request("fidx"),9)
vOpenerChk	= requestCheckvar(request("op"),1)

if (InStr(LCase(backurl),"10x10.co.kr") < 0) then
	 Alert_return("유입경로에 문제가 있습니다.")
	dbget.Close :response.end
end if

'// 특정상품 Wish불가
if itemid="1212183" or itemid="1404138" or itemid="1404911" then
	Alert_close("Wish에 담을 수 없는 상품입니다.")
	dbget.Close :response.end
end if
if inStr(bagarray,"1212183")>0 or inStr(bagarray,"1404138")>0 or inStr(bagarray,"1404911")>0 then
	Alert_close("Wish에 담을 수 없는 상품이 포함되어 있습니다.")
	dbget.Close :response.end
end if

dim myfavorite
set myfavorite = new CMyFavorite
	'---데이터 처리
	myfavorite.FRectUserID      	= userid
	myfavorite.FFolderIdx		= fidx
	
	arrList = myfavorite.fnGetFolderList2	
set myfavorite = nothing

if isArray(arrList) then
	ttFolderCnt = UBound(arrList,2)+1
else
	ttFolderCnt = 1
end if

if fidx="" then fidx="0"

'// datadive 전송 위해 상품명 조회
Dim itemname, brand_id, brand_name, category_name
sqlStr =          "SELECT makerid, "
sqlStr = sqlStr & "        brandname, "
sqlStr = sqlStr & "        itemname, "
sqlStr = sqlStr & "        (SELECT top 1 code_nm "
sqlStr = sqlStr & "         FROM   [db_item].[dbo].[tbl_Cate_large] "
sqlStr = sqlStr & "         WHERE  code_large = it.cate_large ) AS category_name "
sqlStr = sqlStr & " FROM   [db_item].[dbo].[tbl_item] it "
sqlStr = sqlStr & " WHERE itemid ='" & itemid & "'"
rsget.Open SqlStr, dbget, 1
if Not rsget.Eof then
    brand_id = rsget(0)
    brand_name = rsget(1)
    itemname = rsget(2)
    category_name = rsget(3)
Else
    Alert_close("Wish에 담을 수 없는 상품입니다.")
    dbget.Close :response.end
End If
rsget.Close

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
function TnWishList(sUrl){

    if(sUrl == 'close'){
        // 위시 앰플리튜드 연동
        let keys = 'brand_id|brand_name|category_name|item_id|product_name';
        let values = '<%=brand_id%>'+ '|' + '<%=brand_name%>' + '|' + '<%=category_name%>' + '|' + '<%=itemid%>' + '|' + '<%=itemname%>';
        fnAmplitudeEventMultiPropertiesAction('click_wish_in_product', keys, values);
    }

	var frm = document.frmW;
	frm.backurl.value = sUrl;
	frm.fidx.value = $("input[name='selfidx']:checked").val();
	frm.submit();
}

function jsSubmitFolder(){	
	if(!jsChkNull("text",document.frmF.sFN,"폴더명을 입력해주세요")){
		document.frmF.sFN.focus();
		return;
	}

	if(!jsChkNull("radio",document.frmF.viewisusing,"공개 여부를 선택해 주세요")){		
		return;
	}
	
	document.frmF.submit();
}

$(function(){
	// layer popup
	$('.addInfo').hover(function(){
		$(this).next('.contLyr').toggle();
	});

	$("#sFn").focus(function(){
		$(this).val("");
		$("#divF").show();
	});

	$("#btnAdC").click(function(e){
		e.preventDefault();
		$("#sFn").val("새 폴더 추가하기");
		$("#divF").hide();
	});

	$(".folderList li").click(function(){
		$(this).find("input[name='selfidx']").prop("checked",true);
	});

	//팝업 리사이즈 (+20,60)
	resizeTo(500,590);
});
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_wish_folder.gif" alt="위시 폴더" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="folderItem wishFolder">
					<fieldset>
					<legend>위시 폴더 리스트</legend>
						<div class="folderList" <%=chkIIF(ttFolderCnt<=9,"","style=""height:197px;""")%>>
							<ul>
							<%
								IF isArray(arrList) THEN
									For intLoop = 0 To UBound(arrList,2)
							%>
								<li>
									<span><input type="radio" name="selfidx" id="folder<%=intLoop%>" value="<%=arrList(0,intLoop)%>" class="check" <%=chkIIF(Cstr(fidx)=Cstr(arrList(0,intLoop)),"checked","")%> /> <label for="folder<%=intLoop%>"><%=chkIIF(arrList(0,intLoop)="0","기본폴더",arrList(1,intLoop))%></label></span>
									<% IF Trim(arrList(1,intLoop)) = "괜찮아요?" AND Now() < #01/19/2015 00:00:00# then %><em class="crMint fs11">| 이벤트 진행 중 |</em><% end if %>
									<% IF Trim(arrList(1,intLoop)) = "오늘은 털날" AND Now() < #02/14/2016 23:59:59# then %><em class="crMint fs11">| 이벤트 진행 중 |</em><% end if %>
									<% if arrList(2,intLoop)="Y" then %><img src="http://fiximage.10x10.co.kr/web2013/common/ico_open.gif" alt="공개" /><% end if %>
								</li>
							<%
									Next

									'빈칸 채움 (3개 기본)
									if UBound(arrList,2)<2 then
										for intLoop=UBound(arrList,2) to 1
											Response.write "<li class=""noData""></li>"
										next
									end if
								else
							%>
								<li>
									<span><input type="radio" name="selfidx" id="folder0" value="" class="check" checked /> <label for="folder0">기본폴더</label></span>
								</li>
								<li class="noData"></li>
								<li class="noData"></li>
							<%	end If %>
							</ul>
						</div>
					</fieldset>

					<% if ttFolderCnt<9 then %>
					<fieldset>
						<legend>위시 새폴더 추가하기</legend>
						<div class="newFloder">
				    	<form name="frmF" method="post" action="myfavorite_folderProc.asp" style="margin:0px;">
				    	<input type="hidden" name="hidM" value="I">
				    	<input type="hidden" name="bagarray" value="<%=bagarray%>">
						<input type="hidden" name="mode" value="<%=mode%>">
						<input type="hidden" name="itemid" value="<%=itemid%>">
				    	<input type="hidden" name="backurl" value="popMyFavorite.asp">	
				    	<input type="hidden" name="op" value="<%=vOpenerChk%>">	
							<span class="add"><input type="text" id="sFn" name="sFN" title="새 폴더 추가" value="새 폴더 추가하기" placeholder="10자 이내로 작성" maxlength="10" class="txtInp" onKeyPress="if (event.keyCode == 13){ jsSubmitFolder();return false;}" /></span>
							<div id="divF" class="setting" style="display:none;">
								<div class="choice">
									<input type="radio" name="viewisusing" id="folderOpen" value="Y" checked class="radio" /><label for="folderOpen">공개</label>
									<input type="radio" name="viewisusing" id="folderClose" value="N" class="radio" /><label for="folderClose">비공개</label>
								</div>

								<div class="addInfo">
									<span class="ico">도움말 보기</span>
									<div class="contLyr">
										<div class="contLyrInner">
											<ul class="list">
												<li><strong>공개</strong> : 폴더를 공개로 설정하시면 해당 폴더명과 폴더 내에 있는 상품은 모두 공개 됩니다. </li>
												<li><strong>비공개</strong> : 폴더를 비공개로 설정하시면 해당 폴더명과 폴더 내에 있는 상품은 모두 비공개 됩니다.</li>
											</ul>
										</div>
									</div>
								</div>

								<div class="folderBtn">
									<a href="" class="btn btnS4 btnGry2 fn" onclick="jsSubmitFolder(); return false;">확인</a>
									<a href="" id="btnAdC" class="btn btnS4 btnGry2 fn">취소</a>
								</div>
							</div>
						</form>
						</div>
					</fieldset>
					<% end if %>

					<div class="btnArea ct tPad20">
						<a href="" class="btn btnS1 btnWhite btnW120" onclick="TnWishList('/my10x10/mywishlist.asp');return false;">위시 확인하기</a>
						<a href="" class="btn btnS1 btnRed btnW120" onclick="TnWishList('close');return false;">위시 담기</a>
					</div>

					<div class="help">
						<ul>
							<li>위시폴더 수정과 삭제는 <strong>폴더관리</strong>를 이용해주세요. <a href="popmyfavorite_folder.asp?op=1" class="crRed">폴더관리 이동<img src="http://fiximage.10x10.co.kr/web2013/common/blt05.gif" alt="" /></a></li>
							<li>위시폴더는 기본폴더를 포함, 최대 20개 까지 등록 가능 합니다.</li>
						</ul>
					</div>
				</div>
				<form name="frmW" method="post" action="myfavorite_process.asp">
					<input type="hidden" name="backurl" >
					<input type="hidden" name="bagarray" value="<%=bagarray%>">
					<input type="hidden" name="mode" value="<%=mode%>">
					<input type="hidden" name="itemid" value="<%=itemid%>">
					<input type="hidden" name="fidx" value="">
					<input type="hidden" name="op" value="<%=vOpenerChk%>">
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
<!-- #include virtual="/lib/db/dbclose.asp" -->