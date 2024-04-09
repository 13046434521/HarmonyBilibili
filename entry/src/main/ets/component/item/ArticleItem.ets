import { SearchArticleBean } from '../../bean/search/SearchArticleBean'
import { PageManager } from '../../common/PageManager'
import { Utils } from '../../Utils/Utils'

@Component
export struct ArticleItem{
  item: SearchArticleBean
  build(){
    this.articleItem(this.item)
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
        .margin({ left: '2%', right: '2%' })
        .borderRadius(5)
      Column() {
        Text(Utils.upRichTextClear(item.title))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontSize(16)
          .fontColor($r('app.color.bilibili_text_black'))
          .margin({ bottom: '2%' })

        Text(Utils.upRichTextClear(item.desc))
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontSize(14)
          .fontColor($r('app.color.bilibili_text_grey_bold'))
          .margin({ bottom: '2%' })
        Row() {
          Text(item.category_name)
            .fontColor($r('app.color.bilibili_text_grey_bold'))
            .maxLines(1)
            .fontSize(13)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .textAlign(TextAlign.Center)

          Blank().layoutWeight(1)

          Image($r('app.media.ic_like_bold'))
            .height('100%')
            .aspectRatio(1)
            .objectFit(ImageFit.Cover)
            .interpolation(ImageInterpolation.High)
            .margin({right:'1%'})

          Text(item.like + " · " + Utils.timestampToDate(item.pub_time))
            .fontColor($r('app.color.bilibili_text_grey_bold'))
            .maxLines(1)
            .fontSize(13)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({right:'2%'})
            .textAlign(TextAlign.Center)

        }.justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height('14%')
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceEvenly)
      .height('100%')
      .layoutWeight(1)
      .margin({ right: '2%' })
    }.width('100%')
    .height('14%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .onClick(()=>{
      PageManager.routerArticle(this.item.id)
    })
  }
}