"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var app = getApp();
Page({
    data: {
        speed:0.0,
        accuracy:0.0,
        latitude: 39.980760,
        longitude: 116.314740,
        relLat:0.0,
        relLng:0.0,
        received:false,
        shopInfo:null,
        shopList:[],
        cover:null,
        markers:[],
        polyline:null,
        statusType:null,
        sampleUrls:[],
        playId:-1,
    },
    bindViewTap: function () {
      var info = e.currentTarget.dataset.info;
      wx.openLocation({ 
        latitude: 38.9840587078, 
        longitude: 117.3075780869, 
        scale: 18, 
        name: '测试地点', 
        address: info.address
      });
      
    },
    
    markertap:function(e){
      var info = e.currentTarget.dataset.info;
      wx.openLocation({
        latitude: 38.9840587078,
        longitude: 117.3075780869,
        scale: 18,
        name: '测试地点',
        address: "BeiJing",
      });
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
  playSampleVideo: function (e) {
    var that = this;
    that.setData({
      playId: e.currentTarget.dataset.id,
    });
    var palyontext = wx.createVideoContext('video' + e.currentTarget.dataset.id);
    palyontext.play();
  },
    onLoad: function (params) {
      var _this = this;
      var that = this
      var _markers = that.data.markers;
      var _cover = JSON.parse(params.shopInfo).video_cover;
      var _shopList = JSON.parse(params.shopList);
      var shopDetail = JSON.parse(params.shopInfo).info;
      var location=shopDetail.location;
      wx.setNavigationBarColor({
        frontColor: '#000000',
        backgroundColor: '#ffffff',
        animation: { // 可选项
          duration: 400,
          timingFunc: 'easeIn'
        },
      });
      _markers.push({
        id: 0,
        longitude: location[0],
        latitude: location[1],
        iconPath: '../images/location.png',
        width: 32,
        height: 32,
        callout: {
          content: shopDetail.name,
          padding: 2,
          display: 'ALWAYS',
          textAlign: 'center'
        }
      });

      var _sampleUrls=[
        'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4',
        'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4',
        'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4',
        'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4',
      ];

      that.setData({
        shopInfo: shopDetail,
        longitude:location[0],
        latitude: location[1],
        sampleUrls:_sampleUrls,
        shopList: _shopList,
        cover:_cover,
      });
      wx.showLoading({
        title: "定位中",
        mask: true
      })
     
      _markers.push({
        id: 1,
        latitude: 39.980760,
        longitude: 116.314740,
        title: '外婆家',
        iconPath: '../images/location.png',
        width: 32,
        height: 32
      });
      _markers.push({
        id: 2,
        latitude: 39.979279,
        longitude: 116.307152,
        title: '村下外婆家',
        iconPath: '../images/location.png',
        width: 32,
        height: 32
      });
      _markers.push({
        id: 3,
        latitude: 39.980870,
        longitude: 116.305050,
        title: '庆丰包子铺',
        iconPath: '../images/location.png',
        width: 32,
        height: 32
      });

      wx.getLocation({
        type: 'GCJ02',
        altitude: true,//高精度定位
        //定位成功，更新定位结果
        success: function (res) {
          that.setData({
            speed: res.speed,
            accuracy: res.accuracy,
            markers: _markers,
            relLat:res.latitude,
            relLng:res.longitude
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
    },

  receiveCard: function(){
    var that = this;
    that.setData({
      received:true,
    });
  },

  gotohere: function (res) {
    var that = this;
    let lat = ''; // 获取点击的markers经纬度
    let lon = ''; // 获取点击的markers经纬度
    let name = ''; // 获取点击的markers名称
    let markerId = res.markerId;// 获取点击的markers  id
    let markers = that.data.markers;// 获取markers列表

    for (let item of markers) {
      if (item.id === markerId) {
        lat = item.latitude;
        lon = item.longitude;
      }
    }
    that.route("1",lat,lon);
  },

  /**路线规划 */
  route: function (e, lat1, lng1) {
    wx.showLoading({
      title: '正在规划路线',
    });
    var that = this;
    var lat = "";
    var lng = "";
    if (e == "1") {
      lat = lat1;
      lng = lng1;
    } else {
      lat = e.currentTarget.dataset.lat;
      lng = e.currentTarget.dataset.lng;
    }
    // 经纬度坐标
    //百度地图的坐标系是BD09，而腾讯地图坐标系是GCJ02
    // var result = gcoord.transform(
    //   [lat, lng],
    //   gcoord.BD09,
    //   gcoord.GCJ02
    // );
    var result = [lat, lng];
    // var toCoor = lat + ',' + lng;
    var toCoor = result;
    lat = result[0];
    lng = result[1];
    that.driving(toCoor, lat, lng);
  },


 //事件回调函数
  driving: function (toCoor, lat, lng) {
    var _this = this;     //网络请求设置
    var fromCoor = _this.data.relLat + ',' + _this.data.relLng;
    this.mapCtx = wx.createMapContext('mymap'); //获取地图对象同canvas相似，获取后才能调用相应的方法
    this.mapCtx.moveToLocation() //将当前位置移动到地图中心

    this.mapCtx.includePoints({
      padding: [10],
      points: [{
        latitude: _this.data.latitude,
        longitude: _this.data.longitude,
      }, {
        latitude: lat,
        longitude: lng,
      }]
    }) //缩放视野展示所有经纬度


    _this.setData({
      latitude: _this.data.latitude,
      longitude: _this.data.longitude,
      markers: [{
        id: 4,
        latitude: lat,
        longitude: lng,
        iconPath: '../images/end.png',
        width: 30,
        height: 30
      }, {
        id: 5,
        latitude: _this.data.relLat,
        longitude: _this.data.relLat,
        iconPath: '../images/start.png',
        width: 30,
        height: 30
      }]
    })

    wx.request({   //WebService请求地址，from为起点坐标，to为终点坐标，开发key为必填
      url: app.globalData.driving + '?from=' + fromCoor + '&to=' + toCoor + '&key=' + app.globalData.mapKey,
      method: 'GET',
      dataType: 'json',
      //请求成功回调
      success: function (res) {
        var ret = res.data
        if (ret.status != 0) return; //服务异常处理
        var coors = ret.result.routes[0].polyline,
          pl = [];
        //坐标解压（返回的点串坐标，通过前向差分进行压缩）
        var kr = 1000000;
        for (var i = 2; i < coors.length; i++) {
          coors[i] = Number(coors[i - 2]) + Number(coors[i]) / kr;
        }
        //将解压后的坐标放入点串数组pl中
        for (var i = 0; i < coors.length; i += 2) {
          pl.push({
            latitude: coors[i],
            longitude: coors[i + 1]
          })
        }
        //设置polyline属性，将路线显示出来
        _this.setData({
          polyline: [{
            points: pl,
            color: '#20B2AA',
            width: 6
          }]
        })
        wx.hideLoading();
      },
      fail:function(){
        console.log('error......');
      }
    });
  }

});
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyJpbmRleC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOztBQUlBLElBQU0sR0FBRyxHQUFHLE1BQU0sRUFBVSxDQUFBO0FBRTVCLElBQUksQ0FBQztJQUNILElBQUksRUFBRTtRQUNKLEtBQUssRUFBRSxhQUFhO1FBQ3BCLFFBQVEsRUFBRSxFQUFFO1FBQ1osV0FBVyxFQUFFLElBQUk7UUFDakIsT0FBTyxFQUFFLEVBQUUsQ0FBQyxPQUFPLENBQUMsOEJBQThCLENBQUM7S0FDcEQ7SUFFRCxXQUFXO1FBQ1QsRUFBRSxDQUFDLFVBQVUsQ0FBQztZQUNaLEdBQUcsRUFBRSxjQUFjO1NBQ3BCLENBQUMsQ0FBQTtJQUNKLENBQUM7SUFDRCxNQUFNO1FBQU4saUJBMkJDO1FBMUJDLElBQUksR0FBRyxDQUFDLFVBQVUsQ0FBQyxRQUFRLEVBQUU7WUFDM0IsSUFBSSxDQUFDLE9BQVEsQ0FBQztnQkFDWixRQUFRLEVBQUUsR0FBRyxDQUFDLFVBQVUsQ0FBQyxRQUFRO2dCQUNqQyxXQUFXLEVBQUUsSUFBSTthQUNsQixDQUFDLENBQUE7U0FDSDthQUFNLElBQUksSUFBSSxDQUFDLElBQUksQ0FBQyxPQUFPLEVBQUM7WUFHM0IsR0FBRyxDQUFDLHFCQUFxQixHQUFHLFVBQUMsR0FBRztnQkFDOUIsS0FBSSxDQUFDLE9BQVEsQ0FBQztvQkFDWixRQUFRLEVBQUUsR0FBRztvQkFDYixXQUFXLEVBQUUsSUFBSTtpQkFDbEIsQ0FBQyxDQUFBO1lBQ0osQ0FBQyxDQUFBO1NBQ0Y7YUFBTTtZQUVMLEVBQUUsQ0FBQyxXQUFXLENBQUM7Z0JBQ2IsT0FBTyxFQUFFLFVBQUEsR0FBRztvQkFDVixHQUFHLENBQUMsVUFBVSxDQUFDLFFBQVEsR0FBRyxHQUFHLENBQUMsUUFBUSxDQUFBO29CQUN0QyxLQUFJLENBQUMsT0FBUSxDQUFDO3dCQUNaLFFBQVEsRUFBRSxHQUFHLENBQUMsUUFBUTt3QkFDdEIsV0FBVyxFQUFFLElBQUk7cUJBQ2xCLENBQUMsQ0FBQTtnQkFDSixDQUFDO2FBQ0YsQ0FBQyxDQUFBO1NBQ0g7SUFDSCxDQUFDO0lBRUQsV0FBVyxZQUFDLENBQU07UUFDaEIsT0FBTyxDQUFDLEdBQUcsQ0FBQyxDQUFDLENBQUMsQ0FBQTtRQUNkLEdBQUcsQ0FBQyxVQUFVLENBQUMsUUFBUSxHQUFHLENBQUMsQ0FBQyxNQUFNLENBQUMsUUFBUSxDQUFBO1FBQzNDLElBQUksQ0FBQyxPQUFRLENBQUM7WUFDWixRQUFRLEVBQUUsQ0FBQyxDQUFDLE1BQU0sQ0FBQyxRQUFRO1lBQzNCLFdBQVcsRUFBRSxJQUFJO1NBQ2xCLENBQUMsQ0FBQTtJQUNKLENBQUM7Q0FDRixDQUFDLENBQUEiLCJzb3VyY2VzQ29udGVudCI6WyIvL2luZGV4LmpzXG4vL+iOt+WPluW6lOeUqOWunuS+i1xuaW1wb3J0IHsgSU15QXBwIH0gZnJvbSAnLi4vLi4vYXBwJ1xuXG5jb25zdCBhcHAgPSBnZXRBcHA8SU15QXBwPigpXG5cblBhZ2Uoe1xuICBkYXRhOiB7XG4gICAgbW90dG86ICfngrnlh7sg4oCc57yW6K+R4oCdIOS7peaehOW7uicsXG4gICAgdXNlckluZm86IHt9LFxuICAgIGhhc1VzZXJJbmZvOiB0cnVlLFxuICAgIGNhbklVc2U6IHd4LmNhbklVc2UoJ2J1dHRvbi5vcGVuLXR5cGUuZ2V0VXNlckluZm8nKSxcbiAgfSxcbiAgLy/kuovku7blpITnkIblh73mlbBcbiAgYmluZFZpZXdUYXAoKSB7XG4gICAgd3gubmF2aWdhdGVUbyh7XG4gICAgICB1cmw6ICcuLi9sb2dzL2xvZ3MnXG4gICAgfSlcbiAgfSxcbiAgb25Mb2FkKCkge1xuICAgIGlmIChhcHAuZ2xvYmFsRGF0YS51c2VySW5mbykge1xuICAgICAgdGhpcy5zZXREYXRhISh7XG4gICAgICAgIHVzZXJJbmZvOiBhcHAuZ2xvYmFsRGF0YS51c2VySW5mbyxcbiAgICAgICAgaGFzVXNlckluZm86IHRydWUsXG4gICAgICB9KVxuICAgIH0gZWxzZSBpZiAodGhpcy5kYXRhLmNhbklVc2Upe1xuICAgICAgLy8g55Sx5LqOIGdldFVzZXJJbmZvIOaYr+e9kee7nOivt+axgu+8jOWPr+iDveS8muWcqCBQYWdlLm9uTG9hZCDkuYvlkI7miY3ov5Tlm55cbiAgICAgIC8vIOaJgOS7peatpOWkhOWKoOWFpSBjYWxsYmFjayDku6XpmLLmraLov5nnp43mg4XlhrVcbiAgICAgIGFwcC51c2VySW5mb1JlYWR5Q2FsbGJhY2sgPSAocmVzKSA9PiB7XG4gICAgICAgIHRoaXMuc2V0RGF0YSEoe1xuICAgICAgICAgIHVzZXJJbmZvOiByZXMsXG4gICAgICAgICAgaGFzVXNlckluZm86IHRydWVcbiAgICAgICAgfSlcbiAgICAgIH1cbiAgICB9IGVsc2Uge1xuICAgICAgLy8g5Zyo5rKh5pyJIG9wZW4tdHlwZT1nZXRVc2VySW5mbyDniYjmnKznmoTlhbzlrrnlpITnkIZcbiAgICAgIHd4LmdldFVzZXJJbmZvKHtcbiAgICAgICAgc3VjY2VzczogcmVzID0+IHtcbiAgICAgICAgICBhcHAuZ2xvYmFsRGF0YS51c2VySW5mbyA9IHJlcy51c2VySW5mb1xuICAgICAgICAgIHRoaXMuc2V0RGF0YSEoe1xuICAgICAgICAgICAgdXNlckluZm86IHJlcy51c2VySW5mbyxcbiAgICAgICAgICAgIGhhc1VzZXJJbmZvOiB0cnVlXG4gICAgICAgICAgfSlcbiAgICAgICAgfVxuICAgICAgfSlcbiAgICB9XG4gIH0sXG5cbiAgZ2V0VXNlckluZm8oZTogYW55KSB7XG4gICAgY29uc29sZS5sb2coZSlcbiAgICBhcHAuZ2xvYmFsRGF0YS51c2VySW5mbyA9IGUuZGV0YWlsLnVzZXJJbmZvXG4gICAgdGhpcy5zZXREYXRhISh7XG4gICAgICB1c2VySW5mbzogZS5kZXRhaWwudXNlckluZm8sXG4gICAgICBoYXNVc2VySW5mbzogdHJ1ZVxuICAgIH0pXG4gIH1cbn0pXG4iXX0=