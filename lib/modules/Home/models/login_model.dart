///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class LoginModelData {
/*
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjE0LCJlbWFpbCI6InJvbWlsbWF2YW5pMzE4QGdtYWlsLmNvbSIsImlzVXNlclZlcmlmaWVkIjpmYWxzZSwidXNlcm5hbWUiOiJyb21pbCIsImlhdCI6MTY5NjQwMjE1MywiZXhwIjoxNjk2NDAzMDUzfQ.ldFYnzCKMeviWyT2e96MBJOCov_oX5HokSrfGM-fBlA",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjE0LCJlbWFpbCI6InJvbWlsbWF2YW5pMzE4QGdtYWlsLmNvbSIsImlzVXNlclZlcmlmaWVkIjpmYWxzZSwidXNlcm5hbWUiOiJyb21pbCIsImlhdCI6MTY5NjQwMjE1MywiZXhwIjoxNjk3MDA2OTUzfQ.yaRzyjQa4SHm9aKL4HJh2Qg06EHTZSxk-9DtjBLoRe0"
}
*/

  String? accessToken;
  String? refreshToken;

  LoginModelData({
    this.accessToken,
    this.refreshToken,
  });
  LoginModelData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token']?.toString();
    refreshToken = json['refresh_token']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}

class LoginModel {
/*
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjE0LCJlbWFpbCI6InJvbWlsbWF2YW5pMzE4QGdtYWlsLmNvbSIsImlzVXNlclZlcmlmaWVkIjpmYWxzZSwidXNlcm5hbWUiOiJyb21pbCIsImlhdCI6MTY5NjQwMjE1MywiZXhwIjoxNjk2NDAzMDUzfQ.ldFYnzCKMeviWyT2e96MBJOCov_oX5HokSrfGM-fBlA",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjE0LCJlbWFpbCI6InJvbWlsbWF2YW5pMzE4QGdtYWlsLmNvbSIsImlzVXNlclZlcmlmaWVkIjpmYWxzZSwidXNlcm5hbWUiOiJyb21pbCIsImlhdCI6MTY5NjQwMjE1MywiZXhwIjoxNjk3MDA2OTUzfQ.yaRzyjQa4SHm9aKL4HJh2Qg06EHTZSxk-9DtjBLoRe0"
  }
}
*/

  bool? success;
  LoginModelData? data;

  LoginModel({
    this.success,
    this.data,
  });
  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] != null) ? LoginModelData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
