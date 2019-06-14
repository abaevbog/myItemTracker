import 'package:flutter/material.dart';
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
      getLocation(_addressController.text);
    }
  }

  void getLocation(String address) async {
    if (address.trim().isEmpty ) {
      setState(() {
        address = null;
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
    setState(() {
      print("Received $addres");
      _addressController.text = addres;
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
}
