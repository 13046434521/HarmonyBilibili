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
import { IjkPlayerConfig } from './common/IjkPlayer'
import { PlayStatus } from './common/PlayStatus'

export class VideoModel {
  url: string = ""
  bvid: string
  cid: number
  ijkConfig: IjkPlayerConfig = new IjkPlayerConfig()
  videoAspectRatio: number = 16 / 9
  state: PlayStatus = PlayStatus.INIT
  volume:number=0
  brightness:number=0
  sliderStep: number = 0
  timeTotal: string = '00:00'
  currentTime: string = '00:00'
  xcomponentController: XComponentController = new XComponentController()
  // ¸÷ÖÖListener
  mOnVideoSizeChangedListener: OnVideoSizeChangedListener = null
  mOnPreparedListener: OnPreparedListener = null
  mOnTimedTextListener: OnTimedTextListener = null
  mOnCompletionListener: OnCompletionListener = null
  mOnBufferingUpdateListener: OnBufferingUpdateListener = null
  mOnSeekCompleteListener: OnSeekCompleteListener = null
  mOnInfoListener: OnInfoListener = null
  mOnErrorListener: OnErrorListener = null
  updateProgressTimer: number = 0
}