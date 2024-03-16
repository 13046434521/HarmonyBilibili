import { Utils } from '../Utils/Utils'
import router from '@ohos.router'

@Component
export struct SearchHeader {
  @Prop title: string
  @Prop isTitleVisible:boolean = false
  placeholder:string = ''
  clickEvent? = (title?:string,placeholder?:string)=> {}
  change? = (value:string)=> {}

  build() {
    Row() {
      Image($r('app.media.ic_common_back_gray'))
        .objectFit(ImageFit.Auto)
        .renderMode(ImageRenderMode.Original)
        .width(24)
        .margin({left:10,right:10})
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          router.back()
        })
      Search({value:this.isTitleVisible?this.title:null,placeholder: this.placeholder})
        .layoutWeight(1)
        .onChange((value: string) => {
          this.change(value)
        }).onSubmit((value:string)=>{
          this.change(value)
      })

      Text('搜索')
        .fontColor($r('app.color.bilibili_theme'))
        .fontSize(16)
        .margin({left:10,right:10})
        .width(40)
        .onClick(() => {
            this.clickEvent(this.title,this.placeholder)
        })
    }.width('100%')
  }
}