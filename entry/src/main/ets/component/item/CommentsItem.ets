import { CommentsReply } from '../../bean/CommentsInfo'
import { PageManager } from '../../common/PageManager'
import { Utils } from '../../Utils/Utils'

@Component
export struct CommentsItem{
  @Prop commentsReply:CommentsReply
  build(){
    Column(){
      Row(){
        Image(this.commentsReply.member.avatar)
          .borderRadius(100)
          .width('6%')
          .objectFit(ImageFit.Contain)
          .margin('1%')
          .alt($r('app.media.default_avater'))
          .onClick(() => {
            PageManager.routerBiliUser(this.commentsReply.mid)
          })

        Column() {
          Row() {
            Text(this.commentsReply.member.uname)
              .fontColor($r('app.color.bilibili_text_theme'))
            Image(userLevel(this.commentsReply.member.level_info.current_level))
              .width('3%')
              .objectFit(ImageFit.Contain)
              .margin('1%')
          }.justifyContent(FlexAlign.Start)
          .width('100%')

          Row() {
            Text(Utils.timestampToDate(this.commentsReply.ctime))
              .fontColor($r('app.color.bilibili_text_grey_light'))
              .fontSize(10)
          }.justifyContent(FlexAlign.Start)
          .width('100%')

          Text(this.commentsReply.content.message)
            .maxLines(this.commentsReply.content.max_line)
            .textAlign(TextAlign.Start)
            .width('100%')
            .margin({ top: '2%', bottom: "2%" })

          Row() {
            Image($r('app.media.icon_video_like'))
              .margin({ right: '1%' })
              .height('80%')
              .aspectRatio(1)
              .fillColor($r('app.color.color_gray'))
            Text(Utils.Views(this.commentsReply.like, 1))
              .fontColor($r('app.color.bilibili_text_grey_light'))
              .fontSize(12).margin({ right: '4%' })
            Image($r('app.media.icon_video_dislike')).margin({ right: '4%' })
              .fillColor($r('app.color.color_gray'))
              .height('80%')
              .aspectRatio(1)
            Image($r('app.media.icon_video_share')).margin({ right: '4%' })
              .height('80%')
              .aspectRatio(1)
              .fillColor($r('app.color.color_gray'))
            Text('回复')
              .fontColor($r('app.color.bilibili_text_grey_light'))
              .fontSize(12).margin({ right: '4%' })
          }.width('100%')
          .height('4%')
          if (this.commentsReply.replies!==null && this.commentsReply.replies.length!==0){
            Column(){
              ForEach(this.commentsReply.replies,(reply:CommentsReply)=>{
                Row(){
                  Text(reply.member.uname)
                    .fontColor($r('app.color.bilibili_text_blue_dark'))
                    .margin({left:'2%'})

                  Text('：') .fontColor($r('app.color.bilibili_text_black'))

                  Text(`${reply.content.message}`)
                    .fontColor($r('app.color.bilibili_text_black'))
                    .maxLines(reply.content.max_line)
                    .margin({right:'2%'})
                    .layoutWeight(1)
                }.width('100%')
                .justifyContent(FlexAlign.Start)
                .alignItems(VerticalAlign.Top)
                .margin({top:'1%'})
                .onClick(() => {
                  PageManager.routerBiliUser(reply.mid)
                })
              })
              if (this.commentsReply.reply_control!==undefined) {
                Text(this.commentsReply.reply_control.sub_reply_entry_text)
                  .fontColor($r('app.color.bilibili_text_blue_dark'))
                  .maxLines(this.commentsReply.reply_control.max_line)
                  .margin({top:'1%',bottom:'2%',left:'2%'})
              }
            }.borderRadius(10)
            .backgroundColor($r('app.color.bilibili_background_grey'))
            .justifyContent(FlexAlign.Start)
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .margin({top:'1%',bottom:'2%'})
          }
        }.justifyContent(FlexAlign.Start)
        .width('90%')
      }.justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Top).width('100%')


      Divider().strokeWidth(1).color($r('app.color.bilibili_divider'))
        .width('100%')
        .margin({top:'2%',bottom:'2%'})
    }
  }
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