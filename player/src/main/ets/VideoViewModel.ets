import { DisplayInfo } from './common/DisplayInfo'
import { IjkPlayer } from './common/IjkPlayer'
import { Orientation } from './common/Orientation'
import { PlayStatus } from './common/PlayStatus'
import { IPlayer } from './IPlayer'
import { VideoModel } from './VideoModel'
import promptAction from '@ohos.promptAction'


//VideoPlayer 的 逻辑功能类
export class VideoViewModel implements IPlayer{
  viewModel:VideoModel = new VideoModel()
  context:object

  constructor(viewModel?:VideoModel){
    this.viewModel = viewModel
  }

  init(context?:object) {
    // 初始化Player,包括播放
    IjkPlayer.getInstance()
      .initPlayer(this.context, this.viewModel.ijkConfig, this.viewModel.mOnVideoSizeChangedListener, this.viewModel.mOnPreparedListener, this.viewModel.mOnCompletionListener, this.viewModel.mOnBufferingUpdateListener,
        this.viewModel.mOnSeekCompleteListener, this.viewModel.mOnInfoListener, this.viewModel.mOnErrorListener)
  }

  play() {
    this.viewModel.state = this.viewModel.state === PlayStatus.PLAY ? PlayStatus.PAUSE : PlayStatus.PLAY
    switch (this.viewModel.state) {
      case PlayStatus.PAUSE: {
        this.pause()
        break
      }
      case PlayStatus.PLAY: {
        IjkPlayer.getInstance().start()
        break
      }
    }
  }

  pause() {
    IjkPlayer.getInstance().pause()
  }

  moveProgress(progress: number) {
    let seekValue = progress * (IjkPlayer.getInstance().getDuration() / 100);

    IjkPlayer.getInstance().seekTo(Math.floor(seekValue).toString())

    this.viewModel.currentTime= this.Duration(Math.floor(seekValue / 1000))
  }

  getCurrentTime():string{
    return this.viewModel.currentTime
  }

  adjustVolume(volume: number) {
    let tempVolume = volume
    if (tempVolume>100) {
      tempVolume = 100
    }
    else if (volume<0) {
      tempVolume = 0
    }
    this.viewModel.volume = tempVolume
    // IjkPlayer.getInstance().setVolume()
  }

  adjustBrightness(brightness: number) {
    let tempBrightness = brightness
    if (tempBrightness>100) {
      tempBrightness = 100
    }
    else if (brightness<0) {
      tempBrightness = 0
    }
    this.viewModel.brightness = tempBrightness
    // IjkPlayer.getInstance().set()
  }

  stop() {
    IjkPlayer.getInstance().stop()
  }

  destroy() {
    IjkPlayer.getInstance().release()
  }

  reset() {
    IjkPlayer.getInstance().reset()
  }
  setUrl(url:string) {
   this.viewModel.url = url
  }
  getVideoAspectRatio():number{
  return 4/3
}

  getOrientation(): Orientation {
    throw new Error('Method not implemented.')
  }

  setOrientation(orientation: Orientation) {
    throw new Error('Method not implemented.')
  }

  setDisplayInfo(display: DisplayInfo) {
    throw new Error('Method not implemented.')
  }

  getDisplayInfo(): DisplayInfo {
    throw new Error('Method not implemented.')
  }


  upDateViewModel(viewModel:VideoModel){
    this.viewModel = viewModel
  }

  getPlayStateImg():Resource{
    let res = this.viewModel.state === PlayStatus.PLAY ? $r('app.media.ic_detail_video_pause') : $r('app.media.ic_detail_video_play')
    return res
  }

  getTimeContent():string{
    // return IjkPlayer.getInstance().getDuration()
    return '0:0'
  }

  // startProgressTask() {
  //   this.updateProgressTimer = setInterval(() => {
  //     if (IjkPlayer.getInstance().isPlaying()) {
  //       let duration = IjkPlayer.getInstance().getDuration()
  //       let current = IjkPlayer.getInstance().getCurrentPosition()
  //       if (duration>0) {
  //         this.sliderStep = current/duration *100;
  //       }
  //       this.currentTime = this.Duration(Math.floor(current/1000))
  //     }
  //   }, 300);
  // }
  //
  // stopProgressTask() {
  //   clearInterval(this.updateProgressTimer);
  // }



  initListener() {
    //设置获取视频宽高回调监听
    this.viewModel.mOnVideoSizeChangedListener = {
      onVideoSizeChanged: (width: number, height: number, sar_num: number, sar_den: number) => {
        promptAction.showToast({ message: width + "---" + height })
        this.viewModel.videoAspectRatio = width / height
      }
    }
    //设置视频准备就绪回调监听
    this.viewModel.mOnPreparedListener = {
      onPrepared: () => {
        this.viewModel.state = PlayStatus.PLAY
        // this.startProgressTask.bind(this)()
        // promptAction.showToast({
        //   message: IjkPlayer.getInstance().getVideoWidth() + "--**--" + IjkPlayer.getInstance()
        //     .getVideoHeight()
        // })
      }
    }
    //设置字幕回调监听
    this.viewModel.mOnTimedTextListener = {
      onTimedText: () => {
      }
    }
    //设置播放完成回调监听
    this.viewModel.mOnCompletionListener = {
      onCompletion: () => {
        this.viewModel.state = PlayStatus.STOP
        promptAction.showToast({
          message: "播完了"
        })
      }
    }
    //设置buffer缓冲回调监听
    this.viewModel.mOnBufferingUpdateListener = {
      onBufferingUpdate: (percent: number) => {
      }
    }
    //	设置快进后退回调监听
    this.viewModel.mOnSeekCompleteListener = {
      onSeekComplete: () => {
      }
    }

    //设置播放器的各种状态回调监听
    this.viewModel.mOnInfoListener = {
      onInfo: (what: number, extra: number) => {

      }
    }
    //	设置播放异常回调监听
    this.viewModel.mOnErrorListener = {
      onError: (what: number, extra: number) => {
        this.viewModel.state = PlayStatus.STOP
        promptAction.showToast({
          message: `亲，bilibili error ：${what}`
        });
      }
    }
  }

  // 视频时常，转换处理
  Duration(duration: number): string {
    let second: number | string = (duration % 60)
    let minute: number | string = Math.floor(duration / 60)
    if (second < 10) {
      second = '0' + second.toFixed(0)
    }else{
      second.toFixed(0)
    }

    //console.log("duration:"+duration+"---"+minute+'---'+second)
    return duration > 3600 ? Math.floor(duration / 3600) + ":" + minute + ":" + second : minute + ":" + second
  }
}