////////////////////////////////////////////////////////
// 함수들
////////////////////////////////////////////////////////

// 폼검색
function chgSFragTab(sfg) {
	document.sFrm.sflag.value=sfg;
	document.sFrm.cpg.value=1;
	document.sFrm.submit();
}

// 필터속성 삭제
function delFilterItem(obj) {
	// 선택값 해제
	var sId;
	sId = $(obj).parent().attr("value");

	if(sId=="PrcRng") {
		//가격범위 검사
		$('#ftSelMin').val($('#ftMinPrc').val());
		$('#ftSelMax').val($('#ftMaxPrc').val());
	} else if(sId=="DlvMtd") {
		//배송방법 검사
		$("#fttabDelivery input[name='dlvTp']").eq(0).prop("checked",true);
	} else if(sId=="SrcKwd") {
		//키워드 검사
		$("#fttabSearch input[name='skwd']").val("키워드를 입력해주세요.");
	} else {
		$("#"+sId).prop("checked",false);
	
		//컬러검사
		$("#"+sId).parent().removeClass('selected');
		if(!$("#fttabColor li").has("input:checked").length) $("#fttabColor .all").addClass('selected');
		//스타일검사
		if(!$("#fttabStyle li input:checked").not('#stl0').length) $("#fttabStyle #stl0").prop("checked",true);
	}

	//필터조합 정리
	setSearchFilterItem();

	//전체 삭제여부 검사
	if(!$('#lyrSearchFilter').has('dl').length) {
		document.sFrm.cpg.value=1;
		document.sFrm.submit();
	}
}

