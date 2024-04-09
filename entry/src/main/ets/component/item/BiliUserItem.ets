import { SearchBiliUserBean } from '../../bean/search/SearchBiliUserBean'
import deviceInfo from '@ohos.deviceInfo'
import { PageManager } from '../../common/PageManager'
import { Utils } from '../../Utils/Utils'

@Component
export struct BiliUserItem{
  item: SearchBiliUserBean
  deviceType = 'tablet'
  userHeight = 150
  aboutToAppear(){
    this.deviceType = deviceInfo.deviceType

    this.userHeight = this.deviceType==="tablet"?100:80
  }
  build(){
    this.biliUserItem(this.item)
  }

  @Builder
  biliUserItem(item: SearchBiliUserBean) {
    Row() {
      Image(`https:${item.upic}`)
        .alt($r('app.media.ic_placeholder'))
        .margin(8)
        .height('65%')
        .aspectRatio(1)
        .borderRadius(100)
      Column() {
        Row() {
          Text(`${item.uname}`)
            .fontSize(13)
            .fontColor(item.official_verify.type === 127 ? $r('app.color.bilibili_text_black') : $r('app.color.bilibili_theme'))
          Image(userLevel(item.level))
            .height('15%')
            .margin(4)
            .objectFit(ImageFit.Auto)
        }

        Text(`${userFans(item.fans)}粉丝     ${item.videos}个视频${'\n'}${item.official_verify.desc}`)
          .fontColor($r('app.color.bilibili_text_grey_bold'))
          .fontSize(10)
          .maxLines(2)
          .lineHeight(16)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .height('45%')
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .height('80%')
      .margin(8)
      .layoutWeight(1)

      Text(" + 关注")
        .height('30%')
        .aspectRatio(3 / 1)
        .fontColor($r('app.color.bilibili_text_white'))
        .backgroundColor($r('app.color.bilibili_theme'))
        .textAlign(TextAlign.Center)
        .borderRadius(2)
        .margin(8)
        .fontSize(14)
    }
    .width('100%')
    .height(this.userHeight)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .onClick(()=>{
      PageManager.routerBiliUser(this.item.mid)
    })
  }
}

function userFans(fans: number): string {
  let fansRes = fans.toString()
  if (fans >= 10000) {
    fansRes = Math.floor(fans / 10000).toFixed(1) + "万"
  }

  return fansRes
}
function userLevel(level: number): Resource {
  let icon = $r('app.media.ic_im_user_level_0')
  switch (level) {
    case 1: {
      icon = $r('app.media.ic_im_user_level_1')
      break
    }
    case 2: {
      icon = $r('app.media.ic_im_user_level_2')
      break
    }
    case 3: {
      icon = $r('app.media.ic_im_user_level_3')
      break
    }
    case 4: {
      icon = $r('app.media.ic_im_user_level_4')
      break
    }
    case 5: {
      icon = $r('app.media.ic_im_user_level_5')
      break
    }
    case 6: {
      icon = $r('app.media.ic_im_user_level_6')
      break
    }
    default: {
      icon = $r('app.media.ic_im_user_level_0')
      break
    }
  }

  return icon
}
