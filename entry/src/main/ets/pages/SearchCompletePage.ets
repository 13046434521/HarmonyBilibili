import url from '@ohos.url'
import webview from '@ohos.web.webview'
import { Loading } from '../component/LoadingComponent'

@Entry
@Component
struct SearchCompletePage {
  url: string = 'https://b23.tv/4n9Mg7Q'
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