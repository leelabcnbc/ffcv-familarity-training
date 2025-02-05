# 8 GPU training (use only 1 for ResNet-18 training)
export CUDA_VISIBLE_DEVICES=1,2;

# name="vit-b-configs/vit_b_32_32_epochs_1_gpu_varyingsize_0_base_0";
# name="alexnet_configs/alexnet_5layers_32_epochs_test_finetune_alex";
name="alexnet_configs/alexnet_5layers_32_epochs_test_finetune_alex_2layer";
# name="vit-b-configs/vit_b_16_epochs_dist_gpu_varyingsize_0_topk_1";
# name="vit-b-configs/vit_b_16_epochs_1_gpu_varyingsize_0_topk_1";
# name="vit-b-configs/vit_b_16_epochs_1_gpu_varyingsize_1";
# name="vit-b-configs/vit_b_16_epochs_1_gpu_varyingsize_0";
# name="vit-b-configs/vit_b_24_epochs_1_gpu_varyingsize_0";
# name="vit-b-configs/vit_b_24_epochs_1_gpu_0";
# name="rn50_configs/rn50_24_epochs_1_gpu_0";
echo "running "$name;

echo "running layer topk";
# Set the visible GPUs according to the `world_size` configuration parameter
# Modify `data.in_memory` and `data.num_workers` based on your machine
python ../../train.py --config-file ../../$name.yaml \
    --data.train_dataset=/home/ylz1122/data/ffcv-imagenet/train_500_0.50_90.ffcv \
    --data.val_dataset=/home/ylz1122/data/ffcv-imagenet/val_500_0.50_90.ffcv \
    --data.num_workers=20 --data.in_memory=1 \
    --logging.folder=./train_results/$name-original \
    --dist.port 12321 \

# echo "running topk";
# topk='333366667777';
# # # Set the visible GPUs according to the `world_size` configuration parameter
# # # Modify `data.in_memory` and `data.num_workers` based on your machine
# python ../../train.py --config-file ../../$name.yaml \
#     --data.train_dataset=/workspace/data/train_500_0.50_90.ffcv \
#     --data.val_dataset=/workspace/data/val_500_0.50_90.ffcv \
#     --data.num_workers=12 --data.in_memory=1 \
#     --logging.folder=./train_results/$name\_topk\_$topk \
#     --dist.port 12320 \
#     --training.topk_info "$topk" \