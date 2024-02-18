<%
dim diaryStoryCheck
If now() >= #2022-09-01 00:00:00# and now() < #2023-02-01 00:00:00# Then
    diaryStoryCheck = True
elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" then
    diaryStoryCheck = True
else
    diaryStoryCheck = False
end if

function fnReplaceTitle(vTitle)
    if vTitle="다이어리 구분" then
        fnReplaceTitle="종류"
    elseif vTitle="다이어리 스타일" then
        fnReplaceTitle="스타일"
    elseif vTitle="다이어리 날짜" then
        fnReplaceTitle="날짜"
    elseif vTitle="다이어리 기간" then
        fnReplaceTitle="기간"
    elseif vTitle="다이어리 내지 구성" then
        fnReplaceTitle="내지 구성"
    elseif vTitle="다이어리 재질" then
        fnReplaceTitle="재질"
    elseif vTitle="다이어리 제본" then
        fnReplaceTitle="제본"
    end if
end function

if parentsPage="" then parentsPage="today"
if parentsPage="categoryList" or parentsPage="categoryMain" then parentsPage="category"

if diaryStoryCheck then
%>
    <style>
        a:hover{text-decoration:none;}
        .diary2023_filter{cursor:pointer; width:166px; position:fixed; z-index:1000; bottom:40px; left:50%; transform:translateX(-50%);}
        .diary2023_filter .float_img{position:relative;}
        .diary2023_filter .filter_tooltip{width:36px; height:36px; position:absolute; top:3.5px; right:0px; left:unset; transform:unset; z-index:3;}
        .diary2023_filter .filter_tooltip .tooltip{z-index:2; position:absolute; bottom:0; left:50%; padding-bottom:40px;}
        .diary2023_filter .filter_tooltip .tooltip.t01{width:343px; height:163px; display:none; cursor:initial; background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/filter01_info.png?v=1.3) no-repeat; background-size:100%; background-position:top center; margin-left:-237px;}
        .diary2023_filter .filter_tooltip .tooltip.t02{width:328px; height:143px; display:none; cursor:initial; background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/filter01_info02.png) no-repeat; background-size:100%; background-position:top center; margin-left:-229px;}
        .diary2023_filter .filter_tooltip .btn_close{display:block; width:20px; height:20px; position:absolute; right:12px; top:12px;}
        .diary2023_filter .filter_tooltip .btn_daccu{display:block; width:136px; height:24px; position:absolute; left:50%; transform:translateX(-50%); bottom:61px;}
        .diary2023_filter .float_img .filter_btn{width:96px; height:52px; position:relative; margin-left:30px;}
        .diary2023_filter.inactive .float_img .filter_btn{cursor:auto;}
        .diary2023_filter .float_img .filter02 .filter_btn{width:102px; height:52px; margin-left:36px;}
        .diary2023_filter .float_img .filter01{display:none}
        .diary2023_filter .float_img .filter01.on{display:block; position:relative;}
        .diary2023_filter .float_img .filter02{display:none}
        .diary2023_filter .float_img .filter02.on{display:block; position:relative;}
        .diary2023_filter .float_img .filter02 img{position:relative;}
        .diary2023_filter .float_img .filter02 .filter_detail{width:36px; height:36px; position:absolute; left:130px; top:3.5px; z-index:2;}
        .diary2023_filter .filter_notice{width:36px; height:36px; position:absolute; top:0px; right:0px; left:unset; transform:unset; z-index:3;}
        .diary2023_filter .filter_notice img{width:100%;}
        @keyframes up {
            0% {top:0px; opacity:0;}
            80% {top:0px; opacity:0;}
            100% {top:-38px; opacity:1;}
        }
        .diary2023_filter_on{width:750px; position:fixed; top:50%; border:2px solid #FF5D94; border-radius:16px; left:50%; transform:translate(-50%, -50%); background:#fff; opacity:0.9; z-index:1001; display:none;}
        .diary2023_filter_on .filter_top{padding:16px 15px; border-bottom:2px solid #eee; display:flex; justify-content:space-between; align-items:center;}
        .diary2023_filter_on .filter_top .reset{margin-right:8px; font-size:14px; font-weight:600; line-height:16.8px; color:#FF5D94;}
        .diary2023_filter_on .filter_top .btn_filter{font-size:14px; font-weight:600; line-height:16.8px; color:#fff; background:#FF214F; border-radius:24px; padding:7.5px 16px;}
        .diary2023_filter_on .filter_top .btn_close{width:28px; height:28px; cursor:pointer;}
        .diary2023_filter_on .filter_cont{padding:24px 31px;}
        .diary2023_filter_on .filter_cont li{display:flex; flex-wrap:wrap;}
        .diary2023_filter_on .filter_cont .filter-sub{width:calc(100% - 98px);}
        .diary2023_filter_on .filter_cont .filter-sub-cont{display:flex; flex-wrap:wrap;}
        .diary2023_filter_on .filter_cont .option-list{display:flex; flex-wrap:wrap; width:100%;}
        .diary2023_filter_on .filter_cont .filter-main{width:98px; font-size:18px; font-weight:700; line-height:21.6px; color:#000;}
        .diary2023_filter_on .filter_cont .filter-sub-cont .checkbox{width:33.3%; margin-bottom:16px;}
        .diary2023_filter_on .filter_cont .filter-sub-cont .checkbox input[type="checkbox"]{display:none;}
        .diary2023_filter_on .filter_cont .filter-sub-cont .checkbox input[type="checkbox"] + label{padding-left:32px; font-size:14px; font-weight:600; line-height:25px; color:#666; position:relative; cursor:pointer;}
        .diary2023_filter_on .filter_cont .filter-sub-cont .checkbox input[type="checkbox"] + label::after{left:0; background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/check-square.png?v=1.2) no-repeat; content:''; position:absolute; width:24px; height:24px; background-size:contain;}
        .diary2023_filter_on .filter_cont .filter-sub-cont .checkbox input[type="checkbox"]:checked + label::after{left:0; background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/check-square02_new.png) no-repeat; content:''; position:absolute; width:24px; height:24px; background-size:contain;}
        .diary2023_filter_on .filter_cont .line{margin:8px 0 24px 0; width:100%; height:1px; border-bottom:1px dotted #ccc;}
        .diary2023_filter_on .filter_cont .colorchips li.selected{background-image:url(//fiximage.10x10.co.kr/web2015/common/color_chip_on.png);}
    </style>
    <!-- 활성화 -->
    <% if categorydiaryItemCnt>0 then %>
        <div class="diary2023_filter">
            <div class="float_img active">
                <div class="filter01">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/filter02_new.png" alt="" class="filter_btn">
                </div>
                <div class="filter02">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/filter02_detail_new.png" alt="" class="filter_detail">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/filter02_on_new.png?v=1.2" alt="" class="filter_btn">
                </div>
            </div>
            <div class="filter_tooltip" style="display: none">
                <p class="tooltip hover t01">
                    <a href="" class="btn_close"></a>
                    <a href="/diarystory2023/index.asp" class="btn_daccu"></a>
                </p>
                <p class="tooltip click t01">
                    <a href="" class="btn_close"></a>
                    <a href="/diarystory2023/index.asp" class="btn_daccu"></a>
                </p>
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/filter_notice.png" alt="" class="filter_notice">
            </div>
        </div>
        <!-- 검색 세부 -->
        <div class="diary2023_filter_on">
            <div class="filter_top">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/close02.png" alt="" class="btn_close">
                <ul>
                    <a href="#" class="reset">초기화</a>
                    <a href="" class="btn_filter" onclick="fnSearchDiaryStory();return false;"><span id="searchResultCount"><%=diaryItemCnt%></span>건의 상품보기</a>
                </ul>
            </div>
            <div class="filter_cont">
                <ul class="filter-cont">
                    <div id="diaryAttribute">
                    <%
                    If oGrAtt.FResultCount>0 Then
                        tmpAttr1 = ""

                        FOR lp=0 to oGrAtt.FResultCount-1
                            tmpArrAttrNm = split(oGrAtt.FItemList(lp).FAttribName,"||")
                            if left(oGrAtt.FItemList(lp).FAttribCd,4) = "3010" or left(oGrAtt.FItemList(lp).FAttribCd,4) = "3020" or left(oGrAtt.FItemList(lp).FAttribCd,4) = "3040" or left(oGrAtt.FItemList(lp).FAttribCd,4) = "3050" or left(oGrAtt.FItemList(lp).FAttribCd,4) = "3060" or left(oGrAtt.FItemList(lp).FAttribCd,4) = "3070" then
                                if ubound(tmpArrAttrNm)>0 then
                                    '행구분 시작 확인
                                    if tmpAttr1<>left(oGrAtt.FItemList(lp).FAttribCd,3) then
                                        tmpAttr1 = left(oGrAtt.FItemList(lp).FAttribCd,3)
                                        Response.Write "<li id=""filterdiv"&left(oGrAtt.FItemList(lp).FAttribCd,4)&"""><div class=""filter-main"">" & fnReplaceTitle(tmpArrAttrNm(0)) & "</div><div class=""filter-sub""><ul class=""filter-sub-cont"">"
                                    end if

                                    Response.Write "<li class=""checkbox""><input type=""checkbox"" id=""Attr2" & oGrAtt.FItemList(lp).FAttribCd & """ class=""check"" value=""" & oGrAtt.FItemList(lp).FAttribCd & """ " & chkiif(chkArrValue(AttribCd,oGrAtt.FItemList(lp).FAttribCd),"checked","") & " /> <label for=""Attr2" & oGrAtt.FItemList(lp).FAttribCd & """ prv=""" & tmpArrAttrNm(0) & """>" & tmpArrAttrNm(1) & "</label></li>"

                                    '행구분 종료 확인
                                    if lp<(oGrAtt.FResultCount-1) then
                                        if tmpAttr1<>left(oGrAtt.FItemList(lp+1).FAttribCd,3) then
                                        Response.Write "</ul></div><p class=""line""></p></li>"
                                        end if
                                    end if
                                end if
                            end if
                        NEXT
                        'if tmpAttr1<>"" then
                        '    Response.Write "</ul></div><p class=""line""></p></li>"
                        'end if
                    end if
                    %>
                    </div>
                    <li>
                        <div class="filter-main">컬러</div>
                        <div class="filter-sub">
                            <ul class="option-list colorchips" id="diaryColorChip">
                                <li class="all<%=chkiif(cStr(colorCD)="0"," selected","")%>"><input type="checkbox" id="col00" value="0" /><label for="col00">ALL</label></li>
        <%
            If oGrClr.FResultCount>0 Then
                FOR lp=0 to oGrClr.FResultCount-1
                    if oGrClr is Nothing then
                        '// skip
                    elseif VarType(oGrClr) <> vbObject then
                        '// skip
                    elseif VarType(oGrClr.FItemList(lp)) <> vbObject then
                        '// skip
                    elseif VarType(oGrClr.FItemList(lp).FcolorCode) = vbString then
        %>
                                <li class="<%=getColorEng(oGrClr.FItemList(lp).FcolorCode) & " " & chkiif(chkArrValue(colorCD,oGrClr.FItemList(lp).FcolorCode),"selected","")%>">
                                    <input type="checkbox" id="col2<%=oGrClr.FItemList(lp).FcolorCode%>" value="<%=oGrClr.FItemList(lp).FcolorCode%>" <%=chkiif(chkArrValue(colorCD,oGrClr.FItemList(lp).FcolorCode),"checked","")%> />
                                    <label for="col2<%=oGrClr.FItemList(lp).FcolorCode%>"><%=UCase(getColorEng(oGrClr.FItemList(lp).FcolorCode))%></label>
                                </li>
        <%
                    end if
                Next
            end if
        %>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <script>
            $(function(){
                $('.filter_tooltip').delay(15000).fadeOut();
                <% if diarystoryitem="R" then %>
                    $(".float_img").removeClass('active');
                    $(".float_img").find('.filter01').removeClass('on');
                    $(".float_img").find('.filter02').addClass('on');
                    $('.filter_tooltip').hide();
                <% else %>
                    $(".float_img").addClass('active');
                    $(".float_img").find('.filter01').addClass('on');
                    $(".float_img").find('.filter02').removeClass('on');
                    $('.filter_tooltip').show();
                <% end if %>
                $('.diary2023_filter .float_img').click(function(){
                    if($(this).hasClass('active')){
                        $(this).removeClass('active');
                        $(this).find('.filter01').removeClass('on');
                        $(this).find('.filter02').addClass('on');
                        document.sFrm.diarystoryitem.value="R";
                        fnAmplitudeEventMultiPropertiesAction('click_diarystory_toggle','action|place','on|<%=parentsPage%>');
                    }else{
                        $(this).addClass('active');
                        $(this).find('.filter01').addClass('on');
                        $(this).find('.filter02').removeClass('on');
                        document.sFrm.diarystoryitem.value="";
                        document.sFrm.iccd.value="";
                        document.sFrm.attribCd.value="";
                        fnAmplitudeEventMultiPropertiesAction('click_diarystory_toggle','action|place','off|<%=parentsPage%>');
                    }
                    document.sFrm.submit();
                })

                $('.diary2023_filter .filter_detail').click(function(){
                    $('.diary2023_filter .float_img').addClass('active');
                    $('.diary2023_filter_on').show();
                    return false;
                })

                $('.diary2023_filter_on .btn_close').click(function(){
                    $('.diary2023_filter_on').css('display','none');
                })

                // 툴팁 노출
                // hover
                $('.filter_tooltip').on({
                    mouseenter : function(e){
                        if($('.tooltip.click').css('display') == 'block'){
                            
                        }else{
                            $('.tooltip.hover').css('display','block');
                            $('.tooltip.click').css('display','none');
                        }
                    },
                    mouseleave : function(e){
                        $('.tooltip.hover').css('display','none');
                    },
                })
                // click
                $('.diary2023_filter .filter_notice').click(function(){
                    if($('.tooltip.click').css('display') == 'block' || $('.diary2023_filter_on').css('display') == 'block'){
                        $('.tooltip.click').css('display','none');
                    }else{
                        $('.tooltip.click').css('display','block').delay(15000).fadeOut();
                        $('.tooltip.hover').css('display','none');
                    }
                })
                $('.filter_tooltip .btn_close').click(function(){
                    $('.filter_tooltip .tooltip').css('display','none');
                    return false;
                })

                <% if parentsPage<>"categoryMain" then %>
                // 필터속성 초기화 버튼
                $(".reset").click(function(){
                    //컬러
                    $('#fttabColor li input').prop("checked",false);
                    $('#fttabColor li input').removeClass('selected');
                    if(!$("#fttabColor li").has("input:checked").length) $("#fttabColor .all").addClass('selected');

                    // 상품속성
                    $("#fttabAttribute li input").prop("checked",false);

                    setCategoryMainSearchFilterItem();
                    document.sFrm.cpg.value=1;
                    document.sFrm.submit();
                    return false;
                });
                <% else %>
                // 필터속성 초기화 버튼
                $(".reset").click(function(){
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

                    setSearchFilterItem();
                    document.sFrm.cpg.value=1;
                    document.sFrm.submit();
                    return false;
                });
                <% end if %>
            })

            function fnSearchDiaryStory(){
                document.sFrm.cpg.value=1;
                document.sFrm.submit();
            }

            function fnDiarySearchFilterCount(){
                var data={
                    sscp: document.sFrm.sscp.value,
                    sflag: document.sFrm.sflag.value,
                    <% if parentsPage="brand" then %>
                    mkr: document.sFrm.makerid.value,
                    disp: document.sFrm.dispCate.value,
                    <% elseif parentsPage="search" then %>
                    mkr: document.sFrm.mkr.value,
                    disp: document.sFrm.dispCate.value,
                    <% else %>
                    mkr: document.sFrm.mkr.value,
                    disp: document.sFrm.disp.value,
                    <% end if %>
                    arrCate: document.sFrm.arrCate.value,
                    styleCd: document.sFrm.styleCd.value,
                    deliType: document.sFrm.deliType.value,
                    rect: document.sFrm.rect.value,
                    prvtxt: document.sFrm.prvtxt.value,
                    extxt: document.sFrm.extxt.value,
                    rstxt: document.sFrm.rstxt.value,
                    iccd: document.sFrm.iccd.value,
                    attribCd: document.sFrm.attribCd.value
                }
                $.ajax({
                    type:"POST",
                    url:"/diarystory2023/inc/diary_filter_search_count.asp",
                    data: data,
                    dataType: "JSON",
                    success : function(res){
                            if(res!="") {
                                $("#searchResultCount").html(res.searchCount);
                                return false;
                            }
                    },
                    error:function(err){
                        console.log(err)
                        alert("잘못된 접근 입니다.");
                        return false;
                    }
                });
            }
            function setCategoryMainSearchFilterItem() {
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

                // 검색폼에 저장
                document.sFrm.iccd.value=sCCd;
                document.sFrm.styleCd.value=sSCd;
                document.sFrm.attribCd.value=sACd;
                document.sFrm.minPrc.value=iPmn;
                document.sFrm.maxPrc.value=iPmx;
                document.sFrm.deliType.value=sDlv;
                if(document.sFrm.lstDiv.value!="search") document.sFrm.rect.value=sKwd;
            }
        </script>
    <% else %>
        <!-- 비활성화 -->
        <div class="diary2023_filter inactive">
            <div class="float_img">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/filter01_new.png" alt="" class="filter_btn">
                <div class="filter_tooltip">
                    <p class="tooltip hover t01">
                        <a href="" class="btn_close"></a>
                        <a href="/diarystory2023/index.asp" class="btn_daccu"></a>
                    </p>
                    <p class="tooltip click t01">
                        <a href="" class="btn_close"></a>
                        <a href="/diarystory2023/index.asp" class="btn_daccu"></a>
                    </p>
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/filter_notice.png" alt="" class="filter_notice">
                </div>
            </div>
        </div>
        <script>
            $(function(){
                $('.filter_tooltip').css('display','block').delay(15000).fadeOut();

                let isHelpPopupCookie = getPopupCookie("diaryHelpPopupCookie");
                if ( isHelpPopupCookie === "done") {
                    $(".tooltip .t01").hide();
                }
                
                $(".tooltip .t01").click(function() {
                    $(this).show();
                    setHelpPopupCookie();
                })
                // 툴팁 닫기
                $('.filter_tooltip .btn_close').click(function(){
                    $('.filter_tooltip .tooltip').css('display','none');
                    return false;
                })

                // 툴팁 외 클릭시 툴팁 닫기 //
                $('body').on('mouseup', function (e) {
                    if ($('.filter_tooltip .tooltip.click').css('display') == 'block') {
                        if ($('.filter_tooltip .tooltip.click').has(e.target).length == 0) {
                            $('.filter_tooltip .tooltip').css('display','none');
                        }
                    }
                })
                // 툴팁 노출
                // hover
                $('.filter_tooltip').on({
                    mouseenter : function(e){
                        if($('.tooltip.click').css('display') == 'block'){
                            
                        }else{
                            $('.tooltip.hover').css('display','block');
                            $('.tooltip.click').css('display','none');
                        }
                    },
                    mouseleave : function(e){
                        $('.tooltip.hover').css('display','none');
                    },
                })
                // click
                $('.diary2023_filter .filter_notice').click(function(){
                    if($('.tooltip.click').css('display') == 'block' || $('.diary2023_filter_on').css('display') == 'block'){
                        $('.tooltip.click').css('display','none');
                    }else{
                        $('.tooltip.click').css('display','block').delay(15000).fadeOut();
                        $('.tooltip.hover').css('display','none');
                    }
                })
            })
            function setHelpPopupCookie() {
                let cookieName = "diaryHelpPopupCookie";
                document.cookie =  cookieName + "=" + escape( 'done' ) + "; path=/;";
            }
            function getPopupCookie(name) {
                var nameOfCookie = name + "=";  
                var x = 0;  
                while ( x <= document.cookie.length )  
                {  
                    var y = (x+nameOfCookie.length);  
                    if ( document.cookie.substring( x, y ) == nameOfCookie ) {  
                        if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )  
                            endOfCookie = document.cookie.length;  
                        return unescape( document.cookie.substring( y, endOfCookie ) );  
                    }  
                    x = document.cookie.indexOf( " ", x ) + 1;  
                    if ( x == 0 )  
                        break;  
                }  
                return "";  
            }
        </script>
    <% end if %>
<% end if %>
<%
set oGrAtt = Nothing
set oGrClr = Nothing
%>