#!/bin/bash
#by @m4lal0

# Regular Colors
Black='\033[0;30m'      # Black
Red='\033[0;31m'        # Red
Green='\033[0;32m'      # Green
Yellow='\033[0;33m'     # Yellow
Blue='\033[0;34m'       # Blue
Purple='\033[0;35m'     # Purple
Cyan='\033[0;36m'       # Cyan
White='\033[0;97m'      # White
Blink='\033[5m'         # Blink
Color_Off='\033[0m'     # Text Reset

# Additional colors
LGray='\033[0;90m'      # Ligth Gray
LRed='\033[0;91m'       # Ligth Red
LGreen='\033[0;92m'     # Ligth Green
LYellow='\033[0;93m'    # Ligth Yellow
LBlue='\033[0;94m'      # Ligth Blue
LPurple='\033[0;95m'    # Light Purple
LCyan='\033[0;96m'      # Ligth Cyan

# Bold
BBlack='\033[1;30m'     # Black
BGray='\033[1;37m'		# Gray
BRed='\033[1;31m'       # Red
BGreen='\033[1;32m'     # Green
BYellow='\033[1;33m'    # Yellow
BBlue='\033[1;34m'      # Blue
BPurple='\033[1;35m'    # Purple
BCyan='\033[1;36m'      # Cyan
BWhite='\033[1;37m'     # White

# Italics
IBlack='\033[3;30m'     # Black
IRed='\033[3;31m'       # Red
IGreen='\033[3;32m'     # Green
IYellow='\033[3;33m'    # Yellow
IBlue='\033[3;34m'      # Blue
IPurple='\033[3;35m'    # Purple
ICyan='\033[3;36m'      # Cyan
IWhite='\033[3;37m'     # White

# Underline
UBlack='\033[4;30m'     # Black
UGray='\033[4;37m'		# Gray
URed='\033[4;31m'       # Red
UGreen='\033[4;32m'     # Green
UYellow='\033[4;33m'    # Yellow
UBlue='\033[4;34m'      # Blue
UPurple='\033[4;35m'    # Purple
UCyan='\033[4;36m'      # Cyan
UWhite='\033[4;37m'     # White

# Background
On_Black='\033[40m'     # Black
On_Red='\033[41m'       # Red
On_Green='\033[42m'     # Green
On_Yellow='\033[43m'    # Yellow
On_Blue='\033[44m'      # Blue
On_Purple='\033[45m'    # Purple
On_Cyan='\033[46m'      # Cyan
On_White='\033[47m'     # White

trap ctrl_c INT

function ctrl_c(){
    echo -e "\n\n${Cyan}[${BYellow}!${Cyan}]${BRed} Saliendo...${Color_Off}\n"
    tput cnorm; exit 0
}

function banner(){
    echo -e "${LBlue}"
    echo -e "\t  _   _               ____                      _     "
    echo -e "\t | | | |___  ___ _ __/ ___|  ___  __ _ _ __ ___| |__  "
    echo -e "\t | | | / __|/ _ \ '__\___ \ / _ \/ _\` | '__/ __| '_ \\"
    echo -e "\t | |_| \__ \  __/ |   ___) |  __/ (_| | | | (__| | | |${Color_Off}${Gray} By @m4lal0"
    echo -e "\t${LBlue}  \___/|___/\___|_|  |____/ \___|\__,_|_|  \___|_| |_|${Color_Off}"
    echo -e "\t${On_Blue}${BWhite} Búsqueda de nombre de usuario en diferentes Sitios Web ${Color_Off}\n\n"
}

function initial(){
    if [[ -e $USERNAME.txt ]]; then
        echo -e "${Cyan}[${BYellow}!${Cyan}] ${BYellow}Eliminando archivo anterior: ${BGray}$USERNAME.txt${Color_Off}"
        rm -rf $USERNAME.txt
    fi
}

