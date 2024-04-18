@Component
export struct RefreshList{
  @BuilderParam listItem:()=>LazyForEachInterface|ForEachInterface
  @Prop refreshController:RefreshController
  build(){
    Refresh({ refreshing: $$this.refreshController.isRefreshing, offset: 0, friction: 50 }) {
      Column(){
        List(){
          ListItemGroup({footer:this.Loading()}){
            this.listItem()
          }.width('100%')
        }.alignListItem(ListItemAlign.Start)
        .lanes(this.refreshController.lanes)
        .cachedCount(this.refreshController.cacheCount)
        .width('100%')
        .height('100%')
        // .sticky(StickyStyle.Header|StickyStyle.Footer)
        .onReachEnd(()=>{
          if (this.refreshController.onLoadMoreListener!==undefined) {
            this.refreshController.onLoadMoreListener()
          }
          console.error('onReachEnd',"onReachEnd:"+this.refreshController.isLoadMore)
        })
        .edgeEffect(EdgeEffect.None)
      }
    }
    .onStateChange((refreshStatus: RefreshStatus) => {
      console.info('Refresh onStatueChange state is ' + refreshStatus)
    })
    .onRefreshing(() => {
      if (this.refreshController.onRefreshListener!==undefined) {
         this.refreshController.onRefreshListener()
      }
      this.refreshController.isLoadMore = true
      this.refreshController.isRefreshing = false
    })
    .height('100%')
    .width('100%')
  }

  @Builder
  Loading(){
    Column(){
      if (this.refreshController.isLoadMore){
        LoadingProgress()
          .width('6%')
          .aspectRatio(1)
          .color($r('app.color.bilibili_theme'))
        Text('加载更多...')
          .fontSize(12)
      }else{
        Text('没有更多数据...╮(╯▽╰)╭...')
          .fontSize(14)
      }

    }.justifyContent(FlexAlign.Center)
    .width('100%')
    .height('8%')
  }
}


export class RefreshListController implements RefreshController{
  isRefreshing: boolean = false
  isLoadMore: boolean = true
  onRefreshListener: () => boolean
  onLoadMoreListener: () => void
  lanes: number
  cacheCount: number

  setRefresh(refresh:boolean){
    this.isRefreshing = refresh
    return this
  }
  setLoadMore(loadMore:boolean){
    this.isLoadMore = loadMore
    return this
  }
  setRefreshListener(refreshListener:() => boolean){
    this.onRefreshListener = refreshListener
    return this
  }
  setLoadMoreListener(loadMoreListener:() => void){
    this.onLoadMoreListener = loadMoreListener
    return this
  }
  setLanes(lanes:number){
    this.lanes = lanes
    return this
  }
  setCacheCount(cacheCount:number){
    this.cacheCount = cacheCount
    return this
  }
}

export interface RefreshController{
  isRefreshing: boolean
  isLoadMore:boolean
  onRefreshListener:()=>boolean
  onLoadMoreListener:()=>void
  lanes :number
  cacheCount :number
}