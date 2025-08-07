import {
  OnBufferingUpdateListener,
  OnCompletionListener,
  OnErrorListener,
  OnInfoListener,
  OnPreparedListener,
  OnSeekCompleteListener,
  OnTimedTextListener,
  OnVideoSizeChangedListener
} from '@ohos/ijkplayer'
import { PlayStatus } from '../../common/PlayStatus'
import window from '@ohos.window'
import Constants from '../../common/Constants'


@Observed
export default  class VideoModel {
  url: string = ""
  headers :Map<string,string> =  new Map<string,string>([
    ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
    ["Referer", "https://www.bilibili.com"]
  ])
  xComponentId = "XID_"+ new Date().valueOf()
  bvid: string = ""
  cid?: number
  isShowAttachments = true
  videoWidth:number=0 // 视频宽高
  videoHeight: number = 0// 视频宽高
  xComponentWidth :string|undefined= '100%' //xComponent的宽，根据VIDEO_ASPECT_RATIO的值来确定
  xComponentHeight:string|undefined = undefined //xComponent的高
  videoAspectRatio: number = Constants.VIDEO_ASPECT_RATIO
  defaultAspectRatio:number = Constants.DEFAULT_ASPECT_RATIO
  state: PlayStatus = PlayStatus.INIT
  volume:number=-100
  brightness:number=-100
  sliderStep: number = 0

  timeTotal: string = '0:00'
  currentTime: string = '0:00'
  context?:object 
  orientation:window.Orientation = window.Orientation.PORTRAIT
  // 各种Listener
  mOnVideoSizeChangedListener?: OnVideoSizeChangedListener
  mOnPreparedListener?: OnPreparedListener
  mOnTimedTextListener?: OnTimedTextListener
  mOnCompletionListener?: OnCompletionListener
  mOnBufferingUpdateListener?: OnBufferingUpdateListener
  mOnSeekCompleteListener?: OnSeekCompleteListener
  mOnInfoListener?: OnInfoListener
  mOnErrorListener?: OnErrorListener
  updateProgressTimer: number = 0
}