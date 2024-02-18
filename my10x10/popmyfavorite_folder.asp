<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2010.04.09 한용민 생성
'           : 2013.09.12 허진원 2013리뉴얼
'	Description : 위시리스트 폴더 관리
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 위시리스트 폴더관리"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<%
dim i, sqlStr
dim userid, bagarray, mode, itemid, ttFolderCnt
dim backurl,fidx
dim arrList, intLoop, op


userid  	= getEncLoginUserID
fidx		= requestCheckvar(request("fidx"),9)
op		= requestCheckvar(request("op"),9)

if (InStr(LCase(backurl),"10x10.co.kr") < 0) then
	 Alert_return("유입경로에 문제가 있습니다.")
	dbget.Close :response.end
end if

dim myfavorite
set myfavorite = new CMyFavorite	
	myfavorite.FRectUserID      	= userid	
	arrList = myfavorite.fnGetFolderList2	
set myfavorite = nothing

if isArray(arrList) then
	ttFolderCnt = UBound(arrList,2)+1
else
	ttFolderCnt = 1
end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
function jsSubmitFolder(){	
	if(!jsChkNull("text",document.frmF.sFn,"폴더명을 입력해주세요")){
		document.frmF.sFn.focus();
		return;
	}
	
	if(!jsChkNull("radio",document.frmF.viewisusing,"공개 여부를 선택해 주세요")){		
		return;
	}	
	
	document.frmF.hidM.value="I";
	document.frmF.submit();
}

function jsDelFolder(fidx){	
	if(confirm("폴더 삭제시 폴더에 포함된  위시리스트가 모두 삭제됩니다.\n\n폴더를 삭제하시겠습니까? ")){
		document.frmD.fidx.value = fidx;
		document.frmD.submit();
	}
}

