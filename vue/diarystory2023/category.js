const app = new Vue({
    el: '#app'
    , store : store
    , template : `
        <div class="container diary2023">
            <div id="contentWrap" class="diary2023_category">
                <div class="blur01"></div>
                <div class="blur02"></div>
                <div class="blur03"></div>
                <div class="line01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line03.png?v=2" alt=""></div>
                <div class="line02"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line04.png" alt=""></div>
                <div class="top"></div>
                <div class="content">
                    <div class="section">
                        <div class="section01">
                            <Menu-Component></Menu-Component>
                            
                            <a href="/diarystory2023/index.asp"><div class="sect01_inform">
                                <p>기록의 즐거움<br><span>2023 텐텐다꾸</span></p>
                                <li>추억을 기억하는<br>가장 즐거운 방법!</li>
                            </div></a>
                        </div>
                        <div class="section02">
                            <div class="section02_top"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/note_header.png" alt=""></div>
                            <div class="sect02_list">
                                <div class="cate_top">
                                    <p class="text01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/text01.png" alt=""></p>
                                    <p class="text02">어떻게 기록하고 싶나요?</p>
                                    <p class="line"></p>
                                </div>
                                <div class="cate_list">
                                    <p class="text03">다꾸하며 기록</p>
                                    <div class="cate_wrap">
                                        <p  @click="moveCategory(101102101)">다이어리</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102101101)" href="javascript:void(0)">심플</a></p>
                                            <p><a @click="moveCategory(101102101106)" href="javascript:void(0)">다이어리 커버</a></p>
                                            <p><a @click="moveCategory(101102101109)" href="javascript:void(0)">3공/6공 다이어리</a></p>
                                            <p><a @click="moveCategory(101102101102)" href="javascript:void(0)">일러스트</a></p>
                                            <p><a @click="moveCategory(101102101105)" href="javascript:void(0)">리필속지</a></p>
                                            <p><a @click="moveCategory(101102101104)" href="javascript:void(0)">패턴</a></p>
                                            <p><a @click="moveCategory(101102101103)" href="javascript:void(0)">포토</a></p>
                                            <p><a @click="moveCategory(101102101108)" href="javascript:void(0)">일기장</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101107102)">스티커</p>
                                        <ul>
                                            <p><a @click="moveCategory(101107102101)" href="javascript:void(0)">스티커세트</a></p>
                                            <p><a @click="moveCategory(101107102102)" href="javascript:void(0)">빅 포인트 스티커</a></p>
                                            <p><a @click="moveCategory(101107102103)" href="javascript:void(0)">스몰 데코 스티커</a></p>
                                            <p><a @click="moveCategory(101107102104)" href="javascript:void(0)">손글씨 스티커</a></p>
                                            <p><a @click="moveCategory(101107102105)" href="javascript:void(0)">패턴/그래픽 스티커</a></p>
                                            <p><a @click="moveCategory(101107102106)" href="javascript:void(0)">포토 스티커</a></p>
                                            <p><a @click="moveCategory(101107102107)" href="javascript:void(0)">라벨/인덱스 스티커</a></p>
                                            <p><a @click="moveCategory(101107102111)" href="javascript:void(0)">네임 스티커</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101107101)">스탬프</p>
                                        <ul>
                                            <p><a @click="moveCategory(101107101101)" href="javascript:void(0)">스탬프 세트</a></p>
                                            <p><a @click="moveCategory(101107101102)" href="javascript:void(0)">싱글스탬프</a></p>
                                            <p><a @click="moveCategory(101107101103)" href="javascript:void(0)">잉크 내장 스탬프</a></p>
                                            <p><a @click="moveCategory(101107101104)" href="javascript:void(0)">DIY 스탬프</a></p>
                                            <p><a @click="moveCategory(101107101105)" href="javascript:void(0)">날짜 스탬프</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101107103)">테이프/<br>다이모</p>
                                        <ul>
                                            <p><a @click="moveCategory(101107103101)" href="javascript:void(0)">마스킹 테이프</a></p>
                                            <p><a @click="moveCategory(101107103102)" href="javascript:void(0)">종이 테이프</a></p>
                                            <p><a @click="moveCategory(101107103103)" href="javascript:void(0)">박스 테이프</a></p>
                                            <p><a @click="moveCategory(101107103104)" href="javascript:void(0)">패브릭 테이프</a></p>
                                            <p><a @click="moveCategory(101107103106)" href="javascript:void(0)">레이스 테이프</a></p>
                                            <p><a @click="moveCategory(101107103105)" href="javascript:void(0)">다이모/리필</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101104101)">필기구</p>
                                        <ul>
                                            <p><a @click="moveCategory(101104101105)" href="javascript:void(0)">필기구 세트</a></p>
                                            <p><a @click="moveCategory(101104101102)" href="javascript:void(0)">볼펜</a></p>
                                            <p><a @click="moveCategory(101104101104)" href="javascript:void(0)">색연필</a></p>
                                            <p><a @click="moveCategory(101104101107)" href="javascript:void(0)">형광펜</a></p>
                                            <p><a @click="moveCategory(101104101109)" href="javascript:void(0)">데코펜</a></p>
                                            <p><a @click="moveCategory(101104101108)" href="javascript:void(0)">지워지는 펜</a></p>
                                            <p><a @click="moveCategory(101104101114)" href="javascript:void(0)">네임펜/보드마카</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101103108)">메모지</p>
                                        <ul>
                                            <p><a @click="moveCategory(101103108101)" href="javascript:void(0)">떡메모지</a></p>
                                            <p><a @click="moveCategory(101103108102)" href="javascript:void(0)">접착메모지</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                </div>
                                <div class="cate_list">
                                    <p class="text03">계획, TO-DO 리스트</p>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102103)">스케줄러/<br>플래너</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102103101)" href="javascript:void(0)">스케줄러</a></p>
                                            <p><a @click="moveCategory(101102103102)" href="javascript:void(0)">먼슬리플래너</a></p>
                                            <p><a @click="moveCategory(101102103103)" href="javascript:void(0)">위클리플래너</a></p>
                                            <p><a @click="moveCategory(101102103104)" href="javascript:void(0)">데일리플래너</a></p>
                                            <p><a @click="moveCategory(101102103109)" href="javascript:void(0)">여행플래너</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102104)">달력</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102104101)" href="javascript:void(0)">탁상 달력</a></p>
                                            <p><a @click="moveCategory(101102104102)" href="javascript:void(0)">벽걸이 달력</a></p>
                                            <p><a @click="moveCategory(101102104105)" href="javascript:void(0)">일력</a></p>
                                            <p><a @click="moveCategory(101102104106)" href="javascript:void(0)">포스터/엽서 달력</a></p>
                                            <p><a @click="moveCategory(101102104107)" href="javascript:void(0)">디데이 달력</a></p>
                                            <p><a @click="moveCategory(101102104108)" href="javascript:void(0)">프로젝트 달력</a></p>
                                            <p><a @click="moveCategory(101102104103)" href="javascript:void(0)">스티커 달력</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                </div>
                                <div class="cate_list">
                                    <p class="text03">공부 기록</p>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102103)">스케줄러/<br>플래너</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102103106)" href="javascript:void(0)">스터디 플래너</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                </div>
                                <div class="cate_list">
                                    <p class="text03">가계부, 지출 기록</p>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102103)">스케줄러/<br>플래너</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102103107)" href="javascript:void(0)">가계부</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                </div>
                                <div class="cate_list">
                                    <p class="text03">운동/다이어트 기록</p>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102101)">다이어리</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102101101)" href="javascript:void(0)">심플</a></p>
                                            <p><a @click="moveCategory(101102101102)" href="javascript:void(0)">일러스트</a></p>
                                            <p><a @click="moveCategory(101102101106)" href="javascript:void(0)">다이어리 커버</a></p>
                                            <p><a @click="moveCategory(101102101109)" href="javascript:void(0)">3공/6공 다이어리</a></p>
                                            <p><a @click="moveCategory(101102101105)" href="javascript:void(0)">리필속지</a></p>
                                            <p><a @click="moveCategory(101102101104)" href="javascript:void(0)">패턴</a></p>
                                            <p><a @click="moveCategory(101102101103)" href="javascript:void(0)">포토</a></p>
                                            <p><a @click="moveCategory(101102101108)" href="javascript:void(0)">일기장</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102103)">스케줄러/<br>플래너</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102103101)" href="javascript:void(0)">스케줄러</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102104)">달력</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102104101)" href="javascript:void(0)">탁상 달력</a></p>
                                            <p><a @click="moveCategory(101102104102)" href="javascript:void(0)">벽걸이 달력</a></p>
                                            <p><a @click="moveCategory(101102104105)" href="javascript:void(0)">일력</a></p>
                                            <p><a @click="moveCategory(101102104107)" href="javascript:void(0)">디데이 달력</a></p>
                                            <p><a @click="moveCategory(101102104108)" href="javascript:void(0)">프로젝트 달력</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101106)">포토앨범/<br>레코드북</p>
                                        <ul>
                                            <p><a @click="moveCategory(101106102)" href="javascript:void(0)">폴라로이드 앨범</a></p>
                                            <p><a @click="moveCategory(101106101)" href="javascript:void(0)">앨범</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                </div>
                                <div class="cate_list">
                                    <p class="text03">감상 기록</p>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102101)">다이어리</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102101101)" href="javascript:void(0)">심플</a></p>
                                            <p><a @click="moveCategory(101102101102)" href="javascript:void(0)">일러스트</a></p>
                                            <p><a @click="moveCategory(101102101106)" href="javascript:void(0)">다이어리 커버</a></p>
                                            <p><a @click="moveCategory(101102101109)" href="javascript:void(0)">3공/6공 다이어리</a></p>
                                            <p><a @click="moveCategory(101102101105)" href="javascript:void(0)">리필속지</a></p>
                                            <p><a @click="moveCategory(101102101104)" href="javascript:void(0)">패턴</a></p>
                                            <p><a @click="moveCategory(101102101103)" href="javascript:void(0)">포토</a></p>
                                            <p><a @click="moveCategory(101102101108)" href="javascript:void(0)">일기장</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101106)">포토앨범/<br>레코드북</p>
                                        <ul>
                                            <p><a @click="moveCategory(101106102)" href="javascript:void(0)">폴라로이드 앨범</a></p>
                                            <p><a @click="moveCategory(101106101)" href="javascript:void(0)">앨범</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                </div>
                                <div class="cate_list">
                                    <p class="text03">여행 기록</p>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102103)">스케줄러/<br>플래너</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102103109)" href="javascript:void(0)">여행 플래너</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101106)">포토앨범/<br>레코드북</p>
                                        <ul>
                                            <p><a @click="moveCategory(101106102)" href="javascript:void(0)">폴라로이드 앨범</a></p>
                                            <p><a @click="moveCategory(101106101)" href="javascript:void(0)">앨범</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                </div>
                                <div class="cate_list">
                                    <p class="text03">패드/앱 다이어리</p>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101116)">태블릿 PC 앱 상품</p>
                                        <ul>
                                            <p><a @click="moveCategory(101116101)" href="javascript:void(0)">굿노트/노타빌리티 속지</a></p>
                                            <p><a @click="moveCategory(101116102)" href="javascript:void(0)">굿노트/노타빌리티 스티커</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                </div>
                                <div class="cate_list">
                                    <p class="text03 all">텐바이텐의 모든 아이템</p>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101102)">다이어리/<br>플래너</p>
                                        <ul>
                                            <p><a @click="moveCategory(101102101)" href="javascript:void(0)">다이어리</a></p>
                                            <p><a @click="moveCategory(101102103)" href="javascript:void(0)">스케줄러/플래너</a></p>
                                            <p><a @click="moveCategory(101102104)" href="javascript:void(0)">달력</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101107)">데코레이션</p>
                                        <ul>
                                            <p><a @click="moveCategory(101107102)" href="javascript:void(0)">스티커</a></p>
                                            <p><a @click="moveCategory(101107101)" href="javascript:void(0)">스탬프</a></p>
                                            <p><a @click="moveCategory(101107103)" href="javascript:void(0)">테이프/다이모</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101104)">필기류/<br>필통</p>
                                        <ul>
                                            <p><a @click="moveCategory(101104101)" href="javascript:void(0)">필기구</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101103)">노트/<br>메모지</p>
                                        <ul>
                                            <p><a @click="moveCategory(101103108)" href="javascript:void(0)">메모지</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101106)">포토앨범/<br>레코드북</p>
                                        <ul>
                                            <p><a @click="moveCategory(101106102)" href="javascript:void(0)">폴라로이드 앨범</a></p>
                                            <p><a @click="moveCategory(101106101)" href="javascript:void(0)">앨범</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101110)">파일/<br>바인더</p>
                                        <ul>
                                            <p><a @click="moveCategory(101110111)" href="javascript:void(0)">스티커/포토카드 파일</a></p>
                                        </ul>
                                        <p class="line"></p>
                                    </div>
                                    <div class="cate_wrap">
                                        <p @click="moveCategory(101116)">태블릿 PC 앱 상품</p>
                                        <ul>
                                            <p><a @click="moveCategory(101116101)" href="javascript:void(0)">굿노트/노타빌리티 속지</a></p>
                                            <p><a @click="moveCategory(101116102)" href="javascript:void(0)">굿노트/노타빌리티 스티커</a></p>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <p class="sticker"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/sticker03.png" alt=""></p>
                        </div>
                    </div>
                </div>
                <div class="bottom"></div>
            </div>
        </div>
    `
    , created() {
        this.$nextTick(function() {
            // .content 높이
            sectionHeihgt = $('.diary2023_category .section').innerHeight() - 100;
            $('.diary2023_category .content').css('height', sectionHeihgt);
        });
    }
    , methods : {
        moveCategory(categoryCode) {
            location.href = "/shopping/category_list.asp?disp="+ categoryCode + "&diarystoryitem=R";
            this.send_amplitude("view_category_list", {"category_code" : categoryCode});
        },

        send_amplitude(name, data){
            fnAmplitudeEventActionJsonData(name, JSON.stringify(data));
        }
    }
});