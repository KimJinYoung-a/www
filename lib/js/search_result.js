// JQuery 사용자 함수 선언
(function($){
    // 텍스트박스 포커스 이동
    $.fn.setCursorToTextEnd = function(pos) {
	    this.each(function (index, elem) {
	        if (elem.setSelectionRange) {
	            elem.setSelectionRange(pos, pos);
	        } else if (elem.createTextRange) {
	            var range = elem.createTextRange();
	            range.collapse(true);
	            range.moveEnd('character', pos);
	            range.moveStart('character', pos);
	            range.select();
	        }
	    });
    };
})(jQuery);

function jsGoPage(iP){
	document.sFrm.cpg.value = iP;
	document.sFrm.submit();
}

function fnSearch(frmnm,frmval,tgd){
	frmnm.value = frmval;
	
	var frm = document.sFrm;
	
	frm.cpg.value=1;
	if (frm.rect.value.length<=0){
		alert('검색어를 입력해 주세요');
		return;
	}

	if (frm.chke.value=='true') {
		if(frm.rect.value==frm.rstxt.value) {
			alert("검색어와 제외어가 동일합니다.")
			return;
		}
		frm.extxt.value=frm.rect.value;
		frm.rect.value=frm.rstxt.value;
	} else {
		frm.extxt.value="";
	}


	if ((frm.rect.defaultValue!=frm.rect.value)||(tgd=="re")){
		//frm.chkr.value=false;
		frm.dispCate.value='';
		frm.arrCate.value='';
		frm.sflag.value='';
		frm.mkr.value='';
		frm.minPrc.value='';
		frm.maxPrc.value='';
		frm.iccd.value='';
		frm.deliType.value='';
		frm.styleCd.value='';
		frm.attribCd.value='';
	}

	frm.submit();
	
}

function fnSearchCat(dispCd){
	var frm = document.sFrm;
	
	frm.cpg.value=1;
	frm.dispCate.value=dispCd;
	frm.mkr.value='';	// 카테고리 검색시 브랜드/색상/가격/배송구분 초기화
	frm.iccd.value='';
	frm.deliType.value='';
	frm.styleCd.value='';
	frm.attribCd.value='';

	if (frm.chke.value=='true') {
		if(frm.rect.value==frm.rstxt.value) {
			alert("검색어와 제외어가 동일합니다.")
			return;
		}
		frm.extxt.value=frm.rect.value;
		frm.rect.value=frm.rstxt.value;
	} else {
		frm.extxt.value="";
	}

	frm.submit();
	
}

function fnSearchBrd(mkVl) {
	var frm = document.sFrm;
	frm.mkr.value = mkVl;
	frm.cpg.value = 1;
	frm.dispCate.value=''; 	//브랜드 검색시 카테고리/색상/가격/배송구분 초기화
	frm.iccd.value='';
	frm.deliType.value='';
	frm.styleCd.value='';
	frm.attribCd.value='';

	if (frm.chke.value=='true') {
		if(frm.rect.value==frm.rstxt.value) {
			alert("검색어와 제외어가 동일합니다.")
			return;
		}
		frm.extxt.value=frm.rect.value;
		frm.rect.value=frm.rstxt.value;
	} else {
		frm.extxt.value="";
	}

	frm.submit();
}


function fnResearchChk(obj){
	var bo = $(obj).parent().hasClass("checked");
	document.sFrm.chke.value=false;
	document.sFrm.chkr.value=(!bo);

	$(".searchingV15 .searchOptionV15 li").removeClass("checked");
	if(!bo) {
		$(obj).parent().addClass("checked");
		$("input[name='sMtxt']").val("");
		$('.searchWordV15 input[name="sMtxt"]').setCursorToTextEnd(50);
	} else {
		$("input[name='sMtxt']").val($("#viewSTxt").text());
	}
}
function fnExceptChk(obj){
	var bo = $(obj).parent().hasClass("checked");
	document.sFrm.chkr.value=false;
	document.sFrm.chke.value=(!bo);

	$(".searchingV15 .searchOptionV15 li").removeClass("checked");
	if(!bo) {
		$(obj).parent().addClass("checked");
		$("input[name='extxt']").val("");
		$("input[name='sMtxt']").val("");
		$('.searchWordV15 input[name="sMtxt"]').setCursorToTextEnd(50);
	} else {
		$("input[name='sMtxt']").val($("#viewSTxt").text());
	}
}

