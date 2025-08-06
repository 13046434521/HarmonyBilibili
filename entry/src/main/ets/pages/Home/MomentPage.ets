import Constants from '../../common/Constants'
import { LoadingStatus } from '../../common/LoadingStatus'
import { Loading } from '../../component/Loading'
import { VolumeBrightnessProgress } from '../../component/play/VolumeBrightnessProgress'
import { Utils } from '../../Utils/Utils'

@Component
// 动态页面
@Preview
export struct MomentPage {
  @State listPosition: number = 0; // 0代表滚动到List顶部，1代表中间值，2代表滚动到List底部。
  @State private arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  private scrollerForScroll: Scroller = new Scroller()
  private scrollerForList: Scroller = new Scroller()
  private oter: number[] = [-1, -2, -3, -4, -5, -6, -7, -8, -9, -10]

  count:number =0
  build() {
    Scroll(this.scrollerForScroll) {
      Column() {
        Text("Scroll Area")
          .width("100%").height("40%").backgroundColor(0X330000FF)
          .fontSize(16).textAlign(TextAlign.Center)
          .onClick(() => {
            this.scrollerForList.scrollToIndex(5)
          })

        List({ space: 20, scroller: this.scrollerForList }) {
          ForEach(this.arr, (item: number, index?: number) => {
            ListItem() {
              if (index===this.arr.length-1) {
                Image($r('app.media.test'))
              }else{
                Text("ListItem" + item)
                  .width("100%").height("100%").borderRadius(15)
                  .fontSize(16).textAlign(TextAlign.Center).backgroundColor(Color.White)
              }

            }.width("100%").height(100)
          })
        }
        .width("100%")
        .height("50%")
        .edgeEffect(EdgeEffect.None)
        .onReachStart(() => {
          this.listPosition = 0
        })
        .onReachEnd(() => {
          for (let index = 0; index < 10; index++) {
            this.count++
            this.arr.push(this.count)
          }

          // this.listPosition = 2
        }).onScrollFrameBegin((offset: number) => {
          // console.debug('scrollTest:',"offest:"+offset+"  listPosition:"+this.listPosition+"")
          if ((this.listPosition == 0 && offset <= 0) || (this.listPosition == 2 && offset >= 0)) {
            console.debug('scrollTest:',"进来了---offest:"+offset+"  listPosition:"+this.listPosition+"")
            this.scrollerForScroll.scrollBy(0, offset)
            return { offsetRemain: 0 }
          }
          this.listPosition = 1
          console.warn('scrollTest:',"没进来---offest:"+offset+"  listPosition:"+this.listPosition+"")
          return { offsetRemain: offset };
        })
        Text("Scroll Area")
          .width("100%").height("40%").backgroundColor(0X330000FF)
          .fontSize(16).textAlign(TextAlign.Center)
      }.borderWidth(2)
      .borderColor(Color.Orange)
      .justifyContent(FlexAlign.Start)
    }
    .width("100%").height("100%")
  }
}