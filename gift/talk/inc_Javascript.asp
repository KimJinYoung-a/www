//톡 O,X 혹은 A,B 체크 및 버튼 색상 활성화
function jsTalkvote(idx,tidx,v,i,t,s){
<% If IsUserLoginOK Then %>
	$.ajax({
			url: "/gift/talk/vote.asp?idx="+idx+"&talkidx="+tidx+"&theme="+t+"&vote="+v+"&selectoxab="+s,
			cache: false,
			success: function(message)
			{
				if(message == "0"){
					alert("이미 투표하셨습니다.");
				}else if(message == "ok"){
				    // 선물의 참견 투표 참여 앰플리튜드 연동
                    fnAmplitudeEventMultiPropertiesAction('view_gifttalk', 'click_gifttalk_vote', 'Y');
				}else if(message == "x"){
					alert("삭제된 기프트톡 입니다.");
				}else if(message == "xxx"){
					alert("일시적인 통신장애입니다.\n새로고침 후 다시 투표해주세요.");
				}else{
				    // 선물의 참견 투표 참여 앰플리튜드 연동
                    fnAmplitudeEventMultiPropertiesAction('view_gifttalk', 'click_gifttalk_vote', 'Y');

					<% If (now() >= "2020-10-12" And now() < "2020-10-30") Then %>
					var arrdata="";
					arrdata = message.split("|");
					arrdatacount = arrdata[0].split(",");

					if(arrdata[1]=="t"){
						$("#sucessPop").show();
					}

					if(t == "2"){
						$("#countgood"+idx).text(arrdatacount[0]);
						$("#countbad"+idx).text(arrdatacount[1]);
						$("#btgood"+idx).addClass("on")
					}else if(t == "1"){
						if(v == "good"){
							$("#countgood"+idx).text(arrdatacount[0]);
							$("#btgood"+idx).addClass("on")
						}else{
							$("#countbad"+idx).text(arrdatacount[1]);
							$("#btbad"+idx).addClass("on")
						}
					}
					<% else %>
					if(t == "2"){
						$("#countgood"+idx).text(message.split(",")[0]);
						$("#countbad"+idx).text(message.split(",")[1]);
						$("#btgood"+idx).addClass("on")
					}else if(t == "1"){
						if(v == "good"){
							$("#countgood"+idx).text(message.split(",")[0]);
							$("#btgood"+idx).addClass("on")
						}else{
							$("#countbad"+idx).text(message.split(",")[1]);
							$("#btbad"+idx).addClass("on")
						}
					}
					<% end if %>
				}
			}
	});
<% Else %>
	if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
		var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
		winLogin.focus();
		return;
	}else{
		return;
	}
<% End If %>
}

//톡 삭제
function jsMyTalkEdit(tidx){
	if(confirm("선택한 글을 삭제하시겠습니까?") == true) {
		$('input[id="gubun"]').val("d");
		$('input[id="talkidx"]').val(tidx);
		frm1.target = "iframeproc";
		frm1.submit();
		return true;
	} else {
		return false;
	}
}

//기프트 톡 수정
function goPopTalkModify(a){
	var PopTalkModify = window.open('/gift/talk/modify.asp?talkidx='+a+'','PopTalkModify','width=720, height=700, scrollbars=yes');
	PopTalkModify.focus();
}

//기프트톡 신규 작성
function goWriteTalk(){
	<% If IsUserLoginOK Then %>
		location.href = "/gift/talk/write.asp";
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}else{
			return;
		}
	<% End If %>
}

//빠른상품추가 탭 변환(상품검색,마이위시,최근본상품)
function jsTalkRightListTabChange(a){
	$.ajax({
			url: "/gift/talk/write_right_ajax.asp?tab="+a+"",
			cache: false,
			success: function(message)
			{
				$("#write_right").empty().append(message);
			}
	});
}

//톡쓰기 상품검색 검색어 체크
function jsTalkRightSearchInput(){
	if($("#searchtxt").val() == "상품코드 또는 검색어를 입력하세요"){
		$("#searchtxt").val("");
	}
}

//www용

//####### write
function jsTalkRightListFirst(g){
	$.ajax({
			url: "/gift/talk/write_right_ajax.asp?gb="+g+"",
			cache: false,
			success: function(message)
			{
				$("#write_right").empty().append(message);
			}
	});
}

function jsTalkWriteSave(){

	if(talkfrm.contents.value == "" || talkfrm.contents.value == "100자 이내로 작성해주세요."+String.fromCharCode(10)+"(톡과 관련 없는 글은 사전통보 없이 관리자에 의해 삭제 될 수 있습니다.)"){
		alert("상품에 대한 내용을 작성하세요.");
		talkfrm.contents.value = "";
		talkfrm.contents.focus();
		return;
	}
	
	if(talkfrm.itemid.value == "" || talkfrm.itemid.value == ","){
		alert("상품을 선택해 주세요.");
		return;
	}
	
	<% If vTalkIdx <> "" Then %>
		talkfrm.gubun.value = "u";
	<% End If %>

    // 선물의 참견 게시글 작성 앰플리튜드 연동
    fnAmplitudeEventMultiPropertiesAction('view_gifttalk', 'click_gifttalk_write', 'Y');

	talkfrm.submit();
}

//상품 셀렉트ajax
function jsTalkSelectItem(i){
	var iid = talkfrm.itemid;
	var ict = talkfrm.itemcount;
	var isExist = $("#itemid").attr("value").indexOf(','+i+',') > -1;
	if(!isExist){
		if(parseInt(ict.value) > 1){
			alert("상품은 2개까지만 선택할 수 있습니다.");
			return;
		}
	}

	$.ajax({
			url: "/gift/talk/itemselect_ajax.asp?itemid="+i+"&nowitem="+iid.value+"&nowcnt="+ict.value+"",
			cache: false,
			success: function(message)
			{
				$("#itemselectarea").empty().append(message);
				if(isExist){
					iid.value = $("#itemid").attr("value").replace(i,"");
					iid.value = $("#itemid").attr("value").replace(",,",",");
					jsItemCount("-");
				}else{
					iid.value = iid.value + i + ",";
					jsItemCount("+");
				}
			}
	});
}

/*
//기프트톡 쓰기(NEW)
function writeShoppingTalkNew() {
	$.ajax({
		url: "/gift/talk/doShoppingTalkProc.asp?gubun=d",
		cache: false,
		success: function(message) {
			top.location.href='/gift/talk/write.asp?talkidx=';
			//goBack('/gift/talk/write.asp?talkidx=');
		}
		,error: function(err) {
			alert(err.responseText);
			goBack('/gift/talk/');
		}
	});
}

function writeShoppingTalk(tidx,titemid){
	location.href="/gift/talk/write.asp?talkidx="+tidx+"&gubun=u&itemid="+titemid;
}

//빠른상품추가 상품검색 페이지 보기
function gogifttalksearch(){
	location.href="/gift/talk/search.asp"
}
*/