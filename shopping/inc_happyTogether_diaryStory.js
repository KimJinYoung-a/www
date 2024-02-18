(function($){
    // diary story 2019 happy together 2019-09-13 이종화
    
	var json_data = '/shopping/act_happytogether_diaryitems.asp';
    var _data = {};
    var _totalLength;
    var _totalPage; 
    var _sPoint = 0;
    var _ePoint = 4;
    var defaultPageSize = 5;
    var fnDiary = {
        el : function(){
            return $("#rcmdPrd");
        },
        getDiaryData : function(){
            // 비동기로 Data를 전역 변수에 저장함
            $.ajaxSetup({
                async : false
            });
            $.getJSON(json_data, function (data, status, xhr) {
                if (status == 'success') {
                    if (data != ''){
                        console.log('Data OK');
                        var _list = data.diaryitems;
                        _data = _list;
                        _totalLength = _list.length;
                        _totalPage = parseInt(_totalLength/defaultPageSize);
                    }else{
                        console.log('JSON data not Loaded.');
                    }
                } else {
                    console.log('JSON data not Loaded.' + status);
                }
            });
        },
        getTopHtml : function(v,s,t){
            var tophtml;
            tophtml = '<div class="pdtListBoxV17a happy-together">';
			tophtml = tophtml +	'<div class="titWrap">';
			tophtml = tophtml +	'   <h3 class="ftLt"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/tit_diary2019_deco.png?v=1.01" alt="다꾸력을 높이는 데코 아이템" /></h3>';
			tophtml = tophtml +	'   <span class="ftLt" style="line-height:1.7;">하루의 기록을 특별하게! 함께 구매하면 좋을 환상의 짝꿍들</span>';
			tophtml = tophtml +	'	</div>';
			tophtml = tophtml +	'	<div class="itemContainerV17a">';
			tophtml = tophtml +	'		<div class="itemContV15">';
            tophtml = tophtml + '			<ul class="pdtList" id="diaryList">'+ v +'</ul>';
			tophtml = tophtml +	'			<span class="num"><strong id="pgnum">'+ s +'</strong>/'+ t +'</span>';
			tophtml = tophtml +	'			<button type="button" class="btn-prev">이전</button>';
			tophtml = tophtml +	'			<button type="button" class="btn-next">다음</button>';
			tophtml = tophtml +	'		</div>';
			tophtml = tophtml +	'	</div>';
            tophtml = tophtml +	'</div>';
            
            return tophtml;
        },
        getSubHtml : function(v){
            var subhtml;
            var s = v.brandname;
            var im = v.itemname;
            var st = im.length > 14 ? im.substring(0,14)+'..' : im.substring(0,14);

            subhtml = '<li>';
            subhtml = subhtml + '<p class="pdtPhoto"><a href="/shopping/category_prd.asp?itemid='+ v.itemid +'&gaparam=diarystory_related_'+ v.index +'"><img src="'+ v.icon1image +'" alt="'+ im +'" /></a></p>';
            subhtml = subhtml + '<p class="pdtBrand tPad15"><a href="/street/street_brand_sub06.asp?makerid='+ v.makerid +'">'+ s.toUpperCase(); +'</a></p>';
            subhtml = subhtml + '<p class="pdtName tPad05"><a href="/shopping/category_prd.asp?itemid='+ v.itemid +'">'+ st +'</a></p>'; 
            subhtml = subhtml + '<p class="pdtPrice tPad05"><strong>'+ v.totalprice +'</strong>';
            if(v.saleyn ==='Y'){
            subhtml = subhtml + '<strong class="cGr0V15">['+ v.totalsaleper +']</strong></p>';
            }
            subhtml = subhtml + '</li>';

            return subhtml;
        },
        setDataToHtml : function(startPoint , endPoint , current , total ){
            // 저장된 전역 변수 Data를 HTML 바인딩 시킴
            var addEl = new Array();
            var sPoint = startPoint;
            var ePoint = endPoint;
            var cPage = current;
            var tPage = total;

            $.each(_data,function(index){
                if(index >= sPoint && index <= ePoint){
                    addEl += fnDiary.getSubHtml(_data[index]);
                }
            });

            fnDiary.el().html(fnDiary.getTopHtml(addEl,cPage,tPage));
        },
        getNextPageHtml : function(s, e, c , t){
            return fnDiary.setDataToHtml(s, e, c, t);
        }
    }

    // init 
    fnDiary.getDiaryData();

    // first bind
    $(document).ajaxStop(function(){
        fnDiary.setDataToHtml(_sPoint, _ePoint, 1, _totalPage);    
    });

    // button action
    $(document).on('click', function(event){
        var currentPage = parseInt($("#pgnum").text());
        var startPoint = _sPoint;
        var endPoint = _ePoint;
        // nextView
        if($(event.target).attr('class') == 'btn-next'){
            if (currentPage < _totalPage){
                startPoint = parseInt((currentPage*defaultPageSize)); // 5 , 10 , 15 ...
                endPoint = parseInt((currentPage+1)*defaultPageSize)-1; // 9 , 14 , 19 ...
                currentPage += 1;

                fnDiary.getNextPageHtml(startPoint, endPoint, currentPage, _totalPage);
            }
        }

        // preView
        if($(event.target).attr('class') == 'btn-prev'){
            if (currentPage > 1){
                startPoint = parseInt(((currentPage-1)*defaultPageSize)-defaultPageSize); // 0 , 5 , 10 , 15 ...
                endPoint = parseInt((currentPage-1)*defaultPageSize)-1; // 4 , 9 , 14 , 19 ...
                currentPage -= 1;

                fnDiary.getNextPageHtml(startPoint, endPoint, currentPage, _totalPage);
            }
        }
    });
}(jQuery));