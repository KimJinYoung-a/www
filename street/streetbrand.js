//'###########################################################
//' Description :  브랜드스트리트 js모음
//' History : 2013.08.29 한용민 생성
//'###########################################################

//shop 아작스 호출
function goshopView(gourl,reloadyn) {
	var strshopDtl = $.ajax({
			type: "GET",
	        url: gourl,
	        dataType: "text",
	        async: false
	}).responseText;
	$('#sectionshop').empty().html(strshopDtl);

	/////////////////SHOP/////////////////
	$('.brDeliveryInfo').hover(function(){
		$(this).children('.contLyr').toggle();
	});

	// 상품정렬순서 변경
	$("#selSrtMet").unbind("change").change(function(){
		document.sFrm.srm.value=$(this).val();
		goshopsubmit('1')
	});
	// 검색 속성탭
	setSearchFilterItem();
	$('.tabWrap li').append('<dfn></dfn>');
	$('.tabWrap li').unbind("click").click(function(){
		$('.tabWrap li').removeClass('selected');
		$(this).addClass('selected');
		$('.dFilterWrap').hide();
	});
	// 검색 필터 클릭
	$('.dFilterWrap').hide();
	$('.dFilterTab li').unbind("click").click(function(){

		$('.dFilterTab li').removeClass('selected');
		$(this).addClass('selected');

		$('.dFilterWrap').show();
		$('.filterSelect > div').hide();
		$("[id='"+'ft'+$(this).attr("id")+"']").show();
		$('.dFilterResult').show();
	});
	// 검색 필터 닫기
	$('.filterLyrClose').unbind("click").click(function(){
		$('.dFilterWrap').hide();
		$('.dFilterTab li').removeClass('selected');
		$('.sortingTab li:first-child').addClass('selected');
		if(!$('#lyrSearchFilter').has('dl').length) $('.dFilterResult').hide();
	});
	//컬러 속성 확인/지정
	$('#fttabColor li input').unbind("click").click(function(){
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
	$('#fttabStyle li input').unbind("click").click(function(){
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
	$('#fttabAttribute li input').unbind("click").click(function(){
		setSearchFilterItem()
	});
	//배송 속성 확인/지정
	$('#fttabDelivery li input').unbind("click").click(function(){
		setSearchFilterItem()
	});
	//키워드 속성 Focus/Blur
	$("#fttabSearch input[name='skwd']").focus(function(){
		if($(this).val()=="키워드 검색") {
			$(this).val("");
		}
	});
	$("#fttabSearch input[name='skwd']").blur(function(){
		if($(this).val()=="") {
			$(this).val("키워드 검색");
		}
	});
	//키워드 속성 버튼
	$("#fttabSearch input[type='image']").unbind("click").click(function(){
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

	// 카테고리 선택 클릭(1dep)
 	$("#lyrCate input[name^='ctCd1']").unbind("click").click(function(){
 		var selCt = $(this).val().substr(0,3);
 		if($(this).prop("checked")) {
 			$("input[name^='ctCd2"+selCt+"']").prop("checked",true);
	 	} else {
	 		$("input[name^='ctCd2"+selCt+"']").prop("checked",false);
		}
		setDispCateArr()
 	});
	// 카테고리 선택 클릭(2dep)
 	$("#lyrCate input[name^='ctCd2']").unbind("click").click(function(){
		var selCt = $(this).val().substr(0,3);

		var chkCnt = $("input[name^='ctCd2"+selCt+"']:checked").length;
		var totCnt = $("input[name^='ctCd2"+selCt+"']").length;
		if(chkCnt==totCnt) {
			$("#cate"+selCt).prop("checked",true);
		} else {
			$("#cate"+selCt).prop("checked",false);
		}
		setDispCateArr()
 	});
	// 컬렉션 더보기 버튼 클릭
	$('.clctMoreBtn').unbind("click").click(function(){
		//더보기가 접힌 상태
		if ( $(this).attr("view")=="" ){
			$(this).addClass('clctMoreBtn clctClose');
			var collectionidx = $(this).attr("idx");
			$(".trcollectionMore"+eval(collectionidx)).show();
			$(this).attr("view","ON")
		//펼침 상태
		}else{
			$(this).addClass('clctMoreBtn');
			var collectionidx = $(this).attr("idx");
			$(".trcollectionMore"+eval(collectionidx)).hide();
			$(this).attr("view","")
		}
	});
	// 더보기 버튼 클릭
	$('.schMoreView').unbind("click").click(function(){
		$(this).toggleClass('folderOff');

		$(".trCateMore").toggle();
	});
	// 필터속성 검색실행 버튼
	$("#btnActFilter").unbind("click").click(function(){
		goshopsubmit('1')
		return false;
	});
	//로딩시 더보기 펼침 처리
	if($("#lyrCate .trCateMore .check:checked").length) {
		$(".trCateMore").show();
		$('.schMoreView').addClass('folderOff');
	}
	// 상품아이콘 크기 클릭
	$("#lySchIconSize li").unbind("click").click(function(e) {
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
		goshopsubmit('1')
	});
	
	//Product photo mouseover control
	$('.pdtPhoto').hover(function() {
		$(this).children('.pdtAction').toggle();
	});
	
	//페이징 1이후에 호출할경우 페이지 상단으로 강제로 땡겨 올림
	if (reloadyn=='Y'){
		document.getElementById('section05').scrollIntoView();
	}
	/////////////////SHOP/////////////////
}

//Interview 아작스 호출
function goInterviewView(gourl, downmySwipershow) {
	var strInterviewDtl = $.ajax({
			type: "GET",
	        url: gourl,
	        dataType: "text",
	        async: false
	}).responseText;
	$('#section02').empty().html(strInterviewDtl);

	/////////////////Interview/////////////////
	var mySwiper = new Swiper('.swiper1',{
		//pagination:'.pagination',
		pagination:false,
		loop:true,
		grabCursor:false,
		paginationClickable:true
	});

	$('.articleList .arrow-left').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});

	$('.articleList .arrow-right').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});

	//하단슬라이더에서 눌러서 호출할경우
	if (downmySwipershow=='Y'){
		$(".magazineList .mArticle").hide();
		$(".magazine").show();
		$("div[class='mArticle'][id='ma01']").show();
	}else{
		$(".magazine").hide();
	}

	$(".articleList .swiper-slide").unbind("click").click(function(){
		$(".magazineList .mArticle").hide();
		$(".magazine").show();
		$("div[class='mArticle'][id='"+'m'+$(this).attr("id")+"']").show();
	});
	/////////////////Interview/////////////////
}

//LOOK BOOK 룩업 아작스 호출
function golookbookView(gourl) {
	var strlookbookDtl = $.ajax({
			type: "GET",
	        url: gourl,
	        dataType: "text",
	        async: false
	}).responseText;
	$('#section06').empty().html(strlookbookDtl);

	/////////////////LOOK BOOK/////////////////
	var mySwiper3 = new Swiper('.swiper3',{
		pagination:false,
		loop:true,
		grabCursor:false,
		paginationClickable:true
	});
	//mySwiper3.reInit()
	/////////////////LOOK BOOK/////////////////
}

//앵커이동
function goToByScroll(id){
	//$('html,body').animate({scrollTop: $("#section"+id).offset().top-$(".brandIntro").outerHeight()+75},'slow');
	$('html,body').animate({scrollTop: $("#section"+id).offset().top},'slow');
}
//파라메타 타고 넘어 올경우 앵커이동
function goToByScrollparameter(id){
	//$('html,body').animate({scrollTop: $("#section"+id).offset().top-$(".brandIntro").outerHeight()+300},'slow');
	$('html,body').animate({scrollTop: $("#section"+id).offset().top},'slow');
}

//shop 필터 왼쪽 탭 클릭
function chgSFragTab(sfg) {
	document.sFrm.sflag.value=sfg;
	goshopsubmit('1')
}

//shop 선택된 필터 조합 표시
function setSearchFilterItem() {
	var sFtCont="", sCCd="", sSCd="", sACd="", iPmn="", iPmx="", sDlv="", sKwd="";
	// 컬러
	if($('#fttabColor li input:checked').length) {
		sFtCont += "<dl>"
		sFtCont += "<dt>컬러</dt>"
		$("#fttabColor li input:checked").each(function(){
			if(sCCd!="") sCCd += ",";
			sCCd += $(this).attr("value");
			sFtCont += '<dd value="col' + $(this).attr("value") + '">' + $(this).parent().find("label").text() + ' <img src="http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif" alt="Delete" class="deleteBtn" onclick="delFilterItem(this)" /></dd>'
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
		if(!($("#fttabSearch input[name='skwd']").val()==""||$("#fttabSearch input[name='skwd']").val()=="키워드 검색")) {
			sKwd = $("#fttabSearch input[name='skwd']").val();
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
	document.sFrm.rect.value=sKwd;

	//필터조합 넣기
	$('#lyrSearchFilter').html(sFtCont);

	//조합이 있으면 필터 레이어 출력
	if($('#lyrSearchFilter').has('dl').length) {
		$('.dFilterResult').show();
	} else {
		$('.dFilterResult').hide();
	}
}
//shop 선택된 필터 조합 삭제
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
		$("#fttabSearch input[name='skwd']").val("키워드 검색");
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
// 선택된 카테고리 폼값으로 저장
function setDispCateArr() {
	var arrCt="";
	$("#lyrCate input[name^='ctCd1']").each(function(){
		if($(this).prop("checked")) {
			// 1Depth가 선택되면 1Depth 코드만
			if(arrCt) {
				arrCt += "," + $(this).val();
			} else {
				arrCt = $(this).val();
			}
		} else {
			// 1Depth 없고 2Depth 선택된 코드 접수
			$("#lyrCate input[name^='ctCd2"+$(this).val().substr(0,3)+"']:checked").each(function(){
				if(arrCt) {
					arrCt += "," + $(this).val();
				} else {
					arrCt = $(this).val();
				}
			});
		}
	});
	document.sFrm.arrCate.value=arrCt;

	//검색필터조건 리셋
	document.sFrm.iccd.value="0";
	document.sFrm.styleCd.value="";
	document.sFrm.attribCd.value="";
	document.sFrm.minPrc.value="";
	document.sFrm.maxPrc.value="";
	document.sFrm.deliType.value="";
	
	goshopsubmit('1')
}
