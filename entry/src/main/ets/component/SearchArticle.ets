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
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @Prop search:string = "kobe"
  @State page:number=1
  @State searchArticleBeans: SearchArticleBean[] = []
  searchType:SearchType = SearchType.BILI_USER
  @State err:string=""
  aboutToAppear() {
    console.log("图文 页面刷新了")
    this.initPage()
  }

  aboutToDisappear(){
    console.log("图文 页面销毁了")
  }

  initPage(){
    this.page = 1
    Api.getSearchType<SearchArticleBean>(this.searchType,this.search,this.page).then(response=>{
      this.searchArticleBeans = response.result
      this.loadingStatus = LoadingStatus.LoadingSuccess
    }).catch(err=>{
      this.err = err
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  build() {
    LoadingData({loadingStatus :this.loadingStatus,page:this.biliUserPage,extraFailure:"SearchArticle",extraSuccess:'SearchArticle' })
  }

  @Builder biliUserPage(){
    Column(){
      List(){
        ForEach(this.searchArticleBeans,(item:SearchArticleBean)=>{
          this.articleItem(item)
        })
      }
    }.layoutWeight(1)
  }

  @Builder articleItem(item:SearchArticleBean){
    Row(){
      Image("https:"+item.image_urls[0])
        .margin(15)
        .borderRadius(2)
        .width('28%')
        .aspectRatio(1)
        .objectFit(ImageFit.Auto)
        .alt($r('app.media.ic_placeholder'))
      Column(){
        Text(Utils.upRichTextClear(item.title))
          .maxLines(1)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .fontSize(14)
          .fontColor($r('app.color.bilibili_text_black'))

        Text(Utils.upRichTextClear(item.desc))
          .maxLines(2)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .fontSize(10)
          .fontColor($r('app.color.bilibili_text_grey_bold'))

        Row(){
          Text(item.category_name)
          Image($r('app.media.biliplayer_ic_topbar_like_bold'))
            .height('30%')
            .aspectRatio(1)
            .objectFit(ImageFit.Auto)
          Text(item.like+"")
          Text(Utils.timestampToDate(item.pub_time))
        }.justifyContent(FlexAlign.Start)
        .width('100%')
      }.alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({right:15})
    }.width('100%')
    .aspectRatio(25 / 10)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)

    Divider()
      .color('#94999D')
      .margin({ left: 8, right: 8 })
  }
}