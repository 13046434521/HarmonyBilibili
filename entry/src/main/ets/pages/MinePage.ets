import ApiLogin from '../net/ApiLogin';
// import ApiLogin  from '../net/ApiLogin';
import { Utils } from '../Utils/Utils';

@Component
  // 主界面中的我的页面
export struct MinePage {
  @State url:string = ''
  @State qrcode_key:string= ''

  @State responseUrl:string= ''
  @State loginStatus:number= 0
  build() {
    Column({ space: 5 }) {
      Button('二维码登录').onClick(()=>{
        // this.generateQrcode()
      })
      if (this.url!=null){
        QRCode(this.url)
          .width(200).height(200)
      }
      if (this.responseUrl!=null){
        Text(this.responseUrl)
      }
    }.width('100%').margin({ top: 5 })
  }

  generateQrcode(){
    ApiLogin.generateQrcode().then((item)=>{
      this.qrcode_key = item.qrcode_key
      this.url = item.url

      //
      // while (this.loginStatus===0){
      //   worker.ThreadWorker
      //   this.login(this.qrcode_key)
      // }
    }).catch((err)=>{
      Utils.Toast("二维码登录：生成二维码"+err)
    })
  }

  login(qrcode_key:string){
    ApiLogin.loginQrcode(qrcode_key).then((item)=>{
      this.responseUrl = item.url
      this.loginStatus = 1
    }).catch((err)=>{
      Utils.Toast("二维码登录：登录二维码"+err)
      this.loginStatus = -1
    })
  }
}