import { SearchMediaFtBean } from '../bean/search/SearchMediaFtBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import { MediaFtData } from '../datasource/MediaFtData'
import Api from '../net/Api'
import { Utils } from '../Utils/Utils'
import { MediaFtItem } from './item/MediaFtItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchMediaFt {
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  search: string =""
  @State page:number=1
  @State mediaFtData:MediaFtData =new MediaFtData()
  controller:Scroller=new Scroller()
  searchType:SearchType = SearchType.MEDIA_FT

  aboutToAppear() {
    this.initPage()
  }

  
  initPage(){
    this.page = 1
    Api.getSearchType<SearchMediaFtBean>(this.searchType,this.search,this.page).then(response=>{
      this.mediaFtData.pushDataAll(response.result)

      if (this.mediaFtData.totalCount()!=0) {
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }

    }).catch(err=>{
      this.loadingStatus = LoadingStatus.LoadingFailure
      Utils.Toast("影视页面:"+err)
    })
  }

  build() {
    LoadingData({loadingStatus :this.loadingStatus,page:this.mediaFtPage.bind(this)})
      .width('100%')
      .height('100%')
  }

  @Builder mediaFtPage(){
    Scroll(this.controller){
      Column() {
        LazyForEach(this.mediaFtData, (item, index) => {
          MediaFtItem({ item: item })
        }, (item:SearchMediaFtBean) => JSON.stringify(item))
      }.width('100%')
    }.width('100%')
    .align(Alignment.Top)
    .edgeEffect(EdgeEffect.None)
    .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
    .scrollBar(BarState.Auto)  // 滚动条常驻显示
    .scrollBarColor(Color.Gray)  // 滚动条颜色
    .scrollBarWidth(2) // 滚动条宽度
  }
}