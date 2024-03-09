import axios, { AxiosError, AxiosInstance, AxiosResponse } from '@ohos/axios'
import url from '@ohos.url';
import HomeBean from '../bean/HomeBean';
import { HomeSearchBean } from '../bean/HomeSearchBean';
import { PlayVideoBean } from '../bean/PlayVideoBean';
import { SearchHotBean } from '../bean/SearchHotBean';
import { SearchDetailsBean } from '../bean/SearchDetailsBean';

class Api {
  headers = new Map([
    ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
    ["Connection", "keep-alive"],
    ["Referer", "https://www.bilibili.com"]
  ]);


  baseURl = 'https://api.bilibili.com/x'
  defaultURL = 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined'
  searchURl = 'https://api.bilibili.com/x/web-interface/search/default'
  hotSearchURL = 'https://app.bilibili.com/x/v2/search/trending/ranking'
  // 'https://api.bilibili.com/x/player/playurl?bvid=BV1dS421c777&cid=1461669931'
  playURL = 'https://api.bilibili.com/x/player/playurl'

  searchPlayURl ='https://api.bilibili.com/x/web-interface/search/type?search_type=video&keyword=harmony&page=1'
  // /web-interface/search/type?search_type=video&keyword=48岁博士生8年未毕业被劝退&page=1
  instance = axios.create({
    baseURL: this.baseURl,
    timeout: 10000,
    headers: {
      "User-Agent":'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
      "Connection":"keep-alive",
      "Referer":"https://www.bilibili.com"
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

  getPlayVideo(bvid:string,cid:number): Promise<PlayVideoBean> {
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

  getSearchHot(): Promise<SearchHotBean>{
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

  getSearchDetails(video?:string,keyword?:string,page:number=0):Promise<SearchDetailsBean>{
    return new Promise((resolve, reject)=>{
      let url =`/web-interface/search/type?search_type=video&keyword=${keyword}&page=${page}`
      console.log("jtl:getSearchDetails:url:"+url)
// this.instance.get(url)
      axios.get(this.searchPlayURl).then(resp => {
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