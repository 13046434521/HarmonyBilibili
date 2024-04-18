@Component
export struct RefreshList{
  @State isRefreshing: boolean = false
  @State counter: number = 0
  // @BuilderParam listItem
  build(){
    Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
      List(){
        ListItemGroup({footer:this.Loading()}){

        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .onStateChange((refreshStatus: RefreshStatus) => {
      console.info('Refresh onStatueChange state is ' + refreshStatus)
    })
    .onRefreshing(() => {
      setTimeout(() => {
        this.counter++
        this.isRefreshing = false
      }, 1000)
      console.log('onRefreshing test')
    })
  }

  @Builder
  Loading(){
    Column(){
      LoadingProgress()
        .width('10%')
        .aspectRatio(1)
      Text('加载更多...')
        .fontSize(12)
    }.justifyContent(FlexAlign.Center)
    .width('100%')
  }
}