import axios, { AxiosInstance, InternalAxiosRequestConfig } from '@ohos/axios'
import Constants from '../common/Constants'
import { Utils } from '../Utils/Utils'

export class ApiBase{
  baseURl = 'https://api.bilibili.com/x'
  defaultURL = 'https://api.bilibili.com/x/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=1&feed_version=undefined'

  instanceAxios = axios.create({
    baseURL:'',
    timeout: 10000,
    headers: {
      "User-Agent": 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
      "Cookie": Constants.COOKIE,
      "Referer": "https://www.bilibili.com"
    }
  })


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
      "Cookie": Constants.COOKIE,
      "Referer": "https://www.bilibili.com"
    }
  })
  constructor() {
    this.instance.interceptors.request.use((value: InternalAxiosRequestConfig)=>{
      console.log(`拦截器：发送URL：${value.baseURL}${value.url} Header：${value.headers}`)
      // for (const element of value.headers) {
      //    console.log(`拦截器：header:${element.toString()}`)
      // }
      return value
    })

    this.instanceCookie.interceptors.request.use((value: InternalAxiosRequestConfig)=>{
      console.log(`拦截器:cookie的：发送URL：${value.baseURL}${value.url} Header：${value.headers}`)
      return value
    })

    this.instanceAxios.interceptors.request.use((value: InternalAxiosRequestConfig)=>{
      console.log(`拦截器:没有baseUrl的：发送URL：${value.baseURL}${value.url} Header：${value.headers}`)
      return value
    })
  }

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
          console.log("Bilibili:status data:"+url+"  status:" + resp.status + "--*--" + JSON.stringify(httpData))
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