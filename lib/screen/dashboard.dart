import 'package:cbr_android/api/bapok.dart';
import 'package:cbr_android/screen/about.dart';
import 'package:cbr_android/screen/setting.dart';
import 'package:cbr_android/screen/tambah.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  var dataVersion;
  var dataNama;
  var dataUsername;
  var dataCiri;
  var dataToday;
  var dataHasil;
  var dataCiriSaya;
  var dataTinggi;
  var idciri;

  Future _dataUser() async {
    var response = await PostDataService().dataUserService();
    print(response);
    setState(() {
      dataUsername = response['username'];
      dataNama = response['nama'];
      dataCiriSaya = response['cirisaya'];
      dataHasil = response['hasil'];
      dataCiri = response['ciri'];
    });
  }

  Future _deleteCiri() async {
    var response = await PostDataService().deleteService(idciri.toString());
    if (response == true) {
      _dataUser();
      Get.defaultDialog(
        title: 'Berhasil di hapus',
        content: Container(),
        textCancel: 'Exit',
      );
    } else {
      Get.defaultDialog(
        title: 'sudah di hapus',
        content: Container(),
        textCancel: 'Exit',
      );
    }
  }

  void initState() {
    _dataUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DateFormat.jm().format(DateTime.now());

    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.question_mark,
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(() => about(), transition: Transition.rightToLeft);
            },
          ),
          title: Padding(
            padding: EdgeInsets.only(
              left: screenWidth <= 321 ? screenWidth * 0.01 : screenWidth * 0.2,
            ),
            child: Row(
              children: [
                Text(
                  'Test Kepribadian',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _dataUser();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(() => setting(), transition: Transition.rightToLeft);
                  },
                )
              ],
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  radius: 25,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            dataNama == null ? '...' : 'Hi, ' + dataNama,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.purple[500]!),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              dataUsername == null
                                  ? '...'
                                  : 'Nama user : ' + dataUsername,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[500],
                                  fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        dataToday == null
                            ? 'Tanggal : 12-12-2003'
                            : dataToday['tanggal'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'SELAMAT DATANG DI APLIKASI TEST KEPRIBADIAN METODE CASE BASED REASONING (CBR). SILAHKAN TAMBAH SIFAT ANDA DI BAWAH INI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Container(
              child: ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => tambah(), transition: Transition.rightToLeft);
                  },
                  icon: Icon(Icons.add),
                  label: Text("Tambah Ciri"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: Colors.deepPurple)),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: ElevatedButton.icon(
                  onPressed: () {
                    print('tambah');
                  },
                  icon: Icon(Icons.refresh_outlined),
                  label: Text("Check Hasil Kepribadian"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: Colors.deepPurple)),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ciri-Ciri Sifat :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Card(
                      child: ListTile(
                        title: Text(dataCiriSaya[index]['nama']),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              idciri = dataCiriSaya[index]['id'];
                            });

                            _deleteCiri();
                          },
                          child: Icon(Icons.delete_forever_sharp),
                        ),
                      ),
                      elevation: 2,
                    ),
                  );
                },
                itemCount: dataCiriSaya == null ? 0 : dataCiriSaya.length,
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: Text(
                'Hasil Kepribadian:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                dataHasil == null ? '-' : dataHasil,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Text(
            //     'Riwayat Presensi',
            //     style: TextStyle(
            //         color: Colors.grey[800], fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Container(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Card(
            //         child: ListTile(
            //           leading: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 dataPresensi[index]['tanggal'],
            //                 textAlign: TextAlign.center,
            //               ),
            //             ],
            //           ),
            //           title: Row(
            //             children: [
            //               SizedBox(
            //                 width: screenWidth <= 320
            //                     ? screenWidth * 0.01
            //                     : screenWidth * 0.1,
            //               ),
            //               Column(
            //                 children: [
            //                   Text(
            //                     dataPresensi[index]['jam_masuk'],
            //                     style: TextStyle(
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Text(
            //                     "MASUK",
            //                     style: TextStyle(fontSize: 12),
            //                   )
            //                 ],
            //               ),
            //               SizedBox(
            //                 width: 20,
            //               ),
            //               Column(
            //                 children: [
            //                   Text(
            //                     dataPresensi[index]['jam_pulang'],
            //                     style: TextStyle(
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Text(
            //                     "PULANG",
            //                     style: TextStyle(fontSize: 12),
            //                   )
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //     itemCount: dataPresensi == null ? 0 : dataPresensi.length,
            //   ),
            // ),
            // SizedBox(
            //   height: 70,
            // )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     _presensi();
      //   },
      //   label: const Text("Presensi"),
      //   icon: Icon(Icons.fingerprint),
      // ),
    );
  }
}
