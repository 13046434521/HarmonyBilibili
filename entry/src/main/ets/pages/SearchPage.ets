import { SearchHeader } from '../component/SearchHeader'
import router from '@ohos.router'
import {SearchVideoDetails } from '../component/SearchDetails'

@Entry
@Component
struct SearchPage{
  @State search: string = '搜索视频、番剧或up主'
  @State currentIndex: number = 0

  aboutToAppear(){
    this.search = router.getParams()['keyword']
  }
  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? Color.Pink : Color.Grey)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color(Color.Pink)
        .opacity(this.currentIndex === index ? 1 : 0)
        .width('60%')
    }.width('100%')
  }

  build(){
    Column(){
      SearchHeader({title:this.search,search:this.search})
      Tabs({barPosition:BarPosition.Start}){
        TabContent(){
          Text("综合")
        }.tabBar(this.TabBuilder(0,"综合"))
        TabContent(){
          SearchVideoDetails({search:this.search})
        }.tabBar(this.TabBuilder(1,"视频"))
        TabContent(){
          Text("直播")
        }.tabBar(this.TabBuilder(2,"直播"))
        TabContent(){
          Text("用户")
        }.tabBar(this.TabBuilder(3,"用户"))
        TabContent(){
          Text("影视")
        }.tabBar(this.TabBuilder(4,"影视"))
        TabContent(){
          Text("图文")
        }.tabBar(this.TabBuilder(5,"图文"))
      }.vertical(false)
      .barMode(BarMode.Fixed)
      .animationDuration(200)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }.width('100%')
    .height('100%')
  }
}