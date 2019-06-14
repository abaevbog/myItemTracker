/*import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart' as mp;
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationInput extends StatefulWidget {
  Function setAddress;
  LocationInput(this.setAddress);

  @override
  State<StatefulWidget> createState() {
    return LocationInputState();
  }
}

class Location{
  String address;
  double lon;
  double lat;
  Location({this.address,this.lat,this.lon});

  bool valid(){
    return address != null && lon != null && lat != null;
  }
}

class LocationInputState extends State<LocationInput> {
  final FocusNode _addressFocusNode = FocusNode();
  final Location location = Location();
  Uri staticUri;
  final TextEditingController _addressController = TextEditingController();
  @override
  void initState() {
    _addressFocusNode.addListener(updateLocation);
    super.initState();
  }

  @override
  void dispose() {
    _addressFocusNode.removeListener(updateLocation);
    super.dispose();
  }

  void updateLocation() {
    if (!_addressFocusNode.hasFocus) {
      getStaticMap(_addressController.text);
    }
  }

  void getStaticMap(String address) async {
    if (address.trim().isEmpty ) {
      setState(() {
        staticUri = null;
      });
      return;
    }
    final Uri uri = Uri.https('maps.googleapis.com', '/maps/api/geocode/json',
        {'address': address, 'key': 'AIzaSyDPb2UAobTAt-QQKQeXLz7a4FGysq4eR4o'});
    final http.Response response = await http.get(uri);
    final decoded = json.decode(response.body);
    final addres = decoded['results'][0]['formatted_address'];
    final coord = decoded['results'][0]['geometry']['location'];
    location..address = addres
            ..lat = coord['lat']
            ..lon = coord['lng'];
    final mp.StaticMapProvider mapProvider =
        mp.StaticMapProvider('AIzaSyDPb2UAobTAt-QQKQeXLz7a4FGysq4eR4o');
    final Uri mapUri = mapProvider.getStaticUriWithMarkers(
        [mp.Marker('position', 'Position', coord['lat'], coord['lng'])],
        center: mp.Location(coord['lat'], coord['lng']),
        width: 500,
        height: 300,
        maptype: mp.StaticMapViewType.roadmap);
    setState(() {
      _addressController.text = addres;
      staticUri = mapUri;
      widget.setAddress(address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _addressFocusNode,
          controller: _addressController,
          decoration: InputDecoration(labelText: "Address"),
          validator: (String input){
            return location.valid()? null: "There's no way this address is valid";  
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        staticUri != null
            ? Image.network(staticUri.toString())
            : SizedBox(height: 0, width: 0),
      ],
    );
  }
}*/
