import { UserInfoBean } from '../../bean/biliUser/UserInfoBean'
import Stat from '../../bean/Stat'
import VideoInfo from '../../bean/video/VideoInfo'
import { JLog } from '../../common/JLog'
import { Utils } from '../../Utils/Utils'
import VideoViewModel from '../../viewModel/Video/VideoViewModel'

@Component
export default struct VideoIntroduction {
  @State videoInfo:VideoInfo = new VideoInfo()
  @State userInfo:UserInfoBean = new UserInfoBean()
  videoViewModel:VideoViewModel
  bvid:string

  aboutToAppear(){
    this.videoViewModel.loadVideoInfo(this.bvid).then(videoInfo=>{
      this.videoInfo = videoInfo
      return this.videoViewModel.upInfo(videoInfo.owner.mid)
    }).then(userInfo=>{
        this.userInfo = userInfo
    })


  }
  build(){
    Scroll(){
      Column(){
        // 头像
        // 标题
        // 详情
        // tag
        // 点赞,不喜欢,投币,收藏,分享
        // 其他视频
        Row(){
          Image(this.videoInfo.owner.face)
            .height('100%')
            .aspectRatio(1)
            .borderRadius(100)
            .margin({right:'1%'})

          Column(){
            Text(this.videoInfo.owner.name)
              .textStyle($r('app.color.bilibili_text_black_middle'),16)
            Row(){
              Text(Utils.userFans(this.userInfo.follower)+'粉丝')
                .textStyle()
              Text('视频:'+this.videoInfo.dimension.width +"*"+this.videoInfo.dimension.height)
                .textStyle()
                .margin({left:"2%"})
            }.margin({top:'1%'})
          }.width('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Start)

        }.height('8%')
        .margin({left:"2%"})
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

        Text(this.videoInfo.title)
          .textStyle($r('app.color.bilibili_text_black_middle'),20)
          .borderWidth(1)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .maxLines(2)
          .borderColor(Color.Black)
          .margin({left:"2%",top:'2%'})

        Row(){
          Icon({res:$r("app.media.ic_video_like"),content:Utils.userFans(this.videoInfo.stat.like)})
          Icon({res:$r('app.media.ic_video_coin'),content:Utils.userFans(this.videoInfo.stat.coin)})
          Icon({res:$r('app.media.ic_video_favorite'),content:Utils.userFans(this.videoInfo.stat.favorite)})
          Icon({res:$r('app.media.ic_video_share'),content:Utils.userFans(this.videoInfo.stat.share)})
        }.justifyContent(FlexAlign.Start)
        .borderWidth(1)
        .borderColor(Color.Yellow)
        .height('8%')
        .margin({left:"2%",top:'2%'})
      }.justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .borderWidth(1)
      .borderColor(Color.Green)
      .width('100%')
    }
  }

}
@Component
struct Icon{
  @Prop res:Resource
  @Prop content:string
  build(){
    Column(){
      Image(this.res)
        .objectFit(ImageFit.Contain)
        .layoutWeight(1)
        .margin({bottom:'2%'})
        .fillColor($r('app.color.bilibili_background_black_light'))
      Text(this.content)
        .textStyle()
        .height('30%')
    }.borderColor(Color.Red)
    .borderWidth(2)
    .layoutWeight(1)
  }
}

@Extend(Text)
function textStyle(color:Resource=$r('app.color.bilibili_text_grey_light'),size:number=14 ){
  .fontColor(color)
  .fontSize(size)
}