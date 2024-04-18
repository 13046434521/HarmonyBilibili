import { topTlistBean } from '../bean/search/SearchBaseBean'
import { SearchArticleDetails } from './SearchArticle'
import { SearchBiliUserDetails } from './SearchBiliUser'
import { SearchDefaultDetails } from './SearchDefault'
import { SearchLiving } from './SearchLiving'
import { SearchMediaBangumiDetails } from './SearchMediaBangumi'
import { SearchMediaFt } from './SearchMediaFt'

@Component
export struct SearchTabsAll {
  @State videoTitle: string = "视频"
  @State mediaBangumiTitle: string = "番剧"
  @State mediaFtTitle: string = "影视"
  @State liveTitle: string = "直播"
  @State biliUserTitle: string = "用户"
  @State articleTitle: string = "图文"
  @Prop search: string
  @Prop @Watch('upDataTitle')topList: topTlistBean = new topTlistBean()
  @State @Watch('isPageShow') currentIndex :number = 0
  @State pageShow:boolean[] = [true,false,false,false,false]
  controller:TabsController = new TabsController()
  aboutToAppear(){
    console.log("SearchTabsAll 页面刷新了")
    this.upDataTitle()
  }

  aboutToDisappear(){
    console.log("SearchTabsAll 页面销毁了")
  }

  build() {
    this.tabPages()
  }
  isPageShow(){
    this.pageShow[this.currentIndex] = true
  }
  @Builder
  TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? $r('app.color.bilibili_theme') : $r('app.color.bilibili_text_grey_bold'))
        .fontSize(14)
        .maxLines(1)
        .textAlign(TextAlign.Center)
        .margin({ top:"4%" ,left:"4%",right:"4%",bottom:'4%'})
      Divider()
        .strokeWidth(2)
        .color($r('app.color.bilibili_theme'))
        .opacity(this.currentIndex === index  ? 1 : 0)
        .width('50%')
    }.width('17%')
    .height('60%')
    .stateStyles({pressed:pressedStyles,normal:normalStyles})
    .borderRadius(5)
    .onClick(()=>{
      this.currentIndex = index
      this.controller.changeIndex(this.currentIndex)
    }).justifyContent(FlexAlign.Center)
  }

  @Builder
  tabPages() {
    Tabs({ barPosition: BarPosition.Start,controller:this.controller,index:0}) {
      TabContent() {
        if (this.pageShow[0]){
          SearchDefaultDetails({ search: this.search })
        }
      }.tabBar(this.TabBuilder(0,"综合"))
/*      TabContent() {
        // 视频页面 2024-4-5 视频页面合并到综合当中，并实现按弹幕，播放量等排序
        SearchVideoDetails({ search: this.search })
      }.tabBar(this.TabBuilder(1, this.videoTitle))*/

      TabContent() {
        if (this.pageShow[1]){
          SearchMediaBangumiDetails({ search: this.search })
        }
      }.tabBar(this.TabBuilder(1,this.mediaBangumiTitle))

      TabContent() {
        if (this.pageShow[2]){
          SearchLiving({ search: this.search })
        }

      }.tabBar(this.TabBuilder(2,this.liveTitle))

      TabContent() {
        if (this.pageShow[3]){
          SearchBiliUserDetails({ search: this.search })
        }
      }.tabBar(this.TabBuilder(3,this.biliUserTitle))

      TabContent() {
        if (this.pageShow[4]){
          SearchMediaFt({ search: this.search })
        }
      }.tabBar(this.TabBuilder(4,this.mediaFtTitle))

      TabContent() {
        if (this.pageShow[5]){
          SearchArticleDetails({ search: this.search })
        }
      }.tabBar(this.TabBuilder(5,this.articleTitle))
    }
    .width('100%')
    .vertical(false)
    .scrollable(true)
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

@Styles function  pressedStyles() {
  .backgroundColor($r('app.color.bilibili_background_grey'))
}

@Styles function  normalStyles() {
  .backgroundColor($r('app.color.bilibili_background_white'))
}