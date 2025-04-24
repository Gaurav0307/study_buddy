import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/common/constants/string_constants.dart';
import 'package:study_buddy/common/utils/utility_methods.dart';

import '../../common/services/file_downloader.dart';
import '../../controllers/data_controller.dart';
import 'file_viewer.dart';

class ContentListScreen extends StatefulWidget {
  final String branchName;
  final String year;
  final String content;
  const ContentListScreen(
      {super.key,
      required this.branchName,
      required this.year,
      required this.content});

  @override
  State<ContentListScreen> createState() => _ContentListScreenState();
}

class _ContentListScreenState extends State<ContentListScreen> {
  var allData = [];

  List<MyDownloader> myDownloaderList = [];

  var dataController = Get.put(DataController());

  @override
  void initState() {
    if (widget.content == StringConstants.notes ||
        widget.content == StringConstants.questionPapers ||
        widget.content == StringConstants.subjects ||
        widget.content == StringConstants.syllabus) {
      // allData = [...documents, ...images];

      allData = [
        ...dataController.contentModel.value.data!.map((e) {
          if (e.questionType == "image" || e.questionType == "pdf") {
            return {
              "name": e.question,
              "link": UtilityMethods.getProperFileUrl(e.image ?? "")
            };
          }
        })
      ];
    } else {
      // allData = [...videos];

      allData = [
        ...dataController.contentModel.value.data!.map((e) {
          if (e.questionType == "video") {
            return {
              "name": e.question,
              "link": UtilityMethods.getProperFileUrl(e.image ?? "")
            };
          }
        })
      ];
    }

    allData = allData.where((content) => content != null).toList();

    myDownloaderList = List.generate(allData.length, (index) => MyDownloader());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: ListTile(
          title: Text(
            widget.branchName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            "${widget.year} (${widget.content})",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: ListView.builder(
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
                    icon:
                        myDownloaderList[index].status.value == "downloading" ||
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
    );
  }
}
