import webview from '@ohos.web.webview'
import Constants from '../../common/Constants'
import Api from '../../net/Api'
import { Utils } from '../../Utils/Utils'
import VideoViewModel from '../../viewModel/Video/VideoViewModel'
import VideoIntroduction from '../Video/VideoIntroduction'
import window from '@ohos.window'

@Preview
@Component
export struct ShoppingPage {

  @State change:boolean = true
  @State heights:number=0
  @State widths:number=0
  @State orientation :window.Orientation = window.Orientation.PORTRAIT
  aboutToAppear(){
    this.widths = Constants.WINDOW_WIDTH
    this.heights = Constants.WINDOW_HEIGHT
  }
  build() {
    Column() {
      Button('test:'+this.orientation.toString()+"  "+ this.widths+"  "+  this.heights).onClick(()=>{
        this.changeOrientation()
      })
      Image($r('app.media.test'))
        .width('100%')
        .objectFit(ImageFit.Contain)
        .aspectRatio(this.orientation===window.Orientation.PORTRAIT?this.widths/this.heights:this.heights/this.widths)
        .borderColor(Color.Orange)
        .height('100%')
        .borderWidth(2)
    }
  }

  changeOrientation(){
    if (globalThis.windowStage != undefined) {
      globalThis.windowStage.getMainWindow((err, data) => {
        if (err.code) {
          console.error('IjkPlayer changeWindowDirection Failed to change the window: ' + JSON.stringify(err))
          return
        }
        let temp = this.orientation===window.Orientation.LANDSCAPE?window.Orientation.PORTRAIT:window.Orientation.LANDSCAPE
        data.setPreferredOrientation(temp);
        this.orientation = temp
      })
    }
  }
}