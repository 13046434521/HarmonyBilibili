import { SearchArticleBean } from '../../bean/SearchArticleBean'
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