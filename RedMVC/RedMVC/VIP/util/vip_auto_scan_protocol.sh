#! /bin/sh


if [ -z $1 ];then
    echo "please enter scan target path"
    exit 1
fi

if [ -z $2 ];then
    echo "please enter file save path"
    exit 1
fi

headFileSaveName="VIPProtocols_default.h"
if [[ ! -z $3 ]];
then
#default value
    headFileSaveName=$3
fi

currentPath=$(pwd)

scanPath=$(
cd $currentPath"/"$1
pwd
)

fileSavePath=$(
cd $currentPath
cd $2
pwd
)

fileSaveFile=$fileSavePath/$headFileSaveName

echo "currentpath:$currentPath \n scanPath:$1 savePath:$2"


echo "begin auto scan test case in $scanPath"


DATE=`date +%F`" - "`date +%T`
result="//
\n//  $3
\n//
\n//
\n//  auto create by vip_auto_scan_protocol.sh on $DATE
\n//
\n\n"
count=1
loopCheckFile() {

    local currentPath=$1

    if [ -d $currentPath ]
    then
            for file in `ls $currentPath`;do
                loopCheckFile $currentPath/$file
            done
    else
#            find png
           headExt="h"
           if [ ${currentPath##*.} == "$headExt" ]
            then
                echo "find file $currentPath ${currentPath##*/} "

                result=$result"//$count  \n"
                result=$result"#import \"${currentPath##*/}\" \n"

                let "count++"
            fi
    fi
}


loopCheckFile $scanPath

(
    rm -rf $fileSaveFile
    echo -e $result >> $fileSaveFile
)
echo "save $result in $fileSaveFile"
