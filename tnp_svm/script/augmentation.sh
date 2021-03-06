#!/bin/bash
#
# Version:  2017.07.31
# Authors:  Members of the Team NAIST-Panasonic at the Amazon Robotics Challenge 2017:
#           Gustavo A. Garcia R. <garcia-g at is.naist.jp> (Captain), 
#           Lotfi El Hafi, Felix von Drigalski, Wataru Yamazaki, Viktor Hoerig, Arnaud Delmotte, 
#           Akishige Yuguchi, Marcus Gall, Chika Shiogama, Kenta Toyoshima, Pedro Uriguen, 
#           Rodrigo Elizalde, Masaki Yamamoto, Yasunao Okazaki, Kazuo Inoue, Katsuhiko Asai, 
#           Ryutaro Futakuchi, Seigo Okada, Yusuke Kato, and Pin-Chu Yang
#####################
# Copyright 2017 Team NAIST-Panasonic 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at 
#     http://www.apache.org/licenses/LICENSE-2.0 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#####################

######## for Stow Task

cd /root/share/tnp_svm/amazon_bgr

for directory in * ; do
	if  [[ $directory == * ]]; then
		echo $directory
		cd ${directory}
		for img in *.png; do
			echo $img
			if  [[ $img == * ]]; then
				cd /root/catkin_ws/src/tnp/tnp_svm/script
				mkdir -p /root/share/tnp_svm/rectified_amazon_bgr/$directory
				./BackgroundRemoverBBoxExtractor /root/share/tnp_svm/amazon_bgr/$directory/$img /root/share/tnp_svm/rectified_amazon_bgr/$directory/rectified_$img 4 10 60 0.97	
				cd /root/share/tnp_svm/amazon_bgr/$directory
			fi
		done
		cd /root/share/tnp_svm/amazon_bgr
	fi
done

cd /root/share/tnp_svm/own_bgr

for directory in * ; do
	if  [[ $directory == * ]]; then
		echo $directory
		cd ${directory}
		for img in *.png; do
			echo $img
			if  [[ $img == * ]]; then
				cd /root/catkin_ws/src/tnp/tnp_svm/script
				mkdir -p /root/share/tnp_svm/rectified_own_bgr/$directory
				./BackgroundRemoverBBoxExtractor /root/share/tnp_svm/own_bgr/$directory/$img /root/share/tnp_svm/rectified_own_bgr/$directory/rectified_$img 4 10 60 0.97	
				cd /root/share/tnp_svm/own_bgr/$directory
			fi
		done
		cd /root/share/tnp_svm/own_bgr
	fi
done

cd /root/catkin_ws/src/tnp/tnp_svm/script

#### augment amazon 10items
python augmentation.py /root/share/tnp_svm rectified_amazon_bgr augmented_stow

#### augment own 10items
python augmentation.py /root/share/tnp_svm rectified_own_bgr augmented_stow

######## for Pick Task

### augment data from amazon 16items
# python augmentation.py /root/share/tnp_svm/ amazon_bgr augmented_pick

### augment own 16items
# python augmentation.py /root/share/tnp_svm own_bgr augmented_pick

