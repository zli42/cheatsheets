# Advertising

DSP: Demand-Side Platform，广告主需求方平台

SSP：Sell-Side Platform，流量供应方平台

ADX：ad exchange，广告交易平台，联系 DSP（买方）和 SSP（卖方），组织竞价，撮合交易

DMP：Data-Management Platform，数据管理平台，根据用户浏览记录进行数据分析，定位用户属性

RTB：RealTime Bidding，实时竞价

CPA：Cost Per Action，以 action 指标计费

CPM：按千次展示付费

CPS：广告是按佣金比例付费，按照广告点击之后产生的实际销售笔数付给广告站点销售提成费用

RTA：满足广告主个性化投放需求，有广告主选择是否竞价流量，以及个性化选择投放策略，满足拉新拉活的需求

## Uplift Model

| | 广告 CVR | 无广告 CVR | uplift |
| ---- | ---- | ---- | ---- |
| user1 | 0.8% | 0.2% | 0.6% |
| user2 | 2.0% | 1.7% | 0.3% |

虽然 user2 的 CVR 高，但是 user1 的增量大，即 user1 是广告敏感用户。

因果推断反事实：对于一个用户，不可能同时观察到在干预和未干预两种情况下的表现。

因此可以从平均因果做统计，对两组同质用户，一组做干预，乙组作对照，之后统计两组人群的转化差异，可以被近似认为是具备同样特征的人的平均因果效应。

uplift 建模需要满足用户特征 X 与是否营销 T 条件独立。

### two-model 差分响应

$uplift = G(Y_i|X_i, T=1) - G'(Y_i|X_i, T=0)$

用两个模型 G/G' 分别学习用户在有干预/无干预条件下的响应，然后两个模型之差即为 uplift。

该方法简单直观，但是因为是两个独立模型，容易累积误差，而且由于本质上还是两个 response 模型而不是 uplift，所以 uplift 能力有限。

### one-model 差分响应

$uplift = G(Y_i|X_i, T=1) - G(Y_i|X_i, T=0)$

通过在特征中引入是否干预 T，实现在数据和模型层面打通。

相比 two-model 训练样本共享，训练更加充分，避免双模型误差累积问题。但是，本质上依然是对 response 建模。

### 标签转换

$$
\begin{aligned}
uplift&=P(Y_i=1|X_i, T_i=1) -  P(Y_i=1|X_i, T_i=0) \\
&=\frac{P(Y_i=1, T_i=1|X_i)}{P(T_i=1|X_i)} - \frac{P(Y_i=1, T_i=0|X_i)}{P(T_i=0|X_i)} \\
\\
\because \ &条件独立 \\
\therefore \ &P(T_i=1|X_i)=P(T_i=0|X_i) \\
\\
uplift &\rightarrow 2[P(Y_i=1, T_i=1|X_i) - P(Y_i=1, T_i=0|X_i)] \\
&=(P(Y_i=1, T_i=1|X_i) + (1 - P(Y_i=0, T_i=1|X_i))) - (P(Y_i=1, T_i=0|X_i) + (1 - P(Y_i=0, T_i=0|X_i))) \\
&=(P(Y_i=1, T_i=1|X_i)+P(Y_i=0, T_i=0|X_i)) - (P(Y_i=0, T_i=1|X_i)+P(Y_i=1, T_i=0|X_i)) \\
\\
令\ &P(Z_i=1|X_i)=P(Y_i=1, T_i=1|X_i)+P(Y_i=0, T_i=0|X_i) \\
uplift &\rightarrow P(Z_i=1|X_i) - P(Z_i=0|X_i) \\
&= 2P(Z_i=1|X_i) - 1
\end{aligned}
$$

### AUUC 评估

将实验组和对照组分别通过模型打分，uplift 分数由高到低排序，并根据用户量十等分，计算每份：

$AUUC = (\frac{n_{t,y=1}}{n_t}-\frac{n_{c,y=1}}{n_c})(n_t+n_c)$

$n_c$ 和 $n_y$ 表示每份实验组和控制组用户数，$n_{t,y=1}$ 表示当前份实验组广告响应的数量。
