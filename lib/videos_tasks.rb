
class VideosTasks

  def self.sanity
    return true
  end

  def sanity
    puts! "I am sane."
  end

  #
  # Look at all the VideoLegacy and record its id as legacy_id of the corresponding Video.
  # mysql -> mongodb
  #
  def churn_legacy_id
    legacy_videos = VideoLegacy.all
    legacy_videos.each do |legacy_video|
      if ![ '"', '?' ].include?( legacy_video.video_clip.clip[78] )
        puts! "problem with video clip for video_legacy #{legacy_video.id}"
        next
      end
      legacy_video_youtube_id = legacy_video.video_clip.clip[67..77]
      this_modern_video = Video.where( :youtube_id => legacy_video_youtube_id ).first
      if !this_modern_video
        puts! "Problem: this video is not found. Legacy - youtube: #{legacy_video.id} - #{legacy_video_youtube_id}."
        next
      end
      this_modern_video.legacy_id = legacy_video.id
      flag = this_modern_video.save
      if flag
        puts! "Saved video for #{this_modern_video.youtube_id}."
      else
        puts! "Cannot save video #{this_modern_video.errors}"
      end
    end
  end
  
  private
  
  def puts! args, label=""
    puts "+++ +++ #{label}"
    puts args.inspect
  end
  
end
