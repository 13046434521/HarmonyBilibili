import router from '@ohos.router'
import { Utils } from '../Utils/Utils'

@Component
export struct SearchHeader {
  @State title: string=''
  placeholder:string = ''
  clickEvent? = (title?:string,placeholder?:string)=> {}
  change? = (value:string)=> {}

  build() {
    Row() {
      Image($r('app.media.ic_common_back_gray'))
        .objectFit(ImageFit.Auto)
        .renderMode(ImageRenderMode.Original)
        .width(24)
        .height('100%')
        .margin(10)
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          router.back()
        })
      Search({ placeholder: this.placeholder})
        .height('100%')
        .layoutWeight(1)
        .onChange((value: string) => {
          this.change(value)
        }).onSubmit((value:string)=>{
          this.change(value)
      })

      Text('搜索')
        .fontColor($r('app.color.bilibili_theme'))
        .fontSize(16)
        .margin(15)
        .height('100%')
        .width(40)
        .onClick(() => {
            this.clickEvent(this.title,this.placeholder)
        })
    }.width('100%')
    .height('5%')
    .margin({ top:15,left:15,right:15,bottom:10 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}