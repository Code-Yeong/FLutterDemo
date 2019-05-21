"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var app = getApp();
Page({
  data: {
    speed: 0.0,
    accuracy: 0.0,
    latitude: 39.9840587078,
    longitude: 116.3075780869,
  },
  bindViewTap: function () {
    console.log("switch tabs");
    wx.navigateTo({
      url: '../logs/logs'
    });
  },
  markertap: function (e) {
    console.log("clicked");
    wx.getLocation({
      type: "GCJ02",
      success: (res) => {
        this.setData({
          latitude: res.latitude,
          longitude: res.longitude,
        });

      }
    });
  },
  onLoad: function () {
    var _this = this;
    var that = this
    wx.showLoading({
      title: "定位中",
      mask: true
    })
    wx.getLocation({
      type: 'GCJ02',
      altitude: true,//高精度定位
      //定位成功，更新定位结果
      success: function (res) {
        that.setData({
          longitude: res.longitude,
          latitude: res.latitude,
          speed: res.speed,
          accuracy: res.accuracy
        })
      },
      //定位失败回调
      fail: function () {
        wx.showToast({
          title: "定位失败",
          icon: "none"
        })
      },

      complete: function () {
        //隐藏定位中信息进度
        wx.hideLoading()
      }

    });
  }
});