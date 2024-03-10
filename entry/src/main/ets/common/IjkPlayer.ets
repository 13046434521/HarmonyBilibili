/*
import {
  IjkMediaPlayer,
  OnBufferingUpdateListener,
  OnCompletionListener,
  OnErrorListener,
  OnInfoListener,
  OnPreparedListener,
  OnSeekCompleteListener,
  OnVideoSizeChangedListener
} from "@ohos/ijkplayer";

@Observed
export class IjkPlayerConfig {
  */
/*  id: 'xcomponentId',
    type: 'surface',
    libraryname: 'ijkplayer_napi'*//*

  id: string = "ijkplayer"
  type: IjkPlayerConfigType = IjkPlayerConfigType.surface
  libraryName: string = "ijkplayer_napi"
  url: string

  headers =  new Map<string,string>([
    ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
    // ["Connection","keep-alive"],
    // ["Referer", "https://www.bilibili.com"]
    ['Content-Type','application/octet-stream']
  ]);
  public constructor(id?: string,
                     type?: IjkPlayerConfigType,
                     libraryName?: string,
                     url?: string,
                     header?: Map<string, string>) {
*/
/*    this.id = id
    this.type = type
    this.libraryName = libraryName
    this.url = url
    this.header = header*//*

  }
}

export enum IjkPlayerConfigType {
  surface = 'surface',
  component = 'component'
}

export class IjkPlayer extends IjkMediaPlayer {
  private static instance: IjkPlayer
  ijkPlayerConfig: IjkPlayerConfig

  private constructor() {
    super()
  }

  public static getInstance(): IjkPlayer {
    if (!IjkPlayer.instance) {
      IjkPlayer.instance = new IjkPlayer();
    }
    return IjkPlayer.instance;
  }


  // 初始化Player,不包括播放
  public initPlayer(context: object, ijkPlayerConfig: IjkPlayerConfig,mOnVideoSizeChangedListener?: OnVideoSizeChangedListener,
                    mOnPreparedListener?: OnPreparedListener, mOnCompletionListener?: OnCompletionListener,
                    mOnBufferingUpdateListener?: OnBufferingUpdateListener, mOnSeekCompleteListener?: OnSeekCompleteListener,
                    mOnInfoListener?: OnInfoListener, mOnErrorListener?: OnErrorListener) {
    this.ijkPlayerConfig = ijkPlayerConfig
    this.setContext(context);
    this.setDebug(true)
    // 初始化视频资源
    this.native_setup()
    this.setDataSource(this.ijkPlayerConfig.url)
    this.setDataSourceHeader(this.ijkPlayerConfig.headers)
    // 默认设置
    this.defaultOption()
    // 屏幕常亮
    this.setScreenOnWhilePlaying(true);
    // 给Listener赋值，ijkplayer内部进行了判空，因此不用担心传入为null
    this.setOnVideoSizeChangedListener(mOnVideoSizeChangedListener)
    this.setOnPreparedListener(mOnPreparedListener)
    this.setOnCompletionListener(mOnCompletionListener)
    this.setOnBufferingUpdateListener(mOnBufferingUpdateListener)
    this.setOnSeekCompleteListener(mOnSeekCompleteListener)
    this.setOnInfoListener(mOnInfoListener)
    this.setOnErrorListener(mOnErrorListener)
    // 将前面的Listener进行设置
    this.setMessageListener()
    // 加载数据
    this.prepareAsync()
  }

  // 播放器的一些默认设置
  private defaultOption() {
    // 使用精确寻帧 例如，拖动播放后，会寻找最近的关键帧进行播放，很有可能关键帧的位置不是拖动后的位置，而是较前的位置.可以设置这个参数来解决问题
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "enable-accurate-seek", "1");
    // 预读数据的缓冲区大小
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "max-buffer-size", "102400");
    // 停止预读的最小帧数
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "min-frames", "100");
    // 启动预加载
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "start-on-prepared", "1");
    // 设置无缓冲，这是播放器的缓冲区，有数据就播放
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "packet-buffering", "0");
    // 跳帧处理,放CPU处理较慢时，进行跳帧处理，保证播放流程，画面和声音同步
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "framedrop", "5");
    // 最大缓冲cache是3s， 有时候网络波动，会突然在短时间内收到好几秒的数据
    // 因此需要播放器丢包，才不会累积延时
    // 这个和第三个参数packet-buffering无关。
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "max_cached_duration", "3000");
    // 无限制收流
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "infbuf", "1");

    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "opensles", "1");

    // 设置超时
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "timeout", "10000000");
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "connect_timeout", "10000000");
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "listen_timeout", "10000000");
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "addrinfo_timeout", "10000000");
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "dns_cache_timeout", "10000000");
  }
}*/
