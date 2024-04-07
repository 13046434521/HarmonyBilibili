import { AccInfo } from '../bean/biliUser/AccInfo'
import { UserInfoBean } from '../bean/biliUser/UserInfoBean'
import { UserStateBean } from '../bean/biliUser/UserStateBean'
import { ApiBase } from './ApiBase'
import NetEncryption from './NetEncryption'

 export class ApiBiliUser extends ApiBase{
  // https://api.bilibili.com/x/space/wbi/acc/info?mid=''&wts=1685070149&w_rid=f7b376124782ae8cb42c56fdd69144ed
  // 用户空间详细信息 Cookie（SESSDATA）
  getUserAccInfo(mid:number){
    let param={'mid':mid}
    return NetEncryption.getWbi(param).then(webi=>{
      let url =  `https://api.bilibili.com/x/space/wbi/acc/info?${webi}`
      console.warn('WBI',url)
      return this.request<AccInfo>(url,this.instanceAxios)
    })
  }

   // https://api.bilibili.com/x/web-interface/card?mid=68406011
   // 用户名片信息 Cookie（SESSDATA）
   loginUserInfo(mid:number):Promise<UserInfoBean>{
     let url = `https://api.bilibili.com/x/web-interface/card?mid=${mid}`
     return this.request<UserInfoBean>(url,this.instanceAxios)
   }

   getUserState():Promise<UserStateBean>{
     let url = "https://api.bilibili.com/x/web-interface/nav/stat"
     return this.request<UserStateBean>(url,this.instanceAxios)
   }
   //
   // https://api.bilibili.com/x/relation/followings?vmid=11474631
   //  https://api.bilibili.com/x/relation/followings?vmid=68406011
   // 查看用户关注列表，（隐藏的无法查看）

   // https://api.bilibili.com/x/relation/tags
   // 获取关注分组,每组数量以及分组id。没有详细内容

   // https://api.bilibili.com/x/relation/tag?tagid=-10&order_type=&ps=2&pn=1
   // 根据分组id，获取对应的关注列表  ps为返回个数，pn为页数  order_type:attention(常访问排序)，''或者不填写(默认排序)

    // https://api.bilibili.com/x/space/top/arc?vmid=68406011
   // 查询置顶视频 --- app中用不到

   // https://api.bilibili.com/x/space/masterpiece?vmid=68406011
   // 查询代表作视频 --- app中用不到

   // https://api.bilibili.com/x/space/notice?mid=17920281
   // 个人空间公告 --- app中用不到

   // https://api.bilibili.com/x/space/like/video?vmid=17920281
   // 点赞的视频

   // https://api.bilibili.com/x/space/coin/video?vmid=17920281
   // 投币的视频

   // https://api.bilibili.com/x/v3/fav/folder/created/list-all?up_mid=68406011
   // 查询用户收藏夹列表

   //https://space.bilibili.com/ajax/Bangumi/getList?mid=68406011&type=1&ps=2&pn=1
   // 查询用户追番列表

   // https://api.bilibili.com/x/space/bangumi/follow/list?vmid=68406011&type=1&ps=2&pn=1
   // 查询用户追番明细 (type=1：追番  2：追剧)

   // https://space.bilibili.com/ajax/tags/getSubList?mid=68406011&type=1&ps=2&pn=1
   // 查询用户关注话题

   // https://api.bilibili.com/x/space/upstat?mid=430426421
   // 获取播放量和获赞

   // https://api.bilibili.com/x/relation/stat?vmid=430426421
   // 获取用户关注和粉丝数

   // https://api.bilibili.com/x/v3/fav/folder/collected/list?pn=1&ps=20&up_mid=68406011&platform=web
   // 我的收藏和订阅文件夹（我的收藏页面-》我创建的收藏文件夹下面）


   //https://api.bilibili.com/x/v3/fav/resource/list?media_id=101882111&pn=1&ps=20&keyword=&order=mtime&type=0&tid=0&platform=web
   //收藏文件夹中的内容

   // https://api.bilibili.com/x/space/navnum?mid=68406011
   // 用户页面各种类型数量（番剧多少，投稿多少）

   // https://api.bilibili.com/x/space/wbi/arc/search?mid=68406011&order=&pn=1&wts=1712417536&w_rid=2c915ca0c273fd92bb2eb248088cff60
   // 主页->我的视频 ----不能用  tid：分区筛选，默认为0不进行分区筛选，	order:默认为pubdate最新发布：pubdate最多播放：click多收藏：stow
    getBiliUserVideo<T>(mid:number,order:'pubdate'|'click'|'stow',pn:number=1){
      let param ={mid:mid,order:order,pn:pn}

      return NetEncryption.getWbi(param).then(wbi=>{
        let url = `https://api.bilibili.com/x/space/wbi/arc/search?${wbi}`
        return this.request<T>(url,this.instanceAxios)
      })
    }
   //  https://api.bilibili.com/x/space/coin/video?vmid=68406011&wts=1712425725&w_rid=aa1573efd400be4c3b0af4c092027a6c
   // 主页->最近投币视频
   getBiliUserCoin<T>(mid:number){
     let param ={'vmid':mid}

     return NetEncryption.getWbi(param).then(wbi=>{
       let url = `https://api.bilibili.com/x/space/coin/video?${wbi}`
       console.error('ApiBiliUser',"BiliUserCoin:  "+url)
       return this.request<T>(url,this.instanceAxios)
     })
   }
   //https://api.bilibili.com/x/space/like/video?vmid=68406011&wts=1712425725&w_rid=aa1573efd400be4c3b0af4c092027a6c
   //主页->最近点赞视频
   getBiliUserUpvote<T>(mid:number){
     // let param ={vmid:mid,gaia_source:'main_web',web_location:'333.999'}
     let param ={vmid:mid}

     return NetEncryption.getWbi(param).then(wbi=>{
       let url = `https://api.bilibili.com/x/space/like/video?${wbi}`
       console.error('ApiBiliUser',"Upvote:  "+url)
       return this.request<T>(url,this.instanceAxios)
     })
   }

   //https://api.bilibili.com/x/v3/fav/folder/created/list?pn=1&ps=10&up_mid=68406011
   //主页->我的收藏夹（只有收藏夹名字和里面的数量，没有详细信息
   getBiliUserBookmarks<T>(mid:number,pn:number=1,ps:number=10){
     let url = `https://api.bilibili.com/x/v3/fav/folder/created/list?pn=${pn}&ps=${ps}&up_mid=${mid}`
     return this.request<T>(url,this.instanceAxios)
   }
   // https://api.bilibili.com/x/space/bangumi/follow/list?vmid=68406011&type=1&pn=1&ps=1
  // 主页->订阅的番剧(有seasonid和mediaid)type可能是番剧和影视切换
   getBiliUserBangumi<T>(mid:number,pn:number=1,ps:number=10,type:1|2=1){
     let url = `https://api.bilibili.com/x/space/bangumi/follow/list?vmid=${mid}&type=${type}&pn=${pn}&ps=${ps}`
     return this.request<T>(url,this.instanceAxios)
   }
   //https://api.bilibili.com/x/polymer/web-space/home/seasons_series?mid=68406011&page_num=1&page_size=10
   //主页->我的合集和视频列表(有aid，bid等)
   getBiliUserCollection<T>(mid:number,pn:number=1,ps:number=10){
     let url = `https://api.bilibili.com/x/polymer/web-space/home/seasons_series?mid=${mid}&page_num=${pn}&page_size=${ps}`
     return this.request<T>(url,this.instanceAxios)
   }
   // https://api.bilibili.com/x/polymer/web-dynamic/v1/feed/space?host_mid=68406011&wts=1712425725&w_rid=03e9f28257770ebe67fc939799b452d1
   // 我的动态
   getBiliUserDynamic<T>(mid:number){
     let param ={'host_mid':mid}

     return NetEncryption.getWbi(param).then(wbi=>{
       let url = `https://api.bilibili.com/x/polymer/web-dynamic/v1/feed/space?${wbi}`
       console.error('ApiBiliUser',"Dynamic:  "+url)
       return this.request<T>(url,this.instanceAxios)
     })
   }
   // https://api.bilibili.com/x/space/bangumi/follow/list?type=1&follow_status=0&pn=1&ps=15&vmid=68406011&ts=1712058829031
   // 我的追番内容
 }

const biliUser = new ApiBiliUser()
export default biliUser as ApiBiliUser
