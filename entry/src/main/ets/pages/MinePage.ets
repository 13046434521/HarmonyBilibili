@Preview
@Component
  // 主界面中的我的页面
export struct MinePage {
  @State listPosition: number = 0; // 0代表滚动到List顶部，1代表中间值，2代表滚动到List底部。
  private arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  private scrollerForScroll: Scroller = new Scroller()
  private scrollerForList: Scroller = new Scroller()

  build() {
    Scroll(this.scrollerForScroll) {
      Column() {
        List({ space: 20, scroller: this.scrollerForList }) {
          ForEach(this.arr, (item) => {
            ListItem() {
              Text("ListItem" + item)
                .width("100%").height("100%").borderRadius(15)
                .fontSize(16).textAlign(TextAlign.Center).backgroundColor(Color.White)
            }.width("100%").height(100)
          }, item => item)
        }
        .width("100%")
        .height("50%")
        .edgeEffect(EdgeEffect.None)
      }
    }.width('100%').height('100%').backgroundColor(0xDCDCDC).padding(20)
  }
}