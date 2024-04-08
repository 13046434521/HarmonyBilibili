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
    this.cookie="SESSDATA=30309593%2C1727972062%2Cb9920%2A42CjA8Qo8z1dtk_GMJ5ZbYy27pYtLsR34iB24EmmJnsaWM0Jq1SYQrG4PX0LC9ARiD3dgSVjFORzlybkpHc1VNVHU0dlBLa0VpRm5NaDFsSGp4ZlNjVTV1ZlVfdUp5OTlkYnpKSFVQazRaa19PbGw0TXc1OEc2TTc3M3hSakNmVDdheFJTUDJNRmR3IIEC; bili_jct=e8fbf10f85318c0011ea9d9659b8891a; DedeUserID=68406011; DedeUserID__ckMd5=ecb0ad5cd0bcd251; sid=4y5btiio;"
    //this.cookie="SESSDATA=3ae5643a%2C1727949301%2Cf6efd%2A41CjARWsn5Y2xAXP8Ar8YqQeouM0TYtN51rWVug2aS_4Oknms97dEqkxQGs2wYIHTpmRoSVm5LUEdyb2hCMjhtVGVCQ3ZRVURUSEtsaUtjNHNSMWViUW1WamlPYVFCY3BWNGhpTzlLNmNUR2dWRkFqN1hsckFham1KbWQxQnlxWm8zcVR2UFhjdDRRIIEC"
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