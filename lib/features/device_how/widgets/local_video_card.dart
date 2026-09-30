import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../how_section.dart';

class LocalVideoCard extends StatefulWidget {
  final HowVideo video;
  final Color color;

  const LocalVideoCard({super.key, required this.video, required this.color});

  @override
  State<LocalVideoCard> createState() => _LocalVideoCardState();
}

class _LocalVideoCardState extends State<LocalVideoCard> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _hasError = false;
  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.video.assetPath);
      await _controller.initialize();
      _controller.addListener(_onVideoUpdate);
      setState(() => _initialized = true);
      _autoHideControls();
    } catch (e) {
      setState(() => _hasError = true);
    }
  }

  void _onVideoUpdate() {
    if (mounted) setState(() {});
  }

  void _autoHideControls() {
    _hideTimer?.cancel();
    if (_controller.value.isPlaying) {
      _hideTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showControls = false);
      });
    }
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showControls = true;
      } else {
        _controller.play();
        _showControls = true;
        _autoHideControls();
      }
    });
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
    if (_showControls) _autoHideControls();
  }

  Future<void> _openFullscreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullscreenVideo(
          controller: _controller,
          title: widget.video.title,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _controller.removeListener(_onVideoUpdate);
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) return _buildError();
    if (!_initialized) return _buildLoading();

    final value = _controller.value;
    final position = value.position;
    final duration = value.duration;
    final progress = duration.inMilliseconds > 0
        ? position.inMilliseconds / duration.inMilliseconds
        : 0.0;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: value.aspectRatio,
              child: GestureDetector(
                onTap: _toggleControls,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),

                    if (_showControls || !value.isPlaying)
                      Container(
                        color: Colors.black.withValues(alpha: 0.35),
                        child: Center(
                          child: IconButton(
                            iconSize: 64,
                            icon: Icon(
                              value.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              color: Colors.white,
                            ),
                            onPressed: _togglePlay,
                          ),
                        ),
                      ),

                    Positioned(
                      top: 8,
                      left: 8,
                      child: IconButton(
                        icon: const Icon(Icons.fullscreen,
                            color: Colors.white, size: 28),
                        onPressed: _openFullscreen,
                      ),
                    ),

                    if (_showControls)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          color: Colors.black.withValues(alpha: 0.6),
                          child: Row(
                            children: [
                              Text(
                                _formatDuration(position),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 2,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6),
                                    overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 12),
                                    activeTrackColor: widget.color,
                                    inactiveTrackColor: Colors.white30,
                                    thumbColor: widget.color,
                                  ),
                                  child: Slider(
                                    value: progress.clamp(0.0, 1.0),
                                    onChanged: (v) {
                                      _controller.seekTo(Duration(
                                        milliseconds:
                                            (duration.inMilliseconds * v)
                                                .toInt(),
                                      ));
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                _formatDuration(duration),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.play_circle_outline,
                      color: widget.color, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.video.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        if (widget.video.description != null)
                          Text(
                            widget.video.description!,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                      ],
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

  Widget _buildLoading() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.videocam_off, size: 48, color: widget.color),
          const SizedBox(height: 8),
          Text(
            'الفيديو غير متوفر',
            style: TextStyle(
              color: widget.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'تأكد من وجود: ${widget.video.assetPath}',
            style: const TextStyle(fontSize: 11, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FullscreenVideo extends StatefulWidget {
  final VideoPlayerController controller;
  final String title;

  const _FullscreenVideo({
    required this.controller,
    required this.title,
  });

  @override
  State<_FullscreenVideo> createState() => _FullscreenVideoState();
}

class _FullscreenVideoState extends State<_FullscreenVideo> {
  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onUpdate);
    if (!widget.controller.value.isPlaying) {
      widget.controller.play();
    }
    _autoHide();
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  void _autoHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    widget.controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final v = widget.controller.value;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(widget.title, style: const TextStyle(fontSize: 14)),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() => _showControls = !_showControls);
            if (_showControls) _autoHide();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: v.aspectRatio,
                child: VideoPlayer(widget.controller),
              ),
              if (_showControls)
                Container(
                  color: Colors.black.withValues(alpha: 0.35),
                  child: IconButton(
                    iconSize: 80,
                    icon: Icon(
                      v.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (v.isPlaying) {
                          widget.controller.pause();
                        } else {
                          widget.controller.play();
                          _autoHide();
                        }
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}