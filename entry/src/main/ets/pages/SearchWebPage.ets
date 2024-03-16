import url from '@ohos.url'
import webview from '@ohos.web.webview'
import { Loading } from '../component/LoadingComponent'

@Entry
@Component
// 完整的热搜页面
struct SearchWebPage {
  url: string = getContext(this).resourceManager.getStringSync($r('app.string.web_searchhot_link'))
  controller: webview.WebviewController = new webview.WebviewController()
@State loadingPage:boolean = false
  build() {

    Stack({alignContent:Alignment.Center}) {
      if (!this.loadingPage){
        Loading().layoutWeight(1)
      }
      Web({ src: this.url, controller: this.controller })
        .javaScriptAccess(true)
        .width('100%')
        .layoutWeight(1)
        .onPageEnd(()=>{
          this.loadingPage = true
        }).width('100%').height('100%')

    }.width('100%')
    .height('100%')
  }
}