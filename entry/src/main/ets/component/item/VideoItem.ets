import { SearchVideoBean } from '../../bean/search/SearchVideoBean'
import Constants from '../../common/Constants'
import { Utils } from '../../Utils/Utils'
import deviceInfo from '@ohos.deviceInfo'

@Component
export struct VideoItem {
  item?: SearchVideoBean
  deviceType = 'tablet'
  imgHeight = 150
  aboutToAppear(){
    this.deviceType = deviceInfo.deviceType

    this.imgHeight = this.deviceType==="tablet"?150:100
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Image(`https:${this.item?.pic}`)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
            .borderRadius(5)
            .alt($r('app.media.ic_placeholder'))
            .interpolation(ImageInterpolation.High)

          Text(Utils.TimeDeal(this.item?.duration))
            .maxLines(1)
            .margin({ bottom: '1%', right:  '2%' })
            .fontSize(12)
            .backgroundColor(Color.Grey)
            .fontColor(Color.White)
            .borderRadius(5)
            .padding('1%')
            .opacity(0.8)

        }.height('100%')
        .aspectRatio(Constants.DEFAULT_ASPECT_RATIO)
        .padding('1%')
        .align(Alignment.BottomEnd)

        Column() {
          Text(Utils.upRichTextClear(this.item?.title))
            .maxLines(2)
            .fontColor($r("app.color.bilibili_text_black_light"))
            .fontSize(14)
            .letterSpacing(1)
            .maxFontSize(16)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('90%')
            .fontWeight(FontWeight.Bold)

          Blank().layoutWeight(1)

          Row() {
            Image($r('app.media.ic_playlist_up_label'))
              .imageStyle()
            Text(this.item?.author)
              .textStyle()
          }.margin({bottom:'1%'})

          Row() {
            Image($r('app.media.ic_detail_play'))
              .imageStyle()
            Text(Utils.Views(this.item?.play))
              .textStyle()
            Image($r("app.media.ic_danmakus_dark"))
              .imageStyle()
              .margin({ left: '2%' })
            Text(Utils.Views(this.item?.danmaku))
              .textStyle()
            Blank()
              .layoutWeight(1)
            Image($r('app.media.ic_more_vertical'))
              .imageStyle()
              .onClick(() => {
                AlertDialog.show(
                  {
                    message: this.item?.description,
                    autoCancel: true,
                    alignment: DialogAlignment.Bottom,
                    gridCount: 50,
                    offset: { dx: 0, dy: -5 },
                  }
                )
              })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding('1%')
        .layoutWeight(1)

      }.justifyContent(FlexAlign.Start)
      .width('100%')
      .height(this.imgHeight)

      Divider().color($r('app.color.bilibili_divider'))
        .margin({ left: '1%', right: '1%' })
        .strokeWidth(1)
    }
  }
}

@Extend(Image)
function imageStyle() {
  .height('15%')
  .aspectRatio(1)
  .objectFit(ImageFit.Cover)
  .interpolation(ImageInterpolation.High)
}

@Extend(Text)
function textStyle() {
  .fontSize(12)
  .fontColor(Color.Grey)
  .maxLines(1)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
  .margin({ left: '1%' })
}