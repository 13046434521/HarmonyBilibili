@Preview
@Component
  // 主界面中的我的页面
export struct MinePage {
  scroller: Scroller = new Scroller()
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
/*  @Builder banguMiPage(){
    Scroll(this.scroller){
      Column(){
        ForEach(this.arr,(item:number,index)=>{
          Text("数据:"+item)
            .height('30%')
            .width('100%')
            .borderWidth(2)
            .borderColor(Color.Black)
            .borderRadius(2)
        }, item => item)
      }.height('100%')
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
    .scrollBar(BarState.On)  // 滚动条常驻显示
    .scrollBarColor(Color.Gray)  // 滚动条颜色
    .scrollBarWidth(5) // 滚动条宽度
  }*/
  build() {
    Column(){
      Scroll(this.scroller){
        Column(){
          ForEach(this.arr,(item:number,index)=>{
            Text("数据:"+item)
              .height('30%')
              .width('30%')
              .borderWidth(2)
              .borderColor(Color.Black)
              .borderRadius(2)
          }, item => item)
        }.width('100%')
      }.height('100%')
      .width('100%')
      .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
      .scrollBar(BarState.On)  // 滚动条常驻显示
      .scrollBarColor(Color.Gray)  // 滚动条颜色
      .scrollBarWidth(30) // 滚动条宽度
    }
  }
}