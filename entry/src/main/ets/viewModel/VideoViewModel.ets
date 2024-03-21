
import { IPlayer } from './IPlayer'

import promptAction from '@ohos.promptAction'
import VideoModel from './VideoModel'
import { PlayStatus } from '../common/PlayStatus'
import { Orientation } from '../common/Orientation'
import { DisplayInfo } from '../common/DisplayInfo'
import { IjkMediaPlayer } from '@ohos/ijkplayer'


//VideoPlayer 的 逻辑功能类
export class VideoViewModel implements IPlayer {
  viewModel: VideoModel = new VideoModel()

  init(context: object) {
    this.initListener()
    // 初始化Player,包括播放
    this.initPlayer(context, this.viewModel.url, this.viewModel.headers)
    this.initListener()
  }

  // 直接播放
  prepareAsync  (){
    IjkMediaPlayer.getInstance().prepareAsync()
  }

  play() {
    this.viewModel.state = (this.viewModel.state === PlayStatus.PLAY ? PlayStatus.PAUSE : PlayStatus.PLAY)

    switch (this.viewModel.state) {
      case PlayStatus.PAUSE: {
        this.pause()
        break
      }
      case PlayStatus.PLAY: {
        IjkMediaPlayer.getInstance().start()
        break
      }
    }
  }

  pause() {
    this.viewModel.state = PlayStatus.PAUSE
    IjkMediaPlayer.getInstance().pause()
  }

  moveProgress(progress: number) {
    let seekValue = progress * (IjkMediaPlayer.getInstance().getDuration() / 100);

    IjkMediaPlayer.getInstance().seekTo(Math.floor(seekValue).toString())

    this.viewModel.currentTime = this.Duration(Math.floor(seekValue / 1000))
  }

  getCurrentTime(): string {
    return this.viewModel.currentTime
  }

  adjustVolume(volume: number) {
    let tempVolume = volume
    if (tempVolume > 1) {
      tempVolume = 1
    }
    else if (volume < 0) {
      tempVolume = 0
    }
    this.viewModel.volume = tempVolume
    IjkMediaPlayer.getInstance().setVolume(volume.toFixed(0.1),volume.toFixed(0.1))
  }

  adjustBrightness(brightness: number) {
    let tempBrightness = brightness
    if (tempBrightness > 100) {
      tempBrightness = 100
    }
    else if (brightness <= 0) {
      tempBrightness = 0
    }
    this.viewModel.brightness = tempBrightness
    // IjkMediaPlayer.getInstance().set()
  }

  stop() {
    IjkMediaPlayer.getInstance().stop()
  }

  release() {
    IjkMediaPlayer.getInstance().release()
  }

  reset() {
    IjkMediaPlayer.getInstance().reset()
  }

  setUrl(url: string) {
    this.viewModel.url = url
  }

  getUrl():string{
    return this.viewModel.url
  }



  setHeader(headers: Map<string, string>) {
    this.viewModel.headers = headers
  }
  getHeader() {
    return this.viewModel.headers
  }
  getVideoAspectRatio(): number {
    return this.viewModel.videoAspectRatio
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


  upDateViewModel(viewModel: VideoModel) {
    this.viewModel = viewModel
  }

  getPlayStateImg(): Resource | string {
    let res = this.viewModel.state === PlayStatus.PLAY ? $r('app.media.ic_detail_video_pause') : $r('app.media.ic_detail_video_play')
    return res
  }

  getTimeContent(): string {
    // return IjkMediaPlayer.getInstance().getDuration()
    return '0:0'
  }

  // startProgressTask() {
  //   this.updateProgressTimer = setInterval(() => {
  //     if (IjkMediaPlayer.getInstance().isPlaying()) {
  //       let duration = IjkMediaPlayer.getInstance().getDuration()
  //       let current = IjkMediaPlayer.getInstance().getCurrentPosition()
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
        //   message: IjkMediaPlayer.getInstance().getVideoWidth() + "--**--" + IjkMediaPlayer.getInstance()
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
    } else {
      second.toFixed(0)
    }

    //console.log("duration:"+duration+"---"+minute+'---'+second)
    return duration > 3600 ? Math.floor(duration / 3600) + ":" + minute + ":" + second : minute + ":" + second
  }

  // 初始化Player,不包括播放
  public initPlayer(context: object, url:string,headers:Map<string,string>) {

    IjkMediaPlayer.getInstance().setContext(context);
    IjkMediaPlayer.getInstance().setDebug(false)
    // 初始化视频资源
    IjkMediaPlayer.getInstance().native_setup()

    IjkMediaPlayer.getInstance().setDataSourceHeaders(url,headers)
    // 默认设置
    this.defaultOption()
    // 屏幕常亮
    IjkMediaPlayer.getInstance().setScreenOnWhilePlaying(true);
    // 给Listener赋值，IjkMediaPlayer内部进行了判空，因此不用担心传入为null
    // 将前面的Listener进行设置
    IjkMediaPlayer.getInstance().setMessageListener()

    IjkMediaPlayer.getInstance().prepareAsync()
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
    // 设置无缓冲，这是播放器的缓冲区，有数据就播放
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "packet-buffering", "0");
    // 跳帧处理,放CPU处理较慢时，进行跳帧处理，保证播放流程，画面和声音同步
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "framedrop", "5");
    // 最大缓冲cache是3s， 有时候网络波动，会突然在短时间内收到好几秒的数据
    // 因此需要播放器丢包，才不会累积延时
    // 这个和第三个参数packet-buffering无关。
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "max_cached_duration", "3000");
    // 无限制收流
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "infbuf", "1");
    // IjkMediaPlayer.getInstance().setOptionLong(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "infbuf", "1")
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "opensles", "1");

    // 设置超时
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "timeout", "10000000");
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "connect_timeout", "10000000");
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "listen_timeout", "10000000");
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "addrinfo_timeout", "10000000");
    IjkMediaPlayer.getInstance().setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "dns_cache_timeout", "10000000");
  }
}