# ChangeList
## 目前问题（bug清单）：
1. ~~番剧页面会报TypeError问题，可能网络申请导致~~ (2024-3-18解决)
4. ~~SearchTabsAll页面 controller不好使~~ (2024-3-18解决)
3. ~~番剧，图文的item控件，没有提取成单独的组件。无法在综合页面使用~~(2024-3-18解决)
2. 番剧页面用Scroll控件保存数据，没有下拉刷新功能
5. 直播页面没有做下拉加载
6. 搜索页面获取和软键盘收起
6. 默认搜索页面，搜索overlord时，只有3个番剧。不显示其他内容。直言TRIGGER重复显示用户
7. 主页面崩溃：ObservedPropertySimple value must not be an object---OpenHarmony不会有此bug
8. ~~主页面不会默认刷新UI，OpenHarmony不会有此bug~~(2024-4-20解决---新增Splash页面，优先加载数据，传递到Index页面)
9. 搜索页面，搜索内容不能有%
10. 平板上，导航栏重叠了
11. VideoPlay seekTo移动时，没想好逻辑。以及播放完毕时，重新播放的逻辑
12. VideoPlay 连续快速操作，ijkplayer库会报错
13. ~~VideoPlay 播放此间无双的鞠婧祎的视频，会出现变形:分辨率是1280*544.~~ 修改布局，减少Stack层级(2024-3-26解决)
14. ~~搜索默认页面，在HarmonyOS4上不显示数据，OpenHarmony4.0上正常~~ 原因是ListView中的布局。必须用ListItem包裹。否则容易出bug
15. VideoPlay控件，在播放之后，seekTo，退出再进入，必然崩溃
16. SearchSuggest页面 获取焦点问题
17. ~~二维码登录，无法观看大会员视频~~ 通过二维码登录大会员账号，获取Cookie。将SESSION_DATA中的,换成%2C后就能看大会员视频了。(2024-3-26解决)

## 项目功能进度
### 2024-3-17
    图文页面，最下部缺失，无法全屏

### 2024-3-18
#### 1. 解决图文页面，最下部缺失问题
    解决图文页面，最下部缺失问题，通过给SearchTabsAll的LoadingData设置.layoutWeight(1)
    解决问题

#### 2. 解决BiliUser页面搜索TikTok美国，item报undefined问题
    返回2个数据，导致会直接执行onReachEnd中的代码，导致再次网络申请数据，由于后台一共两个数据，
    所以再次申请不到数据，返回异常数据，最终无法解析，布局重绘时都是undifined数据

#### 3. 完成图文页面


#### 4. 完成番剧页面
    番剧页面用Scroll控件保存数据。

#### 5. Shopping页面改为Web页面
    Shopping页面改为Web，新增地址为bilibili网址：https://m.bilibili.com/
    新增loading页面

#### 6. 搜索影视页面
    新增BasicDataSource,懒加载相关
    使用Scroll + LazyForEach完成。LazyForEach外层要套一层Colum同时不能设置高度，否则无法滚动
    MediaFtItem中的@Builder mediaFtItem显示不全，最外层套一层容器组件即可
#### 7. 新增没有数据的页面
    在LoadingData组件中新增NoData组件，用于处理没有申请到数据时的逻辑
#### 8. 解决影视和番剧页面会报TypeError问题
    原因是，网络申请返回的json数据中，没有result。番剧页面中，进行特殊处理即可

#### 9. 解决直播页面只显示一个Item问题
    原因是，item匹配时，使用了item=>item。导致检测为同一个item，没有进行加载

#### 10. 完成直播页面
    使用懒加载+List+Scroll完成直播页面
#### 11. 减少search页面各Tabs页面嵌套层级
    减少search页面各Tabs页面嵌套层级

### 2024-3-19
#### 1. 把Bean数据从class改为interface
    Default页面的各种类数据格式和Video，番剧等一致，改为interface直接implement就能使用
#### 2. 把各页面的Item抽取
    将Search页面的Video，番剧，影视，直播间等页面的Item抽取出单独组件，方便后续默认搜索页面（SearchDefault）页面使用

#### 3. 所有的搜索页面做成懒加载
    从ForEach改为LazyForEach，提高性能
#### 4. 把各主页面热搜页面做成懒加载，新增KeyGenerator 
    把所有懒加载页面都增加了KeyGenerator，以免重复渲染，浪费性能
#### 5. 默认页面懒加载
    默认页面可以显示各种类型，个别界面需要重新设置不能复用之前的
    实现加载功能
### 2024-3-19 4:28 -----------------------------------
#### 6. MINE页面二维码功能
    实现二维码登录的逻辑功能，但是没有UI

### 2024-3-20 --- 0:00 ---> 开始
#### 1. 研究了下拉刷新
    刷新的图标移动，可以根据onTouch的position和修改图标父容器的height来实现
#### 2. SeachPage页面数据传递到Default页面
    SeachPage页面数据传递到Default页面。使用@Provider和@Consume来实现，
    减少Default页面重复获取数据，且多嵌套一层Loading页面
### 2024-3-20  ---  3:40 <--- 结束
### 2024-3-20  ---  11:00 <--- 开始
#### 3. 新增Splash页面
    主界面不刷新的原因，是因为懒加载造成的。可以研究@ObjectLink和@Observed的使用解决
    此处使用另一种解决方案。新增Splash页面，数据放到Slash页面中进行加载。将结果直接传递到主界面中。
    在观感上节省用户等待时间

### 2024-3-21
#### 1. VideoPlay可以播放
    查找ijkplayer库不能播放原因。
    修改VideoPlay可以播放

### 2024-3-22
#### 1. VideoPlay页面
     VideoPlay新增，进度条，播放按钮，loading按钮，旋转按钮，返回按键，以及回到主界面按键

#### 2. 返回按键和home按键
     重新修改了这两个按键的分辨率。

#### 3. 返回桌面，暂停视频。回到程序，继续播放
     返回桌面，暂停视频。回到程序，继续播放

### 2024-3-25
#### 1. 直播页面
    直播页面，可以观看

### 2024-3-26
#### 1. 影视页面
    影视可以观看

#### 2. VideoPlay布局修改
    修改布局VideoPlay布局修改，减少Stack层级。修复bug13

/*------------------------------------------- 2024-3-26  3:05 END --------------------------------------------*/

/*------------------------------------------- 2024-3-26  11:36 START --------------------------------------------*/
#### 3. VideoPlay 抽取子组件，方便@ObjectLink使用
     VideoPlay 抽取子组件，方便@ObjectLink使用

#### 4. SearchHeader中的Search换成TextInput
     SearchHeader中的Search换成TextInput，软键盘搜索后自动缩起。软键盘设置成search键

#### 5. 二维码登录获取Cookie
     通过二维码登录大会员账号，获取Cookie。将SESSION_DATA中的,换成%2C后就能看大会员视频了。

#### 6. 视频宽高比问题
     解决视频宽高比问题
/*------------------------------------------- 2024-3-27 --------------------------------------------*/
#### 1. Index界面的Tab
     Index界面的TabIcon颜色修改成Bilibili主题色