import { SearchHeader } from '../component/SearchHeader'
import router from '@ohos.router'
import { SearchVideoDetails } from '../component/SearchDetails'


@Entry
@Component
struct SearchPage {
  @State search: string = '搜索视频、番剧或up主'
  @State currentIndex: number = 0
  @State searchVideoRequest: string = ''
  @State searchMediaBangumiRequest: string = ''
  @State searchMediaFtRequest: string = ''
  @State searchLiveRequest: string = ''
  @State searchArticleRequest: string = ''
  @State searchLiveUserRequest: string = ''
  @State searchTopicRequest: string = ''
  @State searchBiliUserRequest: string = ''
  @State searchPhotoRequest: string = ''
  @State type: SearchType = SearchType.ALL
  typeArray:SearchType[] = [SearchType.ALL,SearchType.VIDEO,SearchType.MEDIA_BANGUMI,SearchType.LIVE,SearchType.BILI_USER,SearchType.ARTICLE]
  aboutToAppear() {
    this.search = router.getParams()['keyword']
  }

  @Builder
  TabBuilder(type: SearchType, name: string) {
    Column() {
      Text(name)
        .fontColor(this.type === type ? Color.Pink : Color.Grey)
        .fontSize(16)
        .fontWeight(this.type === type ? 500 : 400)
        .lineHeight(22)
        .margin({ bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color(Color.Pink)
        .opacity(this.type === type ? 1 : 0)
        .width('60%')
    }.width('100%')
  }

  build() {
    Column() {
      SearchHeader({ title: this.search, search: this.search, clickEvent: (msg: string) => {
        this.upDateType()
      } })
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          Text("综合")
        }.tabBar(this.TabBuilder(SearchType.ALL, "综合"))
        TabContent() {
          // 视频页面
          SearchVideoDetails({ search: this.search, searchRequest: this.searchVideoRequest })
        }.tabBar(this.TabBuilder(SearchType.VIDEO, "视频"))
        TabContent() {
          Text("番剧")
        }.tabBar(this.TabBuilder(SearchType.MEDIA_BANGUMI, "番剧"))
        TabContent() {
          Text("直播")
        }.tabBar(this.TabBuilder(SearchType.LIVE, "直播"))

        TabContent() {
          Text("用户")
        }.tabBar(this.TabBuilder(SearchType.BILI_USER, "用户"))
        TabContent() {
          Text("图文")
        }.tabBar(this.TabBuilder(SearchType.ARTICLE, "图文"))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .animationDuration(200)
      .onChange((index: number) => {
        this.type = this.typeArray[index]
      })
      .layoutWeight(1)
    }.width('100%')
    .height('100%')
  }

  upDateType(){
  switch (this.type) {
    case SearchType.VIDEO: {
      this.searchVideoRequest = this.search
      break
    }
    case SearchType.PHOTO: {
      this.searchPhotoRequest = this.search
      break
    }
    case SearchType.MEDIA_BANGUMI: {
      this.searchMediaBangumiRequest = this.search
      break
    }
    case SearchType.MEDIA_FT: {
      this.searchMediaFtRequest = this.search
      break
    }
    case SearchType.LIVE: {
      this.searchLiveRequest = this.search
      break
    }
    case SearchType.LIVE_USER: {
      this.searchLiveUserRequest = this.search
      break
    }
    case SearchType.ARTICLE: {
      this.searchArticleRequest = this.search
      break
    }
    case SearchType.BILI_USER: {
      this.searchBiliUserRequest = this.search
      break
    }
    default: {
      this.searchTopicRequest = this.search
      break
    }
  }
}
}



// 视频：video
// 番剧：media_bangumi
// 影视：media_ft
// 直播间及主播：live
// 直播间：live_room
// 主播：live_user
// 专栏：article
// 话题：topic
// 用户：bili_user
// 相簿：photo
enum SearchType {
  ALL = 'all',
  VIDEO = 'video',
  MEDIA_BANGUMI = 'media_bangumi',
  MEDIA_FT = 'media_ft',
  LIVE = 'live',
  LIVE_USER = 'live_user',
  ARTICLE = 'article',
  TOPIC = 'topic',
  BILI_USER = 'bili_user',
  PHOTO = 'photo',
}