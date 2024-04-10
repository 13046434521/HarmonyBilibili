@Component
export struct TabBuilder{
  @Prop currentIndex:number
  @Prop tabTitle:string =''
  // controller:TabsController = new TabsController()
  index:number = 0
  build(){
    Column() {
      Text(this.tabTitle)
        .fontColor(this.currentIndex === this.index ? $r('app.color.bilibili_theme') : $r('app.color.bilibili_text_grey_bold'))
        .fontSize(14)
        .maxLines(1)
        .textAlign(TextAlign.Center)
        .margin('4%')
      Divider()
        .strokeWidth(2)
        .color($r('app.color.bilibili_theme'))
        .opacity(this.currentIndex === this.index  ? 1 : 0)
        .width('50%')
    }.width('17%')
    .height('60%')
    .stateStyles({pressed:pressedStyles,normal:normalStyles})
    .borderRadius(5)
    .justifyContent(FlexAlign.Center)
/*    .onClick(()=>{
      this.currentIndex = this.index
      this.controller.changeIndex(this.currentIndex)
    })*/
  }
}
@Builder
export function TabBuilders(index: number, name: string,currentIndex:number) {
  Column() {
    Text(name)
      .fontColor(currentIndex === index ? $r('app.color.bilibili_theme') : $r('app.color.bilibili_text_grey_bold'))
      .fontSize(14)
      .maxLines(1)
      .textAlign(TextAlign.Center)
      .margin('4%')
    Divider()
      .strokeWidth(2)
      .color($r('app.color.bilibili_theme'))
      .opacity(currentIndex === index  ? 1 : 0)
      .width('50%')
  }.width('17%')
  .height('60%')
  .stateStyles({pressed:pressedStyles,normal:normalStyles})
  .borderRadius(5)
/*  .onClick(()=>{
    this.currentIndex = index
    this.controller.changeIndex(this.currentIndex)
  })*/
  .justifyContent(FlexAlign.Center)
}
@Styles function  pressedStyles() {
  .backgroundColor($r('app.color.bilibili_background_grey'))
}

@Styles function  normalStyles() {
  .backgroundColor($r('app.color.bilibili_background_white'))
}