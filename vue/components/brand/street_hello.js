Vue.component("BRAND-HELLO", {
    template: `
        <!-- ABOUT BRAND-->
        <div class="aboutBrandV15">
            <div class="wFixV15">
                <h4>ABOUT BRAND</h4>
                <div class="brandInfoV15">
                    <span class="arrow"></span>
                    <dl class="aboutContV15 tPad0">
                        <dt><img src="http://fiximage.10x10.co.kr/web2015/brand/tit_design_is.png" alt="DESIGN IS"></dt>
                        <dd>
                            <p><dfn><strong>{{street_hello.designis}}</strong></dfn></p>
                        </dd>
                    </dl>
                    <dl class="aboutContV15">
                        <dt><img src="http://fiximage.10x10.co.kr/web2015/brand/tit_brand_story.png" alt="BRAND STORY"></dt>
                        <dd>
                            <p><dfn><strong>{{street_hello.storyTitle}}</strong></dfn></p>
                            <p class="tPad03">{{street_hello.storyContent}}</p>
                        </dd>
                    </dl>
                    <dl class="aboutContV15">
                        <dt><img src="http://fiximage.10x10.co.kr/web2015/brand/tit_philosophy.png" alt="PHILOSOPHY"></dt>
                        <dd>
                            <p><dfn><strong>{{street_hello.philosophyTitle}}</strong></dfn></p>
                            <p class="tPad03">{{street_hello.philosophyContent}}</p>
                        </dd>
                    </dl>
                    <div class="aboutContV15 brandGuideV15">
                        <dl v-if="street_hello.brandTagList" class="tagView">
                            <dt>BRAND TAG</dt>
                            <dd>
                                <ul>
                                    <li v-for="item in street_hello.brandTagList">
                                        <span>
                                            <a :href="'/street/index.asp?paraTxt=' + item">{{item}}</a>
                                        </span>
                                    </li>
                                </ul>
                            </dd>
                        </dl>
                        <dl v-if="street_hello.samebrandList">
                            <dt>SIMILAR BRAND</dt>
                            <dd class="similarV15">
                                <div v-for="item in street_hello.samebrandList">
                                    <a :href="'/street/street_brand.asp?makerid=' + item">{{item}}</a> /
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <button class="closeLayer"><img src="http://fiximage.10x10.co.kr/web2015/brand/btn_close_layer.gif" alt="닫기"></button>
                </div>
            </div>
        </div>
        <!-- //ABOUT BRAND -->
    `
    , props : {
        street_hello : {
            designis: {type:String, default:""}
            , StoryTitle: {type:String, default:""}
            , StoryContent: {type:String, default:""}
            , philosophyTitle: {type:String, default:""}
            , philosophyContent: {type:String, default:""}
            , brandTag: []
            , samebrand: []
        }
    }
});