$(function(){
	// layer popup
	$('.addInfo').hover(function(){
		$(this).next('.contLyr').toggle();
	});

	$("#sFn").focus(function(){
		$(this).val("");
		$("#divF").show();
		$(".btn-reoreder").hide();
	});

	$("#btnAdC").click(function(e){
		e.preventDefault();
		$("#sFn").val("새 폴더 추가하기");
		$("#divF").hide();
		$(".btn-reoreder").show();
	});

	$(".btnModify").click(function(e){
		e.preventDefault();
		$(".folderModify").hide();
		$(this).parent().parent().next(".folderModify").show();
		$(this).parent().parent().next(".folderModify").find("input[name^='mdyNm']").focus();
	});

	$(".btnModiCancel").click(function(e){
		e.preventDefault();
		$(this).parent().parent().hide();
	});

	$(".btnModiOk").click(function(e){
		e.preventDefault();
		var $obj = $(this).parent().parent();
		var idx = $obj.find("input[name^='mdyId']").val();
		var fnm = $obj.find("input[name^='mdyNm']").val();
		var fvw = $obj.find("input[name^='mdyVw']:checked").val();

		if(fnm=="") {
			alert("폴더명을 입력해주세요.");
			$obj.find("input[name^='mdyNm']").focus();
			return;
		}

		document.frmU.hidM.value="U";
		document.frmU.fidx.value=idx;
		document.frmU.sFn.value=fnm;
		document.frmU.viewisusing.value=fvw;

		document.frmU.submit();
	});

	//팝업 리사이즈 (+20,50)
	resizeTo(500,580);
});
function chgsort(){
	$("#sortable li").each(function(index){
		$("#sort"+$(this).attr("fidx")).val($(this).index());
	});
	document.frmS.submit();
}
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_folder_manage.gif" alt="폴더 관리" /></h1>
			</div>
			<div class="popContent">
				<div class="folderItem folderManage">
				<!-- content -->
					<ul class="list bPad15">
						<li>위시폴더는 기본폴더를 포함, 최대 20개 까지 등록 가능 합니다.</li>
					</ul>
					<fieldset>
					<legend>폴더 리스트</legend>
						<div id="sortable" class="folderList" <%=chkIIF(ttFolderCnt<=9,"","style=""height:295px;""")%>>
							<ul>
							<form name="frmS" method="post" action="/my10x10/myfavorite_folderProc.asp" style="margin:0px;">
							<input type="hidden" name="hidM" value="S">
							<input type="hidden" name="backurl" value="popmyfavorite_folder.asp">
							<input type="hidden" name="backbackurl" value="<%=backurl%>">
							<%
								IF isArray(arrList) THEN
									For intLoop = 0 To UBound(arrList,2)
							%>
								<li <% If arrList(0,intLoop) = "0" Then %>class="ui-state-disabled"<% End If %> fidx="<%=arrList(0,intLoop)%>">
									<input type="hidden" name="chkidx" value="<%=arrList(0,intLoop)%>"/><input type="hidden" name="sort<%=arrList(0,intLoop)%>" id="sort<%=arrList(0,intLoop)%>" value=""/>
									<div class="folder-name">
										<span><%=chkIIF(arrList(0,intLoop)="0","기본폴더",arrList(1,intLoop))%></span>
										<% IF Trim(arrList(1,intLoop)) = "괜찮아요?" AND Now() < #01/19/2015 00:00:00# then %><em class="crMint fs11">| 이벤트 진행 중 |</em><% end if %>
										<% if arrList(2,intLoop)="Y" then %><img src="http://fiximage.10x10.co.kr/web2013/common/ico_open.gif" alt="공개" /><% end if %>
										<% if arrList(0,intLoop)<>"0" then %>
										<div class="btnArea">
											<a href="" class="btn btnS4 btnGry2 fn btnModify">수정</a>
											<a href="" class="btn btnS4 btnGry2 fn" onclick="jsDelFolder(<%=arrList(0,intLoop)%>); return false;">삭제</a>
										</div>
										<% end if %>
									</div>
									<div class="folderModify" style="display:none;">
										<div class="modifying">
											<input type="hidden" name="mdyId<%=intLoop+1%>" value="<%=arrList(0,intLoop)%>">
											<span class="add"><input type="text" name="mdyNm<%=intLoop+1%>" title="폴더 이름 입력" value="<%=arrList(1,intLoop)%>" class="txtInp" /></span>
											<div class="setting">
												<div class="choice">
													<input type="radio" name="mdyVw<%=intLoop+1%>" id="folderOpen<%=intLoop+1%>" <%=chkIIF(arrList(2,intLoop)="Y","checked","")%> value="Y" class="radio" /><label for="folderOpen<%=intLoop+1%>">공개</label>
													<input type="radio" name="mdyVw<%=intLoop+1%>" id="folderClose<%=intLoop+1%>" <%=chkIIF(arrList(2,intLoop)="N","checked","")%> value="N" class="radio" /><label for="folderClose<%=intLoop+1%>">비공개</label>
												</div>
											</div>
										</div>
										<div class="btnArea">
											<a href="" class="btn btnS2 btnGry fn btnModiOk">확인</a>
											<a href="" class="btn btnS2 btnGry fn btnModiCancel">취소</a>
										</div>
									</div>
								</li>
							<%
									Next

									'빈칸 채움 (5개 기본)
									if UBound(arrList,2)<4 then
										for intLoop=UBound(arrList,2) to 3
											Response.write "<li class=""noData ui-state-disabled""></li>"
										next
									end if
								else
							%>
								<li class="ui-state-disabled">
									<span>기본폴더</span>
								</li>
								<li class="noData ui-state-disabled"></li><li class="noData ui-state-disabled"></li>
								<li class="noData ui-state-disabled"></li><li class="noData ui-state-disabled"></li>
							<%	end If %>
							</form>
							</ul>
						</div>
					</fieldset>

					<% if ttFolderCnt<=19 then %>
					<fieldset>
						<legend>새폴더 추가하기</legend>
						<div class="newFloder">
							<span class="btn-reoreder"><input type="button" title="순서편집" value="순서편집" class="btnS2 btnWhite3" /></span>
							<div class="infoTxt" style="display:none;">
								<p class="ftLt"><img src='http://fiximage.10x10.co.kr/web2018/my10x10/btn_reorder.png' alt='순서변경' /> 를 드래그하여 원하는 위치로 옮기세요.</p>
								<p class="ftRt">
									<input type="button" title="저장" value="저장" class="btnS5 btnRed btnRegist" onclick="chgsort();" />
									<input type="button" title="취소" value="취소" class="btnS5 btn-order-cancel" />
								</p>
							</div>
							<form name="frmF" method="post" action="myfavorite_folderProc.asp">	
							<input type="hidden" name="hidM" value="I">
							<input type="hidden" name="backurl" value="Popmyfavorite_folder.asp">
							<input type="hidden" name="op" value="<%=op%>">
								<span class="add"><input type="text" id="sFn" name="sFn" title="새 폴더 추가" value="새 폴더 추가하기" placeholder="10자 이내로 작성" maxlength="10" class="txtInp" onKeyPress="if (event.keyCode == 13){ jsSubmitFolder();return false;}" /></span>
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
				</div>
				<form name="frmU" method="post" action="myfavorite_folderProc.asp">
				<input type="hidden" name="hidM" value="U">
				<input type="hidden" name="backurl" value="Popmyfavorite_folder.asp">
				<input type="hidden" name="fidx" value="">
				<input type="hidden" name="sFn" value="">
				<input type="hidden" name="viewisusing" value="">
				<input type="hidden" name="op" value="<%=op%>">
				</form>
				<form name="frmD" method="post" action="myfavorite_folderProc.asp">
				<input type="hidden" name="hidM" value="D">
				<input type="hidden" name="backurl" value="Popmyfavorite_folder.asp">
				<input type="hidden" name="fidx" value="">
				<input type="hidden" name="op" value="<%=op%>">
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
<%' for dev msg : 위시폴더순서편집(20180816) %>
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script>
$(function() {
	$("#sortable .folder-name").prepend("<span class='sorting-action'></span>");
	$(".btn-reoreder").on('click',function() {
		$("#sortable").addClass('sortable');
		$("#sortable li .sorting-action").html("<img src='http://fiximage.10x10.co.kr/web2018/my10x10/btn_reorder.png' alt='순서변경' />");
		$("#sortable li.ui-state-disabled .sorting-action").html("&nbsp;");
		$("#sortable").sortable({
			placeholder:"ui-state-highlight",
			items:"li:not(.ui-state-disabled)"
		}).disableSelection();
		$("#sortable .btnArea").hide();
		$(".infoTxt").show();
		$(".newFloder .add").hide();
		$("#sortable li.folderModify .sorting-action").hide();
		$(".btn-reoreder").hide();
	});
	$(".btn-order-cancel").on('click',function() {
		$("#sortable").removeClass('sortable');
		$("#sortable li .sorting-action").html("");
		$("#sortable").sortable("destroy");
		$(".btnRegist").prop("disabled", false);
		$(".infoTxt").hide();
		$(".newFloder .add").show();
		$(".btn-reoreder").show();
		$("#sortable .btnArea").show();
	});
});
</script>
<%'// for dev msg : 위시폴더순서편집(20180816) %>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->