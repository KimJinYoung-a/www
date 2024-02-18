<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 
' History : 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/infinitegrid.gridlayout.min.js"></script>
<script type="text/javascript">
$(function(){
    //search
    $('.auto-search').append('<div id="dimed"></div>')
    $('.input-area .btn-delete,.input-area span').click(function(e){
        $(this).parent('.input-area').hide();
        $('.input-area.after').show();
        $('#dimed').show();
        return false;
    });

    //dropDown
    $('.dropDown ul').hide()
    $('.dropDown').click(function(e){
        if ($(this).hasClass('on')){
            $(this).removeClass('on').find('ul').hide()
            $('#dimed').hide();
        }
        else{
            $('.dropDown').removeClass('on').find('ul').hide()
            $(this).addClass('on').find('ul').slideDown(300)
            $('#dimed').show();
        }
        return false;
    });

    $('.dropDown ul li').click(function(e){
        $(this).toggleClass('on');
        return false;
    })
    //recommend
    $('.slide1').slick({
        variableWidth: true,
        slidesToScroll:4,
        arrows: false,
    });
    $('.recommend-word .btn-delete').click(function(e){
        $(this).parent('li').fadeOut(100)
        return false;
    });

    $('#dimed').click(function(){
        $('.input-area.before').show();
        $('.input-area.after').hide();
        $('.dropDown').removeClass('on').find('ul').hide()
        $('#dimed').hide();
    });

    $('.btn-wish').click(function(){
        $(this).toggleClass('on');
    })

    //스타일
    $(window).scroll(function() {
        var st=$(this).scrollTop();
        var wh=window.innerHeight;
        $('.label-black').each(function(){
            if(st>$(this).offset().top-wh&& $(this).offset().top+$(this).innerHeight()>st){
                $(this).addClass('on')
            }else{
                $(this).removeClass('on')
            }
        })
    })

    htmlRender();
});

function htmlRender() {
    $.ajax({
		type: "GET",
		url: "/search/beta/itemlist.asp",
        success: function(Data){
            var el = $("#grid");
            el.find('li').length == 0 ? el.html(Data) : el.append(Data);

            //unit
            var ig = new eg.InfiniteGrid("#grid", {
                isConstantSize: true,
                transitionDuration: 0.2,
            });
            ig.setLayout(eg.InfiniteGrid.GridLayout, {align: "center", margin: 30});
            ig.layout(true);
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.')
        }
	})
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
    <div class="container auto-search">
        <div class="search-area">
            <div class="inner">
                <div class="form">
                    <div class="input-area before"><!-- for dev msg: 검색 전 -->
                        <span>선풍기</span>
                        <a href="" class="btn-delete"><i class="icoV19 ico-delete">삭제</i></a>
                    </div>    
                    <div class="input-area after" style="display: none"><!-- for dev msg: 검색어 변경 시 -->
                        <input title="검색어 입력" value="" placeholder="검색어를 입력해주세요"/>
                    </div>
                    <div class="ftRt">
                        <button type="button" class="btn btn-add">추가 검색</button>
                        <button type="button" class="btn btn-search">검색</button>
                    </div>
                </div>
                <div class="relation"><!-- for dev msg: 4개까지만 나오게 -->
                    <a href="" class="btn color-redV19">일이삼사오육칠팔구십</a>
                    <a href="" class="btn color-redV19">하우스레시피캐리백</a>
                    <a href="" class="btn color-redV19">마이리</a>
                    <a href="" class="btn color-redV19">일정관리캘린더</a>
                </div>
            </div>
        </div>
        <div class="fillter-area"> 
            <div class="ship dropDown">
                <p class="current">
                    배송옵션
                    <span>2</span><!-- for dev msg: 해당 필터 선택된 옵션 수 -->
                    <i class="icoV19  ico-down">더보기</i>
                </p>
                <ul>
                    <li><a href="">텐텐배송</a></li>
                    <li><a href="">텐바이텐 배송</a></li>
                    <li class="on"><a href="">무료배송</a></li>
                    <li><a href="">바로배송</a></li>
                    <li class="on"><a href="">해외직구</a></li>
                    <li><a href="">해외배송</a></li>
                </ul>
            </div>
            <div class="benefit dropDown">
                <p class="current">
                    혜택
                    <span>1</span>
                    <i class="icoV19  ico-down">더보기</i>
                </p>
                <ul>
                    <li><a href="">옵션1</a></li>
                    <li><a href="">옵션1</a></li>
                    <li class="on"><a href="">옵션1</a></li>
                    <li><a href="">옵션1</a></li>
                    <li><a href="">옵션1</a></li>
                </ul>
            </div>
            <div class="color dropDown">
                <p class="current">
                    컬러
                    <i class="icoV19  ico-down">더보기</i>
                </p>
                <ul>
                    <li><a href="">옵션1</a></li>
                    <li><a href="">옵션1</a></li>
                    <li><a href="">옵션1</a></li>
                    <li><a href="">옵션1</a></li>
                    <li><a href="">옵션1</a></li>
                </ul>
            </div>
            <div class="recommend-word">
                <ul class="slide1">
                    <li>
                        <span>써큘레이터</span>
                        <a href="" class="btn-delete"><i class="icoV19 ico-delete-white">삭제</i></a>
                    </li>
                    <li>
                        <span>에어서큘레</span>
                        <a href="" class="btn-delete"><i class="icoV19 ico-delete-white">삭제</i></a>
                    </li>
                    <li>
                        <span>신일광고에나오는</span>
                        <a href="" class="btn-delete"><i class="icoV19 ico-delete-white">삭제</i></a>
                    </li>
                    <li>
                        <span>바람풍</span>
                        <a href="" class="btn-delete"><i class="icoV19 ico-delete-white">삭제</i></a>
                    </li>
                    <li>
                        <span>동서남북자유자제</span>
                        <a href="" class="btn-delete"><i class="icoV19 ico-delete-white">삭제</i></a>
                    </li>
                    <li>
                        <span>제멋대로돌아가는</span>
                        <a href="" class="btn-delete"><i class="icoV19 ico-delete-white">삭제</i></a>
                    </li>
                    <li>
                        <span>시원한바람나오는기가막힌</span>
                        <a href="" class="btn-delete"><i class="icoV19 ico-delete-white">삭제</i></a>
                    </li>
                </ul>
            </div>
            <p class="txt-result"><span class="color-redV19">1,658</span>개의 검색결과</p>
        </div>
        <div class="unit-area">
            <ul id="grid"></ul>
        </div>
        <div class="search-area"><button onClick="htmlRender()">더보기</button></div>
    </div>
    
    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>