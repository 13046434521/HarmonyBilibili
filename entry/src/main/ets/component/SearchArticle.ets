import HomeBean from '../bean/HomeBean'
import { SearchArticleBean } from '../bean/SearchArticleBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import Api from '../net/Api'
import { Utils } from '../Utils/Utils'
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
      this.loadingStatus = LoadingStatus.LoadingSuccess
    }).catch(err => {
      this.err = err
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  build() {
    LoadingData({
      loadingStatus: this.loadingStatus,
      page: this.articlePage.bind(this),
      extraFailure: "SearchArticle",
      extraSuccess: 'SearchArticle'
    })
  }

  @Builder
  articlePage() {
    List() {
      ForEach(this.searchArticleBeans, (item: SearchArticleBean) => {
        ListItem() {
          this.articleItem(item)
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
        this.searchArticleBeans =  this.searchArticleBeans.concat(response.result)
        this.page++
      }).catch(err => {
        this.err = err
      })
    })
    .width('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  articleItem(item: SearchArticleBean) {
    Row() {
      Image("https:" + item.image_urls[0])
        .borderRadius(2)
        .height('90%')
        .aspectRatio(1)
        .objectFit(ImageFit.Cover)
        .alt($r('app.media.ic_placeholder'))
        .margin({ left: 10, right: 10 })
      Column() {
        Text(Utils.upRichTextClear(item.title))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontSize(14)
          .fontColor($r('app.color.bilibili_text_black'))
          .margin({ bottom: 10 })

        Text(Utils.upRichTextClear(item.desc))
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontSize(10)
          .fontColor($r('app.color.bilibili_text_grey_bold'))
          .margin({ bottom: 10 })
        Row() {
          Text("文章类型:" + item.category_name)
            .fontSize(11)
            .fontColor($r('app.color.bilibili_text_grey_bold'))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width("45%")
            .margin({ right: 4 })
          Blank().layoutWeight(1)

          Image($r('app.media.ic_like_bold'))
            .height('15%')
            .aspectRatio(1)
            .objectFit(ImageFit.Auto)

          Text(item.like + " · " + Utils.timestampToDate(item.pub_time))
            .fontSize(10)
            .fontColor($r('app.color.bilibili_text_grey_bold'))
            .margin({ left: 2})
        }.justifyContent(FlexAlign.Start)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceEvenly)
      .height('100%')
      .layoutWeight(1)
      .margin({ right: 10 })
    }.width('100%')
    .height('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}