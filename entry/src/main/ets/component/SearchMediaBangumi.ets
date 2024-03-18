import { SearchBiliUserBean } from '../bean/SearchBiliUserBean'
import { SearchMediaBangumiBean } from '../bean/SearchMediaBangumiBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import Api from '../net/Api'
import { Utils } from '../Utils/Utils'
import { MediaBangumiItem } from './item/MediaBangumiItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchMediaBangumiDetails {
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  search: string =""
  @State page:number=1
  @State searchMediaBangumiBean: SearchMediaBangumiBean[] = []
  @State errMessage :string = ''
  searchType:SearchType = SearchType.MEDIA_BANGUMI
  scroller: Scroller = new Scroller()
  aboutToAppear() {
    console.log("番剧 页面刷新了")
    this.initPage()
  }
  aboutToDisappear(){
    console.log("番剧 页面销毁了")
  }
  initPage(){
    this.page = 1
    Api.getSearchType<SearchMediaBangumiBean>(this.searchType,this.search,this.page).then(response=>{
      this.searchMediaBangumiBean = response.result
      if (this.searchMediaBangumiBean !=null&&this.searchMediaBangumiBean.length!=0) {
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
        ForEach(this.searchMediaBangumiBean,(item:SearchMediaBangumiBean,index)=>{
          MediaBangumiItem({item:item})
        }, (item:SearchMediaBangumiBean )=>item.media_id+item.title)
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