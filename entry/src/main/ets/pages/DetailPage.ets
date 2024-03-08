@Entry
@Component
struct DetailPage {
  @State isRefreshing: boolean = false
  @State counter: number = 0

  build() {
    Column() {
      Search({ placeholder: "this.homeSearchBeanData.show_name" })
        .height(40)
        .width(200)
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14, weight: 400 })
        .textFont({ size: 14, weight: 400 })
        .focusable(true)
    }
  }
}
