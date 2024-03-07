import axios, { AxiosInstance, AxiosResponse } from '@ohos/axios'
import url from '@ohos.url';

export class Api {
  static baseURL = 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined'
  public instance = axios.create({
    baseURL: 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined',
    timeout: 1000,
  });

  getApi():AxiosInstance{
    return this.instance
  }

  static get():void{
    axios.get(this.baseURL).then(resp=>{
      console.log("jtl:"+resp.status+"---"+JSON.stringify(resp.data))
    }).catch(error=>{
      console.log("jtl:"+error)
    })
  }
}