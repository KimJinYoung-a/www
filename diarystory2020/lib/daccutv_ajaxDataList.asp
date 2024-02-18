<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/media/mediaCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
    Dim vCurrPage , vSortMet
    dim oTenfluencer , i

	vCurrPage = RequestCheckVar(Request("cpg"),5)
    vSortMet = RequestCheckVar(request("sortMet"),1)

	If vCurrPage = "" Then vCurrPage = 1

    If vSortMet = "" or vSortMet = "1" then 
        vSortMet = "NEW"
    else
        vSortMet = "BEST"
    end if 

    SET oTenfluencer = new MediaCls	
        oTenfluencer.FPageSize = 9
        oTenfluencer.FCurrPage = vCurrPage
        oTenfluencer.FrectServiceCode = 3 '// tenfluencer
        oTenfluencer.FrectGroupCode	= ""
        oTenfluencer.FrectSortMet = vSortMet
        oTenfluencer.FrectListType = "A"
        oTenfluencer.FrectUserId = getEncLoginUserID()
        oTenfluencer.getContentsPageListProc
    
    If (oTenfluencer.FResultCount > 0) then 
    For i = 0 to oTenfluencer.FResultCount - 1 
        If (NOT IsEmpty(oTenfluencer.FItemList(i))) AND (NOT IsNull(oTenfluencer.FItemList(i))) then
%>
<li>
    <a href="" onclick="goDetail('<%=oTenfluencer.FItemList(i).Fcidx%>');return false;">
        <div class="thumbnail"><img src="<%=oTenfluencer.FItemList(i).Fmainimage%>" alt=""><% if datediff("d", oTenfluencer.FItemList(i).Fstartdate, date()) < 3 then %><span class="badge">NEW</span><% end if %></div>
        <div class="desc">
            <p class="headline"><%=oTenfluencer.FItemList(i).Fctitle%></p>
            <p class="subcopy"><%=oTenfluencer.FItemList(i).Fgroupname%></p>
        </div>
    </a>
    <% if vCurrPage = 1 and i = 0 then %>
    <div class="guide-clap">마음에 드는 영상이라면 박수를 짝짝짝!<br>박수는 최대 30번까지 칠 수 있어요!</div>
    <% end if %>
    <div class="clap-wrap">
        <div class="count">1</div>
        <button type="button" class="btn-clap" <%=chkiif(oTenfluencer.FItemList(i).Flikecount > 0 , "on" , "")%>" onclick="claps('<%=oTenfluencer.FItemList(i).Flikecount%>','<%=oTenfluencer.FItemList(i).Fmylikecount%>','<%=oTenfluencer.FItemList(i).Fcidx%>',event);"><i>박수</i><span><%=chkiif(oTenfluencer.FItemList(i).Flikecount > 0 , formatnumber(oTenfluencer.FItemList(i).Flikecount,0) , "짝짝짝!")%></span></button>
        <input type="hidden" name="claps" value="<%=oTenfluencer.FItemList(i).Fmylikecount%>">
        <input type="hidden" name="timer" value="">
        <input type="hidden" name="insertcount" value="0">
        <input type="hidden" name="totalcount" value="<%=oTenfluencer.FItemList(i).Flikecount%>">
    </div>
</li>
<%
        End if
    Next
%>
<script>
function goDetail(contentsIdx) {
    // view count
    setViewCount(contentsIdx);
    setTimeout(function(){
        location.href = "/diarystory2020/daccutv_detail.asp?cidx="+contentsIdx;
    }, 300);
}

function setViewCount(contentsIdx) {
    var data_likeCount = "/apps/webapi/media/setContentsViewCount.asp";
    var _data = {cidx : contentsIdx , device : 'W'};
    var _url = data_likeCount+'?json='+JSON.stringify(_data);
    $.ajax({
        type: "POST",
        url: _url,
        async : true,
        contentType:"application/json; charset=utf-8",
        dataType: "json",
    });
}

function claps(nowLikeCount, mylikeCount, contentsIdx, event) {
    $(".guide-clap").fadeOut(200);
    // doubleclick 해제
    $(document).unbind("dblclick").dblclick(function () {});

    // chechlogin
    jsChklogin('<%=IsUserLoginOK%>');
    <% if not(IsUserLoginOK) then %>
        return false;
    <% end if %>

    // targer element 
    var el = event.currentTarget;
    ($(el).hasClass('on')) ? '' : $(el).addClass('on'); // 박수 유무 추가
    var $parent = $(el).parent(".clap-wrap");
    var clickCount = $parent.find("input[name='claps']").val(); // 박수 카운트 (기본 나의 카운트)
    var timer = $parent.find("input[name='timer']").val(); // debounce 용 타이머 기본 값
    var insertCount = $parent.find("input[name='insertcount']").val(); // 지금부터 누를 박수 카운트
    var totalCount = $parent.find("input[name='totalcount']").val(); // 데이터 전체 카운트

    // 추가
    var point = "<div class='point'><span class='point-item'></span><span class='point-item'></span><span class='point-item'></span><span class='point-item'></span><span class='point-item'></span><span class='point-item'></span><span class='point-item'></span><span class='point-item'></span></div>";
    $(el).siblings(".point").remove();
    $parent.append(point);
    // 추가

    // Max Like Count
    if (maxLikeCountCheck(mylikeCount , clickCount)) {
        return false;
    }

    // 카운트 증가 후 대입
    clickCount++; // 나의 클릭 값
    insertCount++; // 데이터 넘길 값
    totalCount++; // 전체 카운트
    $parent.find("input[name='claps']").val(clickCount);
    $parent.find("input[name='insertcount']").val(insertCount);
    $parent.find("input[name='totalcount']").val(totalCount);
    $parent.find(".count").text(clickCount);
    $parent.find("span").eq(0).text(totalCount);

    // UI 변화
    $parent.addClass("is-touched");
    setTimeout(function(){
        $parent.removeClass("is-touched");
    }, 300);
    
    // debounce 구현
    if (timer) {
        clearTimeout(timer);
    }

    timer = setTimeout(function() {
        // ajax 영역
        var nowDataCount = $parent.find("input[name='insertcount']").val();
        setLikeCount(nowDataCount,contentsIdx);
        $parent.find("input[name='insertcount']").val(0);
        maxLikeCountCheck(mylikeCount , clickCount);
    }, 1500);

    // 타이머 초기
    $parent.find("input[name='timer']").val(timer);    
}

function maxLikeCountCheck(myLikeCount , clickCount) {
    if (myLikeCount >= 30 || clickCount >= 30) {
        $(".ly-clap").delay(300).show(0).delay(2100).hide(0);
        return true;
    } else {
        return false;
    }
}

function setLikeCount(clickCount,contentsIdx) {
    var data_likeCount = "/apps/webapi/media/setContentsLikeCount.asp";
    var _data = {cidx : contentsIdx , device : 'W' , clickcount : clickCount};
    var _url = data_likeCount+'?json='+JSON.stringify(_data);
    $.ajax({
        type: "POST",
        url: _url,
        async : true,
        contentType:"application/json; charset=utf-8",
        dataType: "json",
    });
}
</script>
<%
    End if
    SET oTenfluencer = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->