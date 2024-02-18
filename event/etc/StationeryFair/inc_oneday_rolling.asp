<%
'####################################################
' Description : MD 텐텐 문구 페어 - 원데이, 롤링배너
' History : 2021-03-02 이전도
'####################################################
%>
<!-- 원데이 -->
<section id="oneday" class="section-oneday">
    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2021/109789/tit_oneday.png" alt="One Day Event"></h3>
    <div class="item">
        <a href="">
            <div class="desc">
                <p class="headline"></p>
                <p class="subcopy"></p>
            </div>
            <div class="thumbnail"><img src="" alt=""></div>
        </a>
    </div>
</section>

<!-- 롤링배너 -->
<section id="rolling_banner" class="section-special">
    <div class="evt-slider">
        <div class="slider"></div>
        <div class="pagination-progressbar"><span class="pagination-progressbar-fill"></span></div>
    </div>
</section>
<script>
    getApiData(apiurl + '/tempEvent/tentenEvent', {
        'brandListMasterIdx' : is_develop ? '2' : '4',
        'deviceType' : 'p',
        'mastercode' : is_develop ? '16' : '19'
    }, data => {
        console.log(data);
        setOneDayHTML(data.oneDay);
        setRollingBannerHTML(data.rolling);
    });

    // Get API DATA
    function getApiData(url, send_data, callback) {
        $.ajax({
            type: "GET",
            data: send_data,
            url: url,
            ContentType: "json",
            crossDomain: true,
            xhrFields: {
                withCredentials: true
            },
            success: callback,
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }
    // 원데이 HTML SET
    function setOneDayHTML(oneDay) {
        const oneday_area = document.getElementById('oneday');
        oneday_area.querySelector('.thumbnail > img').src = decodeBase64(oneDay.imageurl);
        oneday_area.querySelector('.headline').innerHTML = oneDay.titlename;
        oneday_area.querySelector('.subcopy').innerHTML = oneDay.subtitlename;
        oneday_area.querySelector('a').href = decodeBase64(oneDay.linkurl);
    }
    // 롤링배너 HTML SET
    function setRollingBannerHTML(banners) {
        let promise = new Promise((resolve, reject) => {
            const rolling_banner_area = document.getElementById('rolling_banner');
            let bannerHTML = '';

            banners.forEach(banner => {
                bannerHTML += createBannerHTML(banner.evt_code, decodeBase64(banner.bannerImage), banner.evt_name, banner.evt_subname, banner.salePer);
            });
            rolling_banner_area.querySelector('.slider').innerHTML = bannerHTML;

            resolve();
        });

        promise.then(doSwiper)
            .catch(cause => console.log(cause));
    }
    function createBannerHTML(evtCode, imageUrl, evtName, evtSubName, disCount) {
        return `
            <div class="slide-item">
                <a href="/event/eventmain.asp?eventid=${evtCode}">
                    <div class="thumbnail"><img src="${imageUrl}" alt=""></div>
                    <div class="desc">
                        <p class="headline">${evtName}</p>
                        <p class="subcopy">${evtSubName}</p>
                        <p class="discount">${disCount > 0 ? '~'+disCount+'%' : ''}</p>
                    </div>
                </a>
            </div>
        `;
    }

    // 슬라이드
    function doSwiper() {
        var evtSlider = $('.stationery-fair .evt-slider');
        var slick = evtSlider.find('.slider');
        var amt = slick.find('.slide-item').length;
        var progress = evtSlider.find('.pagination-progressbar-fill');
        if (amt > 1) {
            slick.on('init', function(){
                var init = (1 / amt).toFixed(2);
                progress.css('transform', 'scaleX(' + init + ')');
            });
            slick.on('beforeChange', function(event, slick, currentSlide, nextSlide){
                var calc = ( (nextSlide+1) / slick.slideCount ).toFixed(2);
                progress.css('transform', 'scaleX(' + calc + ')');
            });
            slick.slick({
                autoplay: true,
                arrows: true,
                speed: 750,
            });
        } else {
            evtSlider.find('.pagination-progressbar').hide();
        }
    }
    // 디코딩
    function decodeBase64(str) {
        if( str == null ) return null;
        return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
    }
</script>