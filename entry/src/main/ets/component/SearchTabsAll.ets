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
  @State currentIndex: number = 0
  @State type: SearchType = SearchType.ALL
  typeArray: SearchType[] = [SearchType.ALL, SearchType.VIDEO, SearchType.MEDIA_BANGUMI, SearchType.LIVE, SearchType.BILI_USER, SearchType.MEDIA_FT, SearchType.ARTICLE]
  @State videoTitle: string = "视频"
  @State mediaBangumiTitle: string = "番剧"
  @State mediaFtTitle: string = "影视"
  @State liveTitle: string = "直播"
  @State biliUserTitle: string = "用户"
  @State articleTitle: string = "图文"
  @Link loadingStatus: LoadingStatus
  @Prop @Watch('upDataTitleTab') topList: topTlistBean
  @Prop search: string = ""
  private controller: TabsController = new TabsController()

  build() {
    LoadingData({ loadingStatus: this.loadingStatus, page: this.tabPages.bind(this) })
      .width('100%')
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
  }

  @Builder
  tabPages() {
    Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
      TabContent() {
        SearchDefaultDetails()
      }.tabBar(this.TabBuilder(SearchType.ALL, "综合"))

      TabContent() {
        // 视频页面
        SearchVideoDetails({ search: this.search })
      }.tabBar(this.TabBuilder(SearchType.VIDEO, this.videoTitle))

      TabContent() {
        SearchMediaBangumiDetails({
          search: this.search,
        })
      }.tabBar(this.TabBuilder(SearchType.MEDIA_BANGUMI, this.mediaBangumiTitle))

      TabContent() {
        SearchLiving({ search: this.search })
      }.tabBar(this.TabBuilder(SearchType.LIVE, this.liveTitle))

      TabContent() {
        SearchBiliUserDetails({
          search: this.search,
        })
      }.tabBar(this.TabBuilder(SearchType.BILI_USER, this.biliUserTitle))

      TabContent() {
        SearchMediaFt({ search: this.search })
      }.tabBar(this.TabBuilder(SearchType.MEDIA_FT, this.mediaFtTitle))

      TabContent() {
        SearchArticleDetails({
          search: this.search,
        })
      }.tabBar(this.TabBuilder(SearchType.ARTICLE, this.articleTitle))
    }
    .width('100%')
    .vertical(false)
    .scrollable(false)
    .barWidth('100%')
    .barMode(BarMode.Scrollable)
    .animationDuration(200)
    .onChange((index: number) => {
      this.type = this.typeArray[index]
      // Utils.Toast(this.type)
    })
  }

  upDataTitleTab(topList: topTlistBean) {
    Utils.Toast("upDataTitleTab:"+topList.video)
    if (topList.video != 0) {
      this.videoTitle = `视频(${this.setTitleNum(topList.video)})`
    }
    if (topList.media_bangumi != 0) {
      this.mediaBangumiTitle = `番剧(${this.setTitleNum(topList.media_bangumi)})`
    }
    if (topList.live != 0) {
      this.liveTitle = `直播(${this.setTitleNum(topList.live)})`
    }
    if (topList.bili_user != 0) {
      this.biliUserTitle = `用户(${this.setTitleNum(topList.bili_user)})`
    }
    if (topList.media_ft != 0) {
      this.mediaFtTitle = `影视(${this.setTitleNum(topList.media_ft)})`
    }
    if (topList.article != 0) {
      this.articleTitle = `图文(${this.setTitleNum(topList.article)})`
    }
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