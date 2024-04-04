
@Component
export struct Failure{
  @Prop msg:string = "加载失败...wuuuu.."
  @Prop extra:string =''

  aboutToAppear(){
    console.log("加载失败页面刷新  "+this.extra)
  }

  aboutToDisappear(){
    console.log("加载失败页面销毁  "+this.extra)
  }
  build(){
    Column(){
      Image($r('app.media.bangumi_load_season_fail_notice'))
        .width('60%')
        .objectFit(ImageFit.Cover)
        .interpolation(ImageInterpolation.High)
      Text(this.msg+'\n'+this.extra)
        .width('100%')
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .fontColor($r('app.color.bilibili_text_grey_light'))
    }.width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}