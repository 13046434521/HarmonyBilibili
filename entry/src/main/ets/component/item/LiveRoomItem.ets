import { SearchMediaFtBean } from '../../bean/SearchMediaFtBean'
import { Utils } from '../../Utils/Utils'
import router from '@ohos.router'
import { SearchLiveRoomBean } from '../../bean/SearchLiveRoomBean'
import { PageManager } from '../../common/PageManager'

@Component
export struct LiveRoomItem{
  item:SearchLiveRoomBean

  build(){
    this.liveRoomItem(this.item)
  }



  @Builder liveRoomItem(item:SearchLiveRoomBean){
    Column(){
      Stack({alignContent:Alignment.BottomStart}){
        Image('https:'+item.user_cover)
          .alt($r('app.media.ic_placeholder'))
          .width('100%')
          .objectFit(ImageFit.Cover)
          .borderRadius({topLeft:5,topRight:5})
          .aspectRatio(4/3)

        Text(item.uname)
          .backgroundColor($r('app.color.bilibili_text_grey_bold'))
          .opacity(0.6)
          .borderRadius(2)
          .margin(4)
          .padding(4)
          .textNameStyle()
      }

      Text(Utils.upRichTextClear(item.title))
        .fontSize(14)
        .fontColor($r('app.color.bilibili_text_black'))
        .textTitleStyle()

      Row(){
        Text(Utils.upRichTextClear(item.cate_name))
          .fontSize(10)
          .fontColor($r('app.color.bilibili_text_grey_bold'))
          .textOverflow({ overflow:TextOverflow.Ellipsis})
          .maxLines(1)
          .margin({left:4})


        Text(item.live_time)
          .fontSize(10)
          .fontColor($r('app.color.bilibili_text_grey_bold'))
          .textOverflow({ overflow:TextOverflow.Ellipsis})
          .maxLines(1)
          .margin({right:4})
      }.width('100%')
      .aspectRatio(8)
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .borderRadius({topLeft:5,topRight:5,bottomLeft:5,bottomRight:5 })
    .backgroundColor($r('app.color.bilibili_background_grey'))
    .onClick(event=>{
        Utils.Toast('roomid:'+item.roomid+"")
      PageManager.routerLiving(item.roomid)
    }).width('100%')
  }
}


@Extend(Text) function textNameStyle(){
  .height(20)
  .fontSize(11)
  .fontColor(Color.White)
}

@Extend(Text) function textTitleStyle(){
  .textOverflow({ overflow:TextOverflow.Ellipsis})
  .maxLines(1)
  .margin({left:4})
  .width('100%')
  .aspectRatio(6/1)
  .alignSelf(ItemAlign.Start)
}