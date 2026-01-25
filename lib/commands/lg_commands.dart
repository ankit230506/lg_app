import '../service/lg_service.dart';

class LGCommands {
  static String _x = "http://lg1:81";

    static Future<void> showLogo() async {
    // 1. Create the LOGO kml
await SSHService.execute("""
# 1. Create the KML file pointing to the LOCAL image
echo '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
  <ScreenOverlay>
    <name>LG Logo</name>
    <visibility>1</visibility>
    <Icon>
      <href>$_x/lg_logo.png</href>
    </Icon>
    <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
    <screenXY x="0.05" y="0.95" xunits="fraction" yunits="fraction"/>
    <size x="0.2" y="0.2" xunits="fraction" yunits="fraction"/>
  </ScreenOverlay>
</Document>
</kml>' > /var/www/html/kml/slave_3.kml
""");
   } 
// await SSHService.execute("""
//       echo '$_x/kml/slave_3.kml' > /var/www/html/kmls.txt
//     """);
//   }

  static Future<void> clearLogo() async {
    await SSHService.execute("""
      echo '' > /var/www/html/kmls.txt
      echo '<?xml version="1.0" encoding="UTF-8"?>
      <kml xmlns="http://www.opengis.net/kml/2.2">
        <Document>
        </Document>
      </kml>' > /var/www/html/kmls.txt
    """);
  }

  static Future<void> show3DPyramid() async {
    await SSHService.execute("""
echo '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
  <name>3D Multi-Color Pyramid - Eiffel Tower</name>

  <Style id="red"><PolyStyle><color>7d0000ff</color></PolyStyle></Style>
  <Style id="green"><PolyStyle><color>7d00ff00</color></PolyStyle></Style>
  <Style id="blue"><PolyStyle><color>7dff0000</color></PolyStyle></Style>
  <Style id="yellow"><PolyStyle><color>7d00ffff</color></PolyStyle></Style>

  <!-- Red face -->
  <Placemark>
    <styleUrl>#red</styleUrl>
    <Polygon>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs><LinearRing>
        <coordinates>
          2.2943,48.8583,0
          2.2947,48.8583,0
          2.2945,48.8586,200
          2.2943,48.8583,0
        </coordinates>
      </LinearRing></outerBoundaryIs>
    </Polygon>
  </Placemark>

  <!-- Green face -->
  <Placemark>
    <styleUrl>#green</styleUrl>
    <Polygon>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs><LinearRing>
        <coordinates>
          2.2947,48.8583,0
          2.2947,48.8585,0
          2.2945,48.8586,200
          2.2947,48.8583,0
        </coordinates>
      </LinearRing></outerBoundaryIs>
    </Polygon>
  </Placemark>

  <!-- Blue face -->
  <Placemark>
    <styleUrl>#blue</styleUrl>
    <Polygon>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs><LinearRing>
        <coordinates>
          2.2947,48.8585,0
          2.2943,48.8585,0
          2.2945,48.8586,200
          2.2947,48.8585,0
        </coordinates>
      </LinearRing></outerBoundaryIs>
    </Polygon>
  </Placemark>

  <!-- Yellow face -->
  <Placemark>
    <styleUrl>#yellow</styleUrl>
    <Polygon>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs><LinearRing>
        <coordinates>
          2.2943,48.8585,0
          2.2943,48.8583,0
          2.2945,48.8586,200
          2.2943,48.8585,0
        </coordinates>
      </LinearRing></outerBoundaryIs>
    </Polygon>
  </Placemark>

</Document>
</kml>' > /var/www/html/kml/pyramid.kml

echo "$_x/kml/pyramid.kml" > /var/www/html/kmls.txt
""");

    // await Future.delayed(const Duration(seconds: 2));
    await LGCommands.flyToPyramid();
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
      echo "flytoview=<LookAt><longitude>73.7191</longitude><latitude>21.8380</latitude><altitude>0</altitude><heading>0</heading><tilt>60</tilt><range>300</range><altitudeMode>relativeToGround</altitudeMode></LookAt>" > /tmp/query.txt
    """);
  }

  static Future<void> flyToPyramid() async {
  await SSHService.execute("""
    echo "flytoview=<LookAt><longitude>2.2945</longitude><latitude>48.85845</latitude><altitude>0</altitude><heading>210</heading><tilt>45</tilt><range>800</range><altitudeMode>relativeToGround</altitudeMode></LookAt>" > /tmp/query.txt
  """);
}



}