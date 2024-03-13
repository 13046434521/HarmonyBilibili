import router from '@ohos.router'
import display from '@ohos.display'
import Api from '../net/Api'
import { VideoPlay } from '../component/VideoPlay'

@Entry
@Component
struct DetailPage {
  @State bvid: string = ""
  @State cid: number = 0


  aboutToAppear() {
    this.bvid = router.getParams()['bvid']
    this.cid = router.getParams()['cid']
  }

  build() {
    Row() {
      Column() {
        VideoPlay({bvid:this.bvid,cid:this.cid})
          .width('100%')
      }.layoutWeight(1)
    }.width('100%')
    .height('100%')
  }
}
