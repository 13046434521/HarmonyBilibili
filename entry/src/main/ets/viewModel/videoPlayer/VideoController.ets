
import { IPlayer } from './IPlayer'

import promptAction from '@ohos.promptAction'
import VideoModel from './VideoModel'
import { PlayStatus } from '../../common/PlayStatus'
import { IjkMediaPlayer } from '@ohos/ijkplayer'
import window from '@ohos.window'
import Constants from '../../common/Constants'
import audio from '@ohos.multimedia.audio'
import { Utils } from '../../Utils/Utils'
import { showDialog } from '../../Utils/DialogUtil'

//VideoPlayer 的 逻辑功能类
export class VideoController implements IPlayer {
  videoModel: VideoModel = new VideoModel()
  volumeManager = audio.getAudioManager().getVolumeManager();

  isShowAttachments = true

  init(context: object) {
    console.log('app_log:init:'+this.getXComponentId())
    this.videoModel.context = context
    // 初始化Player,包括播放
    this.initPlayer(context, this.videoModel.url, this.videoModel.headers)
  }

  play() {
    console.log('app_log:play:'+this.videoModel.xComponentId)
    if (this.videoModel.context!=null && this.videoModel.state<= PlayStatus.STOP) {
      IjkMediaPlayer.getInstance().start()
      this.videoModel.state = PlayStatus.PLAY
    }
  }

  pause() {
    console.log('app_log:stop:'+this.videoModel.xComponentId)
    if (this.videoModel.context!=null && this.videoModel.state<= PlayStatus.PLAY) {
       IjkMediaPlayer.getInstance().pause()
      this.videoModel.state = PlayStatus.PAUSE
    }
  }

  moveProgress(progress: number) {
    if (this.videoModel.context!=null ) {
      this.videoModel.state = PlayStatus.LOADING

      let seekValue = progress * ( IjkMediaPlayer.getInstance().getDuration() / 100);
       IjkMediaPlayer.getInstance().seekTo(Math.floor(seekValue).toString())
      this.videoModel.currentTime = Utils.Duration(Math.floor(seekValue / 1000))
    }
  }
  updateProgressTimer:number = 0

  private startProgressTask() {
    this.updateProgressTimer = setInterval(() => {
      if (this.videoModel.state === PlayStatus.PLAY && this.videoModel.context!=null&& IjkMediaPlayer.getInstance().isPlaying()) {
        let duration =  IjkMediaPlayer.getInstance().getDuration()
        let current =  IjkMediaPlayer.getInstance().getCurrentPosition()
        if (duration>0) {
          this.videoModel.sliderStep = current/duration *100;
        }
        this.videoModel.currentTime = Utils.Duration(Math.floor(current/1000))
      }
    }, 300);

    console.log('app_log startProgressTask:'+this.videoModel.xComponentId)
  }

  stop() {
    console.log('app_log:stop:'+this.videoModel.xComponentId)
    if (this.videoModel.context!=null && this.videoModel.state<=PlayStatus.STOP) {
       IjkMediaPlayer.getInstance().stop()
      this.videoModel.state =PlayStatus.STOP
    }
  }

  release(msg?:string) {
    console.log('app_log:release:'+msg)
    if (this.videoModel.context!=null && this.videoModel.state<PlayStatus.RELEASE) {
       IjkMediaPlayer.getInstance().release()
      this.videoModel.state = PlayStatus.RELEASE
      this.stopProgressTask()
    }
  }

  reset() {
    console.log('app_log:reset:'+this.videoModel.xComponentId)
    if (this.videoModel.context!=null) {
      this.videoModel.state = PlayStatus.INIT
       IjkMediaPlayer.getInstance().reset()
      this.init(this.videoModel.context)
      this.videoModel.currentTime = '00:00'
    }
  }

  getCurrentTime(): string {
    return this.videoModel.currentTime
  }

  setFullScreen(){
    window.getLastWindow(getContext(this), (err: object, data: window.Window) => {
      data.setWindowLayoutFullScreen(true)
    });
  }

  // 屏幕亮度范围 0~1
  adjustBrightness(brightness: number) {
    window.getLastWindow(getContext(this), (err: object, data: window.Window) => {
      let tempBrightness = brightness
      if (tempBrightness > 1) {
        tempBrightness = 1
      }
      else if (brightness <= 0) {
        tempBrightness = 0
      }
      data.setWindowBrightness(tempBrightness)
    });
  }

  getBright():Promise<number>{
    return new Promise<number>((resolve, reject) => {
      window.getLastWindow(getContext(this), (err: object, data: window.Window) => {
        resolve(data.getWindowProperties().brightness)
      })
    })
  }


  // 声音设置0-15
  adjustVolume(volume: number) {
    if (volume>15) {
      volume = 15
    }else if(volume<0){
      volume = 0
    }
    audio.getAudioManager().setVolume(audio.AudioVolumeType.MEDIA,volume)
  }

