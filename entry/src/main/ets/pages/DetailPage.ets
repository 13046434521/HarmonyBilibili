import router from '@ohos.router'
import display from '@ohos.display'
import Api from '../net/Api'
import { IjkPlayer, IjkPlayerConfig, IjkPlayerConfigType } from '../common/IjkPlayer'
import url from '@ohos.url'

@Entry
@Component
struct DetailPage {
  @State bvid: string = ""
  @State cid: number = 0
  @State url: string = ""
  @State ijkConfig: IjkPlayerConfig = new IjkPlayerConfig()

  aboutToAppear() {
    this.bvid = router.getParams()['bvid']
    this.cid = router.getParams()['cid']


  }

  build() {
    Row() {
      Column() {
        Video({ src: this.url }).width('100%')
          .height(240)
          .autoPlay(false)

        XComponent({
          id: this.ijkConfig.id,
          type: this.ijkConfig.type,
          libraryname: this.ijkConfig.libraryName
        }).onLoad((context) => {
          Api.getPlayVideo(this.bvid, this.cid).then(playVideoBean => {
            this.url = playVideoBean.durl[0].url //.replace(/\\u0026/g, '&')
            console.log("getPlayVideo url:" + this.url)

            this.ijkConfig.url = this.url

            // 初始化Player,不包括播放
            IjkPlayer.getInstance().initPlayer(context, this.ijkConfig)
            // 播放视频
            IjkPlayer.getInstance().start()
          })
        })
          .onDestroy(() => {
          })
          .width('100%')
          .aspectRatio(4 / 3)
      }.layoutWeight(1)
    }.width('100%')
    .height('100%')
  }
}
