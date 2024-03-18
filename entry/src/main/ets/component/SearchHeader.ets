import { Utils } from '../Utils/Utils'
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

@Component
export struct SearchHeader {
  @Prop title: string
  @Prop isTitleVisible: boolean = false
  placeholder: string = ''
  clickEvent? = (title?: string, placeholder?: string) => {}
  change? = (value: string) => {}

  build() {
    Row() {
      Image($r('app.media.ic_common_back_gray'))
        .objectFit(ImageFit.Auto)
        .renderMode(ImageRenderMode.Original)
        .width(24)
        .margin({ left: 10, right: 10 })
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          router.back()
        })
      Search({ value: this.isTitleVisible ? this.title : null, placeholder: this.placeholder })
        .onChange((value: string) => {
          this.change(value)
        }).onSubmit((value: string) => {
        this.change(value)
        })
        .layoutWeight(1)

      Button('搜索')
        .fontColor($r('app.color.bilibili_theme'))
        .fontSize(14)
        .margin({ right: 2})
        .width(80)
        .onClick(() => {
          this.clickEvent(this.title, this.placeholder)
        })
        .backgroundColor(Color.White)

    }.width('100%')
  }
}