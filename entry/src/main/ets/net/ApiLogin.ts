// 登录相关
import axios from '@ohos/axios'
import { LoginNavBean } from '../bean/login/LoginNavBean'
import { LoginUserInfoBean } from '../bean/login/LoginUserInfoBean'
import { QrcodeGenerateBean } from '../bean/login/QrcodeGenerateBean'
import { QrcodeLoginBean } from '../bean/login/QrcodeLoginBean'
import { UserStateBean } from '../bean/login/UserStateBean'
import StorageManager from '../common/StorageManager'
import { ApiBase } from './ApiBase'


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
    return this.request<LoginNavBean>(url,this.instanceAxios)
  }

  // 临时测试cookie：let temp = "i-wanna-go-back=-1; _uuid=C23E3C8B-4A3F-3BEC-4FEE-6C7692E8178330018infoc; enable_web_push=DISABLE; buvid4=A26F40F9-7FBF-43AA-5BD9-80F4924FCBFD30208-023111012-KxfNF8XJX%2FbkT0eszmLSXw%3D%3D; is-2022-channel=1; buvid_fp_plain=undefined; hit-dyn-v2=1; LIVE_BUVID=AUTO3317015948042453; CURRENT_BLACKGAP=0; bsource_origin=baidu_aladdin; share_source_origin=COPY; bp_article_offset_68406011=906886996051361810; msource=pc_web; deviceFingerprint=e82561c17bd52ea232fc909eec721919; from=pc_ticketlist; bsource=search_baidu; CURRENT_QUALITY=112; fingerprint=7a3b2b714f87d63975025c0c8e3d10f8; CURRENT_FNVAL=4048; buvid_fp=7a3b2b714f87d63975025c0c8e3d10f8; rpdid=|(k|kmJl|m~J0J'u~uul|mm)|; home_feed_column=5; browser_resolution=1920-911; PVID=3; bili_ticket=eyJhbGciOiJIUzI1NiIsImtpZCI6InMwMyIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTE4OTI0MTAsImlhdCI6MTcxMTYzMzE1MCwicGx0IjotMX0.QbrQ7yWZ7PyaSi_JUItfn1Adfb1ieZ0bpFuL3Si8o-Q; bili_ticket_expires=1711892350; bp_video_offset_68406011=913942420408762371; b_lsid=3747774B_18E883A5D0A; buvid3=A02544D4-2C6A-6A25-15A2-521309AECBB457861infoc; b_nut=1711687757; b_ut=7; FEED_LIVE_VERSION=V8; header_theme_version=CLOSE; SESSDATA=e85b5348%2C1727239821%2C402b9%2A32CjCMa5xR1ftZOTOQidtxnK4R3wxt-jz7Ab8BTMPL6dOTdLLGnrPs9FK8bMhQf36XIfASVkQwMkc4SkE1VmpoTjdWb0VhaGN2QTVMeEE3TWZucGJBTDBUS29qb21XUlBBQTJFM1dmYkFDd21RdkxXVFRSclhaaVRDbVd3aXV6aUNoWlBhaGp3Qnl3IIEC; bili_jct=d3ac63861f253f083cc5bb7377aeb0b0; DedeUserID=430281002; DedeUserID__ckMd5=c3caa09fe9c35dbb; sid=hhkcaaag"

  // https://api.bilibili.com/x/web-interface/card?mid=68406011
  // 用户名片信息 Cookie（SESSDATA）
  loginUserInfo(mid:number):Promise<LoginUserInfoBean>{
    let url = `https://api.bilibili.com/x/web-interface/card?mid=${mid}}`
    return this.request<LoginUserInfoBean>(url,this.instanceAxios)
  }


  getUserState():Promise<UserStateBean>{
    let url = "https://api.bilibili.com/x/web-interface/nav/stat"
    return this.request<UserStateBean>(url,this.instanceAxios)
  }
  // https://api.bilibili.com/x/web-interface/nav/stat


  // https://api.bilibili.com/x/space/wbi/acc/info
  // 用户空间详细信息 Cookie（SESSDATA）

  // https://passport.bilibili.com/login/exit/v2
  // 退出账号，后台会让当前cookie失效
}

const apiLogin: ApiLogin = new ApiLogin()

export default apiLogin as ApiLogin