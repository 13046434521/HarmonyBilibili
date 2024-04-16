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
  homeBeanData: Array<HomeBeanItem> = null
  @State content: string = "加载中..."

  @StorageLink('isLogin') isLogin:boolean = false
  @StorageLink('login_img_url') loginIcon :string = ''
  @StorageLink('bilibili_cookie') cookie :string = ''
  aboutToAppear() {
    this.cookie=`i-wanna-go-back=-1; _uuid=C23E3C8B-4A3F-3BEC-4FEE-6C7692E8178330018infoc; enable_web_push=DISABLE; buvid4=A26F40F9-7FBF-43AA-5BD9-80F4924FCBFD30208-023111012-KxfNF8XJX%2FbkT0eszmLSXw%3D%3D; is-2022-channel=1; buvid_fp_plain=undefined; hit-dyn-v2=1; LIVE_BUVID=AUTO3317015948042453; CURRENT_BLACKGAP=0; bsource_origin=baidu_aladdin; share_source_origin=COPY; msource=pc_web; deviceFingerprint=e82561c17bd52ea232fc909eec721919; from=pc_ticketlist; fingerprint=7a3b2b714f87d63975025c0c8e3d10f8; CURRENT_FNVAL=4048; bsource=share_source_copy_link; b_ut=7; header_theme_version=CLOSE; bp_video_offset_430281002=917172716842254340; rpdid=|(k|kmJluuRl0J'u~ukRu~)|l; buvid3=EF991736-9855-3371-D6C8-1E40EB1E4D4747279infoc; b_nut=1712418347; bili_ticket=eyJhbGciOiJIUzI1NiIsImtpZCI6InMwMyIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTMzMzIxNzYsImlhdCI6MTcxMzA3MjkxNiwicGx0IjotMX0.AAiJUCcagAENWvXnRx6gEOh8VwQ1-5aIX2waRUhKUJk; bili_ticket_expires=1713332116; CURRENT_QUALITY=116; buvid_fp=7a3b2b714f87d63975025c0c8e3d10f8; SESSDATA=26ab73de%2C1728714148%2C02370%2A42CjDlNgb5F4l0grXkof5PZqttLIMhNP4hm9nyg2glLd5f7D8GBu6w8F1efvIHM5RFSbcSVmFFRFhiTnFpOGY1NUNZU2JTdGFGajV2VnFKQ1kzZGVxemJiM1p1SGhDTG1hOXVoUGtKX0EydzhzeFc2SGNSSVIwSmFWelZKV3E1X0FQM0haOVIxTHFBIIEC; bili_jct=47a4a6c2b0326357ce634b5ffbd245aa; DedeUserID=68406011; DedeUserID__ckMd5=ecb0ad5cd0bcd251; FEED_LIVE_VERSION=V_HEADER_LIVE_NO_POP; home_feed_column=5; sid=4gnjnmpo; PVID=2; browser_resolution=1745-828; bp_video_offset_68406011=920984959877906433; b_lsid=1041ABC105_18EE70F3E66`

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
        this.content = this.homeBeanData !== null ? `加载成功:` : '加载失败:'+(this.isLogin?'已登录':'未登录')
        PageManager.routerIndex(this.homeBeanData)
      })
  }
}