import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'movie_detail.dart';

Dio dio = Dio();

class ComingSoon extends StatefulWidget {
  final String mt;
  ComingSoon({Key key, @required this.mt}): super(key:key);

  @override
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  //默认显示第一页的数据
  int page = 1;
  //每页显示的数据条数
  int pageSize = 10;
  var mList = [];
  //总数据条数,实现分页的效果
  int total = 0;


  getMovieList() async{
    int offSet = pageSize * (page -1);
    var response =  await dio.get('http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}?start=$offSet&count=$pageSize');
    var result = response.data;
    setState(() {
      //通过dio返回的数据,必须使用[]来访问
      mList = result['subjects'];
      total = result['count'];
    });
  }

  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mList.length,
      itemBuilder: (BuildContext context,int index) {
        var mitem = mList[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return MovieDetail(id: mitem['id'], title: mitem['title']);
            }));
          },
          child: Container(
              height: 200,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(color: Colors.black87))),
              child: Row(
                children: <Widget>[
                  Image.network(mitem['images']['small'],fit: BoxFit.cover,width: 130,height: 180),
                  Expanded(
                    child: Container(
                      height: 200,
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('电影名称: ${mitem['title']}'),
                          Text('上映年份: ${mitem['year']}'),
                          Text('电影类型: ${mitem['genres'].join(' ')}'),
                          Text('豆瓣评分: ${mitem['rating']['average']}'),
//                          Text('111'),
                          Container(
                            height: 40,
                            child: Row(
                              children: <Widget>[
                                Text('演员列表:'),
                                ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(left: 4),
                                  separatorBuilder: (BuildContext context, int index) =>
                                      VerticalDivider(
                                        width: 4,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mitem['casts'].length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return CircleAvatar(
                                        backgroundImage: NetworkImage('${mitem['casts'][index]['avatars']['small']}')
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
        );
      },
    );
  }
}
