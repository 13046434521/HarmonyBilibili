import { UserBangumi } from '../../bean/biliUser/UserBangumi'
import { UserBookmark } from '../../bean/biliUser/UserBookmark'
import { UserCoinVideo } from '../../bean/biliUser/UserCoinVideo'
import { UserCollection } from '../../bean/biliUser/UserCollection'
import { UserDynamic } from '../../bean/biliUser/UserDynamic'
import { UserUpvote } from '../../bean/biliUser/UserUpvote'
import { UserVideoBean } from '../../bean/biliUser/UserVideoBean'
import ApiBiliUser from '../../net/ApiBiliUser'
import { Utils } from '../../Utils/Utils'
import HashSet from '@ohos.util.HashSet'
import HashMap from '@ohos.util.HashMap'
import { AccInfo } from '../../bean/biliUser/AccInfo'
import { UserInfoBean } from '../../bean/biliUser/UserInfoBean'

export class BiliUserViewModel {
  controller?:TabsController

  constructor(controller?:TabsController) {
    this.controller = controller
  }

  // 获取用户数据
  getUserAllData(mid: number) {
    return  Promise.all([this.getUserAccInfo(mid),
    this.getLoginUserInfo(mid),
    this.getUserVideoData(mid),
    this.getUserBookmarksData(mid),
    this.getUserBangumiData(mid),
    this.getUserCoinData(mid),
    this.getUserLikeData(mid),
    this.getUserDynamicData(mid),
    this.getUserCollection(mid)]).then((value )=>{
      console.error('BiliUser  Page:video:start')
      // 数据处理。因为有的用户，数据会返回空。此时统一将值设置为undefined，方便后面ui操作
      let accInfo = value[0]//该数据可能为：undefined
      let userInfo = value[1]

      // 主页的影视和投稿页面中的数据
      let userVideoBean:UserVideoBean = value[2]
      if (!Utils.isNonNull(userVideoBean)||!Utils.isNonNull(userVideoBean.list)||!Utils.isNonNull(userVideoBean.list.vlist)||(userVideoBean.list.vlist.length===0)) {
        userVideoBean = new UserVideoBean()//该数据可能为：undefined   投过图文而不是视频的userVideoBean以及userVideoBean中的list不为undefined，但vlist为null
      }
      // 主页的收藏和收藏页面中的数据
      let userBookmark:UserBookmark = value[3]//该数据可能为：null
      if (!Utils.isNonNull(userBookmark)||!Utils.isNonNull(userBookmark.list)) {
        userBookmark = new UserBookmark()
      }
      // 主页的追番和追番页面中的数据
      let userBangumi:UserBangumi = value[4]//该数据可能为：undefined
      if (!Utils.isNonNull(userBangumi)||!Utils.isNonNull(userBangumi.list)) {
        userBangumi = new UserBangumi()
      }
      // 主页的最近投币视频
      let userCoinVideos:UserCoinVideo[] = value[5]//该数据可能为：null
      if (!Utils.isNonNull(userCoinVideos)||userCoinVideos.length===0) {
        userCoinVideos = new Array<UserCoinVideo>()
      }
      // 主页的最近点赞视频
      let userUpvote:UserUpvote = value[6]//该数据可能为：null
      if (!Utils.isNonNull(userUpvote)||!Utils.isNonNull(userUpvote.list)) {
        userUpvote = new UserUpvote()
      }
      // 动态页面
      let userDynamic = value[7]
      // 收藏合集
      let userCollection = value[8]
      console.error('BiliUser  Page:video:'+userVideoBean+ '  Bangumi:'+userBangumi+ '  CoinVideos:'+userCoinVideos+ '  Upvote:'+userUpvote+ '  Bookmark:'+userBookmark)

      let arrays: [AccInfo, UserInfoBean, UserVideoBean, UserBookmark, UserBangumi, UserCoinVideo[], UserUpvote, UserDynamic, UserCollection]=[accInfo,userInfo,userVideoBean,userBookmark,userBangumi,userCoinVideos,userUpvote,userDynamic,userCollection]
      return arrays
    })
  }
  // 获取用户数据
  getUserAllSettledData(mid: number) {
    return Promise.allSettled([this.getUserAccInfo(mid),
    this.getLoginUserInfo(mid),
    this.getUserVideoData(mid),
    this.getUserBookmarksData(mid),
    this.getUserBangumiData(mid),
    this.getUserCoinData(mid),
    this.getUserLikeData(mid),
    this.getUserDynamicData(mid),
    this.getUserCollection(mid)])
  }
  // 获取用户空间详细信息
  getUserAccInfo(mid: number): Promise<AccInfo> {
    return ApiBiliUser.getUserAccInfo(mid)
  }

  // 获取用户
  getLoginUserInfo(mid: number) {
    return ApiBiliUser.loginUserInfo(mid)
  }

  // 获取主页数据
  async getUserHomeData(mid: number) {
    return await Promise.all([
    this.getUserVideoData(mid),
    this.getUserBookmarksData(mid),
    this.getUserBangumiData(mid),
    this.getUserCoinData(mid),
    this.getUserLikeData(mid),
    this.getUserDynamicData(mid),
    this.getUserCollection(mid)
    ])
  }

  // 获取动态数据
  getUserDynamicData(mid: number): Promise<UserDynamic> {
    return ApiBiliUser.getBiliUserDynamic<UserDynamic>(mid)
  }

  // 获取投稿数据
  getUserVideoData(mid: number, order: 'pubdate' | 'click' | 'stow' = 'pubdate', pn: number = 1): Promise<UserVideoBean> {
    return ApiBiliUser.getBiliUserVideo<UserVideoBean>(mid, order, pn)
  }

  // 获取追番数据
  getUserBangumiData(mid: number, pn: number = 1, ps: number = 10, type: 1 | 2 = 1): Promise<UserBangumi> {
    return ApiBiliUser.getBiliUserBangumi<UserBangumi>(mid, pn, ps, type)
  }

  // 获取追番数据
  getUserBookmarksData(mid: number, pn: number = 1, ps: number = 10): Promise<UserBookmark> {
    return ApiBiliUser.getBiliUserBookmarks<UserBookmark>(mid, pn, ps)
  }

  // 获取投币数据
  getUserCoinData(mid: number): Promise<UserCoinVideo[]> {
    return ApiBiliUser.getBiliUserCoin<UserCoinVideo[]>(mid)
  }

  // 获取点赞视频数据
  getUserLikeData(mid: number): Promise<UserUpvote> {
    return ApiBiliUser.getBiliUserUpvote<UserUpvote>(mid)
  }

  getUserCollection(mid: number, pn: number = 1, ps: number = 10): Promise<UserCollection> {
    return ApiBiliUser.getBiliUserCollection<UserCollection>(mid, ps, ps)
  }


  changePage(index:number){
    this.controller?.changeIndex(index)
  }
}