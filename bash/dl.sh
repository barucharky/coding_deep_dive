#!/bin/bash

# Fix this mess.
# https://stackoverflow.com/questions/7069682/how-to-get-arguments-with-flags-in-bash#21128172
# That may help, but also FORMATTING

# Make a log file. Get the file name with this:
# youtube-dl [URL] | tee >(grep Destination | cut -f 3- -d ' ' > thing)

url="$(xclip -o)"
dl_dir="/home/baruch/videos/"
conf_loc="--config-location /home/baruch/.config/youtube-dl/config"
file_count=$(echo "$url" | wc -l)

unset config_name
unset sub_name

unset audio
unset config
unset playlist
unset urlfile
unset folder
unset srt


# This should instead create a unique filename so two lists can be downloaded at once
if [ $file_count -gt 1 ]; then
    urlfile="ytemp$(date +%M%N)"
fi

print_usage() {
    echo "
          Usage:
          -a :     Extract audio, save in /home/music/
          -c :     Create a config file
          -f :     Specify folder name within dir
          -F :     Specify file containing URLs
                   If you copied multiple URLs, there is no need
                   to use this option

          -s :     Add subtitle to beginning
          -p :     Download playlist

          -a and -p and -F cannot be used in conjunction with -c or -s

          ";
}

get-media() {
    filename=$(youtube-dl $conf_loc $playlist $format $url | tee /dev/stderr | grep 'Destination' | cut -d ' ' -f 3-)
    echo -e "~--------------------~\n$(date)\n$filename\n$url" >> $dl_dir/dl-log
}

while getopts 'acpf:F:s:t:' flag; do
    case "${flag}" in
      a) dl_dir="/home/baruch/music/"
         conf_loc="--config-location /home/baruch/.config/youtube-dl/audio-fig" 
         audio=true ;;
      c) config=true ;;
      f) folder="${OPTARG}" ;;
      F) urlfile="${OPTARG}" ;;
      s) srt="${OPTARG}" ;;
      h) print_usage
         exit 1 ;;
      p) playlist="--yes-playlist" ;;
      *) print_usage
         exit 1 ;;
    esac
done;

if [ $urlfile ] || [ $audio ] || [ $playlist ]; then
    if [ $config ] || [ $srt ]; then
         print_usage
         exit 1
    fi
fi

if [ $OPTIND -eq 1 ]; then
    folder="$1"
fi

format="-o $dl_dir${folder:-"new"}/%(title)s.%(ext)s"

if [ $config ]; then
    config_name="config$(date +%M%N)"
    echo -e "volume=\n#negative image\n#vf=eq2=1.0:-0.8\nss=" > $dl_dir$config_name
    vim $dl_dir$config_name
fi

if [ "$srt" ]; then
    sub_name="sub$(date +%M%N)"
    echo -e "1\n00:00:00,200 --> 00:00:06,600\n$srt" > $dl_dir$sub_name
fi

# If there's a URL file, download all URLs therein, otherwise download from clipboard

if [ $urlfile ]; then
    if [[ $urlfile == "ytemp"* ]]; then
        echo "$url" > $urlfile
    fi
    
    while read url; do
           get-media
    done < $urlfile
    rm $urlfile

else
    get-media
fi



# ###########################
# End of program cleanup
# ###########################

if [ $config_name ]; then
    mv $dl_dir$config_name "$filename.conf"
fi

if [ $sub_name ]; then
    mv $dl_dir$sub_name "$filename.srt"
fi


# Try this maybe:
# https://stackoverflow.com/questions/26540044/how-do-you-kill-all-child-processes-without-killing-the-parent
