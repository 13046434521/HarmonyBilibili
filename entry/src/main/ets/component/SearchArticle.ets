import { SearchArticleBean } from '../bean/SearchArticleBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import Api from '../net/Api'
import { Utils } from '../Utils/Utils'
import { ArticleItem } from './item/ArticleItem'
import { LoadingData } from './LoadingData'

@Component
export struct SearchArticleDetails {
  @State message: string = '图文'
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @Prop search: string = ""
  @State page: number = 1
  @State searchArticleBeans: SearchArticleBean[] = []
  searchType: SearchType = SearchType.ARTICLE
  @State err: string = ""

  aboutToAppear() {
    console.log("图文 页面刷新了" + this.searchArticleBeans.length)
    this.initPage()
  }

  aboutToDisappear() {
    console.log("图文 页面销毁了")
  }

  initPage() {
    this.page = 1
    Api.getSearchType<SearchArticleBean>(this.searchType, this.search, this.page).then(response => {
      this.searchArticleBeans = response.result
      if (this.searchArticleBeans!=null&&this.searchArticleBeans.length!=0) {
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
      ForEach(this.searchArticleBeans, (item: SearchArticleBean) => {
        ListItem() {
          ArticleItem({item:item})
        }.width('100%')
        .aspectRatio(3.5)
      })
    }.divider({
      strokeWidth: 1,
      color: $r('app.color.bilibili_divider'),
      startMargin: 8,
      endMargin: 8
    })
    .onReachEnd(()=>{
      Api.getSearchType<SearchArticleBean>(this.searchType, this.search, this.page+1).then(response => {
        if (response.result!=undefined) {
          this.searchArticleBeans =  this.searchArticleBeans.concat(response.result)
          this.page++
        }
      }).catch(err => {
        this.err = err
      })
    })
    .width('100%')
    .backgroundColor(Color.White)
  }
}