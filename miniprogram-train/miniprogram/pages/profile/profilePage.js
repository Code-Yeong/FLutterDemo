// pages/profile/profilePage.js
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
Page({

  /**
   * 页面的初始数据
   */
  data: {
    videoData:[],
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function () {
    var that = this
    var urls = [
      'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4',
      'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4',
      'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4',
      'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4',
      'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4'
    ];
    that.setData({
      videoData: urls,
    });
   
    
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})