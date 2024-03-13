import { Utils } from '../Utils/Utils'

@Component
// 主界面中的购物页面，很可能被去掉
export struct ShoppingPage {
  @State message: string = '购物'

  build() {
    Row() {
      Column() {
        Text(Utils.TimeDeal('12:1:1'))
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}