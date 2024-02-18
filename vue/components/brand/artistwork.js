Vue.component('ARTIST-WORK', {
    template : `
        <div class="workGallery">
        <div class="galleryTab">
            <ul>
                <li v-if="artistwork.work && artistwork.work.length > 0" :class="[{current : active_artistwork == 'work'}]" @click="change_active_artistwork('work')" gal_div='W'><span>WORK</span></li>
                <li v-if="artistwork.drawing && artistwork.drawing.length > 0" :class="[{current : active_artistwork == 'drawing'}]" @click="change_active_artistwork('drawing')" gal_div='D'><span>DRAWING</span></li>
                <li v-if="artistwork.photo && artistwork.photo.length > 0" :class="[{current : active_artistwork == 'photo'}]" @click="change_active_artistwork('photo')" gal_div='P'><span>PHOTO</span></li>
            </ul>
        </div>
        <ARTIST-WORK-SLIDER :tap_data="artistwork" :type="active_artistwork" />
    </div>
    `
    , props: {
        artistwork : {}
    }
    , data(){
        return{
            active_artistwork : "work"
        }
    }
    , mounted(){
        this.swiper = new Swiper('.swiper-container', {
            speed:500,
            loop:true
        });
    }
    , methods : {
        change_active_artistwork(data){
            this.active_artistwork = data;
        }
    }
});