// 숫자입력 확인
function chkDigit(fv) {
	if(fv.value!="") {
		if(!IsDigit(fv.value)) {
			alert("숫자만 입력이 가능합니다.");
			fv.value = fv.value.substr(0,(fv.value.length-1));
		}
	}
}

// 선택된 카테고리 폼값으로 저장
function setDispCateArr(rt) {
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

	if(rt!="R") swBtnDelTerm();
}

// 선택된 브랜드ID 폼값으로 저장
function setMakerIdArr(rt) {
	var arrMk="";
	$("#lyrBrand input[name='mkrid']").each(function(){
		if($(this).prop("checked")) {
			if(arrMk) {
				arrMk += "," + $(this).val();
			} else {
				arrMk = $(this).val();
			}
		}
	});
	document.sFrm.mkr.value=arrMk;

	if(rt!="R") swBtnDelTerm();
}

// 조건 해제버튼 On/Off
function swBtnDelTerm() {
	if(document.sFrm.arrCate.value!=""||document.sFrm.mkr.value!="") {
		$("#btnDelTerm").fadeIn('fast');
	} else {
		$("#btnDelTerm").fadeOut('fast');
	}
	
}


//후지FDI 포토북 편집 :: 파라미터 : 제품 코드와 템플릿 코드
function loadPhotolooks(itemid){
    var frm = document.sbagfrm;
    var optCode = "0000";

    if (!frm.item_option){
        //옵션 없는경우

    }else if (!frm.item_option[0].length){
        //단일 옵션
        if (frm.item_option.value.length<1){
            alert('옵션을 선택 하세요.');
            frm.item_option.focus();
            return;
        }

        if (frm.item_option.options[frm.item_option.selectedIndex].id=="S"){
            alert('품절된 옵션은 구매하실 수 없습니다.');
            frm.item_option.focus();
            return;
        }

        optCode = frm.item_option.value;
    }else{
        //이중 옵션 경우

        for (var i=0;i<frm.item_option.length;i++){
            if (frm.item_option[i].value.length<1){
                alert('옵션을 선택 하세요.');
                frm.item_option[i].focus();
                return;
            }

            if (frm.item_option[i].options[frm.item_option[i].selectedIndex].id=="S"){
                alert('품절된 옵션은 구매하실 수 없습니다.');
                frm.item_option[i].focus();
                return;
            }

            if (i==0){
                optCode = MOptPreFixCode + frm.item_option[i].value.substr(1,1);
            }else if (i==1){
                optCode = optCode + frm.item_option[i].value.substr(1,1);
            }else if (i==2){
                optCode = optCode + frm.item_option[i].value.substr(1,1);
            }
        }

        if (optCode.length==2){
            optCode = optCode + "00";
        }

        if (optCode.length==3){
            optCode = optCode + "0";
        }
    }
    
    for (var j=0; j < frm.itemea.value.length; j++){
        if (((frm.itemea.value.charAt(j) * 0 == 0) == false)||(frm.itemea.value==0)){
    		alert('수량은 숫자만 가능합니다.');
    		frm.itemea.focus();
    		return;
    	}
    }

	var ws = screen.width * 0.8;
	var hs = screen.height * 0.8;
	var winspec = "width="+ ws + ",height="+ hs +",top=10,left=10, menubar=no,toolbar=no,scroolbars=no,resizable=yes";
	var popwin = window.open("/shopping/fuji/photolooks.asp?itemid="+ itemid +"&itemoption="+ optCode +"&itemea="+frm.itemea.value, "photolooks", winspec)
	popwin.focus();
}

