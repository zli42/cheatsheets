# Deep Learning

## 评估指标

$ cos = \frac{x \cdot y}{|x|\cdot|y|} $

$ precision = \frac{TP}{TP + FP} $

$ recall = \frac{TP}{TP + FN} $

$ F1 = \frac{2PR}{p+r} $

AUC @TODO

## 优化策略

### Adam

* 优点：使用一阶动量和二阶动量，自适应学习率来加快收敛速度
* 缺点：后期学习率太低，影响收敛

## 激活函数

### sigmoid

$ \sigma(x) = \frac{1}{1 + e^{-x}} $

优点：
* 输出映射在 $ (0, 1) $ 之间，单调连续
* 容易求导

缺点：
* 落入饱和区梯度接近于 $0$，导致梯度消失
* 输出恒大于 $0$，使得后一层神经元的输入发生偏移，减缓梯度下降的收敛
* 计算中有幂运算，速度较慢

### tanh

$ tanh(x) = \frac{e^{x} - e^{-x}}{e^{x} + e^{-x}} $

优点：

* 输出以 $0$ 为中心，收敛速度快

缺点：

* 落入饱和区梯度接近于 $0$，导致梯度消失
* 计算中有幂运算，速度较慢

### ReLU

$ f(x) = \begin{cases}
0 & x \lt 0 \\
x & x \ge 0
\end{cases} $

优点：

* 计算见简单，收敛速度快
* 当 $ x \ge 0 $ 时，ReLU​ 的导数为常数，缓解梯度消失问题
* 当 $ x \lt 0 $ 时，ReLU​ 的梯度总是 $0$，提供了神经网络的稀疏表达能力

缺点：
* 输出不是以 0 为中心的
* 某些神经元可能永远不会被激活，导致相应参数永远不会被更新
* 不能避免梯度爆炸问题

### PReLU

$ f(x) = \begin{cases}
\alpha x & x \lt 0 \\
x & x \ge 0
\end{cases} $

优点：

* 自适应学习参数，收敛速度快
* 缓解梯度消失问题

缺点：
* 效果不一定比 ReLU 好
* 不能避免梯度爆炸问题

## 损失函数

$ softmax(x_i) = \frac{e^{x_i}}{\sum_{j=1}^k e^{x_j}} $

$ cross entropy = -y * \log{\hat{y}} $

## 正则化

* 数据增强
* L2 正则化（权重衰减）
* L1 正则化，稀疏，用于特征选择
* Dropout
* early stopping
