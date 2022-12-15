# Statistics

## 中心极限定理

从任何独立、同分布的总体（均值为 $\mu$，方差为 $\sigma^2$）中抽取样本容量为 $n$ 的样本，当 $n$ 足够大时，样本均值的抽样分布服从于均值为 $\mu$，方差为 $\sigma^2/n$ 的正态分布。

故当样本足够大，样本均值服从正态分布。

## T 显著性检验

T 检验是通过比较不同数据的均值，研究两组数据之间是否存在显著差异。

前提：

1. 独立
2. 近似正态分布
3. 有相似的方差

使用 A 方案人数 $N_a$，使用 B 方案人数 $N_b$。

由样本计算出，A 方案的 CTR 为 $\hat{P_a}$，B 方案的 CTR 为 $\hat{P_b}$。分别以 $\hat{P_a}$ 和 $\hat{P_b}$ 来估算 $P_a$ 和 $P_b$。用户点击服从期望为 $P$ 的二项分布，根据中心极限定理，当 A、B 方案样本足够大时，样本均值服从正态分布。

* 原假设：差异不显著 $H_0:X=P_b-P_a\le0$
* 备选假设：差异显著 $H_1:X=P_b-P_a\gt0$

由于总体方差未知，根据原假设构建 t 检验统计量：

$$t=\frac{(\hat{P_b}-\hat{P_a})-(P_b-P_a)}{\sqrt{\frac{\hat{P_b}(1-\hat{P_b})}{N_b}+\frac{\hat{P_a}(1-\hat{P_a})}{N_a}}}$$

根据原假设，仅需验证 $P_b-P_a=0$ 的情况即可。给定显著性水平 $\alpha$（一般 $\alpha=0.05$，即 95% 显著性），$自由度 = 样本数 - 1$，当 $t>t_{\alpha}$ 时，拒绝原假设，差异显著。

* 双侧：不确定是否有差异（更严格）
* 单侧：验证差异是否显著

双侧通过，单侧一定通过；若双侧不通过，单侧通过，则需加大样本量，继续观察。