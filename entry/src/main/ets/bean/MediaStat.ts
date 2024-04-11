export class MediaStat {
  //{"coins":387261,"danmakus":676751,"favorite":39425,"favorites":2153787,"follow_text":"215.4万追番","likes":358434,"reply":89390,"share":46214,"views":33292684,"vt":0}

  // 番剧和影视的，不知道为什么比人多个s
  likes: number
  coins: number
  views: number
  danmakus: number

  favorite: number
  favorites: number // 追剧人数
  follow_text: string //"215.4万追番"
  share: number
  reply: number
  vt: number
}