import axios, { AxiosError, AxiosInstance, AxiosResponse } from '@ohos/axios'
import url from '@ohos.url';
import HomeBean from '../bean/HomeBean';
import { HomeSearchBean } from '../bean/HomeSearchBean';
import { PlayVideoBean } from '../bean/PlayVideoBean';

class Api {
  headers = new Map([
    ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
    ["Connection", "keep-alive"],
    ["Referer", "https://www.bilibili.com"]
  ]);

  baseURL = 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined'
  searchURl = 'https://api.bilibili.com/x/web-interface/search/default'
  hotSearchURL = 'https://app.bilibili.com/x/v2/search/trending/ranking'
  // 'https://api.bilibili.com/x/player/playurl?bvid=BV1dS421c777&cid=1461669931'
  playURL = 'https://api.bilibili.com/x/player/playurl'


  instance = axios.create({
    baseURL: 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined',
    timeout: 1000,
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
      axios.get('https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=' + page + '&feed_version=undefined').then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        } else {
          reject("«Î«Û ß∞‹£∫" + resp.status)
        }
        console.log("jtl:getHomePages:" + resp.status + "---" + JSON.stringify(resp.data))
      }).catch(error => {
        console.log("jtl:" + error)
        reject("«Î«Û ß∞‹£∫" + error)
      })
    })
  }

  getHomeSearch(): Promise<HomeSearchBean> {
    return new Promise((resolve, reject) => {
      axios.get(this.searchURl).then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        } else {
          reject("«Î«Û ß∞‹£∫" + resp.status)
        }
        console.log("jtl:getHomeSearch:" + resp.status + "---" + JSON.stringify(resp.data))
      }).catch(error => {
        console.log("jtl:" + error)
        reject("«Î«Û ß∞‹£∫" + error)
      })
    })
  }
  // 'https://api.bilibili.com/x/web-interface/archive/stat?bvid=BV1dS421c777&cid=1461669931'

  getPlayVideo(bvid:string,cid:number): Promise<PlayVideoBean> {
    return new Promise((resolve, reject) => {
      let url = `${this.playURL}?bvid=${bvid}&cid=${cid}&qn=112`
      console.log('getPlayVideo:'+url)
      axios.get(url,{headers: {
        "User-Agent":'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
        "Connection":"keep-alive",
        "Referer":"https://www.bilibili.com",
        "Content-Type":"application/json"
      }}).then(resp => {
        if (resp.status == axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        } else {
          reject("«Î«Û ß∞‹£∫" + resp.status)
        }
        console.log("jtl:getHomeSearch:" + resp.status + "---" + JSON.stringify(resp.data))
      }).catch(error => {
        console.log("jtl:" + error)
        reject("«Î«Û ß∞‹£∫" + error)
      })
    })
  }
}

const api: Api = new Api()

export default api as Api