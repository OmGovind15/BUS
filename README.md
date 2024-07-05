# [CVPR 2024] Open Set Domain Adaptation for Semantic Segmentation

Official PyTorch implementation for CVPR 2024 paper:

**Open Set Domain Adaptation for Semantic Segmentation**  
Seun-An Choe*, Ah-Hyung Shin*, Keon-Hee Park, Jinwoo Choi<sup>$\dagger$</sup> , and Gyeong-Moon Park<sup>$\dagger$</sup> 

[![arXiv](https://img.shields.io/badge/arXiv-2405.19899-b31b1b.svg)](https://arxiv.org/abs/2405.19899) 

## How to run

### Setup Enviorment

We used python 3.8.5.

```shell
python -m venv ~/venv/bus
source ~/venv/bus/bin/activate
```

```shell
pip install -r requirements.txt -f https://download.pytorch.org/whl/torch_stable.html
pip install mmcv-full==1.3.7  # requires the other packages to be installed first
```

Download the MiT-B5 ImageNet weights provided by [SegFormer](https://github.com/NVlabs/SegFormer?tab=readme-ov-file#training)
from their [OneDrive](https://connecthkuhk-my.sharepoint.com/:f:/g/personal/xieenze_connect_hku_hk/EvOn3l1WyM5JpnMQFSEO5b8B7vrHw9kDaJGII-3N9KNhrg?e=cpydzZ) and put them in the folder `pretrained/`.

Download the MobileSAM weights folder provided by [MobileSAM](https://github.com/ChaoningZhang/MobileSAM)
from their [OneDrive](https://drive.google.com/file/d/1dE-YAG-1mFCBmao2rHDp0n-PP4eH7SjE/view?usp=sharing) and only 'mobile_sam.pt' put them in the folder `weights/`.


### Setup Datasets
Download the datasets from GTA5, SYNTHIA, Cityscapes
Download [GTA5](https://download.visinf.tu-darmstadt.de/data/from_games/), [SYNTHIA](http://synthia-dataset.net/downloads/) and [Cityscapes](https://www.cityscapes-dataset.com/).

The final folder structure should look like this:

```none
BUS
├── ...
├── data
│   ├── cityscapes
│   │   ├── leftImg8bit
│   │   │   ├── train
│   │   │   ├── val
│   │   ├── gtFine
│   │   │   ├── train
│   │   │   ├── val
│   ├── gta
│   │   ├── images
│   │   ├── labels
```
**Data Preprocessing:** Finally, please run the following scripts to convert the label IDs to the
train IDs and to generate the class index for OSDA-SS scenario:

```shell
python tools/convert_datasets/gta_13.py data/gta --nproc 8
python tools/convert_datasets/cityscapes_13.py data/cityscapes --nproc 8
```
The code above is what we used in the GTA5-->Cityscapes scenario when we set the six private classes to the following. 
"pole", "traffic sign", "person", "rider", "truck" and "train".

### Training
```shell
python run_experiments.py --config configs/mic/gtaHR2csHR_mic_hrda_512.py
```

### Testing
```shell
sh test.sh work_dirs/run_name/
```
Pretrained model for GTA5->Cityscapes can be downloaded at: (Link). The performance of this model is 62.81 based on the H-Score.

### Acknowledgement
This code is heavily borrowed from [MIC](https://github.com/lhoyer/MIC), [MobileSAM](https://github.com/ChaoningZhang/MobileSAM) and [DACS](https://github.com/vikolss/DACS).

