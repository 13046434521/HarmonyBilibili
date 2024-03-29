@Component

export struct SearchView{
  @Prop title:string
  build(){
    Row(){
      Image($r('app.media.ic_home_search'))
        .width('8%')
        .aspectRatio(1)
        .margin({left:'3%',right:'3%',top:'1%',bottom:'1%'})
        .objectFit(ImageFit.Auto)
      Text(this.title)
        .height('100%')
        .layoutWeight(1)
        .fontSize(14)
        .maxLines(1)
        .textOverflow({overflow:TextOverflow.Ellipsis})
    }.height('100%')
    .width('100%')
    .backgroundColor(Color.White)
    .borderWidth(2)
    .borderRadius(50)
    .borderColor($r('app.color.color_gray'))
  }
}