import '../service/lg_service.dart';

class LGCommands {
  /// 1️⃣ SHOW LG LOGO (on left screen)
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

echo "http://lg1:81/kml/slave_3.kml" > /tmp/query.txt
""");
  }

  /// 2️⃣ SHOW 3D COLORED PYRAMID
 static Future<void> show3DPyramid() async {
  await SSHService.execute("""
echo '
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
  <name>3D Multi-Color Pyramid</name>

  <!-- Styles -->
  <Style id="red">
    <PolyStyle><color>7d0000ff</color></PolyStyle>
  </Style>
  <Style id="green">
    <PolyStyle><color>7d00ff00</color></PolyStyle>
  </Style>
  <Style id="blue">
    <PolyStyle><color>7dff0000</color></PolyStyle>
  </Style>
  <Style id="yellow">
    <PolyStyle><color>7d00ffff</color></PolyStyle>
  </Style>

  <!-- Side 1 -->
  <Placemark>
    <styleUrl>#red</styleUrl>
    <Polygon>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
          <coordinates>
            77.0264,28.4593,0
            77.0268,28.4593,0
            77.0266,28.4595,200
            77.0264,28.4593,0
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>

  <!-- Side 2 -->
  <Placemark>
    <styleUrl>#green</styleUrl>
    <Polygon>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
          <coordinates>
            77.0268,28.4593,0
            77.0268,28.4597,0
            77.0266,28.4595,200
            77.0268,28.4593,0
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>

  <!-- Side 3 -->
  <Placemark>
    <styleUrl>#blue</styleUrl>
    <Polygon>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
          <coordinates>
            77.0268,28.4597,0
            77.0264,28.4597,0
            77.0266,28.4595,200
            77.0268,28.4597,0
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>

  <!-- Side 4 -->
  <Placemark>
    <styleUrl>#yellow</styleUrl>
    <Polygon>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
          <coordinates>
            77.0264,28.4597,0
            77.0264,28.4593,0
            77.0266,28.4595,200
            77.0264,28.4597,0
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>

</Document>
</kml>
' > /var/www/html/kml/pyramid.kml

echo "http://lg1:81/kml/pyramid.kml" > /tmp/query.txt
""");
}


  /// 3️⃣ FLY TO HOME CITY (Gurgaon, India)
  /// Change the coordinates below to your home city
  static Future<void> flyToHomeCity() async {
    await SSHService.execute("""
echo 'flytoview=<LookAt><longitude>77.0266</longitude><latitude>28.4595</latitude><altitude>0</altitude><heading>0</heading><tilt>45</tilt><range>300</range><altitudeMode>relativeToGround</altitudeMode></LookAt>' > /tmp/query.txt""");
  }

  /// 4️⃣ CLEAR LOGO
  static Future<void> clearLogo() async {
    await SSHService.execute("""
echo '' > /var/www/html/kml/slave_3.kml
echo '' > /tmp/query.txt
""");
  }

  /// 5️⃣ CLEAR KML (Pyramid and other KML objects)
  static Future<void> clearKml() async {
    await SSHService.execute("""
echo '' > /var/www/html/kml/pyramid.kml
echo '' > /tmp/query.txt
""");
  }
}