function facebook(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Facebook:${Color_Off} "
    CHECK_FACEBOOK=$(curl -s "https://www.facebook.com/$USERNAME/videos/" -L -H "Accept-Language: en" -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' -I | grep -E "HTTP/2 302|HTTP/2 404"; echo $?)
    if [[ $CHECK_FACEBOOK == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.facebook.com/$USERNAME ${Color_Off}"
        echo "https://www.facebook.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function instagram(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Instagram:${Color_Off} "
    CHECK_INSTAGRAM=$(curl -s -H "Accept-Language: en" "https://www.instagram.com/$USERNAME" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'The link you followed may be broken'; echo $?)
    if [[ $CHECK_INSTAGRAM == "0" ]]; then
        echo -e "${BGreen}[✔] - https://www.instagram.com/$USERNAME ${Color_Off}"
        echo "https://www.instagram.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function twitter(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Twitter:${Color_Off} "
    CHECK_TWITTER=$(curl -s "https://shadowban.eu/.api/$USERNAME" -L -H "Accept-Language: en" -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -E '"exists": false|500 Internal Server Error'; echo $?)
    if [[ $CHECK_TWITTER == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.twitter.com/$USERNAME ${Color_Off}"
        echo "https://www.twitter.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function youtube(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}YouTube:${Color_Off} "
    CHECK_YOUTUBE=$(curl -s "https://www.youtube.com/$USERNAME" -H "Accept-Language: en" -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' -I | grep -o "HTTP/2 404"; echo $?)
    if [[ $CHECK_YOUTUBE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.youtube.com/$USERNAME ${Color_Off}"
        echo "https://www.youtube.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function blogspot(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Blogger:${Color_Off} "
    CHECK_BLOGGER=$(curl -s "https://$USERNAME.blogspot.com" -L -H "Accept-Language: en" -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' -I | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_BLOGGER == "1" ]]; then
        echo -e "${BGreen}[✔] - https://$USERNAME.blogspot.com ${Color_Off}"
        echo "https://$USERNAME.blogspot.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function reddit(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Reddit:${Color_Off} "
    CHECK_REDDIT=$(curl -s -I "https://www.reddit.com/user/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -E 'HTTP/2 404|HTTP/2 403'; echo $?)
    if [[ $CHECK_REDDIT == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.reddit.com/user/$USERNAME ${Color_Off}"
        echo "https://www.reddit.com/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function wordpress(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Wordpress:${Color_Off} "
    CHECK_WORDPRESS=$(curl -s -I "https://$USERNAME.wordpress.com" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -E 'HTTP/2 301|HTTP/2 302'; echo $?)
    if [[ $CHECK_WORDPRESS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://$USERNAME.wordpress.com ${Color_Off}"
        echo "https://$USERNAME.wordpress.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function pinterest(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Pinterest:${Color_Off} "
    CHECK_PINTEREST=$(curl -s -I "https://www.pinterest.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_PINTEREST == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.pinterest.com/$USERNAME ${Color_Off}"
        echo "https://www.pinterest.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function github(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}GitHub:${Color_Off} "
    CHECK_GITHUB=$(curl -s -I "https://www.github.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_GITHUB == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.github.com/$USERNAME ${Color_Off}"
        echo "https://www.github.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function tumblr(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Tumblr:${Color_Off} "
    CHECK_TUMBLR=$(curl -s -I "https://$USERNAME.tumblr.com" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_TUMBLR == "1" ]]; then
        echo -e "${BGreen}[✔] - https://$USERNAME.tumblr.com ${Color_Off}"
        echo "https://$USERNAME.tumblr.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function flickr(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Flickr:${Color_Off} "
    CHECK_FLICKR=$(curl -s -I "https://www.flickr.com/people/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_FLICKR == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.flickr.com/people/$USERNAME ${Color_Off}"
        echo "https://www.flickr.com/people/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function steam(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Steam:${Color_Off} "
    CHECK_STEAM=$(curl -s "https://steamcommunity.com/id/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'The specified profile could not be found'; echo $?)
    if [[ $CHECK_STEAM == "1" ]]; then
        echo -e "${BGreen}[✔] - https://steamcommunity.com/id/$USERNAME ${Color_Off}"
        echo "https://steamcommunity.com/id/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function steamgroup(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}SteamGroup:${Color_Off} "
    CHECK_STEAMGROUP=$(curl -s "https://steamcommunity.com/groups/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'No group could be retrieved for the given URL'; echo $?)
    if [[ $CHECK_STEAMGROUP == "1" ]]; then
        echo -e "${BGreen}[✔] - https://steamcommunity.com/groups/$USERNAME ${Color_Off}"
        echo "https://steamcommunity.com/groups/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function vimeo(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Vimeo:${Color_Off} "
    CHECK_VIMEO=$(curl -s -I "https://vimeo.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_VIMEO == "1" ]]; then
        echo -e "${BGreen}[✔] - https://vimeo.com/$USERNAME ${Color_Off}"
        echo "https://vimeo.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function soundcloud(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}SoundCloud:${Color_Off} "
    CHECK_SOUNDCLOUD=$(curl -s -I "https://soundcloud.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_SOUNDCLOUD == "1" ]]; then
        echo -e "${BGreen}[✔] - https://soundcloud.com/$USERNAME ${Color_Off}"
        echo "https://soundcloud.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function disqus(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Disqus:${Color_Off} "
    CHECK_DISQUS=$(curl -s -I "https://disqus.com/by/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -io '404 Not Found'; echo $?)
    if [[ $CHECK_DISQUS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://disqus.com/by/$USERNAME ${Color_Off}"
        echo "https://disqus.com/by/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function medium(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Medium:${Color_Off} "
    CHECK_MEDIUM=$(curl -s -I "https://medium.com/@$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_MEDIUM == "1" ]]; then
        echo -e "${BGreen}[✔] - https://medium.com/@$USERNAME ${Color_Off}"
        echo "https://medium.com/@$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function deviantart(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}DeviantART:${Color_Off} "
    CHECK_DEVIANTART=$(curl -s -I "https://$USERNAME.deviantart.com" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_DEVIANTART == "1" ]]; then
        echo -e "${BGreen}[✔] - https://$USERNAME.deviantart.com ${Color_Off}"
        echo "https://$USERNAME.deviantart.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function vk(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}VK:${Color_Off} "
    CHECK_VK=$(curl -s "https://vk.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_VK == "1" ]]; then
        echo -e "${BGreen}[✔] - https://vk.com/$USERNAME ${Color_Off}"
        echo "https://vk.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function aboutme(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}About.me:${Color_Off} "
    CHECK_ABOUTME=$(curl -s -I "https://about.me/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_ABOUTME == "1" ]]; then
        echo -e "${BGreen}[✔] - https://about.me/$USERNAME ${Color_Off}"
        echo "https://about.me/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function imgur(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Imgur:${Color_Off} "
    CHECK_IMGUR=$(curl -s -I "https://api.imgur.com/account/v1/accounts/$USERNAME?client_id=546c25a59c58ad7" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_IMGUR == "1" ]]; then
        echo -e "${BGreen}[✔] - https://imgur.com/user/$USERNAME ${Color_Off}"
        echo "https://imgur.com/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function flipboard(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Flipboard:${Color_Off} "
    CHECK_FLIPBOARD=$(curl -s -I "https://flipboard.com/@$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_FLIPBOARD == "1" ]]; then
        echo -e "${BGreen}[✔] - https://flipboard.com/@$USERNAME ${Color_Off}"
        echo "https://flipboard.com/@$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function slideshare(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}SlideShare:${Color_Off} "
    CHECK_SLIDESHARE=$(curl -s -I "https://slideshare.net/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_SLIDESHARE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://slideshare.net/$USERNAME ${Color_Off}"
        echo "https://slideshare.net/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function spotify(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Spotify:${Color_Off} "
    CHECK_SPOTIFY=$(curl -s "https://open.spotify.com/user/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'Something went wrong, please try again later'; echo $?)
    if [[ $CHECK_SPOTIFY == "1" ]]; then
        echo -e "${BGreen}[✔] - https://open.spotify.com/user/$USERNAME ${Color_Off}"
        echo "https://open.spotify.com/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function mixcloud(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}MixCloud:${Color_Off} "
    CHECK_MIXCLOUD=$(curl -s -I "https://api.mixcloud.com/$USERNAME/" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_MIXCLOUD == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.mixcloud.com/$USERNAME/ ${Color_Off}"
        echo "https://www.mixcloud.com/$USERNAME/" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function scribd(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Scribd:${Color_Off} "
    CHECK_SCRIBD=$(curl -s -I "https://www.scribd.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_SCRIBD == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.scribd.com/$USERNAME ${Color_Off}"
        echo "https://www.scribd.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function patreon(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Patreon:${Color_Off} "
    CHECK_PATREON=$(curl -s -I "https://www.patreon.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_PATREON == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.patreon.com/$USERNAME ${Color_Off}"
        echo "https://www.patreon.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function bitbucket(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}BitBucket:${Color_Off} "
    CHECK_BITBUCKET=$(curl -s -I "https://bitbucket.org/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_BITBUCKET == "1" ]]; then
        echo -e "${BGreen}[✔] - https://bitbucket.org/$USERNAME ${Color_Off}"
        echo "https://bitbucket.org/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function dailymotion(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}DailyMotion:${Color_Off} "
    CHECK_DAILYMOTION=$(curl -s -I "https://www.dailymotion.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_DAILYMOTION == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.dailymotion.com/$USERNAME ${Color_Off}"
        echo "https://www.dailymotion.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function etsy(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Etsy:${Color_Off} "
    CHECK_ETSY=$(curl -s -I "https://www.etsy.com/shop/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_ETSY == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.etsy.com/shop/$USERNAME ${Color_Off}"
        echo "https://www.etsy.com/shop/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function behance(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Behance:${Color_Off} "
    CHECK_BEHANCE=$(curl -s -I "https://www.behance.net/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_BEHANCE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.behance.net/$USERNAME ${Color_Off}"
        echo "https://www.behance.net/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function goodreads(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}GoodReads:${Color_Off} "
    CHECK_GOODREADS=$(curl -s -I "https://www.goodreads.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_GOODREADS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.goodreads.com/$USERNAME ${Color_Off}"
        echo "https://www.goodreads.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function instructables(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Instructables:${Color_Off} "
    CHECK_INSTRUCTABLES=$(curl -s -I "https://www.instructables.com/json-api/showAuthorExists?screenName={$USERNAME}" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_INSTRUCTABLES == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.instructables.com/member/$USERNAME ${Color_Off}"
        echo "https://www.instructables.com/member/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function keybase(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Keybase:${Color_Off} "
    CHECK_KEYBASE=$(curl -s -I "https://keybase.io/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_KEYBASE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://keybase.io/$USERNAME ${Color_Off}"
        echo "https://keybase.io/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function kongregate(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Kongregate:${Color_Off} "
    CHECK_KONGREGATE=$(curl -s -I "https://kongregate.com/accounts/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_KONGREGATE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://kongregate.com/accounts/$USERNAME ${Color_Off}"
        echo "https://kongregate.com/accounts/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function livejournal(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}LiveJournal:${Color_Off} "
    CHECK_LIVEJOURNAL=$(curl -s -I "https://$USERNAME.livejournal.com" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_LIVEJOURNAL == "1" ]]; then
        echo -e "${BGreen}[✔] - https://$USERNAME.livejournal.com ${Color_Off}"
        echo "https://$USERNAME.livejournal.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function lastfm(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Last.fm:${Color_Off} "
    CHECK_LASTFM=$(curl -s -I "https://last.fm/user/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_LASTFM == "1" ]]; then
        echo -e "${BGreen}[✔] - https://last.fm/user/$USERNAME ${Color_Off}"
        echo "https://last.fm/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function dribbble(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Dribbble:${Color_Off} "
    CHECK_DRIBBBLE=$(curl -s -I "https://dribbble.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_DRIBBBLE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://dribbble.com/$USERNAME ${Color_Off}"
        echo "https://dribbble.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function codecademy(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Codecademy:${Color_Off} "
    CHECK_CODECADEMY=$(curl -s -I "https://www.codecademy.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_CODECADEMY == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.codecademy.com/$USERNAME ${Color_Off}"
        echo "https://www.codecademy.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function gravatar(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Gravatar:${Color_Off} "
    CHECK_GRAVATAR=$(curl -s -I "https://en.gravatar.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_GRAVATAR == "1" ]]; then
        echo -e "${BGreen}[✔] - https://en.gravatar.com/$USERNAME ${Color_Off}"
        echo "https://en.gravatar.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function pastebin(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Pastebin:${Color_Off} "
    CHECK_PASTEBIN=$(curl -s -I "https://pastebin.com/u/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_PASTEBIN == "1" ]]; then
        echo -e "${BGreen}[✔] - https://pastebin.com/u/$USERNAME ${Color_Off}"
        echo "https://pastebin.com/u/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function roblox(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Roblox:${Color_Off} "
    CHECK_ROBLOX=$(curl -s -I "https://www.roblox.com/user.aspx?username=$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_ROBLOX == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.roblox.com/user.aspx?username=$USERNAME ${Color_Off}"
        echo "https://www.roblox.com/user.aspx?username=$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function gumroad(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Gumroad:${Color_Off} "
    CHECK_GUMROAD=$(curl -s -I "https://www.gumroad.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_GUMROAD == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.gumroad.com/$USERNAME ${Color_Off}"
        echo "https://www.gumroad.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function newgrounds(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Newgrounds:${Color_Off} "
    CHECK_NEWGROUNDS=$(curl -s -I "https://$USERNAME.newgrounds.com" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_NEWGROUNDS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://$USERNAME.newgrounds.com ${Color_Off}"
        echo "https://$USERNAME.newgrounds.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function wattpad(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Wattpad:${Color_Off} "
    CHECK_WATTPAD=$(curl -s -I "https://www.wattpad.com/user/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_WATTPAD == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.wattpad.com/user/$USERNAME ${Color_Off}"
        echo "https://www.wattpad.com/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function trakt(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Trakt:${Color_Off} "
    CHECK_TRAKT=$(curl -s -I "https://www.trakt.tv/users/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_TRAKT == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.trakt.tv/users/$USERNAME ${Color_Off}"
        echo "https://www.trakt.tv/users/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function buzzfeed(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}BuzzFeed:${Color_Off} "
    CHECK_BUZZFEED=$(curl -s -I "https://buzzfeed.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_BUZZFEED == "1" ]]; then
        echo -e "${BGreen}[✔] - https://buzzfeed.com/$USERNAME ${Color_Off}"
        echo "https://buzzfeed.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function tripadvisor(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}TripAdvisor:${Color_Off} "
    CHECK_TRIPADVISOR=$(curl -s -I "https://tripadvisor.com/members/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_TRIPADVISOR == "1" ]]; then
        echo -e "${BGreen}[✔] - https://tripadvisor.com/members/$USERNAME ${Color_Off}"
        echo "https://tripadvisor.com/members/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function hubpages(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}HubPages:${Color_Off} "
    CHECK_HUBPAGES=$(curl -s -I "https://hubpages.com/@$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_HUBPAGES == "1" ]]; then
        echo -e "${BGreen}[✔] - https://hubpages.com/@$USERNAME ${Color_Off}"
        echo "https://hubpages.com/@$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function contently(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Contently:${Color_Off} "
    CHECK_CONTENTLY=$(curl -s -I "https://$USERNAME.contently.com" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_CONTENTLY == "1" ]]; then
        echo -e "${BGreen}[✔] - https://$USERNAME.contently.com ${Color_Off}"
        echo "https://$USERNAME.contently.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function blipfm(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}BLIP.fm:${Color_Off} "
    CHECK_BLIPFM=$(curl -s -I "https://blip.fm/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_BLIPFM == "1" ]]; then
        echo -e "${BGreen}[✔] - https://blip.fm/$USERNAME ${Color_Off}"
        echo "https://blip.fm/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function wikipedia(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Wikipedia:${Color_Off} "
    CHECK_WIKIPEDIA=$(curl -s -I "https://www.wikipedia.org/wiki/User:$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_WIKIPEDIA == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.wikipedia.org/wiki/User:$USERNAME ${Color_Off}"
        echo "https://www.wikipedia.org/wiki/User:$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function hackernews(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}HackerNews:${Color_Off} "
    CHECK_HACKERNEWS=$(curl -s "https://news.ycombinator.com/user?id=$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'No such user'; echo $?)
    if [[ $CHECK_HACKERNEWS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://news.ycombinator.com/user?id=$USERNAME ${Color_Off}"
        echo "https://news.ycombinator.com/user?id=$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function reverbnation(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}ReverbNation:${Color_Off} "
    CHECK_REVERBNATION=$(curl -s -I "https://www.reverbnation.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_REVERBNATION == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.reverbnation.com/$USERNAME ${Color_Off}"
        echo "https://www.reverbnation.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function designspiration(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Designspiration:${Color_Off} "
    CHECK_DESIGNSPIRATION=$(curl -s -I "https://www.designspiration.net/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_DESIGNSPIRATION == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.designspiration.net/$USERNAME ${Color_Off}"
        echo "https://www.designspiration.net/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function bandcamp(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Bandcamp:${Color_Off} "
    CHECK_BANDCAMP=$(curl -s -I "https://www.bandcamp.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_BANDCAMP == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.bandcamp.com/$USERNAME ${Color_Off}"
        echo "https://www.bandcamp.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function colourlovers(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}ColourLovers:${Color_Off} "
    CHECK_COLOURLOVERS=$(curl -s -I "https://www.colourlovers.com/love/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_COLOURLOVERS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.colourlovers.com/love/$USERNAME ${Color_Off}"
        echo "https://www.colourlovers.com/love/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function ifttt(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}IFTTT:${Color_Off} "
    CHECK_IFTTT=$(curl -s -I "https://www.ifttt.com/p/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_IFTTT == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.ifttt.com/p/$USERNAME ${Color_Off}"
        echo "https://www.ifttt.com/p/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function slack(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Slack:${Color_Off} "
    CHECK_SLACK=$(curl -s -I "https://$USERNAME.slack.com" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_SLACK == "1" ]]; then
        echo -e "${BGreen}[✔] - https://$USERNAME.slack.com ${Color_Off}"
        echo "https://$USERNAME.slack.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function ello(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Ello:${Color_Off} "
    CHECK_ELLO=$(curl -s "https://ello.co/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o "We couldn\'t find the page you're looking for"; echo $?)
    if [[ $CHECK_ELLO == "1" ]]; then
        echo -e "${BGreen}[✔] - https://ello.co/$USERNAME ${Color_Off}"
        echo "https://ello.co/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function archiveorg(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Archive.org:${Color_Off} "
    CHECK_ARCHIVEORG=$(curl -s "https://archive.org/details/@$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'cannot find account'; echo $?)
    if [[ $CHECK_ARCHIVEORG == "1" ]]; then
        echo -e "${BGreen}[✔] - https://archive.org/details/@$USERNAME ${Color_Off}"
        echo "https://archive.org/details/@$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function asciinema(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Asciinema:${Color_Off} "
    CHECK_ASCIINEMA=$(curl -s -I "https://asciinema.org/~$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_ASCIINEMA == "1" ]]; then
        echo -e "${BGreen}[✔] - https://asciinema.org/~$USERNAME ${Color_Off}"
        echo "https://asciinema.org/~$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function askfedora(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Ask Fedora:${Color_Off} "
    CHECK_ASKFEDORA=$(curl -s -I "https://ask.fedoraproject.org/u/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_ASKFEDORA == "1" ]]; then
        echo -e "${BGreen}[✔] - https://ask.fedoraproject.org/u/$USERNAME ${Color_Off}"
        echo "https://ask.fedoraproject.org/u/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function atomdiscussions(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Atom Discussions:${Color_Off} "
    CHECK_ATOMDISCUSSIONS=$(curl -s -I "https://discuss.atom.io/u/$USERNAME/summary" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_ATOMDISCUSSIONS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://discuss.atom.io/u/$USERNAME/summary ${Color_Off}"
        echo "https://discuss.atom.io/u/$USERNAME/summary" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function binarysearch(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}BinarySearch:${Color_Off} "
    CHECK_BINARYSEARCH=$(curl -s "https://binarysearch.io/api/users/$USERNAME/profile" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '{}'; echo $?)
    if [[ $CHECK_BINARYSEARCH == "1" ]]; then
        echo -e "${BGreen}[✔] - https://binarysearch.io/@/$USERNAME ${Color_Off}"
        echo "https://binarysearch.io/@/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function bitcoinforum(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}BitCoinForum:${Color_Off} "
    CHECK_BITCOINFORUM=$(curl -s "https://bitcoinforum.com/profile/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'The user whose profile you are trying to view does not exist.'; echo $?)
    if [[ $CHECK_BITCOINFORUM == "1" ]]; then
        echo -e "${BGreen}[✔] - https://bitcoinforum.com/profile/$USERNAME ${Color_Off}"
        echo "https://bitcoinforum.com/profile/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function buymeacoffee(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}BuyMeACoffee:${Color_Off} "
    CHECK_BUYMEACOFFE=$(curl -s -I "https://buymeacoff.ee/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_BUYMEACOFFE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://buymeacoff.ee/$USERNAME ${Color_Off}"
        echo "https://buymeacoff.ee/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function cnet(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}CNET:${Color_Off} "
    CHECK_CNET=$(curl -s -I "https://www.cnet.com/profiles/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_CNET == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.cnet.com/profiles/$USERNAME ${Color_Off}"
        echo "https://www.cnet.com/profiles/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function capfriendly(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}CapFriendly:${Color_Off} "
    CHECK_CAPFRIENDLY=$(curl -s "https://www.capfriendly.com/users/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'No results found'; echo $?)
    if [[ $CHECK_CAPFRIENDLY == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.capfriendly.com/users/$USERNAME ${Color_Off}"
        echo "https://www.capfriendly.com/users/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function codewars(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Codewars:${Color_Off} "
    CHECK_CODEWARS=$(curl -s -I "https://www.codewars.com/users/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_CODEWARS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.codewars.com/users/$USERNAME ${Color_Off}"
        echo "https://www.codewars.com/users/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function coroflot(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Coroflot:${Color_Off} "
    CHECK_COROFLOT=$(curl -s -I "https://www.coroflot.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_COROFLOT == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.coroflot.com/$USERNAME ${Color_Off}"
        echo "https://www.coroflot.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function cracked(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Cracked:${Color_Off} "
    CHECK_CRACKED=$(curl -s -I "https://www.cracked.com/members/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '301 Moved Permanently'; echo $?)
    if [[ $CHECK_CRACKED == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.cracked.com/members/$USERNAME ${Color_Off}"
        echo "https://www.cracked.com/members/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function devcommunity(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}DEV Community:${Color_Off} "
    CHECK_DEVCOMMUNITY=$(curl -s -I "https://dev.to/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_DEVCOMMUNITY == "1" ]]; then
        echo -e "${BGreen}[✔] - https://dev.to/$USERNAME ${Color_Off}"
        echo "https://dev.to/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function dockerhub(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Docker Hub:${Color_Off} "
    CHECK_DOCKERHUB=$(curl -s "https://hub.docker.com/v2/users/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'Not Found'; echo $?)
    if [[ $CHECK_DOCKERHUB == "1" ]]; then
        echo -e "${BGreen}[✔] - https://hub.docker.com/u/$USERNAME ${Color_Off}"
        echo "https://hub.docker.com/u/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function duolingo(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Duolingo:${Color_Off} "
    CHECK_DUOLINGO=$(curl -s "https://www.duolingo.com/2017-06-30/users?username={$USERNAME}" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'username'; echo $?)
    if [[ $CHECK_DUOLINGO == "0" ]]; then
        echo -e "${BGreen}[✔] - https://www.duolingo.com/profile/$USERNAME ${Color_Off}"
        echo "https://www.duolingo.com/profile/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function eyeem(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}EyeEm:${Color_Off} "
    CHECK_EYEEM=$(curl -s -I "https://www.eyeem.com/u/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_EYEEM == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.eyeem.com/u/$USERNAME ${Color_Off}"
        echo "https://www.eyeem.com/u/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function fandom(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Fandom:${Color_Off} "
    CHECK_FANDOM=$(curl -s -I "https://www.fandom.com/u/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_FANDOM == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.fandom.com/u/$USERNAME ${Color_Off}"
        echo "https://www.fandom.com/u/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function fortnitetracker(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}FortniteTracker:${Color_Off} "
    CHECK_FORTNITETRACKER=$(curl -s -I "https://fortnitetracker.com/profile/all/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_FORTNITETRACKER == "1" ]]; then
        echo -e "${BGreen}[✔] - https://fortnitetracker.com/profile/all/$USERNAME ${Color_Off}"
        echo "https://fortnitetracker.com/profile/all/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function freelancer(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Freelancer.com:${Color_Off} "
    CHECK_FREELANCER=$(curl -s "https://www.freelancer.com/api/users/0.1/users?usernames%5B%5D=$USERNAME&compact=true" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'username'; echo $?)
    if [[ $CHECK_FREELANCER == "0" ]]; then
        echo -e "${BGreen}[✔] - https://www.freelancer.com/$USERNAME ${Color_Off}"
        echo "https://www.freelancer.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function gdprofiles(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}GDProfiles:${Color_Off} "
    CHECK_GDPROFILES=$(curl -s -I "https://gdprofiles.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_GDPROFILES == "1" ]]; then
        echo -e "${BGreen}[✔] - https://gdprofiles.com/$USERNAME ${Color_Off}"
        echo "https://gdprofiles.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function gamespot(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Gamespot:${Color_Off} "
    CHECK_GAMESPOT=$(curl -s -I "https://www.gamespot.com/profile/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_GAMESPOT == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.gamespot.com/profile/$USERNAME ${Color_Off}"
        echo "https://www.gamespot.com/profile/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function gitlab(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}GitLab:${Color_Off} "
    CHECK_GITLAB=$(curl -s "https://gitlab.com/api/v4/users?username={$USERNAME}" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o "username"; echo $?)
    if [[ $CHECK_GITLAB == "0" ]]; then
        echo -e "${BGreen}[✔] - https://gitlab.com/$USERNAME ${Color_Off}"
        echo "https://gitlab.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function gurushots(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}GuruShots:${Color_Off} "
    CHECK_GURUSHOTS=$(curl -s -I "https://gurushots.com/$USERNAME/photos" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_GURUSHOTS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://gurushots.com/$USERNAME/photos ${Color_Off}"
        echo "https://gurushots.com/$USERNAME/photos" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function hackthebox(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}HackTheBox:${Color_Off} "
    CHECK_HACKTHEBOX=$(curl -s -I "https://forum.hackthebox.eu/profile/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_HACKTHEBOX == "1" ]]; then
        echo -e "${BGreen}[✔] - https://forum.hackthebox.eu/profile/$USERNAME ${Color_Off}"
        echo "https://forum.hackthebox.eu/profile/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function hackaday(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Hackaday:${Color_Off} "
    CHECK_HACKADAY=$(curl -s -I "https://hackaday.io/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_HACKADAY == "1" ]]; then
        echo -e "${BGreen}[✔] - https://hackaday.io/$USERNAME ${Color_Off}"
        echo "https://hackaday.io/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function hackerone(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}HackerOne:${Color_Off} "
    CHECK_HACKERONE=$(curl -s -I "https://hackerone.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_HACKERONE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://hackerone.com/$USERNAME ${Color_Off}"
        echo "https://hackerone.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function hackerrank(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}HackerRank:${Color_Off} "
    CHECK_HACKERRANK=$(curl -s "https://hackerrank.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'Something went wrong'; echo $?)
    if [[ $CHECK_HACKERRANK == "1" ]]; then
        echo -e "${BGreen}[✔] - https://hackerrank.com/$USERNAME ${Color_Off}"
        echo "https://hackerrank.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function houzz(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Houzz:${Color_Off} "
    CHECK_HOUZZ=$(curl -s -I "https://houzz.com/user/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_HOUZZ == "1" ]]; then
        echo -e "${BGreen}[✔] - https://houzz.com/user/$USERNAME ${Color_Off}"
        echo "https://houzz.com/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function icq(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}ICQ:${Color_Off} "
    CHECK_ICQ=$(curl -s -I "https://icq.im/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/1.1 404'; echo $?)
    if [[ $CHECK_ICQ == "1" ]]; then
        echo -e "${BGreen}[✔] - https://icq.im/$USERNAME ${Color_Off}"
        echo "https://icq.im/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function issuu(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Issuu:${Color_Off} "
    CHECK_ISSUU=$(curl -s -I "https://issuu.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_ISSUU == "1" ]]; then
        echo -e "${BGreen}[✔] - https://issuu.com/$USERNAME ${Color_Off}"
        echo "https://issuu.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function kali(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Kali community:${Color_Off} "
    CHECK_KALI=$(curl -s "https://forums.kali.org/member.php?username={$USERNAME}" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'This user has not registered and therefore does not have a profile to view.'; echo $?)
    if [[ $CHECK_KALI == "1" ]]; then
        echo -e "${BGreen}[✔] - https://forums.kali.org/member.php?username={$USERNAME} ${Color_Off}"
        echo "https://forums.kali.org/member.php?username={$USERNAME}" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function leetcode(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}LeetCode:${Color_Off} "
    CHECK_LEETCODE=$(curl -s -I "https://leetcode.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_LEETCODE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://leetcode.com/$USERNAME ${Color_Off}"
        echo "https://leetcode.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function myspace(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Myspace:${Color_Off} "
    CHECK_MYSPACE=$(curl -s -I "https://myspace.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_MYSPACE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://myspace.com/$USERNAME ${Color_Off}"
        echo "https://myspace.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function opensource(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Opensource:${Color_Off} "
    CHECK_OPENSOURCE=$(curl -s -I "https://opensource.com/users/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_OPENSOURCE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://opensource.com/users/$USERNAME ${Color_Off}"
        echo "https://opensource.com/users/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function opensource(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Opensource:${Color_Off} "
    CHECK_OPENSOURCE=$(curl -s -I "https://opensource.com/users/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_OPENSOURCE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://opensource.com/users/$USERNAME ${Color_Off}"
        echo "https://opensource.com/users/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function pcgamer(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}PCGamer:${Color_Off} "
    CHECK_PCGAMER=$(curl -s "https://forums.pcgamer.com/members/?username={$USERNAME}" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o "The specified member cannot be found. Please enter a member's entire name."; echo $?)
    if [[ $CHECK_PCGAMER == "1" ]]; then
        echo -e "${BGreen}[✔] - https://forums.pcgamer.com/members/?username={$USERNAME} ${Color_Off}"
        echo "https://forums.pcgamer.com/members/?username={$USERNAME}" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function periscope(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Periscope:${Color_Off} "
    CHECK_PERISCOPE=$(curl -s -I "https://www.periscope.tv/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_PERISCOPE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.periscope.tv/$USERNAME ${Color_Off}"
        echo "https://www.periscope.tv/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function pypi(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}PyPi:${Color_Off} "
    CHECK_PYPI=$(curl -s -I "https://pypi.org/user/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_PYPI == "1" ]]; then
        echo -e "${BGreen}[✔] - https://pypi.org/user/$USERNAME ${Color_Off}"
        echo "https://pypi.org/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function rubygems(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}RubyGems:${Color_Off} "
    CHECK_RUBYGEMS=$(curl -s -I "https://rubygems.org/profiles/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_RUBYGEMS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://rubygems.org/profiles/$USERNAME ${Color_Off}"
        echo "https://rubygems.org/profiles/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function scratch(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Scratch:${Color_Off} "
    CHECK_SCRATCH=$(curl -s -I "https://scratch.mit.edu/users/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_SCRATCH == "1" ]]; then
        echo -e "${BGreen}[✔] - https://scratch.mit.edu/users/$USERNAME ${Color_Off}"
        echo "https://scratch.mit.edu/users/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function signal(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Signal:${Color_Off} "
    CHECK_SIGNAL=$(curl -s -I "https://community.signalusers.org/u/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_SIGNAL == "1" ]]; then
        echo -e "${BGreen}[✔] - https://community.signalusers.org/u/$USERNAME ${Color_Off}"
        echo "https://community.signalusers.org/u/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function sourceforge(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}SourceForge:${Color_Off} "
    CHECK_SOURCEFORGE=$(curl -s -I "https://sourceforge.net/u/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_SOURCEFORGE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://sourceforge.net/u/$USERNAME ${Color_Off}"
        echo "https://sourceforge.net/u/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function speedrun(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Speedrun.com:${Color_Off} "
    CHECK_SPEEDRUN=$(curl -s -I "https://speedrun.com/user/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_SPEEDRUN == "1" ]]; then
        echo -e "${BGreen}[✔] - https://speedrun.com/user/$USERNAME ${Color_Off}"
        echo "https://speedrun.com/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function sublimeforum(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}SublimeForum:${Color_Off} "
    CHECK_SUBLIMEFORUM=$(curl -s -I "https://forum.sublimetext.com/u/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_SUBLIMEFORUM == "1" ]]; then
        echo -e "${BGreen}[✔] - https://forum.sublimetext.com/u/$USERNAME ${Color_Off}"
        echo "https://forum.sublimetext.com/u/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function twitch(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Twitch:${Color_Off} "
    CHECK_TWITCH=$(curl -s -I "https://m.twitch.tv/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_TWITCH == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.twitch.tv/$USERNAME ${Color_Off}"
        echo "https://www.twitch.tv/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function wix(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Wix:${Color_Off} "
    CHECK_WIX=$(curl -s -I "https://$USERNAME.wix.com" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_WIX == "1" ]]; then
        echo -e "${BGreen}[✔] - https://$USERNAME.wix.com ${Color_Off}"
        echo "https://$USERNAME.wix.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function xboxgamertag(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Xbox Gamertag:${Color_Off} "
    CHECK_XBOXGAMERTAG=$(curl -s -I "https://xboxgamertag.com/search/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_XBOXGAMERTAG == "1" ]]; then
        echo -e "${BGreen}[✔] - https://xboxgamertag.com/search/$USERNAME ${Color_Off}"
        echo "https://xboxgamertag.com/search/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function younow(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}YouNow:${Color_Off} "
    CHECK_YOUNOW=$(curl -s "https://api.younow.com/php/api/broadcast/info/user=$USERNAME/" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o "No users found"; echo $?)
    if [[ $CHECK_YOUNOW == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.younow.com/$USERNAME ${Color_Off}"
        echo "https://www.younow.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function uidme(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}uid.me:${Color_Off} "
    CHECK_UIDME=$(curl -s -I "http://uid.me/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o '404 Not Found'; echo $?)
    if [[ $CHECK_UIDME == "1" ]]; then
        echo -e "${BGreen}[✔] - http://uid.me/$USERNAME ${Color_Off}"
        echo "http://uid.me/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function protonmail(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Protonmail:${Color_Off} "
    CHECK_PROTONMAIL=$(curl -s "https://api.protonmail.ch/pks/lookup?op=get&search=$USERNAME@protonmail.com" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'No key found'; echo $?)
    if [[ $CHECK_PROTONMAIL == "1" ]]; then
        echo -e "${BGreen}[✔] - https://api.protonmail.ch/pks/lookup?op=get&search=$USERNAME@protonmail.com ${Color_Off}"
        echo "https://api.protonmail.ch/pks/lookup?op=get&search=$USERNAME@protonmail.com" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function audiojungle(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Audiojungle:${Color_Off} "
    CHECK_AUDIOJUNGLE=$(curl -s -I "https://audiojungle.net/user/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_AUDIOJUNGLE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://audiojungle.net/user/$USERNAME ${Color_Off}"
        echo "https://audiojungle.net/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function chess(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Chess:${Color_Off} "
    CHECK_CHESS=$(curl -s -I "https://www.chess.com/member/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_CHESS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.chess.com/member/$USERNAME ${Color_Off}"
        echo "https://www.chess.com/member/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function themeforest(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}ThemeForest:${Color_Off} "
    CHECK_THEMEFOREST=$(curl -s -I "https://themeforest.net/user/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_THEMEFOREST == "1" ]]; then
        echo -e "${BGreen}[✔] - https://themeforest.net/user/$USERNAME ${Color_Off}"
        echo "https://themeforest.net/user/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function telegram(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Telegram:${Color_Off} "
    CHECK_TELEGRAM=$(curl -s "https://t.me/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'View in Telegram'; echo $?)
    if [[ $CHECK_TELEGRAM == "0" ]]; then
        echo -e "${BGreen}[✔] - https://t.me/$USERNAME ${Color_Off}"
        echo "https://t.me/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function smule(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Smule:${Color_Off} "
    CHECK_SMULE=$(curl -s -I "https://www.smule.com/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_SMULE == "1" ]]; then
        echo -e "${BGreen}[✔] - https://www.smule.com/$USERNAME ${Color_Off}"
        echo "https://www.smule.com/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function 7cups(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}7cups:${Color_Off} "
    CHECK_7CUPS=$(curl -s -I "https://7cups.com/@$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_7CUPS == "1" ]]; then
        echo -e "${BGreen}[✔] - https://7cups.com/@$USERNAME ${Color_Off}"
        echo "https://7cups.com/@$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function devto(){
    echo -en "${Cyan}[${BBlue}+${Cyan}] ${BBlue}Dev.to:${Color_Off} "
    CHECK_DEVTO=$(curl -s -I "https://dev.to/$USERNAME" -H "Accept-Language: en" -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0' | grep -o 'HTTP/2 404'; echo $?)
    if [[ $CHECK_DEVTO == "1" ]]; then
        echo -e "${BGreen}[✔] - https://dev.to/$USERNAME ${Color_Off}"
        echo "https://dev.to/$USERNAME" >> $USERNAME.txt
    else
        echo -e "${BRed}[✘] - No encontrado ${Color_Off}"
    fi
}

function search(){
    USERNAME=""
    while [ "$USERNAME" == "" ]; do
        echo -en "${Cyan}[${BPurple}?${Cyan}] ${BPurple}Nombre de Usuario:${Color_Off} " && read USERNAME
    done
    initial
    tput civis
    echo -e "\n${Cyan}[${BYellow}!${Cyan}] ${BYellow}Buscando el usuario [${BGray}$USERNAME${BYellow}] en:${Color_Off}"
    7cups
    aboutme
    archiveorg
    asciinema
    askfedora
    atomdiscussions
    audiojungle
    bandcamp
    behance
    binarysearch
    bitbucket
    bitcoinforum
    blipfm
    blogspot
    buymeacoffee
    buzzfeed
    capfriendly
    chess
    cnet
    codecademy
    codewars
    colourlovers
    contently
    coroflot
    cracked
    dailymotion
    designspiration
    devcommunity
    deviantart
    devto
    disqus
    dockerhub
    dribbble
    duolingo
    ello
    etsy
    eyeem
    facebook
    fandom
    flickr
    flipboard
    fortnitetracker
    freelancer
    gamespot
    gdprofiles
    github
    gitlab
    goodreads
    gravatar
    gumroad
    gurushots
    hackaday
    hackernews
    hackerone
    hackerrank
    hackthebox
    houzz
    hubpages
    icq
    ifttt
    imgur
    #instagram
    instructables
    issuu
    kali
    keybase
    kongregate
    lastfm
    leetcode
    livejournal
    medium
    mixcloud
    myspace
    newgrounds
    opensource
    pastebin
    patreon
    pcgamer
    periscope
    pinterest
    protonmail
    pypi
    reddit
    reverbnation
    roblox
    rubygems
    scratch
    scribd
    signal
    slack
    slideshare
    smule
    soundcloud
    sourceforge
    speedrun
    spotify
    steam
    steamgroup
    sublimeforum
    telegram
    themeforest
    trakt
    tripadvisor
    tumblr
    twitch
    twitter
    uidme
    vimeo
    vk
    wattpad
    wikipedia
    wix
    wordpress
    xboxgamertag
    younow
    youtube

    tput cnorm
    if [[ -e $USERNAME.txt ]]; then
        echo -e "\n${Cyan}[${BGreen}*${Cyan}] ${BGreen}Resultados guardado en: ${BGray}${Blink}$USERNAME.txt${Color_Off}\n"
    fi
    echo -en "\n${Cyan}[${BPurple}?${Cyan}] ${BPurple}Quiere realizar otra búsqueda? (${BGreen}Y${BPurple}/${BRed}n${BPurple}):${Color_Off} " && read INPUT
	case "$INPUT" in
		n|N) exit 0 ;;
		*) main ;;
	esac
}

function main(){
    clear
    banner
    search
}

main