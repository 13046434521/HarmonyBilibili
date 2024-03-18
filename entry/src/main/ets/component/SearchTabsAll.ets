import { topTlistBean } from '../bean/SearchBaseBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { Utils } from '../Utils/Utils'
import { LoadingData } from './LoadingData'
import { SearchArticleDetails } from './SearchArticle'
import { SearchBiliUserDetails } from './SearchBiliUser'
import { SearchDefaultDetails } from './SearchDefault'
import { SearchLiving } from './SearchLiving'
import { SearchMediaBangumiDetails } from './SearchMediaBangumi'
import { SearchMediaFt } from './SearchMediaFt'
import { SearchVideoDetails } from './SearchVideo'

@Component
export struct SearchTabsAll {
  @State videoTitle: string = "视频"
  @State mediaBangumiTitle: string = "番剧"
  @State mediaFtTitle: string = "影视"
  @State liveTitle: string = "直播"
  @State biliUserTitle: string = "用户"
  @State articleTitle: string = "图文"
  @Prop loadingStatus: LoadingStatus
  @Prop search: string
  @Prop @Watch('upDataTitle')topList: topTlistBean = new topTlistBean()
  @State currentIndex :number = 0
  controller:TabsController = new TabsController()

  aboutToAppear(){
    console.log("SearchTabsAll 页面刷新了")
  }
  aboutToDisappear(){
    console.log("SearchTabsAll 页面销毁了")
  }

  build() {
    LoadingData({ loadingStatus: this.loadingStatus, page: this.tabPages.bind(this)})
      .layoutWeight(1)
  }

  @Builder
  TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? $r('app.color.bilibili_theme') : $r('app.color.bilibili_text_grey_bold'))
        .fontSize(14)
        .maxLines(1)
        .textAlign(TextAlign.Center)
        .margin({ bottom: 8 })
      Divider()
        .strokeWidth(2)
        .color($r('app.color.bilibili_theme'))
        .opacity(this.currentIndex === index  ? 1 : 0)
        .width('60%')
    }.width('18%')
    .onClick(()=>{
      this.currentIndex = index
      this.controller.changeIndex(this.currentIndex)
    })
  }

  @Builder
  tabPages() {
    Tabs({ barPosition: BarPosition.Start,controller:this.controller}) {
      TabContent() {
        SearchDefaultDetails()
      }.tabBar(this.TabBuilder(0, "综合"))
      TabContent() {
        // 视频页面
        SearchVideoDetails({ search: this.search })
      }.tabBar(this.TabBuilder(1, this.videoTitle))

      TabContent() {
        SearchMediaBangumiDetails({ search: this.search })
      }.tabBar(this.TabBuilder(2, this.mediaBangumiTitle))

      TabContent() {
        SearchLiving({ search: this.search })
      }.tabBar(this.TabBuilder(3, this.liveTitle))

      TabContent() {
        SearchBiliUserDetails({ search: this.search })
      }.tabBar(this.TabBuilder(4, this.biliUserTitle))

      TabContent() {
        SearchMediaFt({ search: this.search })
      }.tabBar(this.TabBuilder(5, this.mediaFtTitle))

      TabContent() {
        SearchArticleDetails({ search: this.search })
      }.tabBar(this.TabBuilder(6, this.articleTitle))
    }
    .width('100%')
    .vertical(false)
    .scrollable(true)
    .barWidth('100%')
    .barMode(BarMode.Scrollable)
    .animationDuration(200)
    .onChange((index: number) => {
      this.currentIndex = index
      this.controller.changeIndex(this.currentIndex)
    })
  }

  upDataTitle(){
    this.videoTitle="视频"+this.setTitleNum(this.topList.video)
    this.mediaBangumiTitle="番剧"+this.setTitleNum(this.topList.media_bangumi)
    this.mediaFtTitle="影视"+this.setTitleNum(this.topList.media_ft)
    this.liveTitle="直播"+this.setTitleNum(this.topList.live)
    this.biliUserTitle="用户"+this.setTitleNum(this.topList.bili_user)
    this.articleTitle="图文"+this.setTitleNum(this.topList.article)
  }
  // 超过99的变成99+
  setTitleNum(title: number): string {
    let res = `(${title})`
    if (title > 99) {
      res = "(99+)"
    }
    if (title<=0) {
      res=''
    }
    return res;
  }
}