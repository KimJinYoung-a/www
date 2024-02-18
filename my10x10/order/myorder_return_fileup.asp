<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 마이텐바이텐 반품 파일이미지 등록
' History : 2019.11.28 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
dim fileno, filegubun
    filegubun = requestcheckvar(request("filegubun"),2)
    fileno = requestcheckvar(request("fileno"),10)
%>
<style>
	.btnfileClose{position:absolute; top:-11px; right:0; width:60px; height:60px; font-size:0; color:transparent; background:url(//fiximage.10x10.co.kr/web2019/common/ico_x.png) no-repeat 50% / 20px;}
</style>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV18.css" />
<script type="text/javascript" src="/lib/js/jquery.form.min.js"></script> 
<script type="text/javascript" src="/lib/js/iscroll.js"></script>
<script type="text/javascript">

// 업로드 파일 확인 및 처리
function jsCheckUpload() {
	var fileurl='';
	var filegubun='<%= filegubun %>';
	var fileno='<%= fileno %>';

	if($("#sfile").val()!="") {
		var fsize = $('#sfile')[0].files[0].size;

		if (fsize > 5*1024*1024) {
			alert("첨부파일당 최대 5MB까지 허용됩니다.");
			return;
		}
	}

	if($("#sfile").val()!="") {
		$('#ajaxform').ajaxSubmit({
			//submit이후의 처리
			success: function(responseText, statusText){
                var resultObj = JSON.parse(responseText)
                //alert(responseText);
                if(resultObj.response=="OK") {
					fileurl = resultObj.filename
					$("#fileurl").val(fileurl);

					if (filegubun=="R1"){
						if (fileno=="1"){
							$("#sfile1").val(fileurl);
							$("#fileurl1").html("첨부파일1");
							$("#fileurl1").show();
						}else if(fileno=="2"){
							$("#sfile2").val(fileurl);
							$("#fileurl2").html("첨부파일2");
							$("#fileurl2").show();
						}else if(fileno=="3"){
							$("#sfile3").val(fileurl);
							$("#fileurl3").html("첨부파일3");
							$("#fileurl3").show();
						}else if(fileno=="4"){
							$("#sfile4").val(fileurl);
							$("#fileurl4").html("첨부파일4");
							$("#fileurl4").show();
						}else if(fileno=="5"){
							$("#sfile5").val(fileurl);
							$("#fileurl5").html("첨부파일5");
							$("#fileurl5").show();
						}
						ClosePopLayer()
					}
				}else if(resultObj.response=="FAIL") {
                    alert(resultObj.faildesc);
					return;
				} else {
                    alert("처리중 오류가 발생했습니다.\n" + responseText);
					return;
				}
			},
			//ajax error
			error: function(err){
				alert("ERR: " + err.responseText);
				return;
            }
		});
    }else{
        alert("파일을 선택해 주세요.");
        return;
	}
}

</script>
</head>
<div id="lyWrappingV15a">
	<div class="lyWrappingV15a window" style="height:300px">
		<div style="background-color:#d50c0c;">
			<h1 style="margin-top:0; padding:10px 0; color:#fff;" >파일,이미지 등록</h1>
		</div>
		<div class="scrollbarwrap">
            <% IF application("Svr_Info")="Dev" THEN %>
                <form name="frmUpload" id="ajaxform" action="<%= uploadImgUrl %>/linkweb/cscenter/cs_fileupload.asp" method="post" enctype="multipart/form-data">
            <% else %>
                <form name="frmUpload" id="ajaxform" action="<%= replace(uploadImgUrl,"http://","https://") %>/linkweb/cscenter/cs_fileupload.asp" method="post" enctype="multipart/form-data">
            <% end if %>
			<div class="viewport">
				<div class="overview">
                    <div class="figure">
                        <dl class="pkgGoodMsgV15a tMar25">
                            <dt>파일이 많은경우 압축(ZIP)해서 등록해 주세요.<br>첨부파일당 최대 5MB까지만 허용됩니다.</dt>
                            <dd>
                                <div class="btnArea lt tMar20">
									<input type="file" id="sfile" name="sfile" class="ifile txtInp" style="width:350px;" /><input type="hidden" name="fileurl" id="fileurl" value="">
                                </div>
								<div class="tMar30 ct">
									<button style="width:400px;" onclick="jsCheckUpload(); return false;" class="btnSubmit btn btnS1 btnRed btnW160">전송</button>
								</div>
                            </dd>
                        </dl>
                    </div>
                </div>    
            </div> 
            </form>		
			<button type="button" onclick="ClosePopLayer()" class="btnfileClose">close</button>
		</div>
	</div>
</div>

</body>
</html>