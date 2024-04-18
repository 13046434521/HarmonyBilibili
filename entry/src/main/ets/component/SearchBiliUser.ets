import { SearchBiliUserBean } from '../bean/search/SearchBiliUserBean'
import { BiliUserData } from '../datasource/BiliUserData'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import { BiliUserItem } from './item/BiliUserItem'
import { LoadingData } from './LoadingData'
import { Utils } from '../Utils/Utils'
import Api from '../net/Api'
import { RefreshList, RefreshListController } from '../common/RefreshList'
import Constants from '../common/Constants'

@Component
export struct SearchBiliUserDetails {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @State biliUserData:BiliUserData = new BiliUserData()
  @State refreshController:RefreshListController = new RefreshListController()
  @Prop search: string = ""
  @State page: number = 1
  searchType: SearchType = SearchType.BILI_USER
  aboutToAppear() {
    this.refresh()
    this.refreshController.setRefreshListener(this.refresh.bind(this))
      .setLoadMoreListener(this.loadMore.bind(this))
      .setCacheCount(Constants.CACHE_COUNT)
  }

  build() {
    LoadingData({ loadingStatus: this.loadingStatus, page: this.biliUserPage.bind(this)})
      .width('100%')
      .height('100%')
  }

  @Builder
  biliUserPage() {
    RefreshList({refreshController:this.refreshController,listItem:this.listItem.bind(this)})
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(Color.White)
  }

  @Builder
  listItem(){
    LazyForEach(this.biliUserData, (item: SearchBiliUserBean,index?: number) => {
      Column(){
        BiliUserItem({item:item})
        Divider().color($r('app.color.bilibili_divider')).strokeWidth(1).width('100%')
      }
    },(item:SearchBiliUserBean)=>JSON.stringify(item))
  }

  refresh(){
    this.page = 1
    Api.getSearchType<SearchBiliUserBean>(this.searchType, this.search, this.page).then(response => {
      if (response.result!=null&& response.result.length!==0) {
        this.biliUserData.reloadData(response.result)
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }
    }).catch(err => {
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  loadMore(){
    Api.getSearchType<SearchBiliUserBean>(this.searchType, this.search, this.page + 1).then(response => {
      if (Utils.isNonNull(response.result)) {
        this.page++
        this.biliUserData.pushDataAll(response.result)
      }else{
        this.refreshController.isLoadMore = false
      }
    }).catch(err => {
      Utils.Toast(err)
    })
  }
}