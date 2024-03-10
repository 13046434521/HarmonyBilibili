
@Component
// 主界面中的我的页面
export struct MinePage {
  @State message: string = '我的'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}