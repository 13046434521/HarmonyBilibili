import WebView from '@ohos.web.webview';

@Component
export default struct UserAgent {
  @State user: string = '';
  private controller: WebView.WebviewController = new WebView.WebviewController();

  build() {
    Column() {
      Web({
        src: $rawfile(' '),
        controller: this.controller
      })
        .width('100%')
        .height('50%')
        .userAgent(this.user)
        .onPageBegin(() => {
          this.user = this.controller.getUserAgent() + '123456789'
        })
    }
    .height('100%')
    .width('100%')
  }
}