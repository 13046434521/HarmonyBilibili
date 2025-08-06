import { SearchArticleBean } from '../bean/search/SearchArticleBean'
import Constants from '../common/Constants'
import { LoadingStatus } from '../common/LoadingStatus'
import { RefreshList, RefreshListController } from '../common/RefreshList'
import { SearchType } from '../common/SearchType'
import { ArticleData } from '../datasource/ArticleData'
import Api from '../net/Api'
import { ArticleItem } from './item/ArticleItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchArticleDetails {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @State page: number = 1
  @State articleData:ArticleData = new ArticleData()
  @Prop search: string = ""
  @State err: string = ""
  @State refreshController:RefreshListController = new RefreshListController()
  searchType: SearchType = SearchType.ARTICLE
  aboutToAppear() {
    this.refreshController
      .setRefreshListener(this.refresh.bind(this))
      .setLoadMoreListener(this.load.bind(this))
      .setCacheCount(Constants.CACHE_COUNT)

    this.refresh()
  }

  build() {
    LoadingData({
      loadingStatus: this.loadingStatus,
      page: this.articlePage.bind(this),
    }).width('100%')
      .height('100%')
  }

  @Builder
  articlePage() {
    RefreshList({refreshController:this.refreshController,listItem:this.listItem.bind(this)})
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(Color.White)
  }

  @Builder
  listItem(){
    LazyForEach(this.articleData, (item: SearchArticleBean) => {
      Column() {
        ArticleItem({item:item})

        Divider().strokeWidth(1).width('100%').color($r('app.color.bilibili_divider'))
      }
    },(item: SearchArticleBean) =>item.mid+item.title)
  }

  load(){
    Api.getSearchType<SearchArticleBean>(this.searchType, this.search, this.page+1).then(response => {
      if (response.result!=undefined && response.result.length!==0) {
        this.page++
        this.articleData.pushDataAll(response.result)
      }else{
        this.refreshController.isLoadMore = false
      }
    }).catch((err:Error) => {
      this.err = err.message
    })
  }

  refresh(){
    this.page = 1
    Api.getSearchType<SearchArticleBean>(this.searchType, this.search, this.page).then(response => {
      if (response.result!=undefined && response.result.length!==0) {
        this.articleData.reloadData(response.result)
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }
    }).catch((err:Error) => {
      this.err = err.message
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }
}