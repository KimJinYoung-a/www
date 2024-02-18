	// 간이 장바구니에 넣기
	$(document).ready(function () {
		// 옵션(멀티옵션 포함) 담기
		$('.itemoption select[name="item_option"]').change(function() {
			var optCnt = $('.itemoption select[name="item_option"]').length;
			var optSel = 0;
			var itemid = $('input[name="itemid"]').val();
			var itemPrc = $('input[name="itemPrice"]').val()*1;
			var itemCnt = $('input[name="itemea"]').val()*1;
			var optAddPrc = 0;
			var optCd = [];

			// 포토북일경우는 간이바구니 사용안함
			if($('input[name="isPhotobook"]').val()=="True") return;
			// Present상품일경우는 간이바구니 사용안함
			if($('input[name="isPresentItem"]').val()=="True") return;
			// 스페셜 항공권 상품일경우는 간이바구니 사용안함
			if($('input[name="IsSpcTravelItem"]').val()=="True") return;

			$('.itemoption select[name="item_option"] option:selected').each(function () {
				optCd[optSel] = $(this).val();
				var opSelCd = optCd[optSel];
				var opSelNm = $(this).text();
				var optMSel = -1;
				var opSoldout = false;
				var opLimit	= 500;

				if(optCd[optSel]!=""&&optCd[optSel]!="0000") optSel++;

				//옵션이 모두 선택 됐을 때 간이바구니에 넣는다
				if(optSel==optCnt) {
					if(optCnt>1) {
						// 이중옵션일 때 내용 접수
						for(i=0;i<Mopt_Code.length;i++){
							if(optCnt==2) {
								if(Mopt_Code[i].substr(1,1)==optCd[0].substr(1,1)&&Mopt_Code[i].substr(2,1)==optCd[1].substr(1,1)) {
									optMSel = i;
								}
							} else if(optCnt==3) {
								if(Mopt_Code[i].substr(1,1)==optCd[0].substr(1,1)&&Mopt_Code[i].substr(2,1)==optCd[1].substr(1,1)&&Mopt_Code[i].substr(3,1)==optCd[2].substr(1,1)) {
									optMSel = i;
								}
							}
						}
						if(optMSel>=0) {
							opSelCd = Mopt_Code[optMSel];
							opSelNm = Mopt_Name[optMSel];
							optAddPrc = Mopt_addprice[optMSel]*1;
							if(optAddPrc>0) opSelNm+="("+plusComma(optAddPrc)+"원 추가)";
							if(Mopt_LimitEa[optMSel]>0) opLimit = parseInt(Mopt_LimitEa[optMSel]);

							if(Mopt_S[optMSel]) opSoldout=true;
						} else {
							opSoldout = true;
						}
					} else {
						// 단일옵션일 때
						optAddPrc = $(this).attr("addPrice")*1;
						if(!optAddPrc) optAddPrc=0;
						if($(this).attr("limitEa")>0) opLimit=parseInt($(this).attr("limitEa"));
						if($(this).attr("soldout")=="Y") opSoldout = true;
					}

					// 본상품 제한수량 계산
					if($("#itemRamainLimit").val()>0) {
						if($("#itemRamainLimit").val()<opLimit) opLimit=parseInt($("#itemRamainLimit").val());
					}

					opSelNm = opSelNm.replace(/\(한정.*?\)/g,''); //한정구문 제거

					//품절처리
					if(opSoldout) {
						alert("품절된 옵션은 선택하실 수 없습니다.");
						return;
					}

					// 옵션이 없으면 추가하지 않음
					if(opSelCd==""||opSelCd=="0000")  return;

					// 중복 옵션 처리
					var chkDpl = false;
					$("#lySpBagList").find("tr").each(function () {
						if($(this).find("[name='optItemid']").val()==itemid&&$(this).find("[name='optCd']").val()==opSelCd) {
							chkDpl=true;
						}
					});
					if(chkDpl) return;


					// 간이 장바구니 내용 작성
					var sAddItem='';
					sAddItem += '<tr>';
					sAddItem += '	<td class="lt">' + opSelNm;

					if($(".saleInfo").has("#requiredetail").length) {
						sAddItem += '<p class="tPad05"><textarea name="optRequire" style="width:215px; height:35px;"></textarea></p>';
					} else {
						sAddItem += '<input type="hidden" name="optRequire" value="" />';
					}

					sAddItem += '<input type="hidden" name="optItemid" value="'+ (itemid) +'" />';
					sAddItem += '<input type="hidden" name="optCd" value="'+ opSelCd +'" />';
					sAddItem += '<input type="hidden" name="optItemPrc" value="'+ (itemPrc+optAddPrc) +'" />';
					sAddItem += '</td>';
					sAddItem += '	<td><input type="text" id="optItemEa" /></td>';
					sAddItem += '	<td class="rt rPad05">' + plusComma((itemPrc+optAddPrc)*itemCnt) + '</td>';
					sAddItem += '	<td><a href="" class="del"><span class="btnListDel">삭제</span></a></td>';
					sAddItem += '</tr>';


					// 간이바구니에 추가
					$("#lySpBagList").prepend(sAddItem);

					// 스피너 변환
					$("#optItemEa").numSpinner({min:1,max:opLimit,step:1,value:itemCnt});

					// 간이바구니표시
					if($("#lySpBagList").find("tr").length>0) {

						// 개별삭제
						$('#lySpBagList .del').css('cursor', 'pointer');
						$('#lySpBagList .del').unbind("click");
						$('#lySpBagList .del').click(function(e) {
							e.preventDefault();
							var di = $(this).closest("tr").index();
							$("#lySpBagList").find("tr").eq(di).remove();

							//간이바구니 정리
							if($("#lySpBagList").find("tr").length<=0) {
								$("#lySpBag").hide();
							} else {
								$("#lySpBagList").find("tr").first().addClass("start");
							}

							// 중간 메뉴위치 재지정
							resetPrdTabLinkPostion();

							// 총금액 합계 계산
							FnSpCalcTotalPrice();
						});

						// 간이 바구니 주문수량 변경
						$('#lySpBag input[name="optItemEa"]').keyup(function() {
							FnSpCalcTotalPrice();
						});

						// 간이 바구니 스피너 액션
						$('#lySpBagList .spinner .buttons').click(function() {
							FnSpCalcTotalPrice();
						});

						// 총금액 합계 계산
						FnSpCalcTotalPrice();
						$("#lySpBag").show();

						// 선택창 옵션 초기화
						$('.itemoption select[name="item_option"]').val("");

						// 중간 메뉴위치 재지정
						resetPrdTabLinkPostion();
					} else {
						$("#lySpBag").hide();

						// 중간 메뉴위치 재지정
						resetPrdTabLinkPostion();
					}
				}
			});
		});
	});

	//총 합계금액 계산
	function FnSpCalcTotalPrice() {
		var isSpOpt = ($("#lySpBagList tr").length-$("#lySpBagList .plusPdtOrder").length)>0	// 간이바구니 옵션여부
		var isSpPls = $("#lySpBagList .plusPdtOrder").length>0									// 간이바구니 플러스여부

		// 총금액 합계 계산
		var spTotalPrc = 0;
		$("#lySpBagList").find("tr").each(function () {
			spTotalPrc = spTotalPrc + ($(this).find("[name='optItemPrc']").val()*$(this).find("[name='optItemEa']").val());
			$(this).find(".optPrc").html(plusComma($(this).find("[name='optItemPrc']").val()*$(this).find("[name='optItemEa']").val()));
		});
		if(!isSpOpt&&isSpPls) {
			//옵션은 없는데 플러스할인만 있으면 상품원가 추가
			spTotalPrc = spTotalPrc + ($('input[name="itemPrice"]').val()*$('input[name="itemea"]').val());

			// 상품 바구니 스피너 액션
			$('#lyItemEa .spinner .buttons').unbind("click");
			$('#lyItemEa .spinner .buttons').click(function() {
				FnSpCalcTotalPrice();
			});
		} else {
			$('#lyItemEa .spinner .buttons').unbind("click");
		}
		$("#spTotalPrc").html(plusComma(spTotalPrc)+"원");
	}

	//간이바구니 -> 장바구니
	function FnAddShoppingBag(bool) {
	    var frm = document.sbagfrm;
	    var aFrm = document.BagArrFrm;
	    var optCode = "0000";
		var itemarr="";

		var isOpt = $('.itemoption').length>0		// 옵션	여부
		var isPls = $('.plusSaleBoxV15').length>0			// 플러스할인 여부
		var isSpOpt = ($("#lySpBagList tr").length-$("#lySpBagList .plusPdtOrder").length)>0	// 간이바구니 옵션여부
		var isSpPls = $("#lySpBagList .plusPdtOrder").length>0									// 간이바구니 플러스여부
		var sAddBagArr = "";

		if(!isOpt) {
			//일반 상품 검사
		    frm.itemoption.value = optCode;

		    for (var j=0; j < frm.itemea.value.length; j++){
		        if (((frm.itemea.value.charAt(j) * 0 == 0) == false)||(frm.itemea.value==0)){
		    		alert('수량은 숫자만 가능합니다.');
		    		frm.itemea.focus();
		    		return;
		    	}
		    }

		    if (frm.requiredetail){
				if (frm.requiredetail.value.length<1){
					alert('주문 제작 상품 문구를 작성해 주세요.');
					frm.requiredetail.focus();
					return;
				}

				if(GetByteLength(frm.requiredetail.value)>255){
					alert('문구 입력은 한글 최대 120자 까지 가능합니다.');
					frm.requiredetail.focus();
					return;
				}
				// 꺽은괄호 치환
				frm.requiredetail.value = frm.requiredetail.value.replace(/</g,"＜").replace(/>/g,"＞");
			}
		}

		// 간이바구니 사용 상품 검사
		if(isOpt&&!isSpOpt) {
			alert('상품 옵션을 선택해주세요.');
			return;
		}

		// 간이바구니 제작문구 검사
		if(isSpOpt||isSpPls) {
			var chkRq = true;
			$("#lySpBagList").find("tr").each(function () {
				if($(this).has("textarea[name='optRequire']").length) {
					if ($(this).find("textarea[name='optRequire']").val().length<1){
						alert('주문 제작 상품 문구를 작성해 주세요.');
						$(this).find("textarea[name='optRequire']").focus();
						chkRq = false;
						return false;
					}
	
					if(GetByteLength($(this).find("textarea[name='optRequire']").val())>255){
						alert('문구 입력은 한글 최대 120자 까지 가능합니다.');
						frm.requiredetail.focus();
						chkRq = false;
						return false;
					}
				}
			});
			if(!chkRq) return;
		}

		// 간이바구니 변환
		if(isSpOpt||isSpPls) {
			$("#lySpBagList").find("tr").each(function () {
				sAddBagArr += $(this).find("[name='optItemid']").val() + ",";
				sAddBagArr += $(this).find("[name='optCd']").val() + ",";
				sAddBagArr += $(this).find("[name='optItemEa']").val() + ",";
				sAddBagArr += $(this).find("[name='optRequire']").val().replace(/</g,"＜").replace(/>/g,"＞").replace(/,/g,"，") + "|";
				itemarr += $(this).find("[name='optItemid']").val() + ",";
			});
		}

		// 일반상품이면서 플러스 상품일때는 기본값 추가
		if(!isOpt&&isPls) {
			sAddBagArr += frm.itemid.value + "," + frm.itemoption.value + "," + frm.itemea.value;
			if(frm.requiredetail) {
				sAddBagArr += "," + frm.requiredetail.value + "|";
			} else {
				sAddBagArr +=",|"
			}
		}



		if (bool==true){
			// AJAX로 처리
			var vTrData;
			fnAmplitudeEventAction('click_shoppingbag_in_deal','itemid',itemarr);
			if(sAddBagArr=="") {
				vTrData = "mode=add";
				vTrData += "&itemid=" + frm.itemid.value;
				vTrData += "&sitename=" + frm.sitename.value;
				vTrData += "&itemoption=" + frm.itemoption.value;
				vTrData += "&itemPrice=" + frm.itemPrice.value;
				vTrData += "&isPhotobook=" + frm.isPhotobook.value;
				vTrData += "&isPresentItem=" + frm.isPresentItem.value;
				vTrData += "&itemea=" + frm.itemea.value;
				if(frm.requiredetail) {
					vTrData += "&requiredetail=" + encodeURIComponent(frm.requiredetail.value);
				}
			} else {
				vTrData = "mode=arr";
	    	    vTrData += "&bagarr=" + encodeURIComponent(sAddBagArr);
			}

			$.ajax({
				type: "POST",
				url: "/inipay/shoppingbag_process.asp?tp=ajax",
				data:vTrData,
				success: function(message) {
					switch(message.split("||")[0]) {
						case "0":
							alert("유효하지 않은 상품이거나 품절된 상품입니다.");
							break;
						case "1":
							fnDelCartAll();
							$("#alertMsgV15").html("선택하신 상품을<br />장바구니에 담았습니다.");
							$(".alertLyrV15").fadeIn('fast').delay(3000).fadeOut();
							$("#ibgaCNT").html(message.split("||")[1]);
							break;
						case "2":
							$("#alertMsgV15").html("장바구니에 이미<br />같은 상품이 있습니다.");
							$(".alertLyrV15").fadeIn('fast').delay(3000).fadeOut();
							break;
						default:
							alert("죄송합니다. 오류가 발생했습니다."+message);
							break;
					}
				}
			});
		}else{
			fnAmplitudeEventAction('click_directorder_in_deal','itemid',itemarr);
			//즉시 구매하기
			if(sAddBagArr=="") {
				frm.mode.value = "DO1";
				frm.target = "_self";
				frm.action="/inipay/shoppingbag_process.asp";
				frm.submit();
			} else {
	    	    aFrm.mode.value = "DO2";
	    	    aFrm.target = "_self";
		        aFrm.bagarr.value = sAddBagArr;
		        aFrm.action = "/inipay/shoppingbag_process.asp";
		        aFrm.submit();
			}
		}

		// 장바구니 facebook 픽셀 스크립트 추가
		if (typeof fbq == 'function') { 
			fbq('track', 'AddToCart',{content_ids:'['+frm.itemid.value+']',content_type:'product'});
		}
	}


    //파라미터 : 제품 코드와 템플릿 코드
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
    	var winspec = "width="+ ws + ",height="+ hs +",top=10,left=10, menubar=no,toolbar=no,scroolbars=yes,resizable=yes";
    	var popwin = window.open("/shopping/fuji/photolooks.asp?itemid="+ itemid +"&itemoption="+ optCode +"&itemea="+frm.itemea.value, "photolooks"+itemid, winspec)
    	popwin.focus();
    }

	function plusComma(num){
    	if (num < 0) { num *= -1; var minus = true}
    	else var minus = false

    	var dotPos = (num+"").split(".")
    	var dotU = dotPos[0]
    	var dotD = dotPos[1]
    	var commaFlag = dotU.length%3

    	if(commaFlag) {
    		var out = dotU.substring(0, commaFlag)
    		if (dotU.length > 3) out += ","
    	}
    	else var out = ""

    	for (var i=commaFlag; i < dotU.length; i+=3) {
    		out += dotU.substring(i, i+3)
    		if( i < dotU.length-3) out += ","
    	}

    	if(minus) out = "-" + out
    	if(dotD) return out + "." + dotD
    	else return out
    }

    function jsQNACheck(v){
    	if(v=="e") {
	    	if($("#qnaEmail").is(":checked") == true){
	    		$("#emailok").val("Y");
	    	}else if($("#qnaEmail").is(":checked") == false){
	    		$("#emailok").val("N");
	    	}
    	}else if(v=="s") {
	    	if($("#qnaSecret").is(":checked") == true){
	    		$("#secretyn").val("Y");
	    	}else if($("#qnaSecret").is(":checked") == false){
	    		$("#secretyn").val("N");
	    	}    		
	    } else {
	    	if($("#qnaHp").is(":checked") == true){
	    		$("#smsok").val("Y");
	    	}else if($("#qnaHp").is(":checked") == false){
	    		$("#smsok").val("N");
	    	}
		}
    }

	function resetPrdTabLinkPostion() {
		// 상품 중간 메뉴 탭 위치 재지정
		menuTop = $("#lyrPrdTabLink").offset().top;
	}
