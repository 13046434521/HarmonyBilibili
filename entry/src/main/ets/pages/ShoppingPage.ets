import webview from '@ohos.web.webview'
import { LoadingStatus } from '../common/LoadingStatus'
import { Loading } from '../component/LoadingComponent'

@Preview
@Component
  // 主界面中的购物页面，很可能被去掉
export struct ShoppingPage {
  url: string = getContext(this).resourceManager.getStringSync($r('app.string.web_shopping_link'))
  controller: webview.WebviewController = new webview.WebviewController()
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading

  build() {
    Stack({ alignContent: Alignment.Center }) {
      this.webPage()
      if (this.loadingStatus==LoadingStatus.Loading){
        Loading().layoutWeight(1).backgroundColor(Color.White)
      }
    }.width('100%')
    .height('100%')
  }

  @Builder
  webPage() {
    Web({ src: this.url, controller: this.controller })
      .javaScriptAccess(true)
      .width('100%')
      .height('100%')
      .layoutWeight(1)
      .onPageBegin((url) => {
        console.log('jtlurl:onPageBegin：'+url )
        this.loadingStatus = LoadingStatus.LoadingSuccess
      })
      .onPageEnd((url) => {
        console.log('jtlurl:onPageEnd：'+url )
        this.loadingStatus = LoadingStatus.LoadingSuccess
      })

      .onErrorReceive(() => {
        //加载错误时的回调
        this.loadingStatus = LoadingStatus.LoadingFailure
      })
      .onRefreshAccessedHistory((event) => {
        this.loadingStatus = LoadingStatus.Loading
        console.log('jtlurl:' + event.url + ' isReload:' + event.isRefreshed)
      })
      .onProgressChange((event) => {
        console.log('jtlurlnewProgress:' + event.newProgress)
      })
  }
}