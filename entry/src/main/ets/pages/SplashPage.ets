import { HomeBeanItem } from '../bean/HomeBean'
import Api from '../net/Api'
import router from '@ohos.router'
import ApiLogin from '../net/ApiLogin'
import { Utils } from '../Utils/Utils'
import StorageManager from '../common/StorageManager'
import { PageManager } from '../common/PageManager'
import Constants from '../common/Constants'

@Entry
@Component
struct SplashPage {
  homeBeanData: Array<HomeBeanItem>|null = null
  @State content: string = "加载中..."

  @StorageLink('isLogin') isLogin:boolean = false
  @StorageLink('login_img_url') loginIcon :string = ''
  @StorageLink('bilibili_cookie') cookie :string = ''
  aboutToAppear() {
    this.cookie='enable_web_push=DISABLE; buvid4=A26F40F9-7FBF-43AA-5BD9-80F4924FCBFD30208-023111012-KxfNF8XJX%2FbkT0eszmLSXw%3D%3D; buvid_fp_plain=undefined; CURRENT_BLACKGAP=0; is-2022-channel=1; match_float_version=ENABLE; enable_feed_channel=ENABLE; timeMachine=0; SESSDATA=8803ed8b%2C1763266723%2C9878b%2A52CjDA0wuKGvcPTPiLSKWlCq20WrxPDf2z4OgikAR0rzlxgo4skkL-bYJdKdGTWZi_e8QSVkhxRnJGVFRBYjVWM2daNHBVZmV3Wng1T0laTlJZOEFTUjVPczlEalpwYy1aQm0xVHl5dUVpN1EyaWltUl9EX0QtMDRsUEdLR1c5bEJwQzhGSFlPNjN3IIEC; bili_jct=d15d744add14f8b331e838643e30a333; DedeUserID=68406011; DedeUserID__ckMd5=ecb0ad5cd0bcd251; theme-tip-show=SHOWED; sid=4j23us8c; fingerprint=b5e65cbbf664c13566a9cc1a588d755c; buvid_fp=b5e65cbbf664c13566a9cc1a588d755c; _uuid=2F10282B10-AAA3-566D-41019-F107EA55B921194819infoc; hit-dyn-v2=1; PVID=2; header_theme_version=OPEN; theme-avatar-tip-show=SHOWED; CURRENT_QUALITY=120; buvid3=3FBB3BA4-4880-5868-4F50-C337758C66FC77054infoc; b_nut=1751128477; rpdid=|(k|kmJlu|km0J\'u~luuk)R)k; bili_ticket=eyJhbGciOiJIUzI1NiIsImtpZCI6InMwMyIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTQ4MzM5NTcsImlhdCI6MTc1NDU3NDY5NywicGx0IjotMX0.lb6Iv2-zTzife3KCKFbfmr5tQpktI6qcn7n4i7jm2S0; bili_ticket_expires=1754833897; bp_t_offset_68406011=1098404509761142784; b_lsid=8BCDED610_1988549219E; share_source_origin=copy_web; bsource=share_source_copylink_web; CURRENT_FNVAL=4048; home_feed_column=4; browser_resolution=1060-2354'
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
      .catch((e:Error) => {
        Utils.Toast(e.message)
      })
      .finally(() => {
        this.content = this.homeBeanData !== null ? `加载成功:` : '加载失败:'+(this.isLogin?'已登录':'未登录')
        PageManager.routerIndex(this.homeBeanData)
      })
  }
}