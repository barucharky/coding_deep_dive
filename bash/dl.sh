#!/bin/bash

# Fix this mess.
# https://stackoverflow.com/questions/7069682/how-to-get-arguments-with-flags-in-bash#21128172
# That may help, but also FORMATTING

url="$(xclip -o)"
dl_dir="/home/baruch/videos/"
conf_loc="--config-location /home/baruch/.config/youtube-dl/config"

unset config_name
unset sub_name

unset audio
unset config
unset playlist
unset urlfile
unset folder
unset srt
unset tag


print_usage() {
    echo "Usage:....";
}

cancel_conf_sub() {
    if [ $urlfile ] || [ $audio ] || [ $playlist ]; then
        >&2 echo "config or sub only for individual videos"
        echo "true"
    fi;
}

while getopts 'acpF:f:s:t:' flag; do
    case "${flag}" in
      a) dl_dir="/home/baruch/music/"
         conf_loc="--config-location /home/baruch/.config/youtube-dl/audio-fig" ;;
      c) config=true ;;
      p) playlist="--yes-playlist" ;;
      F) urlfile="ytemp" ;;
      f) folder="${OPTARG}" ;;
      s) srt="${OPTARG}" ;;
      t) tag="${OPTARG}" ;;
      *) print_usage
         exit 1 ;;
    esac
done;

format="-o $dl_dir${folder:-"new"}/%(title)s.%(ext)s"

if [ $config ]; then
    if [ -z $(cancel_conf_sub) ]; then
        config_name="config$(date +%M%N)"
        echo -e "volume=\n#negative image\n#vf=eq2=1.0:-0.8\nss=" > $dl_dir$config_name
        vim $dl_dir$config_name
    fi
fi

if [[ $srt ]]; then
    if [ -z $(cancel_conf_sub) ]; then
        sub_name="sub$(date +%M%N)"
        echo -e "1\n00:00:00,200 --> 00:00:06,600\n$srt" > $dl_dir$sub_name
    fi
fi

if [ $urlfile ]; then
    while read furl; do
           youtube-dl $playlist $format $furl
    done < "$urlfile"
    rm "$urlfile"
else
    youtube-dl $conf_loc $playlist $format $url
    filename=$(youtube-dl --get-filename -o '%(title)s.%(ext)s' "$url")
fi



# ###########################
# End of program cleanup
# ###########################

if [[ $config_name ]]; then
    mv $dl_dir$config_name $dl_dir${folder:-"new"}/"${tag:-}$(echo $(echo "${filename##*/}" | strings | head -1)).conf"
fi

if [[ $sub_name ]]; then
    mv $dl_dir$sub_name $dl_dir${folder:-"new"}/"${tag:-}$(echo $(echo "${filename##*/}" | strings | head -1)).srt"
fi

kill -9 $PPID