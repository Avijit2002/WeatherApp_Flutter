import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  Network(this.url);
  late Uri url;
  late http.Response response;
  Future api() async{
    response = await http.get(url);
    if(response.statusCode == 200)
    {
      //String data = response.body;
      //var decodeddata = jsonDecode(data);
      //print(response.body);
      return jsonDecode(response.body);

      //var temp = data['main']['temp'];
      //var id = data['weather'][0]['id'];
      //var city = data['name'];

      //print(temp);
      //print(city);
    }
    else{
      print(response.statusCode);
    }
    //api();
  }
}
