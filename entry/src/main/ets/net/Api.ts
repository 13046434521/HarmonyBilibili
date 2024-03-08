import axios, { AxiosInstance, AxiosResponse } from '@ohos/axios'
import url from '@ohos.url';
import HomeBean from '../bean/HomeBean';
import { HomeSearchBean } from '../bean/HomeSearchBean';

class Api {
  baseURL = 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined'
  searchURl = 'https://api.bilibili.com/x/web-interface/search/default'
  hotSearchURL='https://app.bilibili.com/x/v2/search/trending/ranking'
  instance = axios.create({
    baseURL: 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined',
    timeout: 1000,
  });

  getApi():AxiosInstance{
    return this.instance
  }

  getHomePages(page:number = 0):Promise<HomeBean>{
    return new Promise((resolve,reject)=>{
      axios.get('https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx='+page+'&feed_version=undefined').then(resp=>{
        if (resp.status ==axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        }else{
          reject("«Î«Û ß∞‹£∫"+resp.status)
        }
        console.log("jtl:getHomePages:"+resp.status+"---"+JSON.stringify(resp.data))
      }).catch(error=>{
        console.log("jtl:"+error)
        reject("«Î«Û ß∞‹£∫"+error)
      })
    })
  }

  getHomeSearch():Promise<HomeSearchBean>{
    return new Promise((resolve,reject)=>{
      axios.get(this.searchURl).then(resp=>{
        if (resp.status ==axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        }else{
          reject("«Î«Û ß∞‹£∫"+resp.status)
        }
        console.log("jtl:getHomeSearch:"+resp.status+"---"+JSON.stringify(resp.data))
      }).catch(error=>{
        console.log("jtl:"+error)
        reject("«Î«Û ß∞‹£∫"+error)
      })
    })
  }
}

const api:Api = new Api()

export default api as Api