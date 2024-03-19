import { SearchArticleBean } from '../bean/SearchArticleBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import { ArticleData } from '../datasource/ArticleData'
import Api from '../net/Api'
import { ArticleItem } from './item/ArticleItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchArticleDetails {
  @State message: string = '图文'
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @Prop search: string = ""
  @State page: number = 1
  @State articleData:ArticleData = new ArticleData()
  searchType: SearchType = SearchType.ARTICLE
  @State err: string = ""

  aboutToAppear() {
    this.initPage()
  }

  initPage() {
    this.page = 1
    Api.getSearchType<SearchArticleBean>(this.searchType, this.search, this.page).then(response => {
      this.articleData.pushDataAll(response.result)
      if (response.result!=null&& this.articleData.totalCount()!=0) {
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }
    }).catch(err => {
      this.err = err
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
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
    List() {
      LazyForEach(this.articleData, (item: SearchArticleBean) => {
        ListItem() {
          ArticleItem({item:item})
        }.width('100%')
        .aspectRatio(3.5)
      },(item: SearchArticleBean) =>item.mid+item.title)
    }.divider({
      strokeWidth: 1,
      color: $r('app.color.bilibili_divider'),
      startMargin: 8,
      endMargin: 8
    })
    .onReachEnd(()=>{
      Api.getSearchType<SearchArticleBean>(this.searchType, this.search, this.page+1).then(response => {
        if (response.result!=undefined) {
          this.page++
          this.articleData.pushDataAll(response.result)
        }
      }).catch(err => {
        this.err = err
      })
    })
    .width('100%')
    .backgroundColor(Color.White)
  }
}