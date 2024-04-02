import { UserInfoBean } from '../bean/biliUser/UserInfoBean'
import { UserStateBean } from '../bean/biliUser/UserStateBean'
import { Utils } from '../Utils/Utils'
import { ApiBase } from './ApiBase'
import NetEncryption from './NetEncryption'

 class ApiBiliUser extends ApiBase{
  // https://api.bilibili.com/x/space/wbi/acc/info?mid=''&wts=1685070149&w_rid=f7b376124782ae8cb42c56fdd69144ed
  // 用户空间详细信息 Cookie（SESSDATA）
  getUserDetail(mid:number){
    let param={'mid':mid}
    NetEncryption.getWbi(param).then(webi=>{
      let url =  `https://api.bilibili.com/x/space/wbi/acc/info?${webi}`
      Utils.Toast(url)
      console.warn('WBI',url)
      // this.request()
    })
    let url = "https://api.bilibili.com/x/space/wbi/acc/info?mid=''&wts=1685070149&w_rid=f7b376124782ae8cb42c56fdd69144ed"
  }

   // 临时测试cookie：let temp = "i-wanna-go-back=-1; _uuid=C23E3C8B-4A3F-3BEC-4FEE-6C7692E8178330018infoc; enable_web_push=DISABLE; buvid4=A26F40F9-7FBF-43AA-5BD9-80F4924FCBFD30208-023111012-KxfNF8XJX%2FbkT0eszmLSXw%3D%3D; is-2022-channel=1; buvid_fp_plain=undefined; hit-dyn-v2=1; LIVE_BUVID=AUTO3317015948042453; CURRENT_BLACKGAP=0; bsource_origin=baidu_aladdin; share_source_origin=COPY; bp_article_offset_68406011=906886996051361810; msource=pc_web; deviceFingerprint=e82561c17bd52ea232fc909eec721919; from=pc_ticketlist; bsource=search_baidu; CURRENT_QUALITY=112; fingerprint=7a3b2b714f87d63975025c0c8e3d10f8; CURRENT_FNVAL=4048; buvid_fp=7a3b2b714f87d63975025c0c8e3d10f8; rpdid=|(k|kmJl|m~J0J'u~uul|mm)|; home_feed_column=5; browser_resolution=1920-911; PVID=3; bili_ticket=eyJhbGciOiJIUzI1NiIsImtpZCI6InMwMyIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTE4OTI0MTAsImlhdCI6MTcxMTYzMzE1MCwicGx0IjotMX0.QbrQ7yWZ7PyaSi_JUItfn1Adfb1ieZ0bpFuL3Si8o-Q; bili_ticket_expires=1711892350; bp_video_offset_68406011=913942420408762371; b_lsid=3747774B_18E883A5D0A; buvid3=A02544D4-2C6A-6A25-15A2-521309AECBB457861infoc; b_nut=1711687757; b_ut=7; FEED_LIVE_VERSION=V8; header_theme_version=CLOSE; SESSDATA=e85b5348%2C1727239821%2C402b9%2A32CjCMa5xR1ftZOTOQidtxnK4R3wxt-jz7Ab8BTMPL6dOTdLLGnrPs9FK8bMhQf36XIfASVkQwMkc4SkE1VmpoTjdWb0VhaGN2QTVMeEE3TWZucGJBTDBUS29qb21XUlBBQTJFM1dmYkFDd21RdkxXVFRSclhaaVRDbVd3aXV6aUNoWlBhaGp3Qnl3IIEC; bili_jct=d3ac63861f253f083cc5bb7377aeb0b0; DedeUserID=430281002; DedeUserID__ckMd5=c3caa09fe9c35dbb; sid=hhkcaaag"

   // https://api.bilibili.com/x/web-interface/card?mid=68406011
   // 用户名片信息 Cookie（SESSDATA）
   loginUserInfo(mid:number):Promise<UserInfoBean>{
     let url = `https://api.bilibili.com/x/web-interface/card?mid=${mid}`
     return this.request<UserInfoBean>(url,this.instanceAxios)
   }

   getUserState():Promise<UserStateBean>{
     let url = "https://api.bilibili.com/x/web-interface/nav/stat"
     return this.request<UserStateBean>(url,this.instanceAxios)
   }
}

const biliUser = new ApiBiliUser()
export default biliUser as ApiBiliUser
