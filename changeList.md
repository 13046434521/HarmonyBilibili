# ChangeList

## 2024-4-17
        图文页面，最下部缺失，无法全屏

## 2024-4-18
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

### 2024-4-18 目前问题：
    番剧页面会报TypeError问题，可能网络申请导致  解决
    番剧页面用Scroll控件保存数据，没有下拉刷新功能  
    番剧，图文的item控件，没有提取成单独的组件。无法在综合页面使用
    SearchTabsAll页面 controller不好使
    直播页面没有做下拉加载