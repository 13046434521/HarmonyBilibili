import { Utils } from '../Utils/Utils'
import { HomePage } from './Home/HomePage'
import { MinePage } from './Home/MinePage'
import { MomentPage } from './Home/MomentPage'
import { NewPage } from './Home/NewPage'
import { ShoppingPage } from './Home/ShoppingPage'
import deviceInfo from '@ohos.deviceInfo';
import Constants from '../common/Constants'

@Observed
export class TabIcon {
  text: string
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
  controller:TabsController = new TabsController()
  @StorageProp('background_color') backgroundColors :string = Constants.BACKGROUND_DAY
  aboutToAppear(){
    Utils.Toast("型号："+deviceInfo.deviceType + "  系统版本："+ deviceInfo.osFullName+ "  SDKApi："+deviceInfo.sdkApiVersion)
  }

  onLoginClick:()=>void =()=>{
    this.currentTab = this.tabs[4]
    this.controller.changeIndex(4)
  }

  build() {
    Column(){
      Tabs({controller:this.controller}){
        TabContent(){
          HomePage({onLoginClick:this.onLoginClick})
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
    .backgroundColor(this.backgroundColors)
  }
  @Builder TabBuilder(index: number) {
    Column() {
      Image(this.currentTab.text === this.tabs[index].text ? this.tabs[index].path : this.tabs[index].path)
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
        .fillColor(this.currentTab.text === this.tabs[index].text ?$r('app.color.bilibili_theme'):$r('app.color.bilibili_text_black_middle'))
        .objectFit(ImageFit.Contain)
      Text(this.tabs[index].text)
        .fontColor(this.currentTab.text === this.tabs[index].text ?$r('app.color.bilibili_theme') : $r('app.color.bilibili_text_black_middle'))
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.width('100%')
    .backgroundColor(this.backgroundColors)
  }
}