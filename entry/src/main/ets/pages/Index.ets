import { HomePage } from './HomePage'
import { MinePage } from './MinePage'
import { MomentPage } from './MomentPage'
import { NewPage } from './NewPage'
import { ShoppingPage } from './ShoppingPage'

@Observed
class TabIcon {
  text: string
  num: number
  path: Resource

  constructor(text: string, path: Resource) {
    this.text = text
    this.path = path
  }
}
/**
 * Index主页面
 */
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State tabs: Array<TabIcon> = [new TabIcon('首页', $r('app.media.ic_tab_bar_home')),
    new TabIcon('动态', $r('app.media.ic_tab_bar_moments')),
    new TabIcon('', $r('app.media.ic_tab_bar_add')),
    new TabIcon('会员购', $r('app.media.ic_tab_bar_shopping')),
    new TabIcon('我的', $r('app.media.ic_tab_bar_mine'))]

  @State currentTab :TabIcon = null


  build() {
    Tabs(){
      TabContent(){
        HomePage()
      }.tabBar(new BottomTabBarStyle(this.tabs[0].path, this.tabs[0].text))
      TabContent(){
        MomentPage()
      }.tabBar(new BottomTabBarStyle(this.tabs[1].path, this.tabs[1].text))
      TabContent(){
        NewPage()
      }.tabBar(new BottomTabBarStyle(this.tabs[2].path, this.tabs[2].text))
      TabContent(){
        ShoppingPage()
      }.tabBar(new BottomTabBarStyle(this.tabs[3].path, this.tabs[3].text))
      TabContent(){
        MinePage()
      }.tabBar(new BottomTabBarStyle(this.tabs[4].path, this.tabs[4].text))
    }
    .barMode(BarMode.Fixed)
    .scrollable(true)
    .barPosition(BarPosition.End)
    .layoutWeight(1)
    .height('100%')
    .width('100%')
  }

  @Builder
  NavigationToolbar() {
    Row() {
      ForEach(this.tabs, item => {
        Column() {
          Image(item.path)
            .width(28)
            .height(28)

          Text(item.text)
            .fontColor(this.currentTab == item ? '#007DFF' : '#182431')
            .fontSize(this.currentTab == item?14:12)
            .lineHeight(14)
            .fontWeight(500)
            .margin({ top: 8 })
        }.width('20%')
        .height(64)
        .onClick(() => {
          this.currentTab = item
        })
      })
    }.justifyContent(FlexAlign.SpaceEvenly)
  }
}