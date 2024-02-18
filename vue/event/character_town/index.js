const app = new Vue({
    el: '#app'
    , store : store
    , template : `
    <div class="evt118301">
    <div class="topic">
        <img src="//webimage.10x10.co.kr/fixevent/event/2022/118301/main.jpg" alt="텐텐 스페이스">
    </div>
    <div class="tab-area">
        <div class="content">
            <ul>
                <li>
                    <a href="#sec01">
                        <div class="img"></div>
                        <div class="tit">산리오 행성</div>
                    </a>
                </li>
                <li>
                    <a href="#sec05">
                        <div class="img"></div>
                        <div class="tit">유니버셜 별</div>
                    </a>
                </li>
                <li>
                    <a href="#sec02">
                        <div class="img"></div>
                        <div class="tit">디즈니 행성</div>
                    </a>
                </li>
                <li>
                    <a href="#sec03">
                        <div class="img"></div>
                        <div class="tit">피너츠 별</div>
                    </a>
                </li>
                <li>
                    <a href="#sec04">
                        <div class="img"></div>
                        <div class="tit">카카오 행성</div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <!-- 가격연동 -->
    <div id="sec01" class="content section01">
        <div class="headline">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118301/info_sec01.png" alt="산리오 캐릭터즈">
        </div>
        <!-- 가격연동 -->
        <!-- 상품코드  4211653,4409965,3673690,4276979,4213435,4332787,4023002,3673695 -->
        <div class="prd-list">
            <ul id="itemlist01" class="item_list">
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4409955&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4409955" onclick="fnWishAdd('4409955');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4459573&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4459573" onclick="fnWishAdd('4459573');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4313525&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4313525" onclick="fnWishAdd('4313525');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3664921&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3664921" onclick="fnWishAdd('3664921');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4409965&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4409965" onclick="fnWishAdd('4409965');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3917796&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3917796" onclick="fnWishAdd('3917796');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4171151&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4171151" onclick="fnWishAdd('4171151');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3873462&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3873462" onclick="fnWishAdd('3873462');"></div>
                </li>
            </ul>
        </div>
        <div class="line"></div>
    </div>

    <div id="sec05" class="content section05">
        <div class="headline">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118301/info_sec05.png" alt="유니버셜">
        </div>
        <!-- 가격연동 -->
        <!-- 상품코드  4634336,4690791,4652951,4637626,4714029,4703045,4375217,4692969 -->
        <div class="prd-list">
            <ul id="itemlist05" class="item_list">
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4634336&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span class="sale">10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id=""></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4690791&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span class="sale">10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id=""></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4652951&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span class="sale">10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id=""></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4637626&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span class="sale">10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id=""></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4714029&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span class="sale">10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id=""></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4703045&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span class="sale">10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id=""></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4375217&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span class="sale">10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id=""></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4692969&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span class="sale">10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id=""></div>
                </li>
            </ul>
        </div>
        <div class="line"></div>
    </div>

    <div id="sec02" class="content section02">
        <div class="headline">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118301/info_sec02.png" alt="디즈니">
        </div>
        <!-- 가격연동 -->
        <!-- 상품코드  3646836,4439877,3734247,4470614,3799777,3523267,2584266,3734283,3734302,3754987,3166588 -->
        <div class="prd-list">
            <ul id="itemlist02" class="item_list">
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3523267&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3523267" onclick="fnWishAdd('3523267');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=2310094&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish2310094" onclick="fnWishAdd('2310094');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3901510&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3901510" onclick="fnWishAdd('3901510');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4509635&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4509635" onclick="fnWishAdd('4509635');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3504305&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3504305" onclick="fnWishAdd('3504305');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3646836&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3646836" onclick="fnWishAdd('3646836');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3678978&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3678978" onclick="fnWishAdd('3678978');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3166588&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3166588" onclick="fnWishAdd('3166588');"></div>
                </li>
                <!-- <li>
                    <a href="/shopping/category_prd.asp?itemid=3734302&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3734302" onclick="fnWishAdd('3734302');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3754987&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3754987" onclick="fnWishAdd('3754987');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3166588&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3166588" onclick="fnWishAdd('3166588');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3679249&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3679249" onclick="fnWishAdd('3679249');"></div>
                </li> -->
            </ul>
        </div>
        <div class="line"></div>
    </div>
    <div id="sec03" class="content section03">
        <div class="headline">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118301/info_sec03.png" alt="피너츠">
        </div>
        <!-- 가격연동 -->
        <!-- 상품코드  4460500,3313868,4169194,3471382,4013666 -->
        <div class="prd-list">
            <ul id="itemlist03" class="item_list">
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4619540&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4619540" onclick="fnWishAdd('4619540');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4460500&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4460500" onclick="fnWishAdd('4460500');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3947424&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3947424" onclick="fnWishAdd('3947424');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3313868&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3313868" onclick="fnWishAdd('3313868');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=2784156&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish2784156" onclick="fnWishAdd('2784156');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4013666&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4013666" onclick="fnWishAdd('4013666');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4084296&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4084296" onclick="fnWishAdd('4084296');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3471382&pEtr=118301">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3471382" onclick="fnWishAdd('3471382');"></div>
                </li>
            </ul>
        </div>
        <div class="line"></div>
    </div>
    <div id="sec04" class="content section04">
        <div class="headline">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118301/info_sec04.png" alt="카카오프렌즈">
        </div>
        <!-- 가격연동 -->
        <!-- 상품코드  3943252,4408723,4210015,4166689 -->
        <div class="prd-list">
            <ul id="itemlist04" class="item_list">
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4636866&pEtr=108947">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4636866" onclick="fnWishAdd('4636866');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4119610&pEtr=108947">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4119610" onclick="fnWishAdd('4119610');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4028533&pEtr=108947">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4028533" onclick="fnWishAdd('4028533');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4080406&pEtr=108947">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4080406" onclick="fnWishAdd('4080406');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=3747619&pEtr=108947">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish3747619" onclick="fnWishAdd('3747619');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4286983&pEtr=108947">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4286983" onclick="fnWishAdd('4286983');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=2967378&pEtr=108947">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish2967378" onclick="fnWishAdd('2967378');"></div>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=4476609&pEtr=108947">
                        <div class="thumbnail"><img src="" alt=""></div>
                        <div class="desc">
                        <div class="name">아이코닉 마일드 젤펜 0.38</div>
                        <div class="price"><s>1,800</s> 1,620<span>10%</span></div></div>
                    </a>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                    </div>
                    <div class="wish" id="wish4476609" onclick="fnWishAdd('4476609');"></div>
                </li>
            </ul>
        </div>
    </div>
    <!-- // -->
    <div class="scroll-tab">
        <div class="tab-wrap">
            <div class="tab-brand">
                <div class="prdtitswiper content">
                    <div class="swiper-wrapper">
                        <div v-for="(item, index) in parents_evtgroup" @click="show_tab_item('parents', item)" :class="['swiper-slide', 'brand'+index, active_parents_evtgroup == item.evtgroup_code ? 'on' : '']"><span>{{item.evtgroup_desc}}</span></div>
                    </div>
                </div>
            </div>
            <div class="tab-category">
                <div class="category-list content category01">
                    <div class="prdlistswiper">
                        <div class="swiper-wrapper">
                            <div v-for="item in child_evtgroup" @click="show_tab_item('child', item)" :class="['swiper-slide', active_child_evtgroup == item.evtgroup_code ? 'on' : '']"><span>{{item.evtgroup_desc}}</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 기차 상품 -->
        <div class="prd-bottom-list">
            <h2 id="prdList01">{{active_evtgroup_name}}</h2>
            <div class="content">
                <div class="prd-list">
                    <ul id="itemList" class="item_list"></ul>
                    <div class="btn-more">
                        <button v-if="last_page > page" @click="show_more" type="button"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118301/btn_more.png" alt="제품 더 보기"></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    `
    , created() {
        const _this = this;
        //this.$store.commit("SET_EVT_CODE", this.get_url_param("eventid"));
        this.$store.commit("SET_EVT_CODE", 118301);
        this.$store.dispatch("GET_PARENTS_EVTGROUP");

        this.$nextTick(function() {
            var swiper = new Swiper(".prdtitswiper", {
                slidesPerView:'auto',
            });
            var swiper = new Swiper(".prdlistswiper", {
                slidesPerView:'auto',
            });

            /* scroll 이벤트 */
            $(window).scroll(function(){
                var header = $('#header').outerHeight();
                var tabHeight = $('.tab-area').outerHeight();
                var fixHeight = tabHeight + header;
                var st = $(this).scrollTop();
                var scrollTab = $('.scroll-tab').offset().top;
                var secondTab = $('.tab-wrap').offset().top;
                var startFix = $('.section01').offset().top - fixHeight;
                if(st > startFix) {
                    $('.tab-area').addClass('fixed').css('top',header)
                } else {
                    $('.tab-area').removeClass('fixed')
                }

                if(st > scrollTab - fixHeight) {
                    $('.tab-area').css('display','none');
                    $('.tab-wrap').addClass('fixed').css('top',header)
                    $('.prd-bottom-list').addClass('on');
                } else {
                    $('.tab-area').css('display','inherit');
                    $('.tab-wrap').removeClass('fixed');
                    $('.prd-bottom-list').removeClass('on');
                }

                //스크롤시 특정위치서 탭 활성화
                var scrollPos = $(document).scrollTop();
                $('.tab-area a').each(function () {
                    var currLink = $(this);
                    var refElement = $(currLink.attr("href"));
                    if (refElement.position().top <= scrollPos + 100 && refElement.position().top + refElement.height() >= scrollPos + 100) {
                        $('.tab-area a').removeClass("on");
                        
                        currLink.addClass("on");
                    }
                    else{
                        currLink.removeClass("on");
                    }
                });
            });

            /* tab-area 활성화 */
            $('.tab-area li').on('click',function(){
                if($('.tab-area li').hasClass('on')) {
                    $('.tab-area li').removeClass('on')
                    $(this).addClass('on')
                } else {
                    $(this).addClass('on')
                    $('.tab-area li').removeClass('on')
                }
            });
            /* link smooth 이동 */
            $('.tab-area').on('click', 'a[href^="#"]', function (event) {
                var tabHeight = $('.tab-area').outerHeight();
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: $($.attr(this, 'href')).offset().top - tabHeight
                }, 500);
            });

            /* 가격연동 */
             fnApplyItemInfoList({
                items:"4409955,4459573,4313525,3664921,4409965,3917796,4171151,3873462",
                target:"itemlist01",
                fields:["price","sale","image","name","wish","evaluate"],
                unit:"none",
                saleBracket:false
            });
            fnApplyItemInfoList({
                items:"3523267,2310094,3901510,4509635,3504305,3646836,3678978,3166588",
                target:"itemlist02",
                fields:["price","sale","image","name","wish","evaluate"],
                unit:"none",
                saleBracket:false
            });
            fnApplyItemInfoList({
                items:"4619540,4460500,3947424,3313868,2784156,4013666,4084296,3471382",
                target:"itemlist03",
                fields:["price","sale","image","name","wish","evaluate"],
                unit:"none",
                saleBracket:false
            });
            fnApplyItemInfoList({
                items:"4636866,4119610,4028533,4080406,3747619,4286983,2967378,4476609",
                target:"itemlist04",
                fields:["price","sale","image","name","wish","evaluate"],
                unit:"none",
                saleBracket:false
            });
            fnApplyItemInfoList({
                items:"4634336,4690791,4652951,4637626,4714029,4703045,4375217,4692969",
                target:"itemlist05",
                fields:["price","sale","image","name","wish","evaluate"],
                unit:"none",
                saleBracket:false
            });
        });
    }
    , mounted(){
        const _this = this;
    }
    , computed : {
        evt_code(){
            return this.$store.getters.evt_code;
        }
        , page(){
            return this.$store.getters.page;
        }
        , event_item(){
            return this.$store.getters.event_item;
        }
        , last_page(){
            return this.$store.getters.last_page;
        }
        , evtgroup_code(){
            return this.$store.getters.evtgroup_code;
        }
        , evtgroup_index(){
            return this.$store.getters.evtgroup_index;
        }
        ,parents_evtgroup(){
            return this.$store.getters.parents_evtgroup;
        }
        , child_evtgroup(){
            return this.$store.getters.child_evtgroup;
        }
    }
    , data(){
        return {
            is_saving : false
            , active_parents_evtgroup : 0
            , active_child_evtgroup : 0
            , active_evtgroup_name : ""
        }
    }
    , methods : {
        format_price(price){
            if(price){
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }
        , get_url_param(param_name){
            let now_url = location.search.substr(location.search.indexOf("?") + 1);
            now_url = now_url.split("&");
            let result = "";
            for(let i = 0; i < now_url.length; i++){
                let temp_param = now_url[i].split("=");
                if(temp_param[0] == param_name){
                    result = temp_param[1].replace("%20", " ");
                }
            }

            return result;
        }
        , show_tab_item(type, item){
            var tabWrapHeight = $('.tab-wrap').outerHeight() + 100;
            $('html, body').animate({
                scrollTop: $('#prdList01').offset().top - tabWrapHeight
            }, 500);

            if(type == "parents"){
                this.active_parents_evtgroup = item.evtgroup_code;
                this.$store.commit("SET_PAGE", 1);
                this.$store.dispatch("GET_CHILD_EVTGROUP", item.evtgroup_code);
                this.active_child_evtgroup = 0;
            }else{
                this.active_child_evtgroup = item.evtgroup_code;
                this.$store.commit("SET_EVTGROUP_CODE", item.evtgroup_code);
                this.$store.commit("SET_PAGE", 1);
                this.$store.dispatch("GET_EVENT_ITEM");
            }

            this.active_evtgroup_name = item.evtgroup_desc;
        }
        , show_more(){
            this.$store.commit("SET_PAGE", this.page + 1);
            this.$store.dispatch("GET_EVENT_ITEM");
        }
    }
    , watch : {

    }
});