// 파일 내용확인
function fnCheckPreUpload() {
	if($("#fileupload").val()!="") {
		$("#fileupmode").val("preImg");
		if(parseInt(getIEVersion())<8 && getIEVersion()!="N/A")  $("#fileMtd").val("direct");

		$('#ajaxform').ajaxSubmit({
			//보내기전 validation check가 필요할경우
			beforeSubmit: function (data, frm, opt) {
				if(!(/\.(jpg|jpeg|png)$/i).test(frm[0].UsrPhoto.value)) {
					alert("JPG,PNG 이미지파일만 업로드 하실 수 있습니다.");
					$("#fileupload").val("");
					return false;
				}
				$("#lyrPrgs").show();
			},
			//submit이후의 처리
			success: function(responseText, statusText){
				if(responseText.substr(0,3)=="ERR") {
					alert(responseText.substr(4,responseText.length));
				} else if(responseText.substr(0,2)=="OK") {
					$("#filePreImg").val(responseText.substr(3,responseText.length));
					if(parseInt(getIEVersion())>=8 || getIEVersion()=="N/A") {
						fnOpenModal("popCropbox.asp?fnm="+$("#filePreImg").val());
					} else {
						$("#UsrImg").attr("src",vImgDomain+"/giftcard/temp/"+$("#filePreImg").val()+"?"+Math.floor(Math.random()*1000));
						$("#lyrUsrImg").fadeIn("fast");
					}
				} else {
					alert("처리중 오류가 발생했습니다.\n" + responseText);
				}
				$("#fileupload").val("");
				$("#lyrPrgs").hide();
			},
			//ajax error
			error: function(err){
				alert("ERR: " + err.responseText);
				//alert("처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
				$("#fileupload").val("");
				$("#lyrPrgs").hide();
			}
		});
	}
}

// 크롭 처리
function fnCheckCropProc() {
	$("#fileupmode").val("cropImg");
	$('#ajaxform').ajaxSubmit({
		beforeSubmit: function (data, frm, opt) {
			if(!frm[0].preimg.value) {
				alert("작업할 파일이 없습니다. 먼저 사진등록을 해주세요.");
				return false;
			}
		},
		success: function(responseText, statusText){
			if(responseText.substr(0,3)=="ERR") {
				alert(responseText.substr(4,responseText.length));
			} else if(responseText.substr(0,2)=="OK") {
				//크롭 완료 > 모달닫고 사진카드 표시
				ClosePopLayer();
				$("#UsrImg").attr("src",vImgDomain+"/giftcard/temp/"+$("#filePreImg").val()+"?v="+Math.floor(Math.random()*1000));
				$("#lyrUsrImg").fadeIn("fast");
			} else {
				alert("처리중 오류가 발생했습니다.\n" + responseText);
			}
		},
		error: function(err){
			alert("ERR: " + err.responseText);
			//alert("처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
		}
	});
}

// 사용자 이미지 삭제
function fnDelUsrImg() {
	if(confirm("편집된 이미지를 삭제하시겠습니까?")) {
		$("#fileupmode").val("depImg");
		$('#ajaxform').ajaxSubmit({
			beforeSubmit: function (data, frm, opt) {
				if(!frm[0].preimg.value) {
					alert("작업할 파일이 없습니다. 먼저 사진등록을 해주세요.");
					return false;
				}
			},
			success: function(responseText, statusText){
				if(responseText.substr(0,3)=="ERR") {
					alert(responseText.substr(4,responseText.length));
				} else if(responseText.substr(0,2)=="OK") {
					$('#lyrUsrImg').fadeOut('fast', function(){
						$("#UsrImg").attr("src","");
						$("#filePreImg").val("");
					});
				} else {
					alert("처리중 오류가 발생했습니다.\n" + responseText);
				}
			},
			error: function(err){
				alert("ERR: " + err.responseText);
				//alert("처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
			}
		});
	}
}

function getIEVersion() {
	var word;
	var version = "N/A";

	var agent = navigator.userAgent.toLowerCase();
	var name = navigator.appName;

	// IE old version ( IE 10 or Lower )
	if ( name == "Microsoft Internet Explorer" ) word = "msie ";
	else {
		// IE 11
		if ( agent.search("trident") > -1 ) word = "trident/.*rv:";
		// IE Compatibility View
		if ( agent.search("msie") > -1 ) word = "msie ";
		// IE 12  ( Microsoft Edge )
		else if ( agent.search("edge/") > -1 ) word = "edge/";
	}

	var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" );
	if (  reg.exec( agent ) != null  ) version = RegExp.$1 + RegExp.$2;

	return version;
}

// 금액권 선택
function fnChgOption(obj) {
	document.frmorder.price.value=$(obj).find("option:selected").attr("price");
	document.frmorder.cardPrice.value=$(obj).find("option:selected").attr("price");
}

