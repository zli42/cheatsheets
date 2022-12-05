# 推荐系统

## 数据预处理

统一处理为 tag_index:value 形式，每列都是多个键值对组成，且相同列不同行的键值对个数不一定相同。

* 数值特征：一般通过分桶处理为 id 特征
    1. log 处理，减弱长尾数据的影响
    2. min-max scaling，排除不同特征间 scale 的影响（不能做均值为 0 标准差为 1 的标准化，因为这样会破坏数据的稀疏性）
* 类别特征：剔除生僻的类别，建立字典，将原始数据中的自负床转化为整数 index（例如，`274:1.0`，274表示某类别）

## 用户画像

* 人口属性
* app list
* 行为统计
* 模型预估（准确率、覆盖率）

## 召回

双塔：

* item embedding：周期性根据 item 特征生成，输入 FAISS 建立索引
* user embedding：根据 user 特征在线生成

因此，在训练、预测时不能使用 user-item 交叉特征。

线上召回时，拿 user embedding 去 FAISS 里进行 top-k 近邻搜索，找到与其最接受的 item embedding

### 样本

* 正样本：曝光点击，排除误点、自动播放，热门打压
* 负样本：在 item 库中随机负采样，且未点击，热门增强

pairewise: <user, item+, item->

### 特征

* 用户侧：长/短期画像，点击/收藏/购买历史
* 物品侧：画像，ctr 等后验指标，类别

### Loss

hinge loss

BPR loss

### 评估方法

召回率

每一路召回的占比和 CTR

多路召回去重，按照顺序取最后的召回策略

顺序：热门 -> 标签 -> CF -> item2vec -> DSSM

* 热门
* 地理位置
* 类别/tag
* itemCF / userCF
* u2i
* i2i
* u2u2i
* i2u2i


### DSSM

#### 输入层

分词，考虑向量空间，采用单字分词 one-hot 作为输入

#### 表示层

BOW 词袋方式，不考虑词位置信息，后接 DNN，tanh 作为激活函数

#### 匹配层

使用 cosine 相似度

### item2vec

### YouTube DNN

![](./src/youtube_dnn.png)

## 排序

### 样本

* 正样本：曝光点击，播放时长筛选，过滤掉用户误点和自动播放
* 负样本：曝光未点击，用户点击 item 以上未点击的 item 做负样本

### 特征

* 用户侧：长/短期画像，点击/收藏/购买历史
* 物品侧：画像，ctr 等后验指标，类别
* 交叉特征

DeepFM

FM 对特征进行二阶交叉，同时引入隐向量（矩阵分解），解决稀疏性问题
DNN 提供告诫特征抽取
共享输入向量

## 指标

### precision / recall

### AUC

### LogLoss

$ LogLoss = - \frac{1}{N} \sum_{i=1}^{N} (y_i \log{P_i} + (1 - y_i) \log{(1 - P_i)}) $

* CTR（pv/uv）
* CVR
* 人均点击次数
* 留存率
* 停留时长
* 完播率

## 重排

冷启动 探索利用


Wide&Deep为什么用了两个优化器分别优化Wide侧和Deep侧？
Wide侧的优化器使用带L1正则化项的FTRL，Deep侧的优化器是AdaGrad。采用 L1 FTRL是想让Wide部分变得更加稀疏，而Deep部分的稀疏向量已经embedding化，所以不用考虑特征稀疏问题。



2 DSSM中的负样本为什么是随机采样得到的，而不用“曝光未点击”当负样本？
仅使用“曝光未点击”当作负样本，会造成训练数据和预测数据不一致的bias。在



3 DNN中加入position bias为什么不能和其他特征一样喂入DNN底层，而必须通过一个浅层网络接入？
我们希望DNN专注于学习user对不同item的偏好，所以bias要交给单独的网络去学，在最后一层融合就好，还有user bias，item bias，都是一样的道理

## 冷启动

