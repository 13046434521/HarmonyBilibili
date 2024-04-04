import { HomeBeanItem } from '../bean/HomeBean'
import Api from '../net/Api'
import router from '@ohos.router'
import ApiLogin from '../net/ApiLogin'
import { Utils } from '../Utils/Utils'
import StorageManager from '../common/StorageManager'
import webview from '@ohos.web.webview'


@Entry
@Component
struct SplashPage {
  homeBeanData: Array<HomeBeanItem> = null
  @State content: string = "加载中..."

  @StorageLink('isLogin') isLogin:boolean = false
  @StorageLink('login_img_url') loginIcon :string = ''
  @StorageLink('bilibili_cookie') cookie :string = ''
  aboutToAppear() {
    this.cookie="DedeUserID=68406011;DedeUserID__ckMd5=ecb0ad5cd0bcd251;Expires=1726995029;SESSDATA=3cd4e8a3%2C1726995029%2C2c018*31CjDoM1Zr4KPtkw7itX5UpWdKtyd_PclBy8Dew0oMYwOABq7vQwq_XMrcC3_ALgqsIVgSVnR6NTBXMTBCV0IxWmxCMEN4VV9EUkVrNGlnQ0cxczdTal9IQkFHZnhUVGU3R09HU09CQTRqdXU1QnZ6T3ZaUnUyUVRjMklXTnlFR3VCV2liZVVSVkNBIIEC;bili_jct=5a92cb28818fcbe9d658f0792cf28a7f;gourl=httpswww.bilibili.com"
    this.update()
  }

  build() {
    Stack() {
      Column() {
        Image($r('app.media.ic_splash_default'))
          .width('50%')
          .objectFit(ImageFit.Cover)
      }.width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Button(this.content)
        .width(120)
        .aspectRatio(3)
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
        StorageManager.setKey(response.wbi_img.img_url,response.wbi_img.sub_url)
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