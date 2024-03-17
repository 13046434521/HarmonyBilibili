@Component

export struct SearchView{
  @Prop title:string
  build(){
    Row(){
      Image($r('app.media.ic_home_search'))
        .height(24)
        .width(24)
        .margin(16)
        .objectFit(ImageFit.Cover)
      Text(this.title)
        .height(24)
        .layoutWeight(1)
        .fontSize(14)
        .maxLines(1)
        .textOverflow({overflow:TextOverflow.Ellipsis})
    }.height('100%')
    .width('100%')
    .backgroundColor(Color.White)
    .borderWidth(1)
    .borderRadius(50)
    .borderColor(Color.Gray)
  }
}