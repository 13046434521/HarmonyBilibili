// 登录相关
import axios from '@ohos/axios'
import { QrcodeGenerateBean } from '../bean/login/QrcodeGenerateBean'
import { QrcodeLoginBean } from '../bean/login/QrcodeLoginBean'
import { ApiBase } from './ApiBase'


export class ApiLogin extends ApiBase{
  //https://passport.bilibili.com/x/passport-login/web/qrcode/generate
  // 生成二维码
  generateQrcode():Promise<QrcodeGenerateBean>{
    let url = 'https://passport.bilibili.com/x/passport-login/web/qrcode/generate'
    return this.request<QrcodeGenerateBean>(url,axios)
  }

  //https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key=d7a23f1b2d7196d7970a5b8428e0fed5
  // 登录获取Cookie
  loginQrcode(qrcode_key:string):Promise<QrcodeLoginBean>{
    let url = `https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key=${qrcode_key}`
    return this.request<QrcodeLoginBean>(url,axios)
  }
}

const apiLogin: ApiLogin = new ApiLogin()

export default apiLogin as ApiLogin