import { Utils } from '../Utils/Utils'
import { HomePage } from './HomePage'
import { MinePage } from './MinePage'
import { MomentPage } from './MomentPage'
import { NewPage } from './NewPage'
import { ShoppingPage } from './ShoppingPage'
import deviceInfo from '@ohos.deviceInfo';

class TabIcon {
  text: string
  index: number
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
  @State tabs: Array<TabIcon> = [new TabIcon('首页', $r('app.media.ic_tab_bar_home')),
    new TabIcon('动态', $r('app.media.ic_tab_bar_moments')),
    new TabIcon('', $r('app.media.ic_tab_bar_add')),
    new TabIcon('会员购', $r('app.media.ic_tab_bar_shopping')),
    new TabIcon('我的', $r('app.media.ic_tab_bar_mine'))]

  @State currentTab :TabIcon = this.tabs[0]
  aboutToAppear(){
    Utils.Toast("型号："+deviceInfo.deviceType + "系统版本："+ deviceInfo.osFullName+ "  SDKApi："+deviceInfo.sdkApiVersion)
  }

  build() {
    Tabs(){
      TabContent(){
        HomePage()
      }.tabBar(this.TabBuilder(0))
      TabContent(){
        MomentPage()
      }.tabBar(this.TabBuilder(1))
      TabContent(){
        NewPage()
      }.tabBar(this.TabBuilder(2))
      TabContent(){
        ShoppingPage()
      }.tabBar(this.TabBuilder(3))
      TabContent(){
        MinePage()
      }.tabBar(this.TabBuilder(4))
    }
    .barMode(BarMode.Fixed)
    .scrollable(false)
    .barPosition(BarPosition.End)
    .layoutWeight(1)
    .onChange((index)=>{
      this.currentTab = this.tabs[index]
    })
  }
  @Builder TabBuilder(index: number) {
    Column() {
      Image(this.currentTab.text === this.tabs[index].text ? this.tabs[index].path : this.tabs[index].path)
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
        .fillColor(this.currentTab.text === this.tabs[index].text ?$r('app.color.bilibili_theme'):Color.Black)
        .objectFit(ImageFit.Contain)
      Text(this.tabs[index].text)
        .fontColor(this.currentTab.text === this.tabs[index].text ?$r('app.color.bilibili_theme') : $r('app.color.bilibili_text_black'))
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.width('100%')
  }
}