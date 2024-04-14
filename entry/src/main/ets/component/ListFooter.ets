@Builder
export default  function  ListFooter(){
  Column(){
    Blank().layoutWeight(2)
    LoadingProgress().color($r('app.color.bilibili_theme'))
      .height("50%")
    Blank().layoutWeight(1)
    Text('加载更多......').fontColor($r('app.color.bilibili_text_grey_light'))
      .height("30%")
    Blank().layoutWeight(2)
  }.alignItems(HorizontalAlign.Center)
  .justifyContent(FlexAlign.Center)
  .height("10%")
  .width('100%')
}