import webview from '@ohos.web.webview'
import { Utils } from '../Utils/Utils'

@Component
export struct WebView {
  @Prop url: string = ''
  controller: webview.WebviewController = new webview.WebviewController()

  aboutToAppear() {
    // Utils.Toast(AppStorage.Get('bilibili_cookie'))
    // webview.WebCookieManager.setCookie(this.url,AppStorage.Get<string>('bilibili_cookie'))
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
        })
        .onPageBegin((url) => {
          console.log('jtlurl:onPageBegin：' + url)
          //  let temp = AppStorage.Get<string>('bilibili_cookie')
          // let cookies  =temp.split(';')
          //  webview.WebCookieManager.putAcceptCookieEnabled(false)
          //  webview.WebCookieManager.setCookie(this.url, `${temp}`)
          //  for (let index = 0; index < cookies.length; index++) {
          //    const element = cookies[index];
          //  }
        })
        .onPageEnd((url) => {
          console.log('jtlurl:onPageEnd：' + url)
        })
        .onErrorReceive(() => {
          //加载错误时的回调
        })/*        .onUrlLoadIntercept(()=>{
return false
      }).onInterceptRequest((evnet)=>{
            let header = evnet.request.getRequestHeader()
            return new WebResourceResponse()
      })*/
          // .onRefreshAccessedHistory((event) => {
          //   this.loadingStatus = LoadingStatus.Loading
          //   console.log('jtlurl:' + event.url + ' isReload:' + event.isRefreshed)
          // })
        .onProgressChange((event) => {
          console.log('jtlurlnewProgress:' + event.newProgress)
        })
    }
  }
}