import { SearchMediaBangumiBean } from '../../bean/SearchMediaBangumiBean'
import { Utils } from '../../Utils/Utils'

@Component
export struct MediaBangumiItem{
  item: SearchMediaBangumiBean

  build(){
    this.banguMiPageItem(this.item)

  }

  @Builder banguMiPageItem(item:SearchMediaBangumiBean){
    Column(){
      Row(){
        Stack(){
          Image(item.cover)
            .alt($r('app.media.ic_placeholder'))
            .height('100%')
            .objectFit(ImageFit.Cover)
            .aspectRatio(3/4)
            .borderRadius(5)
            .align(Alignment.BottomEnd)

          if (item.badges!=null){
            Text(item.badges[0].text)
              .backgroundColor(item.badges[0].bg_color)
              .fontColor(item.badges[0].text_color)
              .borderColor(item.badges[0].border_color)
              .borderRadius(5)
              .padding(4)
              .fontSize(10)
              .margin(4)
          }
        }.alignContent(Alignment.TopEnd)
        .margin({left:12,right:12})
        .height('80%')

        Column(){
          Row(){
            Text(item.season_type_name)
              .borderRadius(5)
              .padding(4)
              .fontSize(10)
              .backgroundColor($r('app.color.bilibili_theme'))
              .fontColor($r('app.color.bilibili_text_white'))
              .borderRadius(5)
              .padding(4)
              .fontSize(10)
              .margin({top:4,bottom:4,right:4})

            Text(Utils.upRichTextClear(item.title))
              .fontSize(12)
              .maxLines(2)
              .textOverflow({overflow:TextOverflow.Ellipsis})
              .layoutWeight(1)
          }.width('100%')

          Text(item.areas+" | "+Utils.timestampToDate(item.pubtime)+"\n"+item.styles)
            .fontSize(10)
            .maxLines(2)
            .textOverflow({overflow:TextOverflow.Ellipsis})
            .fontColor($r('app.color.bilibili_text_grey_bold'))
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({top:8})
            .layoutWeight(1)
          Blank().layoutWeight(1)
          Row(){
            Text(item.media_score.score.toString())
              .fontSize(14)
              .fontColor($r('app.color.bilibili_bangumi_score'))
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
            Text('分')
              .fontSize(8)
              .margin({left:2,right:8})
              .fontColor($r('app.color.bilibili_bangumi_score'))
              .textAlign(TextAlign.Center)
            Text(Utils.Views(item.media_score.user_count,'万')+'人参与')
              .fontSize(8)
              .fontColor($r('app.color.bilibili_text_grey_bold'))
              .textAlign(TextAlign.Center)
          }.height('16%')
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Bottom)
        }
        .justifyContent(FlexAlign.Start)
        .height('80%')
        .layoutWeight(1)

        Column(){
          Text(item.button_text)
            .borderRadius(16)
            .backgroundColor($r('app.color.bilibili_theme'))
            .fontColor(Color.White)
            .borderWidth(1)
            .borderColor(Color.White)
            .margin({ left:8,bottom:8,right:8 })
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding(4)
            .fontSize(12)
          Row(){
            Image($r('app.media.ic_svg_test'))
              .fillColor($r('app.color.bilibili_theme'))
              .width('20%')
              .aspectRatio(1)
              .objectFit(ImageFit.Cover)

            Text("追番")
              .fontColor($r('app.color.bilibili_theme'))
              .padding(4)
              .textAlign(TextAlign.Center)
              .fontSize(12)

          }.borderRadius(16)
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(Color.White)
          .borderColor($r('app.color.bilibili_theme'))
          .borderWidth(1)
          .margin(8)
          .width('100%')
        }
        .width('18%')
        .justifyContent(FlexAlign.Start)
        .height('80%')
        .margin({right:18})
      }.width('100%')
      .height('22%')
      .backgroundColor(Color.White)

      Divider().width('95%').color($r('app.color.bilibili_divider'))
    }
  }
}