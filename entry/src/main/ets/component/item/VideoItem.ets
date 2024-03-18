import { SearchVideoBean } from '../../bean/SearchVideoBean'
import { Utils } from '../../Utils/Utils'

@Component
export struct VideoItem {
  item: SearchVideoBean

  build() {
    Column() {
      Divider().color($r('app.color.bilibili_divider'))
        .margin({ left: 5, right: 5 })
      Row() {
        Stack() {
          Image(`https:${this.item.pic}`)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Auto)
            .borderRadius(5)
            .alt($r('app.media.ic_placeholder'))
          Text(Utils.TimeDeal(this.item.duration))
            .maxLines(1)
            .margin({ bottom: 4, right: 8 })
            .fontSize(12)
            .backgroundColor(Color.Grey)
            .fontColor(Color.White)
            .borderRadius(4)
            .padding(4)
            .opacity(0.8)

        }.width('50%')
        .padding(12)
        .align(Alignment.BottomEnd)

        Column() {
          Text(Utils.upRichTextClear(this.item.title))
            .maxLines(2)
            .fontColor(Color.Black)
            .fontSize(14)
            .letterSpacing(1)
            .maxFontSize(16)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('90%')
            .margin({ left: 8 })
            .align(Alignment.TopStart)
            .fontWeight(FontWeight.Bold)

          Blank().layoutWeight(1)
            .margin(15)
          Row() {
            Image($r('app.media.icon_playlist_upper'))
              .imageStyle()
            Text(this.item.author)
              .textStyle()
          }.margin({ left: 8, bottom: 4 })

          Row() {
            Image($r('app.media.ic_detail_play'))
              .imageStyle()

            Text(Utils.Views(this.item.play))
              .textStyle()

            Image($r("app.media.ic_danmakus_dark"))
              .imageStyle()
              .margin({ left: 8, right: 8 })
            Text(Utils.Views(this.item.danmaku))
              .textStyle()
            Blank()
              .layoutWeight(1)
            Image($r('app.media.ic_more_vertical'))
              .imageStyle()
              .onClick(() => {
                AlertDialog.show(
                  {
                    message: this.item.description,
                    autoCancel: true,
                    alignment: DialogAlignment.Bottom,
                    gridCount: 50,
                    offset: { dx: 0, dy: -5 },
                  }
                )
              })

          }.margin({ left: 8, bottom: 8, top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 12, bottom: 4 })
        .layoutWeight(1)

      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .aspectRatio(16 / 5)
    }
  }
}

@Extend(Image)
function imageStyle() {
  .height(14)
  .width(14)
  .margin({ right: 8 })
  .objectFit(ImageFit.Auto)
}

@Extend(Text)
function textStyle() {
  .fontSize(12)
  .fontColor(Color.Grey)
  .maxLines(1)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
}