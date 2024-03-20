import axios, { AxiosInstance } from '@ohos/axios'
import { Utils } from '../Utils/Utils'

export class ApiBase{
  baseURl = 'https://api.bilibili.com/x'
  defaultURL = 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined'
  searchURl = 'https://api.bilibili.com/x/web-interface/search/default'
  hotSearchURL = 'https://app.bilibili.com/x/v2/search/trending/ranking'
  // 'https://api.bilibili.com/x/player/playurl?bvid=BV1dS421c777&cid=1461669931'
  playURL = 'https://api.bilibili.com/x/player/playurl'

  searchPlayURl = 'https://api.bilibili.com/x/web-interface/search/type?search_type=video&keyword=harmony&page=1'
  // /web-interface/search/type?search_type=video&keyword=48岁博士生8年未毕业被劝退&page=1
  instance = axios.create({
    baseURL: this.baseURl,
    timeout: 10000,
    headers: {
      "User-Agent": 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
      "Referer": "https://www.bilibili.com",
    }
  })


  instanceCookie = axios.create({
    baseURL: this.baseURl,
    timeout: 10000,
    headers: {
      "User-Agent": 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
      "Cookie": "buvid3=F990C62D-8570-E810-1D2A-42B652D1376F29722infoc; b_nut=1699589929; i-wanna-go-back=-1; b_ut=7; _uuid=C23E3C8B-4A3F-3BEC-4FEE-6C7692E8178330018infoc; enable_web_push=DISABLE; buvid4=A26F40F9-7FBF-43AA-5BD9-80F4924FCBFD30208-023111012-KxfNF8XJX%2FbkT0eszmLSXw%3D%3D; rpdid=|(k|kmJluuJR0J'uYmml)mmJk; header_theme_version=CLOSE; is-2022-channel=1; buvid_fp_plain=undefined; hit-dyn-v2=1; LIVE_BUVID=AUTO3317015948042453; CURRENT_BLACKGAP=0; bsource_origin=baidu_aladdin; share_source_origin=COPY; CURRENT_QUALITY=120; bsource=search_baidu; fingerprint=278b352fcb69f1c769fe12178cc9fe1b; CURRENT_FNVAL=4048; buvid_fp=278b352fcb69f1c769fe12178cc9fe1b; bp_article_offset_68406011=906886996051361810; PVID=3; bili_ticket=eyJhbGciOiJIUzI1NiIsImtpZCI6InMwMyIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTAzMzAxOTAsImlhdCI6MTcxMDA3MDkzMCwicGx0IjotMX0.VLgbgRpLy7msd_B6vcL0Lv9STAbYZ-tq5FrmyowvDaY; bili_ticket_expires=1710330130; SESSDATA=75afeffc%2C1725623018%2Cf6519%2A32CjDLqHUKV3R3Hylels4DdBS6jn524Y7iv_VRiHwIQ1t8PSnYsujZho3mQmGWb0tK9qgSVklDbUM5ZWp5ZHlNcU1Hd1EySEkwN2liWUY5cUx0ODZwdzQ4TVRxS2dpbDhkRTh5eE5uR1YyZ2hlMTN1dUtyZTdkZ1dqb0x5Zk0tRDVQMWRZNGFSSzR3IIEC; bili_jct=41a765da91704002b1b39082b08b43f6; DedeUserID=68406011; DedeUserID__ckMd5=ecb0ad5cd0bcd251; sid=4o8c3o70; FEED_LIVE_VERSION=V8; bp_video_offset_68406011=907237121746534418; b_lsid=1C101875D_18E291813FF; home_feed_column=4; browser_resolution=622-911",
      "Referer": "https://www.bilibili.com"
    }
  })

  // 请求
  protected async request<T>(url:string,axiosInstance?:AxiosInstance):Promise<T>{
    let instance = this.instance
    if (axiosInstance){
      instance = axiosInstance
    }

    return await new Promise<T>((resolve, reject) => {
      instance.get(url).then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          // 不同的请求，返回的值不一样，正常用data
          let httpData = resp.data.data
          // 不同的请求，返回的值不一样，SearchSuggest是result
          if (httpData === undefined) {
            httpData= resp.data.result
          }
          if (httpData === undefined) {
            Utils.Toast("当前请求返回可以数据为空:"+url)
          }
          console.log("Bilibili:status data:"+url+"  status" + resp.status + "--*--" + JSON.stringify(httpData))
          resolve(httpData)
        } else {
          reject("请求失败：" + resp.status)
          Utils.Toast("Bilibili:status err:" + resp.status)
        }
      }).catch(error => {
        reject("请求失败：" + error)
        console.log("Bilibili:status err:" + error)
        Utils.Toast("Bilibili:status err:" + error)
      })
    })
  }
}