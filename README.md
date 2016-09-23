#####运行此程序报错（报缺少IJKMediaFramework.framework的错误），请下载[IJKMediaFramework.framework](https://pan.baidu.com/s/1eSLRmme)解压IJKMediaFramework.framework.zip后直接拖进工程运行即可。
# LKLiveTool
#### 此APP使用`OC`和`Swift`混编以及`storyboard`,本着能不用代码就不用代码原则。其中`IJKMediaFramework`和`pili-librtmp`使用OC，其他使用Swift(不断跟换)。通过抓取映客的接口实现直播，推流使用的搭建本地服务器实现推流。没有完全照搬映客APP,主要是为了熟悉Swift下常用三方库的使用。所以此App不是高仿只是Demo但是基本直播功能均已实现。最近公司活较少经常跟新后期也会不定时添加新功能。
#### 在写之前参考了很多前辈的代码以及对直播整体有一个大概流程了解。在不断挖坑填坑(下方有关直播资料链接地址)。

##扫描下放二维码即可通过蒲公英下载


##两大模块
###1. 播放端
- 播放器采用[ijkplayer](https://github.com/Bilibili/ijkplayer),是基于FFmpeg的跨平台播放器针对RTMP优化，开源项目已经被多个App使用，其中映客、美拍和斗鱼使用了。这是已经打包好的直接导入就好[IJKMediaFramework.framework](https://pan.baidu.com/s/1eSLRmme)

- 礼物已经有许多造好的轮子直接拿过来用就好。 [弹幕](https://github.com/unash/BarrageRenderer)。

###2. 采集端
- 技术点特别多但是三方框架方法已经写好直接调用就好注释还是中文的。[LFLiveKit](https://github.com/LaiFengiOS/LFLiveKit)
- 关于本地服务器的搭建[快速集成iOS基于RTMP的视频推流](http://www.jianshu.com/p/8ea016b2720e)

##请下载Demo自己去尝试



##链接
- [iOS实时美颜滤镜是怎样炼成的](http://www.open-open.com/lib/view/open1463108934371.html)
- [FFMPEG视音频编解码零基础学习方法](http://blog.csdn.net/leixiaohua1020/article/details/15811977/)
- [移动直播技术秒开优化经验](http://weibo.com/ttarticle/p/show?id=2309403969318634263193)
- [iOS视频直播初窥:高仿<喵播APP>](http://www.jianshu.com/p/b8db6c142aad)
- [做一款仿映客的直播App？看我就够了](http://www.jianshu.com/p/5b1341e97757)



