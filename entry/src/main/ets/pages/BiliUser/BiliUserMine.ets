import { UserVideoBean } from '../../bean/biliUser/UserVideoBean'
import ApiBiliUser from '../../net/ApiBiliUser'

@Component
export struct BiliUserMine{
  mid:number = 0
  @State state:string = ''
  aboutToAppear(){
/*    ApiBiliUser.getBiliUserVideo<UserVideoBean>(this.mid,"pubdate").then((videoData)=>{
      this.state += "视频:"+videoData.list.vlist.length+"\n"
    }).catch(err=>{
      this.state += "视频:"+err +"\n"
    })
    ApiBiliUser.getBiliUserBookmarks(this.mid).then(()=>{
      this.state += "收藏夹:"+"\n"
    }).catch(err=>{
      this.state += "收藏夹 :"+err +"\n"
    })
    ApiBiliUser.getBiliUserBangumi(this.mid).then(()=>{
      this.state += "追番:"+"\n"
    }).catch(err=>{
      this.state += "追番:"+err +"\n"
    })
    ApiBiliUser.getBiliUserCoin(this.mid).then(()=>{
      this.state += "投币视频:" +"\n"
    }).catch(err=>{
      this.state += "投币视频:"+err +"\n"
    })

    ApiBiliUser.getBiliUserUpvote(this.mid).then(()=>{
      this.state += "点赞视频:"+"\n"
    }).catch(err=>{
      this.state += "点赞视频:"+err +"\n"
    })
    ApiBiliUser.getBiliUserDynamic(this.mid).then(()=>{
      this.state += "动态:"+"\n"
    }).catch(err=>{
      this.state += "动态:"+err +"\n"
    })


    ApiBiliUser.getBiliUserCollection(this.mid).then(()=>{
      this.state += "合集和收藏:"+"\n"
    }).catch(err=>{
      this.state += "合集和收藏:"+err +"\n"
    })*/
  }

  build(){
    Column(){
      Text(this.state)
    }.width('100%')
    .height('100%')
    .borderColor(Color.Orange)
    .borderWidth(2)
  }
}