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
import { PlayStatus } from '../common/PlayStatus'
import window from '@ohos.window'

@Observed
export default  class VideoModel {
  url: string = ""
  headers :Map<string,string> =  new Map<string,string>([
    ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
    ["Referer", "https://www.bilibili.com"]
  ])
  bvid: string
  cid: number
  videoAspectRatio: number = 16 / 9
  state: PlayStatus = PlayStatus.INIT
  volume:number=0
  brightness:number=0
  sliderStep: number = 0
  videoWidth:number=0
  videoHeight: number = 0
  timeTotal: string = '00:00'
  currentTime: string = '00:00'
  context:object =null
  // 各种Listener
  mOnVideoSizeChangedListener: OnVideoSizeChangedListener = null
  mOnPreparedListener: OnPreparedListener = null
  mOnTimedTextListener: OnTimedTextListener = null
  mOnCompletionListener: OnCompletionListener = null
  mOnBufferingUpdateListener: OnBufferingUpdateListener = null
  mOnSeekCompleteListener: OnSeekCompleteListener = null
  mOnInfoListener: OnInfoListener = null
  mOnErrorListener: OnErrorListener = null
  updateProgressTimer: number = 0
  orientation:window.Orientation = null
}