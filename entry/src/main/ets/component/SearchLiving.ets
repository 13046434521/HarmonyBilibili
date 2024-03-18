import { SearchBiliUserBean } from '../bean/SearchBiliUserBean'
import { SearchLiveRoomBean } from '../bean/SearchLiveRoomBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import { LivingData } from '../datasource/LivingData'
import Api from '../net/Api'
import { LiveRoomItem } from './item/LiveRoomItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchLiving {
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @Prop search:string = ""
  @State page:number=1
  @State livingData :LivingData = new LivingData()
  scrollerController:Scroller = new Scroller()
  searchType:SearchType = SearchType.LIVE_ROOM

  aboutToAppear() {
    this.initPage()
  }

  initPage(){
    this.page = 1
    Api.getSearchType<SearchLiveRoomBean>(this.searchType,this.search,this.page).then(response=>{
      this.livingData.pushDataAll(response.result)
      if (response.result!=null&& this.livingData.totalCount()!=0) {
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }
    }).catch(err=>{
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  build() {
    LoadingData({loadingStatus :this.loadingStatus,page:this.liveRoomPage.bind(this)})
      .layoutWeight(1)
  }

  @Builder liveRoomPage(){
    Scroll(){
      Column(){
        List({scroller: this.scrollerController }) {
          LazyForEach(this.livingData,(item:SearchLiveRoomBean)=>{
            ListItem() {
              LiveRoomItem({ item: item })
                .margin(4)
            }
          },(item:SearchLiveRoomBean)=>item.roomid+item.uname)
        }.edgeEffect(EdgeEffect.None)
        .lanes(2)
        .width('100%')
        .height('100%')
        }
    }
    .align(Alignment.Top)
    .edgeEffect(EdgeEffect.None)
    .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
    .scrollBar(BarState.Auto)  // 滚动条常驻显示
    .scrollBarColor(Color.Gray)  // 滚动条颜色
    .scrollBarWidth(2) // 滚动条宽度
  }
}