  getVolume():Promise<number> {
    return audio.getAudioManager().getVolume(audio.AudioVolumeType.MEDIA)
  }

  setSpeed(speed:string){
     IjkMediaPlayer.getInstance().setSpeed(speed)
  }

  getSpeed():number{
    return  IjkMediaPlayer.getInstance().getSpeed()
  }

  setUrl(url: string) {
    this.videoModel.url = url
  }

  getUrl():string{
    return this.videoModel.url
  }

  setHeader(headers: Map<string, string>) {
    this.videoModel.headers = headers
  }
  getHeader() {
    return this.videoModel.headers
  }
  getVideoAspectRatio(): number {
    return this.videoModel.videoWidth/this.videoModel.videoHeight
    // return this.videoModel.videoAspectRatio
  }

  setVideoAspectRatio(videoAspectRatio:number) {
    this.videoModel.videoAspectRatio = videoAspectRatio
  }

  setVideoWidth(videoWidth:number) {
    this.videoModel.videoWidth = videoWidth
  }

  setVideoHeight(videoHeight:number) {
    this.videoModel.videoHeight = videoHeight
  }

  getOrientation(): window.Orientation {
    if (this.videoModel.orientation===null) {
      globalThis.windowStage.getMainWindow((err, data) => {
        if (err.code) {
          console.error(JSON.stringify(err))
          return null
        }
        this.videoModel.orientation = this.getOrientation()
      })
    }

    return this.videoModel.orientation
  }

  setOrientation(orientation: window.Orientation) {
    if (globalThis.windowStage != undefined) {
      globalThis.windowStage.getMainWindow((err, data) => {
        if (err.code) {
          console.error('IjkPlayer changeWindowDirection Failed to change the window: ' + JSON.stringify(err))
          return
        }
        data.setPreferredOrientation(orientation);
        this.videoModel.orientation = orientation
      })
    }
  }

  changeOrientation(){
    if (globalThis.windowStage != undefined) {
      globalThis.windowStage.getMainWindow((err, data) => {
        if (err.code) {
          console.error('IjkPlayer changeWindowDirection Failed to change the window: ' + JSON.stringify(err))
          return
        }
        let temp = this.getOrientation()===window.Orientation.LANDSCAPE?window.Orientation.PORTRAIT:window.Orientation.LANDSCAPE
        data.setPreferredOrientation(temp);
        this.videoModel.orientation = temp
      })
    }
  }

    getXComponentId(){
      return this.videoModel.xComponentId
    }




  getPlayStateImg(): Resource | string {
    let res = this.videoModel.state === PlayStatus.PLAY ? $r('app.media.ic_detail_video_pause') : $r('app.media.ic_detail_video_play')
    return res
  }

  getTimeCurrent(): string {
    return this.videoModel.currentTime
  }

  getTimeTotal(): string {
    return this.videoModel.timeTotal
  }

  getPlayState(){
    return this.videoModel.state
  }

  private stopProgressTask() {
    clearInterval(this.updateProgressTimer);
    this.videoModel.sliderStep = 0

    console.log('app_log stopProgressTask:'+this.videoModel.xComponentId)
  }



  // 初始化Player,不包括播放
  public initPlayer(context: object, url:string,headers:Map<string,string>) {

     IjkMediaPlayer.getInstance().setContext(context);
     IjkMediaPlayer.getInstance().setDebug(false)
    // 初始化视频资源
     IjkMediaPlayer.getInstance().native_setup()

     IjkMediaPlayer.getInstance().setDataSource(url,headers)
    // 默认设置
    this.defaultOption()
    // 屏幕常亮
     IjkMediaPlayer.getInstance().setScreenOnWhilePlaying(true);
    // 给Listener赋值，IjkMediaPlayer内部进行了判空，因此不用担心传入为null
    this.initListener()
    // 将前面的Listener进行设置
     IjkMediaPlayer.getInstance().setMessageListener()

     IjkMediaPlayer.getInstance().prepareAsync()
  }

