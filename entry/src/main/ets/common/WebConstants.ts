class WebConstants {
  // 关注|粉丝
  getFollow(mid: number, type: 'fans' | 'follow') {
    return `https://space.bilibili.com/h5/follow?newfans=0&mid=${mid}&type=${type}&native.theme=1`
  }
  /*------------------------------------------- 创作中心 --------------------------------------------*/
  // 创作激励
  getCreateExcitation() {
    return 'https://member.bilibili.com/york/excitation/h5?navhide=1&from=mine&native.theme=1'
  }

  // 有奖活动
  getHotActivity() {
    return 'https://member.bilibili.com/york/hot-activity?native.theme=1'
  }

  // 开播福利
  getLiveAnchor() {
    return 'https://live.bilibili.com/p/html/live-anchor-galaxy/task_center/?week_live_btn=1&source_event=16&is_live_full_webview=1&foreground=pink&background=white'
  }

  // 主播中心
  getLiveCenter() {
    return 'https://live.bilibili.com/p/html/live-app-anchor-center/index.html?is_live_webview=1&foreground=pink&background=white'
  }

  // 直播数据
  getLiveData() {
    return 'https://live.bilibili.com/p/html/live-app-data/index.html?source_tag=0&is_live_webview=1&hybrid_set_header=2&foreground=pink&background=white'
  }
  // 主播活动
  getLiveActivity() {
    return 'https://live.bilibili.com/activity/live-activity-full/activity_center/mobile.html?is_live_webview=1&foreground=pink&background=white'
  }
  /*------------------------------------------- 推荐服务 --------------------------------------------*/
  //我的课程
  getMyClass() {
    return 'https://m.bilibili.com/cheese/mine?spm_id_from=main.my-information.0.0.pv&navhide=1&csource=Me_myclass&native.theme=1'
  }

  // 免流量服务
  getFlowFree() {
    return 'https://www.bilibili.com/blackboard/activity-new-freedata.html?native.theme=1'
  }

  // 个性装扮
  getPersonality() {
    return 'https://www.bilibili.com/h5/mall/home?navhide=1&from=myservice&f_source=shop&native.theme=1'
  }

  // 我的钱包
  getMyWallet() {
    return 'https://pay.bilibili.com/pay-v2/payHome'
  }
  //我的直播
  getMyLive(){
    return 'https://live.bilibili.com/p/html/live-app-center/index.html?is_live_webview=1&hybrid_need_theme=1&source_event=0&foreground=pink&background=white'
  }
  //我的漫画推荐
  getMangaRecommend() {
    return 'https://manga.bilibili.com/m?blrouter.pagename=activity%3A%2F%2Fcomic%2Fhome&index=1&blrouter.targeturl=bilibili%3A%2F%2Fcomic%2Fhome&blrouter.matchrule=bili'
  }

  // 漫画分类
  getMangaType() {
    return 'https://manga.bilibili.com/m/classify?blrouter.pagename=activity%3A%2F%2Fcomic%2Fhome&index=1&blrouter.targeturl=bilibili%3A%2F%2Fcomic%2Fhome&blrou'
  }

  // 漫画排行
  getMangaRanking() {
    return 'https://manga.bilibili.com/ranking'
  }

  // 必火推广
  getHotPromotion() {
    return ' https://cm.bilibili.com/fly-h5/?navhide=1&native.theme=1#/fly/middle?from=tuijian'
  }
  // 公益
  getPublicLove() {
    return ' https://love.bilibili.com/h5?navhide=1&native.theme=1'
  }
  // 能量加油站
  getFighting() {
    return 'https://www.bilibili.com/blackboard/era/3ERAmwloghvazr00.html?native.theme=1'
  }

  // bili日报
  getNewsPaper() {
    return 'https://www.bilibili.com/blackboard/activity-HW2u5b44Dm.html?msource=tuijianfuwu&native.theme=1'
  }

  // 联系客服
  getCustomerService() {
    return 'https://www.bilibili.com/h5/customer-service?native.theme=1'
  }
  // 大会员中心
  getBigVip(){
    return 'https://big.bilibili.com/mobile/vip/index.html?navhide=1&navhide=1&from_spmid=minetab&source_from=vip.my-page.vip.entrance.click&exp_symbol=new_cente'
  }
  // Vip会员试炼
  getVipTry(){
    return 'https://www.bilibili.com/h5/senior-newbie?navhide=1&from=mine&native.theme=1'
  }
}

const constants: WebConstants = new WebConstants()

export default constants as WebConstants