//입력폼 검사
function CheckForm(frmO,frmP){
	// 금액권 재확인
	frmP.price.value=$("#cardopt option:selected").attr("price");
	frmO.cardPrice.value=$("#cardopt option:selected").attr("price");

	// 카드디자인
	if(frmO.designid.value=="") {
		alert('기프트카드 디자인을 선택해주세요.');
		$('html, body').animate({scrollTop:$("#lyrSelDesign").offset().top-20}, 'fast');
		return false;
	}

	if(frmO.designid.value=="900") {
		if($("#filePreImg").val()=="") {
			alert('보내실 사진을 등록해주세요.');
			$('html, body').animate({scrollTop:$("#lyrSelPhoto").offset().top-20}, 'fast');
			return false;
		} else {
			frmO.userImg.value=$("#filePreImg").val();
		}
	}

	if(!frmO.MMSContent.value||frmO.MMSContent.value=="기프트카드와 함께 보낼 따뜻한 메시지를 입력해주세요.") {
		alert('카드와 함께 보내실 메시지를 작성해주세요.');
		frmO.MMSContent.focus();
		return false;
	}

	// 고객 정보
	if (frmO.reqhp.value.length<12 || frmO.reqhp.value.length>13 || !/-/.test(frmO.reqhp.value)){
		alert('받으시는분의 휴대폰 번호를 정확히 입력해주세요.');
		frmO.reqhp.focus();
		return false;
	}

	if (frmO.sendhp.value.length<12 || frmO.sendhp.value.length>13 || !/-/.test(frmO.sendhp.value)){
		alert('보내시는분의 휴대폰 번호를 입력해주세요.');
		frmO.sendhp.focus();
		return false;
	}
	//frmP.buyhp.value=frmO.sendhp.value;

	if(GetByteLength(frmO.MMSContent.value)>200) {
		alert("메시지 내용은 200byte를 넘을 수 없습니다.");
		frmO.MMSContent.focus();
		return false;
	}

	// 기프트카드 사용약관
    if(frmO.areement.checked != true) {
	    alert("기프트카드 이용약관에 동의해 주시기를 바랍니다.");
	    return false;
	}

	return true;
}

function OrderProc(frmO,frmP){
    if (frmO.Tn_paymethod.length){
        var paymethod = frmO.Tn_paymethod[getCheckedIndex(frmO.Tn_paymethod)].value;
    }else{
        var paymethod = frmO.Tn_paymethod.value;
    }

    //Check Default Form
    if (!CheckForm(frmO,frmP)){
        return;
    }

    //신용카드
    if (paymethod=="100"){

    	if (frmP.price.value<1000){
    		alert('신용카드 최소 결제 금액은 1000원 이상입니다.');
    		return;
    	}

        frmP.gopaymethod.value = "Card";
        frmP.buyername.value = frmO.buyname.value;
	    frmP.buyeremail.value = frmO.buyemail.value;
	    frmP.buyertel.value = frmO.buyhp.value;

    	payInI_Web();
    }

    //실시간 이체
    if (paymethod=="20"){
    	if (frmP.price.value<1000){
    		alert('실시간 이체 최소 결제 금액은 1000원 이상입니다.');
    		return;
    	}

        frmP.gopaymethod.value = "DirectBank";

        frmP.buyername.value = frmO.buyname.value;
	    frmP.buyeremail.value = frmO.buyemail.value;
	    frmP.buyertel.value = frmO.buyhp.value;

    	payInI_Web();
    }

	if ((frmO.sendhp.value != '') && (frmP.buyertel.value == '')) {
		frmP.buyertel.value = frmO.sendhp.value;
	}

	//무통장입금
	if(frmO.isCyberAcct.value=="Y") {
	    //가상계좌
	    if (paymethod=="7"){

	    	if (frmP.price.value<0){
	    		alert('무통장입금 최소 결제 금액은 0원 이상입니다.');
	    		return;
	    	}

	        frmP.gopaymethod.value = "VBank";  //가상계좌

	        frmP.buyername.value = frmO.buyname.value;
		    frmP.buyeremail.value = frmO.buyemail.value;
		    frmP.buyertel.value = frmO.buyhp.value;

	    	payInI_Web();
	    }
	} else {
    	//기존-일반
	    if (paymethod=="7"){
	        if (frmO.acctno.value.length<1){
	    		alert('입금하실 은행을 선택하세요. \r\n문자 메세지로 안내해 드립니다.');
	    		frmO.acctno.focus();
	    		return;
	    	}

	    	if (frmO.acctname.value.length<1){
	    		alert('입금자성명을 입력하세요..');
	    		frmO.acctname.focus();
	    		return;
	    	}

	    	if (frmP.price.value<0){
	    		alert('무통장입금 최소 결제 금액은 0원 이상입니다.');
	    		return;
	    	}else if (frmP.price.value*1==0){
	    	    alert('결제금액이 0원인 경우 주문 후 고객센터로 연락바랍니다.');
	    	}

	    	var ret = confirm('주문 하시겠습니까?');
	    	if (ret){
	    		frmO.target = "";
	    		frmO.action = "/inipay/giftcard/AcctResult.asp";
	    		frmO.submit();
	    	}
	    }
	}
}

function payInI_Web(){
	$('#frmorder').attr("action","/giftcard/iniWeb/getIniWebSign_PreProc.asp");
	$('#frmorder').ajaxSubmit({
		success: function(responseText, statusText){
			if(responseText!="") {
				if(responseText.substr(0,3)=="ERR") {
					alert(responseText.substr(4,responseText.length));
				} else if(responseText.substr(0,2)=="OK") {
					$("#INIWEB_SIG").empty().html(responseText.substr(3,responseText.length));
	                INIStdPay.pay('frmpay');
				} else {
					alert("처리중 오류가 발생했습니다.\n" + responseText);
				}
		    }
		},
		error: function(err){
			alert("ERR: " + err.responseText);
			//alert("죄송합니다. 통신중 오류가 발생하였습니다.\n잠시 후 다시 시도해주세요.");
		}
	});
}