function delMyKeyword(kwd,mod) {
	if(mod!="da") {mod="del";}
	//내 검색어 선택 삭제
	$.ajax({
		url: "act_mySearchKeyword.asp?mode="+mod+"&kwd="+kwd,
		cache: false,
		async: false,
		success: function(message) {
			if(message!="") {
				$("#lyrMyKeyword").empty().html(message);	
		    } else {
		    	$("#lyrMyKeyword").empty().parent().hide();
		    }
		}
		,error: function(err) {
			alert(err.responseText);
		}
	});
}


////////////////////////////////////////////////////////
// 액션들
////////////////////////////////////////////////////////
 $("document").ready(function(){
	//로딩시 더보기 펼침 처리
	if($("#lyrCate .trCateMore .check:checked").length) {
		$(".trCateMore").show();
		$('.schMoreViewV15').addClass('folderOffV15');
	}
	if($("#lyrBrand .trBrandMore .check:checked").length) {
		$(".trBrandMore").show();
		$('.schBrandView').addClass('folderOffV15');
	}
 	// 로딩시 카테고리 선택 처리 
 	$("#lyrCate input[name^='ctCd1']").each(function(){
 		var selCt = $(this).val().substr(0,3);
 		if($(this).prop("checked")) {
 			$("input[name^='ctCd2"+selCt+"']").prop("checked",true);
		}
 	});


	// 카테고리 선택 클릭(1dep)
 	$("#lyrCate input[name^='ctCd1']").click(function(){
 		var selCt = $(this).val().substr(0,3);
 		if($(this).prop("checked")) {
 			$("input[name^='ctCd2"+selCt+"']").prop("checked",true);
	 	} else {
	 		$("input[name^='ctCd2"+selCt+"']").prop("checked",false);
		}
		setDispCateArr()
 	});
	// 카테고리 선택 클릭(2dep)
 	$("#lyrCate input[name^='ctCd2']").click(function(){
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

	// 카테고리 링크 클릭(1/2dep)
 	$("#lyrCate input[name^='ctCd1'],input[name^='ctCd2']").next().click(function(e){
 		e.preventDefault();

		document.sFrm.arrCate.value=$(this).prev().val();
		document.sFrm.cpg.value=1;
		document.sFrm.iccd.value="0";
		document.sFrm.styleCd.value="";
		document.sFrm.attribCd.value="";
		document.sFrm.minPrc.value="";
		document.sFrm.maxPrc.value="";
		document.sFrm.deliType.value="";
		document.sFrm.submit();
 	});

	// 카테고리 링크 클릭(3dep)
 	$("#lyrCate .depthWrapV15 .depth a").click(function(e){
 		e.preventDefault();

		document.sFrm.arrCate.value=$(this).attr("selcd3");
		document.sFrm.cpg.value=1;
		document.sFrm.iccd.value="0";
		document.sFrm.styleCd.value="";
		document.sFrm.attribCd.value="";
		document.sFrm.minPrc.value="";
		document.sFrm.maxPrc.value="";
		document.sFrm.deliType.value="";
		document.sFrm.submit();
 	});


	// 브랜드 선택 클릭
 	$("#lyrBrand input[name='mkrid']").click(function(){
		setMakerIdArr()
 	});

	// 브랜드 링크 클릭
 	$("#lyrBrand input[name='mkrid']").next().click(function(e){
 		e.preventDefault();

		document.sFrm.mkr.value=$(this).prev().val();
		document.sFrm.cpg.value=1;
		document.sFrm.iccd.value="0";
		document.sFrm.styleCd.value="";
		document.sFrm.attribCd.value="";
		document.sFrm.minPrc.value="";
		document.sFrm.maxPrc.value="";
		document.sFrm.deliType.value="";
		document.sFrm.submit();
 	});

	// 검색버튼 클릭
	$("#btnMainSearch").click(function(){
		fnSearch(document.sFrm.rect,$("input[name='sMtxt']").val(),"re");
	});

	// 검색메인탭 클릭
	$('.schTabV15 li').click(function(){
		$('.schTabV15 li').removeClass('current');
		$(this).addClass('current');
		$(".lyrTabV15").hide();
		$("#lyr"+$(this).attr("name")).show();

		switch($(this).attr("name")) {
			case "Cate":
				$("#lyrJoinSearch").show();
				$("#lyrBrand .check").prop("checked",false);
				setMakerIdArr();
				break;
			case "Brand":
				$("#lyrJoinSearch").show();
				$("#lyrCate .check").prop("checked",false);
				setDispCateArr();
				break;
			case "Play":
				$("#lyrJoinSearch").hide();
				$(".playContListV15").masonry({
					itemSelector: '.box'
				});
				break;
			default:
				$("#lyrJoinSearch").hide();
		}
	});

	// 더보기 버튼 클릭
	$('.schMoreViewV15').click(function(){
		$(this).toggleClass('folderOffV15');

		//스크롤 위치 이동
		if(!$(this).hasClass('folderOffV15')) {
			$('html, body').animate({scrollTop: $("#lyrSchExpTab").offset().top-20}, 100)
		}

		//카테고리 더보기
		if($(this).hasClass("btnMoreCate")) {
			$(".trCateMore").toggle();
		}

		//브랜드 더보기
		if($(this).hasClass("btnMoreBrand")) {
			$(".trBrandMore").toggle();
		}

		//이벤트 더보기
		if($(this).hasClass("btnMoreEvent")) {
			$(".trEventMore").toggle();
		}
	});

	// 선택조건 해제 버튼
	$("#btnDelTerm").click(function(){
		$("#lyrCate .check").prop("checked",false);
		$("#lyrBrand .check").prop("checked",false);
		setDispCateArr();
		setMakerIdArr();

		document.sFrm.cpg.value=1;
		//검색필터조건 리셋
		document.sFrm.iccd.value="0";
		document.sFrm.styleCd.value="";
		document.sFrm.attribCd.value="";
		document.sFrm.minPrc.value="";
		document.sFrm.maxPrc.value="";
		document.sFrm.deliType.value="";
		document.sFrm.submit();
		return false;
	});
	// 선택조건 검색실행 버튼
	$("#btnActTerm").click(function(){
		if(document.sFrm.arrCate.value=="" && document.sFrm.mkr.value=="") {
			alert("조건을 선택해주세요.");
			return false;
		}

		document.sFrm.cpg.value=1;
		//검색필터조건 리셋
		document.sFrm.iccd.value="0";
		document.sFrm.styleCd.value="";
		document.sFrm.attribCd.value="";
		document.sFrm.minPrc.value="";
		document.sFrm.maxPrc.value="";
		document.sFrm.deliType.value="";
		document.sFrm.submit();
		return false;
	});

	// searchword rolling
	var mySwiper = new Swiper('.swiper-container',{
		pagination:false,
		paginationClickable:false,
		mode: 'vertical',
		autoplay:3400,
		loop:true,
		noSwiping:true
	})

	$('.swiper-slide').css('width', '100px');
	$('.realTRankV15').mouseover(function(){
		mySwiper.stopAutoplay();
		$(this).children('dl').addClass('realTWordViewV15');
		$(this).children('dl').removeClass('realTWordRollingV15');
		$(this).children('dl').find('ul').css('height', 'auto');
		$('.realTWordViewV15 .realTListV15 li:first').hide();
		$('.realTWordViewV15 .realTListV15 li:last').hide();
		$('.realTWordViewV15 .swiper-slide').css('width', '118px');
	});

	$('.realTRankV15').mouseout(function(){
		$(this).children('dl').addClass('realTWordRollingV15');
		$(this).children('dl').removeClass('realTWordViewV15');
		$('.realTWordRollingV15 .realTListV15 li:first').show();
		$('.realTWordRollingV15 .realTListV15 li:last').show();
		$('.swiper-slide').css('width', '100px');
		mySwiper.startAutoplay();
	});

	// search Area Event (2015.06)
	$('.searchV15 .searchWordV15').click(function(){
		$(this).parent().parent().hide();
		$('.searchingV15').show();
		$('#dimed').show();
		$('.searchWordV15 input[name="sMtxt"]').setCursorToTextEnd(50);
	});

	$('#dimed').click(function(){
		$('.searchV15').show();
		$('.searchingV15').hide();
		$('#dimed').hide();
	});
});
