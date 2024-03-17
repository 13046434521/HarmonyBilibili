import { topTlistBean } from '../bean/SearchBaseBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
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
  @State type: SearchType = SearchType.ALL
  typeArray: SearchType[] = [SearchType.ALL, SearchType.VIDEO, SearchType.MEDIA_BANGUMI, SearchType.LIVE, SearchType.BILI_USER, SearchType.MEDIA_FT, SearchType.ARTICLE]
  @State videoTitle: string = "视频"
  @State mediaBangumiTitle: string = "番剧"
  @State mediaFtTitle: string = "影视"
  @State liveTitle: string = "直播"
  @State biliUserTitle: string = "用户"
  @State articleTitle: string = "图文"
  @Link loadingStatus: LoadingStatus
  @Prop search: string
  controller: TabsController = new TabsController()

  aboutToAppear(){
    console.log("SearchTabsAll 页面刷新了")
  }
  aboutToDisappear(){
    console.log("SearchTabsAll 页面销毁了")
  }
  test(){
    console.log("页面:controller出问题了"+this.controller)
  }

  build() {
    Column() {
      Button("状态归0").onClick(()=>{
        this.test()
        this.type = SearchType.ALL
        this.controller.changeIndex(3)
      })
      LoadingData({ loadingStatus: this.loadingStatus, page: this.tabPages.bind(this) })
        .width('100%')
        .height('100%')
    }.width('100%').height('100%')

  }

  @Builder
  TabBuilder(type: SearchType, name: string) {
    Column() {
      Text(name)
        .fontColor(this.type === type ? $r('app.color.bilibili_theme') : $r('app.color.bilibili_text_grey_bold'))
        .fontSize(14)
        .maxLines(1)
        .textAlign(TextAlign.Center)
        .margin({ bottom: 8 })
      Divider()
        .strokeWidth(2)
        .color($r('app.color.bilibili_theme'))
        .opacity(this.type === type ? 1 : 0)
        .width('60%')
    }.width('18%')
    .onClick(() => {
      // this.type = type
      let index = this.upDatePage(type)
      this.controller.changeIndex(index)
      // Utils.Toast( this.controller[0]+"  "+this.type.toString() + "  --- "+index+"   " + type.toString() + " --- " + name)
    })
  }

  @Builder
  tabPages() {
    Tabs({ barPosition: BarPosition.Start, controller: new TabsController() }) {
      TabContent() {
        SearchDefaultDetails()
      }.tabBar(this.TabBuilder(SearchType.ALL, "综合"))

      TabContent() {
        // 视频页面
        SearchVideoDetails({ search: this.search })
      }.tabBar(this.TabBuilder(SearchType.VIDEO, this.videoTitle))

      TabContent() {
        SearchMediaBangumiDetails({ search: this.search })
      }.tabBar(this.TabBuilder(SearchType.MEDIA_BANGUMI, this.mediaBangumiTitle))

      TabContent() {
        SearchLiving({ search: this.search })
      }.tabBar(this.TabBuilder(SearchType.LIVE, this.liveTitle))

      TabContent() {
        SearchBiliUserDetails({ search: this.search })
      }.tabBar(this.TabBuilder(SearchType.BILI_USER, this.biliUserTitle))

      TabContent() {
        SearchMediaFt({ search: this.search })
      }.tabBar(this.TabBuilder(SearchType.MEDIA_FT, this.mediaFtTitle))

      TabContent() {
        SearchArticleDetails({ search: this.search })
      }.tabBar(this.TabBuilder(SearchType.ARTICLE, this.articleTitle))
    }
    .width('100%')
    .vertical(false)
    .scrollable(true)
    .barWidth('100%')
    .barMode(BarMode.Scrollable)
    .animationDuration(200)
    .onChange((index: number) => {
      Utils.Toast(this.type+"   "+this.typeArray[index]+"   "+index)
      this.type = this.typeArray[index]
      this.controller.changeIndex(index)
    }).hitTestBehavior(HitTestMode.Transparent)
  }


  upDatePage(type: SearchType): number {
    for (let index = 0; index < this.typeArray.length; index++) {
      if (type === this.typeArray[index]) {
        return index
      }
    }
    return 0
  }

  // 超过99的变成99+
  setTitleNum(title: number): string {
    let res = `${title}`
    if (title > 99) {
      res = "99+"
    }
    return res;
  }
}