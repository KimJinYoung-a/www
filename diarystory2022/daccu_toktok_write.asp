<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2020 다꾸톡톡 페이지
' History : 2019-09-17 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2022/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2022/lib/classes/daccutoktokcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
    Dim userid, referer, refip

    referer = request.ServerVariables("HTTP_REFERER")
    refip = request.ServerVariables("REMOTE_ADDR")

    userid	= getEncLoginUserID

    '//이미지 업로드 관련
    Dim encUsrId, tmpTx, tmpRn

    Randomize()
    tmpTx = split("A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z",",")
    tmpRn = tmpTx(int(Rnd*26))
    tmpRn = tmpRn & tmpTx(int(Rnd*26))
        encUsrId = tenEnc(tmpRn & userid)
    '//이미지 업로드 관련
%>
<script type="text/javascript" src="/lib/js/jquery.form.min.js"></script>
<script>
    $(function() {
        // 다꾸템 등록
        $('.popup-dctalk .dctem-thumb .mark-list').click(function(e){
            $('#guide-markArea').css('display','none');
            var posX = Math.round( e.offsetX / $('.dctem-thumb .mark-list').width() * 100 );
            var posY = Math.round( e.offsetY / $('.dctem-thumb .mark-list').height() * 100 );
            $('.dctem-thumb .mark-list').append('<li class="mark" id="markposition_'+posX+posY+'" style="left:' + posX + '%; top:' + posY + '%;"><i class="ico-plus"></i></li>');
            setTimeout(function(){
                if (confirm('이곳에 상품을 등록하시겠습니까?')) {
                    daccuMyOrderList();
                    $("#daccuTokItemList").hide();
                    $("#daccuOrderItemCancelBtn").show();
                    $("#daccuOrderItemCancelBtn").attr("onclick","fnMyorderCancel('"+posX+"','"+posY+"');");
                    $("#posX").val(posX);
                    $("#posY").val(posY);
                    $("#daccuRegBtn").hide();
                    <%'// 오른쪽창 크기 조절 %>
                    setTimeout(function(){
                        popCon2('.popup-dctalk');
                    }, 300);                      
                }
                else {
                    $("#markposition_"+posX+posY).remove();
                    return;
                }
            }, 50);
        });

        fnAmplitudeEventMultiPropertiesAction('view_diary_daccutoktok_write','','');    
    });

    <%'// 사용자 이미지 업로드시 Master 데이터 Insert %>
    function daccuTokTokImageExec() {
        $.ajax({
            type:"POST",
            url:"/diarystory2022/lib/ajaxDaccuTokTok.asp",
            data: $("#frmData").serialize(),
            dataType: "text",
            async:false,
            cache:true,
            success : function(Data, textStatus, jqXHR){
                if (jqXHR.readyState == 4) {
                    if (jqXHR.status == 200) {
                        if(Data!="") {
                            var result = JSON.parse(Data)
                            if(result.response == "ok"){									
                                $("#daccuTokMasterIdx").val(result.MasterIdx);
                                <%'// 오른쪽창 크기 조절 %>
                                setTimeout(function(){
                                    popCon('.popup-dctalk');
                                }, 300);                                 								
                            }else{
                                alert(result.faildesc);
                                return false;
                            }
                        } else {
                            alert("잘못된 접근 입니다.");
                            document.location.reload();
                            return false;
                        }
                    }
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("잘못된 접근 입니다.");					
                // document.location.reload();
                return false;
            }
        });
    }

    // 업로드 파일 확인 및 처리
    function jsCheckUpload() {
        if($("#fileupload").val()!="") {
            $("#fileupmode").val("upload");

            $('#ajaxform').ajaxSubmit({
                //보내기전 validation check가 필요할경우
                beforeSubmit: function (data, frm, opt) {
                    if(!(/\.(jpg|jpeg|png)$/i).test(frm[0].upfile.value)) {
                        alert("JPG,PNG 이미지파일만 업로드 하실 수 있습니다.");
                        $("#fileupload").val("");
                        return false;
                    }
                },
                //submit이후의 처리
                success: function(responseText, statusText){
                    //fnAmplitudeEventMultiPropertiesAction('click_my_review_files','','');
                    var resultObj = JSON.parse(responseText)
                    //alert(responseText);

                    if(resultObj.response=="fail") {
                        alert(resultObj.faildesc);
                    } else if(resultObj.response=="ok") {
                        //파일 집어 넣기
                        var $file_len = $(".dctem-left").find('input').length;
                        var $files = $(".dctem-left").find('input');
                        var $file_idx;
                        
                        for (i = 0 ; i < $file_len ; i++ ){
                            if (!$files.eq(i).val()){
                                $files.eq(i).val(resultObj.fileurl);
                                $file_idx = i;
                                break;
                            }
                        }

                        $(".dctem-left .dctem-thumb").eq($file_idx).show();//껍데기 보여주기
                        $(".dctem-left .dctem-thumb").find('img').eq($file_idx).hide().attr("src",resultObj.fileurl+"?"+Math.floor(Math.random()*1000)).fadeIn("fast");//파일 치환
                        $(".dctem-left .btn-add").eq($file_idx).hide();//해당 위치 찾아가기
                        $("#guide-markArea").show();
                        $("#pictureChangeBtn").show();
                        <%'// 이미지 업로드된 URL을 DB에 일단 넣는다.%>
                        $("#daccuTokMode").val("ImageProc");
                        //alert(resultObj.fileurl);
                        $("#daccuTokMainImageUrl").val(resultObj.fileurl);                       
                        daccuTokTokImageExec();                           
                    } else {
                        alert("처리중 오류가 발생했습니다.\n" + responseText);
                    }
                    $("#fileupload").val("");
                },
                //ajax error
                error: function(err){
                    alert("ERR: " + err.responseText);
                    $("#fileupload").val("");
                }
            });
        }
    }

    <%'// 등록완료 버튼 활성화를 위한 validation 체크 %>
    function regStatusCheck() {
        if (!$("#lyrBnrImg").attr("src")==""&&!$("#daccuTokTitle").val()==""&&$("#daccuTokItemList").html() != "") {
            $("#daccuRegBtn").show();
        }
    }

    function daccuTokTokDetailProduct() {
        $.ajax({
            type:"GET",
            url:"/diarystory2022/lib/act_daccu_toktok_detailitemlist.asp?MasterIdx="+$('#daccuTokMasterIdx').val(),
            //data: ,
            dataType: "text",
            async:false,
            cache:true,
            success : function(Data, textStatus, jqXHR){
                if (jqXHR.readyState == 4) {
                    if (jqXHR.status == 200) {
                        if(Data!="") {
                            $("#daccuTokItemList").empty().html(Data);
                        } else {
                            alert("잘못된 접근 입니다.");
                            document.location.reload();
                            return false;
                        }
                    }
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("잘못된 접근 입니다.");					
                // document.location.reload();
                return false;
            }
        });
    }

    <%'// 상품 등록 후 동작 %>
    function daccuTokTokAfterDetailProc() {
        <%'// 상품 주문 리스트를 숨기고  %>
        $("#daccuTokMyOrderList").hide();
        <%'// 기존에 등록했던 리스트를 보여주고 %>
        $("#daccuTokItemList").show();
        <%'// 상품 태그 등록 버튼 숨기고 %>
        $("#daccuOrderItemRegBtn").hide();
        <%'// 상품 태그 취소 버튼 숨기고 %>
        $("#daccuOrderItemCancelBtn").hide();
        <%'// 등록된 주문상품 리스트를 불러옴 %>
        daccuTokTokDetailProduct();
        <%'// 우측 상단 제목 입력부를 다시 보여주고 %>
        $(".dctem-right .dctem-head").show();
        <%'// 좌측 이미지 클릭 막아놓은거 풀어줌 %>
        $('.dctem-thumb').removeClass("disable");
        <%'// 다꾸템 전체를 등록하였는지 체크함 %>
        setTimeout(function(){
            regStatusCheck();
        }, 50);
        setTimeout(function(){
            <%'// 오른쪽 창 크기 재정렬 %>
            popCon3('.popup-dctalk');
        }, 300);
    }

    <%'// 좌측하단 사진변경 클릭 시 %>
    function fnChangePicture() {
        fnCloseModal();
        daccuTokWrite();
    }

    <%'// 상품에 영역 선택 후 내 주문 리스트 가져오기 %>
    function daccuMyOrderList() {
	    <% If IsUserLoginOK() Then %>
            <%'// 상단 타이틀 영역 숨김 %>
            $(".dctem-right .dctem-head").hide();
            $.ajax({
                type:"GET",
                url:"/diarystory2022/lib/act_daccu_toktok_myorder.asp",
                //data: $("#frmDaccuTokTokMyOrderFrm").serialize(),
                dataType: "text",
                async:false,
                cache:true,
                success : function(Data, textStatus, jqXHR){
                        //$str = $(Data);
                        //res = Data.split("||");
                        //alert(Data);
                        if (jqXHR.readyState == 4) {
                            if (jqXHR.status == 200) {
                                if(Data!="") {
                                    $('#daccuTokMyOrderList').empty().html(Data);
                                    $('#daccuTokMyOrderList').show();
                                    $('.dctem-thumb').addClass("disable");
                                } else {
                                    //alert("상품이 없습니다.");
                                }
                            }
                        }
                },
                error:function(jqXHR, textStatus, errorThrown){
                    alert("잘못된 접근 입니다.");
                    var str;
                    for(var i in jqXHR)
                    {
                        if(jqXHR.hasOwnProperty(i))
                        {
                            str += jqXHR[i];
                        }
                    }
                    //alert(str);
                    //document.location.reload();
                    return false;
                }
            });
        <% Else %>
            if(confirm("로그인을 하셔야 주문내역을 보실 수 있습니다.")){
                location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/diarystory2022/daccu_toktok.asp")%>';
                return;
            }
        <% End If %>
    }

    <%'// 상품 태그 등록 취소 버튼 클릭시 %>
    function fnMyorderCancel(xv,yv) {
        <%'// 해당 버튼에 있는 onclick attribute를 삭제한다. %>
        $("#daccuOrderItemCancelBtn").removeAttr("onclick");
        <%'// 상품 태그 등록 버튼 숨기고 %>
        $("#daccuOrderItemRegBtn").hide();        
        <%'// 취소 버튼을 숨긴다. %>
        $("#daccuOrderItemCancelBtn").hide();
        <%'// 출력해줬던 오른쪽의 주문 리스트를 숨긴다. %>
        $("#daccuTokMyOrderList").hide();
        <%'// 기존에 등록했던 리스트를 보여주고 %>
        $("#daccuTokItemList").show();        
        <%'// 좌측 이미지에 찍혀있는 아이콘을 삭제한다. %>
        $("#markposition_"+xv+yv).remove();
        <%'// 오른쪽 상단에 타이틀 영역을 다시 보여준다. %>
        $(".dctem-right .dctem-head").show();
        <%'// 좌측 이미지 클릭 안되게 가리는 부분 제거 처리 해야됨 %>
        $('.dctem-thumb').removeClass("disable");
        <%'// 좌표 값 삭제 %>
        $("#posX").val();
        <%'// 좌표 값 삭제 %>
        $("#posY").val();
        <%'// 다꾸템 전체를 등록하였는지 체크함 %>
        setTimeout(function(){
            regStatusCheck();
        }, 50);        
        setTimeout(function(){
            <%'// 오른쪽 창 크기 재정렬 %>
            popCon3('.popup-dctalk');
        }, 200);
    }

    <%'// 주문 리스트에서 상품 클릭 시 %>
    function clickOrderList(itemid,itemoption) {
        $("#daccuOrderItemRegBtn").show();
        $("#MasterIdxUseItem").val($("#daccuTokMasterIdx").val());
        $("#clickInsertItemId").val(itemid);
        $("#clickInsertItemOption").val(itemoption);
    }

    <%'// 주문 리스트 상품 등록 시 %>
    function buttonProductInsert() {
        $.ajax({
            type:"POST",
            url:"/diarystory2022/lib/ajaxDaccuTokTok.asp",
            data: $("#frmDaccuTokTokMyOrderItemInsert").serialize(),
            dataType: "text",
            async:false,
            cache:true,
            success : function(Data, textStatus, jqXHR){
                if (jqXHR.readyState == 4) {
                    if (jqXHR.status == 200) {
                        if(Data!="") {
                            var result = JSON.parse(Data)
                            if(result.response == "ok"){
                                daccuTokTokAfterDetailProc();
                                return false;
                            }else{
                                alert(result.faildesc);
                                return false;
                            }
                        } else {
                            alert("잘못된 접근 입니다.");
                            document.location.reload();
                            return false;
                        }
                    }
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("잘못된 접근 입니다.");					
                // document.location.reload();
                return false;
            }
        });
    }

    <%'// 최종 등록 %>
    function daccuTokTokProc() {
        $("#daccuTokMode").val("daccuProc");
        $("#daccuTokProcTitle").val($('#daccuTokTitle').val());
        $.ajax({
            type:"POST",
            url:"/diarystory2022/lib/ajaxDaccuTokTok.asp",
            data: $("#frmData").serialize(),
            dataType: "text",
            async:false,
            cache:true,
            success : function(Data, textStatus, jqXHR){
                if (jqXHR.readyState == 4) {
                    if (jqXHR.status == 200) {
                        if(Data!="") {
                            var result = JSON.parse(Data)
                            if(result.response == "ok"){									
                                document.location.href='/diarystory2022/daccu_toktok.asp'									
                                return false;
                            }else{
                                alert(result.faildesc);
                                return false;
                            }
                        } else {
                            alert("잘못된 접근 입니다.");
                            document.location.reload();
                            return false;
                        }
                    }
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("잘못된 접근 입니다.");					
                // document.location.reload();
                return false;
            }
        });
    }
</script>


<button type="button" class="btn-close" onclick="fnCloseModal();return false;">팝업 닫기</button>

<%' 팝업 왼쪽 영역 %>
<div class="dctem-left">
    <input type="hidden" name="file1" value="" />

    <%' for dev msg : 이미지 등록 전 %>
    <label for="fileupload" class="btn-add" style="cursor:pointer;">다꾸템 등록하기</label>
    
    <%' for dev msg : 이미지 등록 후 %>
    <div class="dctem-thumb" style="display:none;">
        <img id="lyrBnrImg" src="" alt="">
        <ul class="mark-list"></ul>
    </div>    
</div>
<%' 팝업 오른쪽 영역 %>
<div class="dctem-right">
    <%' for dev msg : 쓰기 (write) %>
    <div class="dctem-head">
        <input type="text" class="input-tit" name="daccuTokTitle" id="daccuTokTitle" onchange="regStatusCheck();" onkeyup="regStatusCheck();" placeholder="제목을 입력해주세요!">
    </div>
    <div class="dctem-conts">
        <div class="scrollbarwrap1">
            <div class="scrollbar"><div class="thumb"></div></div>
            <div class="viewport">
                <div class="overview">
                    <%' 리스트 영역 %>
                    <%' 등록 리스트 (선택불가) %>
                    <ul class="dctem-list" id="daccuTokItemList"></ul>

                    <%' 구매 리스트 (선택가능) %>
                    <ul class="my-list" id="daccuTokMyOrderList" style="display:none;"></ul>

                    <%'// 이미지 등록 전 숨김 %>
                    <div class="guide-mark" id="guide-markArea" style="display:none;">이미지에서 태그할 영역을 선택해주세요.</div>
                    <%' // 리스트 영역 %>
                </div>
            </div>
        </div>
    </div>
</div>

<%' for dev msg : 쓰기 (write) %>
<div class="bot-area">
    <%' for dev msg : 사진 변경 버튼 (이미지 등록 전 숨김) %>
    <button type="button" class="btn-modify ftLt" id="pictureChangeBtn" style="display:none;" onclick="fnChangePicture();return false;">사진 변경</button>
    <%' for dev msg : 등록 버튼 (구매리스트 선택 시 버튼 텍스트 "상품 태그 등록하기") %>
    <button type="button" class="btn-register ftRt" id="daccuRegBtn" style="display:none" onclick="daccuTokTokProc();">등록하기</button>
    <button type="button" class="btn-cancel ftRt" id="daccuOrderItemCancelBtn" style="display:none;">상품 태그 취소하기</button>
    <button type="button" class="btn-register ftRt" id="daccuOrderItemRegBtn" style="display:none;" onclick="buttonProductInsert();">상품 태그 등록하기</button>
</div>

<%' 이미지 업로드 Form %>
<form name="frmUpload" id="ajaxform" action="<%=staticImgUpUrl%>/common/simpleCommonImgUploadProc.asp" method="post" enctype="multipart/form-data" style="display:none; height:0px;width:0px;">
<input type="file" name="upfile" id="fileupload" onchange="jsCheckUpload();" accept="image/*" />
<input type="hidden" name="mode" id="fileupmode" value="upload">
<input type="hidden" name="div" value="SB">
<input type="hidden" name="tuid" value="<%=encUsrId%>">
<input type="hidden" name="prefile" id="filepre" value="">
<input type="hidden" name="itemid" value="9999999">
</form>
<%' 이미지 업로드 Form %>

<%' 작성 폼 데이터 %>
<form name="frmData" id="frmData" style="display:none; height:0px;width:0px;">
    <input type="hidden" name="daccuTokMasterIdx" id="daccuTokMasterIdx">
    <input type="hidden" name="daccuTokMode" id="daccuTokMode">
    <input type="hidden" name="daccuTokMainImageUrl" id="daccuTokMainImageUrl">
    <input type="hidden" name="daccuTokProcTitle" id="daccuTokProcTitle">
</form>
<%'// 작성 폼 데이터 %>

<form name="frmDaccuTokTokMyOrderItemInsert" id="frmDaccuTokTokMyOrderItemInsert" method="post">
    <input type="hidden" name="clickInsertItemId" id="clickInsertItemId">
    <input type="hidden" name="clickInsertItemOption" id="clickInsertItemOption">
    <input type="hidden" name="daccuTokModeTemp" id="daccuTokModeTemp" value="DetailItemProc">
    <input type="hidden" name="MasterIdxUseItem" id="MasterIdxUseItem">    
    <input type="hidden" name="posX" id="posX">
    <input type="hidden" name="posY" id="posY">
</form>

<!-- #include virtual="/lib/db/dbclose.asp" -->