// 선택된 검색필터 조합 표시
function setSearchFilterItem() {
	var sFtCont="", sCCd="", sSCd="", sACd="", iPmn="", iPmx="", sDlv="", sKwd="";
	// 컬러
	if($('#fttabColor li input:checked').length) {
		sFtCont += "<dl>"
		sFtCont += "<dt>컬러</dt>"
		$("#fttabColor li input:checked").each(function(){
			if(sCCd!="") sCCd += ",";
			sCCd += $(this).attr("value");
			sFtCont += '<dd value="col' + $(this).attr("value") + '">' + $(this).parent().parent().find("label").text() + ' <img src="http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif" alt="Delete" class="deleteBtn" onclick="delFilterItem(this)" /></dd>'
		});
		sFtCont += "</dl>"
	}

	// 스타일
	if($("#fttabStyle li input:checked").not('#stl0').length) {
		sFtCont += "<dl>"
		sFtCont += "<dt>스타일</dt>"
		$("#fttabStyle li input:checked").not('#stl0').each(function(){
			if(sSCd!="") sSCd += ",";
			sSCd += $(this).attr("value");
			sFtCont += '<dd value="stl' + $(this).attr("value") + '">' + $(this).parent().find("label").text() + ' <img src="http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif" alt="Delete" class="deleteBtn" onclick="delFilterItem(this)" /></dd>'
		});
		sFtCont += "</dl>"
	}

	// 상품속성
	if($("#fttabAttribute li input:checked").length) {
		var tmA = $("#fttabAttribute li input:checked").first().attr("value").substr(0,3);
		sFtCont += "<dl>"
		sFtCont += "<dt>"+ $("#fttabAttribute li input:checked").first().parent().find("label").attr("prv") +"</dt>"
		$("#fttabAttribute li input:checked").each(function(){
			if(sACd!="") sACd += ",";
			sACd += $(this).attr("value");

			if(tmA!=$(this).attr("value").substr(0,3)) {
				//행구분
				tmA=$(this).attr("value").substr(0,3);
				sFtCont += '</dl><dl>';
				sFtCont += '<dt>'+$(this).parent().find("label").attr("prv")+'</dt>';
			}

			sFtCont += '<dd value="Attr' + $(this).attr("value") + '">' + $(this).parent().find("label").text() + ' <img src="http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif" alt="Delete" class="deleteBtn" onclick="delFilterItem(this)" /></dd>'
		});
		sFtCont += "</dl>"
	}

	// 가격범위
	if($('#ftMinPrc').val()!=$('#ftSelMin').val()||$('#ftMaxPrc').val()!=$('#ftSelMax').val()) {
		iPmn = $('#ftSelMin').val();
		iPmx = $('#ftSelMax').val();

		sFtCont += '<dl>';
		sFtCont += '	<dt>가격</dt>';
		sFtCont += '	<dd value="PrcRng">' +setComma(iPmn)+ '원 ~ ' +setComma(iPmx)+ '원 <img src="http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif" alt="Delete" class="deleteBtn" onclick="delFilterItem(this)" /></dd>';
		sFtCont += '</dl>';
	}

	// 배송속성
	if($("#fttabDelivery li input:checked").val()!="") {
		sDlv = $("#fttabDelivery li input:checked").val();
		sFtCont += '<dl>';
		sFtCont += '	<dt>배송</dt>';
		sFtCont += '	<dd value="DlvMtd">' + $("#fttabDelivery li input:checked").parent().find("label").text() + ' <img src="http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif" alt="Delete" class="deleteBtn" onclick="delFilterItem(this)" /></dd>';
		sFtCont += '</dl>';
	}

	// 키워드 (검색결과 페이지 이외에서만 동작)
	if(document.sFrm.lstDiv.value!="search") {
		if(!($("#fttabSearch input[name='skwd']").val()==""||$("#fttabSearch input[name='skwd']").val()=="키워드를 입력해주세요.")) {
			sKwd = $("#fttabSearch input[name='skwd']").val();
			sKwd = Replace(sKwd,"<","");
			sKwd = Replace(sKwd,">","");
			sFtCont += '<dl>';
			sFtCont += '	<dt>키워드</dt>';
			sFtCont += '	<dd value="SrcKwd">' + sKwd + ' <img src="http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif" alt="Delete" class="deleteBtn" onclick="delFilterItem(this)" /></dd>';
			sFtCont += '</dl>';
		}
	}

	// 검색폼에 저장
	document.sFrm.iccd.value=sCCd;
	document.sFrm.styleCd.value=sSCd;
	document.sFrm.attribCd.value=sACd;
	document.sFrm.minPrc.value=iPmn;
	document.sFrm.maxPrc.value=iPmx;
	document.sFrm.deliType.value=sDlv;
	if(document.sFrm.lstDiv.value!="search") document.sFrm.rect.value=sKwd;

	//필터조합 넣기
	$('#lyrSearchFilter').html(sFtCont);

	//조합이 있으면 필터 레이어 출력
	if($('#lyrSearchFilter').has('dl').length) {
		$('.dFilterResult').show();
	} else {
		if(!$('.tabWrapV15 li').hasClass("selected")) {
			$('.dFilterResult').hide();
		}
	}
}


