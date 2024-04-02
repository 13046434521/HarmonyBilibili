/*
  data:{
        card:{
            mid:68406011
            name:可乐儿加冰
            approve:false
            sex:男
            rank:10000
            face:https://i2.hdslb.com/bfs/face/e0ce1d97b44643430a7648d79abdf4efc11ba236.jpg
            face_nft:0
            face_nft_type:0
            DisplayRank:0
            regtime:0
            spacesta:0
            birthday:
            place:
            description:
            article:0
            attentions:[

            ]
            fans:14
            friend:275
            attention:275
            sign:我是个坚定的唯物主义者，唯有与你，我希望有来生
            level_info:{
                current_level:6
                current_min:0
                current_exp:0
                next_exp:0
            }
            pendant:{
                pid:0
                name:
                image:
                expire:0
                image_enhance:
                image_enhance_frame:
                n_pid:0
            }
            nameplate:{
                nid:0
                name:
                image:
                image_small:
                level:
                condition:
            }
            Official:{
                role:0
                title:
                desc:
                type:-1
            }
            official_verify:{
                type:-1
                desc:
            }
            vip:{
                type:2
                status:1
                due_date:1717603200000
                vip_pay_type:1
                theme_type:0
                label:{
                    path:
                    text:年度大会员
                    label_theme:annual_vip
                    text_color:#FFFFFF
                    bg_style:1
                    bg_color:#FB7299
                    border_color:
                    use_img_label:true
                    img_label_uri_hans:
                    img_label_uri_hant:
                    img_label_uri_hans_static:https://i0.hdslb.com/bfs/vip/8d4f8bfc713826a5412a0a27eaaac4d6b9ede1d9.png
                    img_label_uri_hant_static:https://i0.hdslb.com/bfs/activity-plat/static/20220614/e369244d0b14644f5e1a06431e22a4d5/VEW8fCC0hg.png
                }
                avatar_subscript:1
                nickname_color:#FB7299
                role:3
                avatar_subscript_url:
                tv_vip_status:0
                tv_vip_pay_type:0
                tv_due_date:0
                avatar_icon:{
                    icon_type:1
                    icon_resource:{

                    }
                }
                vipType:2
                vipStatus:1
            }
            is_senior_member:0
        }
        following:false
        archive_count:16
        article_count:0
        follower:14
        like_num:100
    }*/
//https://api.bilibili.com/x/web-interface/card?mid=68406011

export class UserInfoBean {
  card: UserCardBean
  following: boolean
  archive_count: number
  article_count: number
  follower: number
  like_num: number
}

export class UserCardBean {
  /*
    mid:68406011
      name:可乐儿加冰
      approve:false
      sex:男
      rank:10000
      face:https://i2.hdslb.com/bfs/face/e0ce1d97b44643430a7648d79abdf4efc11ba236.jpg
      face_nft:0
      face_nft_type:0
      DisplayRank:0
      regtime:0
      spacesta:0
      birthday:
        place:
      description:
        article:0
      attentions:[

      ]
      fans:14
      friend:275
      attention:275
      sign:我是个坚定的唯物主义者，唯有与你，我希望有来生
      level_info:{
        current_level:6
        current_min:0
        current_exp:0
        next_exp:0
      }
      pendant:{
        pid:0
        name:
          image:
        expire:0
        image_enhance:
          image_enhance_frame:
        n_pid:0
      }
      nameplate:{
        nid:0
        name:
          image:
        image_small:
          level:
        condition:
      }
      Official:{
        role:0
        title:
          desc:
        type:-1
      }
      official_verify:{
        type:-1
        desc:
      }
      vip:{
        type:2
        status:1
        due_date:1717603200000
        vip_pay_type:1
        theme_type:0
        label:{
          path:
            text:年度大会员
          label_theme:annual_vip
          text_color:#FFFFFF
          bg_style:1
          bg_color:#FB7299
          border_color:
            use_img_label:true
          img_label_uri_hans:
            img_label_uri_hant:
          img_label_uri_hans_static:https://i0.hdslb.com/bfs/vip/8d4f8bfc713826a5412a0a27eaaac4d6b9ede1d9.png
          img_label_uri_hant_static:https://i0.hdslb.com/bfs/activity-plat/static/20220614/e369244d0b14644f5e1a06431e22a4d5/VEW8fCC0hg.png
        }
        avatar_subscript:1
        nickname_color:#FB7299
        role:3
        avatar_subscript_url:
          tv_vip_status:0
        tv_vip_pay_type:0
        tv_due_date:0
        avatar_icon:{
          icon_type:1
          icon_resource:{

          }
        }
        vipType:2
        vipStatus:1
      }
      is_senior_member:0*/
  mid: number
  name: string
  approve: false
  sex: string
  rank: number
  face: string
  face_nft: number
  face_nft_type: number
  DisplayRank: number
  regtime: number
  spacesta: number
  birthday: string
  place: string
  description: string
  article: number
  attentions: []
  fans: number
  friend: number
  attention: number
  sign: string
  level_info: {
    current_level: number
    current_min: number
    current_exp: number
    next_exp: number
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
  nameplate: {
    nid: number
    name: string
    image: string
    image_small: string
    level: string
    condition: string
  }
  Official: {
    role: number
    title: string
    desc: string
    type: number
  }
  official_verify: {
    type: number
    desc: string
  }
  vip: {
    type: number
    status: number
    due_date: number
    vip_pay_type: number
    theme_type: number
    label: {
      path: string
      text: string
      label_theme: string
      text_color: string
      bg_style: number
      bg_color: string
      border_color: string
      use_img_label: boolean
      img_label_uri_hans: string
      img_label_uri_hant: string
      img_label_uri_hans_static: string
      img_label_uri_hant_static: string
    }
    avatar_subscript: number
    nickname_color: string
    role: number
    avatar_subscript_url: string
    tv_vip_status: number
    tv_vip_pay_type: number
    tv_due_date: number
    avatar_icon: {
      icon_type: number
      icon_resource: {
        type: number
        url: string
      }
    }
    vipType: number
    vipStatus: number
  }
  is_senior_member: number
}
