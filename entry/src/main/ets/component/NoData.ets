@Component
@Preview
export struct NoData{
  build(){
    Column(){
      Column(){
        Image($r('app.media.bilibili_no_data'))
          .objectFit(ImageFit.Cover)
          .width('50%')
          .aspectRatio(1)
          .margin(12)
        Text("今天真是寂寞如雪啊 ~ ").fontSize(18).maxLines(1)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .fontColor($r('app.color.bilibili_text_grey_bold'))
          .margin(12)
      }
    }.width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}