import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import Api from '../net/Api'
import { LoadingData } from './LoadingData'
import router from '@ohos.router'
import { SearchBiliUserBean } from '../bean/SearchBiliUserBean'
import { Utils } from '../Utils/Utils'

@Component
export struct SearchBiliUserDetails {
  @State message: string = '用户'
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @Prop search: string = ""
  @State page: number = 1
  @State searchBiliUserBeans: Array<SearchBiliUserBean> = null
  searchType: SearchType = SearchType.BILI_USER

  aboutToAppear() {
    this.initPage()
    console.log("用户 页面刷新了")
  }
  aboutToDisappear(){
    console.log("用户 页面销毁了")
  }

  initPage() {
    this.page = 1
    Api.getSearchType<SearchBiliUserBean>(this.searchType, this.search, this.page).then(response => {
      this.searchBiliUserBeans = response.result
      this.loadingStatus = LoadingStatus.LoadingSuccess
    }).catch(err => {
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  build() {
    Row() {
      LoadingData({ loadingStatus: this.loadingStatus, page: this.biliUserPage.bind(this),extraFailure:"SearchBiliUser",extraSuccess:'SearchBiliUser' })
    }
    .height('100%')
  }

  @Builder
  biliUserPage() {
    Column(){
      List() {
        ForEach(this.searchBiliUserBeans, (item: SearchBiliUserBean,index?: number) => {
          ListItem(){
            this.biliUserItem(item)
          }
        })
      }.layoutWeight(1)
      .cachedCount(3)
      .onReachEnd(() => {
        Api.getSearchType<SearchBiliUserBean>(this.searchType, this.search, this.page + 1).then(response => {
          if (response.result!=undefined) {
            this.page++
            this.searchBiliUserBeans = this.searchBiliUserBeans.concat(response.result)
          }
        }).catch(err => {
          Utils.Toast(err)
        })
      }).divider({ strokeWidth: 1, color: $r('app.color.bilibili_divider'), startMargin: 8, endMargin: 8 })
      .width('100%')
      .backgroundColor(Color.White)
    }
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
          Image(this.userLevel(item.level))
            .height('15%')
            .margin(4)
            .objectFit(ImageFit.Auto)
        }

        Text(`${this.userFans(item.fans)}粉丝     ${item.videos}个视频${'\n'}${item.official_verify.desc}`)
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
    .aspectRatio(25 / 6)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }

  userLevel(level: number): Resource {
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

  userFans(fans: number): string {
    let fansRes = fans.toString()
    if (fans >= 10000) {
      fansRes = Math.floor(fans / 10000).toFixed(1) + "万"
    }

    return fansRes
  }
}