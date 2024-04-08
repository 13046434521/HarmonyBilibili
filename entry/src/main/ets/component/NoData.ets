import { Utils } from '../Utils/Utils'

@Component
@Preview
export struct NoData{
  @State index:number = Math.random()
  reload:()=>void = undefined
  imgArr:Resource[]=[$r("app.media.img_tips_error_no_permission"),$r('app.media.img_holder_search_failed'),$r('app.media.bilibili_no_data'),$r('app.media.ic_following_no_exist'),$r('app.media.ic_empty_list_not_found')]

  aboutToAppear(){
    let temp = this.index * 10
    this.index =Math.floor (temp % this.imgArr.length)
  }


  build(){
    Column(){
      Column(){
        Image(this.imgArr[this.index])
          .objectFit(ImageFit.Cover)
          .width('70%')
          .interpolation(ImageInterpolation.High)
        if (this.reload!==undefined){
          Button('重新加载')
            .fontColor($r('app.color.bilibili_text_white')).backgroundColor($r('app.color.bilibili_theme'))
            .onClick(()=>{
              this.reload()
            }).fontSize(18)
        } else if (this.index!==1){
          Text("今天真是寂寞如雪啊 ~ ").fontSize(18).maxLines(1)
            .textOverflow({overflow:TextOverflow.Ellipsis})
            .fontColor($r('app.color.bilibili_text_grey_bold'))
            .margin(12)
        }
      }
    }.width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}