import { SearchMediaBean } from '../bean/search/SearchMediaBean'
import Constants from '../common/Constants'
import { LoadingStatus } from '../common/LoadingStatus'
import { RefreshList, RefreshListController } from '../common/RefreshList'
import { SearchType } from '../common/SearchType'
import { SearchMediaData } from '../datasource/SearchMediaData'
import Api from '../net/Api'
import { Utils } from '../Utils/Utils'
import { MediaFtItem } from './item/MediaFtItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchMediaFt {
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @State page:number=1
  @State mediaFtData:SearchMediaData =new SearchMediaData()
  @State refreshController:RefreshListController = new RefreshListController()
  searchType:SearchType = SearchType.MEDIA_FT
  search: string =""

  aboutToAppear() {
    this.refresh()

    this.refreshController.setRefreshListener(this.refresh.bind(this))
      .setLoadMoreListener(this.load.bind(this))
      .setCacheCount(Constants.CACHE_COUNT)
  }


  build() {
    LoadingData({loadingStatus :this.loadingStatus,page:this.mediaFtPage.bind(this)})
      .width('100%')
      .height('100%')
  }

  @Builder mediaFtPage(){
    RefreshList({refreshController:this.refreshController,listItem:this.mediaItem.bind(this)})
      .width('100%')
    .layoutWeight(1)
  }

  @Builder
  mediaItem() {
    LazyForEach(this.mediaFtData, (item, index) => {
      Column(){
        MediaFtItem({ item: item })
      }
    }, (item: SearchMediaBean) => JSON.stringify(item))
  }


   refresh(){
     this.page = 1
     Api.getSearchType<SearchMediaBean>(this.searchType,this.search,this.page).then(response=>{
      this.mediaFtData.reloadData(response.result)
      this.refreshController.isLoadMore = true
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

  load(){
    Api.getSearchType<SearchMediaBean>(this.searchType,this.search,this.page+1).then(response=>{
      if (Utils.isNonNull(response.result)){
        this.mediaFtData.pushDataAll(response.result)
        this.page++
      }else{
        this.refreshController.isLoadMore = false
      }
    }).catch(err=>{
      this.refreshController.isLoadMore = false
      Utils.Toast("影视页面:"+err)
    })
  }
}