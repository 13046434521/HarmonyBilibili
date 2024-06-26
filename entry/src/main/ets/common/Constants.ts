import StorageManager from './StorageManager'

class Constants{
  WINDOW_HEIGHT = -1
  WINDOW_WIDTH = -1
  WINDOW_ASPECT_RATIO_PORTRAIT = 16/9 //竖屏时，比例就是16:9
  WINDOW_ASPECT_RATIO_LANDSCAPE = 1  // 横屏时，比例改为 屏幕的宽高比
  CACHE_COUNT = 4
  // QN:number = 64
  QN:number = 116
  // SEARCH_COOKIE:string = `buvid3=F990C62D-8570-E810-1D2A-42B652D1376F29722infoc; b_nut=1699589929; i-wanna-go-back=-1; b_ut=7; _uuid=C23E3C8B-4A3F-3BEC-4FEE-6C7692E8178330018infoc; enable_web_push=DISABLE; buvid4=A26F40F9-7FBF-43AA-5BD9-80F4924FCBFD30208-023111012-KxfNF8XJX%2FbkT0eszmLSXw%3D%3D; rpdid=|(k|kmJluuJR0J'uYmml)mmJk; header_theme_version=CLOSE; is-2022-channel=1; buvid_fp_plain=undefined; hit-dyn-v2=1; LIVE_BUVID=AUTO3317015948042453; CURRENT_BLACKGAP=0; bsource_origin=baidu_aladdin; share_source_origin=COPY; fingerprint=278b352fcb69f1c769fe12178cc9fe1b; bp_article_offset_68406011=906886996051361810; FEED_LIVE_VERSION=V8; DedeUserID=68406011; DedeUserID__ckMd5=ecb0ad5cd0bcd251; msource=pc_web; deviceFingerprint=e82561c17bd52ea232fc909eec721919; from=pc_ticketlist; SESSDATA=b5a9a074%2C1726294164%2C16d7f%2A31CjCXss8GY7aNGIKtOimj3G9m6A640D2piwkx5BCDD837iXUoi0QAwjH0EpKjMW3YmPMSVnByOFlNWTRLaVhHazEzZl9jRFpLT1VPeF91VE4zXzJPN0Jxc25OYjlXd2xkaTdfMmRSRF81aUV1Y2xmOXg1UmdEd0dpV0VpTEtPeVF2ZFZ4QUpscFhRIIEC; bili_jct=6244f8a93fa5fe719ac277f8d68466fe; sid=62exer73; CURRENT_FNVAL=4048; bsource=search_baidu; home_feed_column=5; buvid_fp=278b352fcb69f1c769fe12178cc9fe1b; browser_resolution=1920-911; CURRENT_QUALITY=112; bp_video_offset_68406011=912834709698904096; bili_ticket=eyJhbGciOiJIUzI1NiIsImtpZCI6InMwMyIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTE2MzUwMjcsImlhdCI6MTcxMTM3NTc2NywicGx0IjotMX0.dNehLiM-xvpYplWMax3tH6Nod0M_KXhT_xHu8FyFlW4; bili_ticket_expires=1711634967; PVID=3; b_lsid=FE15B1E6_18E76574295`
  // COOKIE:string = 'DedeUserID=68406011;DedeUserID__ckMd5=ecb0ad5cd0bcd251;Expires=1726995029;SESSDATA=3cd4e8a3,1726995029,2c018*31CjDoM1Zr4KPtkw7itX5UpWdKtyd_PclBy8Dew0oMYwOABq7vQwq_XMrcC3_ALgqsIVgSVnR6NTBXMTBCV0IxWmxCMEN4VV9EUkVrNGlnQ0cxczdTal9IQkFHZnhUVGU3R09HU09CQTRqdXU1QnZ6T3ZaUnUyUVRjMklXTnlFR3VCV2liZVVSVkNBIIEC;bili_jct=5a92cb28818fcbe9d658f0792cf28a7f;gourl=httpswww.bilibili.com'

  SEARCH_COOKIE="i-wanna-go-back=-1; buvid3=0C23069F-5200-3EAB-546E-3FB8CDF833EB74930infoc;"
  COOKIE = StorageManager.getCookie()
  // COOKIE:string = 'DedeUserID=68406011;DedeUserID__ckMd5=ecb0ad5cd0bcd251;Expires=1726995029;SESSDATA=3cd4e8a3%2C1726995029%2C2c018*31CjDoM1Zr4KPtkw7itX5UpWdKtyd_PclBy8Dew0oMYwOABq7vQwq_XMrcC3_ALgqsIVgSVnR6NTBXMTBCV0IxWmxCMEN4VV9EUkVrNGlnQ0cxczdTal9IQkFHZnhUVGU3R09HU09CQTRqdXU1QnZ6T3ZaUnUyUVRjMklXTnlFR3VCV2liZVVSVkNBIIEC;bili_jct=5a92cb28818fcbe9d658f0792cf28a7f;gourl=httpswww.bilibili.com'

  DEFAULT_ASPECT_RATIO = 16/9
  VIDEO_ASPECT_RATIO = 16/9
  SEARCH_FOCUS_ID = "search_focus" // SearchHeader准备获取焦距的
  COOKIE_NAME ='bilibili_cookie'

  BACKGROUND_NIGHT = '#17181A'
  BACKGROUND_DAY = '#FFFFFF'
  BACKGROUND_COLOR = '#17181A'
  BACKGROUND_HOME_COLOR = '#F2F3F5'
  /*------------------------------------------- AppStorage --------------------------------------------*/
  Login_Data:string = 'Bilibili_Login'
  Home_Data:string = 'Bilibili_Home'

  getCookie():string{
    return StorageManager.getCookie()
  }
  /*------------------------------------------- WEB --------------------------------------------*/
  PHONE_USER_AGENT='Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Mobile Safari/537.36'
}

const constants :Constants = new Constants()
export default constants as Constants