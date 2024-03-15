import { SearchHeader } from '../component/SearchHeader'
import router from '@ohos.router'
import { SearchVideoDetails } from '../component/SearchVideo'
import { SearchDefaultDetails } from '../component/SearchDefault'
import { SearchMediaBangumiDetails } from '../component/SearchMediaBangumi'
import { SearchBiliUserDetails } from '../component/SearchBiliUser'
import { SearchArticleDetails } from '../component/SearchArticle'
import Api from '../net/Api'
import { topTlistBean } from '../bean/SearchBaseBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { Loading } from '../component/LoadingComponent'
import { SearchMediaFt } from '../component/SearchMediaFt'
import { SearchLiving } from '../component/SearchLiving'


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
  typeArray: SearchType[] = [SearchType.ALL, SearchType.VIDEO, SearchType.MEDIA_BANGUMI, SearchType.LIVE, SearchType.BILI_USER, SearchType.MEDIA_FT,SearchType.ARTICLE]

  @State videoTitle: string = "视频"
  @State mediaBangumiTitle: string = "番剧"
  @State mediaFtTitle: string = "影视"
  @State liveTitle: string = "直播"
  @State biliUserTitle: string = "用户"
  @State articleTitle: string = "图文"

  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @State errMessage:string =''

  // 超过99的变成99+
  setTitleNum(title:number):string{
    let res = `${title}`
    if (title>99) {
      res = "99+"
    }
    return res;
  }
  upDataTitleTab(topList: topTlistBean) {
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

  aboutToAppear() {
    this.search = router.getParams()['keyword']
    Api.getSearchDefault(this.search).then(response => {
      response.seid
      this.upDataTitleTab(response.top_tlist)
      this.loadingStatus = LoadingStatus.LoadingSuccess
    }).catch (err=>{
      this.errMessage = err
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  @Builder
  TabBuilder(type: SearchType, name: string) {
    Column() {
      Text(name)
        .fontColor(this.type === type ? Color.Pink : Color.Grey)
        .fontSize(14)
        .lineHeight(22)
        .maxLines(1)
        .margin({ bottom: 4 })
      Divider()
        .strokeWidth(2)
        .color(Color.Pink)
        .opacity(this.type === type ? 1 : 0)
        .width('60%')
    }.width('22%')
  }

  build() {
    Column() {
      SearchHeader({ title: this.search, search: this.search, clickEvent: (msg: string) => {
        this.upDateType()
      } })
      if (this.loadingStatus ===LoadingStatus.LoadingSuccess){
        Tabs({ barPosition: BarPosition.Start }) {
          TabContent() {
            SearchDefaultDetails()
          }.tabBar(this.TabBuilder(SearchType.ALL, "综合"))

          TabContent() {
            // 视频页面
            SearchVideoDetails({ search: this.search, searchRequest: this.searchVideoRequest })
          }.tabBar(this.TabBuilder(SearchType.VIDEO, this.videoTitle))

          TabContent() {
            SearchMediaBangumiDetails()
          }.tabBar(this.TabBuilder(SearchType.MEDIA_BANGUMI, this.mediaBangumiTitle))

          TabContent() {
            SearchLiving()
          }.tabBar(this.TabBuilder(SearchType.LIVE, this.liveTitle))

          TabContent() {
            SearchBiliUserDetails()
          }.tabBar(this.TabBuilder(SearchType.BILI_USER, this.biliUserTitle))
          TabContent() {
            SearchMediaFt()
          }.tabBar(this.TabBuilder(SearchType.MEDIA_FT, this.mediaFtTitle))

          TabContent() {
            SearchArticleDetails()
          }.tabBar(this.TabBuilder(SearchType.ARTICLE, this.articleTitle))
        }
        .vertical(false)
        .barMode(BarMode.Scrollable)
        .scrollable(false)
        .animationDuration(200)
        .onChange((index: number) => {
          this.type = this.typeArray[index]
        })
        .layoutWeight(1)
      }else if (this.loadingStatus === LoadingStatus.Loading){
        Loading().width('100%').layoutWeight(1)
      }else{
        Text("加载失败:"+this.errMessage)
          .width("100%")
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }

    }.width('100%')
    .height('100%')
  }

  upDateType() {
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
// 图文：article
// 话题：topic
// 用户：bili_user
// 相簿：photo
enum SearchType {
  ALL = 'all',
  VIDEO = 'video',
  MEDIA_BANGUMI = 'media_bangumi',
  MEDIA_FT = 'media_ft', // 影视
  LIVE = 'live',
  LIVE_USER = 'live_user',
  ARTICLE = 'article',
  TOPIC = 'topic',
  BILI_USER = 'bili_user',
  PHOTO = 'photo',
}