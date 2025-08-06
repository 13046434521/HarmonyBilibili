import { SearchMediaBean } from '../bean/search/SearchMediaBean'
import Constants from '../common/Constants'
import { LoadingStatus } from '../common/LoadingStatus'
import { RefreshList, RefreshListController } from '../common/RefreshList'
import { SearchType } from '../common/SearchType'
import { MediaBangumiData } from '../datasource/MediaBangumiData'
import Api from '../net/Api'
import { MediaBangumiItem } from './item/MediaBangumiItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchMediaBangumiDetails {
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @State page:number=1
  @State errMessage :string = ''
  @State mediaBangumiData:MediaBangumiData = new MediaBangumiData()
  searchType:SearchType = SearchType.MEDIA_BANGUMI
  search: string =""
  @State refreshController:RefreshListController = new RefreshListController()


  aboutToAppear() {
    this.refreshController
      .setRefreshListener(this.refresh.bind(this))
      .setLoadMoreListener(this.load.bind(this))
      .setCacheCount(Constants.CACHE_COUNT)

    this.refresh()
  }

  build() {
    LoadingData({loadingStatus :this.loadingStatus,page:this.bangumiPage.bind(this)})
      .width('100%')
      .height('100%')
  }

  @Builder bangumiPage(){
    RefreshList({refreshController:this.refreshController,listItem:this.listItem.bind(this)})
      .width('100%')
      .layoutWeight(1)
  }

  @Builder
  listItem(){
    LazyForEach(this.mediaBangumiData,(item:SearchMediaBean, index)=>{
      MediaBangumiItem({item:item})
    }, (item:SearchMediaBean )=>JSON.stringify(item))
  }

  load(){
    Api.getSearchType<SearchMediaBean>(this.searchType,this.search,this.page+1).then(response=>{
      if (response.result !=null&&response.result.length!==0) {
        this.page++
        this.mediaBangumiData.pushDataAll(response.result)
      }else{
        this.refreshController.isLoadMore = false
      }
    }).catch((err:Error)=>{
      this.loadingStatus = LoadingStatus.LoadingFailure
      this.errMessage = err.message
    })
  }

  refresh(){
    this.page = 1
    Api.getSearchType<SearchMediaBean>(this.searchType,this.search,this.page).then(response=>{
      if (response.result !=null&&response.result.length!==0) {
        this.mediaBangumiData.reloadData(response.result)
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }
    }).catch((err:Error)=>{
      this.loadingStatus = LoadingStatus.LoadingFailure
      this.errMessage = err.message
    })
  }
}