import { HomeBeanItem } from '../bean/HomeBean'
import Api from '../net/Api'
import router from '@ohos.router'

@Entry
@Component
@Preview
struct SplashPage{
  homeBeanData:Array<HomeBeanItem>=null
  @State content:string = "加载中..."

  aboutToAppear(){
    this.update()
  }

  build(){
    Stack(){
      Image($r('app.media.ic_splash_default'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Contain)

      Text(this.content).width('28%')
        .aspectRatio(2.5)
        .fontSize(14)
        .textAlign(TextAlign.Center)
        .borderColor(Color.Gray)
        .borderRadius(4)
        .margin(8)


    }.alignContent(Alignment.TopEnd)
  }

  update(){
    Api.getHomePages().then(homebean=>{
      this.homeBeanData = homebean.item
    }).finally(()=>{
      this.content =this.homeBeanData!==null?`加载成功:${this.homeBeanData.length}`:'加载失败'

      router.replaceUrl({
        url: 'pages/Index',
        params: {
          'homeData': this.homeBeanData
        }
      }, router.RouterMode.Single)
    })
  }
}