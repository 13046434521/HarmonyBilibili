import { UserBangumi } from '../../bean/biliUser/UserBangumi'
import { UserBookmark } from '../../bean/biliUser/UserBookmark'
import { UserCoinVideo } from '../../bean/biliUser/UserCoinVideo'
import { UserCollection } from '../../bean/biliUser/UserCollection'
import { UserDynamic } from '../../bean/biliUser/UserDynamic'
import { UserUpvote } from '../../bean/biliUser/UserUpvote'
import { UserVideoBean } from '../../bean/biliUser/UserVideoBean'
import ApiBiliUser from '../../net/ApiBiliUser'

export class BiliUserViewModel {
  controller:TabsController

  constructor(controller:TabsController) {
    this.controller = controller
  }

  // 获取用户数据
  async getUserAllData(mid: number) {
    return await Promise.all([this.getUserAccInfo(mid),
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
  async getUserAccInfo(mid: number) {
    return await ApiBiliUser.getUserAccInfo(mid)
  }

  // 获取用户
  async getLoginUserInfo(mid: number) {
    return await ApiBiliUser.loginUserInfo(mid)
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
  async getUserDynamicData(mid: number) {
    return await ApiBiliUser.getBiliUserDynamic<UserDynamic>(mid)
  }

  // 获取投稿数据
  async getUserVideoData(mid: number, order: 'pubdate' | 'click' | 'stow' = 'pubdate', pn: number = 1) {
    return await ApiBiliUser.getBiliUserVideo<UserVideoBean>(mid, order, pn)
  }

  // 获取追番数据
  async getUserBangumiData(mid: number, pn: number = 1, ps: number = 10, type: 1 | 2 = 1) {
    return await ApiBiliUser.getBiliUserBangumi<UserBangumi>(mid, pn, ps, type)
  }

  // 获取追番数据
  async getUserBookmarksData(mid: number, pn: number = 1, ps: number = 10) {
    return await ApiBiliUser.getBiliUserBookmarks<UserBookmark>(mid, pn, ps)
  }

  // 获取投币数据
  async getUserCoinData(mid: number) {
    return await ApiBiliUser.getBiliUserCoin<UserCoinVideo[]>(mid)
  }

  // 获取点赞视频数据
  async getUserLikeData(mid: number) {
    return await ApiBiliUser.getBiliUserUpvote<UserUpvote>(mid)
  }

  async getUserCollection(mid: number, pn: number = 1, ps: number = 10) {
    return await ApiBiliUser.getBiliUserCollection<UserCollection>(mid, ps, ps)
  }


  changePage(index:number){
    this.controller.changeIndex(index)
  }
}