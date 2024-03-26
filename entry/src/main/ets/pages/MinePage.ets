import axios from '@ohos/axios';
import { QrcodeGenerateBean } from '../bean/login/QrcodeGenerateBean';
import Constants from '../common/Constants';
import ApiLogin from '../net/ApiLogin';
import { Utils } from '../Utils/Utils';

@Component
  // 主界面中的我的页面
export struct MinePage {
  @State url:string = undefined
  @State qrcode_key:string= ''

  @State responseUrl:string= ''
  @State loginStatus:number= -1
  @State message:string =''
  @StorageLink('bilibili_cookie') biliCookie:string  =''
  build() {
    Column({ space: 5 }) {
      Button('生成二维码登录').onClick(()=>{
        this.generateQrcode()
      })
      if (this.url!=undefined){
        QRCode(this.url)
          .width(200).height(200)
      }

      Text(this.message)

      Button('获取当前cookie').onClick(()=>{
        this.message = this.biliCookie
      })
    }.width('100%').height('100%').margin({ top: 5 })


  }

  generateQrcode(){
    ApiLogin.generateQrcode().then((item:QrcodeGenerateBean)=>{
      this.url = item.url
      return this.qrcode_key = item.qrcode_key
    }).then((qrcode:string)=>{
      this.login(qrcode)
    }).catch((err)=>{
      Utils.Toast("二维码登录：生成二维码"+err)
    })
  }

  login(qrcode_key:string){
    let interval :number
    interval = setInterval(()=>{
      if (this.loginStatus==-1) {
        ApiLogin.loginQrcode(qrcode_key).then((item)=>{
          this.responseUrl = item.url
          console.log("二维码登录：url  "+item.url)
          console.log("二维码登录：refresh_token   "+item.refresh_token)
          console.log("二维码登录：code  "+item.code)
          console.log("二维码登录：timestamp  "+item.timestamp)
          console.log("二维码登录：message  "+item.message)
          if (item.code === 0) {

            this.loginStatus = 1
            this.biliCookie = Utils.CookieDeal(item.url)
            this.message = "二维码登录：url  "+item.url +"\n二维码登录：refresh_token   "+item.refresh_token+
              "\n二维码登录：code  "+item.code+"\n二维码登录：timestamp  "+item.timestamp+"\n二维码登录：message  "+item.message+"\n 处理后的Cookie："+this.biliCookie
            Constants.COOKIE = this.biliCookie
            clearInterval(interval)
            Utils.Toast('二维码登录：登录二维码成功')
            console.log("二维码登录成功:"+this.biliCookie)
          }


        }).catch((err)=>{
          console.log("二维码登录：登录二维码"+err)
          this.loginStatus = -1
        })
      }
    },1000)
  }
}