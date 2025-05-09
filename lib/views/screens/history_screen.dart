import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/common/constants/string_constants.dart';
import 'package:study_buddy/common/global/global.dart';

import '../../common/services/file_downloader.dart';
import '../../common/utils/utility_methods.dart';
import '../../controllers/data_controller.dart';
import '../widgets/no_data.dart';
import 'file_viewer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final key = "history";

  var allData = [];

  List<MyDownloader> myDownloaderList = [];

  var dataController = Get.put(DataController());

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() {
    // allData = [
    //   ...documents.where((content) =>
    //       sharedPreferences!.containsKey(key) &&
    //       sharedPreferences!.getStringList(key)!.contains(content['link']!)),
    //   ...images.where((content) =>
    //       sharedPreferences!.containsKey(key) &&
    //       sharedPreferences!.getStringList(key)!.contains(content['link']!)),
    //   ...videos.where((content) =>
    //       sharedPreferences!.containsKey(key) &&
    //       sharedPreferences!.getStringList(key)!.contains(content['link']!)),
    // ];

    var _data = dataController.contentModel.value.data!.map((e) {
      return {
        "name": e.question,
        "link": UtilityMethods.getProperFileUrl(e.image ?? "")
      };
    }).toList();

    _data = _data.where((content) => content['link'] != null).toList();

    allData = [
      ..._data.where((content) =>
          sharedPreferences!.containsKey(key) &&
          sharedPreferences!.getStringList(key)!.contains(content['link']!)),
    ];

    myDownloaderList = List.generate(allData.length, (index) => MyDownloader());
  }

  Future<void> deleteAll() async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            StringConstants.confirm,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          content: const Text(StringConstants.doYouWantToDeleteCompleteHistory),
          actions: <Widget>[
            TextButton(
              child: const Text(
                StringConstants.no,
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                StringConstants.yes,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await sharedPreferences!.remove(key);
                setState(() {
                  loadData();
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text(
          StringConstants.history,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (allData.isNotEmpty)
            IconButton(
              onPressed: () {
                deleteAll();
              },
              icon: const Icon(Icons.delete_forever),
            ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Visibility(
        visible: allData.isNotEmpty,
        replacement: const NoData(),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          itemCount: allData.length,
          itemBuilder: (_, index) {
            return Obx(
              () {
                String name = allData[index]['name']!;
                String url = allData[index]['link']!;
                return Card(
                  elevation: 5.0,
                  child: ListTile(
                    onTap: () async {
                      if (myDownloaderList[index].isDownloaded(url)) {
                        String filePath = await myDownloaderList[index]
                            .getDownloadedFilePath(url);
                        Get.to(() => FileViewer(filePath: filePath));
                      } else {
                        Get.to(() => FileViewer(filePath: url));
                      }
                    },
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black87),
                      ),
                      child: url.toLowerCase().endsWith("jpg") ||
                              url.toLowerCase().endsWith("jpeg")
                          ? const Icon(Icons.photo_library)
                          : url.toLowerCase().endsWith("mp4") ||
                                  url.toLowerCase().endsWith("mpeg4")
                              ? const Icon(Icons.video_collection)
                              : const Icon(Icons.picture_as_pdf),
                    ),
                    title: Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      url,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (myDownloaderList[index].status.value ==
                                "downloading" ||
                            myDownloaderList[index].isDownloading(url)) {
                          myDownloaderList[index].cancelDownload(url);
                        } else if (!myDownloaderList[index].isDownloaded(url)) {
                          myDownloaderList[index].download(url, name);
                        } else if (myDownloaderList[index].status.value ==
                                "completed" ||
                            myDownloaderList[index].isDownloaded(url)) {
                          myDownloaderList[index].deleteDownload(url);
                        }
                      },
                      icon: myDownloaderList[index].status.value ==
                                  "downloading" ||
                              myDownloaderList[index].isDownloading(url)
                          ? FittedBox(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.downloading,
                                    color: Colors.green,
                                  ),
                                  if (myDownloaderList[index].progress > 0)
                                    Text(
                                      "${myDownloaderList[index].progress.floor()}%",
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  else
                                    const Text(
                                      StringConstants.downloading,
                                      style: TextStyle(
                                        fontSize: 5.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                ],
                              ),
                            )
                          : myDownloaderList[index].status.value ==
                                      "downloaded" ||
                                  myDownloaderList[index].isDownloaded(url)
                              ? const FittedBox(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        StringConstants.deleteDownload,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 6.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const FittedBox(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.download,
                                        color: Colors.lightBlue,
                                      ),
                                      Text(
                                        StringConstants.download,
                                        style: TextStyle(
                                          fontSize: 6.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
