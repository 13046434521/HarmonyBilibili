import webview from '@ohos.web.webview'
import Constants from '../common/Constants'
import Api from '../net/Api'
import { Utils } from '../Utils/Utils'

@Component
export struct ShoppingPage {
  url: string = 'https://m.bilibili.com/'
  controller: webview.WebviewController = new webview.WebviewController()
  @State title:string=''
  aboutToAppear() {

  }

  build() {
    Column() {

    }
  }

  @Builder
  getText(){
    Web({ src: this.url, controller: this.controller })
      .javaScriptAccess(true)
      .width('100%')
      .layoutWeight(1)
      .onTitleReceive((event) => {
        // this.title = event.title
      })
      .userAgent(Constants.PHONE_USER_AGENT)
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

function setCookie(url:string){
  let temp = AppStorage.Get<string>('bilibili_cookie')
  let arr = temp.split(';')
  for (let index = 0; index < arr.length; index++) {
    const element = arr[index];
    webview.WebCookieManager.setCookie(url, element)
  }}