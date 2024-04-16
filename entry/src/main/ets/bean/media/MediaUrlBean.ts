// https://api.bilibili.com/pgc/player/web/playurl?avid=1900434537&cid=1432159459&ep_id=814315
export class MediaUrlBean {
  accept_format: string
  code: number
  seek_param: string
  is_preview: number
  fnval: number
  video_project: boolean
  fnver: number
  type: string
  bp: number
  result: string
  seek_type: string
  from: string
  video_codecid: number
  durl: MediaDurlBean[]
  is_drm: boolean
  no_rexcode: number
  format: string
  support_formats: MediaSupportFormatsBean[]=[]
  message: string

  accept_quality: number[] // 64 16
  quality: number //16
  timelength: number // 66304
  durls: []
  has_paid: boolean
  clip_info_list: []
  accept_description: string[] //高清 720P,流畅 360P
  status: number
}
// 播放地址
export class MediaDurlBean {
  size: number
  ahead: string
  length: number
  vhead: string
  backup_url: string[]
  url: string
  order: number
  md5: string
}
// 分辨率类
export class MediaSupportFormatsBean {
  // display_desc: 720P
  // sub_description:
  // superscript:
  // need_login: true
  // codecs: []
  // format: mp4720
  // description: 高清 720P
  // quality: 64
  // new_description: 720P 高清

  display_desc: string
  sub_description: string
  superscript: string
  need_login: boolean
  codecs: []
  format: string
  description: string
  quality: number
  new_description: string
}