////////////////////////////////////////////////////////
// 액션들
////////////////////////////////////////////////////////
$("document").ready(function(){

	// 필터속성 검색실행 버튼
	$("#btnActFilter").click(function(){
		document.sFrm.cpg.value=1;
		document.sFrm.submit();
		return false;
	});

	// 필터속성 초기화 버튼
	$("#btnRstFilter").click(function(){
		//컬러
		$('#fttabColor li input').prop("checked",false);
		$('#fttabColor li input').removeClass('selected');
		if(!$("#fttabColor li").has("input:checked").length) $("#fttabColor .all").addClass('selected');

		//스타일
		$('#fttabStyle li input').prop("checked",false);
		if(!$("#fttabStyle li input:checked").not('#stl0').length) $("#fttabStyle #stl0").prop("checked",true);

		// 상품속성
		$("#fttabAttribute li input").prop("checked",false);

		//가격범위
		$('#ftSelMin').val($('#ftMinPrc').val());
		$('#ftSelMax').val($('#ftMaxPrc').val());

		//배송방법
		$("#fttabDelivery input[name='dlvTp']").eq(0).prop("checked",true);

		//키워드
		$("#fttabSearch input[name='skwd']").val("키워드를 입력해주세요.");

//		setSearchFilterItem();
		document.sFrm.cpg.value=1;
		document.sFrm.submit();
		return false;
	});

	// 상품정렬순서 변경
	$("#selSrtMet").change(function(){
		document.sFrm.srm.value=$(this).val();
		document.sFrm.submit();
	});

	// 품절상품 보기 여부 변경
	$("#soldoutExc").click(function(){
		if($(this).attr("value")=="Y") {
			document.sFrm.sscp.value="N";
		} else {
			document.sFrm.sscp.value="Y";
		}
		document.sFrm.cpg.value=1;
		document.sFrm.submit();
		return false;
	});

	// 검색 속성탭
//	setSearchFilterItem();
	$('.tabWrapV15 li').append('<dfn></dfn>');
	$('.tabWrapV15 li').click(function(){
		$('.tabWrapV15 li').removeClass('selected');
		$(this).addClass('selected');
		$('.dFilterWrap').hide();
	});

	// 검색 필터 클릭
	$('.dFilterWrap').hide().find(".filterSelect > div").hide();
	$('.dFilterTabV15 li').click(function(){
		if($("[id='"+"ft"+$(this).attr("id")+"']").css("display")=="none") {
			$('.dFilterWrap').show();
			$('.filterSelect > div').hide();
			$("[id='"+'ft'+$(this).attr("id")+"']").show();
			$('.dFilterResult').show();
		} else {
			$('.dFilterWrap').hide();
			$('.filterSelect > div').hide();
			$('.dFilterTabV15 li').removeClass('selected');
			$('.sortingTabV15 li:first-child').addClass('selected');
			if(!$('#lyrSearchFilter').has('dl').length) $('.dFilterResult').hide();
		}
	});

	// 검색 필터 닫기
	$('.filterLyrClose').click(function(){
		$('.dFilterWrap').hide();
		$('.filterSelect > div').hide();
		$('.dFilterTabV15 li').removeClass('selected');
		$('.sortingTabV15 li:first-child').addClass('selected');
		if(!$('#lyrSearchFilter').has('dl').length) $('.dFilterResult').hide();
	});

	//컬러 속성 확인/지정
	$('#fttabColor li input').click(function(){
		if($(this).val()=="0") {
			$(this).prop("checked",true);
			$(this).parent().toggleClass('selected');
			$("#fttabColor li:not('.all')").removeClass('selected');
			$("#fttabColor li input").prop("checked",false);
		} else {
			$(this).parent().toggleClass('selected');
			if($("#fttabColor li").has("input:checked").length) {
				$("#fttabColor .all").removeClass('selected');
			} else{
				$("#fttabColor .all").addClass('selected');
			}
			$("#fttabColor .all input").prop("checked",false);
		}
		setSearchFilterItem();
	});

	//스타일 속성 확인/지정
	$('#fttabStyle li input').click(function(){
		if($(this).val()=="") {
			$(this).prop("checked",true);
			$("#fttabStyle input:not('#stl0')").prop("checked",false);
		} else {
			if($("#fttabStyle li input:checked").not('#stl0').length) {
				$("#fttabStyle #stl0").prop("checked",false);
			} else {
				$("#fttabStyle #stl0").prop("checked",true);
			}
		}
		setSearchFilterItem()
	});

	//상품 속성 확인/지정
	$('#fttabAttribute li input').click(function(){
		setSearchFilterItem()
	});

	//배송 속성 확인/지정
	$('#fttabDelivery li input').click(function(){
		setSearchFilterItem()
	});

	//키워드 속성 Focus/Blur
	$("#fttabSearch input[name='skwd']").focus(function(){
		if($(this).val()=="키워드를 입력해주세요.") {
			$(this).val("");
		}
	}).blur(function(){
		if($(this).val()=="") {
			$(this).val("키워드를 입력해주세요.");
		}
	}).keyup(function(){
		setSearchFilterItem();
	}).keypress(function(e){
		if(e.which == 13 && $(this).val()!="") {
			document.sFrm.cpg.value=1;
			document.sFrm.submit();
			return false;			
		}
	});

	//키워드 속성 버튼
	$("#fttabSearch input[type='image']").click(function(){
		setSearchFilterItem();
	});

	//가격범위 설정
	var ftpmn = parseInt($("#ftMinPrc").val()), ftpmx = parseInt($("#ftMaxPrc").val());
	var scpmn = parseInt($("#listSFrm input[name='minPrc']").val()), scpmx = parseInt($("#listSFrm input[name='maxPrc']").val());
	if(!scpmn) scpmn = ftpmn; if(!scpmx) scpmx = ftpmx;

	$('#slider-range').slider({
		range:true,
		min:ftpmn,
		max:ftpmx,
		values:[scpmn, scpmx],
		step: 100,
		slide:function(event, ui) {
			$('#amountFirst').val(setComma(ui.values[0]) + "원");
			$('#amountEnd').val(setComma(ui.values[1]) + "원");
		},
		stop:function(evnet, ui) {
			$('#ftSelMin').val(ui.values[0]);
			$('#ftSelMax').val(ui.values[1]);
			setSearchFilterItem();
		}
	});
	$("#amountFirst").val(setComma($("#slider-range").slider("values", 0)) + "원");
	$("#amountEnd").val(setComma($("#slider-range").slider("values", 1)) + "원");
	$('.ui-slider a:first').append($('.amoundBox1'));
	$('.ui-slider a:last').append($('.amoundBox2'));

	// 상품아이콘 크기 클릭
	$("#lySchIconSize li").click(function(e) {
		e.preventDefault();
		var sISz = $(this).attr("val");
		
		//버튼 리셋
		$("#lySchIconSize li").removeClass("current");
		//버튼 선택
		$(this).addClass("current");

		$("#listSFrm input[name='icoSize']").val(sISz);
		if(sISz=="B") {
			$("#listSFrm input[name='psz']").val(10);
		} else if(sISz=="M") {
			$("#listSFrm input[name='psz']").val(20);
		} else {
			$("#listSFrm input[name='psz']").val(40);
		}

		$("#listSFrm input[name='cpg']").val(1);
		$("#listSFrm").submit();
	});

	//2023 다이어리 스토리 필터 추가
	//상품 속성 확인/지정
	$('#diaryAttribute li input').click(function(){
		setSearchDiaryFilterItem()
	});
	//컬러 속성 확인/지정
	$('#diaryColorChip li input').click(function(){
		if($(this).val()=="0") {
			// all일 경우
			$(this).prop("checked",true);
			$(this).parents("li").toggleClass('selected');
			$("#diaryColorChip li:not('.all')").removeClass('selected');
			$("#diaryColorChip li input").prop("checked",false);
		} else {
			$(this).parents("li").toggleClass('selected');
			if($("#diaryColorChip li").has("input:checked").length) {
				$("#diaryColorChip .all").removeClass('selected');
			} else{
				$("#diaryColorChip .all").addClass('selected');
			}
			$("#diaryColorChip .all input").prop("checked",false);
		}
		setSearchDiaryFilterItem();
	});

    // 선택된 검색필터 조합 표시
    function setSearchDiaryFilterItem() {
        var sFtCont="", sCCd="", sACd="";
        // 컬러
        if($('#diaryColorChip li input:checked').length) {
            $("#diaryColorChip li input:checked").each(function(){
                if(sCCd!="") sCCd += ",";
                sCCd += $(this).attr("value");
            });
        }

        // 상품속성
        if($("#diaryAttribute li input:checked").length) {
            $("#diaryAttribute li input:checked").each(function(){
                if(sACd!="") sACd += ",";
                sACd += $(this).attr("value");
            });
        }

        // 검색폼에 저장
        document.sFrm.iccd.value=sCCd;
        document.sFrm.attribCd.value=sACd;
        fnDiarySearchFilterCount();
    }
});