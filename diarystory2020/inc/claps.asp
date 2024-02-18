<%
    'claps
    dim mylikecount : mylikecount = oMedia.getMylikeCount(getEncLoginUserID,vContentsidx)
%>
<div class="clap-wrap">
    <div class="count">1</div>
    <button type="button" class="btn-clap <%=chkiif(oMedia.FOneItem.Flikecount > 0 , "on" , "")%>" onclick="claps('<%=oMedia.FOneItem.Flikecount%>','<%=mylikecount%>','<%=oMedia.FOneItem.Fcidx%>',event);"><i>박수</i><span><%=chkiif(oMedia.FOneItem.Flikecount > 0 , formatnumber(oMedia.FOneItem.Flikecount,0) , "짝짝짝!")%></span></button>
    <div class="point">
        <span class="point-item"></span>
        <span class="point-item"></span>
        <span class="point-item"></span>
        <span class="point-item"></span>
        <span class="point-item"></span>
        <span class="point-item"></span>
        <span class="point-item"></span>
        <span class="point-item"></span>
    </div>
    <input type="hidden" name="claps" value="<%=mylikecount%>">
    <input type="hidden" name="timer" value="">
    <input type="hidden" name="insertcount" value="0">
    <input type="hidden" name="totalcount" value="<%=oMedia.FOneItem.Flikecount%>">
</div>
<script>
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
    }, 400);
    
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