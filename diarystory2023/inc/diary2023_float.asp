<%
dim diaryStoryCheck2
If now() >= #2022-09-01 00:00:00# and now() < #2023-02-01 00:00:00# Then
    diaryStoryCheck2 = True
elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" then
    diaryStoryCheck2 = True
else
    diaryStoryCheck2 = False
end if
if diaryStoryCheck2 then

if parentsPage="" then parentsPage="today"
if parentsPage="categoryList" or parentsPage="categoryMain" then parentsPage="category"
%>
<style>
    .diary2023_float{width:160px; height:128px; position:fixed; z-index:1001; bottom:40px; right:50%; margin-right:-630px;}
    .diary2023_float .float_img img{width:100px; height:100px; display:none; margin:0 auto;}
    .diary2023_float .float_img img.active{display:block;}
    .diary2023_float .float_close{height:20px; box-sizing:border-box; bottom:0; left:50%; transform:translateX(-50%); position:absolute; background:#fff; border-radius:50px; font-size:11px; line-height:13.2px; font-weight:600; padding:4px 8px; align-items:center;}
    .diary2023_float .float_close.on{height:20px; box-sizing:border-box; bottom:0; left:50%; transform:translateX(-50%); position:absolute; background:#fff; border-radius:50px; display:flex; flex-wrap:nowrap; font-size:11px; line-height:13.2px; font-weight:600; padding:4px 8px; align-items:center;}
    .diary2023_float .float_close img{width:12px; height:12px; margin-left:2px; vertical-align:top;}
    .diary2023_float .float_close01{white-space:nowrap;}
    .diary2023_float .float_close02{white-space:nowrap; position:relative; margin-left:12.5px; display:none;}
    .diary2023_float .float_close02::before{position:absolute; left:-6px; content:''; background:#ccc; width:0.5px; height:12px; top:50%; transform:translateY(-50%);}
    .diary2023_float .float_close02.on{display:block;}
</style>
<div class="diary2023_float">
    <a href="" onclick="fnDiaryStoryBannerLink();return false;">
        <div class="float_img">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/float_new.png?v=2" alt="" class="float01 active">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/float02.png?v=1.3" alt="" class="float02">
        </div>
    </a>
    <div class="float_close">
        <a href="" onclick="fnClose1DayDiaryStoryBanner();return false;"><p class="float_close01">닫기<img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/close03.png" alt=""></p></a>
        <a href="" onclick="fnClose15DayDiaryStoryBanner();return false;"><p class="float_close02">15일간 보지않기<img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/close03.png" alt=""></p></a>
    </div>
</div>

<script>
    $(function(){
        // $('.diary2023_float .float_img').mouseenter(function(e){
        //     $(this).find('img').removeClass('active').eq(1).addClass('active');
        // }).mouseleave(function(e){
        //     $(this).find('img').removeClass('active').eq(0).addClass('active');
        // })
        $('.diary2023_float .float_close').mouseenter(function(e){
            $(this).addClass('on');
            $(this).find('.float_close02').addClass('on');
        }).mouseleave(function(e){
            $(this).removeClass('on');
            $(this).find('.float_close02').removeClass('on');
        })
        mainDiaryBanner();
    })
    function fnClose15DayDiaryStoryBanner(){
        setDiaryBannerCookie("diaryStoryFloatingBannerCookie", "done", 15);
        $(".diary2023_float").hide();
        fnAmplitudeEventMultiPropertiesAction('close_diarystory_banner','place','<%=parentsPage%>');
    }
    function fnClose1DayDiaryStoryBanner(){
        setDiaryBannerCookie("diaryStoryFloatingBannerCookie", "done", 1);
        $(".diary2023_float").hide();
        fnAmplitudeEventMultiPropertiesAction('close_diarystory_banner','place','<%=parentsPage%>');
    }
    function fnDiaryStoryBannerLink(){
        fnAmplitudeEventMultiPropertiesAction('click_diarystory_banner','place','<%=parentsPage%>');
        setTimeout(location.href="/diarystory2023/index.asp",1000);
    }
    // 쿠키 가져오기
    function getPopupCookie( name ) {
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
    function setDiaryBannerCookie( name, value, expiredays ) {
        var todayDate = new Date();
        todayDate.setDate( todayDate.getDate() + expiredays );
        document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    }
    function mainDiaryBanner(){//팝업띄우기		
        var popCookie = getPopupCookie("diaryStoryFloatingBannerCookie");
        if(!popCookie){			
            $(".diary2023_float").show();
        }
    }
</script>
<% end if %>