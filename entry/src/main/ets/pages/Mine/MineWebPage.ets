import webview from '@ohos.web.webview'
import router from '@ohos.router'
import { RouterConstants } from '../../common/PageManager'
import { WebView } from '../../component/WebView'

@Entry
@Component
struct MineWebPage {
  url: string = ''

  aboutToAppear(){
    if (router.getParams()!=undefined) {
      this.url = router.getParams()[RouterConstants.MINE_WEB_URL]
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      WebView({url:this.url})
    }.width('100%')
    .height('100%')
  }
}