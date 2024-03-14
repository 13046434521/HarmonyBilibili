import HomeBean from '../bean/HomeBean'

@Component
export struct SearchArticleDetails {
  @State message: string = '图文'

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