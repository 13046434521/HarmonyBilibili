import prompt from '@ohos.prompt'
import { Loading } from './Loading';


PersistentStorage.PersistProp('aProp', 47);
  @Entry
  @Component
  struct Page {
  @State listPosition: number = 0; // 0代表滚动到List顶部，1代表中间值，2代表滚动到List底部。
  private arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  private scrollerForScroll: Scroller = new Scroller()
  private scrollerForList: Scroller = new Scroller()

  build() {
    Flex() {
      Loading({scroll:this.scrollerForScroll}){
        Scroll(this.scrollerForScroll) {
          Column() {
            Text("Scroll Area")
              .width("100%").height("40%").backgroundColor(0X330000FF)
              .fontSize(16).textAlign(TextAlign.Center)
              .onClick(() => {
                this.scrollerForList.scrollToIndex(5)
              })

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
            .onReachStart(() => {
              this.listPosition = 0
            })
            .onReachEnd(() => {
              this.listPosition = 2
            })
            .onScrollFrameBegin((offset: number) => {
              if ((this.listPosition == 0 && offset <= 0) || (this.listPosition == 2 && offset >= 0)) {
                this.scrollerForScroll.scrollBy(0, offset)
                return { offsetRemain: 0 }
              }
              this.listPosition = 1
              return { offsetRemain: offset };
            })

            Text("Scroll Area")
              .width("100%").height("40%").backgroundColor(0X330000FF)
              .fontSize(16).textAlign(TextAlign.Center)
          }
        }
        .width("100%").height("100%")
      }

    }.width('100%').height('100%').backgroundColor(0xDCDCDC).padding(20)
  }
}