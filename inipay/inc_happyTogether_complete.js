$(function(){
	try{
		recoPick('fetchUID', function (uid) {
			if(uid.split(".")[0]%2==0) {
				// 기존 추천 방식 (5:5)
				// CallHappyTogether("O",uid);
				//	getRecoListCheck("O",uid);
					getRecoListCheck("N",uid);
			} else {
				// RecoPick 추천
				//CallHappyTogether("N",uid);
				getRecoListCheck("N",uid);
			}
		});
	} catch(e){
		// 기존 추천 방식
		// getRecoListCheck("O","");
		getRecoListCheck("N","");
	}
});

function CallHappyTogether(vChkHT,vRuid, vPrdList, vMtdList) {
	$.ajax({
		url: "act_happyTogether_complete.asp?itemid="+vIId+"&disp="+vDisp+"&chk="+vChkHT+"&ruid="+vRuid+"&prdlist="+vPrdList+"&MtdList="+vMtdList,
		cache: false,
		async: false,
		success: function(vRst) {
			if(vRst!="") {
				$("#lyrHPTgr").empty().html(vRst);
				if($(".collection").length<=0) $("#detail06_Best").show();
				$('#lyrHPTgr .pdtPhoto').hover(function() {
					$(this).children('.pdtAction').toggle();
				});
		    }
		}
		,error: function(err) {
			alert(err.responseText);
		}
	});
}

function getRecoListCheck(vCHkHT, vRuid)
{
	var vIIdValue='';
	var vMethodValue='';
	if (vCHkHT=="N")
	{
		$.getJSON("https://api.recopick.com/v1/recommendations/item/86/"+vRuid+"/"+vIId+"?limit=5&channel=recopick_c&type=viewtogether&callback=?",
			function(data, status)
			{
				if (status=="success")
				{
					$.each(data, function(header, value) {
						for (it=0;it < value.length;it++)
						{
							vIIdValue += value[it].id+",";
							vMethodValue += value[it].method+",";
						}
						vIIdValue = vIIdValue.substring(0, (vIIdValue.length-1));
						vMethodValue = vMethodValue.substring(0, (vMethodValue.length-1));
					});
					CallHappyTogether(vCHkHT, vRuid, vIIdValue, vMethodValue);
				}
				else
				{
					vIIdValue='';
					vMethodValue = '';
				}
			}
		);
	}
	else
	{
		CallHappyTogether(vCHkHT, vRuid, '', '');
	}
}


function FnGoProdItem(vi,oi,mt,dv,uid,lnk,chn){
	//if(dv=="T") {
	//	location.href = "/shopping/category_prd.asp?itemid="+vi;
	//} else {
		if(lnk!="") {
			location.href = lnk;
		} else {
			location.href = "https://api.recopick.com/1/banner/86/pick?source=" + oi + "&pick=" + vi + "&uid=" + uid + "&method=" + mt + "&channel="+ chn + "&reco_type=item-item";
		}
	//}
}

