import WebConstants from '../common/WebConstants'

export class MineViewModel {
  private recommendData: Array<MineItem> = []
  private createCenterData: Array<MineItem> = []
  getCreateCenter() :Array<MineItem>{
    this.createCenterData.push(new MineItem('创作中心', $r('app.media.ic_mine_live_center')))
    this.createCenterData.push(new MineItem('稿件管理', $r('app.media.ic_mine_live_center')))

    this.createCenterData.push(new MineItem('创作激励', $r('app.media.ic_mine_live_center'),WebConstants.getCreateExcitation()))
    this.createCenterData.push(new MineItem('有奖活动', $r('app.media.ic_mine_live_center'),WebConstants.getHotActivity()))
    this.createCenterData.push(new MineItem('开播福利', $r('app.media.ic_mine_live_center'),WebConstants.getLiveAnchor()))
    this.createCenterData.push(new MineItem('主播中心', $r('app.media.ic_mine_live_center'),WebConstants.getLiveCenter()))
    this.createCenterData.push(new MineItem('直播数据', $r('app.media.ic_mine_live_center'),WebConstants.getLiveData()))
    this.createCenterData.push(new MineItem('主播活动', $r('app.media.ic_mine_live_center'),WebConstants.getLiveActivity()))
    return this.createCenterData
  }
  getRecommendData() :Array<MineItem>{
    this.recommendData.push(new MineItem('我的课程', $r('app.media.ic_mine_live_center'),WebConstants.getMyClass()))
    this.recommendData.push(new MineItem('免流量服务', $r('app.media.ic_mine_freedata'),WebConstants.getFlowFree()))
    this.recommendData.push(new MineItem('个性装扮', $r('app.media.ic_mine_live_center'),WebConstants.getPersonality()))
    this.recommendData.push(new MineItem('我的钱包', $r('app.media.ic_mine_live_center'),WebConstants.getMyWallet()))
    this.recommendData.push(new MineItem('游戏中心', $r('app.media.ic_mine_live_center')))
    this.recommendData.push(new MineItem('会员购物中心', $r('app.media.ic_mine_mall')))
    this.recommendData.push(new MineItem('我的直播', $r('app.media.ic_mine_live_center'),WebConstants.getMyLive()))

    this.recommendData.push(new MineItem('漫画', $r('app.media.ic_mine_live_center'),WebConstants.getMangaRecommend()))
    this.recommendData.push(new MineItem('必火推广', $r('app.media.ic_mine_freedata'),WebConstants.getHotPromotion()))
    this.recommendData.push(new MineItem('社区中心', $r('app.media.ic_mine_live_center')))
    this.recommendData.push(new MineItem('哔哩哔哩公益', $r('app.media.ic_mine_live_center'),WebConstants.getPublicLove()))
    this.recommendData.push(new MineItem('工房', $r('app.media.ic_mine_live_center')))
    this.recommendData.push(new MineItem('能量加油站', $r('app.media.ic_mine_mall'),WebConstants.getFighting()))
    this.recommendData.push(new MineItem('哔哩日报', $r('app.media.ic_mine_live_center'),WebConstants.getNewsPaper()))

    return this.recommendData
  }
}


export class MineItem {
  name: string
  img: Resource
  url:string

  constructor(name: string, img: Resource,url?:string) {
    this.name = name
    this.img = img
    this.url = url
  }
}