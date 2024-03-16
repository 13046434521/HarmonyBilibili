import router from '@ohos.router'

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
        .margin(10)
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          router.back()
        })
      Search({ placeholder: this.placeholder})
        .layoutWeight(1)
        .onChange((value: string) => {
          this.change(value)
        }).onSubmit((value:string)=>{
          this.change(value)
      })

      Text('搜索')
        .fontColor($r('app.color.bilibili_theme'))
        .fontSize(16)
        .margin(10)
        .width(40)
        .onClick(() => {
            this.clickEvent(this.title,this.placeholder)
        })
    }.width('100%')
    .margin({ top:5,left:15,right:15,bottom:5 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}