import { SearchMediaBean } from '../../bean/search/SearchMediaBean'
import { PageManager } from '../../common/PageManager'
import { Utils } from '../../Utils/Utils'

@Component
export struct MediaFtItem{
  item?:SearchMediaBean

  build(){
    this.mediaFtItem(this?.item)
  }

  @Builder mediaFtItem(item?:SearchMediaBean){
    Column(){
      Row(){
        Stack(){
          Image(item?.cover)
            .alt($r('app.media.ic_placeholder'))
            .height('100%')
            .objectFit(ImageFit.Cover)
            .aspectRatio(3/4)
            .borderRadius(5)
            .align(Alignment.BottomEnd)

          Text(item?.season_type_name)
            .backgroundColor($r('app.color.bilibili_theme'))
            .fontColor($r('app.color.bilibili_text_white'))
            .badgeStyle()
            .margin({top:4,bottom:4,right:4})

        }.alignContent(Alignment.TopEnd)
        .height('100%')
        .margin({left:'2%'})

        Column(){
          Row(){
            if (item?.badges!=undefined) {
              Text(item?.badges[0].text)
                .backgroundColor(item?.badges[0].bg_color)
                .fontColor(item?.badges[0].text_color)
                .borderColor(item?.badges[0].border_color)
                .badgeStyle()
                .margin({top:4,bottom:4,right:4})
            }

            Text(Utils.upRichTextClear(item?.title))
              .contentStyle()
              .margin({top:4,bottom:4})
          }.width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Start)

          Text(item?.areas+" | "+Utils.timestampToDate(item?.pubtime)+"\n"+item?.styles)
            .fontColor($r('app.color.bilibili_text_grey_bold'))
            .width('100%')
            .contentStyle()

          Blank().layoutWeight(1)

          Row(){
            Text(item?.media_score.score.toString())
              .fontSize(14)
              .fontColor($r('app.color.bilibili_bangumi_score'))
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
            Text('分')
              .fontSize(12)
              .margin({left:'1%'})
              .fontColor($r('app.color.bilibili_bangumi_score'))
              .textAlign(TextAlign.Center)
            Text(Utils.Views(item?.media_score.user_count)+'人参与')
              .fontSize(12)
              .fontColor($r('app.color.bilibili_text_grey_bold'))
              .margin({left:'2%'})
              .textAlign(TextAlign.Center)
          }.width('100%')
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Bottom)
        }
        .justifyContent(FlexAlign.Start)
        .height('100%')
        .margin({left:'2%'})
        .layoutWeight(1)

        Column(){
          Text(item?.button_text)
            .height("18%")
            .aspectRatio(3)
            .borderWidth(1)
            .borderRadius(16)
            .borderColor(Color.White)
            .backgroundColor($r('app.color.bilibili_theme'))
            .fontColor(Color.White)
            .fontSize(12)
            .textAlign(TextAlign.Center)
            .margin({bottom:'12%'})


          Row(){
            Image($r('app.media.ic_svg_test'))
              .fillColor($r('app.color.bilibili_theme'))
              .width('20%')
              .aspectRatio(1)
              .objectFit(ImageFit.Cover)

            Text("追剧")
              .fontColor($r('app.color.bilibili_theme'))
              .textAlign(TextAlign.Center)
              .fontSize(12)
          }
          .height("18%")
          .aspectRatio(3)
          .borderWidth(1)
          .borderRadius(16)
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(Color.White)
          .borderColor($r('app.color.bilibili_theme'))
        }
        .width('22%')
        .justifyContent(FlexAlign.Start)
        .height('100%')
        .margin({right:'1%'})
      }.width('100%')
      .height('90%')

      Divider().width('100%').color($r('app.color.bilibili_divider'))
        .margin('2%')
    }.backgroundColor(Color.White)
    .height('22%')
    .onClick(()=>{
      PageManager.routerMedia(item?.season_id)
    })
  }
}

@Extend(Text)
function badgeStyle(){
  .borderRadius(5)
  .padding(4)
  .fontSize(12)
}

@Extend(Text)
function contentStyle(){
  .fontSize(12)
  .maxLines(2)
  .textOverflow({overflow:TextOverflow.Ellipsis})
  .margin({top:4})
  .textAlign(TextAlign.Start)
}
