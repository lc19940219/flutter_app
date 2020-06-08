class ProductContentModel {
  ProductContentItem result;

  ProductContentModel({this.result});

  ProductContentModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? new ProductContentItem.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class ProductContentItem {
  String sId;
  String title;
  String cid;
  Object price;
  String oldPrice;
  Object isBest;
  Object isHot;
  Object isNew;
  String status;
  String pic;
  String content;
  String cname;
  List<Attr> attr;
  String subTitle;
  Object salecount;
  String selectValue;
  bool checked;
  int count;

  ProductContentItem(
      {this.sId,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.isBest,
      this.isHot,
      this.isNew,
      this.attr,
      this.status,
      this.pic,
      this.content,
      this.cname,
      this.subTitle,
      this.salecount,
      this.selectValue,
      this.count,
      this.checked});

  ProductContentItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    isBest = json['is_best'];
    isHot = json['is_hot'];
    isNew = json['is_new'];
    if (json['attr'] != null) {
      attr = new List<Attr>();
      json['attr'].forEach((v) {
        attr.add(new Attr.fromJson(v));
      });
    }
    status = json['status'];
    pic = json['pic'];
    content = json['content'];
    cname = json['cname'];
    subTitle = json['sub_title'];
    salecount = json['salecount'];
    selectValue = "";
    count = 1;
    checked = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['is_best'] = this.isBest;
    data['is_hot'] = this.isHot;
    data['is_new'] = this.isNew;
    if (this.attr != null) {
      data['attr'] = this.attr.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['content'] = this.content;
    data['cname'] = this.cname;
    data['sub_title'] = this.subTitle;
    data['salecount'] = this.salecount;
    data['selectValue'] = this.selectValue;
    data['count'] = this.count;
    data['checked'] = this.checked;
    return data;
  }
}

class Attr {
  String cate;
  List<String> list;
  List<Map> attrList;

  Attr({this.cate, this.list});

  Attr.fromJson(Map<String, dynamic> json) {
    cate = json['cate'];
    list = json['list'].cast<String>();
    attrList = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cate'] = this.cate;
    data['list'] = this.list;

    return data;
  }
}
