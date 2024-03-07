
@Component
export struct IconTab{
  title:string = "CESHI"
  image:Resource = $r('app.media.icon')
  build(){
    Column(){
      Image(this.image)
        .width('40%')
        .height('40%')
      Text(this.title)
        .fontSize(25)
    }.width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}