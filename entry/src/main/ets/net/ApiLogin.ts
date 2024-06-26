// 登录相关
import axios from '@ohos/axios'
import { LoginNavBean } from '../bean/login/LoginNavBean'
import { UserInfoBean } from '../bean/biliUser/UserInfoBean'
import { QrcodeGenerateBean } from '../bean/login/QrcodeGenerateBean'
import { QrcodeLoginBean } from '../bean/login/QrcodeLoginBean'
import { UserStateBean } from '../bean/biliUser/UserStateBean'
import StorageManager from '../common/StorageManager'
import { ApiBase } from './ApiBase'
import { Utils } from '../Utils/Utils'


export class ApiLogin extends ApiBase{
  //https://passport.bilibili.com/x/passport-login/web/qrcode/generate
  // 生成二维码
  generateQrcode():Promise<QrcodeGenerateBean>{
    let url = 'https://passport.bilibili.com/x/passport-login/web/qrcode/generate'
    return this.request<QrcodeGenerateBean>(url,this.instanceAxios)
  }

  //https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key=d7a23f1b2d7196d7970a5b8428e0fed5
  // 登录获取Cookie
  loginQrcode(qrcode_key:string):Promise<QrcodeLoginBean>{
    let url = `https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key=${qrcode_key}`
    return this.request<QrcodeLoginBean>(url,this.instanceAxios)
  }

  // https://api.bilibili.com/x/web-interface/nav
  // 导航栏用户信息 Cookie（SESSDATA） 可以通过二维码登录后获取的cookie数据，直接调用该接口，获取mid（当前账号的id）
  // 同时可以根据这个来判断是否需要重新登录
  loginNav():Promise<LoginNavBean>{
    let url = "https://api.bilibili.com/x/web-interface/nav"
    this.instanceAxios.defaults.headers['Cookie'] = StorageManager.getCookie();
    return this.request<LoginNavBean>(url,this.instanceAxios).then(nav=>{
      return new Promise<LoginNavBean>(resolve=>{
        if (!nav.isLogin){
          Utils.Dialog('账号未登录：'+nav.isLogin)
        }
        resolve(nav)
      })
    })
  }
  //https://passport.bilibili.com/account/security#/home
  // 账号安全评分
  // https://passport.bilibili.com/login/exit/v2
  // 退出账号，后台会让当前cookie失效
}

const apiLogin: ApiLogin = new ApiLogin()

export default apiLogin as ApiLogin