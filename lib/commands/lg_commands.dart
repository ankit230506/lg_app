import '../service/lg_service.dart';

class LGCommands {
   static String _x = "http://lg1:81";
static Future<void> showLogo() async {
    await SSHService.execute("""
echo '
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <ScreenOverlay>
      <name>LG Logo</name>
      <Icon>
        <href>https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgXmdNgBTXup6bdWew5RzgCmC9pPb7rK487CpiscWB2S8OlhwFHmeeACHIIjx4B5-Iv-t95mNUx0JhB_oATG3-Tq1gs8Uj0-Xb9Njye6rHtKKsnJQJlzZqJxMDnj_2TXX3eA5x6VSgc8aw/s320-rw/LOGO+LIQUID+GALAXY-sq1000-+OKnoline.png</href>
      </Icon>
      <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
      <screenXY x="0.05" y="0.95" xunits="fraction" yunits="fraction"/>
      <size x="0.2" y="0.2" xunits="fraction" yunits="fraction"/>
    </ScreenOverlay>
  </Document>
</kml>
' > /var/www/html/kml/slave_3.kml
echo "$_x/kml/slave_3.kml" > /tmp/query.txt
""");
  }

  static Future<void> clearLogo() async {
    await SSHService.execute("""
echo '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
  </Document>
</kml>' > /var/www/html/kml/slave_3.kml
""");
  }
  static Future<void> show3DPyramid() async {
    await SSHService.execute("""
echo '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
  <name>3D Multi-Color Pyramid</name>
  <Style id="red"><PolyStyle><color>7d0000ff</color></PolyStyle></Style>
  <Style id="green"><PolyStyle><color>7d00ff00</color></PolyStyle></Style>
  <Style id="blue"><PolyStyle><color>7dff0000</color></PolyStyle></Style>
  <Style id="yellow"><PolyStyle><color>7d00ffff</color></PolyStyle></Style>

  <Placemark><styleUrl>#red</styleUrl><Polygon><altitudeMode>relativeToGround</altitudeMode><outerBoundaryIs><LinearRing><coordinates>77.0264,28.4593,0 77.0268,28.4593,0 77.0266,28.4595,200 77.0264,28.4593,0</coordinates></LinearRing></outerBoundaryIs></Polygon></Placemark>
  <Placemark><styleUrl>#green</styleUrl><Polygon><altitudeMode>relativeToGround</altitudeMode><outerBoundaryIs><LinearRing><coordinates>77.0268,28.4593,0 77.0268,28.4597,0 77.0266,28.4595,200 77.0268,28.4593,0</coordinates></LinearRing></outerBoundaryIs></Polygon></Placemark>
  <Placemark><styleUrl>#blue</styleUrl><Polygon><altitudeMode>relativeToGround</altitudeMode><outerBoundaryIs><LinearRing><coordinates>77.0268,28.4597,0 77.0264,28.4597,0 77.0266,28.4595,200 77.0268,28.4597,0</coordinates></LinearRing></outerBoundaryIs></Polygon></Placemark>
  <Placemark><styleUrl>#yellow</styleUrl><Polygon><altitudeMode>relativeToGround</altitudeMode><outerBoundaryIs><LinearRing><coordinates>77.0264,28.4597,0 77.0264,28.4593,0 77.0266,28.4595,200 77.0264,28.4597,0</coordinates></LinearRing></outerBoundaryIs></Polygon></Placemark>
</Document>
</kml>' > /var/www/html/kml/pyramid.kml

echo "$_x/kml/pyramid.kml" > /var/www/html/kmls.txt
""");

    
    await Future.delayed(const Duration(seconds: 2));
    await flyToHomeCity();
  }

  
  static Future<void> clearKml() async {
    await SSHService.execute("""
echo '' > /var/www/html/kmls.txt
echo '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
  </Document>
</kml>' > /var/www/html/kml/pyramid.kml
""");
  }

  static Future<void> flyToHomeCity() async {
    await SSHService.execute("""
echo "flytoview=<LookAt><longitude>77.0266</longitude><latitude>28.4595</latitude><altitude>0</altitude><heading>0</heading><tilt>45</tilt><range>300</range><altitudeMode>relativeToGround</altitudeMode></LookAt>" > /tmp/query.txt
""");
  }
}