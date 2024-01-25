import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seller/style/gaps.dart';
import 'package:seller/utils/route_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller/utils/image_utils.dart';
import 'package:seller/views/store/store_provider.dart';
import 'package:provider/provider.dart';
import 'package:seller/widgets/click_item.dart';

class StoreThemeImage extends StatefulWidget {
  @override
  _StoreThemeImageState createState() => _StoreThemeImageState();
}

class _StoreThemeImageState extends State<StoreThemeImage> {
  List<String> _imageList = [
    'https://img.aqsea.com/iBuyBuy/seller/shop_bg/shop_bg01.png',
    'https://img.aqsea.com/iBuyBuy/seller/shop_bg/shop_bg02.png',
    'https://img.aqsea.com/iBuyBuy/seller/shop_bg/shop_bg03.png',
    'https://img.aqsea.com/iBuyBuy/seller/shop_bg/shop_bg04.png',
    'https://img.aqsea.com/iBuyBuy/seller/shop_bg/shop_bg05.png',
    'https://img.aqsea.com/iBuyBuy/seller/shop_bg/shop_bg06.png',
  ];
  File _imageFile;

  void _getImage() async {
    try{
      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
      _upLoadImage(_imageFile);
    } catch(e) {

    }
  }
  takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _upLoadImage(image);
  }

  /// 上传图片
  _upLoadImage(File image) async {
    var images = await ImageUtils.uploadImage(image);
    print(images);
    setState(() {
    //  _userImage =  imags;
    });
  }

  backImage(url) async {
    print(url);
    Provider.of<StoreProvider>(context).setImage(url);
    RouteUtil.goBack(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          backgroundColor: Color(0xFFF7F7F7),
          appBar: AppBar(
            title: Text('设置店铺封面'),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ClickItemAvater(
                      label: '从手机相册选择',
                      value: '',
                      type: 'avatar',
                      showLine: true,
                      borderRadius: 6.0,
                      width: 100.0,
                      onPressed: () {
                        _getImage();
                      },
                    ),
                    ClickItem(
                      label: '拍一张',
                      value: '',
                      showLine: false,
                      onPressed: takePhoto
                    ),
                    Gaps.vGap10,
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 20.0),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: Text('从精选图库中选择', style: TextStyle(color: Color(0xFF787878), fontSize: 13)),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8
                            ),
                            itemCount: _imageList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  backImage(_imageList[index]);
                                },
                                child: Container(

                                  child: Image.network(_imageList[index], fit: BoxFit.fitHeight),
                                ),
                              );
                            }
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        );
      },
    );
  }
}