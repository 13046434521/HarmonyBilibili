import axios, { AxiosError, AxiosInstance, AxiosResponse } from '@ohos/axios'
import url from '@ohos.url';
import HomeBean from '../bean/HomeBean';
import { HomeSearchBean } from '../bean/HomeSearchBean';
import { PlayVideoBean } from '../bean/PlayVideoBean';
import { SearchHotBean } from '../bean/SearchHotBean';
import { SearchDetailsBean } from '../bean/SearchDetailsBean';

class Api {
  cookie = "buvid3=F990C62D-8570-E810-1D2A-42B652D1376F29722infoc; b_nut=1699589929; i-wanna-go-back=-1; b_ut=7; _uuid=C23E3C8B-4A3F-3BEC-4FEE-6C7692E8178330018infoc; enable_web_push=DISABLE; buvid4=A26F40F9-7FBF-43AA-5BD9-80F4924FCBFD30208-023111012-KxfNF8XJX%2FbkT0eszmLSXw%3D%3D; rpdid=|(k|kmJluuJR0J'uYmml)mmJk; DedeUserID=68406011; DedeUserID__ckMd5=ecb0ad5cd0bcd251; header_theme_version=CLOSE; is-2022-channel=1; buvid_fp_plain=undefined; hit-dyn-v2=1; LIVE_BUVID=AUTO3317015948042453; CURRENT_BLACKGAP=0; bsource_origin=baidu_aladdin; share_source_origin=COPY; CURRENT_QUALITY=120; bsource=search_baidu; FEED_LIVE_VERSION=V8; home_feed_column=5; browser_resolution=1920-911; fingerprint=278b352fcb69f1c769fe12178cc9fe1b; CURRENT_FNVAL=4048; bili_ticket=eyJhbGciOiJIUzI1NiIsImtpZCI6InMwMyIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTAwNjgxNDIsImlhdCI6MTcwOTgwODg4MiwicGx0IjotMX0.w-5IndBc-Xpv3tlbKr3KykXZx_Sb_xQUsXTXAjOyfXE; bili_ticket_expires=1710068082; SESSDATA=d333e056%2C1725362908%2Ce386a%2A31CjDLM2XkYZ9e0aFjsWnnpjc6U58h5iow8_gZjoFFmJq_a0fcnl7eZE4JI1APflV4EbUSVjNmTDRDOXE3LUdzRUFOTjUtWkJpN1ZHWjU3S3BMNEswaGQyT3JoYVdETzBqTVRtbDQtdVdQeC1KdXJlczYybFZwVHNVNXROb3owY29qam1LVWJXeTBnIIEC; bili_jct=2c7974516be840558eca0adc78db326f; sid=5qt75f39; buvid_fp=278b352fcb69f1c769fe12178cc9fe1b; bp_article_offset_68406011=906886996051361810; bp_video_offset_68406011=906890200062361608; PVID=3; b_lsid=3EFE9261_18E24977114";

  // headers = new Map([
  //   ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
  //   ["Connection", "keep-alive"],
  //   ["Referer", "https://www.bilibili.com"],
  //   ["Cookie",this.cookie]
  // ]);
  cookieHeaders: {
    "User-Agent": 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
    "Connection": "keep-alive",
    "Referer": "https://www.bilibili.com",
    "Cookie","buvid3=F990C62D-8570-E810-1D2A-42B652D1376F29722infoc; b_nut=1699589929; i-wanna-go-back=-1; b_ut=7; _uuid=C23E3C8B-4A3F-3BEC-4FEE-6C7692E8178330018infoc; enable_web_push=DISABLE; buvid4=A26F40F9-7FBF-43AA-5BD9-80F4924FCBFD30208-023111012-KxfNF8XJX%2FbkT0eszmLSXw%3D%3D; rpdid=|(k|kmJluuJR0J'uYmml)mmJk; DedeUserID=68406011; DedeUserID__ckMd5=ecb0ad5cd0bcd251; header_theme_version=CLOSE; is-2022-channel=1; buvid_fp_plain=undefined; hit-dyn-v2=1; LIVE_BUVID=AUTO3317015948042453; CURRENT_BLACKGAP=0; bsource_origin=baidu_aladdin; share_source_origin=COPY; CURRENT_QUALITY=120; bsource=search_baidu; FEED_LIVE_VERSION=V8; home_feed_column=5; browser_resolution=1920-911; fingerprint=278b352fcb69f1c769fe12178cc9fe1b; CURRENT_FNVAL=4048; bili_ticket=eyJhbGciOiJIUzI1NiIsImtpZCI6InMwMyIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTAwNjgxNDIsImlhdCI6MTcwOTgwODg4MiwicGx0IjotMX0.w-5IndBc-Xpv3tlbKr3KykXZx_Sb_xQUsXTXAjOyfXE; bili_ticket_expires=1710068082; SESSDATA=d333e056%2C1725362908%2Ce386a%2A31CjDLM2XkYZ9e0aFjsWnnpjc6U58h5iow8_gZjoFFmJq_a0fcnl7eZE4JI1APflV4EbUSVjNmTDRDOXE3LUdzRUFOTjUtWkJpN1ZHWjU3S3BMNEswaGQyT3JoYVdETzBqTVRtbDQtdVdQeC1KdXJlczYybFZwVHNVNXROb3owY29qam1LVWJXeTBnIIEC; bili_jct=2c7974516be840558eca0adc78db326f; sid=5qt75f39; buvid_fp=278b352fcb69f1c769fe12178cc9fe1b; bp_article_offset_68406011=906886996051361810; bp_video_offset_68406011=906890200062361608; PVID=3; b_lsid=3EFE9261_18E24977114";
  }

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
      "Connection": "keep-alive",
      "Referer": "https://www.bilibili.com",
    }
  });

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
      this.instance.get(`/player/playurl?bvid=${bvid}&cid=${cid}`, {
        headers: this.cookieHeaders
      }).then(resp => {
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

  getSearchDetails(video?: string, keyword?: string, page: number = 0): Promise<SearchDetailsBean> {
    return new Promise((resolve, reject) => {
      let url = `/web-interface/search/type?search_type=video&keyword=${keyword}&page=${page}`
      this.instance.get(url, { headers: this.cookieHeaders }).then(resp => {
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