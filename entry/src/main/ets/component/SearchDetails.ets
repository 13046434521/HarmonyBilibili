import Api from '../net/Api'
import { Loading } from './LoadingComponent'
import router from '@ohos.router'
import { SearchDetailsBean, SearchDetailsItemBean } from '../bean/SearchDetailsBean'
import { Utils } from '../Utils/Utils'

@Component
export struct SearchVideoDetails {
  @State isLoading: number = 0 // 为0时正在加载，1时加载成功,-1加载失败
  @Link search: string
  @State page:number=1
  @State searchDetailsItemBean:SearchDetailsItemBean[] =null
  aboutToAppear(){
    Api.getSearchDetails('video',this.search,this.page).then((searchDetailsBean)=>{
      this.isLoading = 1
      this.searchDetailsItemBean = searchDetailsBean.result
    }).catch((err=>{
      this.isLoading = -1
    }))
  }
  build() {
    Column(){
      if (this.isLoading === 0) {
        Loading().layoutWeight(1)
      }else if (this.isLoading === 1){
        List(){
          ForEach( this.searchDetailsItemBean,(item:SearchDetailsItemBean)=>{
            ListItem(){
              this.VideoItem(item)
            }
          })
        }.width('100%')
        .layoutWeight(1)
      }else {
        Text("加载出错")
          .width('100%')
          .height('100%')
      }
    }.width('100%')
    .height('100%')
  }

  @Builder VideoItem(item:SearchDetailsItemBean){
    Column(){
      Divider().color(Color.Gray)
        .margin({ left:5 ,right:5})
      Row(){
        Image(item.upic)
          .width('50%')
          .aspectRatio(16/9)
          .margin({left:4,right:4})
/*        Stack(){
          Image(item.upic)
            .width('100%')
            .aspectRatio(16/9)

          Text(item.duration)
            .maxLines(1)
            .margin({bottom:4,right:8})
            .fontSize(13)
            .backgroundColor(Color.Grey)
            .fontColor(Color.Black)
            .borderRadius(2)


        }.width('50%')
        .align(Alignment.BottomEnd)*/

        Column(){
          Text(item.title)
            .maxLines(2)
            .fontColor(Color.Black)
            .fontSize(14)
            .textOverflow({overflow:TextOverflow.Ellipsis})

          Blank().layoutWeight(1)
            .margin(15)
          Row(){
            Image($r('app.media.icon_playlist_upper'))
              .imageStyle()
            Text(item.author)
              .textStyle()
          }.margin({left:8,bottom:4})
          Row(){
            Image($r('app.media.ic_video_play_dack'))
              .imageStyle()
            Text(Utils.Views(item.play))
              .textStyle()

            Image($r("app.media.ic_danmakus_dark"))
              .imageStyle()
              .margin({left:8,right:8})
            Text(Utils.Views(item.danmaku))
              .textStyle()

          }.margin({left:8,bottom:8,top:4})
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)


      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .aspectRatio(16/5)
    }
  }
}


@Extend(Image) function imageStyle(){
  .height(14)
  .width(14)
  .margin({right:8})
  .objectFit(ImageFit.Auto)
}

@Extend(Text) function textStyle(){
  .fontSize(12)
  .fontColor(Color.Grey)
  .maxLines(1)
  .textOverflow({overflow:TextOverflow.Ellipsis})
}