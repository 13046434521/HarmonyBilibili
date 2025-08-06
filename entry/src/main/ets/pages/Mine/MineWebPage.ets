import webview from '@ohos.web.webview'
import router from '@ohos.router'
import { MINE_WEB_URL, RouterConstants } from '../../common/PageManager'
import { WebView } from '../../component/WebView'



@Entry
@Component
struct MineWebPage {
  url: string = ''

  aboutToAppear(){
    if (router.getParams()!=undefined) {
      const params = router.getParams() as MINE_WEB_URL
      this.url = params.webUrl
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      WebView({url:this.url})
    }.width('100%')
    .height('100%')
  }
}