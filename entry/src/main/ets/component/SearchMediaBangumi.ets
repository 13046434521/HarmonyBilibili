import { SearchMediaBean } from '../bean/search/SearchMediaBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import { MediaBangumiData } from '../datasource/MediaBangumiData'
import Api from '../net/Api'
import { Utils } from '../Utils/Utils'
import { MediaBangumiItem } from './item/MediaBangumiItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchMediaBangumiDetails {
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  search: string =""
  @State page:number=1
  @State errMessage :string = ''
  searchType:SearchType = SearchType.MEDIA_BANGUMI
  scroller: Scroller = new Scroller()
  @State mediaBangumiData:MediaBangumiData = new MediaBangumiData()


  aboutToAppear() {
    this.initPage()
  }

  initPage(){
    this.page = 1
    Api.getSearchType<SearchMediaBean>(this.searchType,this.search,this.page).then(response=>{
      this.mediaBangumiData.pushDataAll(response.result)
      if (response.result !=null&&this.mediaBangumiData.totalCount()!=0) {
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }
    }).catch(err=>{
      this.loadingStatus = LoadingStatus.LoadingFailure
      this.errMessage = err
      Utils.Toast(err+"")
    })
  }

  build() {
    LoadingData({loadingStatus :this.loadingStatus,page:this.banguMiPage.bind(this)})
      .width('100%')
      .height('100%')
  }

  @Builder banguMiPage(){
    Scroll(this.scroller){
      Column(){
        LazyForEach(this.mediaBangumiData,(item:SearchMediaBean, index)=>{
          MediaBangumiItem({item:item})
        }, (item:SearchMediaBean )=>JSON.stringify(item))
      }
      .width('100%')
    }.height('100%')
    .width('100%')
    .align(Alignment.Top)
    .edgeEffect(EdgeEffect.None)
    .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
    .scrollBar(BarState.Auto)  // 滚动条常驻显示
    .scrollBarColor(Color.Gray)  // 滚动条颜色
    .scrollBarWidth(2) // 滚动条宽度
  }
}