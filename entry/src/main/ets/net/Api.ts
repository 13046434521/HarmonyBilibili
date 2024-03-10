import axios, {AxiosInstance} from '@ohos/axios'
import HomeBean from '../bean/HomeBean';
import { HomeSearchBean } from '../bean/HomeSearchBean';
import { PlayVideoBean } from '../bean/PlayVideoBean';
import { SearchHotBean } from '../bean/SearchHotBean';
import { SearchDetailsBean, SearchDetailsItemBean } from '../bean/SearchDetailsBean';

class Api {
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

  getApi(): AxiosInstance {
    return this.instance
  }

  getHomePages(page: number = 0): Promise<HomeBean> {
    return new Promise((resolve, reject) => {
      this.instance.get(`/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=${page}&feed_version=undefined`).then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        } else {
          reject("请求失败：" + resp.status)
        }
        console.log("jtl:getHomePages:" + resp.status + "---" + JSON.stringify(resp.data))
      }).catch(error => {
        console.log("jtl:" + error)
        reject("请求失败：" + error)
      })
    })
  }

  getHomeSearch(): Promise<HomeSearchBean> {
    return new Promise((resolve, reject) => {
      this.instance.get("/web-interface/search/default").then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        } else {
          reject("请求失败：" + resp.status)
        }
        console.log("jtl:getHomeSearch:" + resp.status + "---" + JSON.stringify(resp.data))
      }).catch(error => {
        console.log("jtl:" + error)
        reject("请求失败：" + error)
      })
    })
  }

  // 'https://api.bilibili.com/x/web-interface/archive/stat?bvid=BV1dS421c777&cid=1461669931'

  getPlayVideo(bvid: string, cid: number): Promise<PlayVideoBean> {
    return new Promise((resolve, reject) => {
      //let url = `${this.playURL}?bvid=${bvid}&cid=${cid}&qn=112`
      this.instance.get(`/player/playurl?bvid=${bvid}&cid=${cid}`).then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        } else {
          reject("请求失败：" + resp.status)
        }
        console.log("jtl:getHomeSearch:" + resp.status + "---" + JSON.stringify(resp.data))
      }).catch(error => {
        console.log("jtl:" + error)
        reject("请求失败：" + error)
      })
    })
  }

  getSearchHot(): Promise<SearchHotBean> {
    return new Promise((resolve, reject) => {
      this.instance.get('/v2/search/trending/ranking').then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        } else {
          reject("请求失败：" + resp.status)
        }
        console.log("jtl:getSearchHot:" + resp.status + "---" + JSON.stringify(resp.data))
      }).catch(error => {
        console.log("jtl:" + error)
        reject("请求失败：" + error)
      })
    })
  }

  getSearchAllDetails(video?: string, keyword?: string, page: number = 0): Promise<SearchDetailsBean> {
    return new Promise((resolve, reject) => {
      //https://api.bilibili.com/x/web-interface/search/all/v2
      let url = `/web-interface/search/type?search_type=video&keyword=${keyword}&page=${page}`
      // this.instance.defaults.headers["cookie"] = this.cookie
      this.instanceCookie.get(url).then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        } else {
          reject("请求失败：" + resp.status)
          console.log("jtl:" + resp.status)
        }
        console.log("jtl:getSearchDetails:" + resp.status + "---" + JSON.stringify(resp.data))
      }).catch(error => {
        console.log("jtl:" + error)
        reject("请求失败：" + error)
      })
    })
  }
  getSearchDetails(video?: string, keyword?: string, page: number = 0): Promise<SearchDetailsBean> {
    return new Promise((resolve, reject) => {
      let url = `/web-interface/search/type?search_type=video&keyword=${keyword}&page=${page}`
      this.instanceCookie.get(url).then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        } else {
          reject("请求失败：" + resp.status)
          console.log("jtl:" + resp.status)
        }
        console.log("jtl:getSearchDetails:" + resp.status + "---" + JSON.stringify(resp.data))
      }).catch(error => {
        console.log("jtl:" + error)
        reject("请求失败：" + error)
      })
    })
  }
}

const api: Api = new Api()

export default api as Api