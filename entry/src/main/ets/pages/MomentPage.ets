import { LoadingStatus } from '../common/LoadingStatus'
import { Loading } from '../component/LoadingComponent'
import { Utils } from '../Utils/Utils'

@Component
// 动态页面
@Preview
export struct MomentPage {
  @State message: string = '动态'

@State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()

  aboutToAppear(){
    this.test()


    console.log("我是4")
  }

  async test(){
    console.log("我是1")

    await this.test1()
    await this.test2()
    console.log("我是3")
  }

  test1(){
    return new Promise((resolve)=>{
      setTimeout(()=>{
        resolve( console.log("我是2.1"))
      },3000)
    }).then(()=>{
      // Utils.Toast("我是2.1")
    })
  }

  test2(){
    return new Promise((resolve)=>{
      setTimeout(()=>{
        resolve(console.log("我是2.2"))
      },1000)
    }).then(()=>{
      // Utils.Toast("我是2.2")
    })
  }

  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width('100%')
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        TabContent() {
          Column(){
            Loading()

          }.width('100%').height('100%').backgroundColor('#00CB87')
        }.tabBar(this.TabBuilder(0, 'green'))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor('#007DFF')
        }.tabBar(this.TabBuilder(1, 'blue'))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor('#FFBF00')
        }.tabBar(this.TabBuilder(2, 'yellow'))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor('#E67C92')
        }.tabBar(this.TabBuilder(3, 'pink'))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth(360)
      .barHeight(56)
      .animationDuration(400)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width(360)
      .height(296)
      .margin({ top: 52 })
      .backgroundColor('#F1F3F5')
    }.width('100%')
  }
}