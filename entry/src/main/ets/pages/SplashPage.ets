import { HomeBeanItem } from '../bean/HomeBean'
import Api from '../net/Api'
import router from '@ohos.router'
import ApiLogin from '../net/ApiLogin'
import { Utils } from '../Utils/Utils'
import StorageManager from '../common/StorageManager'
import webview from '@ohos.web.webview'
import { PageManager } from '../common/PageManager'


@Entry
@Component
struct SplashPage {
  homeBeanData: Array<HomeBeanItem> = null
  @State content: string = "加载中..."

  @StorageLink('isLogin') isLogin:boolean = false
  @StorageLink('login_img_url') loginIcon :string = ''
  @StorageLink('bilibili_cookie') cookie :string = ''
  aboutToAppear() {
    // this.cookie="SESSDATA=30309593%2C1727972062%2Cb9920%2A42CjA8Qo8z1dtk_GMJ5ZbYy27pYtLsR34iB24EmmJnsaWM0Jq1SYQrG4PX0LC9ARiD3dgSVjFORzlybkpHc1VNVHU0dlBLa0VpRm5NaDFsSGp4ZlNjVTV1ZlVfdUp5OTlkYnpKSFVQazRaa19PbGw0TXc1OEc2TTc3M3hSakNmVDdheFJTUDJNRmR3IIEC; bili_jct=e8fbf10f85318c0011ea9d9659b8891a; DedeUserID=68406011; DedeUserID__ckMd5=ecb0ad5cd0bcd251; sid=4y5btiio;"
    this.cookie="SESSDATA=43fba99d%2C1728233851%2Cf5164%2A41CjD6W9xovTQQi_W_xtqhnQws7B7y6_uJ9WmwkIfs5icwTeSP0-oJcI7SlMEJwIO0Sk0SVnN6M1VRNThLRTA5ZTRydDd0NGlZMm5MWFVyZzY3S3pNVFMyMDJnOENhV0tLeE5Pa2poWTYtS21WME5XV3ZFZTRyY3VLZHp4Q19Eb3h5bVpvaFZqaWpBIIEC"
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
        this.content = this.homeBeanData !== null ? `加载成功:${this.homeBeanData.length}` : '加载失败'
        PageManager.routerIndex(this.homeBeanData)
      })
  }
}