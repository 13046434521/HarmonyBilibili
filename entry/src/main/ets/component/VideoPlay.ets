import { IjkPlayer, IjkPlayerConfig } from '../common/IjkPlayer'
import Api from '../net/Api'
import promptAction from '@ohos.promptAction'
import { PlayStatus } from '../common/PlayStatus'
import { PlayURL } from '../bean/PlayVideoBean'
import { Utils } from '../Utils/Utils'
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
import window from '@ohos.window'

@Component
export struct VideoPlay {
  @State url: string = ""
  @Prop bvid: string
  @Prop cid: number
  @State ijkConfig: IjkPlayerConfig = new IjkPlayerConfig()
  @State videoAspectRatio: number = 16 / 9
  @State state: PlayStatus = PlayStatus.INIT
  @State sliderStep: number = 0
  @State playURL: PlayURL = null
  @State timeTotal: string = '00:00'
  @State currentTime: string = '00:00'
  xcomponentController: XComponentController = new XComponentController()
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

  aboutToAppear() {
    // IjkPlayer.getInstance().reset()
    // promptAction.showToast({message:"bvid:"+this.bvid+"  "+"cid:"+this.cid})
  }

  aboutToDisappear() {
    // IjkPlayer.getInstance().release()
  }

  build() {

    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        XComponent({
          id: this.ijkConfig.id,
          type: this.ijkConfig.type,
          libraryname: this.ijkConfig.libraryName,
          controller: this.xcomponentController
        }).onLoad((context) => {
          this.xcomponentController.setXComponentSurfaceSize({
            surfaceWidth: 1080,
            surfaceHeight: 1920
          })

          initListener.bind(this)()
          loadData.bind(this, context)()


        }).onDestroy(() => {
          IjkPlayer.getInstance().release()
        }).width('100%')
          .aspectRatio(this.videoAspectRatio)

        Row() {
          Image(this.state === PlayStatus.PLAY ? $r('app.media.ic_detail_video_pause') : $r('app.media.ic_detail_video_play'))
            .width('8%')
            .aspectRatio(1)
            .objectFit(ImageFit.Contain)
            .interpolation(ImageInterpolation.High)
            .onClick(() => {

              playVideo.bind(this)()
            })
            .margin(12)
          Slider({
            value: this.sliderStep,
            style: SliderStyle.OutSet,
            direction: Axis.Horizontal
          })
            .blockColor(Color.White)
            .trackColor(Color.Grey)
            .selectedColor(Color.Pink)
            .showTips(true)
            .onChange((value: number, mode: SliderChangeMode) => {

              // value/100 是百分比  getDuration获取的是总时长
              let seekValue = value * (IjkPlayer.getInstance().getDuration() / 100);
              IjkPlayer.getInstance().seekTo(Math.floor(seekValue).toString())
              this.currentTime = Utils.Duration(Math.floor(seekValue / 1000))
            })
            .width('50%')
            .opacity(0.5)
          Text(`${this.currentTime} / ${this.timeTotal}`)
            .fontSize(8)
            .maxLines(1)
            .margin(8)
            .fontColor(Color.White)
        }.justifyContent(FlexAlign.SpaceEvenly)
        .backgroundColor("#4F4F4F")
        .height('32')

      }
      .width('100%')
      .aspectRatio(this.videoAspectRatio)


      Button('async').onClick(() => {
        IjkPlayer.getInstance().prepareAsync()

      })
      Button('start').onClick(() => {
        IjkPlayer.getInstance().start()
      })
      Button('pause').onClick(() => {
        IjkPlayer.getInstance().pause()
      })
      Button('height,width').onClick(() => {
        this.videoAspectRatio = IjkPlayer.getInstance().getVideoWidth() / IjkPlayer.getInstance()
          .getVideoHeight()
        promptAction.showToast({
          message: `${IjkPlayer.getInstance().getVideoWidth()} --- ${IjkPlayer.getInstance()
            .getVideoHeight()}`
        })
      })

      Button('release').onClick(() => {
        IjkPlayer.getInstance().release()
      })
    }.width('100%')
    .height('100%')
  }

  startProgressTask() {
    this.updateProgressTimer = setInterval(() => {
      if (IjkPlayer.getInstance().isPlaying()) {
        let duration = IjkPlayer.getInstance().getDuration()
        let current = IjkPlayer.getInstance().getCurrentPosition()
        if (duration>0) {
          this.sliderStep = current/duration *100;
        }
        this.currentTime = Utils.Duration(Math.floor(current/1000))
      }
    }, 300);
  }

  stopProgressTask() {
    clearInterval(this.updateProgressTimer);
  }
}

function playVideo() {
  this.state = this.state === PlayStatus.PLAY ? PlayStatus.PAUSE : PlayStatus.PLAY
  switch (this.state) {
    case PlayStatus.PAUSE: {
      IjkPlayer.getInstance().pause()
      break
    }
    case PlayStatus.PLAY: {
      IjkPlayer.getInstance().start()
      break
    }
  }
  promptAction.showToast({
    message: this.state.toString()
  , duration: 2000
  })
}

function loadData(context: Object) {
  Api.getPlayVideo(this.bvid, this.cid).then(playVideoBean => {
    this.playURL = playVideoBean.durl[0]
    this.url = this.playURL.url.replace(/\\u0026/g, '&')
    this.ijkConfig.url = this.url
    this.timeTotal = Utils.Duration(Math.floor(this.playURL.length / 1000))

    // 初始化Player,不包括播放
    IjkPlayer.getInstance()
      .initPlayer(context, this.ijkConfig, this.mOnVideoSizeChangedListener, this.mOnPreparedListener, this.mOnCompletionListener, this.mOnBufferingUpdateListener,
        this.mOnSeekCompleteListener, this.mOnInfoListener, this.mOnErrorListener)


  }).catch(err => {
    promptAction.showToast({
      message: `${"加载视频url失败："}  bvid:${this.bvid}  cid:${this.cid}  url:${this.url}`,
      duration: 2000,
    });
  })
}

function initListener() {
  //设置获取视频宽高回调监听
  this.mOnVideoSizeChangedListener = {
    onVideoSizeChanged: (width: number, height: number, sar_num: number, sar_den: number) => {
      promptAction.showToast({ message: width + "---" + height })
      this.videoAspectRatio = width / height
    }
  }
  //设置视频准备就绪回调监听
  this.mOnPreparedListener = {
    onPrepared: () => {
      this.state = PlayStatus.PLAY
      this.startProgressTask.bind(this)()
      promptAction.showToast({
        message: IjkPlayer.getInstance().getVideoWidth() + "--**--" + IjkPlayer.getInstance()
          .getVideoHeight()
      })
    }
  }
  //设置字幕回调监听
  this.mOnTimedTextListener = {
    onTimedText: () => {
    }
  }
  //设置播放完成回调监听
  this.mOnCompletionListener = {
    onCompletion: () => {
      this.state = PlayStatus.PAUSE
      promptAction.showToast({
        message: "播完了"
      })
    }
  }
  //设置buffer缓冲回调监听
  this.mOnBufferingUpdateListener = {
    onBufferingUpdate: (percent: number) => {
    }
  }
  //	设置快进后退回调监听
  this.mOnSeekCompleteListener = {
    onSeekComplete: () => {
    }
  }

  //设置播放器的各种状态回调监听
  this.mOnInfoListener = {
    onInfo: (what: number, extra: number) => {

    }
  }
  //	设置播放异常回调监听
  this.mOnErrorListener = {
    onError: (what: number, extra: number) => {
      promptAction.showToast({
        message: `亲，bilibili error ：${what}`
      });
    }
  }
}


