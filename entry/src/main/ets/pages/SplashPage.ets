import { HomeBeanItem } from '../bean/HomeBean'
import Api from '../net/Api'
import router from '@ohos.router'
import Constants from '../common/Constants'
import { Utils } from '../Utils/Utils'

PersistentStorage.PersistProp('bilibili_cookie', Constants.COOKIE)
@Entry
@Component
struct SplashPage{
  homeBeanData:Array<HomeBeanItem>=null
  @State content:string = "加载中..."
  @StorageLink('bilibili_cookie') biliCookie:string  =''
  aboutToAppear(){
    this.update()
    this.cookie()
  }

  build(){
    Stack(){
      Column(){
        Image($r('app.media.ic_splash_default'))
          .width('70%')
          .height('70%')
          .objectFit(ImageFit.Contain)
      }.width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

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

  cookie(){
    console.log('app_log  cookie:' + this.biliCookie)
    Utils.Toast(this.biliCookie+'')
    Constants.COOKIE_NAME = this.biliCookie
  }
}