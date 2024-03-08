import axios, { AxiosInstance, AxiosResponse } from '@ohos/axios'
import url from '@ohos.url';
import HomeBean from '../bean/HomeBean';
import { HomeSearchBean } from '../bean/HomeSearchBean';

class Api {
  baseURL = 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined'
  searchURl = 'https://api.bilibili.com/x/web-interface/search/default'

  instance = axios.create({
    baseURL: 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined',
    timeout: 1000,
  });

  getApi():AxiosInstance{
    return this.instance
  }

  getHomePages():Promise<HomeBean>{
    return new Promise((resolve,reject)=>{
      axios.get(this.baseURL).then(resp=>{
        if (resp.status ==axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        }else{
          reject("����ʧ�ܣ�"+resp.status)
        }
        console.log("jtl:getHomePages:"+resp.status+"---"+JSON.stringify(resp.data))
      }).catch(error=>{
        console.log("jtl:"+error)
        reject("����ʧ�ܣ�"+error)
      })
    })
  }

  getHomeSearch():Promise<HomeSearchBean>{
    return new Promise((resolve,reject)=>{
      axios.get(this.searchURl).then(resp=>{
        if (resp.status ==axios.HttpStatusCode.Ok) {
          resolve(resp.data.data)
        }else{
          reject("����ʧ�ܣ�"+resp.status)
        }
        console.log("jtl:getHomeSearch:"+resp.status+"---"+JSON.stringify(resp.data))
      }).catch(error=>{
        console.log("jtl:"+error)
        reject("����ʧ�ܣ�"+error)
      })
    })
  }
}

const api:Api = new Api()

export default api as Api