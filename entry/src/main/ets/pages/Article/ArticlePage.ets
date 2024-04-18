import { LoadingStatus } from '../../common/LoadingStatus'
import webview from '@ohos.web.webview'
import router from '@ohos.router'
import { RouterConstants } from '../../common/PageManager'
import { JLog } from '../../common/JLog'
import { Utils } from '../../Utils/Utils'

@Entry
@Component
struct ArticlePage {
  @StorageProp('bilibili_cookie') cookie: string = ''
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  controller: webview.WebviewController = new webview.WebviewController()
  url = "https://www.bilibili.com/"
  articleId = 0

  aboutToAppear() {
    if (router.getParams() != null) {
      this.articleId = router.getParams()[RouterConstants.ARTICLE_ID]
      this.url = `https://www.bilibili.com/read/mobile?id=${this.articleId}`
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      this.webPage()

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
      .onUrlLoadIntercept((data) => {
        let url = data.data as string
        JLog.warn('url:', data.data as string)
        if (url.includes('https://www.bilibili.com/read/mobile?id') || url.includes("https://m.bilibili.com/opus/")) {
          JLog.warn('JTL', "没有拦截请求：" + data.data as string)
          return false
        } else {
          JLog.warn('JTL', "拦截请求：" + data.data as string)
          return true
        }
      })
      .onPageBegin((url) => {
        this.loadingStatus = LoadingStatus.LoadingSuccess
        JLog.warn('JTL', "开始加载：" + url.url + "页面")
      })
      .onPageEnd((url) => {
        this.loadingStatus = LoadingStatus.LoadingSuccess
        JLog.warn('JTL', "加载完成：" + url.url + "页面")
      })

      .onErrorReceive((event) => {
        let url = event.request.getRequestUrl()
        let info = event.error.getErrorInfo()
        let code = event.error.getErrorCode()
        //加载错误时的回调
        JLog.warn('JTL:onErrorReceive：' + +code + "  " + info + "  " + url)
        Utils.Toast('加载错误：' + code + "  " + info)
        this.loadingStatus = LoadingStatus.LoadingFailure
      })
      .onProgressChange((event) => {
        JLog.warn('JTL', "加载Progress：" + event.newProgress)
      })
  }
}