//homePage.js

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
//获取应用实例
const app = getApp()

Page({

  urls:[
    'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4',
    'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4',
    'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4',
    'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4',
    'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4'
  ],

  data: {
    motto: 'Hello World',
    userInfo: {},
    shopInfoList:[],
    currIndex:0,
    playIndex:-1,
    hasUserInfo: false,
    canIUse: wx.canIUse('button.open-type.getUserInfo'),
    hidden: false,
    indicatorDots: false,
    autoplay: false,
    interval: 2000,
    indicatordots: true,
    duration: 1000,
    lastX:0,
    lastY:0,
    fling:false,
    likes:[],
  },
  //事件处理函数

  playVideo: function () {
    var that=this;
    that.setData({
      playIndex: that.data.currIndex,
    });
    var palyontext = wx.createVideoContext('video'+that.currIndex);
    palyontext.play();
  },


  bindViewTap: function () {
    // wx.navigateTo({
      // url: '../logs/logs'
    // })
  },

  bindDetailTap:function(){
    var that = this;
    wx.navigateTo({
      url: '../index/index?shopInfo=' + JSON.stringify(that.data.shopInfoList[that.data.currIndex])+ '&shopList=' + JSON.stringify(that.data.shopInfoList),
    })
  },
  bindProfileTap: function () {
    wx.navigateTo({
      url: '../profile/profilePage'
    })
  },

  bindLikeTap: function () {
    var that = this;
    var _likes = that.data.likes;
    _likes[that.data.currIndex]=true;
    that.setData({
        likes:_likes,
    });
  },

  bindUnLikeTap: function () {
    var that = this;
    var _likes = that.data.likes;
    _likes[that.data.currIndex] = false;
    that.setData({
      likes: _likes,
    });
  },

  onLoad: function () {
    var that= this;
    wx.request({
      url: 'http://188.131.219.244:7001/',
      header:{'content-type':'application/json'},
      success:function (res){
        var _likes=that.data.likes;
        for(var i in res.data.data){
          _likes[i]=false;
        }
        that.setData({
          likes:_likes,
          shopInfoList: res.data.data,
        });
      },
      fail:function(e){
        console.log(e.errMsg);
      }
    })

    if (app.globalData.userInfo) {
      this.setData({
        userInfo: app.globalData.userInfo,
        hasUserInfo: true,
      })
    } else if (this.data.canIUse) {
      // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
      // 所以此处加入 callback 以防止这种情况
      app.userInfoReadyCallback = res => {
        // this.setData({
        //   userInfo: res.userInfo,
        //   hasUserInfo: true
        // })
      }
    } else {
      // 在没有 open-type=getUserInfo 版本的兼容处理
      wx.getUserInfo({
        success: res => {
          app.globalData.userInfo = res.userInfo
          this.setData({
            userInfo: res.userInfo,
            hasUserInfo: true,
          })
        }
      })
    }
  
  },
  getUserInfo: function (e) {
    console.log(e)
    app.globalData.userInfo = e.detail.userInfo
    this.setData({
      userInfo: e.detail.userInfo,
      hasUserInfo: true,
    })
  },

  /**
 * 检测触摸
 */
  handletouchtart: function (event) {
    // 赋值
    this.data.lastX = event.touches[0].pageX
    this.data.lastY = event.touches[0].pageY
  },

  /**
   * 触摸滑动
   */
  handletouchmove: function (event) {
    let _this = this;
    let show_video = '';
    let currentX = event.touches[0].pageX;
    let currentY = event.touches[0].pageY;
    let tx = currentX - this.data.lastX;
    let ty = currentY - this.data.lastY;

    if (Math.abs(tx) > Math.abs(ty)) {
      //左右方向滑动
      _this.data.fling = false;
      return;
      // if (tx < 0)
      //   show_video = "before"
      // else if (tx > 0)
      //   show_video = "after"
    } else {
      //上下方向滑动
      if (ty < 0)
        show_video = "after"
      else if (ty > 0)
        show_video = "before"
      //将当前坐标进行保存以进行下一次计算
      _this.data.lastX = currentX
      _this.data.lastY = currentY
      _this.data.fling = true;
      _this.data.show_video = show_video
    }
  },
   

  /**
   * 触摸结束
   */
  bindtouchend: function () {
    let _this = this;
    console.log(_this.data.fling);
    if (!_this.data.fling){
      return;
    }
    var _temp = _this.data.currIndex;
      if (_this.data.show_video == "before") {
        if(_temp==0){
          _temp=_this.data.shopInfoList.length-1;
        }else{
          _temp=_temp-1;
        }
      } else {
        if (_temp == _this.data.shopInfoList.length-1) {
          _temp = 0;
        } else {
          _temp = _temp + 1;
        }
       
      }
    _this.setData({
      currIndex: _temp,
    });
    _this.playVideo();
  },
})
