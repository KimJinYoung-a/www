<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2017 브랜드 스페셜
' History : 2015.10.13 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2017/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2017/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/diarystory2017/lib/classes/specialbrandCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->

<%

Dim i , imglink, PageSize , CurrPage, totalpage

'PageSize	= requestcheckvar(request("page"),2)
'CurrPage 	= requestCheckVar(request("cpg"),9)
''SortMet 	= requestCheckVar(request("srm"),9)
''userid		= getEncLoginUserID
'
PageSize = 4
'IF CurrPage = "" then CurrPage = 1
'
'''스페셜 브랜드 테스트
dim oSpecialBrand
set oSpecialBrand = new DiaryCls
'	oSpecialBrand.FPageSize = PageSize
'	oSpecialBrand.FCurrPage = CurrPage
	oSpecialBrand.fcontents_list

totalpage = oSpecialBrand.FTotalCount/PageSize
%>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2017.css" />
<script type="text/javascript">

function jsGoPage(iP){
document.sFrm.cpg.value = iP;
document.sFrm.submit();
}

function jsvideo(mvurl,brname){
	var mvurlid = document.getElementById('mvurlid');
	$("#videobrname").text(brname);
	mvurlid.src = mvurl;
	viewPoupLayer('modal',$('#lyrVideo').html());
}

function checkForHash() {
	if(document.location.hash){
		var HashLocationName = document.location.hash;
		HashLocationName = HashLocationName.replace("#","");
		$("#cpg").val(HashLocationName);
	} else {
		$("#cpg").val(1);
		document.location.hash = "#1";
	}
}

var isloading=true;
$(function(){

	//첫페이지 로딩
	checkForHash();
	if(document.location.hash){
		getListhash();
	} else {
		getList();
	}

	//스크롤 이벤트 시작
	$(window).unbind("scroll");
	$(window).scroll(function() {
      if ($(window).scrollTop() >= $(document).height() - $(window).height() - 350){
          if (isloading==false){
            isloading=true;

			var pg = $("#cpg").val();
			if (pg>0 && pg<<%=totalpage%>){
			//if (pg>0){
				pg++;
				$("#cpg").val(pg);
	            setTimeout("getList()",500);
	        }
          }
      }
    });
});

function getList(cpgval) {
//	if(cpgval==2){
//		$("#indexfrm input[name='cpg']").val(cpgval);
//		$("#additem").remove();
//	}
	var cpage = $("#cpg").val();
	if (cpage>1){
		document.location.hash = "#" + cpage;
	}
	var str = $.ajax({
			type: "GET",
	        url: "brandspecial_act.asp",
	        data: $("#indexfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;

	if(str!="") {
    	if($("#cpg").val()=="1") {
        	$('#indexact').html(str);
        } else {
       		$str = $(str)
       		$('#indexact').append($str);
        }
        isloading=false;
    } else {
    	$(window).unbind("scroll");
    }
}

function getListhash() {
	var hcpg = $("#cpg").val();
	for(var i=1; i<=hcpg; i++) {
		$("#cpg").val(i);
		var str = $.ajax({
				type: "GET",
		        url: "brandspecial_act.asp",
		        data: $("#indexfrm").serialize(),
		        dataType: "text",
		        async: false
		}).responseText;
	
		if(str!="") {
	    	if($("#cpg").val()=="1") {
	        	$('#indexact').html(str);
	
	        } else {
	       		$str = $(str)
	       		$('#indexact').append($str);
	        }
	        isloading=false;
	    } else {
	    	$(window).unbind("scroll");
	    }
	}
//	$("#additem").remove();
}

</script>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2017.css" />
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diarystory2017 brandSpecial">
		<div id="contentWrap">
			<!-- #include virtual="/diarystory2017/inc/head.asp" -->
			<div class="diaryContent" id="indexact"></div>
			<form id="indexfrm" name="indexfrm" method="get" style="margin:0px;">
			<input type="hidden" id="cpg" name="cpg" value="1" />
			</form>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<!-- 브랜드 동영상 보기 레이어 -->
<div id="lyrVideo" style="display:none;">
	<div class="brandVideo">
		<p class="name" id="videobrname"></p>
		<div class="video"><div><iframe id="mvurlid" src="" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div></div>
		<button class="close" onclick="ClosePopLayer();"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/btn_close.png" alt="닫기" /></button>
	</div>
</div>
<!--// 브랜드 동영상 보기 레이어 -->
</body>
</html>
<% Set oSpecialBrand = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->