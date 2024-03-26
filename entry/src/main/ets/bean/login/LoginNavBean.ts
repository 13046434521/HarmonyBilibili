/*
 *                isLogin: true
    email_verified: 1
    face: https://i2.hdslb.com/bfs/face/e0ce1d97b44643430a7648d79abdf4efc11ba236.jpg
    face_nft: 0
    face_nft_type: 0
    level_info: {
      current_level: 6
      current_min: 28800
      current_exp: 37813
      next_exp: --
    }
    mid: 68406011
    mobile_verified: 1
    money: 442.6
    moral: 70
    official: {
      role: 0
      title:
      desc:
      type: -1
    }
    officialVerify: {
      type: -1
      desc:
    }
    pendant: {
      pid: 0
      name:
      image:
      expire: 0
      image_enhance:
      image_enhance_frame:
      n_pid: 0
    }
    scores: 0
    uname: 可乐儿加冰
    vipDueDate: 1717603200000
    vipStatus: 1
    vipType: 2
    vip_pay_type: 1
    vip_theme_type: 0
    vip_label: {
      path:
      text: 年度大会员
      label_theme: annual_vip
      text_color: #FFFFFF
      bg_style: 1
      bg_color: #FB7299
      border_color:
      use_img_label: true
      img_label_uri_hans:
      img_label_uri_hant:
      img_label_uri_hans_static: https://i0.hdslb.com/bfs/vip/8d4f8bfc713826a5412a0a27eaaac4d6b9ede1d9.png
      img_label_uri_hant_static: https://i0.hdslb.com/bfs/activity-plat/static/20220614/e369244d0b14644f5e1a06431e22a4d5/VEW8fCC0hg.png
    }
    vip_avatar_subscript: 1
    vip_nickname_color: #FB7299
    vip: {
      type: 2
      status: 1
      due_date: 1717603200000
      vip_pay_type: 1
      theme_type: 0
      label: {
        path:
        text: 年度大会员
        label_theme: annual_vip
        text_color: #FFFFFF
        bg_style: 1
        bg_color: #FB7299
        border_color:
        use_img_label: true
        img_label_uri_hans:
        img_label_uri_hant:
        img_label_uri_hans_static: https://i0.hdslb.com/bfs/vip/8d4f8bfc713826a5412a0a27eaaac4d6b9ede1d9.png
        img_label_uri_hant_static: https://i0.hdslb.com/bfs/activity-plat/static/20220614/e369244d0b14644f5e1a06431e22a4d5/VEW8fCC0hg.png
      }
      avatar_subscript: 1
      nickname_color: #FB7299
      role: 3
      avatar_subscript_url:
      tv_vip_status: 0
      tv_vip_pay_type: 0
      tv_due_date: 0
      avatar_icon: {
        icon_type: 1
        icon_resource: {

        }
      }
    }
    wallet: {
      mid: 68406011
      bcoin_balance: 0
      coupon_balance: 0
      coupon_due_time: 0
    }
    has_shop: false
    shop_url:
    allowance_count: 0
    answer_status: 0
    is_senior_member: 0
    wbi_img: {
      img_url: https://i0.hdslb.com/bfs/wbi/7cd084941338484aae1ad9425b84077c.png
      sub_url: https://i0.hdslb.com/bfs/wbi/4932caff0ff746eab6f01bf08b70ac45.png
    }
    is_jury: false
 * */
// https://api.bilibili.com/x/web-interface/nav
// 可以通过cookie获取当前登录状态
export interface LoginNavBean {
  isLogin: boolean
  email_verified: number
  face: string
  face_nft: number
  face_nft_type: number
  level_info: {
    current_level: number //6
    current_min: number //28800
    current_exp: number //37813
    next_exp: string
  }
  mid: number
  mobile_verified: number
  money: number //442.6
  moral: number //70
  official: {
    role: number
    title: string
    desc: string
    type: number
  }
  officialVerify: {
    type: number
    desc: string
  }
  pendant: {
    pid: number
    name: string
    image: string
    expire: number
    image_enhance: string
    image_enhance_frame: string
    n_pid: number
  }
  scores: number
  uname: string
  vipDueDate: number
  vipStatus: number
  vipType: number
  vip_pay_type: number
  vip_theme_type: number
  vip_label: {
    path: string
    text: string //年度大会员
    label_theme: string
    text_color: string //#FFFFFF
    bg_style: number
    bg_color: string // #FB7299
    border_color: string
    use_img_label: true
    img_label_uri_hans: string
    img_label_uri_hant: string
    img_label_uri_hans_static: string //https://i0.hdslb.com/bfs/vip/8d4f8bfc713826a5412a0a27eaaac4d6b9ede1d9.png
    img_label_uri_hant_static: string //https://i0.hdslb.com/bfs/activity-plat/static/20220614/e369244d0b14644f5e1a06431e22a4d5/VEW8fCC0hg.png
  }
  vip_avatar_subscript: number
  vip_nickname_color: string //#FB7299
  vip: {
    type: number
    status: number
    due_date: number
    vip_pay_type: number
    theme_type: number
    label: {
      path: string
      text: string //年度大会员
      label_theme: string //annual_vip
      text_color: string //#FFFFFF
      bg_style: number
      bg_color: string //#FB7299
      border_color: string
      use_img_label: true
      img_label_uri_hans: string
      img_label_uri_hant: string
      img_label_uri_hans_static: string // https://i0.hdslb.com/bfs/vip/8d4f8bfc713826a5412a0a27eaaac4d6b9ede1d9.png
      img_label_uri_hant_static: string // https://i0.hdslb.com/bfs/activity-plat/static/20220614/e369244d0b14644f5e1a06431e22a4d5/VEW8fCC0hg.png
    }
    avatar_subscript: number
    nickname_color: string // #FB7299
    role: number
    avatar_subscript_url: string
    tv_vip_status: number
    tv_vip_pay_type: number
    tv_due_date: number
    avatar_icon: {
      icon_type: number
      icon_resource: {}
    }
  }
  wallet: {
    mid: number
    bcoin_balance: number
    coupon_balance: number
    coupon_due_time: number
  }
  has_shop: false
  shop_url: string
  allowance_count: number
  answer_status: number
  is_senior_member: number
  wbi_img: {
    img_url: string //https://i0.hdslb.com/bfs/wbi/7cd084941338484aae1ad9425b84077c.png
    sub_url: string // https://i0.hdslb.com/bfs/wbi/4932caff0ff746eab6f01bf08b70ac45.png
  }
  is_jury: false
}