  private initListener() {
    //设置获取视频宽高回调监听
    this.videoModel.mOnVideoSizeChangedListener = {
      onVideoSizeChanged: (width: number, height: number, sar_num: number, sar_den: number) => {
        if (width!==this.videoModel.videoWidth||height!==this.videoModel.videoHeight) {
          this.videoModel.videoWidth = width
          this.videoModel.videoHeight = height
          this.videoModel.videoAspectRatio = this.videoModel.videoWidth/this.videoModel.videoHeight
        }

        promptAction.showToast({ message: width + "---" + height })
        console.log('app_log mOnVideoSizeChangedListener:width:'+width+"  height:"+height)
      }
    }
    //设置视频准备就绪回调监听
    this.videoModel.mOnPreparedListener = {
      onPrepared: () => {
        this.videoModel.videoWidth =  IjkMediaPlayer.getInstance().getVideoWidth()
        this.videoModel.videoHeight =  IjkMediaPlayer.getInstance().getVideoHeight()

        if (this.videoModel.videoAspectRatio>Constants.VIDEO_ASPECT_RATIO) {
          this.videoModel.xComponentWidth = '100%'
          this.videoModel.xComponentHeight = undefined
        }else{
          this.videoModel.xComponentWidth = undefined
          this.videoModel.xComponentHeight = '100%'
        }
        this.videoModel.videoAspectRatio = this.videoModel.videoWidth/this.videoModel.videoHeight
        this.videoModel.timeTotal = Utils.Duration(Math.floor( IjkMediaPlayer.getInstance().getDuration() / 1000))
        console.log('app_log mOnPreparedListener:'+this.videoModel.videoWidth+" --- "+this.videoModel.videoHeight +" --- "+this.videoModel.videoAspectRatio )
        this.videoModel.state = PlayStatus.PLAY
        this.startProgressTask();
      }
    }
    //设置字幕回调监听
    this.videoModel.mOnTimedTextListener = {
      onTimedText: () => {
      }
    }
    //设置播放完成回调监听
    this.videoModel.mOnCompletionListener = {
      onCompletion: () => {
        this.videoModel.state = PlayStatus.STOP
        this.videoModel.sliderStep = 0
        this.videoModel.currentTime = '00:00'
        console.log('app_log mOnCompletionListener:percent:'+this.videoModel.xComponentId)
      }
    }

    //设置buffer缓冲回调监听
    this.videoModel.mOnBufferingUpdateListener = {
      onBufferingUpdate: (percent: number) => {
        console.log('app_log mOnBufferingUpdateListener:percent:'+percent)
      }
    }

    //	设置快进后退回调监听
    this.videoModel.mOnSeekCompleteListener = {
      onSeekComplete: () => {
        this.play()
        console.log('app_log onSeekComplete：'+this.videoModel.sliderStep)
      }
    }

    //设置播放器的各种状态回调监听
    this.videoModel.mOnInfoListener = {
      onInfo: (what: number, extra: number) => {
        // console.log('app_log mOnInfoListener:what:'+what+"   extra:"+extra)
      }
    }
    //	设置播放异常回调监听
    this.videoModel.mOnErrorListener = {
      onError: (what: number, extra: number) => {
        this.videoModel.state = PlayStatus.STOP
        promptAction.showToast({
          message: `亲，bilibili error ：${what}`
        });
      }
    }

     IjkMediaPlayer.getInstance().setOnCompletionListener(this.videoModel.mOnCompletionListener);
     IjkMediaPlayer.getInstance().setOnPreparedListener(this.videoModel.mOnPreparedListener);
     IjkMediaPlayer.getInstance().setOnTimedTextListener(this.videoModel.mOnTimedTextListener);
     IjkMediaPlayer.getInstance().setOnVideoSizeChangedListener(this.videoModel.mOnVideoSizeChangedListener);
     IjkMediaPlayer.getInstance().setOnBufferingUpdateListener(this.videoModel.mOnBufferingUpdateListener);
     IjkMediaPlayer.getInstance().setOnSeekCompleteListener(this.videoModel.mOnSeekCompleteListener);
     IjkMediaPlayer.getInstance().setOnInfoListener(this.videoModel.mOnInfoListener);
     IjkMediaPlayer.getInstance().setOnErrorListener(this.videoModel.mOnErrorListener);
  }
  // 播放器的一些默认设置
  private defaultOption() {
    // 使用精确寻帧 例如，拖动播放后，会寻找最近的关键帧进行播放，很有可能关键帧的位置不是拖动后的位置，而是较前的位置.可以设置这个参数来解决问题
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "enable-accurate-seek", "1");
    // 预读数据的缓冲区大小
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "max-buffer-size", "102400");
    // 停止预读的最小帧数
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "min-frames", "100");
    // 启动预加载
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "start-on-prepared", "1");
    // 设置无缓冲，这是播放器的缓冲区，有数据就播放,0为无缓冲，1为有缓冲
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "packet-buffering", "0");
    // 跳帧处理,放CPU处理较慢时，进行跳帧处理，保证播放流程，画面和声音同步
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "framedrop", "5");
    // 最大缓冲cache是3s， 有时候网络波动，会突然在短时间内收到好几秒的数据
    // 因此需要播放器丢包，才不会累积延时
    // 这个和第三个参数packet-buffering无关。
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "max_cached_duration", "3000");
    // 无限制收流
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "infbuf", "1");
    //  IjkMediaPlayer.getInstance().setOptionLong(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "infbuf", "1")
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "opensles", "1");

    // 设置超时
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "timeout", "10000000");
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "connect_timeout", "10000000");
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "listen_timeout", "10000000");
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "addrinfo_timeout", "10000000");
     IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "dns_cache_timeout", "10000000");
  }
}