import router from '@ohos.router'
import Constants from '../common/Constants'

@Component
export struct SearchHeader {
  @Prop title: string
  @Prop isTitleVisible: boolean = false
  placeholder: string = ''
  clickEvent = (title: string, placeholder: string) => {}
  change = (value: string) => {}
  controller:SearchController = new SearchController()

  build() {
    Row() {
      Image($r('app.media.ic_common_back_gray'))
        .objectFit(ImageFit.Auto)
        .interpolation(ImageInterpolation.High)
        .renderMode(ImageRenderMode.Original)
        .width(24)
        .margin({ left: 10, right: 10 })
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          router.back()
        })
      TextInput({placeholder: this.placeholder,text: this.isTitleVisible ? this.title : null})
        .onChange((value: string) => {
          this.change(value)
        })
        .type(InputType.Normal)
        .enterKeyType(EnterKeyType.Search)
        .onSubmit((enterKey: EnterKeyType)=>{
          if (enterKey === EnterKeyType.Search) {
            this.clickEvent(this.title, this.placeholder)
          }
      }).layoutWeight(1)
      // Search({ value: this.isTitleVisible ? this.title : null, placeholder: this.placeholder ,controller:this.controller})
      //   .onChange((value: string) => {
      //     this.change(value)
      //   }).onSubmit((value: string) => {
      //   this.change(value)
      //   })
      //   .layoutWeight(1)

      Button('搜索')
        .id(Constants.SEARCH_FOCUS_ID)
        .key(Constants.SEARCH_FOCUS_ID)
        .fontColor($r('app.color.bilibili_theme'))
        .fontSize(14)
        .margin({ right: 2})
        .width(80)
        .onClick(() => {
          this.clickEvent(this.title, this.placeholder)
        })
        .focusOnTouch(true)
        .defaultFocus(true)
        .backgroundColor(Color.White)

    }.width('100%')
    .margin({top:'4%'})
  }
}