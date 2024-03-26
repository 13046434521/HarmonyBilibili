import axios from '@ohos/axios';
import { QrcodeGenerateBean } from '../bean/login/QrcodeGenerateBean';
import Constants from '../common/Constants';
import ApiLogin from '../net/ApiLogin';
import { Utils } from '../Utils/Utils';

@Preview
@Component
  // 主界面中的我的页面
export struct MinePage {
  @State url: string = undefined
  @State qrcode_key: string = ''
  @State responseUrl: string = ''
  @State loginStatus: number = -1
  @State message: string = '登录即可体验完整功能'
  @StorageLink('bilibili_cookie') biliCookie: string = ''

  build() {
    Column() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.End)
      }.height('40%')
      .justifyContent(FlexAlign.End)

      Column() {
        Button('二维码登录')
          .width('60%')
          .backgroundColor($r('app.color.bilibili_theme'))
          .onClick(() => {
            this.generateQrcode()
          })
      }.height('10%')
      .justifyContent(FlexAlign.End)

      if (this.url != undefined) {
        Column() {
          QRCode(this.url)
            .width(200).height(200)
        }.height('10%')
        .margin('10%')
        .justifyContent(FlexAlign.Center)
      }

      Column() {
        Button('获取当前cookie')
          .width('60%')
          .backgroundColor($r('app.color.bilibili_theme'))
          .onClick(() => {
            this.message = this.biliCookie
          })
      }.height('10%')
      .justifyContent(FlexAlign.End)
      Blank().layoutWeight(1)
    }.width('100%')
    .height('100%')
    .margin({ top: 5 })
    .justifyContent(FlexAlign.Start)
  }

  generateQrcode() {
    ApiLogin.generateQrcode().then((item: QrcodeGenerateBean) => {
      this.url = item.url
      return this.qrcode_key = item.qrcode_key
    }).then((qrcode: string) => {
      this.login(qrcode)
    }).catch((err) => {
      Utils.Toast("二维码登录：生成二维码" + err)
    })
  }

  login(qrcode_key: string) {
    let interval: number
    interval = setInterval(() => {
      if (this.loginStatus == -1) {
        ApiLogin.loginQrcode(qrcode_key).then((item) => {
          this.responseUrl = item.url
          this.message = '请扫描二维码登录:'+item.message
          console.log("二维码登录：url  " + item.url)
          console.log("二维码登录：refresh_token   " + item.refresh_token)
          console.log("二维码登录：code  " + item.code)
          console.log("二维码登录：timestamp  " + item.timestamp)
          console.log("二维码登录：message  " + item.message)
          if (item.code === 0) {
            this.loginStatus = 1
            this.biliCookie = Utils.CookieDeal(item.url)
            Constants.COOKIE = this.biliCookie

            clearInterval(interval)

            Utils.Toast('二维码登录：登录二维码成功')
            console.log("二维码登录成功:" + this.biliCookie)
          }
        }).catch((err) => {
          console.log("二维码登录：登录二维码" + err)
          this.loginStatus = -1
        })
      }
    }, 1000)
  }
}