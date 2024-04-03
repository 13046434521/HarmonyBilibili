import webview from '@ohos.web.webview'
import Constants from '../common/Constants'
import { Utils } from '../Utils/Utils'

@Component
export struct WebView {
  @Prop url: string = ''
  @State title :string =this.url
  controller: webview.WebviewController = new webview.WebviewController()

  aboutToAppear() {
  }

  build() {
    Column() {
      Web({ src: this.url, controller: this.controller })
        .javaScriptAccess(true)
        .width('100%')
        .height('100%')
        .layoutWeight(1)
        .onTitleReceive((event) => {
          event.title = "粉丝"
        }).userAgent(Constants.PHONE_USER_AGENT)
        .onRequestSelected(()=>{
        console.log('jtlurl:onRequestSelected：' + this.url)
      })
        .onPageBegin((url) => {
          console.log('jtlurl:onPageBegin：' + url)
        })
        .onPageEnd((url) => {
          console.log('jtlurl:onPageEnd：' + url)
        })
        .onErrorReceive(() => {
          //加载错误时的回调
        })
        .onProgressChange((event) => {
          console.log('jtlurlnewProgress:' + event.newProgress)
        })
    }
  }
}

function setCookie(url:string){
  let temp = AppStorage.Get<string>('bilibili_cookie')
  let arr = temp.split(';')
  for (let index = 0; index < arr.length; index++) {
    const element = arr[index];
    webview.WebCookieManager.setCookie(url, element)
  }}