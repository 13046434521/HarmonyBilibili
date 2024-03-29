import { HomeBeanItem } from '../bean/HomeBean'
import Api from '../net/Api'
import router from '@ohos.router'
import ApiLogin from '../net/ApiLogin'
import { Utils } from '../Utils/Utils'


@Entry
@Component
struct SplashPage {
  homeBeanData: Array<HomeBeanItem> = null
  @State content: string = "加载中..."

  @StorageLink('isLogin') isLogin:boolean = false
  @StorageLink('login_img_url') loginIcon :string = ''

  aboutToAppear() {
    this.update()
  }

  build() {
    Stack() {
      Column() {
        Image($r('app.media.ic_splash_default'))
          .width('50%')
          .height('50%')
          .objectFit(ImageFit.Cover)
      }.width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Button(this.content)
        .width('16%')
        .aspectRatio(4)
        .fontSize(14)
        .fontColor($r('app.color.bilibili_text_white'))
        .borderColor($r('app.color.bilibili_background_grey'))
        .backgroundColor($r('app.color.bilibili_theme'))
        .borderRadius(24)
        .margin(8)
    }.alignContent(Alignment.TopEnd)
  }

  update() {
    ApiLogin.loginNav()
      .then(response => {
        this.isLogin = response.isLogin
        this.loginIcon = response.face
        return Api.getHomePages()
      })
      .then(response => {
        this.homeBeanData = response.item
      })
      .catch(e => {
        Utils.Toast(e)
      })
      .finally(() => {
        this.content =this.homeBeanData!==null?`加载成功:${this.homeBeanData.length}`:'加载失败'
        router.replaceUrl({
          url: 'pages/Index',
          params: {
            'homeData': this.homeBeanData,
          }
        }, router.RouterMode.Single)
      })
  }
}