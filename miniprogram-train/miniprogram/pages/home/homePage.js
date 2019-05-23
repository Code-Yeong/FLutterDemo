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
    shopName:'外婆家',
    shopPic:'../images/shop.jpg',
    shopInfo:'附近有103人也感兴趣',
    videoUrl: 'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4',
    hasUserInfo: false,
    canIUse: wx.canIUse('button.open-type.getUserInfo')
  },
  //事件处理函数
  bindViewTap: function () {
    // wx.navigateTo({
      // url: '../logs/logs'
    // })
    var palyontext = wx.createVideoContext('video1');
    palyontext.play();
  },

  bindDetailTap:function(){
    var that = this;
    wx.navigateTo({
      url: '../index/index?shopName='+that.data.shopInfoList[that.data.currIndex].info.name,
    })
  },
  bindProfileTap: function () {
    wx.navigateTo({
      url: '../profile/profilePage'
    })
  },
  onLoad: function () {
    var that= this;
    wx.request({
      url: 'http://188.131.219.244:7001/',
      header:{'content-type':'application/json'},
      success:function (res){
        console.log(res.statusCode);
        console.log(res.data);
        that.setData({
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
        videoUrl: "../mytestvideo.MP4"
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
            videoUrl: "../mytestvideo.MP4"
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
      videoUrl: "../mytestvideo.MP4"
    })
  }
})
