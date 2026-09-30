import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../utils/app_colors.dart';
import '../file_model.dart';

class FileViewerScreen extends StatefulWidget {
  final StoredFile file;
  const FileViewerScreen({super.key, required this.file});

  @override
  State<FileViewerScreen> createState() => _FileViewerScreenState();
}

class _FileViewerScreenState extends State<FileViewerScreen> {
  VideoPlayerController? _videoCtrl;
  bool _videoReady = false;
  String? _videoError;

  @override
  void initState() {
    super.initState();
    if (widget.file.kind == FileKind.video) {
      _initVideo();
    }
  }

  Future<void> _initVideo() async {
    try {
      final file = widget.file;

      // الحالة 1: base64 (الويب)
      if (file.isBase64 && file.storedPath != null) {
        final bytes = base64Decode(file.storedPath!);

        // اكتب في ملف مؤقت ثم شغّل
        final tempDir = Directory.systemTemp;
        final tempFile =
            File('${tempDir.path}/${file.name}');
        await tempFile.writeAsBytes(bytes);

        _videoCtrl = VideoPlayerController.file(tempFile);
      }
      // الحالة 2: ملف محلي (الهاتف)
      else if (!kIsWeb && file.storedPath != null) {
        final f = File(file.storedPath!);
        if (!await f.exists()) {
          setState(() => _videoError = 'الملف غير موجود');
          return;
        }
        _videoCtrl = VideoPlayerController.file(f);
      } else {
        setState(() => _videoError = 'لا يمكن فتح الفيديو');
        return;
      }

      await _videoCtrl!.initialize();
      _videoCtrl!.setLooping(true);
      if (mounted) {
        setState(() => _videoReady = true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _videoError = 'تعذّر تشغيل الفيديو');
      }
      debugPrint('Video error: $e');
    }
  }

  @override
  void dispose() {
    _videoCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.file.name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (widget.file.kind) {
      case FileKind.image:
        return _buildImageViewer();
      case FileKind.video:
        return _buildVideoPlayer();
      case FileKind.audio:
        return _buildAudioInfo();
      default:
        return _buildFileInfo();
    }
  }

  // ═══════════════════════════════════════════════════
  //  🎬 عارض الفيديو
  // ═══════════════════════════════════════════════════
  Widget _buildVideoPlayer() {
    if (_videoError != null) {
      return _buildError(_videoError!);
    }

    if (!_videoReady || _videoCtrl == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: _videoCtrl!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_videoCtrl!),
                  _buildVideoControls(),
                ],
              ),
            ),
          ),
        ),
        _buildVideoProgressBar(),
      ],
    );
  }

  Widget _buildVideoControls() {
    final v = _videoCtrl!.value;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (v.isPlaying) {
            _videoCtrl!.pause();
          } else {
            _videoCtrl!.play();
          }
        });
      },
      child: AnimatedOpacity(
        opacity: v.isPlaying ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          color: Colors.black38,
          child: const Center(
            child: Icon(
              Icons.play_circle_filled_rounded,
              color: Colors.white,
              size: 72,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoProgressBar() {
    final v = _videoCtrl!.value;
    final pos = v.position;
    final dur = v.duration;

    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.black,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                _fmt(pos),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const Spacer(),
              Text(
                _fmt(dur),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 3,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 7),
              overlayShape:
                  const RoundSliderOverlayShape(overlayRadius: 14),
              activeTrackColor: const Color(0xFFEC4899),
              inactiveTrackColor: Colors.white24,
              thumbColor: const Color(0xFFEC4899),
            ),
            child: Slider(
              value: dur.inMilliseconds > 0
                  ? (pos.inMilliseconds / dur.inMilliseconds)
                      .clamp(0.0, 1.0)
                  : 0.0,
              onChanged: (val) {
                final newPos = Duration(
                  milliseconds:
                      (dur.inMilliseconds * val).toInt(),
                );
                _videoCtrl!.seekTo(newPos);
              },
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_10_rounded,
                    color: Colors.white),
                onPressed: () {
                  final newPos = pos - const Duration(seconds: 10);
                  _videoCtrl!.seekTo(
                    newPos.isNegative ? Duration.zero : newPos,
                  );
                },
              ),
              IconButton(
                iconSize: 48,
                icon: Icon(
                  v.isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_filled_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (v.isPlaying) {
                      _videoCtrl!.pause();
                    } else {
                      _videoCtrl!.play();
                    }
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.forward_10_rounded,
                    color: Colors.white),
                onPressed: () {
                  _videoCtrl!.seekTo(pos + const Duration(seconds: 10));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  // ═══════════════════════════════════════════════════
  //  🖼️ عارض الصور
  // ═══════════════════════════════════════════════════
  Widget _buildImageViewer() {
    // من base64
    if (widget.file.isBase64 && widget.file.storedPath != null) {
      try {
        final bytes = base64Decode(widget.file.storedPath!);
        return Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 5.0,
            child: Image.memory(Uint8List.fromList(bytes)),
          ),
        );
      } catch (e) {
        return _buildError('تعذّر عرض الصورة');
      }
    }

    // من ملف محلي
    if (!kIsWeb && widget.file.storedPath != null) {
      final f = File(widget.file.storedPath!);
      return Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 5.0,
          child: Image.file(
            f,
            errorBuilder: (_, __, ___) => _buildError('تعذّر عرض الصورة'),
          ),
        ),
      );
    }

    return _buildError('لا يمكن عرض الصورة');
  }

  // ═══════════════════════════════════════════════════
  //  📄 معلومات الملف (للأنواع الأخرى)
  // ═══════════════════════════════════════════════════
  Widget _buildFileInfo() {
    final file = widget.file;
    final color = Color(file.kind.color);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Text(file.kind.emoji,
                  style: const TextStyle(fontSize: 60)),
            ),
            const SizedBox(height: 24),
            Text(
              file.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${file.kind.label}  •  ${file.sizeLabel}',
                style: TextStyle(
                  color: color,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: Colors.white54, size: 30),
                  const SizedBox(height: 10),
                  Text(
                    file.kind == FileKind.audio
                        ? 'هذا الملف الصوتي محفوظ داخل التطبيق.\nلتشغيله استخدم مشغّل موسيقى من جهازك.'
                        : 'الملف محفوظ داخل التطبيق بأمان.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioInfo() {
    return _buildFileInfo();
  }

  Widget _buildError(String msg) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: Colors.redAccent, size: 60),
            const SizedBox(height: 16),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}