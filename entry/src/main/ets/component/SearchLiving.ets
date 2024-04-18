import { SearchBiliUserBean } from '../bean/search/SearchBiliUserBean'
import { SearchLiveRoomBean } from '../bean/search/SearchLiveRoomBean'
import Constants from '../common/Constants'
import { LoadingStatus } from '../common/LoadingStatus'
import { RefreshList, RefreshListController } from '../common/RefreshList'
import { SearchType } from '../common/SearchType'
import { LivingData } from '../datasource/LivingData'
import Api from '../net/Api'
import { LiveRoomItem } from './item/LiveRoomItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchLiving {
  @State refreshController:RefreshListController = new RefreshListController()
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @State livingData :LivingData = new LivingData()
  @State page:number=1
  @Prop search:string = ""
  searchType:SearchType = SearchType.LIVE_ROOM


  aboutToAppear() {
    this.refreshController
      .setRefreshListener(this.refresh.bind(this))
      .setLoadMoreListener(this.load.bind(this))
      .setCacheCount(Constants.CACHE_COUNT)
      .setLanes(2)

    this.refresh()
  }

  build() {
    LoadingData({loadingStatus :this.loadingStatus,page:this.liveRoomPage.bind(this)})
      .layoutWeight(1)
  }

  @Builder liveRoomPage(){
    RefreshList({refreshController:this.refreshController,listItem:this.listItem.bind(this)})
      .width('100%')
      .layoutWeight(1)
      .backgroundColor($r('app.color.bilibili_background_grey'))
  }

  @Builder
  listItem(){
    LazyForEach(this.livingData,(item:SearchLiveRoomBean)=>{
      Column() {
        LiveRoomItem({ item: item })
          .margin('4%')
       }
    },(item:SearchLiveRoomBean)=>JSON.stringify(item))
  }

  refresh(){
    this.page = 1
    Api.getSearchType<SearchLiveRoomBean>(this.searchType,this.search,this.page).then(response=>{
      if (response.result!=null&& response.result.length!==0) {
        this.livingData.reloadData(response.result)
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }
    }).catch(err=>{
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  load(){
    Api.getSearchType<SearchLiveRoomBean>(this.searchType,this.search,this.page+1).then(response=>{
      if (response.result!=null&& response.result.length!==0) {
        this.livingData.pushDataAll(response.result)
        this.page++
      }else{
        this.refreshController.isLoadMore = false
      }
    }).catch(err=>{
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

}