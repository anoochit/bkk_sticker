import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = 'กรุงเทพฯ · Bangkok';

  TextEditingController textEditingController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    textEditingController.text = text;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BKK Sticker',
          style: TextStyle(
            fontFamily: 'SaoChingcha',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00744B),
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // text
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'SaoChingcha',
                  ),
                  decoration: const InputDecoration(
                    hintText: 'ใส่ข้อความ...',
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      text = value;
                    });
                  },
                ),
              ),

              const Gap(16.0),

              // image
              Screenshot(
                controller: screenshotController,
                child: Stack(
                  children: [
                    // image
                    Image.asset('assets/images/bg.jpg'),
                    // text
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.65,
                          alignment: Alignment.center,
                          child: Text(
                            text,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontFamily: 'SaoChingcha',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(16.0),

              // buttons
              FilledButton(
                style: ButtonStyle(
                  textStyle: const WidgetStatePropertyAll(
                    TextStyle(fontFamily: 'SaoChingcha'),
                  ),
                  foregroundColor: const WidgetStatePropertyAll(
                    Colors.white,
                  ),
                  backgroundColor: const WidgetStatePropertyAll(
                    Colors.blue,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(
                        12.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  try {
                    // export
                    final image = await screenshotController.capture(
                      pixelRatio: 2.0,
                      delay: const Duration(milliseconds: 300),
                    );
                    // save to gallery
                    if (image != null) {
                      final filename =
                          'bkk_sticker_${DateTime.now().microsecondsSinceEpoch}.png';
                      await ImageGallerySaver.saveImage(
                        image,
                        name: filename,
                      );
                    }
                    // show message
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text('บันทึกไฟล์ลงแกลเลอรี่เรียบร้อยแล้ว'),
                      ),
                    );
                  } catch (e) {
                    // show error message
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text('ไม่สามารถบันทึกภาพได้'),
                      ),
                    );
                  }
                },
                child: const Text('เซฟภาพ'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
